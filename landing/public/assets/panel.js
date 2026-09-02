/* ==========================================================================
   Panel privado — Juan marca qué horas tiene ocupadas.

   Una hora tiene tres estados:
     libre    → así la ve la gente en /clases
     ocupado  → él la marcó
     pasado   → ya arrancó, o falta menos de la anticipación mínima

   Todo lo decide el servidor; aquí solo se pinta y se manda el cambio.
   ========================================================================== */

(() => {
	const $ = (s) => document.querySelector(s);

	const escapar = (t) =>
		String(t ?? "").replace(/[&<>"']/g, (c) =>
			({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c],
		);

	/* --- sesión ----------------------------------------------------------- */

	async function haySesion() {
		try {
			const r = await fetch("/api/admin/login");
			return (await r.json()).sesion === true;
		} catch {
			return false;
		}
	}

	function mostrarPanel(entra) {
		$("#login").classList.toggle("oculto", entra);
		$("#panel").classList.toggle("oculto", !entra);
		$("#salir").classList.toggle("oculto", !entra);
	}

	$("#form-login").addEventListener("submit", async (ev) => {
		ev.preventDefault();
		const error = $("#error-login");
		error.classList.add("oculto");

		const datos = new FormData();
		datos.set("password", $("#password").value);

		const r = await fetch("/api/admin/login", { method: "POST", body: datos });
		const res = await r.json();

		if (!res.ok) {
			error.textContent = res.error || "No se pudo entrar.";
			error.classList.remove("oculto");
			return;
		}

		$("#password").value = "";
		mostrarPanel(true);
		cargar();
	});

	$("#salir").addEventListener("click", async (ev) => {
		ev.preventDefault();
		await fetch("/api/admin/login", { method: "DELETE" });
		mostrarPanel(false);
	});

	/* --- pintar la agenda -------------------------------------------------- */

	function pintar(datos) {
		$("#cargando").classList.add("oculto");

		let libres = 0;
		let ocupadas = 0;

		const html = datos.dias
			.map((d) => {
				const horas = d.horas
					.map((h) => {
						if (h.estado === "libre") libres++;
						if (h.estado === "ocupado") ocupadas++;

						const rotulo =
							h.estado === "libre"
								? "✓ Libre"
								: h.estado === "ocupado"
									? "✕ Ocupada"
									: "— ya pasó";

						return `
              <button type="button" class="celda ${h.estado}"
                      data-fecha="${d.fecha}" data-hora="${h.hora}"
                      ${h.estado === "pasado" ? "disabled" : ""}>
                <b>${escapar(h.etiqueta)}</b>
                <span>${rotulo}</span>
                ${h.motivo ? `<em>${escapar(h.motivo)}</em>` : ""}
              </button>`;
					})
					.join("");

				return `
          <section class="dia-panel ${d.diaCompletoOcupado ? "dia-cerrado" : ""}">
            <header>
              <b>${escapar(d.etiqueta)}</b>
              <button type="button" class="btn btn-ghost btn-sm"
                      data-dia="${d.fecha}" data-intent="${d.diaCompletoOcupado ? "liberar" : "ocupar"}">
                ${d.diaCompletoOcupado ? "↩️ Abrir el día" : "🚫 Cerrar el día"}
              </button>
            </header>
            <div class="celdas">${horas}</div>
          </section>`;
			})
			.join("");

		$("#agenda").innerHTML = html || '<p class="aviso">No hay días hábiles por delante.</p>';
		$("#n-libres").textContent = libres;
		$("#n-ocupadas").textContent = ocupadas;
	}

	async function cargar() {
		const r = await fetch("/api/admin/agenda");
		if (r.status === 401) return mostrarPanel(false);

		const datos = await r.json();
		if (datos.ok) pintar(datos);
	}

	/* --- cambiar una hora o un día ---------------------------------------- */

	async function cambiar({ fecha, hora, intent }) {
		const datos = new FormData();
		datos.set("intent", intent);
		datos.set("fecha", fecha);
		datos.set("hora", hora ?? "");
		if (intent === "ocupar") datos.set("motivo", $("#motivo").value.trim());

		const r = await fetch("/api/admin/agenda", { method: "POST", body: datos });
		if (r.status === 401) return mostrarPanel(false);

		const res = await r.json();
		if (!res.ok) return alert(res.error || "No se pudo guardar el cambio.");

		// El motivo se gasta al usarlo: si se quedara escrito, se le pegaría
		// al siguiente clic sin que uno se dé cuenta.
		if (intent === "ocupar") $("#motivo").value = "";

		// La respuesta trae la agenda completa: se repinta con lo que quedó
		// guardado de verdad, no con lo que uno supone que quedó.
		pintar(res);
	}

	$("#agenda").addEventListener("click", (ev) => {
		const celda = ev.target.closest(".celda");
		if (celda && !celda.disabled) {
			return cambiar({
				fecha: celda.dataset.fecha,
				hora: celda.dataset.hora,
				intent: celda.classList.contains("ocupado") ? "liberar" : "ocupar",
			});
		}

		const dia = ev.target.closest("[data-dia]");
		if (dia) {
			return cambiar({ fecha: dia.dataset.dia, hora: null, intent: dia.dataset.intent });
		}
	});

	$("#recargar").addEventListener("click", cargar);

	// Si el panel quedó abierto en el celular y en el computador, al volver a
	// mirarlo se refresca solo: dos pantallas no pueden mostrar cosas distintas.
	document.addEventListener("visibilitychange", () => {
		if (!document.hidden && !$("#panel").classList.contains("oculto")) cargar();
	});

	/* --- arranque --------------------------------------------------------- */

	haySesion().then((entra) => {
		mostrarPanel(entra);
		if (entra) cargar();
		else $("#password").focus();
	});
})();
