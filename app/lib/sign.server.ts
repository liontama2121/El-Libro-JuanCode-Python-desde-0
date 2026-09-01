/**
 * Firma HMAC de las cargas que van y vuelven del cliente.
 *
 * Cuando un quiz se arma con preguntas ALEATORIAS, el servidor tiene que
 * saber en el `action` exactamente qué preguntas sirvió el `loader`. En vez
 * de guardar una sesión por intento, el loader manda la lista de ids firmada
 * y el action verifica la firma antes de calificar: así el estudiante no
 * puede cambiarse las preguntas por otras.
 *
 * (Esto NO revela nada: la respuesta correcta jamás sale del servidor.)
 */

function secretoDe(env: Env) {
	return env.BETTER_AUTH_SECRET || "dev-secret-solo-para-local-cambiar-en-produccion";
}

async function clave(env: Env) {
	return crypto.subtle.importKey(
		"raw",
		new TextEncoder().encode(secretoDe(env)),
		{ name: "HMAC", hash: "SHA-256" },
		false,
		["sign", "verify"],
	);
}

function aHex(buffer: ArrayBuffer) {
	return [...new Uint8Array(buffer)]
		.map((b) => b.toString(16).padStart(2, "0"))
		.join("");
}

/** Devuelve `<payload en base64url>.<firma hex>`. */
export async function firmar(env: Env, payload: unknown): Promise<string> {
	const json = JSON.stringify(payload);
	const datos = new TextEncoder().encode(json);
	const firma = await crypto.subtle.sign("HMAC", await clave(env), datos);
	return `${base64url(json)}.${aHex(firma)}`;
}

/** Verifica y devuelve el payload, o null si la firma no cuadra. */
export async function verificar<T>(env: Env, token: string): Promise<T | null> {
	const corte = token.lastIndexOf(".");
	if (corte < 1) return null;

	const json = desdeBase64url(token.slice(0, corte));
	if (json === null) return null;

	const esperada = aHex(
		await crypto.subtle.sign("HMAC", await clave(env), new TextEncoder().encode(json)),
	);
	if (!igualEnTiempoConstante(esperada, token.slice(corte + 1))) return null;

	try {
		return JSON.parse(json) as T;
	} catch {
		return null;
	}
}

function igualEnTiempoConstante(a: string, b: string) {
	if (a.length !== b.length) return false;
	let diff = 0;
	for (let i = 0; i < a.length; i++) diff |= a.charCodeAt(i) ^ b.charCodeAt(i);
	return diff === 0;
}

function base64url(texto: string) {
	const bytes = new TextEncoder().encode(texto);
	let binario = "";
	for (const b of bytes) binario += String.fromCharCode(b);
	return btoa(binario).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

function desdeBase64url(texto: string): string | null {
	try {
		const base = texto.replace(/-/g, "+").replace(/_/g, "/");
		const binario = atob(base.padEnd(Math.ceil(base.length / 4) * 4, "="));
		const bytes = Uint8Array.from(binario, (c) => c.charCodeAt(0));
		return new TextDecoder().decode(bytes);
	} catch {
		return null;
	}
}
