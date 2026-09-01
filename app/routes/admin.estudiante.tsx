import { asc, desc, eq } from "drizzle-orm";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Tabla, Vacio } from "~/components/admin";
import { BarraProgreso } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import { formatearFechaHora, romano } from "~/lib/format";
import {
	cargarProgreso,
	otorgarDesbloqueo,
	quitarDesbloqueo,
} from "~/lib/progress.server";
import type { Route } from "./+types/admin.estudiante";

export const meta: Route.MetaFunction = ({ data }) => [
	{
		title: data
			? `${data.estudiante.name} — Panel del profe`
			: "Estudiante — Panel del profe",
	},
];

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const [estudiante] = await db
		.select({
			id: schema.users.id,
			name: schema.users.name,
			username: schema.users.username,
			mustChangePassword: schema.users.mustChangePassword,
			createdAt: schema.users.createdAt,
		})
		.from(schema.users)
		.where(eq(schema.users.id, params.id))
		.limit(1);

	if (!estudiante) throw redirect("/admin/estudiantes");

	const [partes, capitulos, progreso] = await Promise.all([
		db.select().from(schema.parts).orderBy(asc(schema.parts.number)),
		db.select().from(schema.chapters).orderBy(asc(schema.chapters.number)),
		cargarProgreso(db, estudiante.id),
	]);

	const desbloqueos = await db
		.select({
			chapterId: schema.unlocks.chapterId,
			source: schema.unlocks.source,
		})
		.from(schema.unlocks)
		.where(eq(schema.unlocks.userId, estudiante.id));

	const fuentes = new Map(desbloqueos.map((u) => [u.chapterId, u.source]));

	const intentos = await db
		.select({
			id: schema.quizAttempts.id,
			score: schema.quizAttempts.score,
			passed: schema.quizAttempts.passed,
			createdAt: schema.quizAttempts.createdAt,
			chapterNumber: schema.chapters.number,
			chapterTitle: schema.chapters.title,
		})
		.from(schema.quizAttempts)
		.innerJoin(schema.quizzes, eq(schema.quizzes.id, schema.quizAttempts.quizId))
		.innerJoin(schema.chapters, eq(schema.chapters.id, schema.quizzes.chapterId))
		.where(eq(schema.quizAttempts.userId, estudiante.id))
		.orderBy(desc(schema.quizAttempts.createdAt))
		.limit(80);

	const filas = capitulos.map((c) => ({
		id: c.id,
		number: c.number,
		title: c.title,
		emoji: c.emoji,
		partId: c.partId,
		published: c.published,
		desbloqueado: c.number === 1 || progreso.unlocked.has(c.id),
		fuente: c.number === 1 ? "inicio" : (fuentes.get(c.id) ?? null),
		aprobado: progreso.passed.has(c.id),
	}));

	return {
		user,
		estudiante,
		partes,
		capitulos: filas,
		intentos,
		completados: progreso.passed.size,
	};
}

export async function action({ context, request, params }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const form = await request.formData();
	const intent = String(form.get("intent") || "");
	const chapterId = Number(form.get("chapterId"));

	if (!Number.isInteger(chapterId)) return { ok: false };

	if (intent === "desbloquear") {
		await otorgarDesbloqueo(db, params.id, chapterId, "teacher");
	} else if (intent === "bloquear") {
		await quitarDesbloqueo(db, params.id, chapterId);
	}

	return { ok: true };
}

