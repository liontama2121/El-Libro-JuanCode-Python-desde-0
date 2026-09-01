import { and, asc, eq, inArray, sql, type SQL } from "drizzle-orm";
import { useState } from "react";
import { Form, Link, redirect, useSearchParams } from "react-router";
import { AdminShell, Aviso, Tabla, Vacio } from "~/components/admin";
import { EditorCodigo } from "~/components/editor";
import { NOMBRE_TIPO, Pregunta } from "~/components/pregunta";
import { getDb, schema } from "~/db";
import { DIFICULTADES, TIPOS_PREGUNTA, type TipoPregunta } from "~/db/schema";
import { requireTeacher } from "~/lib/auth.server";
import { parse } from "~/lib/bank.server";
import type { PreguntaPublica } from "~/lib/bank.server";
import type { Route } from "./+types/admin.banco";

export const meta: Route.MetaFunction = () => [
	{ title: "Banco de preguntas — Panel del profe" },
];

const LETRAS = ["a", "b", "c", "d"] as const;

/* -------------------------------------------------------------------------- */
/*  LOADER                                                                     */
/* -------------------------------------------------------------------------- */

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	const user = await requireTeacher(env, request);
	const db = getDb(env);

	const url = new URL(request.url);
	const capFiltro = Number(url.searchParams.get("cap")) || 0;
	const tipoFiltro = url.searchParams.get("tipo") || "";
	const difFiltro = url.searchParams.get("dif") || "";

	const capitulos = await db
		.select({
			id: schema.chapters.id,
			number: schema.chapters.number,
			title: schema.chapters.title,
		})
		.from(schema.chapters)
		.orderBy(asc(schema.chapters.number));

	const condiciones: SQL[] = [];
	if (capFiltro) condiciones.push(eq(schema.questionBank.chapterId, capFiltro));
	if (tipoFiltro) condiciones.push(eq(schema.questionBank.type, tipoFiltro));
	if (difFiltro) condiciones.push(eq(schema.questionBank.difficulty, difFiltro));

	const preguntas = await db
		.select()
		.from(schema.questionBank)
		.where(condiciones.length ? and(...condiciones) : undefined)
		.orderBy(asc(schema.questionBank.chapterId), asc(schema.questionBank.id));

	const idEditar = Number(url.searchParams.get("q"));
	const editando = preguntas.find((q) => q.id === idEditar) ?? null;

	const [{ total }] = await db
		.select({ total: sql<number>`count(*)` })
		.from(schema.questionBank);

	return {
		user,
		capitulos,
		preguntas: preguntas.map((q) => ({
			...q,
			data: parse(q.dataJson),
			correct: parse(q.correctJson),
		})),
		editando: editando
			? { ...editando, data: parse(editando.dataJson), correct: parse(editando.correctJson) }
			: null,
		total: Number(total) || 0,
		filtros: { cap: capFiltro, tipo: tipoFiltro, dif: difFiltro },
	};
}

/* -------------------------------------------------------------------------- */
/*  ACTION                                                                     */
/* -------------------------------------------------------------------------- */

type Resultado = { error?: string; ok?: string; errores?: string[] };

