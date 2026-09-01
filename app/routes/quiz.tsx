import { asc, eq, inArray } from "drizzle-orm";
import { useEffect, useState } from "react";
import { Link, redirect, useFetcher } from "react-router";
import { Nav } from "~/components/nav";
import {
	BarraProgreso,
	BloqueCodigo,
	Confetti,
	ScoreAnimado,
	Toast,
} from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { cargarLibro, otorgarDesbloqueo } from "~/lib/progress.server";
import type { Route } from "./+types/quiz";

export const meta: Route.MetaFunction = ({ data }) => [
	{
		title: data
			? `Quiz — ${data.capitulo.title} — El Libro JuanCode`
			: "Quiz — El Libro JuanCode",
	},
];

type PreguntaPublica = {
	id: number;
	prompt: string;
	codeSnippet: string | null;
	opciones: { id: number; label: string; text: string }[];
};

/* -------------------------------------------------------------------------- */
/*  LOADER: nunca envía is_correct al cliente                                  */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const numero = Number(params.number);
	const { capitulos } = await cargarLibro(
		db,
		user.id,
		user.role === "teacher",
	);
	const capitulo = capitulos.find((c) => c.number === numero);

	if (!capitulo || capitulo.estado === "bloqueado") {
		throw redirect(
			`/libro?toast=${encodeURIComponent(
				"Aprueba el quiz del capítulo anterior 🔒",
			)}`,
		);
	}

	const [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.chapterId, capitulo.id))
		.limit(1);

	if (!quiz) {
		throw redirect(
			`/libro/capitulo/${numero}?toast=${encodeURIComponent(
				"Este capítulo todavía no tiene quiz 🙃",
			)}`,
		);
	}

	const preguntas = await db
		.select()
		.from(schema.questions)
		.where(eq(schema.questions.quizId, quiz.id))
		.orderBy(asc(schema.questions.orden), asc(schema.questions.id));

	const opciones = preguntas.length
		? await db
				.select({
					id: schema.options.id,
					questionId: schema.options.questionId,
					label: schema.options.label,
					text: schema.options.text,
					// OJO: is_correct NO se selecciona. La calificación es del servidor.
				})
				.from(schema.options)
				.where(
					inArray(
						schema.options.questionId,
						preguntas.map((p) => p.id),
					),
				)
				.orderBy(asc(schema.options.label))
		: [];

	const publicas: PreguntaPublica[] = preguntas.map((p) => ({
		id: p.id,
		prompt: p.prompt,
		codeSnippet: p.codeSnippet,
		opciones: opciones.filter((o) => o.questionId === p.id),
	}));

	return {
		user,
		capitulo,
		passingScore: quiz.passingScore,
		preguntas: publicas,
		siguiente: capitulos.find((c) => c.number === numero + 1) ?? null,
	};
}

/* -------------------------------------------------------------------------- */
/*  ACTION: la calificación y el desbloqueo ocurren SIEMPRE aquí (servidor)    */
/* -------------------------------------------------------------------------- */

export type ResultadoQuiz = {
	score: number;
	passed: boolean;
	aciertos: number;
	totalPreguntas: number;
	passingScore: number;
	feedback: Feedback[];
	desbloqueado: number | null;
};

export type Feedback = {
	questionId: number;
	prompt: string;
	seleccionada: number | null;
	correcta: number | null;
	acerto: boolean;
};

