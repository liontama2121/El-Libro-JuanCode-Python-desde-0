import { inArray } from "drizzle-orm";
import { useEffect, useMemo, useState } from "react";
import { Form, Link, useFetcher, useSearchParams } from "react-router";
import { Nav } from "~/components/nav";
import { Pregunta, type CorreccionUI } from "~/components/pregunta";
import { BarraProgreso, ScoreAnimado, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { formatoReloj } from "~/lib/format";
import {
	aPublica,
	calificar,
	elegirPreguntas,
	type PreguntaPublica,
	type Respuesta,
} from "~/lib/bank.server";
import { cargarLibro } from "~/lib/progress.server";
import { firmar, verificar } from "~/lib/sign.server";
import type { Route } from "./+types/practica.simulacro-quiz";

export const meta: Route.MetaFunction = () => [
	{ title: "Simulacro de quiz — El Libro JuanCode" },
];

const CANTIDADES = [10, 20, 30];
const SEGUNDOS_POR_PREGUNTA = 60;

type Sobre = { ids: number[]; crono: boolean; caps: number[] };

/* -------------------------------------------------------------------------- */
/*  LOADER                                                                     */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const { capitulos } = await cargarLibro(db, user.id, user.role === "teacher");
	const abiertos = capitulos.filter((c) => c.estado !== "bloqueado");

	const url = new URL(request.url);
	const empezar = url.searchParams.get("empezar") === "1";

	if (!empezar) {
		return {
			user,
			modo: "config" as const,
			abiertos: abiertos.map((c) => ({
				id: c.id,
				number: c.number,
				title: c.title,
				emoji: c.emoji,
			})),
		};
	}

	const crono = url.searchParams.get("crono") === "1";
	const cantidad = Math.min(50, Math.max(1, Number(url.searchParams.get("n")) || 10));

	const capsPedidos = (url.searchParams.get("caps") || "")
		.split(",")
		.map(Number)
		.filter((n) => Number.isInteger(n));

	// Solo capítulos que el estudiante tiene abiertos, pida lo que pida.
	const permitidos = new Set(abiertos.map((c) => c.id));
	const caps = capsPedidos.filter((id) => permitidos.has(id));
	const chapterIds = caps.length ? caps : abiertos.map((c) => c.id);

	// "Repetir solo las falladas": vienen ids concretos
	const repetir = (url.searchParams.get("ids") || "")
		.split(",")
		.map(Number)
		.filter((n) => Number.isInteger(n) && n > 0);

	const elegidas = repetir.length
		? await db
				.select()
				.from(schema.questionBank)
				.where(inArray(schema.questionBank.id, repetir))
		: await elegirPreguntas(db, { chapterIds, limite: cantidad });

	const semilla = Date.now() % 100000;
	const titulos = new Map(abiertos.map((c) => [c.id, `${c.number}. ${c.title}`]));

	return {
		user,
		modo: "quiz" as const,
		preguntas: elegidas.map((q) => aPublica(q, semilla)),
		capitulos: Object.fromEntries(titulos),
		crono,
		segundos: crono ? elegidas.length * SEGUNDOS_POR_PREGUNTA : 0,
		token: await firmar(env, {
			ids: elegidas.map((q) => q.id),
			crono,
			caps: chapterIds,
		} satisfies Sobre),
	};
}

/* -------------------------------------------------------------------------- */
/*  ACTION — califica en el servidor y guarda el intento                       */
/* -------------------------------------------------------------------------- */

export type ResultadoSimulacro = {
	score: number;
	aciertos: number;
	total: number;
	segundos: number;
	feedback: (CorreccionUI & { questionId: number; chapterId: number })[];
	porCapitulo: { chapterId: number; aciertos: number; total: number }[];
	falladas: number[];
};

