import { and, eq, sql } from "drizzle-orm";
import { ArrowRight, CheckCircle, LockSimple } from "@phosphor-icons/react";
import { Link, redirect } from "react-router";
import { Muro } from "~/components/muro";
import { Nav } from "~/components/nav";
import { BarraProgreso, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { cargarStats, nivelDe } from "~/lib/gamification.server";
import { romano } from "~/lib/format";
import { cargarLibro, type CapituloConEstado } from "~/lib/progress.server";
import {
	TRACK_INFO,
	palabraCapitulo,
	puedeVerTrack,
	rutaCapitulo,
	rutaLibro,
	rutaQuiz,
	trackDeRuta,
	tracksVisibles,
} from "~/lib/tracks";
import type { Track } from "~/db/schema";
import type { Route } from "./+types/libro";

export const meta: Route.MetaFunction = () => [
	{ title: "El Libro JuanCode — Python desde 0" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const esProfesor = user.role === "teacher";

	// Un mismo componente sirve los dos libros: el track sale de la URL.
	const track = trackDeRuta(request.url);
	if (!puedeVerTrack(user.track, track, esProfesor)) {
		throw redirect(rutaLibro(tracksVisibles(user.track)[0]));
	}

	const { partes } = await cargarLibro(db, user.id, esProfesor, track);

	const [{ total }] = await db
		.select({ total: sql<number>`count(*)` })
		.from(schema.chapters)
		.where(eq(schema.chapters.track, track));

	// Aviso de repaso: si viene al avanzado sin haber tocado el básico, se le
	// ofrece ayuda. No bloquea nada — es una invitación, no un muro.
	const repaso =
		track === "avanzado" && !esProfesor
			? await progresoDelBasico(db, user.id)
			: null;

	const completados = partes
		.flatMap((p) => p.capitulos)
		.filter((c) => c.estado === "completado").length;

	const stats = await cargarStats(db, user.id);
	const nivel = nivelDe(stats.xp);

	return {
		user,
		track,
		repaso,
		whatsapp: env.WHATSAPP_URL ?? "",
		partes,
		total: Number(total) || 0,
		completados,
		navStats: {
			xp: stats.xp,
			emoji: nivel.actual.emoji,
			nombre: nivel.actual.nombre,
			progreso: nivel.progreso,
		},
	};
}

/** Cuántos capítulos del libro básico lleva aprobados este estudiante. */
async function progresoDelBasico(db: ReturnType<typeof getDb>, userId: string) {
	const [{ total }] = await db
		.select({ total: sql<number>`count(*)` })
		.from(schema.chapters)
		.where(
			and(eq(schema.chapters.track, "basico"), eq(schema.chapters.published, true)),
		);

	const [{ hechos }] = await db
		.select({ hechos: sql<number>`count(distinct ${schema.chapters.id})` })
		.from(schema.quizAttempts)
		.innerJoin(schema.quizzes, eq(schema.quizzes.id, schema.quizAttempts.quizId))
		.innerJoin(schema.chapters, eq(schema.chapters.id, schema.quizzes.chapterId))
		.where(
			and(
				eq(schema.quizAttempts.userId, userId),
				eq(schema.quizAttempts.passed, true),
				eq(schema.chapters.track, "basico"),
			),
		);

	return { hechos: Number(hechos) || 0, total: Number(total) || 0 };
}

export default function Libro({ loaderData }: Route.ComponentProps) {
	const { user, track, repaso, whatsapp, partes, total, completados, navStats } =
		loaderData;

	const avanzado = track === "avanzado";
	const info = TRACK_INFO[track];

	return (
		<>
			<Nav user={user} stats={navStats} />
			<Toast />

			{/* Portada ---------------------------------------------------------- */}
			<section className="grid border-b-2 border-[var(--color-borde)] md:grid-cols-[1.25fr_0.75fr]">
				<div className="jc-anim-in w-full px-5 py-14 sm:py-20 md:pr-14 md:pl-[max(1.25rem,calc((100vw-64rem)/2+1.25rem))]">
					<p
						className={`text-xs font-bold tracking-[0.06em] uppercase [font-variation-settings:'wdth'_125] ${
							avanzado
								? "text-[var(--color-magenta)]"
								: "text-[var(--color-cyan)]"
						}`}
					>
						{avanzado ? "track avanzado" : "libro digital interactivo"}
					</p>
					<h1 className="jc-display mt-5 text-6xl sm:text-8xl">
						El Libro
						<br />
						JuanCode
					</h1>
					<p className="mt-5 text-xl text-[var(--color-tinta-2)]">
						{info.nombre} {info.emoji}
					</p>

					<div className="mt-10 max-w-md">
						<BarraProgreso
							valor={completados}
							total={total}
							etiqueta={`${completados} de ${total} ${
								avanzado ? "módulos" : "capítulos"
							}`}
						/>
					</div>
				</div>
				<div className="relative hidden min-h-[320px] border-l border-[var(--color-borde)] md:block">
					<Muro />
				</div>
			</section>

			<main className="mx-auto max-w-5xl px-5 pt-14 pb-24">

				{/* Aviso de repaso ------------------------------------------------ */}
				{repaso && repaso.hechos < repaso.total && (
					<aside className="jc-anim-in mb-10 flex flex-wrap items-center gap-3 border-t border-[var(--color-cyan)] bg-[var(--color-noche-2)] px-5 py-4">
						<p className="min-w-0 flex-1 text-sm text-[var(--color-tinta-2)]">
							Este track asume que ya manejas lo básico.{" "}
							{repaso.hechos > 0
								? `Llevas ${repaso.hechos} de ${repaso.total} capítulos del libro básico.`
								: "¿Necesitas repasar antes de arrancar?"}
						</p>
						{whatsapp && (
							<a
								href={whatsapp}
								target="_blank"
								rel="noopener"
								className="jc-btn jc-btn-sm jc-btn-ghost shrink-0"
							>
								Escríbeme por WhatsApp
							</a>
						)}
					</aside>
				)}

				{/* Índice --------------------------------------------------------- */}
				<div className="space-y-14">
					{partes.map((parte) => (
						<section key={parte.id} className="jc-anim-in">
							<header className="mb-6 flex items-end gap-4 border-b border-[color-mix(in_srgb,var(--color-cyan)_40%,transparent)] pb-3">
								<span className="text-3xl">{parte.emoji}</span>
								<div>
									<p className="text-sm font-semibold text-[var(--color-tinta-2)]">
										Parte {romano(parte.number)}
									</p>
									<h2 className="jc-display text-3xl">{parte.title}</h2>
								</div>
							</header>

							<div className="grid gap-4 sm:grid-cols-2">
								{parte.capitulos.map((c) => (
									<CardCapitulo key={c.id} capitulo={c} track={track} />
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

function CardCapitulo({
	capitulo,
	track,
}: {
	capitulo: CapituloConEstado;
	track: Track;
}) {
	const bloqueado = capitulo.estado === "bloqueado";
	const clase = `jc-cap jc-cap-${capitulo.estado}`;

	const contenido = (
		<>
			<div className="flex items-start gap-3">
				<span className={`text-2xl ${bloqueado ? "opacity-50 grayscale" : ""}`}>
					{capitulo.emoji}
				</span>
				<div className="min-w-0 flex-1">
					<div className="flex items-center gap-2">
						<p className="text-sm font-semibold text-[var(--color-tinta-2)]">
							{palabraCapitulo(track)} {capitulo.number}
						</p>
						{track === "avanzado" && (
							<span className="jc-mono rounded-full border border-[color-mix(in_srgb,var(--color-magenta)_40%,transparent)] bg-[color-mix(in_srgb,var(--color-magenta)_12%,transparent)] px-2 py-[1px] text-[0.58rem] tracking-[0.14em] text-[var(--color-magenta)] uppercase">
								Avanzado
							</span>
						)}
					</div>
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
		<Link to={rutaCapitulo(track, capitulo.number)} className={clase}>
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
		return <CheckCircle size={24} weight="fill" aria-label="Completado" className="text-[var(--color-verde)]" />;
	}
	if (estado === "disponible") {
		return <ArrowRight size={22} aria-label="Disponible" className="text-[var(--color-cyan)]" />;
	}
	return <LockSimple size={22} aria-label="Bloqueado" className="text-[var(--color-tinta-2)]" />;
}