export async function action({ context, request, params }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const numero = Number(params.number);
	const { capitulos } = await cargarLibro(db, user.id, user.role === "teacher");
	const capitulo = capitulos.find((c) => c.number === numero);

	if (!capitulo || capitulo.estado === "bloqueado") {
		throw redirect(
			`/libro?toast=${encodeURIComponent(
				"Aprueba el quiz del capítulo anterior 🔒",
			)}`,
		);
	}

	const [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.chapterId, capitulo.id))
		.limit(1);
	if (!quiz) throw redirect(`/libro/capitulo/${numero}`);

	const form = await request.formData();
	let enviadas: Record<string, number> = {};
	try {
		enviadas = JSON.parse(String(form.get("respuestas") || "{}"));
	} catch {
		enviadas = {};
	}

	const preguntas = await db
		.select()
		.from(schema.questions)
		.where(eq(schema.questions.quizId, quiz.id))
		.orderBy(asc(schema.questions.orden), asc(schema.questions.id));

	if (preguntas.length === 0) throw redirect(`/libro/capitulo/${numero}`);

	const opciones = await db
		.select()
		.from(schema.options)
		.where(
			inArray(
				schema.options.questionId,
				preguntas.map((p) => p.id),
			),
		);

	const feedback: Feedback[] = preguntas.map((p) => {
		const delGrupo = opciones.filter((o) => o.questionId === p.id);
		const correcta = delGrupo.find((o) => o.isCorrect) ?? null;
		const marcada = Number(enviadas[String(p.id)]);
		const seleccionada = delGrupo.some((o) => o.id === marcada) ? marcada : null;

		return {
			questionId: p.id,
			prompt: p.prompt,
			seleccionada,
			correcta: correcta?.id ?? null,
			acerto: correcta != null && seleccionada === correcta.id,
		};
	});

	const aciertos = feedback.filter((f) => f.acerto).length;
	const score = Math.round((aciertos / preguntas.length) * 100);
	const passed = score >= quiz.passingScore;

	await db.insert(schema.quizAttempts).values({
		userId: user.id,
		quizId: quiz.id,
		score,
		passed,
		answersJson: JSON.stringify(enviadas),
	});

	// Aprobar el quiz del capítulo N desbloquea el capítulo N+1.
	let desbloqueado: number | null = null;
	if (passed) {
		const [siguiente] = await db
			.select({ id: schema.chapters.id, number: schema.chapters.number })
			.from(schema.chapters)
			.where(eq(schema.chapters.number, numero + 1))
			.limit(1);

		if (siguiente) {
			await otorgarDesbloqueo(db, user.id, siguiente.id, "quiz");
			desbloqueado = siguiente.number;
		}
	}

	return {
		score,
		passed,
		aciertos,
		totalPreguntas: preguntas.length,
		passingScore: quiz.passingScore,
		feedback,
		desbloqueado,
	};
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function Quiz({ loaderData }: Route.ComponentProps) {
	const { user, capitulo, preguntas, passingScore, siguiente } = loaderData;
	const fetcher = useFetcher<typeof action>();

	const [resultado, setResultado] = useState<ResultadoQuiz | null>(null);
	const [indice, setIndice] = useState(0);
	const [respuestas, setRespuestas] = useState<Record<number, number>>({});

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

	function enviar() {
		fetcher.submit(
			{ respuestas: JSON.stringify(respuestas) },
			{ method: "post" },
		);
	}

	function reiniciar() {
		setResultado(null);
		setRespuestas({});
		setIndice(0);
		window.scrollTo({ top: 0 });
	}

	if (resultado) {
		return (
			<Resultado
				user={user}
				capituloNumero={capitulo.number}
				capituloTitulo={capitulo.title}
				resultado={resultado}
				preguntas={preguntas}
				siguienteNumero={
					resultado.desbloqueado ?? (siguiente ? siguiente.number : null)
				}
				onReintentar={reiniciar}
			/>
		);
	}

	if (total === 0) {
		return (
			<>
				<Nav user={user} />
				<main className="mx-auto max-w-2xl px-5 py-24 text-center">
					<p className="text-[var(--color-tinta-2)]">
						Este quiz todavía no tiene preguntas.
					</p>
					<Link
						to={`/libro/capitulo/${capitulo.number}`}
						className="jc-btn mt-6"
					>
						Volver al capítulo
					</Link>
				</main>
			</>
		);
	}

	const seleccionada = respuestas[pregunta.id];
	const esUltima = indice === total - 1;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-3xl px-5 py-10">
				<header className="mb-8">
					<Link
						to={`/libro/capitulo/${capitulo.number}`}
						className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
					>
						← salir del quiz
					</Link>
					<h1 className="jc-display jc-grad mt-4 text-3xl">
						🎯 Quiz — {capitulo.title}
					</h1>
					<p className="jc-mono mt-2 text-xs text-[var(--color-tinta-2)]">
						necesitas {passingScore} puntos para aprobar · intentos ilimitados
					</p>

					<div className="mt-6">
						<BarraProgreso
							valor={indice + 1}
							total={total}
							etiqueta={`Pregunta ${indice + 1} de ${total}`}
						/>
					</div>
				</header>

				<section key={pregunta.id} className="jc-anim-slide jc-glass p-7">
					<h2 className="jc-display text-xl leading-snug">{pregunta.prompt}</h2>

					{pregunta.codeSnippet && (
						<div className="mt-5">
							<BloqueCodigo codigo={pregunta.codeSnippet} />
						</div>
					)}

					<div className="mt-6 space-y-3">
						{pregunta.opciones.map((op) => {
							const activa = seleccionada === op.id;
							return (
								<button
									key={op.id}
									type="button"
									onClick={() =>
										setRespuestas((r) => ({ ...r, [pregunta.id]: op.id }))
									}
									className={`flex w-full items-start gap-3 rounded-2xl border p-4 text-left transition ${
										activa
											? "border-[rgba(0,229,255,.6)] bg-[rgba(0,229,255,.09)]"
											: "border-[var(--color-borde)] bg-white/[0.03] hover:border-white/25 hover:bg-white/[0.06]"
									}`}
								>
									<span
										className={`jc-mono grid h-7 w-7 shrink-0 place-items-center rounded-lg border text-xs uppercase ${
											activa
												? "border-transparent bg-[var(--color-cyan)] text-[#08131a]"
												: "border-[var(--color-borde)] text-[var(--color-tinta-2)]"
										}`}
									>
										{op.label}
									</span>
									<span className="flex-1">{op.text}</span>
								</button>
							);
						})}
					</div>
				</section>

				<div className="mt-7 flex items-center justify-between gap-4">
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
							disabled={enviando || Object.keys(respuestas).length !== total}
						>
							{enviando ? "Calificando…" : "Enviar respuestas ✅"}
						</button>
					) : (
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={() => setIndice((i) => Math.min(total - 1, i + 1))}
							disabled={seleccionada === undefined}
						>
							Siguiente →
						</button>
					)}
				</div>

				<p className="jc-mono mt-5 text-center text-xs text-[var(--color-tinta-2)]">
					{Object.keys(respuestas).length}/{total} respondidas
				</p>
			</main>
		</>
	);
}

