import { desc, eq } from "drizzle-orm";
import { Link } from "react-router";
import { Nav } from "~/components/nav";
import { BarraProgreso, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { formatearFecha, formatoReloj } from "~/lib/format";
import {
	actividad30Dias,
	cargarStats,
	contadoresDe,
	listarInsignias,
	nivelDe,
} from "~/lib/gamification.server";
import type { Route } from "./+types/perfil";

export const meta: Route.MetaFunction = () => [
	{ title: "Mi perfil — El Libro JuanCode" },
];

const NOMBRE_MODO: Record<string, string> = {
	simulacro_quiz: "🎯 Simulacro de quiz",
	simulacro_parcial: "📝 Simulacro de parcial",
	arcade_relampago: "⚡ Relámpago",
	arcade_detective: "🕵️ Detective",
	arcade_puzzle: "🧩 Rompecabezas",
	arcade_sorpresa: "🎲 Sorpresa",
	arcade_codigo: "💻 Modo código",
	reto_dia: "🗓️ Reto del día",
};

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const stats = await cargarStats(db, user.id);

	const [intentos, quizzes, actividad] = await Promise.all([
		db
			.select()
			.from(schema.practiceAttempts)
			.where(eq(schema.practiceAttempts.userId, user.id))
			.orderBy(desc(schema.practiceAttempts.createdAt))
			.limit(25),
		db
			.select({
				id: schema.quizAttempts.id,
				score: schema.quizAttempts.score,
				passed: schema.quizAttempts.passed,
				createdAt: schema.quizAttempts.createdAt,
				numero: schema.chapters.number,
				titulo: schema.chapters.title,
			})
			.from(schema.quizAttempts)
			.innerJoin(schema.quizzes, eq(schema.quizzes.id, schema.quizAttempts.quizId))
			.innerJoin(schema.chapters, eq(schema.chapters.id, schema.quizzes.chapterId))
			.where(eq(schema.quizAttempts.userId, user.id))
			.orderBy(desc(schema.quizAttempts.createdAt))
			.limit(25),
		actividad30Dias(db, user.id),
	]);

	return {
		user,
		xp: stats.xp,
		nivel: nivelDe(stats.xp),
		streakDays: stats.streakDays,
		bestStreak: stats.bestStreak,
		insignias: listarInsignias(stats.badgesJson),
		contadores: contadoresDe(stats.badgesJson),
		intentos,
		quizzes,
		actividad,
	};
}

