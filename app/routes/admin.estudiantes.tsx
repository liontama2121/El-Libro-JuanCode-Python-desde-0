import { asc, eq } from "drizzle-orm";
import { Form, Link, useNavigation } from "react-router";
import { AdminShell, Aviso, Tabla, Vacio } from "~/components/admin";
import { getDb, schema } from "~/db";
import { crearUsuario, requireTeacher, setPasswordHash } from "~/lib/auth.server";
import { formatearFecha } from "~/lib/format";
import type { Route } from "./+types/admin.estudiantes";

export const meta: Route.MetaFunction = () => [
	{ title: "Estudiantes — Panel del profe" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const estudiantes = await db
		.select({
			id: schema.users.id,
			name: schema.users.name,
			username: schema.users.username,
			mustChangePassword: schema.users.mustChangePassword,
			createdAt: schema.users.createdAt,
		})
		.from(schema.users)
		.where(eq(schema.users.role, "student"))
		.orderBy(asc(schema.users.name));

	return { user, estudiantes };
}

type AccionResultado = { error?: string; ok?: string };

export async function action({
	context,
	request,
}: Route.ActionArgs): Promise<AccionResultado> {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);
	const form = await request.formData();
	const intent = String(form.get("intent") || "");

	if (intent === "crear") {
		const name = String(form.get("name") || "").trim();
		const username = String(form.get("username") || "").trim().toLowerCase();
		const password = String(form.get("password") || "");

		if (!name || !username || password.length < 6) {
			return {
				error:
					"Faltan datos: nombre, usuario y una contraseña de mínimo 6 caracteres.",
			};
		}
		if (!/^[a-z0-9_]{3,}$/.test(username)) {
			return {
				error:
					"El usuario debe tener 3+ caracteres: sólo letras, números y guion bajo.",
			};
		}

		const res = await crearUsuario(env, request, {
			name,
			username,
			password,
			role: "student",
			mustChangePassword: true,
		});

		if (!res.ok) return { error: res.error };
		return { ok: `Estudiante ${name} creado. Contraseña temporal: ${password}` };
	}

	if (intent === "resetear") {
		const id = String(form.get("id") || "");
		const password = String(form.get("password") || "").trim();
		if (password.length < 6) {
			return { error: "La contraseña temporal necesita 6+ caracteres." };
		}

		await setPasswordHash(db, id, password);
		await db
			.update(schema.users)
			.set({ mustChangePassword: true, updatedAt: new Date() })
			.where(eq(schema.users.id, id));

		return { ok: `Contraseña reiniciada. Nueva temporal: ${password}` };
	}

	if (intent === "eliminar") {
		const id = String(form.get("id") || "");
		// Borrado explícito por si el motor no propaga los ON DELETE CASCADE.
		await db.delete(schema.unlocks).where(eq(schema.unlocks.userId, id));
		await db
			.delete(schema.quizAttempts)
			.where(eq(schema.quizAttempts.userId, id));
		await db.delete(schema.sessions).where(eq(schema.sessions.userId, id));
		await db.delete(schema.accounts).where(eq(schema.accounts.userId, id));
		await db
			.delete(schema.users)
			.where(eq(schema.users.id, id));

		return { ok: "Estudiante eliminado." };
	}

	return { error: "Acción desconocida." };
}

