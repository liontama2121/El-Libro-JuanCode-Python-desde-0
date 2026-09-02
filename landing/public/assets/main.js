/* ==========================================================================
   main.js — cablea la configuración, el año del footer y la animación de
   aparición al hacer scroll. Cero librerías.
   ========================================================================== */

(() => {
	const CONFIG = window.JUANCODE || {};

	// Sigue sin configurar si conserva el valor de ejemplo
	const esPlaceholder = (url) =>
		!url || url.includes("XXXXXXXXXX") || url.includes("TU_CODIGO_AQUI");

	/* --- 1. Enlaces e iframe salen de config.js ---------------------------- */

	const DESTINOS = {
		whatsapp: "WHATSAPP_URL",
		libro: "LIBRO_URL",
		tiktok: "TIKTOK_URL",
		instagram: "INSTAGRAM_URL",
	};

	// Con la landing abierta en el propio computador, el botón del libro
	// apunta al servidor local en vez del dominio de producción.
	const enLocal = ["localhost", "127.0.0.1"].includes(location.hostname);

	for (const el of document.querySelectorAll("[data-jc]")) {
		const clave = DESTINOS[el.dataset.jc];
		const url =
			clave === "LIBRO_URL" && enLocal && CONFIG.LIBRO_URL_LOCAL
				? CONFIG.LIBRO_URL_LOCAL
				: CONFIG[clave];
		if (!url) continue;

		el.href = url;
	}

	/* --- 2. Año del footer ------------------------------------------------- */

	const anio = document.getElementById("anio");
	if (anio) anio.textContent = new Date().getFullYear();

	/* --- 3. Aparición al hacer scroll -------------------------------------- */

	const objetivos = document.querySelectorAll(".reveal");

	// Si el navegador no soporta IntersectionObserver, o el usuario pidió menos
	// movimiento, se muestra todo de una en vez de dejarlo invisible.
	const sinAnimacion =
		!("IntersectionObserver" in window) ||
		window.matchMedia("(prefers-reduced-motion: reduce)").matches;

	if (sinAnimacion) {
		for (const el of objetivos) el.classList.add("in");
		return;
	}

	const obs = new IntersectionObserver(
		(entries) => {
			for (const e of entries) {
				if (e.isIntersecting) {
					e.target.classList.add("in");
					obs.unobserve(e.target);
				}
			}
		},
		{ threshold: 0.12 },
	);

	for (const el of objetivos) obs.observe(el);

	// Red de seguridad: si el observer no llega a dispararse (la pestaña abrió
	// en segundo plano, el usuario saltó con un ancla, un motor viejo), lo que
	// esté a la vista se muestra igual. Nada puede quedarse en opacity 0.
	let pendiente = false;

	const revelarLoVisible = () => {
		pendiente = false;
		let faltan = 0;

		for (const el of objetivos) {
			if (el.classList.contains("in")) continue;
			// Todo lo que ya quedó por encima del borde inferior se muestra,
			// incluso si el usuario saltó con un ancla y nunca pasó por ahí.
			const r = el.getBoundingClientRect();
			if (r.top < window.innerHeight * 0.92) {
				el.classList.add("in");
				obs.unobserve(el);
			} else {
				faltan++;
			}
		}

		if (faltan === 0) window.removeEventListener("scroll", alScrollear);
	};

	// El throttle va con setTimeout y no con requestAnimationFrame: en una
	// pestaña en segundo plano rAF queda congelado, que es justo el caso que
	// esta red de seguridad tiene que cubrir.
	function alScrollear() {
		if (pendiente) return;
		pendiente = true;
		setTimeout(revelarLoVisible, 80);
	}

	window.addEventListener("scroll", alScrollear, { passive: true });
	window.addEventListener("load", revelarLoVisible, { once: true });
	revelarLoVisible();
})();
