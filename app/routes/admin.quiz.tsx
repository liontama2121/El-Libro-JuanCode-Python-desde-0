import { asc, eq, inArray } from "drizzle-orm";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Aviso, Vacio } from "~/components/admin";
import { BloqueCodigo } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import type { Route } from "./+types/admin.quiz";

export const meta: Route.MetaFunction = ({ data }) => [
	{ title: data ? `Quiz — ${data.capitulo.title}` : "Quiz — Panel del profe" },
];

const LABELS = ["a", "b", "c", "d"] as const;

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

	let [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.chapterId, chapterId))
		.limit(1);

	// El quiz se crea vacío la primera vez que el profe abre esta pantalla.
	if (!quiz) {
		const [creado] = await db
			.insert(schema.quizzes)
			.values({ chapterId, passingScore: 80 })
			.returning();
		quiz = creado;
	}

	const preguntas = await db
		.select()
		.from(schema.questions)
		.where(eq(schema.questions.quizId, quiz.id))
		.orderBy(asc(schema.questions.orden), asc(schema.questions.id));

	const opciones = preguntas.length
		? await db
				.select()
				.from(schema.options)
				.where(
					inArray(
						schema.options.questionId,
						preguntas.map((p) => p.id),
					),
				)
				.orderBy(asc(schema.options.label))
		: [];

	const idEditar = Number(new URL(request.url).searchParams.get("q"));
	const editando = preguntas.find((p) => p.id === idEditar) ?? null;

	return {
		user,
		capitulo,
		quiz,
		preguntas: preguntas.map((p) => ({
			...p,
			opciones: opciones.filter((o) => o.questionId === p.id),
		})),
		editando: editando
			? {
					...editando,
					opciones: opciones.filter((o) => o.questionId === editando.id),
				}
			: null,
	};
}

export async function action({
	context,
	request,
	params,
}: Route.ActionArgs): Promise<{ error?: string } | Response> {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const chapterId = Number(params.id);
	const form = await request.formData();
	const intent = String(form.get("intent") || "");

	const [quiz] = await db
		.select()
		.from(schema.quizzes)
		.where(eq(schema.quizzes.chapterId, chapterId))
		.limit(1);

	if (!quiz) throw redirect(`/admin/capitulo/${chapterId}/quiz`);

	if (intent === "passing") {
		const valor = Math.min(100, Math.max(0, Number(form.get("passingScore"))));
		await db
			.update(schema.quizzes)
			.set({ passingScore: Number.isFinite(valor) ? valor : 80 })
			.where(eq(schema.quizzes.id, quiz.id));
		return redirect(`/admin/capitulo/${chapterId}/quiz`);
	}

	if (intent === "eliminar") {
		const id = Number(form.get("id"));
		if (Number.isInteger(id) && id > 0) {
			await db.delete(schema.options).where(eq(schema.options.questionId, id));
			await db.delete(schema.questions).where(eq(schema.questions.id, id));
		}
		return redirect(`/admin/capitulo/${chapterId}/quiz`);
	}

	// Guardar pregunta + sus 4 opciones ------------------------------------
	const id = Number(form.get("id"));
	const prompt = String(form.get("prompt") || "").trim();
	const codeSnippet = String(form.get("codeSnippet") || "").trim();
	const orden = Number(form.get("orden")) || 1;
	const correcta = String(form.get("correcta") || "a");

	if (!prompt) return { error: "La pregunta necesita un enunciado." };

	const textos = LABELS.map((l) => String(form.get(`opcion_${l}`) || "").trim());
	if (textos.some((t) => !t)) {
		return { error: "Escribe las cuatro opciones (a, b, c, d)." };
	}
	if (!LABELS.includes(correcta as (typeof LABELS)[number])) {
		return { error: "Marca cuál opción es la correcta." };
	}

	let questionId = id;
	if (Number.isInteger(id) && id > 0) {
		await db
			.update(schema.questions)
			.set({ prompt, codeSnippet: codeSnippet || null, orden })
			.where(eq(schema.questions.id, id));
		await db.delete(schema.options).where(eq(schema.options.questionId, id));
	} else {
		const [creada] = await db
			.insert(schema.questions)
			.values({
				quizId: quiz.id,
				prompt,
				codeSnippet: codeSnippet || null,
				orden,
			})
			.returning({ id: schema.questions.id });
		questionId = creada.id;
	}

	await db.insert(schema.options).values(
		LABELS.map((label, i) => ({
			questionId,
			label,
			text: textos[i],
			isCorrect: label === correcta,
		})),
	);

	return redirect(`/admin/capitulo/${chapterId}/quiz`);
}

