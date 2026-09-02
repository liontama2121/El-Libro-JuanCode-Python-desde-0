/**
 * "La película en vivo": tipos y parseo de una prueba de escritorio.
 *
 * Módulo puro (sin `.server`) porque lo usan el lector, el panel del profe y
 * el componente `TraceStepper` del cliente.
 */

/** Un paso = una fila de la tabla + lo que el programa imprime en ese momento. */
export type TracePaso = {
	/** Un texto por columna. Si faltan, se rellenan con "" */
	cells: string[];
	/** Lo que sale en la consola en este paso. "" = no imprime nada */
	out: string;
	/** Índice de la celda a resaltar en magenta, o null */
	hl: number | null;
};

/** Una película lista para renderizar. */
export type Pelicula = {
	id: number;
	orden: number;
	title: string;
	description: string;
	code: string;
	columns: string[];
	pasos: TracePaso[];
};

/** Fila cruda de `trace_demos` (o lo que escribe el profe en el formulario). */
export type TraceCrudo = {
	id?: number;
	orden?: number;
	title?: string | null;
	description?: string | null;
	code?: string | null;
	columnsJson?: string | null;
	stepsJson?: string | null;
};

/**
 * Lee `columns_json`: un array de títulos de columna.
 * Devuelve [] si el JSON no sirve, para que una película mal escrita no
 * tumbe el capítulo entero.
 */
export function leerColumnas(json: string | null | undefined): string[] {
	try {
		const crudo = JSON.parse(json || "[]");
		if (!Array.isArray(crudo)) return [];
		return crudo.map((c) => String(c ?? ""));
	} catch {
		return [];
	}
}

/**
 * Lee `steps_json` y normaliza cada paso: siempre `cells` con una entrada por
 * columna, `out` como texto y `hl` como índice válido o null.
 */
export function leerPasos(
	json: string | null | undefined,
	columnas: number,
): TracePaso[] {
	let crudo: unknown;
	try {
		crudo = JSON.parse(json || "[]");
	} catch {
		return [];
	}
	if (!Array.isArray(crudo)) return [];

	return crudo.map((p) => {
		const paso = (p ?? {}) as Record<string, unknown>;
		const celdas = Array.isArray(paso.cells)
			? paso.cells.map((c) => String(c ?? ""))
			: [];

		// La tabla tiene un <td> por columna sí o sí: si el paso trae menos
		// celdas se rellenan, y si trae más se recortan.
		const cells = Array.from(
			{ length: columnas },
			(_, i) => celdas[i] ?? "",
		);

		const hlCrudo = Number(paso.hl);
		const hl =
			paso.hl === null || paso.hl === undefined || !Number.isInteger(hlCrudo)
				? null
				: hlCrudo >= 0 && hlCrudo < columnas
					? hlCrudo
					: null;

		return { cells, out: String(paso.out ?? ""), hl };
	});
}

/** Convierte una fila de la base (o del formulario) en algo renderizable. */
export function aPelicula(fila: TraceCrudo): Pelicula {
	const columns = leerColumnas(fila.columnsJson);
	return {
		id: fila.id ?? 0,
		orden: fila.orden ?? 1,
		title: fila.title ?? "",
		description: fila.description ?? "",
		code: fila.code ?? "",
		columns,
		pasos: leerPasos(fila.stepsJson, columns.length),
	};
}

/** Todo lo que el programa imprime, de principio a fin. */
export function salidaCompleta(pasos: TracePaso[]): string {
	return pasos.map((p) => p.out).join("");
}

export type ErrorValidacion = { campo: "columns_json" | "steps_json"; mensaje: string };

/**
 * Valida lo que el profe escribió en los dos textareas del panel.
 * Devuelve la lista de problemas, en español y diciendo qué fila falla.
 */
export function validarPelicula(
	columnsJson: string,
	stepsJson: string,
): ErrorValidacion[] {
	const errores: ErrorValidacion[] = [];

	let columnas: unknown;
	try {
		columnas = JSON.parse(columnsJson || "[]");
	} catch (e) {
		errores.push({
			campo: "columns_json",
			mensaje: `No es JSON válido: ${(e as Error).message}`,
		});
		columnas = null;
	}

	if (columnas !== null && !Array.isArray(columnas)) {
		errores.push({
			campo: "columns_json",
			mensaje: 'Tiene que ser un array de textos: ["Vuelta", "contador"]',
		});
	}

	const nCol = Array.isArray(columnas) ? columnas.length : 0;
	if (Array.isArray(columnas) && nCol === 0) {
		errores.push({
			campo: "columns_json",
			mensaje: "La tabla necesita por lo menos una columna.",
		});
	}

	let pasos: unknown;
	try {
		pasos = JSON.parse(stepsJson || "[]");
	} catch (e) {
		errores.push({
			campo: "steps_json",
			mensaje: `No es JSON válido: ${(e as Error).message}`,
		});
		return errores;
	}

	if (!Array.isArray(pasos)) {
		errores.push({
			campo: "steps_json",
			mensaje:
				'Tiene que ser un array de pasos: [{ "cells": [...], "out": "", "hl": null }]',
		});
		return errores;
	}

	if (pasos.length === 0) {
		errores.push({ campo: "steps_json", mensaje: "La película no tiene pasos." });
	}

	pasos.forEach((p, i) => {
		const fila = i + 1;
		const paso = (p ?? {}) as Record<string, unknown>;

		if (!Array.isArray(paso.cells)) {
			errores.push({
				campo: "steps_json",
				mensaje: `Paso ${fila}: le falta "cells" (array de textos, uno por columna).`,
			});
			return;
		}

		if (nCol > 0 && paso.cells.length !== nCol) {
			errores.push({
				campo: "steps_json",
				mensaje: `Paso ${fila}: tiene ${paso.cells.length} celdas y la tabla tiene ${nCol} columnas.`,
			});
		}

		if (paso.out !== undefined && typeof paso.out !== "string") {
			errores.push({
				campo: "steps_json",
				mensaje: `Paso ${fila}: "out" tiene que ser texto (usa "" si no imprime nada).`,
			});
		}

		if (paso.hl !== undefined && paso.hl !== null) {
			const hl = Number(paso.hl);
			if (!Number.isInteger(hl) || hl < 0 || (nCol > 0 && hl >= nCol)) {
				errores.push({
					campo: "steps_json",
					mensaje: `Paso ${fila}: "hl" tiene que ser null o un índice entre 0 y ${nCol - 1}.`,
				});
			}
		}
	});

	return errores;
}
