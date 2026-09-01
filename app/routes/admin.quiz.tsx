import { and, asc, eq, sql } from "drizzle-orm";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Tabla, Vacio } from "~/components/admin";
import { NOMBRE_TIPO } from "~/components/pregunta";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import type { Route } from "./+types/admin.quiz";

export const meta: Route.MetaFunction = ({ data }) => [
	{ title: data ? `Quiz — ${data.capitulo.title}` : "Quiz — Panel del profe" },
];

/** Las que puede sacar el quiz oficial del capítulo. */
const TIPOS_DEL_QUIZ = ["mcq", "predict_output"] as const;

/* -------------------------------------------------------------------------- */

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const chapterId = Number(params.id);
	const [capitulo] = await db
		.select()
		.from(schema.chapters)
		.where(eq(schema.chapters.id, chapterId))
		.limit(1);

	if (!capitulo) throw redirect("/admin/capitulos");

	// El quiz del capítulo se crea vacío la primera vez que se abre esta pantalla.
	let [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.chapterId, chapterId))
		.limit(1);

	if (!quiz) {
		const [creado] = await db
			.insert(schema.quizzes)
			.values({ chapterId, passingScore: 80 })
			.returning();
		quiz = creado;
	}

	const preguntas = await db
		.select({
			id: schema.questionBank.id,
			type: schema.questionBank.type,
			difficulty: schema.questionBank.difficulty,
			prompt: schema.questionBank.prompt,
			active: schema.questionBank.active,
			source: schema.questionBank.source,
		})
		.from(schema.questionBank)
		.where(eq(schema.questionBank.chapterId, chapterId))
		.orderBy(asc(schema.questionBank.id));

	const [{ disponibles }] = await db
		.select({ disponibles: sql<number>`count(*)` })
		.from(schema.questionBank)
		.where(
			and(
				eq(schema.questionBank.chapterId, chapterId),
				eq(schema.questionBank.active, true),
				sql`${schema.questionBank.type} IN ('mcq', 'predict_output')`,
			),
		);

	return {
		user,
		capitulo,
		quiz,
		preguntas,
		disponibles: Number(disponibles) || 0,
	};
}

export async function action({ context, request, params }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const chapterId = Number(params.id);
	const form = await request.formData();
	const valor = Math.min(100, Math.max(0, Number(form.get("passingScore"))));

	await db
		.update(schema.quizzes)
		.set({ passingScore: Number.isFinite(valor) ? valor : 80 })
		.where(eq(schema.quizzes.chapterId, chapterId));

	return redirect(
		`/admin/capitulo/${chapterId}/quiz?toast=${encodeURIComponent("Puntaje guardado ✅")}`,
	);
}

/* -------------------------------------------------------------------------- */

export default function AdminQuiz({ loaderData }: Route.ComponentProps) {
	const { user, capitulo, quiz, preguntas, disponibles } = loaderData;

	return (
		<AdminShell
			user={user}
			titulo={`🎯 Quiz — ${capitulo.title}`}
			descripcion={`Capítulo ${capitulo.number}`}
			acciones={
				<div className="flex flex-wrap gap-2">
					<Link
						to={`/admin/capitulos?id=${capitulo.id}`}
						className="jc-btn jc-btn-ghost"
					>
						← Capítulo
					</Link>
					<Link
						to={`/admin/capitulo/${capitulo.id}/ejercicios`}
						className="jc-btn jc-btn-ghost"
					>
						🏋️ Ejercicios
					</Link>
					<Link
						to={`/admin/banco?cap=${capitulo.id}`}
						className="jc-btn jc-btn-primary"
					>
						🏦 Editar el banco
					</Link>
				</div>
			}
		>
			{/* Cómo funciona ---------------------------------------------------- */}
			<div className="jc-glass mb-8 p-5 sm:p-6">
				<h2 className="jc-display text-xl">Cómo se arma este quiz</h2>
				<p className="mt-2 text-sm text-[var(--color-tinta-2)]">
					El quiz oficial ya no tiene preguntas fijas: en cada intento saca{" "}
					<strong>5 al azar</strong> del banco de este capítulo, entre las de tipo{" "}
					{TIPOS_DEL_QUIZ.map((t) => NOMBRE_TIPO[t]).join(" y ")}. Así repetirlo no es
					memorizar el orden. Las preguntas se escriben en{" "}
					<Link className="text-[var(--color-cyan)] underline" to={`/admin/banco?cap=${capitulo.id}`}>
						el banco
					</Link>
					.
				</p>
				<p
					className={`jc-mono mt-3 text-sm ${
						disponibles >= 5 ? "text-[var(--color-verde)]" : "text-[var(--color-naranja)]"
					}`}
				>
					{disponibles} preguntas disponibles para el quiz
					{disponibles < 5 && " — se necesitan al menos 5"}
				</p>
			</div>

			{/* Nota de aprobación ----------------------------------------------- */}
			<Form method="post" className="jc-glass mb-8 flex flex-wrap items-end gap-4 p-5">
				<div>
					<label className="jc-label" htmlFor="passingScore">
						Puntaje mínimo para aprobar
					</label>
					<input
						id="passingScore"
						name="passingScore"
						type="number"
						min={0}
						max={100}
						className="jc-input jc-mono w-28"
						defaultValue={quiz.passingScore}
					/>
				</div>
				<button type="submit" className="jc-btn jc-btn-sm">
					Guardar
				</button>
				<p className="text-xs text-[var(--color-tinta-2)]">
					Aprobar este quiz desbloquea el capítulo {capitulo.number + 1}.
				</p>
			</Form>

			{/* Banco del capítulo ------------------------------------------------ */}
			<h2 className="jc-display mb-4 text-2xl">Banco de este capítulo</h2>

			{preguntas.length === 0 ? (
				<Vacio>
					Este capítulo no tiene preguntas todavía.{" "}
					<Link className="text-[var(--color-cyan)] underline" to={`/admin/banco?cap=${capitulo.id}`}>
						Escribe la primera
					</Link>
					.
				</Vacio>
			) : (
				<Tabla cabeceras={["Tipo", "Dif", "Enunciado", "Origen", "Estado"]}>
					{preguntas.map((q) => (
						<tr
							key={q.id}
							className={`border-b border-[var(--color-borde)] last:border-0 ${
								q.active ? "" : "opacity-50"
							}`}
						>
							<td className="px-4 py-3 text-xs">{NOMBRE_TIPO[q.type] ?? q.type}</td>
							<td className="px-4 py-3">
								<span className={`jc-badge jc-badge-${q.difficulty}`}>
									{q.difficulty}
								</span>
							</td>
							<td className="px-4 py-3">
								<Link
									to={`/admin/banco?q=${q.id}`}
									className="line-clamp-2 text-sm hover:text-[var(--color-cyan)]"
								>
									{q.prompt}
								</Link>
							</td>
							<td className="jc-mono px-4 py-3 text-[0.66rem] text-[var(--color-tinta-2)]">
								{q.source === "seed" ? "del libro" : "del profe"}
							</td>
							<td className="px-4 py-3 text-xs">
								{q.active ? "activa" : "inactiva"}
							</td>
						</tr>
					))}
				</Tabla>
			)}
		</AdminShell>
	);
}