export async function action({
	context,
	request,
}: Route.ActionArgs): Promise<Resultado | Response> {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const form = await request.formData();
	const intent = String(form.get("intent") || "guardar");

	if (intent === "eliminar") {
		const id = Number(form.get("id"));
		if (Number.isInteger(id) && id > 0) {
			await db.delete(schema.questionBank).where(eq(schema.questionBank.id, id));
		}
		return redirect(`/admin/banco?toast=${encodeURIComponent("Pregunta eliminada 🗑️")}`);
	}

	if (intent === "activar") {
		const id = Number(form.get("id"));
		const activa = form.get("activa") === "1";
		await db
			.update(schema.questionBank)
			.set({ active: activa })
			.where(eq(schema.questionBank.id, id));
		return { ok: activa ? "Pregunta activada." : "Pregunta desactivada." };
	}

	/* Importación masiva ---------------------------------------------------- */
	if (intent === "importar") {
		const crudo = String(form.get("json") || "");
		let filas: unknown;
		try {
			filas = JSON.parse(crudo);
		} catch {
			return { error: "El JSON no es válido." };
		}
		if (!Array.isArray(filas)) return { error: "El JSON debe ser un arreglo." };

		const capitulos = await db
			.select({ id: schema.chapters.id, number: schema.chapters.number })
			.from(schema.chapters);
		const porNumero = new Map(capitulos.map((c) => [c.number, c.id]));
		const ids = new Set(capitulos.map((c) => c.id));

		const errores: string[] = [];
		const listas: (typeof schema.questionBank.$inferInsert)[] = [];

		filas.forEach((fila, i) => {
			const f = fila as Record<string, unknown>;
			const etiqueta = `fila ${i + 1}`;

			const chapterId =
				Number(f.chapter_id) || porNumero.get(Number(f.chapter_number)) || 0;
			if (!ids.has(chapterId)) {
				errores.push(`${etiqueta}: capítulo desconocido.`);
				return;
			}
			const tipo = String(f.type || "");
			if (!TIPOS_PREGUNTA.includes(tipo as TipoPregunta)) {
				errores.push(`${etiqueta}: type "${tipo}" no existe.`);
				return;
			}
			const prompt = String(f.prompt || "").trim();
			if (!prompt) {
				errores.push(`${etiqueta}: falta prompt.`);
				return;
			}
			const problema = validarEstructura(tipo as TipoPregunta, f.data, f.correct);
			if (problema) {
				errores.push(`${etiqueta}: ${problema}`);
				return;
			}

			listas.push({
				chapterId,
				type: tipo,
				difficulty: DIFICULTADES.includes(String(f.difficulty) as never)
					? String(f.difficulty)
					: "facil",
				prompt,
				codeSnippet: f.code_snippet ? String(f.code_snippet) : null,
				dataJson: JSON.stringify(f.data ?? {}),
				correctJson: JSON.stringify(f.correct ?? {}),
				explanation: String(f.explanation ?? ""),
				active: f.active === undefined ? true : Boolean(f.active),
			});
		});

		if (listas.length) {
			// D1 no acepta insert gigantes: se sube por lotes
			for (let i = 0; i < listas.length; i += 20) {
				await db.insert(schema.questionBank).values(listas.slice(i, i + 20));
			}
		}

		return {
			ok: `${listas.length} preguntas importadas.`,
			errores: errores.length ? errores : undefined,
		};
	}

	/* Crear / editar una pregunta ------------------------------------------- */
	const id = Number(form.get("id"));
	const chapterId = Number(form.get("chapterId"));
	const tipo = String(form.get("type") || "mcq") as TipoPregunta;
	const dificultad = String(form.get("difficulty") || "facil");
	const prompt = String(form.get("prompt") || "").trim();
	const codeSnippet = String(form.get("codeSnippet") || "").trim();
	const explanation = String(form.get("explanation") || "").trim();
	const active = form.get("active") === "on";

	if (!prompt) return { error: "La pregunta necesita enunciado." };
	if (!Number.isInteger(chapterId) || chapterId <= 0) {
		return { error: "Elige el capítulo." };
	}
	if (tipo === "predict_output" && !codeSnippet) {
		return { error: "Las preguntas de tipo “¿Qué imprime?” necesitan código." };
	}

	let data: unknown = {};
	let correct: unknown = {};

	if (tipo === "mcq" || tipo === "predict_output") {
		const textos = LETRAS.map((l) => String(form.get(`opcion_${l}`) || "").trim());
		if (textos.some((t) => !t)) return { error: "Escribe las cuatro opciones." };
		const correcta = String(form.get("correcta") || "a");
		data = { options: LETRAS.map((l, i) => ({ id: l, text: textos[i] })) };
		correct = { option_id: correcta };
	} else if (tipo === "find_bug") {
		const lineas = String(form.get("lineas") || "").replace(/\r/g, "").split("\n");
		if (lineas.length < 2) return { error: "Pega el programa, línea por línea." };
		const n = Number(form.get("line_number"));
		if (!Number.isInteger(n) || n < 1 || n > lineas.length) {
			return { error: `La línea del error debe estar entre 1 y ${lineas.length}.` };
		}
		data = { lines: lineas };
		correct = { line_number: n };
	} else if (tipo === "parsons") {
		const crudo = String(form.get("solucion") || "").replace(/\r/g, "");
		const lineas = crudo.split("\n").filter((l) => l.trim().length > 0);
		if (lineas.length < 2) return { error: "El rompecabezas necesita al menos 2 líneas." };
		// La indentación sale del propio código: 4 espacios = 1 nivel.
		const piezas = lineas.map((linea, i) => ({
			id: `l${i + 1}`,
			text: linea.trim(),
			indent: Math.floor((linea.length - linea.trimStart().length) / 4),
		}));
		data = { lines: piezas };
		correct = { order: piezas.map((p) => p.id) };
	}

	const valores = {
		chapterId,
		type: tipo,
		difficulty: dificultad,
		prompt,
		codeSnippet: codeSnippet || null,
		dataJson: JSON.stringify(data),
		correctJson: JSON.stringify(correct),
		explanation,
		active,
	};

	if (Number.isInteger(id) && id > 0) {
		await db.update(schema.questionBank).set(valores).where(eq(schema.questionBank.id, id));
		return redirect(
			`/admin/banco?q=${id}&toast=${encodeURIComponent("Pregunta guardada ✅")}`,
		);
	}

	const [creada] = await db
		.insert(schema.questionBank)
		.values(valores)
		.returning({ id: schema.questionBank.id });

	return redirect(
		`/admin/banco?q=${creada.id}&toast=${encodeURIComponent("Pregunta creada ✅")}`,
	);
}

