import { eq } from "drizzle-orm";
import { useState } from "react";
import { Form, Link, redirect } from "react-router";
import { AdminShell, Aviso } from "~/components/admin";
import { EditorCodigo } from "~/components/editor";
import { BadgeDificultad } from "~/components/ui";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import type { Route } from "./+types/admin.ejercicio";

export const meta: Route.MetaFunction = ({ data }) => [
	{ title: data ? `Tests — ${data.ejercicio.title}` : "Tests — Panel del profe" },
];

export type Test = { stdin: string; expected_output: string };

/* -------------------------------------------------------------------------- */

export async function loader({ context, request, params }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const [ejercicio] = await db
		.select()
		.from(schema.exercises)
		.where(eq(schema.exercises.id, Number(params.id)))
		.limit(1);

	if (!ejercicio) throw redirect("/admin/capitulos");

	const [capitulo] = await db
		.select({
			id: schema.chapters.id,
			number: schema.chapters.number,
			title: schema.chapters.title,
		})
		.from(schema.chapters)
		.where(eq(schema.chapters.id, ejercicio.chapterId))
		.limit(1);

	let tests: Test[] = [];
	try {
		const crudo = JSON.parse(ejercicio.testsJson || "[]");
		if (Array.isArray(crudo)) {
			tests = crudo.map((t) => ({
				stdin: String(t?.stdin ?? ""),
				expected_output: String(t?.expected_output ?? ""),
			}));
		}
	} catch {
		tests = [];
	}

	return { user, ejercicio, capitulo, tests };
}

export async function action({
	context,
	request,
	params,
}: Route.ActionArgs): Promise<{ error?: string } | Response> {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const id = Number(params.id);
	const form = await request.formData();

	const stdins = form.getAll("stdin").map(String);
	const esperados = form.getAll("expected_output").map(String);

	const tests: Test[] = stdins
		.map((stdin, i) => ({ stdin, expected_output: esperados[i] ?? "" }))
		// Un test sin salida esperada no sirve para calificar nada.
		.filter((t) => t.expected_output.trim() !== "");

	const starter = String(form.get("starterCode") || "");

	await db
		.update(schema.exercises)
		.set({
			testsJson: tests.length ? JSON.stringify(tests) : null,
			starterCode: starter.trim() ? starter : null,
		})
		.where(eq(schema.exercises.id, id));

	return redirect(
		`/admin/ejercicio/${id}?toast=${encodeURIComponent(
			`${tests.length} tests guardados ✅`,
		)}`,
	);
}

/* -------------------------------------------------------------------------- */

export default function AdminEjercicio({ loaderData, actionData }: Route.ComponentProps) {
	const { user, ejercicio, capitulo, tests } = loaderData;
	const [filas, setFilas] = useState<Test[]>(
		tests.length ? tests : [{ stdin: "", expected_output: "" }],
	);
	const [starter, setStarter] = useState(ejercicio.starterCode ?? "");

	const cambiar = (i: number, campo: keyof Test, valor: string) =>
		setFilas((prev) => prev.map((f, j) => (j === i ? { ...f, [campo]: valor } : f)));

	return (
		<AdminShell
			user={user}
			titulo={`🧪 Tests — ${ejercicio.title}`}
			descripcion={`Capítulo ${capitulo?.number}. ${capitulo?.title}`}
			acciones={
				<Link
					to={`/admin/capitulo/${ejercicio.chapterId}/ejercicios`}
					className="jc-btn jc-btn-ghost"
				>
					← Ejercicios
				</Link>
			}
		>
			<div className="mb-6 flex flex-wrap items-center gap-3">
				<BadgeDificultad nivel={ejercicio.difficulty} />
				<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
					orden {ejercicio.orden}
				</span>
			</div>

			<Form method="post" className="grid gap-8 xl:grid-cols-[1.2fr_1fr]">
				<div className="jc-glass p-5 sm:p-6">
					<h2 className="jc-display text-xl">Casos de prueba</h2>
					<p className="mt-2 text-sm text-[var(--color-tinta-2)]">
						Cada caso alimenta el programa por <code className="jc-mono">stdin</code> y
						compara la salida con lo esperado (se recortan espacios y saltos sobrantes).
						Las filas sin salida esperada se descartan al guardar.
					</p>

					<div className="mt-6 space-y-5">
						{filas.map((t, i) => (
							<div
								key={i}
								className="rounded-2xl border border-[var(--color-borde)] bg-white/[0.03] p-4"
							>
								<div className="mb-3 flex items-center justify-between">
									<span className="jc-mono text-xs text-[var(--color-tinta-2)]">
										Caso {i + 1}
									</span>
									<button
										type="button"
										className="jc-btn jc-btn-sm jc-btn-ghost text-[var(--color-magenta)]"
										onClick={() => setFilas((prev) => prev.filter((_, j) => j !== i))}
									>
										Quitar
									</button>
								</div>

								<div className="grid gap-4 sm:grid-cols-2">
									<div>
										<label className="jc-label">Entrada (stdin)</label>
										<textarea
											name="stdin"
											rows={4}
											className="jc-input jc-mono text-sm"
											value={t.stdin}
											onChange={(e) => cambiar(i, "stdin", e.target.value)}
											placeholder={"12000\n3"}
										/>
									</div>
									<div>
										<label className="jc-label">Salida esperada</label>
										<textarea
											name="expected_output"
											rows={4}
											className="jc-input jc-mono text-sm"
											value={t.expected_output}
											onChange={(e) => cambiar(i, "expected_output", e.target.value)}
											placeholder={"Total: 36000"}
										/>
									</div>
								</div>
							</div>
						))}
					</div>

					<button
						type="button"
						className="jc-btn jc-btn-sm mt-5"
						onClick={() => setFilas((prev) => [...prev, { stdin: "", expected_output: "" }])}
					>
						+ Agregar caso
					</button>
				</div>

				<div className="space-y-6">
					<div className="jc-glass p-5 sm:p-6">
						<h2 className="jc-display text-xl">Código inicial</h2>
						<p className="mt-2 mb-4 text-sm text-[var(--color-tinta-2)]">
							Lo que aparece en el editor del estudiante antes de escribir.
						</p>
						<EditorCodigo
							nombre="starterCode"
							valor={starter}
							onCambio={setStarter}
							filas={12}
						/>
					</div>

					{actionData?.error && <Aviso tipo="error">{actionData.error}</Aviso>}

					<button type="submit" className="jc-btn jc-btn-primary w-full">
						Guardar tests y código inicial
					</button>
				</div>
			</Form>
		</AdminShell>
	);
}
