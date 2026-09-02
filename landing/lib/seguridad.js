/* ==========================================================================
   Seguridad del panel: sesión firmada y freno a la fuerza bruta.
   Nada de esto se puede hacer en el cliente.
   ========================================================================== */

const COOKIE = "jc_admin";
const DURACION_MS = 8 * 3600_000;

const enc = new TextEncoder();

const b64url = (bytes) =>
	btoa(String.fromCharCode(...new Uint8Array(bytes)))
		.replaceAll("+", "-")
		.replaceAll("/", "_")
		.replaceAll("=", "");

async function clave(secreto) {
	return crypto.subtle.importKey(
		"raw",
		enc.encode(secreto),
		{ name: "HMAC", hash: "SHA-256" },
		false,
		["sign"],
	);
}

async function firmar(secreto, texto) {
	return b64url(await crypto.subtle.sign("HMAC", await clave(secreto), enc.encode(texto)));
}

/** Comparación en tiempo constante: no se filtra en cuántos caracteres falló. */
function igualSeguro(a, b) {
	if (a.length !== b.length) return false;
	let dif = 0;
	for (let i = 0; i < a.length; i++) dif |= a.charCodeAt(i) ^ b.charCodeAt(i);
	return dif === 0;
}

/** Cookie de sesión del panel: vence sola a las 8 horas y va firmada. */
export async function crearCookieSesion(secreto, url) {
	const vence = String(Date.now() + DURACION_MS);
	const valor = `${vence}.${await firmar(secreto, vence)}`;
	const seguro = new URL(url).protocol === "https:" ? " Secure;" : "";

	return `${COOKIE}=${valor}; Path=/; HttpOnly;${seguro} SameSite=Lax; Max-Age=${DURACION_MS / 1000}`;
}

export function cookieVacia(url) {
	const seguro = new URL(url).protocol === "https:" ? " Secure;" : "";
	return `${COOKIE}=; Path=/; HttpOnly;${seguro} SameSite=Lax; Max-Age=0`;
}

/** ¿La petición trae una sesión válida y sin vencer? */
export async function sesionValida(request, secreto) {
	if (!secreto) return false;

	const cookies = request.headers.get("Cookie") || "";
	const bruto = cookies
		.split(";")
		.map((c) => c.trim())
		.find((c) => c.startsWith(`${COOKIE}=`))
		?.slice(COOKIE.length + 1);

	if (!bruto) return false;

	const [vence, firma] = bruto.split(".");
	if (!vence || !firma) return false;
	if (Number(vence) < Date.now()) return false;

	return igualSeguro(firma, await firmar(secreto, vence));
}

/* -------------------------------------------------------------------------- */
/*  Rate limit — 5 envíos por hora por IP                                      */
/* -------------------------------------------------------------------------- */

export const LIMITE_POR_HORA = 5;

export function ipDe(request) {
	return (
		request.headers.get("CF-Connecting-IP") ||
		request.headers.get("X-Forwarded-For")?.split(",")[0]?.trim() ||
		"desconocida"
	);
}

/** true = ya pasó del límite. También limpia lo viejo, para no crecer sin fin. */
export async function pasoDelLimite(db, ip) {
	const desde = Date.now() - 3600_000;

	await db.prepare("DELETE FROM rate_limit WHERE created_at < ?1").bind(desde).run();

	const { total } = await db
		.prepare("SELECT COUNT(*) AS total FROM rate_limit WHERE ip = ?1 AND created_at >= ?2")
		.bind(ip, desde)
		.first();

	return Number(total) >= LIMITE_POR_HORA;
}

export async function registrarEnvio(db, ip) {
	await db
		.prepare("INSERT INTO rate_limit (ip, created_at) VALUES (?1, ?2)")
		.bind(ip, Date.now())
		.run();
}

/* -------------------------------------------------------------------------- */

export const json = (datos, status = 200, headers = {}) =>
	new Response(JSON.stringify(datos), {
		status,
		headers: { "content-type": "application/json; charset=utf-8", ...headers },
	});

export const error = (mensaje, status = 400) => json({ ok: false, error: mensaje }, status);
