import { desc, eq } from "drizzle-orm";
import { Link } from "react-router";
import { Nav } from "~/components/nav";
import { Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { rankingVisible } from "~/lib/gamification.server";
import { nivelDe } from "~/lib/niveles";
import type { Route } from "./+types/ranking";

export const meta: Route.MetaFunction = () => [
	{ title: "Ranking — El Libro JuanCode" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const visible = await rankingVisible(db);
	// El profe siempre lo ve, aunque lo tenga oculto para el curso.
	if (!visible && user.role !== "teacher") {
		return { user, visible: false as const, filas: [] };
	}

	const filas = await db
		.select({
			userId: schema.users.id,
			nombre: schema.users.name,
			xp: schema.userStats.xp,
			streakDays: schema.userStats.streakDays,
		})
		.from(schema.userStats)
		.innerJoin(schema.users, eq(schema.users.id, schema.userStats.userId))
		.where(eq(schema.users.role, "student"))
		.orderBy(desc(schema.userStats.xp))
		.limit(50);

	return { user, visible: true as const, filas };
}

export default function Ranking({ loaderData }: Route.ComponentProps) {
	const { user, visible, filas } = loaderData;

	if (!visible) {
		return (
			<>
				<Nav user={user} />
				<main className="mx-auto max-w-xl px-5 py-24 text-center">
					<p className="text-5xl">🙈</p>
					<h1 className="jc-display mt-5 text-3xl">El ranking está oculto</h1>
					<p className="mt-3 text-[var(--color-tinta-2)]">
						El profe lo apagó por ahora. Sigue sumando XP: cuando vuelva, tu puesto
						estará ahí.
					</p>
					<Link to="/practica" className="jc-btn jc-btn-primary mt-7">
						Volver a práctica
					</Link>
				</main>
			</>
		);
	}

	const miPuesto = filas.findIndex((f) => f.userId === user.id) + 1;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-2xl px-4 pb-24 sm:px-5">
				<header className="jc-anim-in py-10 text-center sm:py-14">
					<h1 className="jc-display jc-grad text-4xl sm:text-5xl">🏆 Ranking</h1>
					<p className="mt-3 text-[var(--color-tinta-2)]">
						{miPuesto > 0
							? `Vas de ${miPuesto.toString()}° entre ${filas.length}.`
							: "Practica un rato y apareces en la tabla."}
					</p>
				</header>

				<ol className="space-y-2">
					{filas.map((f, i) => {
						const yo = f.userId === user.id;
						const nivel = nivelDe(f.xp);
						return (
							<li
								key={f.userId}
								className={`flex items-center gap-3 rounded-2xl border px-4 py-3 ${
									yo
										? "border-[rgba(0,229,255,.55)] bg-[rgba(0,229,255,.09)]"
										: "border-[var(--color-borde)] bg-white/[0.03]"
								}`}
							>
								<span className="jc-mono w-8 shrink-0 text-center text-sm text-[var(--color-tinta-2)]">
									{i === 0 ? "🥇" : i === 1 ? "🥈" : i === 2 ? "🥉" : i + 1}
								</span>
								<span className="min-w-0 flex-1">
									<span className="block truncate font-semibold">
										{f.nombre}
										{yo && (
											<span className="jc-mono ml-2 text-xs text-[var(--color-cyan)]">
												tú
											</span>
										)}
									</span>
									<span className="jc-mono text-[0.68rem] text-[var(--color-tinta-2)]">
										{nivel.actual.emoji} {nivel.actual.nombre} · 🔥 {f.streakDays}
									</span>
								</span>
								<span className="jc-mono shrink-0 text-sm text-[var(--color-dorado)]">
									{f.xp} XP
								</span>
							</li>
						);
					})}
					{filas.length === 0 && (
						<li className="rounded-2xl border border-dashed border-[var(--color-borde)] p-8 text-center text-sm text-[var(--color-tinta-2)]">
							Todavía nadie ha sumado XP.
						</li>
					)}
				</ol>

				<div className="mt-10 flex flex-wrap justify-center gap-3">
					<Link to="/practica/arcade" className="jc-btn jc-btn-primary">
						🕹️ Subir en la tabla
					</Link>
					<Link to="/perfil" className="jc-btn jc-btn-ghost">
						👤 Mi perfil
					</Link>
				</div>
			</main>
		</>
	);
}
