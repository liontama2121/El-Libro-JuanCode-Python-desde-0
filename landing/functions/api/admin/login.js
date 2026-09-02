import { cookieVacia, crearCookieSesion, error, ipDe, json, pasoDelLimite, registrarEnvio, sesionValida } from "../../../lib/seguridad.js";

/** GET /api/admin/login — ¿ya hay sesión abierta? */
export async function onRequestGet({ request, env }) {
	return json({ ok: true, sesion: await sesionValida(request, env.ADMIN_PASSWORD) });
}

/** POST /api/admin/login — entra al panel. */
export async function onRequestPost({ request, env }) {
	if (!env.ADMIN_PASSWORD) {
		return error("El panel no tiene ADMIN_PASSWORD configurada.", 500);
	}

	const ip = ipDe(request);

	// El mismo freno del formulario público: nadie prueba claves a lo bruto
	try {
		if (await pasoDelLimite(env.DB, `admin:${ip}`)) {
			return error("Demasiados intentos. Espera una hora.", 429);
		}
	} catch {}

	let clave = "";
	try {
		const form = await request.formData();
		clave = String(form.get("password") ?? "");
	} catch {
		return error("Petición inválida.");
	}

	if (clave !== env.ADMIN_PASSWORD) {
		registrarEnvio(env.DB, `admin:${ip}`).catch(() => {});
		return error("Clave incorrecta.", 401);
	}

	return json({ ok: true }, 200, {
		"set-cookie": await crearCookieSesion(env.ADMIN_PASSWORD, request.url),
	});
}

/** DELETE /api/admin/login — sale del panel. */
export async function onRequestDelete({ request }) {
	return json({ ok: true }, 200, { "set-cookie": cookieVacia(request.url) });
}