export default function Perfil({ loaderData }: Route.ComponentProps) {
	const {
		user,
		xp,
		nivel,
		streakDays,
		bestStreak,
		insignias,
		contadores,
		intentos,
		quizzes,
		actividad,
	} = loaderData;

	const maxActividad = Math.max(1, ...actividad.map((a) => a.n));
	const ganadas = insignias.filter((i) => i.ganada).length;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-4xl px-4 pb-24 sm:px-5">
				<header className="jc-anim-in py-10 sm:py-14">
					<p className="jc-mono text-xs tracking-[0.3em] text-[var(--color-cyan)] uppercase">
						mi progreso
					</p>
					<h1 className="jc-display jc-grad mt-3 text-4xl sm:text-5xl">{user.name}</h1>
					<p className="jc-mono mt-2 text-sm text-[var(--color-tinta-2)]">
						@{user.username}
					</p>
				</header>

				{/* Nivel y XP */}
				<section className="jc-glass p-6 sm:p-7">
					<div className="flex flex-wrap items-end justify-between gap-4">
						<div>
							<p className="jc-display text-3xl">
								{nivel.actual.emoji} {nivel.actual.nombre}
							</p>
							<p className="jc-mono mt-1 text-sm text-[var(--color-dorado)]">{xp} XP</p>
						</div>
						<div className="text-right">
							<p className="jc-display text-2xl text-[var(--color-naranja)]">
								🔥 {streakDays}
							</p>
							<p className="jc-mono text-xs text-[var(--color-tinta-2)]">
								días seguidos · mejor: {bestStreak}
							</p>
						</div>
					</div>

					<div className="mt-6">
						<BarraProgreso
							valor={nivel.progreso}
							total={100}
							etiqueta={
								nivel.siguiente
									? `Faltan ${nivel.faltan} XP para ${nivel.siguiente.emoji} ${nivel.siguiente.nombre}`
									: "Nivel máximo alcanzado"
							}
						/>
					</div>
				</section>

				{/* Insignias */}
				<section className="mt-10">
					<h2 className="jc-display text-2xl">
						🏅 Insignias{" "}
						<span className="jc-mono text-sm text-[var(--color-tinta-2)]">
							{ganadas}/{insignias.length}
						</span>
					</h2>

					<div className="mt-5 grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
						{insignias.map((i) => (
							<div
								key={i.id}
								className={`rounded-2xl border p-4 ${
									i.ganada
										? "border-[rgba(255,212,59,.45)] bg-[rgba(255,212,59,.07)]"
										: "border-[var(--color-borde)] bg-white/[0.02] opacity-45 grayscale"
								}`}
							>
								<p className="jc-display text-lg">
									{i.ganada ? i.emoji : "🔒"} {i.nombre}
								</p>
								<p className="mt-1 text-xs text-[var(--color-tinta-2)]">{i.texto}</p>
								{!i.ganada && i.id === "cazador_bugs" && (
									<p className="jc-mono mt-2 text-[0.65rem] text-[var(--color-tinta-2)]">
										{contadores.find_bug ?? 0}/20
									</p>
								)}
								{!i.ganada && i.id === "arquitecto" && (
									<p className="jc-mono mt-2 text-[0.65rem] text-[var(--color-tinta-2)]">
										{contadores.parsons ?? 0}/20
									</p>
								)}
							</div>
						))}
					</div>
				</section>

				{/* Actividad */}
				<section className="mt-12">
					<h2 className="jc-display text-2xl">📈 Últimos 30 días</h2>
					<div className="jc-glass mt-5 flex items-end gap-[3px] overflow-x-auto p-5 sm:gap-1.5">
						{actividad.map((a) => (
							<div
								key={a.dia}
								title={`${a.dia}: ${a.n} actividades`}
								className="min-w-[8px] flex-1 rounded-t-sm"
								style={{
									height: `${8 + (a.n / maxActividad) * 72}px`,
									background:
										a.n === 0
											? "rgba(255,255,255,.07)"
											: "linear-gradient(180deg, var(--color-cyan), var(--color-purpura))",
								}}
							/>
						))}
					</div>
					<p className="jc-mono mt-2 text-xs text-[var(--color-tinta-2)]">
						cada barra es un día · pasa el dedo para ver el detalle
					</p>
				</section>

				{/* Historial */}
				<section className="mt-12 grid gap-8 lg:grid-cols-2">
					<div>
						<h2 className="jc-display text-2xl">🎯 Quizzes de capítulo</h2>
						<ul className="mt-4 space-y-2">
							{quizzes.map((q) => (
								<li
									key={q.id}
									className="flex items-center gap-3 rounded-xl border border-[var(--color-borde)]
										bg-white/[0.03] px-4 py-2.5 text-sm"
								>
									<span>{q.passed ? "✅" : "❌"}</span>
									<span className="flex-1 truncate">
										<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
											{q.numero}.
										</span>{" "}
										{q.titulo}
									</span>
									<span className="jc-mono text-xs">{q.score}</span>
									<span className="jc-mono text-[0.65rem] text-[var(--color-tinta-2)]">
										{formatearFecha(q.createdAt)}
									</span>
								</li>
							))}
							{quizzes.length === 0 && (
								<li className="text-sm text-[var(--color-tinta-2)]">
									Todavía no has presentado ningún quiz.
								</li>
							)}
						</ul>
					</div>

					<div>
						<h2 className="jc-display text-2xl">🕹️ Práctica</h2>
						<ul className="mt-4 space-y-2">
							{intentos.map((a) => (
								<li
									key={a.id}
									className="flex items-center gap-3 rounded-xl border border-[var(--color-borde)]
										bg-white/[0.03] px-4 py-2.5 text-sm"
								>
									<span className="flex-1 truncate">
										{NOMBRE_MODO[a.mode] ?? a.mode}
									</span>
									<span className="jc-mono text-xs">
										{a.score}/{a.total}
									</span>
									{a.xpEarned > 0 && (
										<span className="jc-mono text-[0.65rem] text-[var(--color-dorado)]">
											+{a.xpEarned}
										</span>
									)}
									<span className="jc-mono text-[0.65rem] text-[var(--color-tinta-2)]">
										{formatoReloj(a.durationSeconds)}
									</span>
								</li>
							))}
							{intentos.length === 0 && (
								<li className="text-sm text-[var(--color-tinta-2)]">
									Todavía no has practicado. {""}
									<Link className="text-[var(--color-cyan)] underline" to="/practica">
										Empieza aquí
									</Link>
									.
								</li>
							)}
						</ul>
					</div>
				</section>

				<div className="mt-12 flex flex-wrap gap-3">
					<Link to="/practica" className="jc-btn jc-btn-ghost">
						🎮 Práctica
					</Link>
					<Link to="/ranking" className="jc-btn jc-btn-ghost">
						🏆 Ranking
					</Link>
				</div>
			</main>
		</>
	);
}
