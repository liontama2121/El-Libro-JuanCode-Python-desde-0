import { and, eq, sql } from "drizzle-orm";
import { type Db, schema } from "~/db";
import type { Dificultad, UserStats } from "~/db/schema";
import { hoyISO } from "./bank.server";

/* -------------------------------------------------------------------------- */
/*  Niveles                                                                    */
/* -------------------------------------------------------------------------- */

export const NIVELES = [
	{ nivel: 0, desde: 0, nombre: "Novato", emoji: "🌱" },
	{ nivel: 1, desde: 300, nombre: "Aprendiz", emoji: "📦" },
	{ nivel: 2, desde: 800, nombre: "Programador", emoji: "💻" },
	{ nivel: 3, desde: 1500, nombre: "Hacker", emoji: "🧠" },
	{ nivel: 4, desde: 3000, nombre: "Maestro JuanCode", emoji: "🏆" },
] as const;

export type Nivel = (typeof NIVELES)[number];

export function nivelDe(xp: number) {
	let actual: Nivel = NIVELES[0];
	for (const n of NIVELES) if (xp >= n.desde) actual = n;
	const siguiente = NIVELES.find((n) => n.desde > xp) ?? null;

	const base = actual.desde;
	const techo = siguiente?.desde ?? actual.desde;
	const progreso = siguiente ? Math.round(((xp - base) / (techo - base)) * 100) : 100;

	return { actual, siguiente, progreso, faltan: siguiente ? siguiente.desde - xp : 0 };
}

/* -------------------------------------------------------------------------- */
/*  XP                                                                         */
/* -------------------------------------------------------------------------- */

/** Puntos base del arcade según la dificultad de la pregunta. */
export const XP_ARCADE: Record<Dificultad, number> = {
	facil: 10,
	medio: 20,
	dificil: 30,
};

export const XP_QUIZ_CAPITULO = 100;
export const XP_POR_CORRECTA_SIMULACRO = 5;
export const XP_DIA_ACTIVO = 25;

/** A partir de esta racha de aciertos seguidos, cada acierto vale 50% más. */
export const RACHA_BONUS = 5;

/**
 * XP de una tanda del arcade. La racha se recorre en orden: cada acierto la
 * sube, cada fallo la deja en cero, y desde el quinto acierto seguido el
 * bonus del 50% se aplica.
 */
export function xpDeArcade(
	respuestas: { dificultad: Dificultad; acerto: boolean }[],
): { xp: number; mejorRacha: number } {
	let xp = 0;
	let racha = 0;
	let mejorRacha = 0;

	for (const r of respuestas) {
		if (!r.acerto) {
			racha = 0;
			continue;
		}
		racha += 1;
		mejorRacha = Math.max(mejorRacha, racha);
		const base = XP_ARCADE[r.dificultad] ?? XP_ARCADE.facil;
		xp += racha >= RACHA_BONUS ? Math.round(base * 1.5) : base;
	}

	return { xp, mejorRacha };
}

/* -------------------------------------------------------------------------- */
/*  Insignias                                                                  */
/* -------------------------------------------------------------------------- */

export const INSIGNIAS = [
	{ id: "primer_capitulo", emoji: "🌱", nombre: "Primer capítulo", texto: "Aprobaste tu primer quiz de capítulo." },
	{ id: "cinco_capitulos", emoji: "🖐️", nombre: "Cinco capítulos", texto: "Cinco capítulos aprobados." },
	{ id: "medio_libro", emoji: "📖", nombre: "Medio libro", texto: "Doce capítulos aprobados." },
	{ id: "libro_completo", emoji: "🏁", nombre: "Libro completo", texto: "Los 24 capítulos aprobados." },
	{ id: "racha_7", emoji: "🔥", nombre: "Racha de 7 días", texto: "Siete días seguidos practicando." },
	{ id: "simulacro_perfecto", emoji: "💯", nombre: "Simulacro perfecto", texto: "100% en un simulacro de quiz." },
	{ id: "cazador_bugs", emoji: "🕵️", nombre: "Cazador de bugs", texto: "20 bugs encontrados." },
	{ id: "arquitecto", emoji: "🧩", nombre: "Arquitecto", texto: "20 rompecabezas armados." },
	{ id: "relampago", emoji: "⚡", nombre: "Relámpago", texto: "10 aciertos seguidos en modo relámpago." },
] as const;

