import { and, desc, eq, gte, inArray } from "drizzle-orm";
import { useCallback, useEffect, useRef, useState } from "react";
import { Link, redirect, useFetcher } from "react-router";
import { Nav } from "~/components/nav";
import { Pregunta, type CorreccionUI } from "~/components/pregunta";
import { BarraProgreso, Confetti, Toast, ToastInsignias } from "~/components/ui";
import { getDb, schema } from "~/db";
import type { Dificultad } from "~/db/schema";
import { requireUser } from "~/lib/auth.server";
import { MODOS } from "~/lib/arcade";
import {
	aPublica,
	calificar,
	elegirPreguntas,
	semillaDelDia,
	type PreguntaPublica,
	type Respuesta,
} from "~/lib/bank.server";
import { formatoReloj } from "~/lib/format";
import { otorgar, xpDeArcade } from "~/lib/gamification.server";
import { cargarCapitulosVisibles } from "~/lib/progress.server";
import { firmar, verificar } from "~/lib/sign.server";
import type { Route } from "./+types/practica.arcade.modo";

export const meta: Route.MetaFunction = ({ data }) => [
	{ title: data ? `${data.modo.nombre} — Arcade` : "Arcade — El Libro JuanCode" },
];

type Sobre = { slug: string; ids: number[] };

/* -------------------------------------------------------------------------- */
/*  LOADER                                                                     */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const modo = MODOS[params.modo ?? ""];
	if (!modo) throw redirect("/practica/arcade");

	const capitulos = await cargarCapitulosVisibles(
		db,
		user.id,
		user.role === "teacher",
		user.track,
	);
	const chapterIds = capitulos
		.filter((c) => c.estado !== "bloqueado")
		.map((c) => c.id);

	/* El reto del día: un intento diario y tabla de posiciones ------------- */
	if (modo.slug === "reto") {
		const inicioDelDia = new Date();
		inicioDelDia.setUTCHours(0, 0, 0, 0);

		const [yaJugo] = await db
			.select({
				id: schema.practiceAttempts.id,
				score: schema.practiceAttempts.score,
				total: schema.practiceAttempts.total,
			})
			.from(schema.practiceAttempts)
			.where(
				and(
					eq(schema.practiceAttempts.userId, user.id),
					eq(schema.practiceAttempts.mode, "reto_dia"),
					gte(schema.practiceAttempts.createdAt, inicioDelDia),
				),
			)
			.limit(1);

		if (yaJugo) {
			return {
				user,
				modo,
				estado: "hecho" as const,
				miScore: yaJugo.score,
				miTotal: yaJugo.total,
				tabla: await tablaDelDia(db, inicioDelDia),
			};
		}
	}

	// El reto es igual para todo el curso: la semilla es la fecha.
	const elegidas = await elegirPreguntas(db, {
		chapterIds,
		tipos: modo.tipos.length ? modo.tipos : undefined,
		limite: modo.limite,
		semilla: modo.slug === "reto" ? semillaDelDia() : undefined,
	});

	if (elegidas.length === 0) {
		throw redirect(
			`/practica/arcade?toast=${encodeURIComponent(
				"Ese modo todavía no tiene preguntas 🙃",
			)}`,
		);
	}

	const semilla = modo.slug === "reto" ? semillaDelDia() : Date.now() % 100000;

	return {
		user,
		modo,
		estado: "jugando" as const,
		preguntas: elegidas.map((q) => aPublica(q, semilla)),
		token: await firmar(env, { slug: modo.slug, ids: elegidas.map((q) => q.id) } satisfies Sobre),
	};
}

async function tablaDelDia(db: ReturnType<typeof getDb>, desde: Date) {
	return db
		.select({
			userId: schema.practiceAttempts.userId,
			nombre: schema.users.name,
			score: schema.practiceAttempts.score,
			total: schema.practiceAttempts.total,
			segundos: schema.practiceAttempts.durationSeconds,
		})
		.from(schema.practiceAttempts)
		.innerJoin(schema.users, eq(schema.users.id, schema.practiceAttempts.userId))
		.where(
			and(
				eq(schema.practiceAttempts.mode, "reto_dia"),
				gte(schema.practiceAttempts.createdAt, desde),
			),
		)
		.orderBy(desc(schema.practiceAttempts.score), schema.practiceAttempts.durationSeconds)
		.limit(20);
}

/* -------------------------------------------------------------------------- */
/*  ACTION — corrige y (al terminar) reparte la XP                            */
/* -------------------------------------------------------------------------- */

