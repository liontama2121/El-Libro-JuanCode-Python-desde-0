import { and, asc, desc, eq, like, sql } from "drizzle-orm";
import { Form, Link } from "react-router";
import { AdminShell, Tabla, Vacio } from "~/components/admin";
import { BarraProgreso } from "~/components/ui";
import { getDb, schema } from "~/db";
import { formatearFecha } from "~/lib/format";
import {
	cargarStats,
	fijarRanking,
	nivelDe,
	rankingVisible,
} from "~/lib/gamification.server";
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

	const verRanking = await rankingVisible(db);

	const filas = await Promise.all(
		estudiantes.map(async (e) => {
			const progreso = await cargarProgreso(db, e.id);
			const intento = await ultimoIntento(db, e.id);
			const stats = await cargarStats(db, e.id);

			// Último rato de arcade (los modos empiezan por "arcade_")
			const [arcade] = await db
				.select({
					mode: schema.practiceAttempts.mode,
					score: schema.practiceAttempts.score,
					total: schema.practiceAttempts.total,
					createdAt: schema.practiceAttempts.createdAt,
				})
				.from(schema.practiceAttempts)
				.where(
					and(
						eq(schema.practiceAttempts.userId, e.id),
						like(schema.practiceAttempts.mode, "arcade_%"),
					),
				)
				.orderBy(desc(schema.practiceAttempts.createdAt))
				.limit(1);

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
				xp: stats.xp,
				nivel: nivelDe(stats.xp).actual,
				streakDays: stats.streakDays,
				arcade: arcade ?? null,
			};
		}),
	);

	return {
		user,
		filas,
		totalCapitulos: Number(totalCapitulos) || 0,
		publicados: Number(publicados) || 0,
		verRanking,
	};
}

/** Único ajuste por ahora: mostrar u ocultar el ranking al curso. */
export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const form = await request.formData();
	if (String(form.get("intent")) === "ranking") {
		await fijarRanking(db, form.get("visible") === "1");
	}
	return { ok: true };
}

const NOMBRE_ARCADE: Record<string, string> = {
	arcade_relampago: "⚡ Relámpago",
	arcade_detective: "🕵️ Detective",
	arcade_puzzle: "🧩 Rompecabezas",
	arcade_sorpresa: "🎲 Sorpresa",
	arcade_codigo: "💻 Modo código",
};

export default function Admin({ loaderData }: Route.ComponentProps) {
	const { user, filas, totalCapitulos, publicados, verRanking } = loaderData;

	return (
		<AdminShell
			user={user}
			titulo="Panel del profe"
			descripcion={`${filas.length} estudiantes · ${publicados} de ${totalCapitulos} capítulos publicados`}
			acciones={
				<div className="flex flex-wrap items-center gap-3">
					<Form method="post">
						<input type="hidden" name="intent" value="ranking" />
						<input type="hidden" name="visible" value={verRanking ? "0" : "1"} />
						<button type="submit" className="jc-btn jc-btn-sm jc-btn-ghost">
							{verRanking ? "🏆 Ranking visible" : "🙈 Ranking oculto"}
						</button>
					</Form>
					<Link to="/admin/estudiantes" className="jc-btn jc-btn-primary">
						+ Nuevo estudiante
					</Link>
				</div>
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
						"Nivel · XP",
						"Racha",
						"Capítulo",
						"Progreso",
						"Último quiz",
						"Último arcade",
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
							<td className="px-5 py-4">
								<div className="text-sm">
									{f.nivel.emoji} {f.nivel.nombre}
								</div>
								<div className="jc-mono text-[0.66rem] text-[var(--color-dorado)]">
									{f.xp} XP
								</div>
							</td>
							<td className="jc-mono px-5 py-4 text-sm">
								{f.streakDays > 0 ? `🔥 ${f.streakDays}` : "—"}
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
							<td className="px-5 py-4">
								{f.arcade ? (
									<div className="text-xs">
										<div>{NOMBRE_ARCADE[f.arcade.mode] ?? f.arcade.mode}</div>
										<div className="text-[var(--color-tinta-2)]">
											{f.arcade.score}/{f.arcade.total} ·{" "}
											{formatearFecha(f.arcade.createdAt)}
										</div>
									</div>
								) : (
									<span className="text-xs text-[var(--color-tinta-2)]">—</span>
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
