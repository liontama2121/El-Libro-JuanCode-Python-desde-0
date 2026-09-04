import { and, asc, eq, sql } from "drizzle-orm";
import { useMemo, useState } from "react";
import { Form, Link, useFetcher, useNavigation } from "react-router";
import { AdminShell, Aviso, Tabla, Vacio } from "~/components/admin";
import { getDb, schema } from "~/db";
import { TRACKS_USUARIO, type TrackUsuario } from "~/db/schema";
import { crearUsuario, requireTeacher, setPasswordHash } from "~/lib/auth.server";
import { formatearFecha } from "~/lib/format";
import { TRACK_INFO, tracksVisibles } from "~/lib/tracks";
import type { Route } from "./+types/admin.estudiantes";

export const meta: Route.MetaFunction = () => [
	{ title: "Estudiantes — Panel del profe" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const [filas, totales, aprobados] = await Promise.all([
		db
			.select({
				id: schema.users.id,
				name: schema.users.name,
				username: schema.users.username,
				track: schema.users.track,
				mustChangePassword: schema.users.mustChangePassword,
				createdAt: schema.users.createdAt,
			})
			.from(schema.users)
			.where(eq(schema.users.role, "student"))
			.orderBy(asc(schema.users.name)),

		// Cuántos capítulos publicados tiene cada libro
		db
			.select({
				track: schema.chapters.track,
				total: sql<number>`count(*)`,
			})
			.from(schema.chapters)
			.where(eq(schema.chapters.published, true))
			.groupBy(schema.chapters.track),

		// Cuántos aprobó cada estudiante, por libro. Una sola consulta para
		// todos: con una por estudiante, la tabla se arrastraría.
		db
			.select({
				userId: schema.quizAttempts.userId,
				track: schema.chapters.track,
				hechos: sql<number>`count(distinct ${schema.chapters.id})`,
			})
			.from(schema.quizAttempts)
			.innerJoin(
				schema.quizzes,
				eq(schema.quizzes.id, schema.quizAttempts.quizId),
			)
			.innerJoin(
				schema.chapters,
				eq(schema.chapters.id, schema.quizzes.chapterId),
			)
			.where(eq(schema.quizAttempts.passed, true))
			.groupBy(schema.quizAttempts.userId, schema.chapters.track),
	]);

	const totalDe = (track: string) =>
		Number(totales.find((t) => t.track === track)?.total ?? 0);

	const estudiantes = filas.map((e) => ({
		...e,
		progreso: {
			basico: {
				hechos: Number(
					aprobados.find((a) => a.userId === e.id && a.track === "basico")
						?.hechos ?? 0,
				),
				total: totalDe("basico"),
			},
			avanzado: {
				hechos: Number(
					aprobados.find((a) => a.userId === e.id && a.track === "avanzado")
						?.hechos ?? 0,
				),
				total: totalDe("avanzado"),
			},
		},
	}));

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

	if (intent === "track") {
		const id = String(form.get("id") || "");
		const track = String(form.get("track") || "");

		// Solo el profe llega hasta aquí (requireTeacher arriba). El estudiante
		// no puede cambiarse el suyo: se saltaría el contenido que necesita.
		if (!TRACKS_USUARIO.includes(track as TrackUsuario)) {
			return { error: "Ese track no existe." };
		}

		await db
			.update(schema.users)
			.set({ track, updatedAt: new Date() })
			.where(and(eq(schema.users.id, id), eq(schema.users.role, "student")));

		return { ok: "Track actualizado." };
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

	const [filtroTrack, setFiltroTrack] = useState<"todos" | TrackUsuario>("todos");
	const [busqueda, setBusqueda] = useState("");

	const visibles = useMemo(() => {
		const texto = busqueda.trim().toLowerCase();
		return estudiantes.filter((e) => {
			if (filtroTrack !== "todos" && e.track !== filtroTrack) return false;
			if (!texto) return true;
			return (
				e.name.toLowerCase().includes(texto) ||
				e.username.toLowerCase().includes(texto)
			);
		});
	}, [estudiantes, filtroTrack, busqueda]);
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
					<div className="mb-4 flex flex-wrap items-center gap-2">
						<input
							value={busqueda}
							onChange={(ev) => setBusqueda(ev.target.value)}
							placeholder="🔍 Buscar por nombre o usuario"
							className="jc-input max-w-xs !py-2 text-sm"
							aria-label="Buscar estudiante"
						/>

						<div className="flex flex-wrap gap-1.5">
							{(["todos", ...TRACKS_USUARIO] as const).map((t) => (
								<button
									key={t}
									type="button"
									onClick={() => setFiltroTrack(t)}
									className={`jc-btn jc-btn-sm ${
										filtroTrack === t ? "jc-btn-primary" : "jc-btn-ghost"
									}`}
								>
									{t === "todos" ? "Todos" : etiquetaTrack(t)}
								</button>
							))}
						</div>

						<span className="jc-mono ml-auto text-xs text-[var(--color-tinta-2)]">
							{visibles.length} de {estudiantes.length}
						</span>
					</div>

					{estudiantes.length === 0 ? (
						<Vacio>Aún no hay estudiantes registrados.</Vacio>
					) : visibles.length === 0 ? (
						<Vacio>Ningún estudiante coincide con ese filtro.</Vacio>
					) : (
						<Tabla
							cabeceras={[
								"Estudiante",
								"Usuario",
								"Track",
								"Progreso",
								"Alta",
								"Acciones",
							]}
						>
							{visibles.map((e) => (
								<FilaEstudiante key={e.id} estudiante={e} />
							))}
						</Tabla>
					)}
				</div>
			</div>
		</AdminShell>
	);
}

/** "Básico", "Avanzado", "Los dos" — como se lee el track en la tabla. */
function etiquetaTrack(track: TrackUsuario | string): string {
	if (track === "ambos") return "Los dos";
	if (track === "avanzado") return `${TRACK_INFO.avanzado.emoji} Avanzado`;
	return `${TRACK_INFO.basico.emoji} Básico`;
}

type Estudiante = Route.ComponentProps["loaderData"]["estudiantes"][number];

function FilaEstudiante({ estudiante: e }: { estudiante: Estudiante }) {
	const fetcher = useFetcher();

	// Cambio optimista: mientras el servidor responde, la tabla ya muestra el
	// track nuevo. Si falla, el loader vuelve a mandar el valor real.
	const enVuelo = fetcher.formData?.get("track");
	const track = (enVuelo ? String(enVuelo) : e.track) as TrackUsuario;
	const guardando = fetcher.state !== "idle";

	return (
		<tr className="border-b border-[var(--color-borde)] last:border-0">
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

			{/* Track ------------------------------------------------------- */}
			<td className="px-5 py-4">
				<fetcher.Form method="post">
					<input type="hidden" name="intent" value="track" />
					<input type="hidden" name="id" value={e.id} />
					<select
						name="track"
						value={track}
						disabled={guardando}
						aria-label={`Track de ${e.name}`}
						onChange={(ev) =>
							fetcher.submit(
								{ intent: "track", id: e.id, track: ev.target.value },
								{ method: "post" },
							)
						}
						className={`jc-input jc-mono !w-auto !px-3 !py-1.5 text-xs ${
							track === "basico"
								? ""
								: "!border-[rgba(255,77,255,.45)] text-[var(--color-magenta)]"
						} ${guardando ? "opacity-60" : ""}`}
					>
						{TRACKS_USUARIO.map((t) => (
							<option key={t} value={t}>
								{etiquetaTrack(t)}
							</option>
						))}
					</select>
				</fetcher.Form>
			</td>

			{/* Progreso ---------------------------------------------------- */}
			<td className="px-5 py-4">
				<div className="flex flex-col gap-1">
					{tracksVisibles(track).map((t) => {
						const { hechos, total } = e.progreso[t];
						const pct = total ? Math.round((hechos / total) * 100) : 0;

						return (
							<div key={t} className="flex items-center gap-2">
								<span className="w-4 text-xs">{TRACK_INFO[t].emoji}</span>
								<div className="h-1.5 w-20 overflow-hidden rounded-full bg-white/10">
									<div
										className="h-full rounded-full"
										style={{
											width: `${pct}%`,
											background:
												t === "avanzado"
													? "linear-gradient(90deg,#b975ff,#FF4DFF)"
													: "linear-gradient(90deg,#00E5FF,#b975ff)",
										}}
									/>
								</div>
								<span className="jc-mono text-[0.66rem] text-[var(--color-tinta-2)]">
									{hechos}/{total}
								</span>
							</div>
						);
					})}
				</div>
			</td>

			<td className="px-5 py-4 text-xs text-[var(--color-tinta-2)]">
				{formatearFecha(e.createdAt)}
			</td>

			{/* Acciones ---------------------------------------------------- */}
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
						<button type="submit" className="jc-btn jc-btn-sm jc-btn-ghost">
							🔑 Resetear
						</button>
					</Form>

					<Form
						method="post"
						onSubmit={(ev) => {
							if (!confirm(`¿Eliminar a ${e.name}? Se borra su progreso.`)) {
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
	);
}
