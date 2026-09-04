import { and, eq, inArray } from "drizzle-orm";
import { useEffect, useState } from "react";
import { Link, redirect, useFetcher } from "react-router";
import { Nav } from "~/components/nav";
import { Pregunta, type CorreccionUI } from "~/components/pregunta";
import {
	BarraProgreso,
	Confetti,
	ScoreAnimado,
	Toast,
	ToastInsignias,
} from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import {
	aPublica,
	calificar,
	elegirPreguntas,
	type PreguntaPublica,
	type Respuesta,
} from "~/lib/bank.server";
import {
	capitulosAprobados,
	insigniasPorCapitulos,
	otorgar,
	XP_QUIZ_CAPITULO,
} from "~/lib/gamification.server";
import { cargarLibro, otorgarDesbloqueo } from "~/lib/progress.server";
import {
	palabraCapitulo,
	puedeVerTrack,
	rutaCapitulo,
	rutaLibro,
	rutaQuiz,
	trackDeRuta,
	tracksVisibles,
} from "~/lib/tracks";
import { firmar, verificar } from "~/lib/sign.server";
import type { Track } from "~/db/schema";
import type { Route } from "./+types/quiz";

export const meta: Route.MetaFunction = ({ data }) => [
	{
		title: data
			? `Quiz — ${data.capitulo.title} — El Libro JuanCode`
			: "Quiz — El Libro JuanCode",
	},
];

/** Cuántas preguntas trae cada intento del quiz oficial. */
const PREGUNTAS_POR_QUIZ = 5;

type Sobre = { quizId: number; chapterId: number; ids: number[] };

/* -------------------------------------------------------------------------- */
/*  LOADER — arma un quiz distinto en cada intento, sin revelar respuestas     */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const numero = Number(params.number);
	const esProfesor = user.role === "teacher";

	const track = trackDeRuta(request.url);
	if (!puedeVerTrack(user.track, track, esProfesor)) {
		throw redirect(rutaLibro(tracksVisibles(user.track)[0]));
	}

	const { capitulos } = await cargarLibro(db, user.id, esProfesor, track);
	const capitulo = capitulos.find((c) => c.number === numero);

	if (!capitulo || capitulo.estado === "bloqueado") {
		throw redirect(
			`${rutaLibro(track)}?toast=${encodeURIComponent("Aprueba el quiz del capítulo anterior 🔒")}`,
		);
	}

	const [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.chapterId, capitulo.id))
		.limit(1);

	if (!quiz) {
		throw redirect(
			`${rutaCapitulo(track, numero)}?toast=${encodeURIComponent(
				"Este capítulo todavía no tiene quiz 🙃",
			)}`,
		);
	}

	// 5 preguntas al azar del banco del capítulo: cada intento es distinto.
	const elegidas = await elegirPreguntas(db, {
		chapterIds: [capitulo.id],
		// El libro básico pregunta con opción múltiple: el estudiante apenas
		// está entendiendo qué hace el código. El avanzado además lo hace
		// escribir y armar — ahí el objetivo es que se sepa los algoritmos.
		tipos:
			track === "avanzado"
				? ["mcq", "predict_output", "find_bug", "parsons", "fill_blank"]
				: ["mcq", "predict_output"],
		limite: PREGUNTAS_POR_QUIZ,
	});

	const semilla = Date.now() % 100000;
	const preguntas = elegidas.map((q) => aPublica(q, semilla));

	// El action necesita saber qué preguntas se sirvieron. Van firmadas para
	// que nadie pueda cambiárselas por otras.
	const sobre: Sobre = {
		quizId: quiz.id,
		chapterId: capitulo.id,
		ids: elegidas.map((q) => q.id),
	};

	return {
		user,
		track,
		capitulo,
		passingScore: quiz.passingScore,
		preguntas,
		token: await firmar(env, sobre),
		siguiente: capitulos.find((c) => c.number === numero + 1) ?? null,
	};
}

/* -------------------------------------------------------------------------- */
/*  ACTION — la calificación y el desbloqueo ocurren SIEMPRE aquí (servidor)   */
/* -------------------------------------------------------------------------- */

export type Feedback = CorreccionUI & { questionId: number };

export type ResultadoQuiz = {
	score: number;
	passed: boolean;
	aciertos: number;
	totalPreguntas: number;
	passingScore: number;
	feedback: Feedback[];
	desbloqueado: number | null;
	xp: number;
	insignias: { emoji: string; nombre: string; texto: string }[];
};

