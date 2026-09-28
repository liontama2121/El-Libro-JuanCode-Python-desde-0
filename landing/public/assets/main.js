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

	/* --- 3. Aparición al entrar en pantalla ------------------------------- */

	// El contenido es visible por defecto: solo se oculta si la página marcó
	// <html class="js"> (script en el <head>). Sin IntersectionObserver o con
	// movimiento reducido, se muestra todo de una.
	const objetivos = document.querySelectorAll(".reveal");

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
				// Lo que ya quedó arriba (salto con ancla) también se muestra
				if (e.isIntersecting || e.boundingClientRect.top < 0) {
					e.target.classList.add("in");
					obs.unobserve(e.target);
				}
			}
		},
		{ threshold: 0.12 },
	);

	for (const el of objetivos) obs.observe(el);
})();