export default function AdminQuiz({
	loaderData,
	actionData,
}: Route.ComponentProps) {
	const { user, capitulo, quiz, preguntas, editando } = loaderData;
	const nuevo = !editando;
	const error =
		actionData && "error" in actionData ? actionData.error : undefined;

	const opcionDe = (label: string) =>
		editando?.opciones.find((o) => o.label === label)?.text ?? "";
	const correctaActual =
		editando?.opciones.find((o) => o.isCorrect)?.label ?? "a";

	return (
		<AdminShell
			user={user}
			titulo={`🎯 Quiz — ${capitulo.title}`}
			descripcion={`Capítulo ${capitulo.number} · ${preguntas.length} preguntas`}
			acciones={
				<div className="flex gap-2">
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
				</div>
			}
		>
			{/* Nota de aprobación ------------------------------------------------ */}
			<Form
				method="post"
				className="jc-glass mb-8 flex flex-wrap items-end gap-4 p-5"
			>
				<input type="hidden" name="intent" value="passing" />
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

			<div className="grid gap-8 lg:grid-cols-[1fr_minmax(0,1.1fr)]">
				{/* Lista de preguntas --------------------------------------------- */}
				<div className="space-y-3">
					{preguntas.length === 0 && (
						<Vacio>Este quiz todavía no tiene preguntas.</Vacio>
					)}

					{preguntas.map((p) => (
						<article
							key={p.id}
							className={`rounded-xl border p-4 ${
								editando?.id === p.id
									? "border-[rgba(0,229,255,.5)] bg-[rgba(0,229,255,.07)]"
									: "border-[var(--color-borde)] bg-white/[0.03]"
							}`}
						>
							<div className="flex items-start gap-3">
								<span className="jc-mono w-5 text-right text-xs text-[var(--color-tinta-2)]">
									{p.orden}
								</span>
								<Link
									to={`/admin/capitulo/${capitulo.id}/quiz?q=${p.id}`}
									className="flex-1 text-sm hover:text-[var(--color-cyan)]"
								>
									{p.prompt}
								</Link>
								<Form
									method="post"
									onSubmit={(ev) => {
										if (!confirm("¿Eliminar esta pregunta?")) ev.preventDefault();
									}}
								>
									<input type="hidden" name="intent" value="eliminar" />
									<input type="hidden" name="id" value={p.id} />
									<button
										type="submit"
										className="jc-btn jc-btn-sm jc-btn-ghost text-[var(--color-magenta)]"
									>
										🗑️
									</button>
								</Form>
							</div>

							{p.codeSnippet && (
								<div className="mt-3 ml-8">
									<BloqueCodigo codigo={p.codeSnippet} />
								</div>
							)}

							<ul className="mt-3 ml-8 space-y-1 text-xs">
								{p.opciones.map((o) => (
									<li
										key={o.id}
										className={
											o.isCorrect
												? "text-[var(--color-verde)]"
												: "text-[var(--color-tinta-2)]"
										}
									>
										<span className="jc-mono uppercase">{o.label})</span>{" "}
										{o.text}
										{o.isCorrect && " ✅"}
									</li>
								))}
							</ul>
						</article>
					))}

					{!nuevo && (
						<Link
							to={`/admin/capitulo/${capitulo.id}/quiz`}
							className="jc-btn jc-btn-primary mt-2"
						>
							+ Nueva pregunta
						</Link>
					)}
				</div>

				{/* Editor de pregunta --------------------------------------------- */}
				<Form
					method="post"
					key={editando?.id ?? "nueva"}
					className="jc-glass h-fit p-6"
				>
					<input type="hidden" name="id" value={editando?.id ?? 0} />

					<h2 className="jc-display text-xl">
						{nuevo ? "➕ Nueva pregunta" : "✏️ Editar pregunta"}
					</h2>

					<div className="mt-5 grid gap-4 sm:grid-cols-[90px_1fr]">
						<div>
							<label className="jc-label" htmlFor="orden">
								Orden
							</label>
							<input
								id="orden"
								name="orden"
								type="number"
								min={1}
								className="jc-input jc-mono"
								defaultValue={editando?.orden ?? preguntas.length + 1}
							/>
						</div>
						<div>
							<label className="jc-label" htmlFor="prompt">
								Enunciado
							</label>
							<input
								id="prompt"
								name="prompt"
								className="jc-input"
								defaultValue={editando?.prompt ?? ""}
								required
							/>
						</div>
					</div>

					<div className="mt-4">
						<label className="jc-label" htmlFor="codeSnippet">
							Código (opcional)
						</label>
						<textarea
							id="codeSnippet"
							name="codeSnippet"
							rows={6}
							className="jc-input jc-mono text-sm"
							defaultValue={editando?.codeSnippet ?? ""}
							placeholder={"x = 5\nprint(type(x))"}
						/>
						<p className="mt-2 text-xs text-[var(--color-tinta-2)]">
							Se muestra como bloque de código encima de las opciones.
						</p>
					</div>

					<fieldset className="mt-6">
						<legend className="jc-label">Opciones (marca la correcta)</legend>
						<div className="space-y-3">
							{LABELS.map((label) => (
								<div key={label} className="flex items-center gap-3">
									<label className="flex items-center gap-2">
										<input
											type="radio"
											name="correcta"
											value={label}
											defaultChecked={correctaActual === label}
											className="h-4 w-4 accent-[var(--color-verde)]"
										/>
										<span className="jc-mono w-4 text-sm uppercase">
											{label}
										</span>
									</label>
									<input
										name={`opcion_${label}`}
										className="jc-input"
										defaultValue={opcionDe(label)}
										required
									/>
								</div>
							))}
						</div>
					</fieldset>

					{error && (
						<div className="mt-4">
							<Aviso tipo="error">{error}</Aviso>
						</div>
					)}

					<button
						type="submit"
						name="intent"
						value="guardar"
						className="jc-btn jc-btn-primary mt-6"
					>
						{nuevo ? "Crear pregunta" : "Guardar cambios"}
					</button>
				</Form>
			</div>
		</AdminShell>
	);
}
