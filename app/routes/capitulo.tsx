import { and, asc, eq } from "drizzle-orm";
import { Link, redirect } from "react-router";
import { Nav } from "~/components/nav";
import { ProbarCodigo } from "~/components/probar-codigo";
import { TraceStepper } from "~/components/trace-stepper";
import { BadgeDificultad, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import type { Exercise } from "~/db/schema";
import { requireUser } from "~/lib/auth.server";
import { leerTests, modoCodigoActivo } from "~/lib/piston.server";
import { cargarLibro } from "~/lib/progress.server";
import {
	palabraCapitulo,
	puedeVerTrack,
	rutaCapitulo,
	rutaLibro,
	rutaQuiz,
	trackDeRuta,
	tracksVisibles,
} from "~/lib/tracks";
import { aPelicula } from "~/lib/traces";
import type { Route } from "./+types/capitulo";

export const meta: Route.MetaFunction = ({ data }) => [
	{
		title: data
			? `${data.capitulo.number}. ${data.capitulo.title} — El Libro JuanCode`
			: "El Libro JuanCode",
	},
];

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const numero = Number(params.number);
	if (!Number.isInteger(numero)) throw redirect(rutaLibro(trackDeRuta(request.url)));

	const esProfesor = user.role === "teacher";

	const track = trackDeRuta(request.url);
	if (!puedeVerTrack(user.track, track, esProfesor)) {
		throw redirect(rutaLibro(tracksVisibles(user.track)[0]));
	}

	const { capitulos } = await cargarLibro(db, user.id, esProfesor, track);
	const capitulo = capitulos.find((c) => c.number === numero);

	// Bloqueado o inexistente -> de vuelta al índice con aviso.
	if (!capitulo || capitulo.estado === "bloqueado") {
		throw redirect(
			`${rutaLibro(track)}?toast=${encodeURIComponent(
				"Aprueba el quiz del capítulo anterior 🔒",
			)}`,
		);
	}

	const [ejercicios, quiz, peliculas] = await Promise.all([
		db
			.select()
			.from(schema.exercises)
			.where(eq(schema.exercises.chapterId, capitulo.id))
			.orderBy(asc(schema.exercises.orden), asc(schema.exercises.id)),
		db
			.select({ id: schema.quizzes.id })
			.from(schema.quizzes)
			.where(eq(schema.quizzes.chapterId, capitulo.id))
			.limit(1),
		db
			.select()
			.from(schema.traceDemos)
			.where(
				and(
					eq(schema.traceDemos.chapterId, capitulo.id),
					eq(schema.traceDemos.active, true),
				),
			)
			.orderBy(asc(schema.traceDemos.orden), asc(schema.traceDemos.id)),
	]);

	const [aprobado] = await db
		.select({ id: schema.quizAttempts.id })
		.from(schema.quizAttempts)
		.where(
			and(
				eq(schema.quizAttempts.userId, user.id),
				eq(schema.quizAttempts.quizId, quiz[0]?.id ?? -1),
				eq(schema.quizAttempts.passed, true),
			),
		)
		.limit(1);

	return {
		user,
		track,
		capitulo,
		capitulos,
		modoCodigo: modoCodigoActivo(env),
		ejercicios: ejercicios.map((e) => ({
			...e,
			// El cliente sabe si HAY tests, nunca cuáles son.
			tieneTests: leerTests(e.testsJson).length > 0,
			testsJson: null,
		})),
		peliculas: peliculas.map(aPelicula),
		tieneQuiz: quiz.length > 0,
		yaAprobado: Boolean(aprobado),
		siguiente: capitulos.find((c) => c.number === numero + 1) ?? null,
	};
}

