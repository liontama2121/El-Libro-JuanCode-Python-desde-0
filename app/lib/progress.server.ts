import { and, asc, desc, eq, inArray } from "drizzle-orm";
import { type Db, schema } from "~/db";
import type { Chapter, Part } from "~/db/schema";

export type EstadoCapitulo = "completado" | "disponible" | "bloqueado";

export type CapituloConEstado = Chapter & {
	estado: EstadoCapitulo;
	tieneQuiz: boolean;
};

export type ParteConCapitulos = Part & { capitulos: CapituloConEstado[] };

/** Progreso de un estudiante: qué tiene desbloqueado y qué quizzes aprobó. */
export async function cargarProgreso(db: Db, userId: string) {
	const [desbloqueados, aprobados] = await Promise.all([
		db
			.select({ chapterId: schema.unlocks.chapterId })
			.from(schema.unlocks)
			.where(eq(schema.unlocks.userId, userId)),
		db
			.select({ chapterId: schema.quizzes.chapterId })
			.from(schema.quizAttempts)
			.innerJoin(
				schema.quizzes,
				eq(schema.quizzes.id, schema.quizAttempts.quizId),
			)
			.where(
				and(
					eq(schema.quizAttempts.userId, userId),
					eq(schema.quizAttempts.passed, true),
				),
			),
	]);

	return {
		unlocked: new Set(desbloqueados.map((u) => u.chapterId)),
		passed: new Set(aprobados.map((a) => a.chapterId)),
	};
}

export type Progreso = Awaited<ReturnType<typeof cargarProgreso>>;

/**
 * REGLA: el capítulo 1 siempre está abierto. Los demás necesitan un unlock
 * (que nace al aprobar el quiz anterior o porque el profe lo abrió a mano).
 * El profe ve todo abierto.
 */
export function estadoDeCapitulo(
	capitulo: Chapter,
	progreso: Progreso,
	esProfesor: boolean,
): EstadoCapitulo {
	if (progreso.passed.has(capitulo.id)) return "completado";
	if (esProfesor) return "disponible";
	if (capitulo.number === 1) return "disponible";
	return progreso.unlocked.has(capitulo.id) ? "disponible" : "bloqueado";
}

/** Índice completo del libro agrupado por partes, con el estado de cada capítulo. */
export async function cargarLibro(
	db: Db,
	userId: string,
	esProfesor: boolean,
): Promise<{ partes: ParteConCapitulos[]; capitulos: CapituloConEstado[] }> {
	const progreso = await cargarProgreso(db, userId);

	const partes = await db
		.select()
		.from(schema.parts)
		.orderBy(asc(schema.parts.number));

	const filas = esProfesor
		? await db.select().from(schema.chapters).orderBy(asc(schema.chapters.number))
		: await db
				.select()
				.from(schema.chapters)
				.where(eq(schema.chapters.published, true))
				.orderBy(asc(schema.chapters.number));

	const conQuiz = filas.length
		? new Set(
				(
					await db
						.select({ chapterId: schema.quizzes.chapterId })
						.from(schema.quizzes)
						.where(
							inArray(
								schema.quizzes.chapterId,
								filas.map((c) => c.id),
							),
						)
				).map((q) => q.chapterId),
			)
		: new Set<number>();

	const capitulos: CapituloConEstado[] = filas.map((c) => ({
		...c,
		estado: estadoDeCapitulo(c, progreso, esProfesor),
		tieneQuiz: conQuiz.has(c.id),
	}));

	return {
		partes: partes.map((p) => ({
			...p,
			capitulos: capitulos.filter((c) => c.partId === p.id),
		})),
		capitulos,
	};
}

/** Crea el desbloqueo si no existe (único por user+capítulo). */
export async function otorgarDesbloqueo(
	db: Db,
	userId: string,
	chapterId: number,
	source: "quiz" | "teacher",
) {
	await db
		.insert(schema.unlocks)
		.values({ userId, chapterId, source })
		.onConflictDoNothing();
}

export async function quitarDesbloqueo(
	db: Db,
	userId: string,
	chapterId: number,
) {
	await db
		.delete(schema.unlocks)
		.where(
			and(eq(schema.unlocks.userId, userId), eq(schema.unlocks.chapterId, chapterId)),
		);
}

/** Último intento de quiz de un estudiante (para el dashboard del profe). */
export async function ultimoIntento(db: Db, userId: string) {
	const [fila] = await db
		.select({
			score: schema.quizAttempts.score,
			passed: schema.quizAttempts.passed,
			createdAt: schema.quizAttempts.createdAt,
			chapterNumber: schema.chapters.number,
			chapterTitle: schema.chapters.title,
		})
		.from(schema.quizAttempts)
		.innerJoin(schema.quizzes, eq(schema.quizzes.id, schema.quizAttempts.quizId))
		.innerJoin(schema.chapters, eq(schema.chapters.id, schema.quizzes.chapterId))
		.where(eq(schema.quizAttempts.userId, userId))
		.orderBy(desc(schema.quizAttempts.createdAt))
		.limit(1);

	return fila ?? null;
}
