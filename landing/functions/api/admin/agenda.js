import { HORAS, cargarAgenda, slotValido } from "../../../lib/agenda.js";
import { error, json } from "../../../lib/seguridad.js";

/** GET /api/admin/agenda — la misma agenda, incluidas las horas ya pasadas. */
export async function onRequestGet({ env }) {
	try {
		const agenda = await cargarAgenda(env.DB, { incluirPasadas: true, incluirMotivos: true });
		return json({ ok: true, ...agenda }, 200, { "cache-control": "no-store" });
	} catch (e) {
		console.error("[admin/agenda]", e);
		return error("No se pudo cargar la agenda.", 500);
	}
}

/**
 * POST /api/admin/agenda — marca o libera.
 *
 * intent = "ocupar" | "liberar"
 * hora   = 18..22, o vacío para el día completo
 */
export async function onRequestPost({ request, env }) {
	let form;
	try {
		form = await request.formData();
	} catch {
		return error("Petición inválida.");
	}

	const intent = String(form.get("intent") || "ocupar");
	const fecha = String(form.get("fecha") || "").trim();
	const horaCruda = String(form.get("hora") ?? "").trim();
	const motivo = String(form.get("motivo") || "").trim().slice(0, 200);

	const hora = horaCruda === "" ? null : Number(horaCruda);

	if (!/^\d{4}-\d{2}-\d{2}$/.test(fecha)) return error("Fecha inválida.");
	if (hora !== null && !HORAS.includes(hora)) return error("Esa hora no existe en la agenda.");
	if (!slotValido(fecha, hora)) return error("Ese día no es hábil en la agenda.");

	try {
		if (intent === "liberar") {
			// Liberar el día completo quita también las horas sueltas de ese día:
			// si no, quedarían marcas invisibles que reaparecen después.
			if (hora === null) {
				await env.DB.prepare("DELETE FROM ocupados WHERE fecha = ?1").bind(fecha).run();
			} else {
				await env.DB.prepare(
					"DELETE FROM ocupados WHERE fecha = ?1 AND hora_inicio = ?2",
				)
					.bind(fecha, hora)
					.run();
			}
		} else {
			// Ocupar el día completo reemplaza las horas sueltas por una sola marca
			if (hora === null) {
				await env.DB.prepare("DELETE FROM ocupados WHERE fecha = ?1").bind(fecha).run();
			}

			await env.DB.prepare(
				`INSERT INTO ocupados (fecha, hora_inicio, motivo, created_at)
                 VALUES (?1, ?2, ?3, ?4)
                 ON CONFLICT (fecha, IFNULL(hora_inicio, -1))
                 DO UPDATE SET motivo = excluded.motivo`,
			)
				.bind(fecha, hora, motivo, Date.now())
				.run();
		}
	} catch (e) {
		console.error("[admin/agenda]", e);
		return error("No se pudo guardar el cambio.", 500);
	}

	const agenda = await cargarAgenda(env.DB, { incluirPasadas: true, incluirMotivos: true });
	return json({ ok: true, ...agenda }, 200, { "cache-control": "no-store" });
}
