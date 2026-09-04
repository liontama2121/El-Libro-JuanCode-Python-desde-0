/* ==========================================================================
   Los dos libros paralelos.

   Módulo puro (sin `.server`): lo usan los loaders, los componentes y el
   panel del profe. Aquí vive la única definición de qué track ve quién y
   con qué URL se llega a cada uno.
   ========================================================================== */

import type { Track, TrackUsuario } from "~/db/schema";

export type { Track, TrackUsuario };

/** Cómo se ve cada track en pantalla. */
export const TRACK_INFO = {
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

/** Qué libros puede abrir un estudiante según lo que le asignó el profe. */
export function tracksVisibles(trackUsuario: TrackUsuario | string): Track[] {
	if (trackUsuario === "avanzado") return ["avanzado"];
	if (trackUsuario === "ambos") return ["basico", "avanzado"];
	return ["basico"];
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
 * ni marcadores. El avanzado cuelga de /avanzado.
 */
export function rutaLibro(track: Track): string {
	return track === "avanzado" ? "/avanzado" : "/libro";
}

export function rutaCapitulo(track: Track, numero: number): string {
	return track === "avanzado"
		? `/avanzado/modulo/${numero}`
		: `/libro/capitulo/${numero}`;
}

export function rutaQuiz(track: Track, numero: number): string {
	return `${rutaCapitulo(track, numero)}/quiz`;
}

/** De qué libro habla esta URL. Es lo que usan los loaders compartidos. */
export function trackDeRuta(url: string | URL): Track {
	const ruta = typeof url === "string" ? new URL(url).pathname : url.pathname;
	return ruta.startsWith("/avanzado") ? "avanzado" : "basico";
}

/** "Capítulo" en el básico, "Módulo" en el avanzado. */
export function palabraCapitulo(track: Track): string {
	return track === "avanzado" ? "Módulo" : "Capítulo";
}