export type RespuestaCorregida = CorreccionUI & { questionId: number };

export type CierreArcade = {
	terminado: true;
	aciertos: number;
	total: number;
	xp: number;
	mejorRacha: number;
	nivelSubio: boolean;
	nivel: string;
	insignias: { emoji: string; nombre: string; texto: string }[];
};

export async function action({ context, request, params }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const modo = MODOS[params.modo ?? ""];
	if (!modo) throw new Response("Modo desconocido", { status: 404 });

	const form = await request.formData();
	const sobre = await verificar<Sobre>(env, String(form.get("token") || ""));
	if (!sobre || sobre.slug !== modo.slug) {
		throw new Response("Firma inválida", { status: 400 });
	}

	const intent = String(form.get("intent") || "responder");

	/* Corregir UNA pregunta (feedback inmediato, sin XP) -------------------- */
	if (intent === "responder") {
		const questionId = Number(form.get("questionId"));
		if (!sobre.ids.includes(questionId)) {
			throw new Response("Pregunta fuera de la tanda", { status: 400 });
		}

		let respuesta: Respuesta = null;
		try {
			respuesta = JSON.parse(String(form.get("respuesta") || "null"));
		} catch {
			respuesta = null;
		}

		const [q] = await db
			.select()
			.from(schema.questionBank)
			.where(eq(schema.questionBank.id, questionId))
			.limit(1);
		if (!q) throw new Response("Pregunta no encontrada", { status: 404 });

		const correccion: RespuestaCorregida = { questionId, ...calificar(q, respuesta) };
		return correccion;
	}

	/* Terminar: se vuelve a calificar TODO aquí y recién ahí se paga la XP -- */
	let enviadas: Record<string, Respuesta> = {};
	try {
		enviadas = JSON.parse(String(form.get("respuestas") || "{}"));
	} catch {
		enviadas = {};
	}
	const segundos = Math.max(0, Number(form.get("segundos")) || 0);

	// Solo cuentan las preguntas de esta tanda, y una sola vez cada una.
	const respondidas = sobre.ids.filter((id) => enviadas[String(id)] !== undefined);
	const preguntas = respondidas.length
		? await db
				.select()
				.from(schema.questionBank)
				.where(inArray(schema.questionBank.id, respondidas))
		: [];

	const detalle = respondidas.flatMap((id) => {
		const q = preguntas.find((p) => p.id === id);
		if (!q) return [];
		const { acerto } = calificar(q, enviadas[String(id)] ?? null);
		return [
			{
				questionId: id,
				tipo: q.type,
				dificultad: q.difficulty as Dificultad,
				acerto,
			},
		];
	});

	const aciertos = detalle.filter((d) => d.acerto).length;
	const { xp, mejorRacha } = xpDeArcade(
		detalle.map((d) => ({ dificultad: d.dificultad, acerto: d.acerto })),
	);

	// Contadores para las insignias de Cazador de bugs y Arquitecto
	const contadores: Record<string, number> = {};
	for (const d of detalle) {
		if (!d.acerto) continue;
		if (d.tipo === "find_bug") contadores.find_bug = (contadores.find_bug ?? 0) + 1;
		if (d.tipo === "parsons") contadores.parsons = (contadores.parsons ?? 0) + 1;
	}

	const candidatas =
		modo.slug === "relampago" && mejorRacha >= 10 ? (["relampago"] as const) : [];

	const premio = await otorgar(db, user.id, {
		xp,
		contadores,
		candidatas: [...candidatas],
	});

	await db.insert(schema.practiceAttempts).values({
		userId: user.id,
		mode: modo.mode,
		configJson: JSON.stringify({ slug: modo.slug }),
		score: aciertos,
		total: detalle.length,
		xpEarned: premio.xp,
		durationSeconds: segundos,
		detailJson: JSON.stringify({ mejorRacha, detalle }),
	});

	const cierre: CierreArcade = {
		terminado: true,
		aciertos,
		total: detalle.length,
		xp: premio.xp,
		mejorRacha,
		nivelSubio: premio.nivelSubio,
		nivel: `${premio.nivel.actual.emoji} ${premio.nivel.actual.nombre}`,
		insignias: premio.nuevasInsignias.map((i) => ({
			emoji: i.emoji,
			nombre: i.nombre,
			texto: i.texto,
		})),
	};
	return cierre;
}

