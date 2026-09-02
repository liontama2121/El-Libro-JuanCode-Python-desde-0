import { asc, eq } from "drizzle-orm";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Aviso } from "~/components/admin";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import { romano } from "~/lib/format";
import type { Route } from "./+types/admin.capitulos";

export const meta: Route.MetaFunction = () => [
	{ title: "Capítulos — Panel del profe" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const [partes, capitulos] = await Promise.all([
		db.select().from(schema.parts).orderBy(asc(schema.parts.number)),
		db.select().from(schema.chapters).orderBy(asc(schema.chapters.number)),
	]);

	const idEditar = Number(new URL(request.url).searchParams.get("id"));
	const editando =
		capitulos.find((c) => c.id === idEditar) ?? null;

	return { user, partes, capitulos, editando };
}

type AccionResultado = { error?: string; ok?: string };

export async function action({
	context,
	request,
}: Route.ActionArgs): Promise<AccionResultado | Response> {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const form = await request.formData();
	const intent = String(form.get("intent") || "guardar");

	if (intent === "eliminar") {
		const id = Number(form.get("id"));
		if (Number.isInteger(id)) {
			await db.delete(schema.chapters).where(eq(schema.chapters.id, id));
		}
		return redirect(
			`/admin/capitulos?toast=${encodeURIComponent("Capítulo eliminado 🗑️")}`,
		);
	}

	const id = Number(form.get("id"));
	const partId = Number(form.get("partId"));
	const number = Number(form.get("number"));
	const title = String(form.get("title") || "").trim();
	const emoji = String(form.get("emoji") || "📖").trim() || "📖";
	const description = String(form.get("description") || "").trim();
	const contentHtml = String(form.get("contentHtml") || "");
	const published = form.get("published") === "on";

	if (!title || !Number.isInteger(partId) || !Number.isInteger(number)) {
		return { error: "Necesitas parte, número y título." };
	}

	const chocan = await db
		.select({ id: schema.chapters.id })
		.from(schema.chapters)
		.where(eq(schema.chapters.number, number))
		.limit(1);

	if (chocan.length > 0 && chocan[0].id !== id) {
		return { error: `Ya existe un capítulo con el número ${number}.` };
	}

	const datos = {
		partId,
		number,
		title,
		emoji,
		description,
		contentHtml,
		published,
	};

	if (Number.isInteger(id) && id > 0) {
		await db
			.update(schema.chapters)
			.set(datos)
			.where(eq(schema.chapters.id, id));
		return redirect(
			`/admin/capitulos?id=${id}&toast=${encodeURIComponent("Capítulo guardado ✅")}`,
		);
	}

	const [creado] = await db
		.insert(schema.chapters)
		.values(datos)
		.returning({ id: schema.chapters.id });

	return redirect(
		`/admin/capitulos?id=${creado.id}&toast=${encodeURIComponent("Capítulo creado ✅")}`,
	);
}

export default function AdminCapitulos({
	loaderData,
	actionData,
}: Route.ComponentProps) {
	const { user, partes, capitulos, editando } = loaderData;
	const nuevo = !editando;
	const error =
		actionData && "error" in actionData ? actionData.error : undefined;

	const siguienteNumero =
		capitulos.length > 0 ? Math.max(...capitulos.map((c) => c.number)) + 1 : 1;

	return (
		<AdminShell
			user={user}
			titulo="Capítulos"
			descripcion={`${capitulos.length} capítulos · ${
				capitulos.filter((c) => c.published).length
			} publicados`}
			acciones={
				!nuevo && (
					<Link to="/admin/capitulos" className="jc-btn jc-btn-primary">
						+ Nuevo capítulo
					</Link>
				)
			}
		>
			<div className="grid gap-8 lg:grid-cols-[1fr_minmax(0,1.35fr)]">
				{/* Lista ---------------------------------------------------------- */}
				<div className="space-y-7">
					{partes.map((parte) => {
						const delParte = capitulos.filter((c) => c.partId === parte.id);
						return (
							<section key={parte.id}>
								<p className="jc-mono mb-2 text-[0.66rem] tracking-[0.2em] text-[var(--color-tinta-2)] uppercase">
									{parte.emoji} Parte {romano(parte.number)} — {parte.title}
								</p>
								<ul className="space-y-2">
									{delParte.map((c) => {
										const activo = editando?.id === c.id;
										return (
											<li key={c.id}>
												<div
													className={`flex items-center gap-3 rounded-xl border px-4 py-2.5 ${
														activo
															? "border-[rgba(0,229,255,.5)] bg-[rgba(0,229,255,.07)]"
															: "border-[var(--color-borde)] bg-white/[0.03]"
													}`}
												>
													<span className="jc-mono w-6 text-right text-xs text-[var(--color-tinta-2)]">
														{c.number}
													</span>
													<span>{c.emoji}</span>
													<Link
														to={`/admin/capitulos?id=${c.id}`}
														className="flex-1 truncate text-sm hover:text-[var(--color-cyan)]"
													>
														{c.title}
													</Link>
													<span
														className={`jc-mono text-[0.6rem] ${
															c.published
																? "text-[var(--color-verde)]"
																: "text-[var(--color-tinta-2)]"
														}`}
													>
														{c.published ? "publicado" : "borrador"}
													</span>
												</div>
												{activo && (
													<div className="mt-2 ml-9 flex flex-wrap gap-2">
														<Link
															to={`/admin/capitulo/${c.id}/ejercicios`}
															className="jc-btn jc-btn-sm jc-btn-ghost"
														>
															🏋️ Ejercicios
														</Link>
														<Link
															to={`/admin/capitulo/${c.id}/quiz`}
															className="jc-btn jc-btn-sm jc-btn-ghost"
														>
															🎯 Quiz
														</Link>
														<Link
															to={`/admin/capitulo/${c.id}/peliculas`}
															className="jc-btn jc-btn-sm jc-btn-ghost"
														>
															🎬 Películas
														</Link>
														<Link
															to={`/libro/capitulo/${c.number}`}
															className="jc-btn jc-btn-sm jc-btn-ghost"
														>
															👁️ Ver
														</Link>
													</div>
												)}
											</li>
										);
									})}
									{delParte.length === 0 && (
										<li className="text-xs text-[var(--color-tinta-2)]">
											Sin capítulos.
										</li>
									)}
								</ul>
							</section>
						);
					})}
				</div>

				{/* Editor --------------------------------------------------------- */}
				<Form
					method="post"
					key={editando?.id ?? "nuevo"}
					className="jc-glass h-fit p-6"
				>
					<input type="hidden" name="id" value={editando?.id ?? 0} />

					<div className="flex items-center justify-between">
						<h2 className="jc-display text-xl">
							{nuevo ? "➕ Nuevo capítulo" : `✏️ Editar capítulo ${editando.number}`}
						</h2>
						{!nuevo && (
							<Link
								to="/admin/capitulos"
								className="jc-mono text-xs text-[var(--color-tinta-2)] underline"
							>
								cancelar
							</Link>
						)}
					</div>

					<div className="mt-5 grid gap-4 sm:grid-cols-[1fr_110px_90px]">
						<div>
							<label className="jc-label" htmlFor="partId">
								Parte
							</label>
							<select
								id="partId"
								name="partId"
								className="jc-input"
								defaultValue={editando?.partId ?? partes[0]?.id}
							>
								{partes.map((p) => (
									<option key={p.id} value={p.id}>
										{p.emoji} {romano(p.number)} — {p.title}
									</option>
								))}
							</select>
						</div>
						<div>
							<label className="jc-label" htmlFor="number">
								Número
							</label>
							<input
								id="number"
								name="number"
								type="number"
								min={1}
								className="jc-input jc-mono"
								defaultValue={editando?.number ?? siguienteNumero}
								required
							/>
						</div>
						<div>
							<label className="jc-label" htmlFor="emoji">
								Emoji
							</label>
							<input
								id="emoji"
								name="emoji"
								className="jc-input text-center"
								defaultValue={editando?.emoji ?? "📖"}
							/>
						</div>
					</div>

					<div className="mt-4">
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

					<div className="mt-4">
						<label className="jc-label" htmlFor="description">
							Descripción corta
						</label>
						<input
							id="description"
							name="description"
							className="jc-input"
							defaultValue={editando?.description ?? ""}
						/>
					</div>

					<div className="mt-4">
						<label className="jc-label" htmlFor="contentHtml">
							Contenido del capítulo
						</label>
						<textarea
							id="contentHtml"
							name="contentHtml"
							rows={20}
							className="jc-input jc-mono text-sm"
							defaultValue={editando?.contentHtml ?? ""}
							placeholder="<h2>Sección</h2>&#10;<p>Texto…</p>&#10;<pre><code>print('Hola')</code></pre>"
						/>
						<p className="mt-2 text-xs text-[var(--color-tinta-2)]">
							Acepta HTML: <code className="jc-mono">h2</code>,{" "}
							<code className="jc-mono">h3</code>,{" "}
							<code className="jc-mono">p</code>,{" "}
							<code className="jc-mono">ul</code>,{" "}
							<code className="jc-mono">table</code>,{" "}
							<code className="jc-mono">pre&gt;code</code>. Se renderiza tal cual
							en el lector.
						</p>
					</div>

					<label className="mt-5 flex items-center gap-3 text-sm">
						<input
							type="checkbox"
							name="published"
							defaultChecked={editando?.published ?? false}
							className="h-4 w-4 accent-[var(--color-cyan)]"
						/>
						Publicado (visible para los estudiantes)
					</label>

					{error && (
						<div className="mt-4">
							<Aviso tipo="error">{error}</Aviso>
						</div>
					)}

					<div className="mt-6 flex flex-wrap gap-3">
						<button
							type="submit"
							name="intent"
							value="guardar"
							className="jc-btn jc-btn-primary"
						>
							{nuevo ? "Crear capítulo" : "Guardar cambios"}
						</button>
						{!nuevo && (
							<button
								type="submit"
								name="intent"
								value="eliminar"
								className="jc-btn jc-btn-ghost text-[var(--color-magenta)]"
								onClick={(ev) => {
									if (
										!confirm(
											"¿Eliminar el capítulo? Se borran sus ejercicios y su quiz.",
										)
									) {
										ev.preventDefault();
									}
								}}
							>
								🗑️ Eliminar
							</button>
						)}
					</div>
				</Form>
			</div>
		</AdminShell>
	);
}
