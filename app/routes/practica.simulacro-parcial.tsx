import { and, eq, inArray, sql } from "drizzle-orm";
import { useEffect, useState } from "react";
import { Form, Link, useFetcher } from "react-router";
import { EditorCodigo } from "~/components/editor";
import { Nav } from "~/components/nav";
import { BadgeDificultad, Toast } from "~/components/ui";
import { getDb, schema } from "~/db";
import type { Dificultad } from "~/db/schema";
import { requireUser } from "~/lib/auth.server";
import { formatoReloj } from "~/lib/format";
import { otorgar } from "~/lib/gamification.server";
import { cargarLibro } from "~/lib/progress.server";
import { firmar, verificar } from "~/lib/sign.server";
import type { Route } from "./+types/practica.simulacro-parcial";

export const meta: Route.MetaFunction = () => [
	{ title: "Simulacro de parcial — El Libro JuanCode" },
];

/** 90 minutos, como un parcial de verdad. */
const MINUTOS = 90;

/** 1 fácil, 2 medios, 1 difícil. */
const REPARTO: [Dificultad, number][] = [
	["facil", 1],
	["medio", 2],
	["dificil", 1],
];

type Sobre = { ejercicios: number[] };

/* -------------------------------------------------------------------------- */
/*  LOADER                                                                     */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const { capitulos } = await cargarLibro(db, user.id, user.role === "teacher");
	const abiertos = capitulos.filter((c) => c.estado !== "bloqueado");
	const chapterIds = abiertos.map((c) => c.id);

	const url = new URL(request.url);
	if (url.searchParams.get("empezar") !== "1") {
		const [{ disponibles }] = chapterIds.length
			? await db
					.select({ disponibles: sql<number>`count(*)` })
					.from(schema.exercises)
					.where(inArray(schema.exercises.chapterId, chapterIds))
			: [{ disponibles: 0 }];

		return {
			user,
			modo: "config" as const,
			capitulos: abiertos.length,
			disponibles: Number(disponibles) || 0,
			minutos: MINUTOS,
		};
	}

	// Un punto por dificultad, al azar entre los capítulos abiertos.
	const puntos: (typeof schema.exercises.$inferSelect)[] = [];
	for (const [dificultad, cuantos] of REPARTO) {
		if (!chapterIds.length) break;
		const lote = await db
			.select()
			.from(schema.exercises)
			.where(
				and(
					inArray(schema.exercises.chapterId, chapterIds),
					eq(schema.exercises.difficulty, dificultad),
				),
			)
			.orderBy(sql`random()`)
			.limit(cuantos);
		puntos.push(...lote.filter((e) => !puntos.some((p) => p.id === e.id)));
	}

	// Si no alcanzan por dificultad, se completa con lo que haya.
	if (puntos.length < 4 && chapterIds.length) {
		const relleno = await db
			.select()
			.from(schema.exercises)
			.where(inArray(schema.exercises.chapterId, chapterIds))
			.orderBy(sql`random()`)
			.limit(8);
		for (const e of relleno) {
			if (puntos.length >= 4) break;
			if (!puntos.some((p) => p.id === e.id)) puntos.push(e);
		}
	}

	const titulos = new Map(abiertos.map((c) => [c.id, `${c.number}. ${c.title}`]));

	return {
		user,
		modo: "parcial" as const,
		minutos: MINUTOS,
		puntos: puntos.map((e) => ({
			id: e.id,
			title: e.title,
			difficulty: e.difficulty,
			statementHtml: e.statementHtml,
			starterCode: e.starterCode ?? "",
			capitulo: titulos.get(e.chapterId) ?? "",
		})),
		token: await firmar(env, { ejercicios: puntos.map((e) => e.id) } satisfies Sobre),
	};
}

/* -------------------------------------------------------------------------- */
/*  ACTION                                                                     */
/* -------------------------------------------------------------------------- */

export type EntregaParcial = {
	attemptId: number;
	soluciones: {
		id: number;
		title: string;
		difficulty: string;
		solutionHtml: string;
		hintHtml: string;
		codigo: string;
	}[];
};