export type IdInsignia = (typeof INSIGNIAS)[number]["id"];

type Bolsa = {
	ganadas: string[];
	contadores: Record<string, number>;
};

function leerBolsa(json: string): Bolsa {
	try {
		const b = JSON.parse(json);
		return {
			ganadas: Array.isArray(b?.ganadas) ? b.ganadas : [],
			contadores: typeof b?.contadores === "object" && b.contadores ? b.contadores : {},
		};
	} catch {
		return { ganadas: [], contadores: {} };
	}
}

/* -------------------------------------------------------------------------- */
/*  Estado del estudiante                                                      */
/* -------------------------------------------------------------------------- */

export async function cargarStats(db: Db, userId: string): Promise<UserStats> {
	const [fila] = await db
		.select()
		.from(schema.userStats)
		.where(eq(schema.userStats.userId, userId))
		.limit(1);

	if (fila) return fila;

	const nuevo = {
		userId,
		xp: 0,
		level: 0,
		streakDays: 0,
		bestStreak: 0,
		lastActivityDate: null,
		badgesJson: JSON.stringify({ ganadas: [], contadores: {} }),
		updatedAt: new Date(),
	};
	await db.insert(schema.userStats).values(nuevo).onConflictDoNothing();
	return nuevo as UserStats;
}

export type Otorgado = {
	xp: number;
	xpTotal: number;
	nivelSubio: boolean;
	nivel: ReturnType<typeof nivelDe>;
	streakDays: number;
	nuevasInsignias: (typeof INSIGNIAS)[number][];
};

/**
 * Suma XP, actualiza la racha diaria y revisa las insignias.
 * Es el ÚNICO sitio donde se escribe `user_stats`.
 */
export async function otorgar(
	db: Db,
	userId: string,
	{
		xp = 0,
		contadores = {},
		candidatas = [],
	}: {
		xp?: number;
		/** Suma a los contadores acumulados: { find_bug: 3, parsons: 1 } */
		contadores?: Record<string, number>;
		/** Insignias que este evento podría desbloquear */
		candidatas?: IdInsignia[];
	},
): Promise<Otorgado> {
	const previo = await cargarStats(db, userId);
	const bolsa = leerBolsa(previo.badgesJson);
	const hoy = hoyISO();

	/* Racha diaria: si se saltó un día, vuelve a empezar. */
	let streakDays = previo.streakDays;
	let xpTotalEvento = xp;

	if (previo.lastActivityDate !== hoy) {
		const ayer = new Date();
		ayer.setUTCDate(ayer.getUTCDate() - 1);
		const fueAyer = previo.lastActivityDate === ayer.toISOString().slice(0, 10);
		streakDays = fueAyer ? previo.streakDays + 1 : 1;
		xpTotalEvento += XP_DIA_ACTIVO; // primer rato del día
	}

	for (const [clave, suma] of Object.entries(contadores)) {
		bolsa.contadores[clave] = (bolsa.contadores[clave] ?? 0) + suma;
	}

	const xpNuevo = Math.max(0, previo.xp + xpTotalEvento);
	const nivelAntes = nivelDe(previo.xp);
	const nivelAhora = nivelDe(xpNuevo);

	/* Insignias que dependen del propio user_stats */
	const porGanar = new Set<string>(candidatas);
	if (streakDays >= 7) porGanar.add("racha_7");
	if ((bolsa.contadores.find_bug ?? 0) >= 20) porGanar.add("cazador_bugs");
	if ((bolsa.contadores.parsons ?? 0) >= 20) porGanar.add("arquitecto");

	const nuevas = [...porGanar].filter((id) => !bolsa.ganadas.includes(id));
	bolsa.ganadas.push(...nuevas);

	const bestStreak = Math.max(previo.bestStreak, streakDays);

	await db
		.update(schema.userStats)
		.set({
			xp: xpNuevo,
			level: nivelAhora.actual.nivel,
			streakDays,
			bestStreak,
			lastActivityDate: hoy,
			badgesJson: JSON.stringify(bolsa),
			updatedAt: new Date(),
		})
		.where(eq(schema.userStats.userId, userId));

	return {
		xp: xpTotalEvento,
		xpTotal: xpNuevo,
		nivelSubio: nivelAhora.actual.nivel > nivelAntes.actual.nivel,
		nivel: nivelAhora,
		streakDays,
		nuevasInsignias: INSIGNIAS.filter((i) => nuevas.includes(i.id)),
	};
}

