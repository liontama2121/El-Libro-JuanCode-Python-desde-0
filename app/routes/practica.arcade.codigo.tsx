import { and, desc, eq, inArray, isNotNull, like, sql } from "drizzle-orm";
import { useEffect, useState } from "react";
import { Link, redirect, useFetcher } from "react-router";
import { Nav } from "~/components/nav";
import { ProbarCodigo } from "~/components/probar-codigo";
import { BadgeDificultad, Confetti, Toast, ToastInsignias } from "~/components/ui";
import { getDb, schema } from "~/db";
import type { Dificultad } from "~/db/schema";
import { requireUser } from "~/lib/auth.server";
import { formatoReloj } from "~/lib/format";
import { otorgar, XP_ARCADE } from "~/lib/gamification.server";
import { leerTests, modoCodigoActivo } from "~/lib/piston.server";
import { cargarLibro } from "~/lib/progress.server";
import type { Route } from "./+types/practica.arcade.codigo";

export const meta: Route.MetaFunction = () => [
	{ title: "Modo código — Arcade" },
];

/* -------------------------------------------------------------------------- */
/*  LOADER — un ejercicio al azar con tests                                    */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	if (!modoCodigoActivo(env)) {
		throw redirect(
			`/practica/arcade?toast=${encodeURIComponent(
				"El Modo Código está apagado por ahora 💤",
			)}`,
		);
	}

	const { capitulos } = await cargarLibro(db, user.id, user.role === "teacher");
	const chapterIds = capitulos
		.filter((c) => c.estado !== "bloqueado")
		.map((c) => c.id);

	const candidatos = chapterIds.length
		? await db
				.select()
				.from(schema.exercises)
				.where(
					and(
						inArray(schema.exercises.chapterId, chapterIds),
						isNotNull(schema.exercises.testsJson),
					),
				)
				.orderBy(sql`random()`)
				.limit(10)
		: [];

	const ejercicio = candidatos.find((e) => leerTests(e.testsJson).length > 0);

	if (!ejercicio) {
		throw redirect(
			`/practica/arcade?toast=${encodeURIComponent(
				"Todavía no hay ejercicios con tests en tus capítulos 🙃",
			)}`,
		);
	}

	const capitulo = capitulos.find((c) => c.id === ejercicio.chapterId);

	return {
		user,
		ejercicio: {
			id: ejercicio.id,
			title: ejercicio.title,
			difficulty: ejercicio.difficulty,
			statementHtml: ejercicio.statementHtml,
			hintHtml: ejercicio.hintHtml,
			starterCode: ejercicio.starterCode ?? "",
			capitulo: capitulo ? `${capitulo.number}. ${capitulo.title}` : "",
			cuantosTests: leerTests(ejercicio.testsJson).length,
		},
	};
}

/* -------------------------------------------------------------------------- */
/*  ACTION — la XP se paga aquí, comprobando el code_run en la base            */
/* -------------------------------------------------------------------------- */

export type CobroCodigo = {
	cobrado: true;
	xp: number;
	repetido: boolean;
	insignias: { emoji: string; nombre: string; texto: string }[];
};

