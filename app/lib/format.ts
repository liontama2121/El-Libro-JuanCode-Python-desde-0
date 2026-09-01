export function formatearFecha(valor: Date | string | number) {
	const d = valor instanceof Date ? valor : new Date(valor);
	return d.toLocaleDateString("es-CO", {
		day: "2-digit",
		month: "short",
		year: "numeric",
	});
}

export function formatearFechaHora(valor: Date | string | number) {
	const d = valor instanceof Date ? valor : new Date(valor);
	return d.toLocaleString("es-CO", {
		day: "2-digit",
		month: "short",
		year: "numeric",
		hour: "2-digit",
		minute: "2-digit",
	});
}

const ROMANOS = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];

export function romano(n: number) {
	return ROMANOS[n] ?? String(n);
}

/** Segundos -> mm:ss (cronómetros de simulacros y arcade). */
export function formatoReloj(segundos: number) {
	const m = Math.floor(Math.max(0, segundos) / 60);
	const s = Math.max(0, segundos) % 60;
	return `${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
}