export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const form = await request.formData();
	const sobre = await verificar<Sobre>(env, String(form.get("token") || ""));
	if (!sobre) throw new Response("Firma inválida", { status: 400 });

	let enviadas: Record<string, Respuesta> = {};
	try {
		enviadas = JSON.parse(String(form.get("respuestas") || "{}"));
	} catch {
		enviadas = {};
	}
	const segundos = Math.max(0, Number(form.get("segundos")) || 0);

	const preguntas = await db
		.select()
		.from(schema.questionBank)
		.where(inArray(schema.questionBank.id, sobre.ids));

	const feedback = sobre.ids.flatMap((id) => {
		const q = preguntas.find((p) => p.id === id);
		if (!q) return [];
		return [
			{
				questionId: id,
				chapterId: q.chapterId,
				...calificar(q, enviadas[String(id)] ?? null),
			},
		];
	});

	const aciertos = feedback.filter((f) => f.acerto).length;
	const total = feedback.length;
	const score = total ? Math.round((aciertos / total) * 100) : 0;

	const porCapitulo = [...new Set(feedback.map((f) => f.chapterId))].map((chapterId) => ({
		chapterId,
		aciertos: feedback.filter((f) => f.chapterId === chapterId && f.acerto).length,
		total: feedback.filter((f) => f.chapterId === chapterId).length,
	}));

	const falladas = feedback.filter((f) => !f.acerto).map((f) => f.questionId);

	// El simulacro NO desbloquea capítulos: solo el quiz oficial lo hace.
	await db.insert(schema.practiceAttempts).values({
		userId: user.id,
		mode: "simulacro_quiz",
		configJson: JSON.stringify({ caps: sobre.caps, crono: sobre.crono, total }),
		score: aciertos,
		total,
		xpEarned: 0, // la XP entra en la Fase B
		durationSeconds: segundos,
		detailJson: JSON.stringify({ porCapitulo, falladas }),
	});

	const resultado: ResultadoSimulacro = {
		score,
		aciertos,
		total,
		segundos,
		feedback,
		porCapitulo,
		falladas,
	};
	return resultado;
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function SimulacroQuiz({ loaderData }: Route.ComponentProps) {
	if (loaderData.modo === "config") {
		return <Configurador loaderData={loaderData} />;
	}
	return <Corriendo loaderData={loaderData} />;
}

/* ── Pantalla de configuración ─────────────────────────────────────────── */

type DatosConfig = Extract<Route.ComponentProps["loaderData"], { modo: "config" }>;

function Configurador({ loaderData }: { loaderData: DatosConfig }) {
	const { user, abiertos } = loaderData;
	const [todos, setTodos] = useState(true);
	const [marcados, setMarcados] = useState<number[]>([]);

	const seleccion = todos ? abiertos.map((c) => c.id) : marcados;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-3xl px-4 py-10 sm:px-5">
				<Link
					to="/practica"
					className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
				>
					← práctica
				</Link>

				<h1 className="jc-display jc-grad mt-4 text-3xl sm:text-4xl">
					🎯 Simulacro de quiz
				</h1>
				<p className="mt-3 text-[var(--color-tinta-2)]">
					Preguntas al azar, sin repetir. No desbloquea capítulos: es para entrenar.
				</p>

				<Form method="get" className="jc-glass mt-8 space-y-7 p-5 sm:p-7">
					<input type="hidden" name="empezar" value="1" />
					<input type="hidden" name="caps" value={seleccion.join(",")} />

					<div>
						<span className="jc-label">Capítulos</span>
						<label className="mt-2 flex items-center gap-3 text-sm">
							<input
								type="checkbox"
								checked={todos}
								onChange={(e) => setTodos(e.target.checked)}
								className="h-4 w-4 accent-[var(--color-cyan)]"
							/>
							Todos los que tengo desbloqueados ({abiertos.length})
						</label>

						{!todos && (
							<div className="mt-4 grid gap-2 sm:grid-cols-2">
								{abiertos.map((c) => (
									<label
										key={c.id}
										className="flex items-center gap-2 rounded-xl border border-[var(--color-borde)]
											bg-white/[0.03] px-3 py-2 text-sm"
									>
										<input
											type="checkbox"
											checked={marcados.includes(c.id)}
											onChange={(e) =>
												setMarcados((prev) =>
													e.target.checked
														? [...prev, c.id]
														: prev.filter((id) => id !== c.id),
												)
											}
											className="h-4 w-4 accent-[var(--color-cyan)]"
										/>
										<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
											{c.number}
										</span>
										<span className="truncate">
											{c.emoji} {c.title}
										</span>
									</label>
								))}
							</div>
						)}
					</div>

					<div>
						<span className="jc-label">¿Cuántas preguntas?</span>
						<div className="mt-2 flex flex-wrap gap-2">
							{CANTIDADES.map((n, i) => (
								<label key={n} className="cursor-pointer">
									<input
										type="radio"
										name="n"
										value={n}
										defaultChecked={i === 0}
										className="peer sr-only"
									/>
									<span
										className="jc-btn jc-btn-sm peer-checked:border-transparent
											peer-checked:bg-[var(--color-cyan)] peer-checked:text-[#08131a]"
									>
										{n}
									</span>
								</label>
							))}
						</div>
					</div>

					<label className="flex items-center gap-3 text-sm">
						<input
							type="checkbox"
							name="crono"
							value="1"
							className="h-4 w-4 accent-[var(--color-cyan)]"
						/>
						Con cronómetro (1 minuto por pregunta)
					</label>

					<button
						type="submit"
						className="jc-btn jc-btn-primary w-full text-lg"
						disabled={seleccion.length === 0}
					>
						Empezar simulacro 🚀
					</button>
				</Form>
			</main>
		</>
	);
}