/* -------------------------------------------------------------------------- */
/*  Insignias por capítulos aprobados                                          */
/* -------------------------------------------------------------------------- */

/** Cuántos capítulos distintos tiene aprobados el estudiante. */
export async function capitulosAprobados(db: Db, userId: string) {
	const filas = await db
		.selectDistinct({ chapterId: schema.quizzes.chapterId })
		.from(schema.quizAttempts)
		.innerJoin(schema.quizzes, eq(schema.quizzes.id, schema.quizAttempts.quizId))
		.where(
			and(eq(schema.quizAttempts.userId, userId), eq(schema.quizAttempts.passed, true)),
		);
	return filas.length;
}

export function insigniasPorCapitulos(cuantos: number): IdInsignia[] {
	const ids: IdInsignia[] = [];
	if (cuantos >= 1) ids.push("primer_capitulo");
	if (cuantos >= 5) ids.push("cinco_capitulos");
	if (cuantos >= 12) ids.push("medio_libro");
	if (cuantos >= 24) ids.push("libro_completo");
	return ids;
}

/** Estado de las insignias para pintarlas (ganadas y bloqueadas). */
export function listarInsignias(badgesJson: string) {
	const bolsa = leerBolsa(badgesJson);
	return INSIGNIAS.map((i) => ({
		...i,
		ganada: bolsa.ganadas.includes(i.id),
	}));
}

export function contadoresDe(badgesJson: string) {
	return leerBolsa(badgesJson).contadores;
}

/* -------------------------------------------------------------------------- */
/*  Ajustes                                                                    */
/* -------------------------------------------------------------------------- */

export const CLAVE_RANKING = "ranking_visible";

export async function rankingVisible(db: Db) {
	const [fila] = await db
		.select()
		.from(schema.settings)
		.where(eq(schema.settings.key, CLAVE_RANKING))
		.limit(1);
	// Por defecto se ve.
	return fila ? fila.value === "1" : true;
}

export async function fijarRanking(db: Db, visible: boolean) {
	await db
		.insert(schema.settings)
		.values({ key: CLAVE_RANKING, value: visible ? "1" : "0" })
		.onConflictDoUpdate({
			target: schema.settings.key,
			set: { value: visible ? "1" : "0" },
		});
}

/* -------------------------------------------------------------------------- */
/*  Actividad de los últimos 30 días (gráfica del perfil)                      */
/* -------------------------------------------------------------------------- */

export async function actividad30Dias(db: Db, userId: string) {
	const desde = new Date();
	desde.setUTCDate(desde.getUTCDate() - 29);
	const corte = desde.getTime();

	const practicas = await db
		.select({
			dia: sql<string>`date(${schema.practiceAttempts.createdAt} / 1000, 'unixepoch')`,
			n: sql<number>`count(*)`,
		})
		.from(schema.practiceAttempts)
		.where(
			and(
				eq(schema.practiceAttempts.userId, userId),
				sql`${schema.practiceAttempts.createdAt} >= ${corte}`,
			),
		)
		.groupBy(sql`1`);

	const quizzes = await db
		.select({
			dia: sql<string>`date(${schema.quizAttempts.createdAt} / 1000, 'unixepoch')`,
			n: sql<number>`count(*)`,
		})
		.from(schema.quizAttempts)
		.where(
			and(
				eq(schema.quizAttempts.userId, userId),
				sql`${schema.quizAttempts.createdAt} >= ${corte}`,
			),
		)
		.groupBy(sql`1`);

	const porDia = new Map<string, number>();
	for (const f of [...practicas, ...quizzes]) {
		porDia.set(f.dia, (porDia.get(f.dia) ?? 0) + Number(f.n));
	}

	return Array.from({ length: 30 }, (_, i) => {
		const d = new Date(desde);
		d.setUTCDate(desde.getUTCDate() + i);
		const iso = d.toISOString().slice(0, 10);
		return { dia: iso, n: porDia.get(iso) ?? 0 };
	});
}