export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	const form = await request.formData();
	const intent = String(form.get("intent") || "entregar");

	/* Autocalificación: el estudiante marca su propio checklist ------------ */
	if (intent === "autocalificar") {
		const attemptId = Number(form.get("attemptId"));
		const puntos = Math.max(0, Math.min(4, Number(form.get("puntos")) || 0));
		const detalle = String(form.get("detalle") || "{}");

		const [intento] = await db
			.select()
			.from(schema.practiceAttempts)
			.where(
				and(
					eq(schema.practiceAttempts.id, attemptId),
					eq(schema.practiceAttempts.userId, user.id),
				),
			)
			.limit(1);

		if (!intento) throw new Response("Intento no encontrado", { status: 404 });

		const previo = JSON.parse(intento.detailJson || "{}");
		await db
			.update(schema.practiceAttempts)
			.set({
				score: puntos,
				detailJson: JSON.stringify({ ...previo, autocalificacion: JSON.parse(detalle) }),
			})
			.where(eq(schema.practiceAttempts.id, attemptId));

		return { guardado: true as const };
	}

	/* Entrega del parcial -------------------------------------------------- */
	const sobre = await verificar<Sobre>(env, String(form.get("token") || ""));
	if (!sobre) throw new Response("Firma inválida", { status: 400 });

	let codigos: Record<string, string> = {};
	try {
		codigos = JSON.parse(String(form.get("codigos") || "{}"));
	} catch {
		codigos = {};
	}
	const segundos = Math.max(0, Number(form.get("segundos")) || 0);

	const ejercicios = await db
		.select()
		.from(schema.exercises)
		.where(inArray(schema.exercises.id, sobre.ejercicios));

	// Entregar el parcial cuenta como día activo (la nota la pone el checklist).
	await otorgar(db, user.id, {});

	const [creado] = await db
		.insert(schema.practiceAttempts)
		.values({
			userId: user.id,
			mode: "simulacro_parcial",
			configJson: JSON.stringify({ ejercicios: sobre.ejercicios, minutos: MINUTOS }),
			score: 0,
			total: sobre.ejercicios.length,
			xpEarned: 0,
			durationSeconds: segundos,
			detailJson: JSON.stringify({
				puntos: sobre.ejercicios.map((id) => ({ id, codigo: codigos[String(id)] ?? "" })),
			}),
		})
		.returning({ id: schema.practiceAttempts.id });

	const entrega: EntregaParcial = {
		attemptId: creado.id,
		soluciones: sobre.ejercicios.flatMap((id) => {
			const e = ejercicios.find((x) => x.id === id);
			if (!e) return [];
			return [
				{
					id: e.id,
					title: e.title,
					difficulty: e.difficulty,
					solutionHtml: e.solutionHtml,
					hintHtml: e.hintHtml,
					codigo: codigos[String(id)] ?? "",
				},
			];
		}),
	};
	return entrega;
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function SimulacroParcial({ loaderData }: Route.ComponentProps) {
	if (loaderData.modo === "config") return <Portada loaderData={loaderData} />;
	return <Parcial loaderData={loaderData} />;
}

type DatosConfig = Extract<Route.ComponentProps["loaderData"], { modo: "config" }>;
type DatosParcial = Extract<Route.ComponentProps["loaderData"], { modo: "parcial" }>;

function Portada({ loaderData }: { loaderData: DatosConfig }) {
	const { user, capitulos, disponibles, minutos } = loaderData;

	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-2xl px-4 py-10 sm:px-5">
				<Link
					to="/practica"
					className="jc-mono text-xs tracking-[0.18em] text-[var(--color-tinta-2)] uppercase hover:text-[var(--color-cyan)]"
				>
					← práctica
				</Link>

				<h1 className="jc-display jc-grad mt-4 text-3xl sm:text-4xl">
					📝 Simulacro de parcial
				</h1>

				<div className="jc-glass mt-7 space-y-4 p-6 sm:p-7">
					<p className="text-[var(--color-tinta-2)]">
						Cuatro puntos de programación tomados al azar de tus capítulos abiertos:
						uno fácil, dos medios y uno difícil. Tienes <strong>{minutos} minutos</strong>,
						igual que en un parcial de verdad.
					</p>
					<ul className="space-y-2 text-sm text-[var(--color-tinta-2)]">
						<li>· Escribes el código de cada punto en su propio editor.</li>
						<li>· Al terminar ves las soluciones documentadas.</li>
						<li>· Te calificas tú con un checklist por punto.</li>
					</ul>
					<p className="jc-mono text-xs text-[var(--color-tinta-2)]">
						{capitulos} capítulos abiertos · {disponibles} ejercicios disponibles
					</p>

					<Form method="get">
						<input type="hidden" name="empezar" value="1" />
						<button
							type="submit"
							className="jc-btn jc-btn-primary w-full text-lg"
							disabled={disponibles === 0}
						>
							Empezar el parcial ⏱
						</button>
					</Form>
					{disponibles === 0 && (
						<p className="text-sm text-[var(--color-naranja)]">
							Todavía no hay ejercicios en tus capítulos abiertos.
						</p>
					)}
				</div>
			</main>
		</>
	);
}