/** Valida que data/correct cuadren con el tipo. Devuelve el error o null. */
function validarEstructura(tipo: TipoPregunta, data: unknown, correct: unknown): string | null {
	const d = (data ?? {}) as Record<string, unknown>;
	const c = (correct ?? {}) as Record<string, unknown>;

	if (tipo === "mcq" || tipo === "predict_output") {
		const opciones = d.options as { id?: string; text?: string }[] | undefined;
		if (!Array.isArray(opciones) || opciones.length < 2) {
			return "data.options necesita al menos 2 opciones.";
		}
		if (opciones.some((o) => !o?.id || !o?.text)) return "cada opción necesita id y text.";
		if (!c.option_id) return "correct.option_id es obligatorio.";
		if (!opciones.some((o) => o.id === c.option_id)) {
			return "correct.option_id no coincide con ninguna opción.";
		}
		return null;
	}

	if (tipo === "find_bug") {
		const lineas = d.lines as string[] | undefined;
		if (!Array.isArray(lineas) || lineas.length === 0) return "data.lines está vacío.";
		const n = Number(c.line_number);
		if (!Number.isInteger(n) || n < 1 || n > lineas.length) {
			return "correct.line_number fuera de rango.";
		}
		return null;
	}

	if (tipo === "parsons") {
		const lineas = d.lines as { id?: string; text?: string }[] | undefined;
		if (!Array.isArray(lineas) || lineas.length < 2) return "data.lines necesita 2+ líneas.";
		if (lineas.some((l) => !l?.id || l?.text === undefined)) {
			return "cada línea necesita id y text.";
		}
		const orden = c.order as string[] | undefined;
		if (!Array.isArray(orden) || orden.length !== lineas.length) {
			return "correct.order debe listar todas las líneas.";
		}
		if (orden.some((id) => !lineas.some((l) => l.id === id))) {
			return "correct.order tiene ids que no existen.";
		}
		return null;
	}

	return null;
}

/* -------------------------------------------------------------------------- */
/*  UI                                                                         */
/* -------------------------------------------------------------------------- */

