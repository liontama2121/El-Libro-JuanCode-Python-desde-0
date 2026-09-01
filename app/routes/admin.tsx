import { asc, eq, sql } from "drizzle-orm";
import { Link } from "react-router";
import { AdminShell, Tabla, Vacio } from "~/components/admin";
import { BarraProgreso } from "~/components/ui";
import { getDb, schema } from "~/db";
import { formatearFecha } from "~/lib/format";
import { requireTeacher } from "~/lib/auth.server";
import { cargarProgreso, ultimoIntento } from "~/lib/progress.server";
import type { Route } from "./+types/admin";

export const meta: Route.MetaFunction = () => [
	{ title: "Panel del profe — El Libro JuanCode" },
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

	const capitulos = await db
		.select({ id: schema.chapters.id, number: schema.chapters.number })
		.from(schema.chapters)
		.orderBy(asc(schema.chapters.number));

	const [{ totalCapitulos }] = await db
		.select({ totalCapitulos: sql<number>`count(*)` })
		.from(schema.chapters);

	const [{ publicados }] = await db
		.select({ publicados: sql<number>`count(*)` })
		.from(schema.chapters)
		.where(eq(schema.chapters.published, true));

	const filas = await Promise.all(
		estudiantes.map(async (e) => {
			const progreso = await cargarProgreso(db, e.id);
			const intento = await ultimoIntento(db, e.id);

			// "Capítulo actual" = el mayor desbloqueado/accesible.
			const accesibles = capitulos.filter(
				(c) => c.number === 1 || progreso.unlocked.has(c.id),
			);
			const actual = accesibles.length
				? Math.max(...accesibles.map((c) => c.number))
				: 1;

			return {
				...e,
				completados: progreso.passed.size,
				actual,
				intento,
			};
		}),
	);

	return {
		user,
		filas,
		totalCapitulos: Number(totalCapitulos) || 0,
		publicados: Number(publicados) || 0,
	};
}

export default function Admin({ loaderData }: Route.ComponentProps) {
	const { user, filas, totalCapitulos, publicados } = loaderData;

	return (
		<AdminShell
			user={user}
			titulo="Panel del profe"
			descripcion={`${filas.length} estudiantes · ${publicados} de ${totalCapitulos} capítulos publicados`}
			acciones={
				<Link to="/admin/estudiantes" className="jc-btn jc-btn-primary">
					+ Nuevo estudiante
				</Link>
			}
		>
			{filas.length === 0 ? (
				<Vacio>
					Todavía no hay estudiantes.{" "}
					<Link className="text-[var(--color-cyan)] underline" to="/admin/estudiantes">
						Crea el primero
					</Link>
					.
				</Vacio>
			) : (
				<Tabla
					cabeceras={[
						"Estudiante",
						"Usuario",
						"Capítulo actual",
						"Progreso",
						"Último quiz",
						"",
					]}
				>
					{filas.map((f) => (
						<tr
							key={f.id}
							className="border-b border-[var(--color-borde)] last:border-0"
						>
							<td className="px-5 py-4">
								<div className="font-semibold">{f.name}</div>
								{f.mustChangePassword && (
									<div className="jc-mono text-[0.66rem] text-[var(--color-naranja)]">
										debe cambiar contraseña
									</div>
								)}
							</td>
							<td className="jc-mono px-5 py-4 text-[var(--color-tinta-2)]">
								{f.username}
							</td>
							<td className="px-5 py-4">
								<span className="jc-mono rounded-full border border-[var(--color-borde)] px-3 py-1 text-xs">
									cap. {f.actual}
								</span>
							</td>
							<td className="w-56 px-5 py-4">
								<BarraProgreso valor={f.completados} total={totalCapitulos} />
								<div className="jc-mono mt-1 text-[0.66rem] text-[var(--color-tinta-2)]">
									{f.completados}/{totalCapitulos} capítulos
								</div>
							</td>
							<td className="px-5 py-4">
								{f.intento ? (
									<div className="text-xs">
										<span
											className={
												f.intento.passed
													? "text-[var(--color-verde)]"
													: "text-[var(--color-naranja)]"
											}
										>
											{f.intento.passed ? "✅" : "❌"} {f.intento.score} pts
										</span>
										<div className="text-[var(--color-tinta-2)]">
											cap. {f.intento.chapterNumber} ·{" "}
											{formatearFecha(f.intento.createdAt)}
										</div>
									</div>
								) : (
									<span className="text-xs text-[var(--color-tinta-2)]">
										sin intentos
									</span>
								)}
							</td>
							<td className="px-5 py-4 text-right">
								<Link
									to={`/admin/estudiante/${f.id}`}
									className="jc-btn jc-btn-sm jc-btn-ghost"
								>
									Ver
								</Link>
							</td>
						</tr>
					))}
				</Tabla>
			)}
		</AdminShell>
	);
}