function Parcial({ loaderData }: { loaderData: DatosParcial }) {
	const { user, puntos, minutos, token } = loaderData;
	const fetcher = useFetcher<typeof action>();

	const [codigos, setCodigos] = useState<Record<number, string>>(
		Object.fromEntries(puntos.map((p) => [p.id, p.starterCode])),
	);
	const [restante, setRestante] = useState(minutos * 60);
	const [entrega, setEntrega] = useState<EntregaParcial | null>(null);

	useEffect(() => {
		const id = setInterval(() => setRestante((r) => Math.max(0, r - 1)), 1000);
		return () => clearInterval(id);
	}, []);

	const entregar = () =>
		fetcher.submit(
			{
				intent: "entregar",
				token,
				codigos: JSON.stringify(codigos),
				segundos: String(minutos * 60 - restante),
			},
			{ method: "post" },
		);

	// Se acabó el tiempo: se entrega solo
	useEffect(() => {
		if (restante === 0 && !entrega && fetcher.state === "idle") entregar();
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [restante]);

	useEffect(() => {
		if (fetcher.data && "attemptId" in fetcher.data) {
			setEntrega(fetcher.data as EntregaParcial);
			window.scrollTo({ top: 0 });
		}
	}, [fetcher.data]);

	if (entrega) return <Revision user={user} entrega={entrega} />;

	return (
		<>
			<Nav user={user} />

			<main className="mx-auto max-w-3xl px-4 py-8 sm:px-5 sm:py-10">
				<header className="sticky top-16 z-30 -mx-4 mb-8 border-b border-[var(--color-borde)] bg-[#0b0b16]/90 px-4 py-3 backdrop-blur-xl sm:-mx-5 sm:px-5">
					<div className="flex items-center justify-between gap-3">
						<h1 className="jc-display text-lg sm:text-xl">📝 Parcial</h1>
						<span
							className={`jc-mono rounded-full border px-4 py-1.5 text-sm ${
								restante <= 300
									? "border-[rgba(255,77,255,.5)] text-[var(--color-magenta)]"
									: "border-[var(--color-borde)] text-[var(--color-tinta-2)]"
							}`}
						>
							⏱ {formatoReloj(restante)}
						</span>
					</div>
				</header>

				<div className="space-y-10">
					{puntos.map((p, i) => (
						<section key={p.id} className="jc-glass p-5 sm:p-7">
							<div className="flex flex-wrap items-center gap-3">
								<span className="jc-display text-2xl text-[var(--color-cyan)]">
									Punto {i + 1}
								</span>
								<BadgeDificultad nivel={p.difficulty} />
								<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
									{p.capitulo}
								</span>
							</div>

							<h2 className="jc-display mt-3 text-xl">{p.title}</h2>

							{p.statementHtml && (
								<div
									className="jc-prosa mt-4 text-[1rem]"
									dangerouslySetInnerHTML={{ __html: p.statementHtml }}
								/>
							)}

							<div className="mt-6">
								<EditorCodigo
									etiqueta="Tu solución"
									valor={codigos[p.id] ?? ""}
									onCambio={(v) => setCodigos((prev) => ({ ...prev, [p.id]: v }))}
								/>
							</div>
						</section>
					))}
				</div>

				<div className="mt-10 text-center">
					<button
						type="button"
						className="jc-btn jc-btn-primary text-lg"
						onClick={entregar}
						disabled={fetcher.state !== "idle"}
					>
						{fetcher.state !== "idle" ? "Entregando…" : "Entregar parcial ✅"}
					</button>
				</div>
			</main>
		</>
	);
}

/* ── Revisión + autocalificación ───────────────────────────────────────── */

const CRITERIOS = [
	{ id: "funciona", texto: "Funciona con los datos del enunciado" },
	{ id: "borde", texto: "Maneja los casos borde (cero, negativos, vacío)" },
	{ id: "doc", texto: "Está documentado: encabezado ''' y secciones #Inicio / #Fin" },
];

function Revision({
	user,
	entrega,
}: {
	user: DatosParcial["user"];
	entrega: EntregaParcial;
}) {
	const fetcher = useFetcher<typeof action>();
	const [marcas, setMarcas] = useState<Record<string, boolean>>({});

	const puntosBuenos = entrega.soluciones.filter((s) =>
		CRITERIOS.every((c) => marcas[`${s.id}-${c.id}`]),
	).length;

	const guardar = () =>
		fetcher.submit(
			{
				intent: "autocalificar",
				attemptId: String(entrega.attemptId),
				puntos: String(puntosBuenos),
				detalle: JSON.stringify(marcas),
			},
			{ method: "post" },
		);

	const guardado = Boolean(fetcher.data && "guardado" in fetcher.data);

	return (
		<>
			<Nav user={user} />

			<main className="mx-auto max-w-3xl px-4 py-10 sm:px-5 sm:py-12">
				<h1 className="jc-display jc-grad text-3xl">Parcial entregado</h1>
				<p className="mt-3 text-[var(--color-tinta-2)]">
					Compara tu código con la solución documentada y márcate cada punto. Cuando el
					Modo Código esté activo, esto lo calificarán los tests automáticamente.
				</p>

				<div className="mt-8 space-y-8">
					{entrega.soluciones.map((s, i) => (
						<section key={s.id} className="jc-glass p-5 sm:p-7">
							<div className="flex flex-wrap items-center gap-3">
								<span className="jc-display text-xl text-[var(--color-cyan)]">
									Punto {i + 1}
								</span>
								<BadgeDificultad nivel={s.difficulty} />
							</div>
							<h2 className="jc-display mt-2 text-lg">{s.title}</h2>

							<div className="mt-5">
								<EditorCodigo
									etiqueta="Lo que escribiste"
									valor={s.codigo || "# (en blanco)"}
									soloLectura
									filas={8}
								/>
							</div>

							{s.solutionHtml && (
								<details className="mt-5" open>
									<summary className="jc-btn jc-btn-sm jc-btn-ghost list-none marker:content-none">
										✅ Solución documentada
									</summary>
									<div
										className="jc-prosa mt-3 rounded-2xl border border-[var(--color-borde)] bg-black/30 p-5 text-[1rem]"
										dangerouslySetInnerHTML={{ __html: s.solutionHtml }}
									/>
								</details>
							)}

							<fieldset className="mt-6">
								<legend className="jc-label">Autocalificación</legend>
								<div className="space-y-2">
									{CRITERIOS.map((c) => {
										const clave = `${s.id}-${c.id}`;
										return (
											<label key={clave} className="flex items-start gap-3 text-sm">
												<input
													type="checkbox"
													checked={Boolean(marcas[clave])}
													onChange={(e) =>
														setMarcas((prev) => ({ ...prev, [clave]: e.target.checked }))
													}
													className="mt-0.5 h-4 w-4 accent-[var(--color-verde)]"
												/>
												{c.texto}
											</label>
										);
									})}
								</div>
							</fieldset>
						</section>
					))}
				</div>

				<div className="jc-glass mt-10 flex flex-wrap items-center justify-between gap-4 p-6">
					<div>
						<p className="jc-display text-2xl">
							{puntosBuenos} / {entrega.soluciones.length} puntos
						</p>
						<p className="text-sm text-[var(--color-tinta-2)]">
							según tu propio checklist
						</p>
					</div>
					<div className="flex flex-wrap gap-3">
						<Link to="/practica" className="jc-btn jc-btn-ghost">
							← Práctica
						</Link>
						<button
							type="button"
							className="jc-btn jc-btn-primary"
							onClick={guardar}
							disabled={fetcher.state !== "idle" || guardado}
						>
							{guardado ? "Guardado ✅" : "Guardar mi nota"}
						</button>
					</div>
				</div>
			</main>
		</>
	);
}
