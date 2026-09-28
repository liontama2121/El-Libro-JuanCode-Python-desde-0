/* ==========================================================================
   calculadora.js — el wizard "Calcula tu proyecto" de /web. Cero librerías.

   Seis preguntas, una a la vez. Cada opción suma un precio; al final sale
   el resumen, el "desde $X" y un botón que abre WhatsApp con todo escrito.
   El progreso vive en localStorage: si el visitante recarga, sigue donde iba.

   El panel para que el cliente actualice su contenido no se pregunta ni se
   cobra: va incluido en todo proyecto, así no hay que pedirle a Juan cada
   cambio. Sale en el resumen (ver resumen()).

   Vender productos suma un fijo. Si el cliente sube sus productos con el
   panel, no suma más; si Juan los sube a mano, se cobra por producto con un
   tope de 100 (ver extraProductos()).

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
				{ id: "panel", texto: "Sí, y yo subo mis productos con el panel", precio: 500000, incluye: "catálogo, carrito, checkout, pagos (Wompi/PayPal/Nequi)", resumen: "Catálogo con carrito y pagos (Wompi, PayPal, Nequi)" },
				// La línea "Carga de N productos" se arma con la cantidad (ver resumen())
				{ id: "juan", texto: "Sí, y quiero que Juan suba mis productos", precio: 500000, incluye: "lo mismo + yo cargo tus productos, hasta 100", resumen: "Catálogo con carrito y pagos (Wompi, PayPal, Nequi)", cantidad: true },
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

	/* Carga a mano: $500.000 por 100 productos, proporcional (regla de 3),
	   a miles. Tope de 100: lo que pase de ahí lo sube el cliente con el panel.
	   20 → $100.000 · 50 → $250.000 · 100 → $500.000 */
	const PRECIO_POR_100 = 500000;
	const MAX_PRODUCTOS = 100;
	const extraProductos = (n) => Math.round((n * PRECIO_POR_100) / 100 / 1000) * 1000;

	const productosValidos = (n) => Number.isInteger(n) && n >= 1 && n <= MAX_PRODUCTOS;

	const etiquetaPrecio = (p, o) => {
		if (p.id === "tipo") return pesos(o.precio);
		return o.precio ? "+ " + pesos(o.precio) : "+ $0";
	};

	const sinMovimiento = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

	// Opciones marcadas de una pregunta, siempre como arreglo
	const elegidas = (p, resp = estado.resp) => {
		const r = resp[p.id];
		const ids = Array.isArray(r) ? r : r ? [r] : [];
		return p.opciones.filter((o) => ids.includes(o.id));
	};

	// La opción con cantidad (vender productos) exige además el número
	const pideCantidad = (p, resp = estado.resp) => elegidas(p, resp).some((o) => o.cantidad);

	const respondida = (p, resp = estado.resp) =>
		elegidas(p, resp).length > 0 && (!pideCantidad(p, resp) || productosValidos(resp.productos));

	const precioActual = () =>
		PREGUNTAS.reduce(
			(suma, p) =>
				suma +
				elegidas(p).reduce((s, o) => s + o.precio, 0) +
				(pideCantidad(p) && productosValidos(estado.resp.productos) ? extraProductos(estado.resp.productos) : 0),
			0,
		);

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
		if (productosValidos(crudo.resp.productos)) limpio.resp.productos = crudo.resp.productos;

		// No se puede quedar parado más allá de la primera pregunta sin responder
		let paso = Number.isInteger(crudo.paso) ? crudo.paso : 0;
		paso = Math.max(0, Math.min(paso, TOTAL));
		const primeraVacia = PREGUNTAS.findIndex((p) => !respondida(p, limpio.resp));
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
		const venta = PREGUNTAS.find((p) => p.id === "venta");
		const vende = elegidas(venta).some((o) => o.precio > 0);
		const carga = pideCantidad(venta) ? [`Carga de ${estado.resp.productos} productos hecha por Juan`] : [];
		const panel = vende
			? "Panel incluido: tú mismo actualizas productos, pedidos, textos e imágenes"
			: "Panel incluido: tú mismo cambias textos e imágenes";
		// El panel va justo después de lo que se vende, antes de los extras
		const lineas = PREGUNTAS.slice(0, -1).flatMap((p) => {
			const propias = elegidas(p).map((o) => o.resumen).filter(Boolean);
			return p.id === "venta" ? [...propias, ...carga, panel] : propias;
		});
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

	const notaCantidad = (n) => {
		if (n > MAX_PRODUCTOS) return `Subo a mano hasta ${MAX_PRODUCTOS}. El resto lo subes tú con el panel.`;
		if (!productosValidos(n)) return `Escribe un número del 1 al ${MAX_PRODUCTOS}.`;
		return `Carga a mano: + ${pesos(extraProductos(n))} (${pesos(PRECIO_POR_100 / 100)} por producto).`;
	};

	const htmlCantidad = (p) => {
		const n = estado.resp.productos;
		return `
			<div class="calc-cantidad"${pideCantidad(p) ? "" : " hidden"}>
				<label for="calc-productos">¿Cuántos productos subo yo? (máximo ${MAX_PRODUCTOS})</label>
				<input id="calc-productos" type="number" inputmode="numeric" min="1" max="${MAX_PRODUCTOS}" step="1"
					placeholder="Ej: 30" value="${productosValidos(n) ? n : ""}" aria-describedby="calc-productos-nota">
				<p class="calc-cantidad-nota" id="calc-productos-nota" aria-live="polite">${notaCantidad(n)}</p>
			</div>`;
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
				${p.opciones.some((o) => o.cantidad) ? htmlCantidad(p) : ""}
			</fieldset>
			<div class="calc-nav">
				<button type="button" class="btn btn-linea" data-accion="anterior"${i === 0 ? " disabled" : ""}><i class="ph ph-arrow-left" aria-hidden="true"></i> Anterior</button>
				<button type="button" class="btn btn-ladrillo" data-accion="siguiente"${respondida(p) ? "" : " disabled"}>
					${ultima ? "Ver mi precio" : "Siguiente"} <i class="ph ph-arrow-right" aria-hidden="true"></i>
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
					<a class="calc-wa" href="${linkWhatsApp()}" target="_blank" rel="noopener"><i class="ph ph-whatsapp-logo" aria-hidden="true"></i> Enviar por WhatsApp y cotizar</a>
					<button type="button" class="btn btn-linea calc-reset" data-accion="reiniciar"><i class="ph ph-arrows-clockwise" aria-hidden="true"></i> Empezar de nuevo</button>
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
		if (!(input instanceof HTMLInputElement) || input.type === "number" || estado.paso >= TOTAL) return;
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
			for (const el of app.querySelectorAll(".calc-opt input")) el.checked = ids.includes(el.value);
		} else {
			estado.resp[p.id] = input.value;
		}

		for (const el of app.querySelectorAll(".calc-opt input")) {
			el.closest(".calc-opt").classList.toggle("sel", el.checked);
		}

		// Al marcar "Sí, voy a vender" aparece la casilla de cantidad
		const cantidad = app.querySelector(".calc-cantidad");
		if (cantidad) {
			const pide = pideCantidad(p);
			cantidad.hidden = !pide;
			if (pide && !productosValidos(estado.resp.productos)) cantidad.querySelector("input").focus();
		}

		app.querySelector('[data-accion="siguiente"]').disabled = !respondida(p);
		guardar();
		actualizarSticky();
	});

	app.addEventListener("input", (e) => {
		if (e.target.id !== "calc-productos") return;
		const n = Number(e.target.value);
		if (productosValidos(n)) estado.resp.productos = n;
		else delete estado.resp.productos;

		document.getElementById("calc-productos-nota").textContent = notaCantidad(n);
		app.querySelector('[data-accion="siguiente"]').disabled = !respondida(PREGUNTAS[estado.paso]);
		guardar();
		actualizarSticky();
	});

	// Enter en la casilla de cantidad = Siguiente (y no recargar nada)
	app.addEventListener("keydown", (e) => {
		if (e.key !== "Enter" || e.target.id !== "calc-productos") return;
		e.preventDefault();
		app.querySelector('[data-accion="siguiente"]').click();
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
