/**
 * Niveles e insignias: datos y funciones PURAS.
 *
 * Vive fuera de `gamification.server` a propósito: el ranking y el perfil los
 * dibujan en el cliente, y un módulo `.server` no puede acabar en el bundle
 * del navegador.
 */

export const NIVELES = [
	{ nivel: 0, desde: 0, nombre: "Novato", emoji: "🌱" },
	{ nivel: 1, desde: 300, nombre: "Aprendiz", emoji: "📦" },
	{ nivel: 2, desde: 800, nombre: "Programador", emoji: "💻" },
	{ nivel: 3, desde: 1500, nombre: "Hacker", emoji: "🧠" },
	{ nivel: 4, desde: 3000, nombre: "Maestro JuanCode", emoji: "🏆" },
] as const;

export type Nivel = (typeof NIVELES)[number];

/** Nivel actual, siguiente y cuánto falta. */
export function nivelDe(xp: number) {
	let actual: Nivel = NIVELES[0];
	for (const n of NIVELES) if (xp >= n.desde) actual = n;
	const siguiente = NIVELES.find((n) => n.desde > xp) ?? null;

	const base = actual.desde;
	const techo = siguiente?.desde ?? actual.desde;
	const progreso = siguiente ? Math.round(((xp - base) / (techo - base)) * 100) : 100;

	return { actual, siguiente, progreso, faltan: siguiente ? siguiente.desde - xp : 0 };
}

export const INSIGNIAS = [
	{ id: "primer_capitulo", emoji: "🌱", nombre: "Primer capítulo", texto: "Aprobaste tu primer quiz de capítulo." },
	{ id: "cinco_capitulos", emoji: "🖐️", nombre: "Cinco capítulos", texto: "Cinco capítulos aprobados." },
	{ id: "medio_libro", emoji: "📖", nombre: "Medio libro", texto: "Doce capítulos aprobados." },
	{ id: "libro_completo", emoji: "🏁", nombre: "Libro completo", texto: "Los 24 capítulos aprobados." },
	{ id: "racha_7", emoji: "🔥", nombre: "Racha de 7 días", texto: "Siete días seguidos practicando." },
	{ id: "simulacro_perfecto", emoji: "💯", nombre: "Simulacro perfecto", texto: "100% en un simulacro de quiz." },
	{ id: "cazador_bugs", emoji: "🕵️", nombre: "Cazador de bugs", texto: "20 bugs encontrados." },
	{ id: "arquitecto", emoji: "🧩", nombre: "Arquitecto", texto: "20 rompecabezas armados." },
	{ id: "relampago", emoji: "⚡", nombre: "Relámpago", texto: "10 aciertos seguidos en modo relámpago." },
] as const;

export type IdInsignia = (typeof INSIGNIAS)[number]["id"];
