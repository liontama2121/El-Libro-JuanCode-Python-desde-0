import { sql } from "drizzle-orm";
import { Link } from "react-router";
import { Nav } from "~/components/nav";
import { Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { cargarStats, nivelDe } from "~/lib/gamification.server";
import { cargarLibro } from "~/lib/progress.server";
import type { Route } from "./+types/practica";

export const meta: Route.MetaFunction = () => [
	{ title: "Práctica — El Libro JuanCode" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const { capitulos } = await cargarLibro(db, user.id, user.role === "teacher");
	const abiertos = capitulos.filter((c) => c.estado !== "bloqueado");

	const [{ preguntas }] = await db
		.select({ preguntas: sql<number>`count(*)` })
		.from(schema.questionBank)
		.where(sql`${schema.questionBank.active} = 1`);

	const stats = await cargarStats(db, user.id);
	const nivel = nivelDe(stats.xp);

	return {
		user,
		capitulosAbiertos: abiertos.length,
		preguntas: Number(preguntas) || 0,
		navStats: {
			xp: stats.xp,
			emoji: nivel.actual.emoji,
			nombre: nivel.actual.nombre,
			progreso: nivel.progreso,
		},
	};
}

const MODOS = [
	{
		to: "/practica/simulacro-quiz",
		emoji: "🎯",
		titulo: "Simulacro de quiz",
		texto: "Preguntas al azar de los capítulos que ya tienes abiertos. Tú eliges cuántas y si quieres cronómetro.",
		color: "0,229,255",
	},
	{
		to: "/practica/simulacro-parcial",
		emoji: "📝",
		titulo: "Simulacro de parcial",
		texto: "Cuatro puntos de programación estilo universidad, 90 minutos, con editor de código.",
		color: "255,169,77",
	},
	{
		to: "/practica/arcade",
		emoji: "🕹️",
		titulo: "Arcade",
		texto: "Relámpago, Detective, Rompecabezas, Sorpresa y el Reto del día. Rápido y con XP.",
		color: "255,77,255",
	},
];

export default function Practica({ loaderData }: Route.ComponentProps) {
	const { user, capitulosAbiertos, preguntas, navStats } = loaderData;

	return (
		<>
			<Nav user={user} stats={navStats} />
			<Toast />

			<main className="mx-auto max-w-5xl px-4 pb-24 sm:px-5">
				<header className="jc-anim-in py-12 text-center sm:py-16">
					<p className="jc-mono text-xs tracking-[0.3em] text-[var(--color-cyan)] uppercase">
						entrenamiento
					</p>
					<h1 className="jc-display jc-grad mt-4 text-4xl sm:text-6xl">Práctica</h1>
					<p className="mt-4 text-[var(--color-tinta-2)]">
						Aquí no se desbloquea nada: se entrena. Equivócate todo lo que quieras.
					</p>
					<p className="jc-mono mt-3 text-xs text-[var(--color-tinta-2)]">
						{capitulosAbiertos} capítulos abiertos · {preguntas} preguntas en el banco
					</p>
				</header>

				<div className="grid gap-5 sm:grid-cols-3">
					{MODOS.map((m) => (
						<Link
							key={m.to}
							to={m.to}
							className="jc-cap jc-cap-disponible flex flex-col p-6 text-left"
							style={{ borderColor: `rgba(${m.color},.35)` }}
						>
							<span className="text-4xl">{m.emoji}</span>
							<h2 className="jc-display mt-4 text-xl" style={{ color: `rgb(${m.color})` }}>
								{m.titulo}
							</h2>
							<p className="mt-2 flex-1 text-sm text-[var(--color-tinta-2)]">{m.texto}</p>
							<span className="jc-mono mt-5 text-xs tracking-[0.18em] uppercase" style={{ color: `rgb(${m.color})` }}>
								empezar →
							</span>
						</Link>
					))}
				</div>
			</main>
		</>
	);
}
