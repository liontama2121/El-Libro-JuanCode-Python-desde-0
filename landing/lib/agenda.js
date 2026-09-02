/* ==========================================================================
   Reglas de la agenda — TODO se calcula aquí, en el servidor.

   La agenda es manual: Juan marca a mano las horas que tiene ocupadas y el
   resto se muestran libres. Cambiar el horario, los días o hasta cuándo se
   ve la agenda es cambiar una constante de este archivo.
   ========================================================================== */

/** Colombia no tiene horario de verano: siempre UTC-5. */
export const ZONA = "America/Bogota";
export const OFFSET = "-05:00";

/** Horas de inicio de las clases (6:00 p.m. a 10:00 p.m., de 1 hora). */
export const HORAS = [18, 19, 20, 21, 22];

/** Cuántos días hacia adelante se muestra la agenda. */
export const DIAS_ADELANTE = 21;

/** Días de la semana que se atienden (1 = lunes … 5 = viernes). */
export const DIAS_HABILES = [1, 2, 3, 4, 5];

/** Con menos de estas horas por delante, la hora ya no se ofrece como libre. */
export const ANTICIPACION_HORAS = 2;

/* -------------------------------------------------------------------------- */

/** Fecha y hora actuales en Colombia, pase lo que pase con el reloj del server. */
export function ahoraEnColombia(base = new Date()) {
	const partes = new Intl.DateTimeFormat("en-CA", {
		timeZone: ZONA,
		year: "numeric",
		month: "2-digit",
		day: "2-digit",
		hour: "2-digit",
		minute: "2-digit",
		hourCycle: "h23",
	}).formatToParts(base);

	const p = Object.fromEntries(
		partes.filter((x) => x.type !== "literal").map((x) => [x.type, x.value]),
	);

	return {
		fecha: `${p.year}-${p.month}-${p.day}`,
		hora: Number(p.hour),
		minuto: Number(p.minute),
		ms: base.getTime(),
	};
}

/** El instante exacto en que arranca una hora de clase, en milisegundos. */
export function instanteDelSlot(fecha, hora) {
	return Date.parse(`${fecha}T${String(hora).padStart(2, "0")}:00:00${OFFSET}`);
}

/** 0 = domingo … 6 = sábado, leído al mediodía para no cruzar el cambio de día. */
export function diaDeLaSemana(fecha) {
	return new Date(`${fecha}T12:00:00${OFFSET}`).getUTCDay();
}

/** "lun 8 sep" */
export function etiquetaCorta(fecha) {
	return new Intl.DateTimeFormat("es-CO", {
		timeZone: ZONA,
		weekday: "short",
		day: "numeric",
		month: "short",
	}).format(new Date(`${fecha}T12:00:00${OFFSET}`));
}

/** "lunes 8 de septiembre de 2026" */
export function etiquetaLarga(fecha) {
	return new Intl.DateTimeFormat("es-CO", {
		timeZone: ZONA,
		weekday: "long",
		day: "numeric",
		month: "long",
		year: "numeric",
	}).format(new Date(`${fecha}T12:00:00${OFFSET}`));
}

/** 18 → "6:00 p.m." */
export function etiquetaHora(hora) {
	const h12 = hora % 12 === 0 ? 12 : hora % 12;
	return `${h12}:00 ${hora < 12 ? "a.m." : "p.m."}`;
}

/** "6:00 – 7:00 p.m." */
export function etiquetaRango(hora) {
	return `${etiquetaHora(hora)} – ${etiquetaHora(hora + 1)}`;
}

/** "6:00 a 7:00 p.m." — para escribirlo dentro de una frase. */
export function rangoEnFrase(hora) {
	const h12 = (h) => (h % 12 === 0 ? 12 : h % 12);
	return `${h12(hora)}:00 a ${h12(hora + 1)}:00 ${hora < 12 ? "a.m." : "p.m."}`;
}

/** "jueves 3 de septiembre" — sin año ni comas, para meterlo en una frase. */
export function fechaEnFrase(fecha) {
	return new Intl.DateTimeFormat("es-CO", {
		timeZone: ZONA,
		weekday: "long",
		day: "numeric",
		month: "long",
	})
		.format(new Date(`${fecha}T12:00:00${OFFSET}`))
		.replace(",", "");
}

