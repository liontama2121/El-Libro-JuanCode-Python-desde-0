#!/usr/bin/env node
/**
 * Corre la solución documentada de cada ejercicio contra sus propios tests.
 *
 * Es el control de calidad del contenido: si un `expected_output` está mal
 * escrito, o la solución no hace lo que dice el enunciado, aquí se ve antes
 * de que lo vea un estudiante.
 *
 *   npm run content:verificar
 *
 * Necesita python en el PATH. No usa Piston: corre local y va mucho más rápido.
 */

import { readFileSync, readdirSync, existsSync } from "node:fs";
import { spawnSync } from "node:child_process";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const raiz = join(dirname(fileURLToPath(import.meta.url)), "..");
const dirEjercicios = join(raiz, "content", "exercises");

/** Igual que el Modo Código: espacios al final de línea y saltos sobrantes no cuentan. */
function normalizar(texto) {
	return texto
		.replace(/\r\n/g, "\n")
		.split("\n")
		.map((l) => l.replace(/\s+$/, ""))
		.join("\n")
		.trim();
}

const ENTIDADES = {
	"&lt;": "<",
	"&gt;": ">",
	"&amp;": "&",
	"&quot;": '"',
	"&#39;": "'",
	"&nbsp;": " ",
};

function desescapar(html) {
	return html.replace(/&(lt|gt|amp|quot|#39|nbsp);/g, (m) => ENTIDADES[m] ?? m);
}

/** Saca el primer bloque <pre><code>…</code></pre> de la solución. */
function codigoDe(solutionHtml) {
	const m = /<pre><code>([\s\S]*?)<\/code><\/pre>/.exec(solutionHtml ?? "");
	return m ? desescapar(m[1]) : null;
}

let total = 0;
let fallos = 0;
const sinTests = [];

const archivos = existsSync(dirEjercicios)
	? readdirSync(dirEjercicios).filter((f) => f.endsWith(".json")).sort()
	: [];

for (const archivo of archivos) {
	const capitulo = archivo.replace(".json", "");
	const ejercicios = JSON.parse(readFileSync(join(dirEjercicios, archivo), "utf8"));

	for (const ej of ejercicios) {
		if (!ej.tests?.length) {
			sinTests.push(`${capitulo} · ${ej.title}`);
			continue;
		}

		const codigo = codigoDe(ej.solution_html);
		if (!codigo) {
			fallos += 1;
			console.log(`❌ ${capitulo} · ${ej.title}: no se encontró bloque de código en la solución`);
			continue;
		}

		for (const [i, test] of ej.tests.entries()) {
			total += 1;
			const res = spawnSync("python", ["-c", codigo], {
				input: test.stdin ?? "",
				encoding: "utf8",
				timeout: 10_000,
			});

			const obtenido = normalizar(res.stdout ?? "");
			const esperado = normalizar(test.expected_output ?? "");

			if (res.status !== 0) {
				fallos += 1;
				console.log(`❌ ${capitulo} · ${ej.title} · caso ${i + 1}: la solución se cayó`);
				console.log(`   ${(res.stderr ?? "").trim().split("\n").slice(-1)[0]}`);
				continue;
			}

			if (obtenido !== esperado) {
				fallos += 1;
				console.log(`❌ ${capitulo} · ${ej.title} · caso ${i + 1}`);
				console.log(`   esperaba: ${JSON.stringify(esperado)}`);
				console.log(`   salió:    ${JSON.stringify(obtenido)}`);
			}
		}
	}
}

console.log(`\n${total - fallos}/${total} casos en verde`);
if (sinTests.length) {
	console.log(`\n${sinTests.length} ejercicios sin tests (no se verifican):`);
	for (const s of sinTests) console.log(`  · ${s}`);
}

process.exit(fallos > 0 ? 1 : 0);
