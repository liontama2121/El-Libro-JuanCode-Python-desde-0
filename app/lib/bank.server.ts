import { and, eq, inArray, sql } from "drizzle-orm";
import { type Db, schema } from "~/db";
import type { BankQuestion, Dificultad, TipoPregunta } from "~/db/schema";

/* -------------------------------------------------------------------------- */
/*  Lo que SÍ puede ver el cliente                                             */
/* -------------------------------------------------------------------------- */

export type OpcionPublica = { id: string; text: string };

export type PreguntaPublica = {
	id: number;
	chapterId: number;
	type: TipoPregunta;
	difficulty: Dificultad;
	prompt: string;
	codeSnippet: string | null;
	/** mcq / predict_output */
	opciones?: OpcionPublica[];
	/** find_bug: las líneas del programa, numeradas desde 1 */
	lineas?: string[];
	/** parsons: las líneas DESORDENADAS, sin la indentación correcta */
	piezas?: { id: string; text: string }[];
	/** fill_blank: el código con las marcas ___N___ y la pista de cada hueco */
	codigoHuecos?: string;
	huecos?: { id: string; pista: string }[];
};

/**
 * Quita del registro todo lo que revelaría la respuesta.
 * `correct_json` NUNCA sale de esta función.
 */
export function aPublica(q: BankQuestion, semilla = 0): PreguntaPublica {
	const data = parse(q.dataJson) as Record<string, unknown>;
	const base: PreguntaPublica = {
		id: q.id,
		chapterId: q.chapterId,
		type: q.type as TipoPregunta,
		difficulty: q.difficulty as Dificultad,
		prompt: q.prompt,
		codeSnippet: q.codeSnippet,
	};

	if (q.type === "mcq" || q.type === "predict_output") {
		const opciones = (data.options as OpcionPublica[] | undefined) ?? [];
		return { ...base, opciones: barajar(opciones, semilla + q.id) };
	}

	if (q.type === "find_bug") {
		return { ...base, lineas: (data.lines as string[] | undefined) ?? [] };
	}

	if (q.type === "parsons") {
		const lines = (data.lines as { id: string; text: string }[] | undefined) ?? [];
		// Se entregan desordenadas y sin indentación: eso es lo que hay que armar.
		return {
			...base,
			piezas: barajar(
				lines.map((l) => ({ id: l.id, text: l.text })),
				semilla + q.id,
			),
		};
	}

	if (q.type === "fill_blank") {
		const huecos =
			(data.blanks as { id: string | number; pista?: string }[] | undefined) ?? [];
		// Se manda el código con los huecos, nunca las respuestas.
		return {
			...base,
			codigoHuecos: String(data.code ?? ""),
			huecos: huecos.map((h) => ({ id: String(h.id), pista: String(h.pista ?? "") })),
		};
	}

	return base;
}

/* -------------------------------------------------------------------------- */
/*  Calificación — SIEMPRE en el servidor                                      */
/* -------------------------------------------------------------------------- */

export type Respuesta =
	/** mcq / predict_output */
	| { option_id: string }
	/** find_bug */
	| { line_number: number }
	/** parsons */
	| { order: { id: string; indent: number }[] }
	/** fill_blank: lo que el estudiante escribió en cada hueco */
	| { blanks: Record<string, string> }
	| null;

export type Correccion = {
	acerto: boolean;
	/** Cómo se describe la respuesta correcta para mostrarla en la revisión */
	correcta: unknown;
	explanation: string;
};

export function calificar(q: BankQuestion, respuesta: Respuesta): Correccion {
	const correcto = parse(q.correctJson) as Record<string, unknown>;
	const data = parse(q.dataJson) as Record<string, unknown>;

	if (q.type === "mcq" || q.type === "predict_output") {
		const marcada = (respuesta as { option_id?: string } | null)?.option_id;
		return {
			acerto: marcada != null && marcada === correcto.option_id,
			correcta: correcto.option_id ?? null,
			explanation: q.explanation,
		};
	}

	if (q.type === "find_bug") {
		const marcada = Number((respuesta as { line_number?: number } | null)?.line_number);
		return {
			acerto: Number.isInteger(marcada) && marcada === Number(correcto.line_number),
			correcta: correcto.line_number ?? null,
			explanation: q.explanation,
		};
	}

	if (q.type === "parsons") {
		const orden = (respuesta as { order?: { id: string; indent: number }[] } | null)?.order ?? [];
		const esperado = (correcto.order as string[] | undefined) ?? [];
		const lineas =
			(data.lines as { id: string; text: string; indent?: number }[] | undefined) ?? [];
		const indentDe = new Map(lineas.map((l) => [l.id, Number(l.indent ?? 0)]));

		const mismoOrden =
			orden.length === esperado.length && orden.every((o, i) => o.id === esperado[i]);
		// La indentación también cuenta: en Python el bloque ES la indentación.
		const mismaIndentacion = orden.every((o) => Number(o.indent ?? 0) === indentDe.get(o.id));

		return {
			acerto: mismoOrden && mismaIndentacion,
			correcta: esperado.map((id) => ({
				id,
				text: lineas.find((l) => l.id === id)?.text ?? "",
				indent: indentDe.get(id) ?? 0,
			})),
			explanation: q.explanation,
		};
	}

	if (q.type === "fill_blank") {
		const escritas =
			(respuesta as { blanks?: Record<string, string> } | null)?.blanks ?? {};
		const esperadas = (correcto.answers as Record<string, string[]>) ?? {};
		const huecos = (data.blanks as { id: string | number }[] | undefined) ?? [];

		// Un hueco está bien si coincide con CUALQUIERA de las variantes que
		// el autor aceptó, comparando en forma normalizada.
		const detalle = huecos.map((h) => {
			const id = String(h.id);
			const escrita = String(escritas[id] ?? "");
			const variantes = esperadas[id] ?? [];
			return {
				id,
				escrita,
				acerto: variantes.some((v) => mismoCodigo(v, escrita)),
				correcta: variantes[0] ?? "",
			};
		});

		return {
			// Todo o nada: memorizar medio algoritmo no sirve de nada.
			acerto: detalle.length > 0 && detalle.every((d) => d.acerto),
			correcta: detalle,
			explanation: q.explanation,
		};
	}

	return { acerto: false, correcta: null, explanation: q.explanation };
}

