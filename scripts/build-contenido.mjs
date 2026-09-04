#!/usr/bin/env node
/**
 * Convierte el contenido escrito a mano en `content/` en un único SQL
 * idempotente (`seeds/contenido.sql`) que se puede correr las veces que haga
 * falta, en local y en remoto.
 *
 *   content/libro.json            partes y ficha de cada capítulo
 *   content/chapters/NN-slug.html cuerpo del capítulo (content_html)
 *   content/bank/NN.json          banco de preguntas del capítulo
 *   content/exercises/NN.json     ejercicios del capítulo
 *
 * Reglas:
 *  - Los capítulos se actualizan POR NÚMERO: editar el archivo y volver a
 *    seedear deja la base igual al archivo.
 *  - Solo se borra y reescribe lo que tenga source = 'seed'. Lo que el profe
 *    escriba desde /admin (source = 'profe') no se toca.
 *  - Un capítulo queda published = 1 cuando tiene las tres cosas: cuerpo,
 *    banco y ejercicios.
 *
 *   npm run content:build
 */

import { readFileSync, readdirSync, existsSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const raiz = join(dirname(fileURLToPath(import.meta.url)), "..");

/**
 * Sin argumentos arma el libro básico (content/ -> seeds/contenido.sql).
 * Con uno, arma ese otro libro:
 *
 *   node scripts/build-contenido.mjs avanzado
 *   -> content/avanzado/ -> seeds/avanzado.sql
 */
const carpetaLibro = process.argv[2] ?? "";
const dirContenido = carpetaLibro
	? join(raiz, "content", carpetaLibro)
	: join(raiz, "content");
const salida = join(raiz, "seeds", `${carpetaLibro || "contenido"}.sql`);

const TIPOS = new Set([
	"mcq",
	"predict_output",
	"find_bug",
	"parsons",
	"fill_blank",
]);
const DIFICULTADES = new Set(["facil", "medio", "dificil"]);

/* ── Utilidades ─────────────────────────────────────────────────────────── */

/** Comilla simple duplicada: la forma segura de meter texto en SQLite. */
function txt(valor) {
	if (valor === null || valor === undefined) return "NULL";
	return `'${String(valor).replace(/'/g, "''")}'`;
}

function json(valor) {
	return txt(JSON.stringify(valor ?? {}));
}

function leerJSON(ruta) {
	return JSON.parse(readFileSync(ruta, "utf8"));
}

const problemas = [];
function revisar(condicion, mensaje) {
	if (!condicion) problemas.push(mensaje);
	return condicion;
}

/* ── Lectura del contenido ──────────────────────────────────────────────── */

if (!existsSync(join(dirContenido, "libro.json"))) {
	console.error("Falta content/libro.json");
	process.exit(1);
}

const libro = leerJSON(join(dirContenido, "libro.json"));

/**
 * Track al que pertenece este contenido. libro.json puede declararlo
 * ("avanzado"); si no dice nada, es el libro basico de siempre.
 */
const TRACK = libro.track ?? "basico";

/** Mapa número -> ruta del html, leyendo content/chapters/NN-slug.html */
const cuerpos = new Map();
const dirCap = join(dirContenido, "chapters");
if (existsSync(dirCap)) {
	for (const archivo of readdirSync(dirCap)) {
		if (!archivo.endsWith(".html")) continue;
		const n = Number(archivo.slice(0, 2));
		if (Number.isInteger(n)) cuerpos.set(n, join(dirCap, archivo));
	}
}

function leerOpcional(carpeta, numero) {
	const ruta = join(dirContenido, carpeta, `${String(numero).padStart(2, "0")}.json`);
	return existsSync(ruta) ? leerJSON(ruta) : null;
}

/* ── Validación ─────────────────────────────────────────────────────────── */

function validarPregunta(q, etiqueta) {
	revisar(TIPOS.has(q.type), `${etiqueta}: type "${q.type}" no existe.`);
	revisar(Boolean(q.prompt), `${etiqueta}: falta prompt.`);
	revisar(
		!q.difficulty || DIFICULTADES.has(q.difficulty),
		`${etiqueta}: difficulty "${q.difficulty}" no existe.`,
	);

	if (q.type === "mcq" || q.type === "predict_output") {
		const ops = q.data?.options ?? [];
		revisar(ops.length >= 2, `${etiqueta}: necesita al menos 2 opciones.`);
		revisar(
			ops.some((o) => o.id === q.correct?.option_id),
			`${etiqueta}: correct.option_id no coincide con ninguna opción.`,
		);
	}
	if (q.type === "predict_output") {
		revisar(Boolean(q.code_snippet), `${etiqueta}: predict_output necesita code_snippet.`);
	}
	if (q.type === "find_bug") {
		const lineas = q.data?.lines ?? [];
		revisar(lineas.length > 0, `${etiqueta}: find_bug sin líneas.`);
		revisar(
			Number.isInteger(q.correct?.line_number) &&
				q.correct.line_number >= 1 &&
				q.correct.line_number <= lineas.length,
			`${etiqueta}: line_number fuera de rango.`,
		);
	}
	if (q.type === "parsons") {
		const lineas = q.data?.lines ?? [];
		revisar(lineas.length >= 2, `${etiqueta}: parsons necesita 2+ líneas.`);
		revisar(
			(q.correct?.order ?? []).length === lineas.length,
			`${etiqueta}: correct.order debe listar todas las líneas.`,
		);
	}
	if (q.type === "fill_blank") {
		const codigo = String(q.data?.code ?? "");
		const huecos = q.data?.blanks ?? [];
		const respuestas = q.correct?.answers ?? {};

		revisar(huecos.length > 0, `${etiqueta}: fill_blank sin huecos.`);

		for (const h of huecos) {
			const id = String(h?.id ?? "");
			// La marca tiene que existir en el código, o el hueco no se dibuja
			revisar(
				codigo.includes(`___${id}___`),
				`${etiqueta}: el código no tiene la marca ___${id}___.`,
			);
			const variantes = respuestas[id];
			revisar(
				Array.isArray(variantes) && variantes.length > 0,
				`${etiqueta}: al hueco ${id} le falta correct.answers["${id}"].`,
			);
		}

		// Al revés: una respuesta sin hueco es una respuesta que nadie escribe
		for (const id of Object.keys(respuestas)) {
			revisar(
				huecos.some((h) => String(h?.id) === id),
				`${etiqueta}: correct.answers tiene "${id}" pero no existe ese hueco.`,
			);
		}
	}

	revisar(Boolean(q.explanation), `${etiqueta}: falta explanation.`);
}

/* ── Generación del SQL ─────────────────────────────────────────────────── */

const sql = [];
sql.push("-- ============================================================================");
sql.push("--  CONTENIDO DEL LIBRO — generado por scripts/build-contenido.mjs");
sql.push("--  No editar a mano: se regenera con `npm run content:build`.");
sql.push("--  Solo toca las filas con source = 'seed'.");
sql.push("-- ============================================================================");
sql.push("");

/* Partes */
for (const p of libro.partes) {
	sql.push(
		`INSERT INTO parts (number, title, emoji, track) VALUES (${p.number}, ${txt(p.title)}, ${txt(p.emoji)}, ${txt(TRACK)})`,
	);
	sql.push(
		`  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;`,
	);
}
sql.push("");

let capitulosListos = 0;
let totalPreguntas = 0;
let totalEjercicios = 0;

for (const cap of libro.capitulos) {
	const n = cap.number;
	const etiqueta = `capítulo ${n}`;

	const rutaCuerpo = cuerpos.get(n);
	const cuerpo = rutaCuerpo ? readFileSync(rutaCuerpo, "utf8").trim() : "";
	const banco = leerOpcional("bank", n) ?? [];
	const ejercicios = leerOpcional("exercises", n) ?? [];

	const completo = Boolean(cuerpo) && banco.length > 0 && ejercicios.length > 0;
	if (completo) capitulosListos += 1;

	banco.forEach((q, i) => validarPregunta(q, `${etiqueta} · pregunta ${i + 1}`));
	ejercicios.forEach((e, i) => {
		revisar(Boolean(e.title), `${etiqueta} · ejercicio ${i + 1}: falta title.`);
		revisar(
			!e.difficulty || DIFICULTADES.has(e.difficulty),
			`${etiqueta} · ejercicio ${i + 1}: difficulty "${e.difficulty}" no existe.`,
		);
	});

	sql.push(`-- ── Capítulo ${n}: ${cap.title} ${completo ? "(publicado)" : "(borrador)"}`);

	/* El capítulo: se actualiza por número, o se crea si no estaba. */
	sql.push(
		`INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)`,
	);
	sql.push(
		`  SELECT p.id, ${n}, ${txt(cap.title)}, ${txt(cap.emoji)}, ${txt(cap.description ?? "")}, ${txt(cuerpo)}, ${completo ? 1 : 0}, ${txt(TRACK)}`,
	);
	sql.push(`    FROM parts p WHERE p.number = ${cap.part}`);
	// El numero se repite entre tracks (hay capitulo 1 en cada libro), asi
	// que el conflicto se resuelve por la pareja.
	sql.push(`  ON CONFLICT(track, number) DO UPDATE SET`);
	sql.push(`    part_id      = excluded.part_id,`);
	sql.push(`    title        = excluded.title,`);
	sql.push(`    emoji        = excluded.emoji,`);
	sql.push(`    description  = excluded.description,`);
	sql.push(`    content_html = excluded.content_html,`);
	sql.push(`    published    = excluded.published;`);

	/* El quiz del capítulo (uno por capítulo) */
	sql.push(
		`INSERT INTO quizzes (chapter_id, passing_score) SELECT id, ${cap.passing_score ?? 80} FROM chapters WHERE number = ${n} AND track = ${txt(TRACK)}`,
	);
	sql.push(
		`  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;`,
	);

	/* Ejercicios del archivo (los del profe no se tocan) */
	sql.push(
		`DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = ${n} AND track = ${txt(TRACK)});`,
	);
	ejercicios.forEach((e, i) => {
		totalEjercicios += 1;
		const tests = e.tests?.length ? json(e.tests) : "NULL";
		sql.push(
			`INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)`,
		);
		sql.push(
			`  SELECT id, ${e.orden ?? i + 1}, ${txt(e.title)}, ${txt(e.difficulty ?? "facil")}, ${txt(e.statement_html ?? "")}, ${txt(e.hint_html ?? "")}, ${txt(e.solution_html ?? "")}, ${tests}, ${e.starter_code ? txt(e.starter_code) : "NULL"}, 'seed'`,
		);
		sql.push(`    FROM chapters WHERE number = ${n} AND track = ${txt(TRACK)};`);
	});

	/* Banco del archivo */
	sql.push(
		`DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = ${n} AND track = ${txt(TRACK)});`,
	);
	banco.forEach((q) => {
		totalPreguntas += 1;
		sql.push(
			`INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)`,
		);
		sql.push(
			`  SELECT id, ${txt(q.type)}, ${txt(q.difficulty ?? "facil")}, ${txt(q.prompt)}, ${q.code_snippet ? txt(q.code_snippet) : "NULL"}, ${json(q.data)}, ${json(q.correct)}, ${txt(q.explanation ?? "")}, 1, 'seed'`,
		);
		sql.push(`    FROM chapters WHERE number = ${n} AND track = ${txt(TRACK)};`);
	});

	sql.push("");
}

if (problemas.length > 0) {
	console.error("\nEl contenido tiene problemas:\n");
	for (const p of problemas) console.error(`  · ${p}`);
	console.error("\nNo se generó nada.");
	process.exit(1);
}

mkdirSync(join(raiz, "seeds"), { recursive: true });
writeFileSync(salida, `${sql.join("\n")}\n`, "utf8");

console.log(`seeds/${carpetaLibro || "contenido"}.sql generado · track ${TRACK}`);
console.log(
	`  ${libro.capitulos.length} capítulos (${capitulosListos} publicados) · ` +
		`${totalPreguntas} preguntas · ${totalEjercicios} ejercicios`,
);