export default function AdminBanco({ loaderData, actionData }: Route.ComponentProps) {
	const { user, capitulos, preguntas, editando, total, filtros } = loaderData;
	const [params] = useSearchParams();
	const [importando, setImportando] = useState(false);

	const numeroDe = new Map(capitulos.map((c) => [c.id, c.number]));
	const resultado = actionData as Resultado | undefined;

	return (
		<AdminShell
			user={user}
			titulo="Banco de preguntas"
			descripcion={`${preguntas.length} de ${total} preguntas · el quiz de cada capítulo saca 5 al azar de aquí`}
			acciones={
				<div className="flex flex-wrap gap-2">
					<button
						type="button"
						className="jc-btn jc-btn-ghost"
						onClick={() => setImportando((v) => !v)}
					>
						⬆️ Importar JSON
					</button>
					<a
						href={`/admin/banco/export?${params.toString()}`}
						className="jc-btn jc-btn-ghost"
					>
						⬇️ Exportar
					</a>
					<Link to="/admin/banco" className="jc-btn jc-btn-primary">
						+ Nueva pregunta
					</Link>
				</div>
			}
		>
			{resultado?.ok && (
				<div className="mb-5">
					<Aviso tipo="ok">{resultado.ok}</Aviso>
				</div>
			)}
			{resultado?.errores && (
				<div className="mb-5 space-y-1">
					{resultado.errores.map((e) => (
						<Aviso key={e} tipo="error">
							{e}
						</Aviso>
					))}
				</div>
			)}

			{importando && (
				<Form method="post" className="jc-glass mb-8 p-5">
					<input type="hidden" name="intent" value="importar" />
					<span className="jc-label">Pega el arreglo JSON</span>
					<textarea
						name="json"
						rows={10}
						className="jc-input jc-mono text-sm"
						placeholder={`[\n  {\n    "chapter_number": 1,\n    "type": "mcq",\n    "difficulty": "facil",\n    "prompt": "¿Qué hace print()?",\n    "data": { "options": [{ "id": "a", "text": "Muestra en pantalla" }] },\n    "correct": { "option_id": "a" },\n    "explanation": "..."\n  }\n]`}
					/>
					<button type="submit" className="jc-btn jc-btn-primary mt-4">
						Importar
					</button>
				</Form>
			)}

			{/* Filtros ---------------------------------------------------------- */}
			<Form method="get" className="jc-glass mb-8 flex flex-wrap items-end gap-4 p-5">
				<div>
					<label className="jc-label" htmlFor="cap">
						Capítulo
					</label>
					<select id="cap" name="cap" defaultValue={filtros.cap || ""} className="jc-input">
						<option value="">Todos</option>
						{capitulos.map((c) => (
							<option key={c.id} value={c.id}>
								{c.number}. {c.title}
							</option>
						))}
					</select>
				</div>
				<div>
					<label className="jc-label" htmlFor="tipo">
						Tipo
					</label>
					<select id="tipo" name="tipo" defaultValue={filtros.tipo} className="jc-input">
						<option value="">Todos</option>
						{TIPOS_PREGUNTA.map((t) => (
							<option key={t} value={t}>
								{NOMBRE_TIPO[t]}
							</option>
						))}
					</select>
				</div>
				<div>
					<label className="jc-label" htmlFor="dif">
						Dificultad
					</label>
					<select id="dif" name="dif" defaultValue={filtros.dif} className="jc-input">
						<option value="">Todas</option>
						{DIFICULTADES.map((d) => (
							<option key={d} value={d}>
								{d}
							</option>
						))}
					</select>
				</div>
				<button type="submit" className="jc-btn jc-btn-sm">
					Filtrar
				</button>
			</Form>

			<div className="grid gap-8 xl:grid-cols-[1fr_minmax(0,1.1fr)]">
				{/* Tabla --------------------------------------------------------- */}
				<div>
					{preguntas.length === 0 ? (
						<Vacio>No hay preguntas con esos filtros.</Vacio>
					) : (
						<Tabla cabeceras={["Cap", "Tipo", "Dif", "Enunciado", ""]}>
							{preguntas.map((q) => (
								<tr
									key={q.id}
									className={`border-b border-[var(--color-borde)] last:border-0 ${
										editando?.id === q.id ? "bg-[rgba(0,229,255,.07)]" : ""
									} ${q.active ? "" : "opacity-50"}`}
								>
									<td className="jc-mono px-4 py-3 text-xs">{numeroDe.get(q.chapterId)}</td>
									<td className="px-4 py-3 text-xs">{NOMBRE_TIPO[q.type] ?? q.type}</td>
									<td className="px-4 py-3">
										<span className={`jc-badge jc-badge-${q.difficulty}`}>{q.difficulty}</span>
									</td>
									<td className="px-4 py-3">
										<Link
											to={`/admin/banco?q=${q.id}`}
											className="line-clamp-2 text-sm hover:text-[var(--color-cyan)]"
										>
											{q.prompt}
										</Link>
									</td>
									<td className="px-4 py-3">
										<div className="flex items-center gap-1">
											<Form method="post">
												<input type="hidden" name="intent" value="activar" />
												<input type="hidden" name="id" value={q.id} />
												<input type="hidden" name="activa" value={q.active ? "0" : "1"} />
												<button
													type="submit"
													title={q.active ? "Desactivar" : "Activar"}
													className="jc-btn jc-btn-sm jc-btn-ghost"
												>
													{q.active ? "👁️" : "🚫"}
												</button>
											</Form>
											<Form
												method="post"
												onSubmit={(e) => {
													if (!confirm("¿Eliminar esta pregunta?")) e.preventDefault();
												}}
											>
												<input type="hidden" name="intent" value="eliminar" />
												<input type="hidden" name="id" value={q.id} />
												<button
													type="submit"
													className="jc-btn jc-btn-sm jc-btn-ghost text-[var(--color-magenta)]"
												>
													🗑️
												</button>
											</Form>
										</div>
									</td>
								</tr>
							))}
						</Tabla>
					)}
				</div>

				{/* Editor -------------------------------------------------------- */}
				<EditorPregunta
					key={editando?.id ?? "nueva"}
					capitulos={capitulos}
					editando={editando}
					error={resultado?.error}
				/>
			</div>
		</AdminShell>
	);
}