export default function Capitulo({ loaderData }: Route.ComponentProps) {
	const {
		user,
		track,
		capitulo,
		capitulos,
		ejercicios,
		peliculas,
		tieneQuiz,
		yaAprobado,
		siguiente,
		modoCodigo,
	} = loaderData;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<div className="mx-auto flex max-w-[1400px] gap-10 px-5 py-10">
				{/* Sidebar ------------------------------------------------------- */}
				<aside className="sticky top-24 hidden h-[calc(100dvh-8rem)] w-72 shrink-0 overflow-y-auto pr-2 lg:block">
					<p className="jc-mono mb-3 text-[0.66rem] tracking-[0.24em] text-[var(--color-tinta-2)] uppercase">
						{track === "avanzado" ? "🚀 Track avanzado" : "Índice del libro"}
					</p>
					<ul className="space-y-1">
						{capitulos.map((c) => {
							const bloqueado = c.estado === "bloqueado";
							const actual = c.id === capitulo.id;
							const clase = `flex items-center gap-2 rounded-xl px-3 py-2 text-sm transition ${
								actual
									? "bg-white/10 text-[var(--color-cyan)]"
									: bloqueado
										? "text-[var(--color-tinta-2)] opacity-50"
										: "text-[var(--color-tinta-2)] hover:bg-white/5 hover:text-[var(--color-tinta)]"
							}`;

							const inner = (
								<>
									<span className="jc-mono w-6 shrink-0 text-right text-xs opacity-70">
										{c.number}
									</span>
									<span className="shrink-0">
										{bloqueado
											? "🔒"
											: c.estado === "completado"
												? "✅"
												: c.emoji}
									</span>
									<span className="truncate">{c.title}</span>
								</>
							);

							return (
								<li key={c.id}>
									{bloqueado ? (
										<span className={`${clase} cursor-not-allowed`}>{inner}</span>
									) : (
										<Link to={rutaCapitulo(track, c.number)} className={clase}>
											{inner}
										</Link>
									)}
								</li>
							);
						})}
					</ul>
				</aside>

				{/* Lector -------------------------------------------------------- */}
				<main className="jc-anim-in mx-auto w-full max-w-[800px] min-w-0">
					<Link
						to={rutaLibro(track)}
						className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
					>
						← índice
					</Link>

					<header className="mt-5 border-b border-[var(--color-borde)] pb-8">
						<div className="flex flex-wrap items-center gap-3">
							<p
								className={`jc-mono text-xs tracking-[0.26em] uppercase ${
									track === "avanzado"
										? "text-[var(--color-magenta)]"
										: "text-[var(--color-cyan)]"
								}`}
							>
								{palabraCapitulo(track)} {capitulo.number}
							</p>
							{track === "avanzado" && (
								<span className="jc-mono rounded-full border border-[rgba(255,77,255,.4)] bg-[rgba(255,77,255,.12)] px-2.5 py-0.5 text-[0.62rem] tracking-[0.16em] text-[var(--color-magenta)] uppercase">
									🚀 Avanzado
								</span>
							)}
						</div>
						<h1 className="jc-display jc-grad mt-3 text-5xl">
							{capitulo.emoji} {capitulo.title}
						</h1>
						{capitulo.description && (
							<p className="mt-4 text-[var(--color-tinta-2)]">
								{capitulo.description}
							</p>
						)}
						{!capitulo.published && (
							<p className="jc-mono mt-4 inline-block rounded-full border border-[rgba(255,169,77,.4)] bg-[rgba(255,169,77,.1)] px-3 py-1 text-xs text-[var(--color-naranja)]">
								borrador — solo lo ves porque eres el profe
							</p>
						)}
					</header>

					{capitulo.contentHtml ? (
						<article
							className="jc-prosa mt-10"
							// El HTML lo escribe el profesor desde /admin.
							dangerouslySetInnerHTML={{ __html: capitulo.contentHtml }}
						/>
					) : (
						<p className="mt-10 rounded-2xl border border-dashed border-[var(--color-borde)] p-8 text-center text-[var(--color-tinta-2)]">
							Este capítulo todavía se está escribiendo ✍️
						</p>
					)}

					{/* La película en vivo ---------------------------------------- */}
					{peliculas.length > 0 && (
						<section className="mt-16">
							<h2 className="jc-display text-3xl">
								🎬 La película en vivo
							</h2>
							<p className="mt-2 text-[var(--color-tinta-2)]">
								Mira las variables en directo.{" "}
								<strong className="text-[var(--color-dorado)]">
									Intenta predecir cada fila ANTES de darle al botón.
								</strong>
							</p>
							<div className="mt-6 space-y-6">
								{peliculas.map((p) => (
									<TraceStepper key={p.id} pelicula={p} />
								))}
							</div>
						</section>
					)}

					{/* Ejercicios ------------------------------------------------- */}
					{ejercicios.length > 0 && (
						<section className="mt-16">
							<h2 className="jc-display text-3xl">🏋️ Ejercicios</h2>
							<div className="mt-6 space-y-5">
								{ejercicios.map((ej, i) => (
									<CardEjercicio
										key={ej.id}
										ejercicio={ej}
										indice={i + 1}
										modoCodigo={modoCodigo}
									/>
								))}
							</div>
						</section>
					)}

					{/* Quiz ------------------------------------------------------- */}
					<section className="mt-16 text-center">
						{tieneQuiz ? (
							<div className="jc-glass p-8">
								<h2 className="jc-display text-2xl">
									{yaAprobado
										? "Ya aprobaste este quiz ✅"
										: "¿Listo para el quiz?"}
								</h2>
								<p className="mt-2 text-sm text-[var(--color-tinta-2)]">
									{yaAprobado
										? "Puedes repetirlo las veces que quieras."
										: "Apruébalo y desbloqueas el siguiente capítulo. Intentos ilimitados."}
								</p>
								<Link
									to={rutaQuiz(track, capitulo.number)}
									className="jc-btn jc-btn-primary mt-6 text-lg"
								>
									🎯 Presentar quiz del capítulo
								</Link>
							</div>
						) : (
							<p className="text-sm text-[var(--color-tinta-2)]">
								Este capítulo aún no tiene quiz.
							</p>
						)}

						{siguiente && siguiente.estado !== "bloqueado" && (
							<Link
								to={rutaCapitulo(track, siguiente.number)}
								className="jc-btn jc-btn-ghost mt-6"
							>
								Siguiente: {siguiente.emoji} {siguiente.title} →
							</Link>
						)}
					</section>
				</main>
			</div>
		</>
	);
}

