/* ==========================================================================
   calculadora.js — el wizard "Calcula tu proyecto" de /web. Cero librerías.

   Siete preguntas, una a la vez. Cada opción suma un precio; al final sale
   el resumen, el "desde $X" y un botón que abre WhatsApp con todo escrito.
   El progreso vive en localStorage: si el visitante recarga, sigue donde iba.

   Cambiar un precio o un texto es cambiar PREGUNTAS, nada más.
   ========================================================================== */

(() => {
	const app = document.getElementById("calc-app");
	if (!app) return;

	const WHATSAPP = "https://wa.me/573160996970";
	const CLAVE = "jc-calculadora-v1";

	/* --- 1. Las preguntas ---------------------------------------------------
	   · precio   → lo que suma la opción, en COP
	   · incluye  → la línea chica bajo la opción
	   · resumen  → cómo se nombra en el resultado (null = no se lista)
	   · intro    → solo la pregunta 1: "Estás construyendo <intro> con:"
	   · entrega  → solo la pregunta 7: lo que sale en "Entrega estimada"
	   · exclusivo → en la pregunta de checkboxes, desmarca las demás        */

	const PREGUNTAS = [
		{
			id: "tipo",
			titulo: "¿Qué tipo de proyecto necesitas?",
			opciones: [
				{ id: "una", texto: "Solo presentar mi negocio (una vista)", precio: 1000000, intro: "una página para presentar tu negocio", resumen: "Una vista con tu marca y botón de WhatsApp" },
				{ id: "varias", texto: "Presentar mi negocio con varias secciones", precio: 1500000, intro: "un sitio para presentar tu negocio", resumen: "Varias secciones: inicio, servicios, nosotros y contacto" },
				{ id: "tienda", texto: "Vender productos por internet", precio: 2500000, intro: "una tienda online", resumen: "Tienda diseñada a la medida de tu marca" },
				{ id: "plataforma", texto: "Plataforma completa a medida", precio: 3000000, intro: "una plataforma a la medida", resumen: "Funciones hechas para cómo trabaja tu negocio" },
			],
		},
		{
			id: "venta",
			titulo: "¿Vas a vender productos?",
			opciones: [
				{ id: "no", texto: "No, solo información y contacto", precio: 0, resumen: null },
				{ id: "pocos", texto: "Sí, pocos productos (menos de 20)", precio: 500000, incluye: "catálogo, carrito, checkout, pagos (Wompi/PayPal/Nequi)", resumen: "Catálogo hasta 20 productos con carrito y pagos (Wompi, PayPal, Nequi)" },
				{ id: "muchos", texto: "Sí, catálogo grande (más de 20 productos)", precio: 1000000, incluye: "gestión de categorías, filtros, búsqueda, inventario", resumen: "Catálogo grande con categorías, filtros, búsqueda e inventario" },
			],
		},
		{
			id: "panel",
			titulo: "¿Quieres poder actualizar el contenido tú mismo?",
			opciones: [
				{ id: "no", texto: "No, tú me avisas y yo hago los cambios", precio: 0, resumen: null },
				{ id: "textos", texto: "Sí, quiero editar textos e imágenes", precio: 400000, incluye: "panel privado con login, editor visual", resumen: "Panel donde tú mismo cambias textos e imágenes" },
				{ id: "gestion", texto: "Sí, quiero gestionar productos, pedidos y clientes", precio: 800000, incluye: "dashboard completo, gestión de inventario, estadísticas de ventas", resumen: "Panel donde tú gestionas productos, pedidos y clientes" },
			],
		},
		{
			id: "blog",
			titulo: "¿Vas a publicar artículos o contenido regularmente?",
			opciones: [
				{ id: "no", texto: "No", precio: 0, resumen: null },
				{ id: "si", texto: "Sí, quiero un blog con categorías", precio: 400000, incluye: "editor de artículos, categorías, comentarios opcionales", resumen: "Blog con categorías para publicar contenido" },
			],
		},
		{
			id: "cuentas",
			titulo: "¿Los clientes deben crear cuenta?",
			opciones: [
				{ id: "no", texto: "No, cualquiera puede comprar como invitado", precio: 0, resumen: null },
				{ id: "historial", texto: "Sí, cuentas con historial de pedidos", precio: 600000, resumen: "Cuentas de cliente con historial de pedidos" },
				{ id: "roles", texto: "Sí, con roles diferentes (admin, cliente, vendedor)", precio: 1000000, resumen: "Cuentas con roles: admin, cliente y vendedor" },
			],
		},
		{
			id: "extras",
			titulo: "¿Necesitas algo especial?",
			ayuda: "Elige todas las que apliquen.",
			multiple: true,
			opciones: [
				{ id: "chatbot", texto: "Chatbot con IA que responde con tus documentos", precio: 2000000, resumen: "Chatbot con IA que responde con tus documentos" },
				{ id: "buscador", texto: "Buscador inteligente en tu sitio", precio: 1000000, resumen: "Buscador inteligente en tu sitio" },
				{ id: "reservas", texto: "Reservas o citas online", precio: 800000, resumen: "Reservas o citas online" },
				{ id: "whatsapp", texto: "Notificaciones automáticas por WhatsApp", precio: 500000, resumen: "Notificaciones automáticas por WhatsApp" },
				{ id: "idiomas", texto: "Multi-idioma", precio: 600000, resumen: "Sitio en varios idiomas" },
				{ id: "crm", texto: "Conexión con tu contabilidad o CRM", precio: 1500000, resumen: "Conexión con tu contabilidad o CRM" },
				{ id: "ninguno", texto: "Nada de esto por ahora", precio: 0, resumen: null, exclusivo: true },
			],
		},
		{
			id: "tiempo",
			titulo: "¿Cuándo lo necesitas?",
			opciones: [
				{ id: "normal", texto: "Sin apuros, en 4-6 semanas", precio: 0, entrega: "4-6 semanas" },
				{ id: "rapido", texto: "En 2-3 semanas", precio: 500000, entrega: "2-3 semanas" },
				{ id: "urgente", texto: "Urgente, en menos de 2 semanas", precio: 1000000, entrega: "menos de 2 semanas" },
			],
		},
	];

	const TOTAL = PREGUNTAS.length;
	// Desde qué pregunta (índice) aparece el precio flotante: la 3
	const PASO_STICKY = 2;

	/* --- 2. Utilidades ----------------------------------------------------- */

	// 2500000 → "$2.500.000". A mano y no con toLocaleString: así sale igual
	// en cualquier navegador, tenga o no los datos del locale es-CO.
	const pesos = (n) => "$" + String(Math.round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, ".");

	const etiquetaPrecio = (p, o) => {
		if (p.id === "tipo") return pesos(o.precio);
		return o.precio ? "+ " + pesos(o.precio) : "+ $0";
	};

	const sinMovimiento = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

	// Opciones marcadas de una pregunta, siempre como arreglo
	const elegidas = (p) => {
		const r = estado.resp[p.id];
		const ids = Array.isArray(r) ? r : r ? [r] : [];
		return p.opciones.filter((o) => ids.includes(o.id));
	};

	const respondida = (p) => elegidas(p).length > 0;

	const precioActual = () =>
		PREGUNTAS.reduce((suma, p) => suma + elegidas(p).reduce((s, o) => s + o.precio, 0), 0);

	/* --- 3. Estado + localStorage ------------------------------------------ */

	// Lo guardado se limpia contra PREGUNTAS: si mañana cambia una opción,
	// un id viejo no rompe nada, solo se descarta.
	const sanear = (crudo) => {
		const limpio = { paso: 0, resp: {} };
		if (!crudo || typeof crudo !== "object" || !crudo.resp) return limpio;

		for (const p of PREGUNTAS) {
			const ids = new Set(p.opciones.map((o) => o.id));
			const r = crudo.resp[p.id];
			if (p.multiple && Array.isArray(r)) {
				const validos = r.filter((id) => ids.has(id));
				if (validos.length) limpio.resp[p.id] = validos;
			} else if (typeof r === "string" && ids.has(r)) {
				limpio.resp[p.id] = r;
			}
		}

		// No se puede quedar parado más allá de la primera pregunta sin responder
		let paso = Number.isInteger(crudo.paso) ? crudo.paso : 0;
		paso = Math.max(0, Math.min(paso, TOTAL));
		const primeraVacia = PREGUNTAS.findIndex((p) => !limpio.resp[p.id]);
		if (primeraVacia !== -1) paso = Math.min(paso, primeraVacia);
		limpio.paso = paso;
		return limpio;
	};

	const cargar = () => {
		try {
			return sanear(JSON.parse(localStorage.getItem(CLAVE)));
		} catch {
			return sanear(null);
		}
	};

	const guardar = () => {
		try {
			localStorage.setItem(CLAVE, JSON.stringify(estado));
		} catch {
			// Navegación privada o almacenamiento bloqueado: la calculadora
			// funciona igual, solo que no recuerda el progreso.
		}
	};

	let estado = cargar();

	/* --- 4. Resumen y mensaje de WhatsApp ---------------------------------- */

	const resumen = () => {
		const tipo = elegidas(PREGUNTAS[0])[0];
		const lineas = PREGUNTAS.slice(0, -1)
			.flatMap((p) => elegidas(p))
			.map((o) => o.resumen)
			.filter(Boolean);
		const tiempo = elegidas(PREGUNTAS[TOTAL - 1])[0];
		return { intro: tipo ? tipo.intro : "tu proyecto", lineas, tiempo };
	};

	const linkWhatsApp = () => {
		const { intro, lineas, tiempo } = resumen();
		const texto = [
			"Hola Juan 👋 Hice la calculadora en tu landing y me interesa cotizar. Mi proyecto:",
			"",
			`${intro.charAt(0).toUpperCase() + intro.slice(1)} con:`,
			...lineas.map((l) => `✓ ${l}`),
			"",
			`Precio estimado: ${pesos(precioActual())} COP`,
			`Timing: ${tiempo ? tiempo.texto : "por definir"}`,
			"",
			"¿Cuándo podemos hablar?",
		].join("\n");
		return `${WHATSAPP}?text=${encodeURIComponent(texto)}`;
	};

	/* --- 5. Pintar --------------------------------------------------------- */

	const anuncio = document.getElementById("calc-anuncio");
	const anunciar = (txt) => {
		if (anuncio) anuncio.textContent = txt;
	};

	const htmlOpcion = (p, o, sel) => {
		const tipo = p.multiple ? "checkbox" : "radio";
		return `
			<label class="calc-opt${p.multiple ? " check" : ""}${sel ? " sel" : ""}">
				<input type="${tipo}" name="calc-${p.id}" value="${o.id}"${sel ? " checked" : ""}>
				<span class="calc-marca" aria-hidden="true"></span>
				<span class="calc-txt">
					<strong>${o.texto}</strong>
					${o.incluye ? `<small>Incluye: ${o.incluye}</small>` : ""}
				</span>
				<span class="calc-precio-op">${etiquetaPrecio(p, o)}</span>
			</label>`;
	};

	const htmlPregunta = (i) => {
		const p = PREGUNTAS[i];
		const ids = elegidas(p).map((o) => o.id);
		const ultima = i === TOTAL - 1;
		return `
			<div class="calc-top">
				<span class="calc-paso">Pregunta ${i + 1} de ${TOTAL}</span>
				<div class="calc-barra" role="progressbar" aria-label="Progreso de la calculadora"
					aria-valuemin="1" aria-valuemax="${TOTAL}" aria-valuenow="${i + 1}">
					<span style="width:${((i + 1) / TOTAL) * 100}%"></span>
				</div>
			</div>
			<fieldset class="calc-card">
				<legend class="calc-q" tabindex="-1">${p.titulo}</legend>
				${p.ayuda ? `<p class="calc-ayuda">${p.ayuda}</p>` : ""}
				<div class="calc-opts">
					${p.opciones.map((o) => htmlOpcion(p, o, ids.includes(o.id))).join("")}
				</div>
			</fieldset>
			<div class="calc-nav">
				<button type="button" class="btn btn-ghost" data-accion="anterior"${i === 0 ? " disabled" : ""}>◀ Anterior</button>
				<button type="button" class="btn btn-grad" data-accion="siguiente"${respondida(p) ? "" : " disabled"}>
					${ultima ? "Ver mi precio ▶" : "Siguiente ▶"}
				</button>
			</div>`;
	};

	const htmlResultado = () => {
		const { intro, lineas, tiempo } = resumen();
		const total = precioActual();
		return `
			<div class="calc-resultado" tabindex="-1" aria-labelledby="calc-res-tag">
				<p class="calc-res-tag" id="calc-res-tag">📋 TU PROYECTO</p>
				<p class="calc-res-intro">Estás construyendo ${intro} con:</p>
				<ul class="calc-res-lista">
					${lineas.map((l) => `<li>${l}</li>`).join("")}
				</ul>
				<div class="calc-res-precio">
					<span>Desde</span>
					<b id="calc-total" aria-hidden="true">${pesos(total)}</b><i aria-hidden="true">COP</i>
					<span class="calc-sr">Desde ${pesos(total)} pesos colombianos</span>
					<p class="calc-res-nota">Es un estimado: el precio exacto sale en la propuesta, después de hablar 15 minutos.</p>
				</div>
				<ul class="calc-beneficios">
					<li>6 meses de mantenimiento GRATIS incluidos</li>
					<li>Entrega estimada: ${tiempo ? tiempo.entrega : "por definir"}</li>
					<li>50% al arrancar / 50% al entregar</li>
					<li>El código es tuyo desde el día uno</li>
				</ul>
				<div class="calc-acciones">
					<a class="calc-wa" href="${linkWhatsApp()}" target="_blank" rel="noopener">💬 Enviar por WhatsApp y cotizar</a>
					<button type="button" class="btn btn-ghost calc-reset" data-accion="reiniciar">🔄 Empezar de nuevo</button>
				</div>
			</div>`;
	};

	// El precio final sube de 0 al total en ~1.2 s
	const contar = (el, total) => {
		if (sinMovimiento) return;
		const dur = 1200;
		const t0 = performance.now();
		const tick = (t) => {
			const x = Math.min(1, (t - t0) / dur);
			const suave = 1 - Math.pow(1 - x, 3);
			// Se redondea a miles para que no titilen los últimos dígitos
			el.textContent = pesos(x < 1 ? Math.round((total * suave) / 1000) * 1000 : total);
			if (x < 1) requestAnimationFrame(tick);
		};
		el.textContent = pesos(0);
		requestAnimationFrame(tick);
		// Con la pestaña en segundo plano rAF queda congelado: el total nunca
		// se puede quedar en $0.
		setTimeout(() => {
			el.textContent = pesos(total);
		}, dur + 150);
	};

	/* direccion: "adelante" | "atras" | null (primera carga, sin animación
	   ni robo de foco) */
	const pintar = (direccion) => {
		const enResultado = estado.paso >= TOTAL;
		app.innerHTML = enResultado ? htmlResultado() : htmlPregunta(estado.paso);

		if (direccion && !sinMovimiento) {
			app.classList.remove("calc-entra-adelante", "calc-entra-atras");
			void app.offsetWidth; // reinicia la animación
			app.classList.add(`calc-entra-${direccion}`);
		}

		actualizarSticky();
		if (!direccion) return;

		if (enResultado) {
			const res = app.querySelector(".calc-resultado");
			contar(document.getElementById("calc-total"), precioActual());
			res.scrollIntoView({ behavior: sinMovimiento ? "auto" : "smooth", block: "start" });
			res.focus({ preventScroll: true });
			anunciar(`Listo. Tu proyecto sale desde ${pesos(precioActual())} pesos.`);
		} else {
			app.querySelector(".calc-q").focus({ preventScroll: true });
			anunciar(`Pregunta ${estado.paso + 1} de ${TOTAL}: ${PREGUNTAS[estado.paso].titulo}`);
			// Si la tarjeta quedó por encima de la pantalla (celular), se sube
			const top = app.getBoundingClientRect().top;
			if (top < 0) app.scrollIntoView({ behavior: sinMovimiento ? "auto" : "smooth", block: "start" });
		}
	};

	/* --- 6. Precio flotante ------------------------------------------------ */

	const sticky = document.getElementById("calc-sticky");
	const seccion = document.getElementById("calculadora");
	let seccionVisible = false;

	function actualizarSticky() {
		if (!sticky) return;
		const mostrar = seccionVisible && estado.paso >= PASO_STICKY && estado.paso < TOTAL;
		sticky.hidden = !mostrar;
		sticky.querySelector("b").textContent = pesos(precioActual());
	}

	if (sticky && seccion && "IntersectionObserver" in window) {
		new IntersectionObserver(
			([e]) => {
				seccionVisible = e.isIntersecting;
				actualizarSticky();
			},
			{ threshold: 0.15 },
		).observe(seccion);
	}

	/* --- 7. Eventos -------------------------------------------------------- */

	app.addEventListener("change", (e) => {
		const input = e.target;
		if (!(input instanceof HTMLInputElement) || estado.paso >= TOTAL) return;
		const p = PREGUNTAS[estado.paso];

		if (p.multiple) {
			const opcion = p.opciones.find((o) => o.id === input.value);
			let ids = elegidas(p).map((o) => o.id);
			if (input.checked) {
				// "Nada de esto" apaga las demás, y cualquier otra apaga "Nada de esto"
				ids = opcion.exclusivo
					? [opcion.id]
					: ids.filter((id) => !p.opciones.find((o) => o.id === id).exclusivo).concat(opcion.id);
			} else {
				ids = ids.filter((id) => id !== opcion.id);
			}
			estado.resp[p.id] = ids;
			for (const el of app.querySelectorAll("input")) el.checked = ids.includes(el.value);
		} else {
			estado.resp[p.id] = input.value;
		}

		for (const el of app.querySelectorAll("input")) {
			el.closest(".calc-opt").classList.toggle("sel", el.checked);
		}
		app.querySelector('[data-accion="siguiente"]').disabled = !respondida(p);
		guardar();
		actualizarSticky();
	});

	app.addEventListener("click", (e) => {
		const boton = e.target.closest("[data-accion]");
		if (!boton || boton.disabled) return;

		switch (boton.dataset.accion) {
			case "siguiente":
				if (!respondida(PREGUNTAS[estado.paso])) return;
				estado.paso++;
				guardar();
				pintar("adelante");
				break;
			case "anterior":
				if (estado.paso === 0) return;
				estado.paso--;
				guardar();
				pintar("atras");
				break;
			case "reiniciar":
				estado = { paso: 0, resp: {} };
				guardar();
				pintar("atras");
				seccion.scrollIntoView({ behavior: sinMovimiento ? "auto" : "smooth", block: "start" });
				break;
		}
	});

	// Primera carga: retoma donde iba (o la pregunta 1) sin animar ni mover foco
	pintar(null);
})();