export default function AdminEstudiantes({
	loaderData,
	actionData,
}: Route.ComponentProps) {
	const { user, estudiantes } = loaderData;
	const navigation = useNavigation();
	const enviando = navigation.state === "submitting";

	return (
		<AdminShell
			user={user}
			titulo="Estudiantes"
			descripcion="Crea cuentas, reinicia contraseñas y elimina estudiantes."
		>
			<div className="grid gap-8 lg:grid-cols-[380px_1fr]">
				{/* Crear ---------------------------------------------------------- */}
				<Form method="post" className="jc-glass h-fit p-6">
					<input type="hidden" name="intent" value="crear" />
					<h2 className="jc-display text-xl">➕ Nuevo estudiante</h2>

					<div className="mt-5 space-y-4">
						<div>
							<label className="jc-label" htmlFor="name">
								Nombre completo
							</label>
							<input id="name" name="name" className="jc-input" required />
						</div>
						<div>
							<label className="jc-label" htmlFor="username">
								Usuario
							</label>
							<input
								id="username"
								name="username"
								className="jc-input jc-mono"
								placeholder="ana_perez"
								pattern="[a-zA-Z0-9_]{3,}"
								required
							/>
						</div>
						<div>
							<label className="jc-label" htmlFor="password">
								Contraseña temporal
							</label>
							<input
								id="password"
								name="password"
								className="jc-input jc-mono"
								minLength={6}
								defaultValue="python123"
								required
							/>
							<p className="mt-2 text-xs text-[var(--color-tinta-2)]">
								El estudiante deberá cambiarla la primera vez que entre.
							</p>
						</div>
					</div>

					<button
						type="submit"
						className="jc-btn jc-btn-primary mt-6 w-full"
						disabled={enviando}
					>
						Crear estudiante
					</button>

					{actionData?.error && (
						<div className="mt-4">
							<Aviso tipo="error">{actionData.error}</Aviso>
						</div>
					)}
					{actionData?.ok && (
						<div className="mt-4">
							<Aviso tipo="ok">{actionData.ok}</Aviso>
						</div>
					)}
				</Form>

				{/* Lista ---------------------------------------------------------- */}
				<div>
					{estudiantes.length === 0 ? (
						<Vacio>Aún no hay estudiantes registrados.</Vacio>
					) : (
						<Tabla cabeceras={["Estudiante", "Usuario", "Alta", "Acciones"]}>
							{estudiantes.map((e) => (
								<tr
									key={e.id}
									className="border-b border-[var(--color-borde)] last:border-0"
								>
									<td className="px-5 py-4">
										<Link
											to={`/admin/estudiante/${e.id}`}
											className="font-semibold hover:text-[var(--color-cyan)]"
										>
											{e.name}
										</Link>
										{e.mustChangePassword && (
											<div className="jc-mono text-[0.66rem] text-[var(--color-naranja)]">
												clave temporal pendiente
											</div>
										)}
									</td>
									<td className="jc-mono px-5 py-4 text-[var(--color-tinta-2)]">
										{e.username}
									</td>
									<td className="px-5 py-4 text-xs text-[var(--color-tinta-2)]">
										{formatearFecha(e.createdAt)}
									</td>
									<td className="px-5 py-4">
										<div className="flex flex-wrap items-center gap-2">
											<Form method="post" className="flex items-center gap-2">
												<input type="hidden" name="intent" value="resetear" />
												<input type="hidden" name="id" value={e.id} />
												<input
													name="password"
													className="jc-input jc-mono w-32 !px-3 !py-1.5 text-xs"
													defaultValue="python123"
													minLength={6}
													aria-label="Nueva contraseña temporal"
												/>
												<button
													type="submit"
													className="jc-btn jc-btn-sm jc-btn-ghost"
												>
													🔑 Resetear
												</button>
											</Form>

											<Form
												method="post"
												onSubmit={(ev) => {
													if (
														!confirm(
															`¿Eliminar a ${e.name}? Se borra su progreso.`,
														)
													) {
														ev.preventDefault();
													}
												}}
											>
												<input type="hidden" name="intent" value="eliminar" />
												<input type="hidden" name="id" value={e.id} />
												<button
													type="submit"
													className="jc-btn jc-btn-sm jc-btn-ghost text-[var(--color-magenta)]"
												>
													🗑️
												</button>
											</Form>
										</div>
									</td>
								</tr>
							))}
						</Tabla>
					)}
				</div>
			</div>
		</AdminShell>
	);
}