/* ── Simulacro en marcha ───────────────────────────────────────────────── */

type DatosQuiz = Extract<Route.ComponentProps["loaderData"], { modo: "quiz" }>;

function Corriendo({ loaderData }: { loaderData: DatosQuiz }) {
	const { user, preguntas, capitulos, crono, segundos, token } = loaderData;
	const fetcher = useFetcher<typeof action>();
	const [params] = useSearchParams();

	const [resultado, setResultado] = useState<ResultadoSimulacro | null>(null);
	const [indice, setIndice] = useState(0);
	const [respuestas, setRespuestas] = useState<Record<number, Respuesta>>({});
	const [restante, setRestante] = useState(segundos);
	const [transcurrido, setTranscurrido] = useState(0);

	const total = preguntas.length;
	const enviando = fetcher.state !== "idle";

	const enviar = useMemo(
		() => () =>
			fetcher.submit(
				{
					respuestas: JSON.stringify(respuestas),
					token,
					segundos: String(transcurrido),
				},
				{ method: "post" },
			),
		[fetcher, respuestas, token, transcurrido],
	);

	// Cronómetro
	useEffect(() => {
		const id = setInterval(() => {
			setTranscurrido((t) => t + 1);
			if (crono) setRestante((r) => Math.max(0, r - 1));
		}, 1000);
		return () => clearInterval(id);
	}, [crono]);

	// Se acabó el tiempo: se envía lo que haya
	useEffect(() => {
		if (crono && restante === 0 && segundos > 0 && !resultado && !enviando) enviar();
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [restante]);

	useEffect(() => {
		if (fetcher.data && "score" in fetcher.data) {
			setResultado(fetcher.data as ResultadoSimulacro);
			window.scrollTo({ top: 0 });
		}
	}, [fetcher.data]);

	if (resultado) {
		return (
			<ResultadoSimulacroVista
				user={user}
				resultado={resultado}
				preguntas={preguntas}
				respuestas={respuestas}
				capitulos={capitulos}
				volverA={`/practica/simulacro-quiz?${params.toString()}`}
			/>
		);
	}

	if (total === 0) {
		return (
			<>
				<Nav user={user} />
				<main className="mx-auto max-w-2xl px-5 py-24 text-center">
					<p className="text-[var(--color-tinta-2)]">
						No hay preguntas en el banco para esos capítulos todavía.
					</p>
					<Link to="/practica/simulacro-quiz" className="jc-btn mt-6">
						Cambiar la selección
					</Link>
				</main>
			</>
		);
	}

	const pregunta = preguntas[indice];
	const respondidas = Object.keys(respuestas).length;
	const esUltima = indice === total - 1;

	return (
		<>
			<Nav user={user} />

			<main className="mx-auto max-w-3xl px-4 py-8 sm:px-5 sm:py-10">
				<header className="mb-7">
					<div className="flex flex-wrap items-center justify-between gap-3">
						<Link
							to="/practica"
							className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
						>
							← salir
						</Link>
						{crono && (
							<span
								className={`jc-mono rounded-full border px-4 py-1.5 text-sm ${
									restante <= 30
										? "border-[rgba(255,77,255,.5)] text-[var(--color-magenta)]"
										: "border-[var(--color-borde)] text-[var(--color-tinta-2)]"
								}`}
							>
								⏱ {formatoReloj(restante)}
							</span>
						)}
					</div>

					<h1 className="jc-display mt-4 text-2xl sm:text-3xl">🎯 Simulacro</h1>

					<div className="mt-5">
						<BarraProgreso
							valor={indice + 1}
							total={total}
							etiqueta={`Pregunta ${indice + 1} de ${total}`}
						/>
					</div>
				</header>

				<section key={pregunta.id} className="jc-anim-slide jc-glass p-5 sm:p-7">
					<p className="jc-mono mb-3 text-xs text-[var(--color-tinta-2)]">
						{capitulos[String(pregunta.chapterId)] ?? "Capítulo"}
					</p>
					<Pregunta
						pregunta={pregunta}
						respuesta={respuestas[pregunta.id] ?? null}
						onRespuesta={(r) => setRespuestas((prev) => ({ ...prev, [pregunta.id]: r }))}
					/>
				</section>

				<div className="mt-7 flex items-center justify-between gap-3">
					<button
						type="button"
						className="jc-btn jc-btn-ghost"
						onClick={() => setIndice((i) => Math.max(0, i - 1))}
						disabled={indice === 0}
					>
						← Anterior
					</button>

					{esUltima ? (
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={enviar}
							disabled={enviando}
						>
							{enviando ? "Calificando…" : "Terminar ✅"}
						</button>
					) : (
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={() => setIndice((i) => Math.min(total - 1, i + 1))}
						>
							Siguiente →
						</button>
					)}
				</div>

				<p className="jc-mono mt-5 text-center text-xs text-[var(--color-tinta-2)]">
					{respondidas}/{total} respondidas · puedes terminar cuando quieras
				</p>
			</main>
		</>
	);
}

/* ── Resultado ─────────────────────────────────────────────────────────── */

function ResultadoSimulacroVista({
	user,
	resultado,
	preguntas,
	respuestas,
	capitulos,
	volverA,
}: {
	user: DatosQuiz["user"];
	resultado: ResultadoSimulacro;
	preguntas: PreguntaPublica[];
	respuestas: Record<number, Respuesta>;
	capitulos: Record<string, string>;
	volverA: string;
}) {
	const falladas = resultado.feedback.filter((f) => !f.acerto);

	return (
		<>
			<Nav user={user} />

			<main className="mx-auto max-w-3xl px-4 py-10 sm:px-5 sm:py-12">
				<div className="jc-anim-pop jc-glass flex flex-col items-center p-7 text-center sm:p-10">
					<ScoreAnimado score={resultado.score} aprobado={resultado.score >= 80} />
					<h1 className="jc-display mt-6 text-3xl">Simulacro terminado</h1>
					<p className="mt-3 text-[var(--color-tinta-2)]">
						{resultado.aciertos} de {resultado.total} correctas · {formatoReloj(resultado.segundos)}
					</p>
					<p className="jc-mono mt-2 text-xs text-[var(--color-tinta-2)]">
						esto no desbloquea capítulos — el quiz oficial sí
					</p>
				</div>

				{/* Desglose por capítulo */}
				<section className="mt-10">
					<h2 className="jc-display text-2xl">Por capítulo</h2>
					<div className="mt-5 space-y-4">
						{resultado.porCapitulo.map((c) => (
							<div key={c.chapterId}>
								<div className="mb-1 flex items-baseline justify-between text-sm">
									<span>{capitulos[String(c.chapterId)] ?? `Capítulo ${c.chapterId}`}</span>
									<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
										{c.aciertos}/{c.total}
									</span>
								</div>
								<BarraProgreso valor={c.aciertos} total={c.total} />
							</div>
						))}
					</div>
				</section>

				<div className="mt-8 flex flex-wrap gap-3">
					<Link to="/practica" className="jc-btn jc-btn-ghost">
						← Práctica
					</Link>
					<a href={volverA} className="jc-btn jc-btn-ghost">
						🔁 Otro simulacro
					</a>
					{falladas.length > 0 && (
						<a
							href={`/practica/simulacro-quiz?empezar=1&ids=${falladas
								.map((f) => f.questionId)
								.join(",")}`}
							className="jc-btn jc-btn-primary"
						>
							Repetir solo las falladas ({falladas.length})
						</a>
					)}
				</div>

				{/* Revisión de las falladas */}
				{falladas.length > 0 && (
					<section className="mt-12">
						<h2 className="jc-display text-2xl">Lo que falló</h2>
						<div className="mt-6 space-y-5">
							{falladas.map((f) => {
								const pregunta = preguntas.find((p) => p.id === f.questionId);
								if (!pregunta) return null;
								return (
									<article
										key={f.questionId}
										className="rounded-2xl border border-[rgba(255,77,255,.35)]
											bg-[rgba(255,77,255,.05)] p-5 sm:p-6"
									>
										<p className="jc-mono mb-3 text-xs text-[var(--color-tinta-2)]">
											{capitulos[String(f.chapterId)] ?? "Capítulo"}
										</p>
										<Pregunta
											pregunta={pregunta}
											respuesta={respuestas[f.questionId] ?? null}
											onRespuesta={() => {}}
											correccion={f}
										/>
									</article>
								);
							})}
						</div>
					</section>
				)}
			</main>
		</>
	);
}
