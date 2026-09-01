import { and, eq, gte, inArray, sql } from "drizzle-orm";
import { Link } from "react-router";
import { Nav } from "~/components/nav";
import { BarraProgreso, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { MODOS, ORDEN_MODOS } from "~/lib/arcade";
import { cargarStats, listarInsignias, nivelDe } from "~/lib/gamification.server";
import { leerTests, modoCodigoActivo } from "~/lib/piston.server";
import { cargarLibro } from "~/lib/progress.server";
import type { Route } from "./+types/practica.arcade";

export const meta: Route.MetaFunction = () => [
	{ title: "Arcade — El Libro JuanCode" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const { capitulos } = await cargarLibro(db, user.id, user.role === "teacher");
	const abiertos = capitulos.filter((c) => c.estado !== "bloqueado").map((c) => c.id);

	// Cuántas preguntas hay por tipo entre los capítulos que tiene abiertos
	const porTipo = abiertos.length
		? await db
				.select({
					type: schema.questionBank.type,
					n: sql<number>`count(*)`,
				})
				.from(schema.questionBank)
				.where(
					and(
						eq(schema.questionBank.active, true),
						inArray(schema.questionBank.chapterId, abiertos),
					),
				)
				.groupBy(schema.questionBank.type)
		: [];

	// El Modo Código no bebe del banco: necesita ejercicios con tests.
	const conTests = abiertos.length
		? (
				await db
					.select({ testsJson: schema.exercises.testsJson })
					.from(schema.exercises)
					.where(inArray(schema.exercises.chapterId, abiertos))
			).filter((e) => leerTests(e.testsJson).length > 0).length
		: 0;

	const stats = await cargarStats(db, user.id);

	// ¿Ya jugó el reto de hoy?
	const inicioDelDia = new Date();
	inicioDelDia.setUTCHours(0, 0, 0, 0);
	const [retoHoy] = await db
		.select({ id: schema.practiceAttempts.id })
		.from(schema.practiceAttempts)
		.where(
			and(
				eq(schema.practiceAttempts.userId, user.id),
				eq(schema.practiceAttempts.mode, "reto_dia"),
				gte(schema.practiceAttempts.createdAt, inicioDelDia),
			),
		)
		.limit(1);

	return {
		user,
		disponibles: Object.fromEntries(porTipo.map((t) => [t.type, Number(t.n)])),
		stats: {
			xp: stats.xp,
			streakDays: stats.streakDays,
			bestStreak: stats.bestStreak,
			nivel: nivelDe(stats.xp),
			insignias: listarInsignias(stats.badgesJson).filter((i) => i.ganada).length,
		},
		retoJugado: Boolean(retoHoy),
		modoCodigo: modoCodigoActivo(env) && conTests > 0,
		ejerciciosConTests: conTests,
	};
}

export default function Arcade({ loaderData }: Route.ComponentProps) {
	const { user, disponibles, stats, retoJugado, modoCodigo, ejerciciosConTests } =
		loaderData;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-5xl px-4 pb-24 sm:px-5">
				<header className="jc-anim-in py-10 sm:py-14">
					<Link
						to="/practica"
						className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
					>
						← práctica
					</Link>
					<h1 className="jc-display jc-grad mt-4 text-4xl sm:text-5xl">🕹️ Arcade</h1>
					<p className="mt-3 text-[var(--color-tinta-2)]">
						Preguntas cortas de los capítulos que ya tienes abiertos. Cada acierto suma XP.
					</p>

					{/* Estado del jugador */}
					<div className="jc-glass mt-7 flex flex-wrap items-center gap-6 p-5">
						<div>
							<p className="jc-display text-2xl">
								{stats.nivel.actual.emoji} {stats.nivel.actual.nombre}
							</p>
							<p className="jc-mono text-xs text-[var(--color-tinta-2)]">
								{stats.xp} XP
								{stats.nivel.siguiente
									? ` · faltan ${stats.nivel.faltan} para ${stats.nivel.siguiente.nombre}`
									: " · nivel máximo"}
							</p>
						</div>
						<div className="min-w-[180px] flex-1">
							<BarraProgreso valor={stats.nivel.progreso} total={100} />
						</div>
						<div className="jc-mono text-xs text-[var(--color-tinta-2)]">
							🔥 {stats.streakDays} días · 🏅 {stats.insignias} insignias
						</div>
					</div>
				</header>

				<div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
					{ORDEN_MODOS.map((slug) => {
						const m = MODOS[slug];
						const hay =
							slug === "codigo"
								? modoCodigo
								: m.tipos.some((t) => (disponibles[t] ?? 0) > 0);
						const bloqueado = !hay || (slug === "reto" && retoJugado);

						const contenido = (
							<>
								<span className="text-4xl">{m.emoji}</span>
								<h2
									className="jc-display mt-3 text-xl"
									style={{ color: `rgb(${m.color})` }}
								>
									{m.nombre}
								</h2>
								<p className="mt-2 flex-1 text-sm text-[var(--color-tinta-2)]">{m.blurb}</p>
								<span className="jc-mono mt-4 text-xs text-[var(--color-tinta-2)]">
									{slug === "reto" && retoJugado
										? "ya lo jugaste hoy — vuelve mañana"
										: slug === "codigo"
											? hay
												? `${ejerciciosConTests} ejercicios con tests`
												: "modo código apagado"
											: !hay
												? "sin preguntas todavía"
												: `${m.vidas ? `${m.vidas} vidas · ` : ""}${
														m.segundos ? `${m.segundos}s` : `${m.limite} preguntas`
													}`}
								</span>
							</>
						);

						if (bloqueado) {
							return (
								<div
									key={slug}
									className="jc-cap jc-cap-bloqueado flex flex-col p-6"
									title="Todavía no disponible"
								>
									{contenido}
								</div>
							);
						}

						return (
							<Link
								key={slug}
								to={`/practica/arcade/${slug}`}
								className="jc-cap jc-cap-disponible flex flex-col p-6"
								style={{ borderColor: `rgba(${m.color},.35)` }}
							>
								{contenido}
							</Link>
						);
					})}
				</div>

				<div className="mt-10 flex flex-wrap gap-3">
					<Link to="/perfil" className="jc-btn jc-btn-ghost">
						👤 Mi perfil
					</Link>
					<Link to="/ranking" className="jc-btn jc-btn-ghost">
						🏆 Ranking
					</Link>
				</div>
			</main>
		</>
	);
}