/** Suma días a una fecha YYYY-MM-DD sin salirse de la zona horaria. */
export function sumarDias(fecha, dias) {
	const d = new Date(`${fecha}T12:00:00${OFFSET}`);
	d.setUTCDate(d.getUTCDate() + dias);
	return d.toISOString().slice(0, 10);
}

/** Todas las fechas hábiles de la ventana visible, desde hoy. */
export function fechasDeLaVentana(hoy) {
	const fechas = [];
	for (let i = 0; i < DIAS_ADELANTE; i++) {
		const fecha = sumarDias(hoy, i);
		if (DIAS_HABILES.includes(diaDeLaSemana(fecha))) fechas.push(fecha);
	}
	return fechas;
}

/** ¿Esa hora todavía alcanza a cuadrarse por tiempo? */
export function hayAnticipacion(fecha, hora, ahoraMs) {
	return instanteDelSlot(fecha, hora) - ahoraMs >= ANTICIPACION_HORAS * 3600_000;
}

/** ¿La fecha y la hora son valores que esta agenda acepta? */
export function slotValido(fecha, hora) {
	if (!/^\d{4}-\d{2}-\d{2}$/.test(String(fecha || ""))) return false;
	if (hora !== null && !HORAS.includes(Number(hora))) return false;
	return DIAS_HABILES.includes(diaDeLaSemana(fecha));
}

/**
 * La agenda completa: cada día hábil con sus 5 horas, y cada hora con su
 * estado real.
 *
 * Estados posibles de una hora:
 *   libre    → nadie la ha marcado, y falta tiempo suficiente
 *   ocupado  → Juan la marcó (o marcó el día entero)
 *   pasado   → ya arrancó, o falta menos de la anticipación mínima
 *
 * El motivo de cada hora ocupada es PRIVADO: puede tener el nombre de otro
 * estudiante. Solo sale cuando lo pide el panel, nunca en la agenda pública.
 *
 * @param {D1Database} db
 * @param {{incluirPasadas?: boolean, incluirMotivos?: boolean}} opciones
 */
export async function cargarAgenda(
	db,
	{ incluirPasadas = false, incluirMotivos = false } = {},
) {
	const ahora = ahoraEnColombia();
	const fechas = fechasDeLaVentana(ahora.fecha);
	const hasta = fechas[fechas.length - 1] ?? ahora.fecha;

	const { results } = await db
		.prepare(
			"SELECT fecha, hora_inicio, motivo FROM ocupados WHERE fecha BETWEEN ?1 AND ?2",
		)
		.bind(ahora.fecha, hasta)
		.all();

	const marcadas = new Map();
	const diasCompletos = new Map();

	for (const o of results ?? []) {
		if (o.hora_inicio === null) diasCompletos.set(o.fecha, o.motivo || "");
		else marcadas.set(`${o.fecha}-${o.hora_inicio}`, o.motivo || "");
	}

	const dias = [];

	for (const fecha of fechas) {
		const diaOcupado = diasCompletos.has(fecha);

		const horas = HORAS.map((hora) => {
			const marcada = marcadas.has(`${fecha}-${hora}`);
			const aTiempo = hayAnticipacion(fecha, hora, ahora.ms);

			let estado = "libre";
			if (diaOcupado || marcada) estado = "ocupado";
			else if (!aTiempo) estado = "pasado";

			const motivo = diaOcupado
				? diasCompletos.get(fecha)
				: (marcadas.get(`${fecha}-${hora}`) ?? "");

			return {
				hora,
				etiqueta: etiquetaRango(hora),
				enFrase: rangoEnFrase(hora),
				estado,
				motivo: incluirMotivos ? motivo : "",
			};
		}).filter((h) => incluirPasadas || h.estado !== "pasado");

		if (!horas.length) continue;

		dias.push({
			fecha,
			etiqueta: etiquetaCorta(fecha),
			etiquetaLarga: etiquetaLarga(fecha),
			enFrase: fechaEnFrase(fecha),
			diaCompletoOcupado: diaOcupado,
			libres: horas.filter((h) => h.estado === "libre").length,
			horas,
		});
	}

	return { hoy: ahora.fecha, actualizado: ahora.ms, dias };
}
