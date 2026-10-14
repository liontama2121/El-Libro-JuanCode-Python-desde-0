/* ==========================================================================
   cv.js — la ficha de /cv: copiar el correo y marcar en el índice el
   capítulo que se está leyendo. Cero librerías.
   ========================================================================== */

(() => {
	const aviso = document.getElementById("aviso");

	/* --- 1. Copiar correo -------------------------------------------------- */

	for (const boton of document.querySelectorAll("[data-copiar]")) {
		const etiqueta = boton.querySelector("span");
		let espera;
		boton.addEventListener("click", async () => {
			try {
				await navigator.clipboard.writeText(boton.dataset.copiar);
				boton.classList.add("listo");
				etiqueta.textContent = "Copiado";
				if (aviso) aviso.textContent = "Correo copiado";
			} catch {
				// Sin permiso de portapapeles: se abre el correo directamente
				location.href = `mailto:${boton.dataset.copiar}`;
				return;
			}
			clearTimeout(espera);
			espera = setTimeout(() => {
				boton.classList.remove("listo");
				etiqueta.textContent = "Copiar";
			}, 2200);
		});
	}

	const sinMovimiento = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

	/* --- 2. Chips: índice para la cascada --------------------------------- */

	for (const lista of document.querySelectorAll(".celda")) {
		lista.querySelectorAll(".chips li").forEach((li, i) => li.style.setProperty("--c", i));
	}

	if (!sinMovimiento) {
		decodificarNombre();
		contarAdopcion();
		redDeFondo();
		luzYInclinacion();
		titulosQueSeDescifran();
		largoDelPulso();
	}

	/* --- Paneles: luz bajo el cursor y leve inclinación 3D ------------------ */

	function luzYInclinacion() {
		const fino = window.matchMedia("(hover: hover) and (pointer: fine)").matches;
		if (!fino) return;
		for (const panel of document.querySelectorAll(".celda, .pieza, .diploma")) {
			panel.addEventListener("pointermove", (e) => {
				const r = panel.getBoundingClientRect();
				const x = (e.clientX - r.left) / r.width;
				const y = (e.clientY - r.top) / r.height;
				panel.style.setProperty("--mx", `${x * 100}%`);
				panel.style.setProperty("--my", `${y * 100}%`);
				panel.style.setProperty("--rx", `${(0.5 - y) * 4}deg`);
				panel.style.setProperty("--ry", `${(x - 0.5) * 5}deg`);
			});
			panel.addEventListener("pointerleave", () => {
				panel.style.setProperty("--rx", "0deg");
				panel.style.setProperty("--ry", "0deg");
			});
		}
	}

	/* --- Títulos de capítulo: se descifran al entrar en pantalla ----------- */

	function descifrar(el, dur) {
		const final = el.textContent;
		const signos = "<>/{}[]=+*#01ABCDEFXYZ";
		el.setAttribute("aria-label", final);
		const inicio = performance.now();
		const paso = (ahora) => {
			const k = Math.min(1, (ahora - inicio) / dur);
			const fijos = Math.floor(k * final.length);
			let s = "";
			for (let i = 0; i < final.length; i++) {
				const ch = final[i];
				s += i < fijos || ch === " " ? ch : signos[(Math.random() * signos.length) | 0];
			}
			el.textContent = k < 1 ? s : final;
			if (k < 1) requestAnimationFrame(paso);
		};
		requestAnimationFrame(paso);
	}

	function titulosQueSeDescifran() {
		if (!("IntersectionObserver" in window)) return;
		const titulos = document.querySelectorAll(".cap-cabeza h2, #habilidades h2, .diploma h2");
		const obs = new IntersectionObserver((entradas) => {
			for (const e of entradas) {
				if (!e.isIntersecting) continue;
				obs.unobserve(e.target);
				descifrar(e.target, 750);
			}
		}, { threshold: 0.8 });
		for (const t of titulos) obs.observe(t);
	}

	/* --- Línea de tiempo: el pulso recorre todo su largo ------------------- */

	function largoDelPulso() {
		const antes = document.querySelector(".antes");
		if (!antes) return;
		const fijar = () => antes.style.setProperty("--largo", `${antes.offsetHeight - 60}px`);
		fijar();
		window.addEventListener("resize", fijar);
	}

	/* --- 3. Nombre: se decodifica como una lectura del visor --------------- */

	function decodificarNombre() {
		const h1 = document.querySelector(".cv-hero h1");
		if (h1) descifrar(h1, 1100);
	}

	/* --- 4. 95 %: cuenta desde cero cuando entra en pantalla -------------- */

	function contarAdopcion() {
		const cifra = document.querySelector(".adopcion-cifra");
		if (!cifra || !("IntersectionObserver" in window)) return;
		const nodo = cifra.firstChild;
		const meta = parseInt(nodo.textContent, 10);
		nodo.textContent = "0";
		const obs = new IntersectionObserver((entradas) => {
			if (!entradas.some((e) => e.isIntersecting)) return;
			obs.disconnect();
			const inicio = performance.now();
			const dur = 1400;
			const paso = (ahora) => {
				const k = Math.min(1, (ahora - inicio) / dur);
				nodo.textContent = String(Math.round(meta * (1 - Math.pow(2, -10 * k))));
				if (k < 1) requestAnimationFrame(paso);
				else {
					nodo.textContent = String(meta);
					cifra.classList.add("contado");
				}
			};
			requestAnimationFrame(paso);
		}, { threshold: 0.6 });
		obs.observe(cifra);
	}

	/* --- 5. Fondo: paquetes de datos viajando por la retícula -------------- */

	// Misma retícula de 64px que pinta hud.css; los paquetes corren sobre sus
	// líneas, giran en los cruces y dejan una estela. Al llegar a un cruce,
	// a veces el nodo destella. Se detiene con la pestaña oculta.
	function redDeFondo() {
		const canvas = document.createElement("canvas");
		canvas.className = "red-fondo";
		canvas.setAttribute("aria-hidden", "true");
		document.body.prepend(canvas);
		const ctx = canvas.getContext("2d");
		const PASO = 64;
		const CIAN = "0,229,255";
		const MAGENTA = "255,43,214";
		let w = 0, h = 0, raf = 0, previo = 0;
		const paquetes = [];
		const destellos = [];

		const medir = () => {
			const dpr = Math.min(window.devicePixelRatio || 1, 1.5);
			w = window.innerWidth;
			h = window.innerHeight;
			canvas.width = Math.round(w * dpr);
			canvas.height = Math.round(h * dpr);
			ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
		};

		const DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]];
		const nuevo = () => {
			const d = DIRS[(Math.random() * 4) | 0];
			return {
				x: Math.round((Math.random() * w) / PASO) * PASO,
				y: Math.round((Math.random() * h) / PASO) * PASO,
				dx: d[0], dy: d[1],
				v: 70 + Math.random() * 90,
				color: Math.random() < 0.22 ? MAGENTA : CIAN,
				estela: [],
				avance: 0,
			};
		};

		const cuadro = (ahora) => {
			const dt = Math.min(0.05, (ahora - (previo || ahora)) / 1000);
			previo = ahora;
			ctx.clearRect(0, 0, w, h);
			const meta = Math.max(8, Math.min(22, Math.round((w * h) / 70000)));
			while (paquetes.length < meta) paquetes.push(nuevo());

			for (let i = paquetes.length - 1; i >= 0; i--) {
				const p = paquetes[i];
				const d = p.v * dt;
				p.x += p.dx * d;
				p.y += p.dy * d;
				p.avance += d;
				p.estela.unshift([p.x, p.y]);
				if (p.estela.length > 26) p.estela.pop();
				// En cada cruce: seguir, girar o destellar
				if (p.avance >= PASO) {
					p.avance -= PASO;
					p.x = Math.round(p.x / PASO) * PASO;
					p.y = Math.round(p.y / PASO) * PASO;
					const r = Math.random();
					if (r < 0.28) [p.dx, p.dy] = [p.dy, -p.dx];
					else if (r < 0.5) [p.dx, p.dy] = [-p.dy, p.dx];
					if (Math.random() < 0.08) destellos.push({ x: p.x, y: p.y, t: 0, color: p.color });
				}
				if (p.x < -PASO * 2 || p.x > w + PASO * 2 || p.y < -PASO * 2 || p.y > h + PASO * 2) {
					paquetes.splice(i, 1);
					continue;
				}
				// Estela
				for (let j = 1; j < p.estela.length; j++) {
					const a = (1 - j / p.estela.length) * 0.45;
					ctx.strokeStyle = `rgba(${p.color},${a})`;
					ctx.lineWidth = 1.5;
					ctx.beginPath();
					ctx.moveTo(p.estela[j - 1][0], p.estela[j - 1][1]);
					ctx.lineTo(p.estela[j][0], p.estela[j][1]);
					ctx.stroke();
				}
				ctx.fillStyle = `rgba(${p.color},0.95)`;
				ctx.shadowColor = `rgba(${p.color},0.9)`;
				ctx.shadowBlur = 10;
				ctx.fillRect(p.x - 2, p.y - 2, 4, 4);
				ctx.shadowBlur = 0;
			}

			// Destellos: una mira que se abre en el cruce y se apaga
			for (let i = destellos.length - 1; i >= 0; i--) {
				const f = destellos[i];
				f.t += dt;
				const k = f.t / 0.9;
				if (k >= 1) { destellos.splice(i, 1); continue; }
				const r = 4 + k * 14;
				const l = 5;
				ctx.strokeStyle = `rgba(${f.color},${0.7 * (1 - k)})`;
				ctx.lineWidth = 1;
				ctx.beginPath();
				for (const [sx, sy] of [[-1, -1], [1, -1], [1, 1], [-1, 1]]) {
					ctx.moveTo(f.x + sx * r, f.y + sy * (r - l));
					ctx.lineTo(f.x + sx * r, f.y + sy * r);
					ctx.lineTo(f.x + sx * (r - l), f.y + sy * r);
				}
				ctx.stroke();
			}
			raf = requestAnimationFrame(cuadro);
		};

		medir();
		window.addEventListener("resize", medir);
		document.addEventListener("visibilitychange", () => {
			cancelAnimationFrame(raf);
			previo = 0;
			if (!document.hidden) raf = requestAnimationFrame(cuadro);
		});
		raf = requestAnimationFrame(cuadro);
	}

	/* --- 6. Índice: capítulo activo --------------------------------------- */

	const enlaces = [...document.querySelectorAll(".indice a")];
	if (!enlaces.length || !("IntersectionObserver" in window)) return;

	const porId = new Map(enlaces.map((a) => [a.hash.slice(1), a]));
	const secciones = [...porId.keys()].map((id) => document.getElementById(id)).filter(Boolean);

	const marcar = (id) => {
		for (const a of enlaces) a.toggleAttribute("aria-current", false);
		porId.get(id)?.setAttribute("aria-current", "true");
	};

	// Activo = la última sección cuyo inicio ya cruzó la franja superior
	const visibles = new Set();
	const obs = new IntersectionObserver(
		(entradas) => {
			for (const e of entradas) e.isIntersecting ? visibles.add(e.target) : visibles.delete(e.target);
			const actual = secciones.filter((s) => visibles.has(s)).at(0);
			if (actual) marcar(actual.id);
		},
		{ rootMargin: "-20% 0px -65% 0px" },
	);
	for (const s of secciones) obs.observe(s);
})();