/* -------------------------------------------------------------------------- */

function Resultado({
	user,
	capituloNumero,
	capituloTitulo,
	resultado,
	preguntas,
	siguienteNumero,
	onReintentar,
}: {
	user: Route.ComponentProps["loaderData"]["user"];
	capituloNumero: number;
	capituloTitulo: string;
	resultado: ResultadoQuiz;
	preguntas: PreguntaPublica[];
	siguienteNumero: number | null;
	onReintentar: () => void;
}) {
	const { score, passed, aciertos, totalPreguntas, feedback } = resultado;

	return (
		<>
			<Nav user={user} />
			<Confetti activo={passed} />

			<main className="mx-auto max-w-3xl px-5 py-12">
				<div className="jc-anim-pop jc-glass flex flex-col items-center p-10 text-center">
					<ScoreAnimado score={score} aprobado={passed} />

					<h1 className="jc-display mt-6 text-4xl">
						{passed ? "¡Aprobaste! 🎉" : "Casi… 💪"}
					</h1>
					<p className="mt-3 text-[var(--color-tinta-2)]">
						{aciertos} de {totalPreguntas} correctas · necesitabas{" "}
						{resultado.passingScore} puntos
					</p>

					{passed && siguienteNumero && (
						<p className="jc-mono mt-4 text-sm text-[var(--color-verde)]">
							🔓 Capítulo {siguienteNumero} desbloqueado
						</p>
					)}

					<div className="mt-8 flex flex-wrap justify-center gap-3">
						{passed && siguienteNumero ? (
							<Link
								to={`/libro/capitulo/${siguienteNumero}`}
								className="jc-btn jc-btn-verde text-lg"
							>
								Ir al capítulo siguiente 🚀
							</Link>
						) : passed ? (
							<Link to="/libro" className="jc-btn jc-btn-verde text-lg">
								Volver al libro 📚
							</Link>
						) : (
							<>
								<Link
									to={`/libro/capitulo/${capituloNumero}`}
									className="jc-btn jc-btn-ghost"
								>
									📖 Repasar capítulo
								</Link>
								<button
									type="button"
									className="jc-btn jc-btn-primary"
									onClick={onReintentar}
								>
									🔁 Reintentar quiz
								</button>
							</>
						)}
					</div>
				</div>

				{/* Feedback pregunta por pregunta ------------------------------- */}
				<section className="mt-12">
					<h2 className="jc-display text-2xl">Revisión</h2>
					<p className="mt-1 text-sm text-[var(--color-tinta-2)]">
						{capituloTitulo}
					</p>

					<div className="mt-6 space-y-5">
						{feedback.map((f, i) => {
							const pregunta = preguntas.find((p) => p.id === f.questionId);
							return (
								<article
									key={f.questionId}
									className={`rounded-2xl border p-6 ${
										f.acerto
											? "border-[rgba(52,224,122,.4)] bg-[rgba(52,224,122,.06)]"
											: "border-[rgba(255,77,255,.35)] bg-[rgba(255,77,255,.05)]"
									}`}
								>
									<div className="flex items-start gap-3">
										<span className="text-xl">{f.acerto ? "✅" : "❌"}</span>
										<h3 className="jc-display flex-1 text-lg leading-snug">
											{i + 1}. {f.prompt}
										</h3>
									</div>

									{pregunta?.codeSnippet && (
										<div className="mt-4">
											<BloqueCodigo codigo={pregunta.codeSnippet} />
										</div>
									)}

									<ul className="mt-4 space-y-2 text-sm">
										{pregunta?.opciones.map((op) => {
											const esCorrecta = op.id === f.correcta;
											const esTuya = op.id === f.seleccionada;
											return (
												<li
													key={op.id}
													className={`flex items-start gap-2 rounded-xl border px-3 py-2 ${
														esCorrecta
															? "border-[rgba(52,224,122,.5)] text-[var(--color-verde)]"
															: esTuya
																? "border-[rgba(255,77,255,.5)] text-[var(--color-magenta)]"
																: "border-transparent text-[var(--color-tinta-2)]"
													}`}
												>
													<span className="jc-mono w-4 shrink-0 uppercase">
														{op.label}
													</span>
													<span className="flex-1">{op.text}</span>
													{esCorrecta && (
														<span className="jc-mono text-xs">correcta</span>
													)}
													{esTuya && !esCorrecta && (
														<span className="jc-mono text-xs">tu elección</span>
													)}
												</li>
											);
										})}
									</ul>
								</article>
							);
						})}
					</div>
				</section>
			</main>
		</>
	);
}