export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const form = await request.formData();
	const exerciseId = Number(form.get("exerciseId"));
	const segundos = Math.max(0, Number(form.get("segundos")) || 0);

	const [ejercicio] = await db
		.select()
		.from(schema.exercises)
		.where(eq(schema.exercises.id, exerciseId))
		.limit(1);
	if (!ejercicio) throw new Response("Ejercicio no encontrado", { status: 404 });

	// La prueba de que lo resolvió está en code_runs, no en lo que diga el cliente.
	const [aprobado] = await db
		.select({ id: schema.codeRuns.id })
		.from(schema.codeRuns)
		.where(
			and(
				eq(schema.codeRuns.userId, user.id),
				eq(schema.codeRuns.exerciseId, exerciseId),
				eq(schema.codeRuns.passed, true),
			),
		)
		.orderBy(desc(schema.codeRuns.createdAt))
		.limit(1);

	if (!aprobado) {
		throw new Response("Todavía no has pasado todos los tests", { status: 400 });
	}

	// Cada ejercicio paga XP una sola vez.
	const [yaCobrado] = await db
		.select({ id: schema.practiceAttempts.id })
		.from(schema.practiceAttempts)
		.where(
			and(
				eq(schema.practiceAttempts.userId, user.id),
				eq(schema.practiceAttempts.mode, "arcade_codigo"),
				like(schema.practiceAttempts.configJson, `%"exerciseId":${exerciseId}%`),
			),
		)
		.limit(1);

	const xpBase = yaCobrado
		? 0
		: (XP_ARCADE[ejercicio.difficulty as Dificultad] ?? XP_ARCADE.facil);

	const premio = await otorgar(db, user.id, { xp: xpBase });

	if (!yaCobrado) {
		await db.insert(schema.practiceAttempts).values({
			userId: user.id,
			mode: "arcade_codigo",
			configJson: JSON.stringify({ exerciseId }),
			score: 1,
			total: 1,
			xpEarned: premio.xp,
			durationSeconds: segundos,
			detailJson: JSON.stringify({ difficulty: ejercicio.difficulty }),
		});
	}

	const cobro: CobroCodigo = {
		cobrado: true,
		xp: premio.xp,
		repetido: Boolean(yaCobrado),
		insignias: premio.nuevasInsignias.map((i) => ({
			emoji: i.emoji,
			nombre: i.nombre,
			texto: i.texto,
		})),
	};
	return cobro;
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function ArcadeCodigo({ loaderData }: Route.ComponentProps) {
	const { user, ejercicio } = loaderData;
	const fetcher = useFetcher<typeof action>();

	const [segundos, setSegundos] = useState(0);
	const [resuelto, setResuelto] = useState(false);
	const [cobro, setCobro] = useState<CobroCodigo | null>(null);

	useEffect(() => {
		if (resuelto) return;
		const id = setInterval(() => setSegundos((s) => s + 1), 1000);
		return () => clearInterval(id);
	}, [resuelto]);

	useEffect(() => {
		if (fetcher.data && "cobrado" in fetcher.data) {
			setCobro(fetcher.data as CobroCodigo);
		}
	}, [fetcher.data]);

	function alResultado(passed: boolean) {
		if (!passed || resuelto) return;
		setResuelto(true);
		fetcher.submit(
			{ exerciseId: String(ejercicio.id), segundos: String(segundos) },
			{ method: "post" },
		);
	}

	return (
		<>
			<Nav user={user} />
			<Confetti activo={resuelto} />
			<ToastInsignias insignias={cobro?.insignias ?? []} />
			<Toast />

			<main className="mx-auto max-w-3xl px-4 py-6 sm:px-5 sm:py-10">
				<header className="mb-7">
					<div className="flex flex-wrap items-center justify-between gap-3">
						<Link
							to="/practica/arcade"
							className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
						>
							← salir
						</Link>
						<span className="jc-mono rounded-full border border-[var(--color-borde)] px-3 py-1 text-sm text-[var(--color-tinta-2)]">
							⏱ {formatoReloj(segundos)}
						</span>
					</div>

					<h1 className="jc-display mt-4 text-2xl text-[var(--color-verde)] sm:text-3xl">
						💻 Modo código
					</h1>

					<div className="mt-3 flex flex-wrap items-center gap-3">
						<BadgeDificultad nivel={ejercicio.difficulty} />
						<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
							{ejercicio.capitulo} · {ejercicio.cuantosTests} tests
						</span>
					</div>
				</header>

				<section className="jc-glass p-5 sm:p-7">
					<h2 className="jc-display text-xl">{ejercicio.title}</h2>

					{ejercicio.statementHtml && (
						<div
							className="jc-prosa mt-4 text-[1rem]"
							dangerouslySetInnerHTML={{ __html: ejercicio.statementHtml }}
						/>
					)}

					{ejercicio.hintHtml && (
						<details className="mt-5">
							<summary className="jc-btn jc-btn-sm jc-btn-ghost list-none marker:content-none">
								💡 Ver pista
							</summary>
							<div
								className="jc-prosa mt-3 rounded-2xl border border-[var(--color-borde)] bg-black/30 p-5 text-[1rem]"
								dangerouslySetInnerHTML={{ __html: ejercicio.hintHtml }}
							/>
						</details>
					)}

					<div className="mt-7">
						<ProbarCodigo
							exerciseId={ejercicio.id}
							codigoInicial={ejercicio.starterCode}
							filas={16}
							onResultado={alResultado}
						/>
					</div>
				</section>

				{resuelto && (
					<div className="jc-anim-pop jc-glass mt-8 p-7 text-center">
						<p className="text-4xl">🎉</p>
						<h2 className="jc-display mt-3 text-2xl">¡Todos los tests en verde!</h2>
						{cobro && (
							<p className="jc-mono mt-3 text-[var(--color-dorado)]">
								{cobro.repetido
									? "Este ejercicio ya te había pagado XP"
									: `+${cobro.xp} XP`}
							</p>
						)}
						<div className="mt-6 flex flex-wrap justify-center gap-3">
							<a href="/practica/arcade/codigo" className="jc-btn jc-btn-primary">
								🔁 Otro ejercicio
							</a>
							<Link to="/practica/arcade" className="jc-btn jc-btn-ghost">
								← Arcade
							</Link>
						</div>
					</div>
				)}
			</main>
		</>
	);
}
