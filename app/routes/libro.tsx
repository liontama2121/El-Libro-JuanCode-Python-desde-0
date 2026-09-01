import { sql } from "drizzle-orm";
import { Link } from "react-router";
import { Nav } from "~/components/nav";
import { BarraProgreso, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { romano } from "~/lib/format";
import { cargarLibro, type CapituloConEstado } from "~/lib/progress.server";
import type { Route } from "./+types/libro";

export const meta: Route.MetaFunction = () => [
	{ title: "El Libro JuanCode — Python desde 0" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const esProfesor = user.role === "teacher";
	const { partes } = await cargarLibro(db, user.id, esProfesor);

	const [{ total }] = await db
		.select({ total: sql<number>`count(*)` })
		.from(schema.chapters);

	const completados = partes
		.flatMap((p) => p.capitulos)
		.filter((c) => c.estado === "completado").length;

	return { user, partes, total: Number(total) || 0, completados };
}

export default function Libro({ loaderData }: Route.ComponentProps) {
	const { user, partes, total, completados } = loaderData;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-5xl px-5 pb-24">
				{/* Portada -------------------------------------------------------- */}
				<section className="jc-anim-in py-16 text-center sm:py-24">
					<p className="jc-mono text-xs tracking-[0.32em] text-[var(--color-cyan)] uppercase">
						libro digital interactivo
					</p>
					<h1 className="jc-display jc-grad mt-5 text-6xl leading-[1.05] sm:text-7xl">
						El Libro
						<br />
						JuanCode
					</h1>
					<p className="jc-display mt-4 text-xl text-[var(--color-tinta)]">
						Python desde 0 🐍
					</p>
					<p className="jc-mono mt-3 text-sm tracking-[0.2em] text-[var(--color-tinta-2)] uppercase">
						por JuanCode
					</p>

					<div className="mx-auto mt-10 max-w-md">
						<BarraProgreso
							valor={completados}
							total={total}
							etiqueta={`${completados} de ${total} capítulos`}
						/>
					</div>
				</section>

				{/* Índice --------------------------------------------------------- */}
				<div className="space-y-14">
					{partes.map((parte) => (
						<section key={parte.id} className="jc-anim-in">
							<header className="mb-5 flex items-center gap-3 border-b border-[var(--color-borde)] pb-3">
								<span className="text-3xl">{parte.emoji}</span>
								<div>
									<p className="jc-mono text-[0.68rem] tracking-[0.24em] text-[var(--color-tinta-2)] uppercase">
										Parte {romano(parte.number)}
									</p>
									<h2 className="jc-display text-2xl">{parte.title}</h2>
								</div>
							</header>

							<div className="grid gap-4 sm:grid-cols-2">
								{parte.capitulos.map((c) => (
									<CardCapitulo key={c.id} capitulo={c} />
								))}
								{parte.capitulos.length === 0 && (
									<p className="text-sm text-[var(--color-tinta-2)]">
										Todavía no hay capítulos publicados en esta parte.
									</p>
								)}
							</div>
						</section>
					))}
				</div>
			</main>
		</>
	);
}

function CardCapitulo({ capitulo }: { capitulo: CapituloConEstado }) {
	const bloqueado = capitulo.estado === "bloqueado";
	const clase = `jc-cap jc-cap-${capitulo.estado}`;

	const contenido = (
		<>
			<div className="flex items-start gap-3">
				<span className={`text-2xl ${bloqueado ? "grayscale" : ""}`}>
					{bloqueado ? "🔒" : capitulo.emoji}
				</span>
				<div className="min-w-0 flex-1">
					<p className="jc-mono text-[0.66rem] tracking-[0.22em] text-[var(--color-tinta-2)] uppercase">
						Capítulo {capitulo.number}
					</p>
					<h3 className="jc-display mt-0.5 truncate text-lg">{capitulo.title}</h3>
				</div>
				<Estado estado={capitulo.estado} publicado={capitulo.published} />
			</div>
			{capitulo.description && (
				<p className="mt-3 line-clamp-2 text-sm text-[var(--color-tinta-2)]">
					{capitulo.description}
				</p>
			)}
		</>
	);

	if (bloqueado) {
		return (
			<div className={clase} title="Aprueba el quiz del capítulo anterior 🔒">
				{contenido}
			</div>
		);
	}

	return (
		<Link to={`/libro/capitulo/${capitulo.number}`} className={clase}>
			{contenido}
		</Link>
	);
}

function Estado({
	estado,
	publicado,
}: {
	estado: string;
	publicado: boolean;
}) {
	if (!publicado) {
		return (
			<span className="jc-badge text-[var(--color-tinta-2)]">borrador</span>
		);
	}
	if (estado === "completado") {
		return <span className="text-xl text-[var(--color-verde)]">✅</span>;
	}
	if (estado === "disponible") {
		return <span className="text-xl">📖</span>;
	}
	return <span className="text-xl opacity-60">🔒</span>;
}