/* -------------------------------------------------------------------------- */
/*  Formulario dinámico + vista previa                                         */
/* -------------------------------------------------------------------------- */

type Editando = Route.ComponentProps["loaderData"]["editando"];

function EditorPregunta({
	capitulos,
	editando,
	error,
}: {
	capitulos: { id: number; number: number; title: string }[];
	editando: Editando;
	error?: string;
}) {
	const data = (editando?.data ?? {}) as Record<string, unknown>;
	const correct = (editando?.correct ?? {}) as Record<string, unknown>;

	const [tipo, setTipo] = useState<TipoPregunta>(
		(editando?.type as TipoPregunta) ?? "mcq",
	);
	const [prompt, setPrompt] = useState(editando?.prompt ?? "");
	const [codigo, setCodigo] = useState(editando?.codeSnippet ?? "");
	const [dificultad, setDificultad] = useState(editando?.difficulty ?? "facil");

	const opcionesIniciales = (data.options as { id: string; text: string }[] | undefined) ?? [];
	const [opciones, setOpciones] = useState<string[]>(
		LETRAS.map((l) => opcionesIniciales.find((o) => o.id === l)?.text ?? ""),
	);
	const [correcta, setCorrecta] = useState(String(correct.option_id ?? "a"));

	const [lineas, setLineas] = useState(
		((data.lines as string[] | undefined) ?? []).join("\n"),
	);
	const [lineaError, setLineaError] = useState(String(correct.line_number ?? 1));

	const [solucion, setSolucion] = useState(
		((data.lines as { text: string; indent: number }[] | undefined) ?? [])
			.map((l) => `${"    ".repeat(l.indent ?? 0)}${l.text}`)
			.join("\n"),
	);

	// Vista previa: lo mismo que verá el estudiante (sin la respuesta correcta).
	const vistaPrevia: PreguntaPublica = {
		id: -1,
		chapterId: 0,
		type: tipo,
		difficulty: dificultad as PreguntaPublica["difficulty"],
		prompt: prompt || "…",
		codeSnippet: codigo || null,
		opciones:
			tipo === "mcq" || tipo === "predict_output"
				? LETRAS.map((l, i) => ({ id: l, text: opciones[i] || `Opción ${l}` }))
				: undefined,
		lineas: tipo === "find_bug" ? lineas.split("\n") : undefined,
		piezas:
			tipo === "parsons"
				? solucion
						.split("\n")
						.filter((l) => l.trim())
						.map((l, i) => ({ id: `l${i + 1}`, text: l.trim() }))
				: undefined,
	};

	return (
		<div className="space-y-6">
			<Form method="post" className="jc-glass p-5 sm:p-6">
				<input type="hidden" name="id" value={editando?.id ?? 0} />

				<h2 className="jc-display text-xl">
					{editando ? "✏️ Editar pregunta" : "➕ Nueva pregunta"}
				</h2>

				<div className="mt-5 grid gap-4 sm:grid-cols-3">
					<div>
						<label className="jc-label" htmlFor="chapterId">
							Capítulo
						</label>
						<select
							id="chapterId"
							name="chapterId"
							className="jc-input"
							defaultValue={editando?.chapterId ?? capitulos[0]?.id}
						>
							{capitulos.map((c) => (
								<option key={c.id} value={c.id}>
									{c.number}. {c.title}
								</option>
							))}
						</select>
					</div>
					<div>
						<label className="jc-label" htmlFor="type">
							Tipo
						</label>
						<select
							id="type"
							name="type"
							className="jc-input"
							value={tipo}
							onChange={(e) => setTipo(e.target.value as TipoPregunta)}
						>
							{TIPOS_PREGUNTA.map((t) => (
								<option key={t} value={t}>
									{NOMBRE_TIPO[t]}
								</option>
							))}
						</select>
					</div>
					<div>
						<label className="jc-label" htmlFor="difficulty">
							Dificultad
						</label>
						<select
							id="difficulty"
							name="difficulty"
							className="jc-input"
							value={dificultad}
							onChange={(e) => setDificultad(e.target.value)}
						>
							{DIFICULTADES.map((d) => (
								<option key={d} value={d}>
									{d}
								</option>
							))}
						</select>
					</div>
				</div>

				<div className="mt-4">
					<label className="jc-label" htmlFor="prompt">
						Enunciado
					</label>
					<input
						id="prompt"
						name="prompt"
						className="jc-input"
						value={prompt}
						onChange={(e) => setPrompt(e.target.value)}
						required
					/>
				</div>

				{tipo !== "find_bug" && (
					<div className="mt-4">
						<EditorCodigo
							etiqueta={
								tipo === "predict_output" ? "Código (obligatorio)" : "Código (opcional)"
							}
							nombre="codeSnippet"
							valor={codigo}
							onCambio={setCodigo}
							filas={6}
						/>
					</div>
				)}
				{tipo === "find_bug" && <input type="hidden" name="codeSnippet" value="" />}

				{/* Campos propios de cada tipo ---------------------------------- */}
				{(tipo === "mcq" || tipo === "predict_output") && (
					<fieldset className="mt-6">
						<legend className="jc-label">Opciones (marca la correcta)</legend>
						<div className="space-y-3">
							{LETRAS.map((l, i) => (
								<div key={l} className="flex items-center gap-3">
									<label className="flex items-center gap-2">
										<input
											type="radio"
											name="correcta"
											value={l}
											checked={correcta === l}
											onChange={() => setCorrecta(l)}
											className="h-4 w-4 accent-[var(--color-verde)]"
										/>
										<span className="jc-mono w-4 text-sm uppercase">{l}</span>
									</label>
									<input
										name={`opcion_${l}`}
										className="jc-input"
										value={opciones[i]}
										onChange={(e) =>
											setOpciones((prev) =>
												prev.map((v, j) => (j === i ? e.target.value : v)),
											)
										}
										required
									/>
								</div>
							))}
						</div>
					</fieldset>
				)}

				{tipo === "find_bug" && (
					<div className="mt-6 space-y-4">
						<EditorCodigo
							etiqueta="Programa con el bug (una línea por renglón)"
							nombre="lineas"
							valor={lineas}
							onCambio={setLineas}
							filas={9}
						/>
						<div className="max-w-[200px]">
							<label className="jc-label" htmlFor="line_number">
								Línea del error
							</label>
							<input
								id="line_number"
								name="line_number"
								type="number"
								min={1}
								className="jc-input jc-mono"
								value={lineaError}
								onChange={(e) => setLineaError(e.target.value)}
							/>
						</div>
					</div>
				)}

				{tipo === "parsons" && (
					<div className="mt-6">
						<EditorCodigo
							etiqueta="Solución en el orden correcto (la indentación se toma de aquí)"
							nombre="solucion"
							valor={solucion}
							onCambio={setSolucion}
							filas={10}
						/>
						<p className="mt-2 text-xs text-[var(--color-tinta-2)]">
							Al estudiante le llegan estas líneas desordenadas y sin indentar.
							4 espacios = 1 nivel de bloque.
						</p>
					</div>
				)}

				<div className="mt-4">
					<label className="jc-label" htmlFor="explanation">
						Explicación (se muestra al corregir)
					</label>
					<textarea
						id="explanation"
						name="explanation"
						rows={3}
						className="jc-input"
						defaultValue={editando?.explanation ?? ""}
					/>
				</div>

				<label className="mt-5 flex items-center gap-3 text-sm">
					<input
						type="checkbox"
						name="active"
						defaultChecked={editando?.active ?? true}
						className="h-4 w-4 accent-[var(--color-cyan)]"
					/>
					Activa (entra en quizzes, simulacros y arcade)
				</label>

				{error && (
					<div className="mt-4">
						<Aviso tipo="error">{error}</Aviso>
					</div>
				)}

				<button
					type="submit"
					name="intent"
					value="guardar"
					className="jc-btn jc-btn-primary mt-6"
				>
					{editando ? "Guardar cambios" : "Crear pregunta"}
				</button>
			</Form>

			{/* Vista previa ---------------------------------------------------- */}
			<div>
				<p className="jc-mono mb-3 text-xs tracking-[0.2em] text-[var(--color-tinta-2)] uppercase">
					así lo ve el estudiante
				</p>
				<div className="jc-glass p-5 sm:p-6">
					<Pregunta pregunta={vistaPrevia} respuesta={null} onRespuesta={() => {}} />
				</div>
			</div>
		</div>
	);
}
