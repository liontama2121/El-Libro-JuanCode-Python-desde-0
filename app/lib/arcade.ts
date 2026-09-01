import type { TipoPregunta } from "~/db/schema";

/**
 * Configuración de cada modo del arcade. Vive fuera de `.server` porque la
 * usan tanto el menú (cliente) como los loaders/actions.
 */
export type ModoArcade = {
	slug: string;
	emoji: string;
	nombre: string;
	blurb: string;
	/** rgb sin paréntesis, para pintar bordes y textos */
	color: string;
	tipos: TipoPregunta[];
	limite: number;
	/** 0 = sin vidas */
	vidas: number;
	/** 0 = sin cronómetro */
	segundos: number;
	/** valor de practice_attempts.mode */
	mode: string;
};

export const MODOS: Record<string, ModoArcade> = {
	relampago: {
		slug: "relampago",
		emoji: "⚡",
		nombre: "Relámpago",
		blurb: "60 segundos adivinando qué imprime cada programa. Suma racha.",
		color: "255,212,59",
		tipos: ["predict_output"],
		limite: 25,
		vidas: 0,
		segundos: 60,
		mode: "arcade_relampago",
	},
	detective: {
		slug: "detective",
		emoji: "🕵️",
		nombre: "Detective",
		blurb: "Encuentra la línea con el error. Tres vidas.",
		color: "0,229,255",
		tipos: ["find_bug"],
		limite: 15,
		vidas: 3,
		segundos: 0,
		mode: "arcade_detective",
	},
	puzzle: {
		slug: "puzzle",
		emoji: "🧩",
		nombre: "Rompecabezas",
		blurb: "Arma el programa línea por línea, con su indentación. Tres vidas.",
		color: "185,117,255",
		tipos: ["parsons"],
		limite: 10,
		vidas: 3,
		segundos: 0,
		mode: "arcade_puzzle",
	},
	sorpresa: {
		slug: "sorpresa",
		emoji: "🎲",
		nombre: "Sorpresa",
		blurb: "Diez preguntas mezclando los tres modos. Tres vidas.",
		color: "255,77,255",
		tipos: ["predict_output", "find_bug", "parsons"],
		limite: 10,
		vidas: 3,
		segundos: 0,
		mode: "arcade_sorpresa",
	},
	reto: {
		slug: "reto",
		emoji: "🗓️",
		nombre: "Reto del día",
		blurb: "Cinco preguntas iguales para todo el curso. Un intento por día.",
		color: "52,224,122",
		tipos: ["mcq", "predict_output", "find_bug", "parsons"],
		limite: 5,
		vidas: 0,
		segundos: 0,
		mode: "reto_dia",
	},
};

export const ORDEN_MODOS = ["relampago", "detective", "puzzle", "sorpresa", "reto"];