/* -------------------------------------------------------------------------- */
/*  Sonidos (sin archivos: dos pitidos con WebAudio)                           */
/* -------------------------------------------------------------------------- */

function useSonido() {
	const [activo, setActivo] = useState(true);
	const ctxRef = useRef<AudioContext | null>(null);

	useEffect(() => {
		try {
			setActivo(localStorage.getItem("jc-sonido") !== "0");
		} catch {
			/* modo privado: se queda en true */
		}
	}, []);

	const alternar = () =>
		setActivo((v) => {
			const siguiente = !v;
			try {
				localStorage.setItem("jc-sonido", siguiente ? "1" : "0");
			} catch {
				/* da igual */
			}
			return siguiente;
		});

	const sonar = useCallback(
		(tipo: "bien" | "mal") => {
			if (!activo) return;
			try {
				const Ctx = window.AudioContext ?? (window as unknown as { webkitAudioContext: typeof AudioContext }).webkitAudioContext;
				const ctx = (ctxRef.current ??= new Ctx());
				const osc = ctx.createOscillator();
				const gain = ctx.createGain();
				osc.type = "sine";
				osc.frequency.value = tipo === "bien" ? 880 : 200;
				gain.gain.setValueAtTime(0.08, ctx.currentTime);
				gain.gain.exponentialRampToValueAtTime(0.0001, ctx.currentTime + 0.22);
				osc.connect(gain).connect(ctx.destination);
				osc.start();
				osc.stop(ctx.currentTime + 0.22);
			} catch {
				/* si el navegador no deja sonar, no pasa nada */
			}
		},
		[activo],
	);

	return { activo, alternar, sonar };
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function ArcadeModo({ loaderData }: Route.ComponentProps) {
	if (loaderData.estado === "hecho") return <RetoHecho loaderData={loaderData} />;
	return <Juego loaderData={loaderData} />;
}

type DatosHecho = Extract<Route.ComponentProps["loaderData"], { estado: "hecho" }>;
type DatosJuego = Extract<Route.ComponentProps["loaderData"], { estado: "jugando" }>;

function RetoHecho({ loaderData }: { loaderData: DatosHecho }) {
	const { user, miScore, miTotal, tabla } = loaderData;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-2xl px-4 py-10 sm:px-5">
				<Link
					to="/practica/arcade"
					className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
				>
					← arcade
				</Link>

				<h1 className="jc-display jc-grad mt-4 text-3xl">🗓️ Reto del día</h1>
				<p className="mt-3 text-[var(--color-tinta-2)]">
					Ya lo jugaste hoy: {miScore} de {miTotal}. Mañana hay uno nuevo.
				</p>

				<h2 className="jc-display mt-10 text-2xl">Tabla de hoy</h2>
				<ol className="mt-5 space-y-2">
					{tabla.map((f, i) => (
						<li
							key={f.userId}
							className={`flex items-center gap-3 rounded-xl border px-4 py-3 ${
								f.userId === user.id
									? "border-[rgba(0,229,255,.5)] bg-[rgba(0,229,255,.08)]"
									: "border-[var(--color-borde)] bg-white/[0.03]"
							}`}
						>
							<span className="jc-mono w-7 text-center text-sm text-[var(--color-tinta-2)]">
								{i === 0 ? "🥇" : i === 1 ? "🥈" : i === 2 ? "🥉" : i + 1}
							</span>
							<span className="flex-1 truncate">{f.nombre}</span>
							<span className="jc-mono text-sm">
								{f.score}/{f.total}
							</span>
							<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
								{formatoReloj(f.segundos)}
							</span>
						</li>
					))}
					{tabla.length === 0 && (
						<li className="text-sm text-[var(--color-tinta-2)]">
							Todavía nadie ha jugado hoy.
						</li>
					)}
				</ol>
			</main>
		</>
	);
}

