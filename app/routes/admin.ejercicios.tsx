import { asc, eq } from "drizzle-orm";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Aviso, Vacio } from "~/components/admin";
import { BadgeDificultad } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import type { Route } from "./+types/admin.ejercicios";

export const meta: Route.MetaFunction = ({ data }) => [
	{
		title: data
			? `Ejercicios — ${data.capitulo.title}`
			: "Ejercicios — Panel del profe",
	},
];

const DIFICULTADES = ["facil", "medio", "dificil"] as const;

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

	const ejercicios = await db
		.select()
		.from(schema.exercises)
		.where(eq(schema.exercises.chapterId, chapterId))
		.orderBy(asc(schema.exercises.orden), asc(schema.exercises.id));

	const idEditar = Number(new URL(request.url).searchParams.get("ej"));
	const editando = ejercicios.find((e) => e.id === idEditar) ?? null;

	return { user, capitulo, ejercicios, editando };
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
	const intent = String(form.get("intent") || "guardar");
	const id = Number(form.get("id"));

	if (intent === "eliminar") {
		if (Number.isInteger(id) && id > 0) {
			await db.delete(schema.exercises).where(eq(schema.exercises.id, id));
		}
		return redirect(`/admin/capitulo/${chapterId}/ejercicios`);
	}

	const title = String(form.get("title") || "").trim();
	if (!title) return { error: "El ejercicio necesita un título." };

	const datos = {
		chapterId,
		orden: Number(form.get("orden")) || 1,
		title,
		difficulty: DIFICULTADES.includes(
			String(form.get("difficulty")) as (typeof DIFICULTADES)[number],
		)
			? String(form.get("difficulty"))
			: "facil",
		statementHtml: String(form.get("statementHtml") || ""),
		hintHtml: String(form.get("hintHtml") || ""),
		solutionHtml: String(form.get("solutionHtml") || ""),
	};

	if (Number.isInteger(id) && id > 0) {
		await db
			.update(schema.exercises)
			.set(datos)
			.where(eq(schema.exercises.id, id));
	} else {
		await db.insert(schema.exercises).values(datos);
	}

	return redirect(`/admin/capitulo/${chapterId}/ejercicios`);
}

export default function AdminEjercicios({
	loaderData,
	actionData,
}: Route.ComponentProps) {
	const { user, capitulo, ejercicios, editando } = loaderData;
	const nuevo = !editando;
	const error =
		actionData && "error" in actionData ? actionData.error : undefined;

	return (
		<AdminShell
			user={user}
			titulo={`🏋️ Ejercicios — ${capitulo.title}`}
			descripcion={`Capítulo ${capitulo.number}`}
			acciones={
				<div className="flex gap-2">
					<Link
						to={`/admin/capitulos?id=${capitulo.id}`}
						className="jc-btn jc-btn-ghost"
					>
						← Capítulo
					</Link>
					<Link
						to={`/admin/capitulo/${capitulo.id}/quiz`}
						className="jc-btn jc-btn-ghost"
					>
						🎯 Quiz
					</Link>
				</div>
			}
		>
			<div className="grid gap-8 lg:grid-cols-[1fr_minmax(0,1.2fr)]">
				{/* Lista ---------------------------------------------------------- */}
				<div className="space-y-3">
					{ejercicios.length === 0 && (
						<Vacio>Este capítulo todavía no tiene ejercicios.</Vacio>
					)}
					{ejercicios.map((ej) => (
						<div
							key={ej.id}
							className={`flex items-center gap-3 rounded-xl border px-4 py-3 ${
								editando?.id === ej.id
									? "border-[rgba(0,229,255,.5)] bg-[rgba(0,229,255,.07)]"
									: "border-[var(--color-borde)] bg-white/[0.03]"
							}`}
						>
							<span className="jc-mono w-6 text-right text-xs text-[var(--color-tinta-2)]">
								{ej.orden}
							</span>
							<Link
								to={`/admin/capitulo/${capitulo.id}/ejercicios?ej=${ej.id}`}
								className="flex-1 truncate text-sm hover:text-[var(--color-cyan)]"
							>
								{ej.title}
							</Link>
							<BadgeDificultad nivel={ej.difficulty} />
							<Link
								to={`/admin/ejercicio/${ej.id}`}
								title="Tests y código inicial"
								className="jc-btn jc-btn-sm jc-btn-ghost"
							>
								🧪
							</Link>
							<Form
								method="post"
								onSubmit={(ev) => {
									if (!confirm(`¿Eliminar “${ej.title}”?`)) ev.preventDefault();
								}}
							>
								<input type="hidden" name="intent" value="eliminar" />
								<input type="hidden" name="id" value={ej.id} />
								<button
									type="submit"
									className="jc-btn jc-btn-sm jc-btn-ghost text-[var(--color-magenta)]"
								>
									🗑️
								</button>
							</Form>
						</div>
					))}

					{!nuevo && (
						<Link
							to={`/admin/capitulo/${capitulo.id}/ejercicios`}
							className="jc-btn jc-btn-primary mt-2"
						>
							+ Nuevo ejercicio
						</Link>
					)}
				</div>

				{/* Editor --------------------------------------------------------- */}
				<Form
					method="post"
					key={editando?.id ?? "nuevo"}
					className="jc-glass h-fit p-6"
				>
					<input type="hidden" name="id" value={editando?.id ?? 0} />

					<h2 className="jc-display text-xl">
						{nuevo ? "➕ Nuevo ejercicio" : "✏️ Editar ejercicio"}
					</h2>

					<div className="mt-5 grid gap-4 sm:grid-cols-[90px_1fr_140px]">
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
								defaultValue={editando?.orden ?? ejercicios.length + 1}
							/>
						</div>
						<div>
							<label className="jc-label" htmlFor="title">
								Título
							</label>
							<input
								id="title"
								name="title"
								className="jc-input"
								defaultValue={editando?.title ?? ""}
								required
							/>
						</div>
						<div>
							<label className="jc-label" htmlFor="difficulty">
								Dificultad
							</label>
							<select
								id="difficulty"
								name="difficulty"
								className="jc-input"
								defaultValue={editando?.difficulty ?? "facil"}
							>
								<option value="facil">fácil</option>
								<option value="medio">medio</option>
								<option value="dificil">difícil</option>
							</select>
						</div>
					</div>

					<CampoHtml
						id="statementHtml"
						etiqueta="Enunciado (HTML)"
						valor={editando?.statementHtml ?? ""}
						filas={7}
					/>
					<CampoHtml
						id="hintHtml"
						etiqueta="💡 Pista (HTML)"
						valor={editando?.hintHtml ?? ""}
						filas={5}
					/>
					<CampoHtml
						id="solutionHtml"
						etiqueta="✅ Solución (HTML)"
						valor={editando?.solutionHtml ?? ""}
						filas={9}
					/>

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
						{nuevo ? "Crear ejercicio" : "Guardar cambios"}
					</button>
				</Form>
			</div>
		</AdminShell>
	);
}

function CampoHtml({
	id,
	etiqueta,
	valor,
	filas,
}: {
	id: string;
	etiqueta: string;
	valor: string;
	filas: number;
}) {
	return (
		<div className="mt-4">
			<label className="jc-label" htmlFor={id}>
				{etiqueta}
			</label>
			<textarea
				id={id}
				name={id}
				rows={filas}
				className="jc-input jc-mono text-sm"
				defaultValue={valor}
			/>
		</div>
	);
}
