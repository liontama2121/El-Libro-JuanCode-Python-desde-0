import { asc, eq } from "drizzle-orm";
import { useState } from "react";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Aviso, Vacio } from "~/components/admin";
import { TraceStepper } from "~/components/trace-stepper";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import { aPelicula, validarPelicula } from "~/lib/traces";
import type { Route } from "./+types/admin.peliculas";

export const meta: Route.MetaFunction = ({ data }) => [
	{
		title: data
			? `Películas — ${data.capitulo.title}`
			: "Películas — Panel del profe",
	},
];

const EJEMPLO_COLUMNAS = '["Vuelta", "contador", "¿contador ≤ 5?", "imprime"]';
const EJEMPLO_PASOS = `[
  { "cells": ["antes", "1", "—", "—"], "out": "", "hl": null },
  { "cells": ["1", "1", "✅ SÍ entra", "1"], "out": "1\\n", "hl": 3 }
]`;

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

	const demos = await db
		.select()
		.from(schema.traceDemos)
		.where(eq(schema.traceDemos.chapterId, chapterId))
		.orderBy(asc(schema.traceDemos.orden), asc(schema.traceDemos.id));

	const idEditar = Number(new URL(request.url).searchParams.get("peli"));
	const editando = demos.find((d) => d.id === idEditar) ?? null;

	return { user, capitulo, demos, editando };
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
			await db.delete(schema.traceDemos).where(eq(schema.traceDemos.id, id));
		}
		return redirect(`/admin/capitulo/${chapterId}/peliculas`);
	}

	const title = String(form.get("title") || "").trim();
	if (!title) return { error: "La película necesita un título." };

	const columnsJson = String(form.get("columnsJson") || "[]");
	const stepsJson = String(form.get("stepsJson") || "[]");

	// La validación del cliente es comodidad; esta es la que manda.
	const errores = validarPelicula(columnsJson, stepsJson);
	if (errores.length) {
		return {
			error: errores.map((e) => `${e.campo}: ${e.mensaje}`).join(" · "),
		};
	}

	const datos = {
		chapterId,
		orden: Number(form.get("orden")) || 1,
		title,
		description: String(form.get("description") || "").trim(),
		code: String(form.get("code") || ""),
		columnsJson,
		stepsJson,
		active: form.get("active") === "on",
	};

	if (Number.isInteger(id) && id > 0) {
		await db
			.update(schema.traceDemos)
			.set(datos)
			.where(eq(schema.traceDemos.id, id));
	} else {
		await db.insert(schema.traceDemos).values(datos);
	}

	return redirect(
		`/admin/capitulo/${chapterId}/peliculas?toast=${encodeURIComponent(
			"Película guardada 🎬",
		)}`,
	);
}

/* -------------------------------------------------------------------------- */