/**
 * Compara dos trozos de código como los compararía un profesor: los espacios
 * sobran, pero los nombres y la lógica no.
 *
 *   "arr[j+1]"  ==  "arr[j + 1]"        ✔ mismo código
 *   "arr[j]>arr[j+1]" == "arr[j] > arr[j+1]"   ✔
 *   "lista[j]"  !=  "arr[j]"            ✘ otro nombre, otra respuesta
 */
export function mismoCodigo(a: string, b: string): boolean {
	const limpio = (t: string) =>
		String(t)
			.trim()
			.replace(/\s+/g, " ")
			// Espacios alrededor de los símbolos: irrelevantes al comparar
			.replace(/\s*([[\]().,:+\-*/%<>=!]+)\s*/g, "$1");

	return limpio(a) === limpio(b);
}

/* -------------------------------------------------------------------------- */
/*  Selección de preguntas                                                     */
/* -------------------------------------------------------------------------- */

export type FiltroBanco = {
	chapterIds: number[];
	tipos?: TipoPregunta[];
	dificultades?: Dificultad[];
	limite: number;
	/** Si viene, la selección es reproducible (reto del día) */
	semilla?: number;
};

/** Trae preguntas activas del banco, ya mezcladas y sin repetir. */
export async function elegirPreguntas(
	db: Db,
	{ chapterIds, tipos, dificultades, limite, semilla }: FiltroBanco,
): Promise<BankQuestion[]> {
	if (chapterIds.length === 0 || limite <= 0) return [];

	const condiciones = [
		inArray(schema.questionBank.chapterId, chapterIds),
		eq(schema.questionBank.active, true),
	];
	if (tipos?.length) condiciones.push(inArray(schema.questionBank.type, tipos));
	if (dificultades?.length) {
		condiciones.push(inArray(schema.questionBank.difficulty, dificultades));
	}

	// Con semilla la mezcla se hace en JS (determinista); sin semilla la deja
	// SQLite, que es más barato cuando el banco crece.
	if (semilla === undefined) {
		return db
			.select()
			.from(schema.questionBank)
			.where(and(...condiciones))
			.orderBy(sql`random()`)
			.limit(limite);
	}

	const todas = await db
		.select()
		.from(schema.questionBank)
		.where(and(...condiciones))
		.orderBy(schema.questionBank.id);

	return barajar(todas, semilla).slice(0, limite);
}

/**
 * Reparto por dificultad para el simulacro de parcial: 1 fácil, 2 medios,
 * 1 difícil. Si falta de alguna, se rellena con lo que haya.
 */
export async function elegirPorDificultad(
	db: Db,
	chapterIds: number[],
	reparto: Partial<Record<Dificultad, number>>,
	tipos?: TipoPregunta[],
): Promise<BankQuestion[]> {
	const salida: BankQuestion[] = [];
	for (const [dificultad, cuantas] of Object.entries(reparto)) {
		if (!cuantas) continue;
		const lote = await elegirPreguntas(db, {
			chapterIds,
			tipos,
			dificultades: [dificultad as Dificultad],
			limite: cuantas,
		});
		salida.push(...lote.filter((q) => !salida.some((s) => s.id === q.id)));
	}
	return salida;
}

/* -------------------------------------------------------------------------- */
/*  Utilidades                                                                 */
/* -------------------------------------------------------------------------- */

export function parse(json: string): unknown {
	try {
		return JSON.parse(json);
	} catch {
		return {};
	}
}

/** Mezcla determinista (Fisher-Yates con un PRNG sembrado). */
export function barajar<T>(items: T[], semilla: number): T[] {
	const copia = [...items];
	let estado = (semilla || 1) >>> 0;
	const random = () => {
		// xorshift32: suficiente para barajar preguntas
		estado ^= estado << 13;
		estado ^= estado >>> 17;
		estado ^= estado << 5;
		return ((estado >>> 0) % 100000) / 100000;
	};
	for (let i = copia.length - 1; i > 0; i--) {
		const j = Math.floor(random() * (i + 1));
		[copia[i], copia[j]] = [copia[j], copia[i]];
	}
	return copia;
}

/** Semilla del día: misma para todos los estudiantes (reto del día). */
export function semillaDelDia(fecha = new Date()) {
	const iso = fecha.toISOString().slice(0, 10); // YYYY-MM-DD
	let h = 2166136261;
	for (const ch of iso) {
		h ^= ch.charCodeAt(0);
		h = Math.imul(h, 16777619);
	}
	return h >>> 0;
}

export function hoyISO(fecha = new Date()) {
	return fecha.toISOString().slice(0, 10);
}