type EjercicioLector = Omit<Exercise, "testsJson"> & { tieneTests: boolean };

function CardEjercicio({
	ejercicio,
	indice,
	modoCodigo,
}: {
	ejercicio: EjercicioLector;
	indice: number;
	modoCodigo: boolean;
}) {
	return (
		<article className="jc-glass p-6">
			<div className="flex items-center gap-3">
				<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
					#{indice}
				</span>
				<h3 className="jc-display flex-1 text-lg">{ejercicio.title}</h3>
				<BadgeDificultad nivel={ejercicio.difficulty} />
			</div>

			{ejercicio.statementHtml && (
				<div
					className="jc-prosa mt-4 text-[1rem]"
					dangerouslySetInnerHTML={{ __html: ejercicio.statementHtml }}
				/>
			)}

			{/* Modo Código: correr el ejercicio contra sus tests */}
			{modoCodigo && ejercicio.tieneTests && (
				<details className="mt-5">
					<summary className="jc-btn jc-btn-sm list-none marker:content-none">
						▶ Probar mi código
					</summary>
					<div className="mt-4">
						<ProbarCodigo
							exerciseId={ejercicio.id}
							codigoInicial={ejercicio.starterCode ?? ""}
						/>
					</div>
				</details>
			)}

			<div className="mt-5 flex flex-wrap gap-3">
				{ejercicio.hintHtml && (
					<Desplegable etiqueta="💡 Ver pista" html={ejercicio.hintHtml} />
				)}
				{ejercicio.solutionHtml && (
					<Desplegable
						etiqueta="✅ Ver solución"
						html={ejercicio.solutionHtml}
					/>
				)}
			</div>
		</article>
	);
}

function Desplegable({ etiqueta, html }: { etiqueta: string; html: string }) {
	return (
		<details className="group w-full">
			<summary className="jc-btn jc-btn-sm jc-btn-ghost list-none marker:content-none">
				{etiqueta}
			</summary>
			<div
				className="jc-prosa jc-anim-in mt-3 rounded-2xl border border-[var(--color-borde)] bg-black/30 p-5 text-[1rem]"
				dangerouslySetInnerHTML={{ __html: html }}
			/>
		</details>
	);
}
