import { cargarAgenda } from "../../lib/agenda.js";
import { error, json } from "../../lib/seguridad.js";

/**
 * GET /api/disponibilidad — la agenda como la ve cualquiera.
 *
 * Sale del servidor y sin caché: lo que Juan marque en su panel se ve aquí
 * en la siguiente consulta, sin esperar nada.
 */
export async function onRequestGet({ env }) {
	try {
		const agenda = await cargarAgenda(env.DB);
		return json({ ok: true, ...agenda }, 200, { "cache-control": "no-store" });
	} catch (e) {
		console.error("[disponibilidad]", e);
		return error("No se pudo cargar la agenda. Recarga en un momento.", 500);
	}
}