export default function AdminEstudiante({ loaderData }: Route.ComponentProps) {
	const { user, estudiante, partes, capitulos, intentos, completados } =
		loaderData;

	return (
		<AdminShell
			user={user}
			titulo={estudiante.name}
			descripcion={`@${estudiante.username} · ${completados} de ${capitulos.length} capítulos aprobados`}
			acciones={
				<Link to="/admin/estudiantes" className="jc-btn jc-btn-ghost">
					← Estudiantes
				</Link>
			}
		>
			<div className="mx-auto mb-10 max-w-md">
				<BarraProgreso
					valor={completados}
					total={capitulos.length}
					etiqueta="Progreso del libro"
				/>
			</div>

			<div className="grid gap-10 lg:grid-cols-2">
				{/* Desbloqueos ---------------------------------------------------- */}
				<section>
					<h2 className="jc-display text-2xl">🔓 Desbloqueos</h2>
					<p className="mt-1 text-sm text-[var(--color-tinta-2)]">
						El capítulo 1 siempre está abierto. Los demás se abren al aprobar el
						quiz anterior, o a mano desde aquí.
					</p>

					<div className="mt-6 space-y-6">
						{partes.map((parte) => {
							const delParte = capitulos.filter((c) => c.partId === parte.id);
							if (delParte.length === 0) return null;

							return (
								<div key={parte.id}>
									<p className="jc-mono mb-2 text-[0.66rem] tracking-[0.2em] text-[var(--color-tinta-2)] uppercase">
										{parte.emoji} Parte {romano(parte.number)} — {parte.title}
									</p>
									<ul className="space-y-2">
										{delParte.map((c) => (
											<li
												key={c.id}
												className="flex items-center gap-3 rounded-xl border border-[var(--color-borde)] bg-white/[0.03] px-4 py-2.5"
											>
												<span className="jc-mono w-6 text-right text-xs text-[var(--color-tinta-2)]">
													{c.number}
												</span>
												<span>{c.aprobado ? "✅" : c.desbloqueado ? "📖" : "🔒"}</span>
												<span className="flex-1 truncate text-sm">
													{c.title}
												</span>

												{c.fuente && (
													<span className="jc-mono hidden text-[0.6rem] text-[var(--color-tinta-2)] sm:inline">
														{c.fuente === "teacher"
															? "manual"
															: c.fuente === "quiz"
																? "por quiz"
																: "inicio"}
													</span>
												)}

												{c.number === 1 ? (
													<span className="jc-mono text-[0.6rem] text-[var(--color-tinta-2)]">
														siempre
													</span>
												) : (
													<Form method="post">
														<input
															type="hidden"
															name="chapterId"
															value={c.id}
														/>
														<input
															type="hidden"
															name="intent"
															value={c.desbloqueado ? "bloquear" : "desbloquear"}
														/>
														<button
															type="submit"
															className="jc-btn jc-btn-sm jc-btn-ghost"
														>
															{c.desbloqueado
																? "🔒 Quitar desbloqueo"
																: "🔓 Desbloquear"}
														</button>
													</Form>
												)}
											</li>
										))}
									</ul>
								</div>
							);
						})}
					</div>
				</section>

				{/* Historial ------------------------------------------------------ */}
				<section>
					<h2 className="jc-display text-2xl">📈 Historial de intentos</h2>
					<p className="mt-1 text-sm text-[var(--color-tinta-2)]">
						Todos los intentos quedan guardados.
					</p>

					<div className="mt-6">
						{intentos.length === 0 ? (
							<Vacio>Este estudiante todavía no ha presentado ningún quiz.</Vacio>
						) : (
							<Tabla cabeceras={["Fecha", "Capítulo", "Score", ""]}>
								{intentos.map((i) => (
									<tr
										key={i.id}
										className="border-b border-[var(--color-borde)] last:border-0"
									>
										<td className="px-5 py-3 text-xs text-[var(--color-tinta-2)]">
											{formatearFechaHora(i.createdAt)}
										</td>
										<td className="px-5 py-3 text-sm">
											<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
												{i.chapterNumber}.
											</span>{" "}
											{i.chapterTitle}
										</td>
										<td className="jc-mono px-5 py-3 text-sm">{i.score}</td>
										<td className="px-5 py-3">
											{i.passed ? (
												<span className="text-[var(--color-verde)]">✅</span>
											) : (
												<span className="text-[var(--color-naranja)]">❌</span>
											)}
										</td>
									</tr>
								))}
							</Tabla>
						)}
					</div>
				</section>
			</div>
		</AdminShell>
	);
}
