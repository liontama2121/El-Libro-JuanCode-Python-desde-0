#!/usr/bin/env node
/**
 * Genera seeds/peliculas.sql desde content/peliculas.json.
 *
 * El seed es idempotente: hace upsert por (chapter_id, orden), así que
 * volver a correrlo actualiza las mismas seis películas en vez de duplicarlas.
 *
 * Antes de emitir nada valida la forma de cada demo. La verificación contra
 * Python real la hace scripts/verify-traces.py, que es lo que manda.
 */

import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const RAIZ = join(dirname(fileURLToPath(import.meta.url)), "..");
const FUENTE = join(RAIZ, "content", "peliculas.json");
const SALIDA = join(RAIZ, "seeds", "peliculas.sql");

/** Escapa un texto para meterlo en un literal SQL de SQLite. */
const txt = (v) => `'${String(v ?? "").replaceAll("'", "''")}'`;

const { peliculas } = JSON.parse(readFileSync(FUENTE, "utf8"));
const problemas = [];

peliculas.forEach((p, i) => {
	const donde = `película ${i + 1} (${p.title ?? "sin título"})`;

	if (!Number.isInteger(p.chapter)) problemas.push(`${donde}: falta "chapter"`);
	if (!Number.isInteger(p.orden)) problemas.push(`${donde}: falta "orden"`);
	if (!p.title) problemas.push(`${donde}: falta "title"`);
	if (!p.code) problemas.push(`${donde}: falta "code"`);

	if (!Array.isArray(p.columns) || p.columns.length === 0) {
		problemas.push(`${donde}: "columns" tiene que ser un array con columnas`);
		return;
	}
	if (!Array.isArray(p.steps) || p.steps.length === 0) {
		problemas.push(`${donde}: "steps" tiene que ser un array con pasos`);
		return;
	}

	p.steps.forEach((paso, j) => {
		const fila = `${donde}, paso ${j + 1}`;
		if (!Array.isArray(paso.cells)) {
			problemas.push(`${fila}: le falta "cells"`);
			return;
		}
		if (paso.cells.length !== p.columns.length) {
			problemas.push(
				`${fila}: ${paso.cells.length} celdas y ${p.columns.length} columnas`,
			);
		}
		if (paso.out !== undefined && typeof paso.out !== "string") {
			problemas.push(`${fila}: "out" tiene que ser texto`);
		}
		if (
			paso.hl !== null &&
			paso.hl !== undefined &&
			(!Number.isInteger(paso.hl) || paso.hl < 0 || paso.hl >= p.columns.length)
		) {
			problemas.push(`${fila}: "hl" fuera de rango`);
		}
	});
});

// Dos películas del mismo capítulo no pueden pelear por el mismo orden:
// el upsert las pisaría entre sí.
const vistos = new Set();
for (const p of peliculas) {
	const clave = `${p.chapter}-${p.orden}`;
	if (vistos.has(clave)) {
		problemas.push(`capítulo ${p.chapter}: dos películas con orden ${p.orden}`);
	}
	vistos.add(clave);
}

if (problemas.length) {
	console.error("❌ No se generó nada. Problemas encontrados:\n");
	for (const p of problemas) console.error(`  · ${p}`);
	process.exit(1);
}

const lineas = [
	"-- Generado por scripts/build-peliculas.mjs — NO editar a mano.",
	"-- Fuente: content/peliculas.json",
	"-- Verificado contra Python real con scripts/verify-traces.py",
	"",
];

for (const p of peliculas) {
	const pasos = p.steps.map((paso) => ({
		cells: paso.cells.map((c) => String(c ?? "")),
		out: String(paso.out ?? ""),
		hl: paso.hl === undefined ? null : paso.hl,
	}));

	lineas.push(
		`-- Capítulo ${p.chapter} · ${p.orden}. ${p.title}`,
		"INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)",
		`SELECT id, ${p.orden}, ${txt(p.title)}, ${txt(p.description)}, ${txt(p.code)}, ${txt(
			JSON.stringify(p.columns),
		)}, ${txt(JSON.stringify(pasos))}, 1`,
		// El track importa: sin el filtro, la película se pegaría también al
		// capítulo con el mismo número del track avanzado.
		`FROM chapters WHERE number = ${p.chapter} AND track = 'basico'`,
		"ON CONFLICT(chapter_id, orden) DO UPDATE SET",
		"  title = excluded.title,",
		"  description = excluded.description,",
		"  code = excluded.code,",
		"  columns_json = excluded.columns_json,",
		"  steps_json = excluded.steps_json,",
		"  active = excluded.active;",
		"",
	);
}

writeFileSync(SALIDA, lineas.join("\n"), "utf8");

const porCapitulo = peliculas.reduce((acc, p) => {
	acc[p.chapter] = (acc[p.chapter] ?? 0) + 1;
	return acc;
}, {});

console.log("seeds/peliculas.sql generado");
console.log(
	`  ${peliculas.length} películas · ${Object.entries(porCapitulo)
		.map(([cap, n]) => `capítulo ${cap}: ${n}`)
		.join(" · ")}`,
);