export default function AdminPeliculas({
	loaderData,
	actionData,
}: Route.ComponentProps) {
	const { user, capitulo, demos, editando } = loaderData;
	const nuevo = !editando;
	const error =
		actionData && "error" in actionData ? actionData.error : undefined;

	// Estado del formulario: la vista previa se arma con esto en vivo.
	const [title, setTitle] = useState(editando?.title ?? "");
	const [description, setDescription] = useState(editando?.description ?? "");
	const [code, setCode] = useState(editando?.code ?? "");
	const [columnsJson, setColumnsJson] = useState(
		editando?.columnsJson ?? EJEMPLO_COLUMNAS,
	);
	const [stepsJson, setStepsJson] = useState(editando?.stepsJson ?? "[]");

	const errores = validarPelicula(columnsJson, stepsJson);
	const errColumnas = errores.filter((e) => e.campo === "columns_json");
	const errPasos = errores.filter((e) => e.campo === "steps_json");

	// Si el JSON no sirve, la vista previa se queda con lo último válido:
	// aPelicula ya devuelve listas vacías en vez de reventar.
	const vista = aPelicula({
		id: editando?.id ?? 0,
		orden: editando?.orden ?? 1,
		title: title || "Sin título",
		description,
		code,
		columnsJson,
		stepsJson,
	});

	return (
		<AdminShell
			user={user}
			titulo={`🎬 Películas — ${capitulo.title}`}
			descripcion={`Capítulo ${capitulo.number} · pruebas de escritorio interactivas`}
			acciones={
				<div className="flex gap-2">
					<Link
						to={`/admin/capitulos?id=${capitulo.id}`}
						className="jc-btn jc-btn-ghost"
					>
						← Capítulo
					</Link>
					<Link
						to={`/libro/capitulo/${capitulo.number}`}
						className="jc-btn jc-btn-ghost"
					>
						👁️ Ver
					</Link>
				</div>
			}
		>
			<div className="grid gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,1fr)]">
				{/* Lista + formulario -------------------------------------------- */}
				<div className="space-y-4">
					<div className="space-y-3">
						{demos.length === 0 && (
							<Vacio>Este capítulo todavía no tiene películas.</Vacio>
						)}
						{demos.map((d) => (
							<div
								key={d.id}
								className={`flex items-center gap-3 rounded-xl border px-4 py-3 ${
									editando?.id === d.id
										? "border-[rgba(0,229,255,.5)] bg-[rgba(0,229,255,.07)]"
										: "border-[var(--color-borde)] bg-white/[0.03]"
								}`}
							>
								<span className="jc-mono w-6 text-right text-xs text-[var(--color-tinta-2)]">
									{d.orden}
								</span>
								<Link
									to={`/admin/capitulo/${capitulo.id}/peliculas?peli=${d.id}`}
									className="flex-1 truncate text-sm hover:text-[var(--color-cyan)]"
								>
									{d.title}
								</Link>
								<span
									className={`jc-mono text-[0.6rem] ${
										d.active
											? "text-[var(--color-verde)]"
											: "text-[var(--color-tinta-2)]"
									}`}
								>
									{d.active ? "activo" : "oculto"}
								</span>
								<Form
									method="post"
									onSubmit={(ev) => {
										if (!confirm(`¿Eliminar “${d.title}”?`)) ev.preventDefault();
									}}
								>
									<input type="hidden" name="intent" value="eliminar" />
									<input type="hidden" name="id" value={d.id} />
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
								to={`/admin/capitulo/${capitulo.id}/peliculas`}
								className="jc-btn jc-btn-primary mt-2"
							>
								+ Nueva película
							</Link>
						)}
					</div>

					<Form method="post" key={editando?.id ?? "nuevo"} className="jc-glass p-6">
						<input type="hidden" name="id" value={editando?.id ?? 0} />

						<h2 className="jc-display text-xl">
							{nuevo ? "➕ Nueva película" : "✏️ Editar película"}
						</h2>

						{error && (
							<div className="mt-4">
								<Aviso tipo="error">{error}</Aviso>
							</div>
						)}

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
									defaultValue={editando?.orden ?? demos.length + 1}
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
									value={title}
									onChange={(e) => setTitle(e.target.value)}
									required
								/>
							</div>
						</div>

						<div className="mt-4">
							<label className="jc-label" htmlFor="description">
								Descripción (una línea)
							</label>
							<input
								id="description"
								name="description"
								className="jc-input"
								value={description}
								onChange={(e) => setDescription(e.target.value)}
								placeholder="Qué hay que mirar en esta película"
							/>
						</div>

						<div className="mt-4">
							<label className="jc-label" htmlFor="code">
								Código Python
							</label>
							<textarea
								id="code"
								name="code"
								rows={8}
								spellCheck={false}
								className="jc-input jc-mono text-[0.82rem]"
								value={code}
								onChange={(e) => setCode(e.target.value)}
							/>
						</div>

						<div className="mt-4">
							<label className="jc-label" htmlFor="columnsJson">
								columns_json — títulos de las columnas
							</label>
							<textarea
								id="columnsJson"
								name="columnsJson"
								rows={3}
								spellCheck={false}
								className="jc-input jc-mono text-[0.82rem]"
								value={columnsJson}
								onChange={(e) => setColumnsJson(e.target.value)}
							/>
							{errColumnas.length > 0 && (
								<ul className="mt-2 space-y-1">
									{errColumnas.map((e) => (
										<li
											key={e.mensaje}
											className="text-xs text-[var(--color-magenta)]"
										>
											⚠️ {e.mensaje}
										</li>
									))}
								</ul>
							)}
						</div>

						<div className="mt-4">
							<label className="jc-label" htmlFor="stepsJson">
								steps_json — un paso por fila
							</label>
							<textarea
								id="stepsJson"
								name="stepsJson"
								rows={12}
								spellCheck={false}
								className="jc-input jc-mono text-[0.82rem]"
								value={stepsJson}
								onChange={(e) => setStepsJson(e.target.value)}
								placeholder={EJEMPLO_PASOS}
							/>
							<p className="mt-1.5 text-xs text-[var(--color-tinta-2)]">
								{"{ cells: [una por columna], out: \"lo que imprime\", hl: índice a resaltar o null }"}
							</p>
							{errPasos.length > 0 && (
								<ul className="mt-2 space-y-1">
									{errPasos.map((e) => (
										<li
											key={e.mensaje}
											className="text-xs text-[var(--color-magenta)]"
										>
											⚠️ {e.mensaje}
										</li>
									))}
								</ul>
							)}
						</div>

						<label className="mt-5 flex items-center gap-2 text-sm">
							<input
								type="checkbox"
								name="active"
								defaultChecked={editando ? editando.active : true}
								className="size-4 accent-[var(--color-cyan)]"
							/>
							Activa (se ve en el capítulo)
						</label>

						<div className="mt-6 flex flex-wrap gap-2">
							<button
								type="submit"
								className="jc-btn jc-btn-primary"
								disabled={errores.length > 0}
							>
								💾 Guardar
							</button>
							{errores.length > 0 && (
								<span className="self-center text-xs text-[var(--color-magenta)]">
									Arregla el JSON para poder guardar
								</span>
							)}
						</div>
					</Form>
				</div>

				{/* Vista previa --------------------------------------------------- */}
				<div className="lg:sticky lg:top-24 lg:h-fit">
					<p className="jc-mono mb-3 text-[0.66rem] tracking-[0.2em] text-[var(--color-tinta-2)] uppercase">
						Vista previa — así la ve el estudiante
					</p>
					{vista.pasos.length > 0 && vista.columns.length > 0 ? (
						// La key reinicia el stepper cada vez que cambia el contenido.
						<TraceStepper
							key={`${vista.columns.length}-${vista.pasos.length}-${code.length}`}
							pelicula={vista}
						/>
					) : (
						<Vacio>
							Escribe las columnas y los pasos para ver la película aquí.
						</Vacio>
					)}
				</div>
			</div>
		</AdminShell>
	);
}