export async function action({ context, request, params }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const numero = Number(params.number);
	const track = trackDeRuta(request.url);

	if (!puedeVerTrack(user.track, track, user.role === "teacher")) {
		throw redirect(rutaLibro(tracksVisibles(user.track)[0]));
	}

	const { capitulos } = await cargarLibro(
		db,
		user.id,
		user.role === "teacher",
		track,
	);
	const capitulo = capitulos.find((c) => c.number === numero);

	if (!capitulo || capitulo.estado === "bloqueado") {
		throw redirect(
			`${rutaLibro(track)}?toast=${encodeURIComponent("Aprueba el quiz del capítulo anterior 🔒")}`,
		);
	}

	const form = await request.formData();
	const sobre = await verificar<Sobre>(env, String(form.get("token") || ""));

	// Sin firma válida no se califica: son preguntas que este servidor no sirvió.
	if (!sobre || sobre.chapterId !== capitulo.id) {
		throw redirect(rutaQuiz(track, numero));
	}

	const [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.id, sobre.quizId))
		.limit(1);
	if (!quiz) throw redirect(rutaCapitulo(track, numero));

	let enviadas: Record<string, Respuesta> = {};
	try {
		enviadas = JSON.parse(String(form.get("respuestas") || "{}"));
	} catch {
		enviadas = {};
	}

	const preguntas = await db
		.select()
		.from(schema.questionBank)
		.where(inArray(schema.questionBank.id, sobre.ids));

	if (preguntas.length === 0) throw redirect(rutaCapitulo(track, numero));

	const feedback: Feedback[] = sobre.ids.flatMap((id) => {
		const q = preguntas.find((p) => p.id === id);
		if (!q) return [];
		return [{ questionId: id, ...calificar(q, enviadas[String(id)] ?? null) }];
	});

	const aciertos = feedback.filter((f) => f.acerto).length;
	const score = Math.round((aciertos / feedback.length) * 100);
	const passed = score >= quiz.passingScore;

	// ¿Ya lo había aprobado antes? La XP del capítulo se paga una sola vez.
	const [yaAprobado] = await db
		.select({ id: schema.quizAttempts.id })
		.from(schema.quizAttempts)
		.where(
			and(
				eq(schema.quizAttempts.userId, user.id),
				eq(schema.quizAttempts.quizId, quiz.id),
				eq(schema.quizAttempts.passed, true),
			),
		)
		.limit(1);

	await db.insert(schema.quizAttempts).values({
		userId: user.id,
		quizId: quiz.id,
		score,
		passed,
		answersJson: JSON.stringify(enviadas),
	});

	// Aprobar el quiz del capítulo N desbloquea el N+1 DEL MISMO LIBRO.
	// Sin el filtro por track, el quiz del último capítulo básico abriría el
	// primer módulo del avanzado.
	let desbloqueado: number | null = null;
	if (passed) {
		const [siguiente] = await db
			.select({ id: schema.chapters.id, number: schema.chapters.number })
			.from(schema.chapters)
			.where(
				and(
					eq(schema.chapters.track, capitulo.track),
					eq(schema.chapters.number, numero + 1),
				),
			)
			.limit(1);

		if (siguiente) {
			await otorgarDesbloqueo(db, user.id, siguiente.id, "quiz");
			desbloqueado = siguiente.number;
		}
	}

	// XP y insignias: siempre en el servidor.
	const premio = await otorgar(db, user.id, {
		xp: passed && !yaAprobado ? XP_QUIZ_CAPITULO : 0,
		candidatas: passed ? insigniasPorCapitulos(await capitulosAprobados(db, user.id)) : [],
	});

	const resultado: ResultadoQuiz = {
		score,
		passed,
		aciertos,
		totalPreguntas: feedback.length,
		passingScore: quiz.passingScore,
		feedback,
		desbloqueado,
		xp: premio.xp,
		insignias: premio.nuevasInsignias.map((i) => ({
			emoji: i.emoji,
			nombre: i.nombre,
			texto: i.texto,
		})),
	};
	return resultado;
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function Quiz({ loaderData }: Route.ComponentProps) {
	const { user, track, capitulo, preguntas, passingScore, siguiente, token } =
		loaderData;
	const fetcher = useFetcher<typeof action>();

	const [resultado, setResultado] = useState<ResultadoQuiz | null>(null);
	const [indice, setIndice] = useState(0);
	const [respuestas, setRespuestas] = useState<Record<number, Respuesta>>({});

	// El resultado sólo puede venir del action (calificación en servidor).
	useEffect(() => {
		if (fetcher.data && "score" in fetcher.data) {
			setResultado(fetcher.data as ResultadoQuiz);
			window.scrollTo({ top: 0 });
		}
	}, [fetcher.data]);

	const pregunta = preguntas[indice];
	const total = preguntas.length;
	const enviando = fetcher.state !== "idle";
	const respondidas = Object.keys(respuestas).length;

	function enviar() {
		fetcher.submit(
			{ respuestas: JSON.stringify(respuestas), token },
			{ method: "post" },
		);
	}

	if (resultado) {
		return (
			<Resultado
				user={user}
				track={track}
				capituloNumero={capitulo.number}
				capituloTitulo={capitulo.title}
				resultado={resultado}
				preguntas={preguntas}
				respuestas={respuestas}
				siguienteNumero={resultado.desbloqueado ?? siguiente?.number ?? null}
			/>
		);
	}

	if (total === 0) {
		return (
			<>
				<Nav user={user} />
				<main className="mx-auto max-w-2xl px-5 py-24 text-center">
					<p className="text-[var(--color-tinta-2)]">
						El banco de este capítulo todavía no tiene preguntas.
					</p>
					<Link to={rutaCapitulo(track, capitulo.number)} className="jc-btn mt-6">
						Volver al capítulo
					</Link>
				</main>
			</>
		);
	}

	const esUltima = indice === total - 1;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-3xl px-4 py-8 sm:px-5 sm:py-10">
				<header className="mb-7">
					<Link
						to={rutaCapitulo(track, capitulo.number)}
						className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
					>
						← salir del quiz
					</Link>
					<h1 className="jc-display jc-grad mt-4 text-2xl sm:text-3xl">
						🎯 Quiz — {capitulo.title}
					</h1>
					<p className="jc-mono mt-2 text-xs text-[var(--color-tinta-2)]">
						{passingScore} puntos para aprobar · preguntas nuevas en cada intento
					</p>

					<div className="mt-6">
						<BarraProgreso
							valor={indice + 1}
							total={total}
							etiqueta={`Pregunta ${indice + 1} de ${total}`}
						/>
					</div>
				</header>

				<section key={pregunta.id} className="jc-anim-slide jc-glass p-5 sm:p-7">
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
							disabled={enviando || respondidas !== total}
						>
							{enviando ? "Calificando…" : "Enviar respuestas ✅"}
						</button>
					) : (
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={() => setIndice((i) => Math.min(total - 1, i + 1))}
							disabled={respuestas[pregunta.id] === undefined}
						>
							Siguiente →
						</button>
					)}
				</div>

				<p className="jc-mono mt-5 text-center text-xs text-[var(--color-tinta-2)]">
					{respondidas}/{total} respondidas
				</p>
			</main>
		</>
	);
}

