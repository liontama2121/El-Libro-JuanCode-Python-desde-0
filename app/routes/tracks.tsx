import { and, eq, inArray } from "drizzle-orm";
import { Link, redirect } from "react-router";
import { Nav } from "~/components/nav";
import { Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import type { Track } from "~/db/schema";
import { requireUser } from "~/lib/auth.server";
import { cargarProgreso } from "~/lib/progress.server";
import { TRACK_INFO, rutaLibro, tracksVisibles } from "~/lib/tracks";
import type { Route } from "./+types/tracks";

export const meta: Route.MetaFunction = () => [
	{ title: "Elige tu ruta — El Libro JuanCode" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const esProfesor = user.role === "teacher";
	const visibles: Track[] = esProfesor
		? ["basico", "avanzado"]
		: tracksVisibles(user.track);

	// Con un solo libro no hay nada que elegir: se entra directo.
	if (visibles.length === 1) throw redirect(rutaLibro(visibles[0]));

	const progreso = await cargarProgreso(db, user.id);

	// Cuántos capítulos publicados tiene cada libro y cuántos lleva aprobados.
	const capitulos = await db
		.select({
			id: schema.chapters.id,
			track: schema.chapters.track,
		})
		.from(schema.chapters)
		.where(
			and(
				eq(schema.chapters.published, true),
				inArray(schema.chapters.track, visibles),
			),
		);

	const resumen = visibles.map((track) => {
		const delTrack = capitulos.filter((c) => c.track === track);
		return {
			track,
			total: delTrack.length,
			completados: delTrack.filter((c) => progreso.passed.has(c.id)).length,
		};
	});

	return { user, resumen };
}

export default function Tracks({ loaderData }: Route.ComponentProps) {
	const { user, resumen } = loaderData;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-4xl px-5 py-12">
				<header className="jc-anim-in text-center">
					<p className="jc-mono text-xs tracking-[0.26em] text-[var(--color-cyan)] uppercase">
						Tienes dos libros
					</p>
					<h1 className="jc-display jc-grad mt-3 text-4xl sm:text-5xl">
						¿Por cuál seguimos hoy?
					</h1>
					<p className="mt-4 text-[var(--color-tinta-2)]">
						Cada uno lleva su propio progreso. Puedes cambiar de libro cuando
						quieras — lo que llevas no se pierde.
					</p>
				</header>

				<div className="jc-anim-in mt-10 grid gap-5 md:grid-cols-2">
					{resumen.map(({ track, total, completados }) => {
						const info = TRACK_INFO[track];
						const avanzado = track === "avanzado";
						const porcentaje = total ? Math.round((completados / total) * 100) : 0;

						return (
							<Link
								key={track}
								to={rutaLibro(track)}
								className={`jc-glass group flex flex-col gap-3 rounded-3xl border-t-4 p-7 transition hover:-translate-y-1.5 ${
									avanzado
										? "border-t-[var(--color-magenta)] hover:border-[rgba(255,77,255,.45)]"
										: "border-t-[var(--color-cyan)] hover:border-[rgba(0,229,255,.45)]"
								}`}
							>
								<span className="text-5xl">{info.emoji}</span>

								<div className="flex items-center gap-2">
									<h2 className="jc-display text-2xl">{info.nombre}</h2>
									{avanzado && (
										<span className="jc-badge border-[rgba(255,77,255,.4)] bg-[rgba(255,77,255,.1)] text-[var(--color-magenta)]">
											Avanzado
										</span>
									)}
								</div>

								<p className="text-[var(--color-tinta-2)]">{info.descripcion}</p>

								<div className="mt-auto pt-4">
									<div className="jc-mono flex justify-between text-xs text-[var(--color-tinta-2)]">
										<span>
											{completados} de {total} completados
										</span>
										<span>{porcentaje}%</span>
									</div>
									<div className="mt-2 h-1.5 overflow-hidden rounded-full bg-white/10">
										<div
											className="h-full rounded-full transition-[width] duration-700"
											style={{
												width: `${porcentaje}%`,
												background: avanzado
													? "linear-gradient(90deg,#b975ff,#FF4DFF)"
													: "linear-gradient(90deg,#00E5FF,#b975ff)",
											}}
										/>
									</div>
								</div>

								<span
									className={`jc-mono mt-3 text-sm font-semibold transition-[gap] ${
										avanzado
											? "text-[var(--color-magenta)]"
											: "text-[var(--color-cyan)]"
									}`}
								>
									Abrir este libro →
								</span>
							</Link>
						);
					})}
				</div>
			</main>
		</>
	);
}
