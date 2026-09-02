/* ==========================================================================
   Agenda pública — muestra en vivo qué horas tiene Juan libres.

   Toca una hora libre y se abre WhatsApp con el mensaje ya escrito. No hay
   formulario ni pagos: el cupo se cuadra por chat.
   ========================================================================== */

(() => {
	const CONFIG = window.JUANCODE || {};
	const contenedor = document.querySelector("#agenda-viva");
	if (!contenedor) return;

	const estado = document.querySelector("#agenda-estado");
	const REFRESCO_MS = 60_000;

	const escapar = (t) =>
		String(t ?? "").replace(/[&<>"']/g, (c) =>
			({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c],
		);

	function linkWhatsApp(dia, hora) {
		const base = CONFIG.WHATSAPP_URL || "";
		const texto = `¡Hola Juan! Vi en tu agenda que tienes libre el ${dia.enFrase} de ${hora.enFrase}. ¿Lo cuadramos? 🐍`;
		return `${base}?text=${encodeURIComponent(texto)}`;
	}

	function pintar(datos) {
		const dias = datos.dias.filter((d) => d.horas.length);

		if (!dias.length) {
			contenedor.innerHTML =
				'<p class="agenda-vacia">No hay horas libres en las próximas semanas. Escríbeme y miramos cómo cuadramos.</p>';
			return;
		}

		contenedor.innerHTML = dias
			.map((d) => {
				const horas = d.horas
					.map((h) =>
						h.estado === "libre"
							? `<a class="hueco libre" href="${linkWhatsApp(d, h)}" target="_blank" rel="noopener">
                   <b>${escapar(h.etiqueta)}</b><span>✓ Libre</span>
                 </a>`
							: `<span class="hueco ocupado" aria-label="Ocupado">
                   <b>${escapar(h.etiqueta)}</b><span>Ocupado</span>
                 </span>`,
					)
					.join("");

				return `
          <div class="dia-agenda${d.libres === 0 ? " sin-cupo" : ""}">
            <div class="dia-cabeza">
              <b>${escapar(d.etiqueta)}</b>
              <span>${d.libres === 0 ? "sin cupos" : `${d.libres} ${d.libres === 1 ? "hora libre" : "horas libres"}`}</span>
            </div>
            <div class="huecos">${horas}</div>
          </div>`;
			})
			.join("");

		if (estado) {
			const total = dias.reduce((n, d) => n + d.libres, 0);
			estado.textContent = total
				? `● ${total} ${total === 1 ? "hora libre" : "horas libres"} en las próximas 3 semanas`
				: "● Agenda llena por ahora";
			estado.classList.toggle("sin-cupos", total === 0);
		}
	}

	async function cargar() {
		try {
			const r = await fetch("/api/disponibilidad", { headers: { accept: "application/json" } });
			const datos = await r.json();
			if (datos.ok) pintar(datos);
		} catch {
			contenedor.innerHTML =
				'<p class="agenda-vacia">No se pudo cargar la agenda. Escríbeme por WhatsApp y la miramos.</p>';
		}
	}

	cargar();

	// En vivo: se refresca sola cada minuto, y de una al volver a la pestaña.
	// Así, si Juan marca una hora desde el celular, quien esté mirando la
	// página no le escribe por una hora que ya no existe.
	setInterval(() => {
		if (!document.hidden) cargar();
	}, REFRESCO_MS);

	document.addEventListener("visibilitychange", () => {
		if (!document.hidden) cargar();
	});
})();