/* -------------------------------------------------------------------------- */

function Resultado({
	user,
	track,
	capituloNumero,
	capituloTitulo,
	resultado,
	preguntas,
	respuestas,
	siguienteNumero,
}: {
	user: Route.ComponentProps["loaderData"]["user"];
	track: Track;
	capituloNumero: number;
	capituloTitulo: string;
	resultado: ResultadoQuiz;
	preguntas: PreguntaPublica[];
	respuestas: Record<number, Respuesta>;
	siguienteNumero: number | null;
}) {
	const { score, passed, aciertos, totalPreguntas, feedback } = resultado;

	return (
		<>
			<Nav user={user} />
			<Confetti activo={passed} />
			<ToastInsignias insignias={resultado.insignias} />

			<main className="mx-auto max-w-3xl px-4 py-10 sm:px-5 sm:py-12">
				<div className="jc-anim-pop jc-glass flex flex-col items-center p-7 text-center sm:p-10">
					<ScoreAnimado score={score} aprobado={passed} />

					<h1 className="jc-display mt-6 text-3xl sm:text-4xl">
						{passed ? "¡Aprobaste! 🎉" : "Casi… 💪"}
					</h1>
					<p className="mt-3 text-[var(--color-tinta-2)]">
						{aciertos} de {totalPreguntas} correctas · necesitabas{" "}
						{resultado.passingScore} puntos
					</p>

					{passed && siguienteNumero && (
						<p className="jc-mono mt-4 text-sm text-[var(--color-verde)]">
							🔓 {palabraCapitulo(track)} {siguienteNumero} desbloqueado
						</p>
					)}
					{resultado.xp > 0 && (
						<p className="jc-mono mt-2 text-sm text-[var(--color-dorado)]">
							+{resultado.xp} XP
						</p>
					)}

					<div className="mt-8 flex flex-wrap justify-center gap-3">
						{passed && siguienteNumero ? (
							<Link
								to={rutaCapitulo(track, siguienteNumero)}
								className="jc-btn jc-btn-verde text-lg"
							>
								Ir al capítulo siguiente 🚀
							</Link>
						) : passed ? (
							<Link to={rutaLibro(track)} className="jc-btn jc-btn-verde text-lg">
								Volver al libro 📚
							</Link>
						) : (
							<>
								<Link
									to={rutaCapitulo(track, capituloNumero)}
									className="jc-btn jc-btn-ghost"
								>
									📖 Repasar capítulo
								</Link>
								{/* Recargar el quiz trae 5 preguntas nuevas del banco */}
								<a
									href={rutaQuiz(track, capituloNumero)}
									className="jc-btn jc-btn-primary"
								>
									🔁 Reintentar quiz
								</a>
							</>
						)}
					</div>
				</div>

				<section className="mt-12">
					<h2 className="jc-display text-2xl">Revisión</h2>
					<p className="mt-1 text-sm text-[var(--color-tinta-2)]">{capituloTitulo}</p>

					<div className="mt-6 space-y-5">
						{feedback.map((f, i) => {
							const pregunta = preguntas.find((p) => p.id === f.questionId);
							if (!pregunta) return null;
							return (
								<article
									key={f.questionId}
									className={`rounded-2xl border p-5 sm:p-6 ${
										f.acerto
											? "border-[rgba(52,224,122,.4)] bg-[rgba(52,224,122,.06)]"
											: "border-[rgba(255,77,255,.35)] bg-[rgba(255,77,255,.05)]"
									}`}
								>
									<p className="jc-mono mb-3 text-xs text-[var(--color-tinta-2)]">
										Pregunta {i + 1}
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
			</main>
		</>
	);
}