function Juego({ loaderData }: { loaderData: DatosJuego }) {
	const { user, modo, preguntas, token } = loaderData;
	const fetcher = useFetcher<typeof action>();
	const { activo: sonidoActivo, alternar, sonar } = useSonido();

	const [indice, setIndice] = useState(0);
	const [respuesta, setRespuesta] = useState<Respuesta>(null);
	const [respuestas, setRespuestas] = useState<Record<number, Respuesta>>({});
	const [correccion, setCorreccion] = useState<CorreccionUI | null>(null);
	const [racha, setRacha] = useState(0);
	const [mejorRacha, setMejorRacha] = useState(0);
	const [aciertos, setAciertos] = useState(0);
	const [vidas, setVidas] = useState(modo.vidas);
	const [restante, setRestante] = useState(modo.segundos);
	const [transcurrido, setTranscurrido] = useState(0);
	const [cierre, setCierre] = useState<CierreArcade | null>(null);
	const [temblor, setTemblor] = useState(false);

	const pregunta = preguntas[indice];
	const enviando = fetcher.state !== "idle";
	const cerradoRef = useRef(false);

	const terminar = useCallback(
		(mapa: Record<number, Respuesta>, segundos: number) => {
			if (cerradoRef.current) return;
			cerradoRef.current = true;
			fetcher.submit(
				{
					intent: "terminar",
					token,
					respuestas: JSON.stringify(mapa),
					segundos: String(segundos),
				},
				{ method: "post" },
			);
		},
		[fetcher, token],
	);

	/* Cronómetro (solo Relámpago) */
	useEffect(() => {
		const id = setInterval(() => {
			setTranscurrido((t) => t + 1);
			if (modo.segundos) setRestante((r) => Math.max(0, r - 1));
		}, 1000);
		return () => clearInterval(id);
	}, [modo.segundos]);

	useEffect(() => {
		if (modo.segundos && restante === 0 && !cierre) terminar(respuestas, modo.segundos);
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [restante]);

	/* Respuestas del servidor */
	useEffect(() => {
		const data = fetcher.data;
		if (!data) return;

		if ("terminado" in data) {
			setCierre(data as CierreArcade);
			window.scrollTo({ top: 0 });
			return;
		}

		if ("acerto" in data) {
			const c = data as RespuestaCorregida;
			setCorreccion(c);
			sonar(c.acerto ? "bien" : "mal");

			if (c.acerto) {
				setAciertos((a) => a + 1);
				setRacha((r) => {
					const nueva = r + 1;
					setMejorRacha((m) => Math.max(m, nueva));
					return nueva;
				});
			} else {
				setRacha(0);
				setVidas((v) => v - 1);
				setTemblor(true);
				setTimeout(() => setTemblor(false), 420);
			}
		}
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [fetcher.data]);

	function responder() {
		if (!pregunta || correccion) return;
		setRespuestas((prev) => ({ ...prev, [pregunta.id]: respuesta }));
		fetcher.submit(
			{
				intent: "responder",
				token,
				questionId: String(pregunta.id),
				respuesta: JSON.stringify(respuesta),
			},
			{ method: "post" },
		);
	}

	function siguiente() {
		const mapa = { ...respuestas, [pregunta.id]: respuesta };
		const sinVidas = modo.vidas > 0 && vidas <= 0;
		const ultima = indice + 1 >= preguntas.length;

		if (sinVidas || ultima) {
			terminar(mapa, transcurrido);
			return;
		}
		setIndice((i) => i + 1);
		setRespuesta(null);
		setCorreccion(null);
	}

	if (cierre) {
		return <Cierre user={user} modo={modo} cierre={cierre} />;
	}

	if (!pregunta) return null;

	const vidasAgotadas = modo.vidas > 0 && vidas <= 0;

	return (
		<>
			<Nav user={user} />
			<Confetti activo={racha >= 5 && Boolean(correccion?.acerto)} />

			<main className="mx-auto max-w-3xl px-4 py-6 sm:px-5 sm:py-10">
				{/* Marcador */}
				<header className="mb-6">
					<div className="flex flex-wrap items-center justify-between gap-3">
						<Link
							to="/practica/arcade"
							className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
						>
							← salir
						</Link>

						<div className="flex items-center gap-3">
							{modo.vidas > 0 && (
								<span className="text-lg" title={`${vidas} vidas`}>
									{"❤️".repeat(Math.max(0, vidas))}
									<span className="opacity-30">
										{"🖤".repeat(Math.max(0, modo.vidas - vidas))}
									</span>
								</span>
							)}
							{modo.segundos > 0 && (
								<span
									className={`jc-mono rounded-full border px-3 py-1 text-sm ${
										restante <= 10
											? "border-[rgba(255,77,255,.5)] text-[var(--color-magenta)]"
											: "border-[var(--color-borde)] text-[var(--color-tinta-2)]"
									}`}
								>
									⏱ {formatoReloj(restante)}
								</span>
							)}
							<button
								type="button"
								onClick={alternar}
								title={sonidoActivo ? "Silenciar" : "Activar sonido"}
								className="jc-btn jc-btn-sm jc-btn-ghost"
							>
								{sonidoActivo ? "🔊" : "🔇"}
							</button>
						</div>
					</div>

					<h1
						className="jc-display mt-4 text-2xl sm:text-3xl"
						style={{ color: `rgb(${modo.color})` }}
					>
						{modo.emoji} {modo.nombre}
					</h1>

					<div className="mt-4 flex flex-wrap items-center gap-4">
						<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
							✅ {aciertos} aciertos
						</span>
						<span
							className={`jc-mono text-xs ${
								racha >= 5 ? "text-[var(--color-dorado)]" : "text-[var(--color-tinta-2)]"
							}`}
						>
							🔥 racha {racha}
							{racha >= 5 && " · +50% XP"}
						</span>
					</div>

					{modo.segundos === 0 && (
						<div className="mt-4">
							<BarraProgreso
								valor={indice + 1}
								total={preguntas.length}
								etiqueta={`Pregunta ${indice + 1} de ${preguntas.length}`}
							/>
						</div>
					)}
				</header>

				<section
					key={pregunta.id}
					className={`jc-glass p-5 sm:p-7 ${temblor ? "jc-anim-shake" : "jc-anim-slide"}`}
				>
					<Pregunta
						pregunta={pregunta}
						respuesta={respuesta}
						onRespuesta={setRespuesta}
						correccion={correccion}
					/>
				</section>

				<div className="mt-6 flex justify-end">
					{correccion ? (
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={siguiente}
							disabled={enviando}
						>
							{vidasAgotadas
								? "Sin vidas — ver resultado"
								: indice + 1 >= preguntas.length
									? "Terminar ✅"
									: "Siguiente →"}
						</button>
					) : (
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={responder}
							disabled={enviando || respuesta === null}
						>
							{enviando ? "Revisando…" : "Responder"}
						</button>
					)}
				</div>
			</main>
		</>
	);
}

/* ── Pantalla final ────────────────────────────────────────────────────── */

function Cierre({
	user,
	modo,
	cierre,
}: {
	user: DatosJuego["user"];
	modo: DatosJuego["modo"];
	cierre: CierreArcade;
}) {
	return (
		<>
			<Nav user={user} />
			<Confetti activo={cierre.aciertos > 0} />
			<ToastInsignias insignias={cierre.insignias} />

			<main className="mx-auto max-w-2xl px-4 py-12 sm:px-5">
				<div className="jc-anim-pop jc-glass p-8 text-center sm:p-10">
					<p className="text-5xl">{modo.emoji}</p>
					<h1 className="jc-display mt-4 text-3xl">{modo.nombre}</h1>

					<p className="jc-display mt-6 text-5xl" style={{ color: `rgb(${modo.color})` }}>
						{cierre.aciertos}
						<span className="text-2xl text-[var(--color-tinta-2)]">/{cierre.total}</span>
					</p>

					<p className="jc-mono mt-4 text-lg text-[var(--color-dorado)]">
						+{cierre.xp} XP
					</p>
					<p className="jc-mono mt-1 text-xs text-[var(--color-tinta-2)]">
						mejor racha: {cierre.mejorRacha} · nivel {cierre.nivel}
					</p>

					{cierre.nivelSubio && (
						<p className="jc-display mt-4 text-xl text-[var(--color-verde)]">
							¡Subiste de nivel! 🎉
						</p>
					)}

					{cierre.insignias.length > 0 && (
						<div className="mt-6 space-y-2">
							{cierre.insignias.map((i) => (
								<div
									key={i.nombre}
									className="jc-anim-pop rounded-2xl border border-[rgba(255,212,59,.45)]
										bg-[rgba(255,212,59,.08)] px-4 py-3"
								>
									<p className="jc-display text-lg">
										{i.emoji} {i.nombre}
									</p>
									<p className="text-sm text-[var(--color-tinta-2)]">{i.texto}</p>
								</div>
							))}
						</div>
					)}

					<div className="mt-8 flex flex-wrap justify-center gap-3">
						<Link to="/practica/arcade" className="jc-btn jc-btn-ghost">
							← Arcade
						</Link>
						{modo.slug !== "reto" && (
							<a href={`/practica/arcade/${modo.slug}`} className="jc-btn jc-btn-primary">
								🔁 Otra vez
							</a>
						)}
						<Link to="/perfil" className="jc-btn jc-btn-ghost">
							👤 Mi perfil
						</Link>
					</div>
				</div>
			</main>
		</>
	);
}
