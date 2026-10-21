/* ==========================================================================
   Los libros paralelos: Nivel 0, básico y avanzado.

   Módulo puro (sin `.server`): lo usan los loaders, los componentes y el
   panel del profe. Aquí vive la única definición de qué track ve quién y
   con qué URL se llega a cada uno.
   ========================================================================== */

import type { Track, TrackUsuario } from "~/db/schema";

export type { Track, TrackUsuario };

/** Cómo se ve cada track en pantalla. */
export const TRACK_INFO = {
	nivel0: {
		nombre: "Nivel 0 — Planas de código",
		corto: "Nivel 0",
		emoji: "✍️",
		descripcion:
			"Los patrones de vectores del examen, repetidos hasta que salgan solos. Para aprobar el primer parcial.",
		color: "var(--color-verde)",
	},
	basico: {
		nombre: "Python desde 0",
		corto: "Básico",
		emoji: "🐍",
		descripcion:
			"Los 24 capítulos, de las variables a tu propia API. Para arrancar desde cero.",
		color: "var(--color-cyan)",
	},
	avanzado: {
		nombre: "Algoritmos y competitiva",
		corto: "Avanzado",
		emoji: "🚀",
		descripcion:
			"Recursión, backtracking, DP y greedy. Para cursos tipo DDYA y jueces en línea.",
		color: "var(--color-magenta)",
	},
} as const satisfies Record<Track, unknown>;

/** Todos los libros, en el orden en que se muestran. El profe los ve todos. */
export const TODOS_LOS_TRACKS: Track[] = ["nivel0", "basico", "avanzado"];

/**
 * Qué libros puede abrir un estudiante según lo que le asignó el profe.
 * El Nivel 0 es la base del básico: quien tiene el básico también lo ve.
 */
export function tracksVisibles(trackUsuario: TrackUsuario | string): Track[] {
	if (trackUsuario === "avanzado") return ["avanzado"];
	if (trackUsuario === "nivel0") return ["nivel0"];
	if (trackUsuario === "ambos") return TODOS_LOS_TRACKS;
	return ["nivel0", "basico"];
}

/** ¿Este usuario tiene permiso de abrir ese libro? El profe entra a todos. */
export function puedeVerTrack(
	trackUsuario: TrackUsuario | string,
	track: Track,
	esProfesor = false,
): boolean {
	return esProfesor || tracksVisibles(trackUsuario).includes(track);
}

/* -------------------------------------------------------------------------- */
/*  URLs                                                                       */
/* -------------------------------------------------------------------------- */

/**
 * El básico conserva sus URLs de siempre (/libro/...) para no romper links
 * ni marcadores. El avanzado cuelga de /avanzado y el Nivel 0 de /nivel0.
 */
export function rutaLibro(track: Track): string {
	if (track === "avanzado") return "/avanzado";
	if (track === "nivel0") return "/nivel0";
	return "/libro";
}

export function rutaCapitulo(track: Track, numero: number): string {
	if (track === "avanzado") return `/avanzado/modulo/${numero}`;
	if (track === "nivel0") return `/nivel0/capitulo/${numero}`;
	return `/libro/capitulo/${numero}`;
}

export function rutaQuiz(track: Track, numero: number): string {
	return `${rutaCapitulo(track, numero)}/quiz`;
}

/** De qué libro habla esta URL. Es lo que usan los loaders compartidos. */
export function trackDeRuta(url: string | URL): Track {
	const ruta = typeof url === "string" ? new URL(url).pathname : url.pathname;
	if (ruta.startsWith("/avanzado")) return "avanzado";
	if (ruta.startsWith("/nivel0")) return "nivel0";
	return "basico";
}

/** "Capítulo" en el básico, "Módulo" en el avanzado. */
export function palabraCapitulo(track: Track): string {
	return track === "avanzado" ? "Módulo" : "Capítulo";
}
