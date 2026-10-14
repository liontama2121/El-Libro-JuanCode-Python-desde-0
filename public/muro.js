/* ==========================================================================
   muro.js — escenas holográficas de JuanCode, dibujadas en <canvas>.

   <canvas class="muro" data-muro></canvas>          código → página web
   <canvas class="muro" data-muro="python"></canvas> la película en vivo
   <canvas class="muro" data-muro="agentes"></canvas> RAG con supervisor (/cv)
   <canvas class="muro" data-muro="piso"></canvas>   retícula de piso en fuga

   Web: un editor escribe la página línea por línea y, al terminar cada
   línea, su bloque se traza en el wireframe del navegador.
   Python: el código se ejecuta paso a paso y el panel de variables se
   actualiza como en El Libro. Ambas escenas se repiten mientras están en
   pantalla; con movimiento reducido se dibuja el estado final, quieto.
   ========================================================================== */

(() => {
	const sinMovimiento = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
	const CIAN = "0,229,255";
	const MAGENTA = "255,43,214";
	const TINTA = "228,244,248";
	const GRIS = "142,163,179";
	const MONO = '"JetBrains Mono", ui-monospace, monospace';

	const c = (rgb, a = 1) => `rgba(${rgb},${a})`;
	const tramo = (t, ini, dur) => Math.max(0, Math.min(1, (t - ini) / dur));
	const suave = (x) => (x >= 1 ? 1 : 1 - Math.pow(2, -10 * x));

	// Línea de neón: halo ancho y tenue + trazo fino
	function linea(ctx, x1, y1, x2, y2, rgb, a = 1, g = 1) {
		if (a <= 0) return;
		ctx.beginPath();
		ctx.moveTo(x1, y1);
		ctx.lineTo(x2, y2);
		ctx.strokeStyle = c(rgb, 0.15 * a);
		ctx.lineWidth = 5 * g;
		ctx.stroke();
		ctx.strokeStyle = c(rgb, 0.9 * a);
		ctx.lineWidth = g;
		ctx.stroke();
	}

	// Rectángulo trazado a lo largo de su perímetro hasta la fracción k
	function marco(ctx, x, y, w, h, rgb, k = 1, a = 1, g = 1) {
		if (k <= 0) return;
		const lados = [[x, y, x + w, y], [x + w, y, x + w, y + h], [x + w, y + h, x, y + h], [x, y + h, x, y]];
		const total = 2 * (w + h);
		let resto = k * total;
		for (const [x1, y1, x2, y2] of lados) {
			const largo = Math.hypot(x2 - x1, y2 - y1);
			if (resto <= 0) break;
			const f = Math.min(1, resto / largo);
			linea(ctx, x1, y1, x1 + (x2 - x1) * f, y1 + (y2 - y1) * f, rgb, a, g);
			resto -= largo;
		}
	}

	function barra(ctx, x, y, w, h, rgb, k = 1, a = 1) {
		if (k <= 0) return;
		ctx.fillStyle = c(rgb, 0.85 * a);
		ctx.fillRect(x, y, w * k, h);
		ctx.fillStyle = c(rgb, 0.12 * a);
		ctx.fillRect(x - 2, y - 2, w * k + 4, h + 4);
	}

	function texto(ctx, str, x, y, rgb, tam, a = 1, peso = 400) {
		ctx.font = `${peso} ${tam}px ${MONO}`;
		ctx.fillStyle = c(rgb, a);
		ctx.fillText(str, x, y);
		return ctx.measureText(str).width;
	}

	// Un fragmento de código con color por token: [[texto, color], ...]
	function codigo(ctx, partes, x, y, tam, chars) {
		let resta = chars;
		let cx = x;
		for (const [t, rgb] of partes) {
			if (resta <= 0) break;
			const s = t.slice(0, resta);
			cx += texto(ctx, s, cx, y, rgb, tam);
			resta -= t.length;
		}
		return cx;
	}
	const largo = (partes) => partes.reduce((n, [t]) => n + t.length, 0);

	function panelEditor(ctx, x, y, w, h, titulo, tam) {
		ctx.fillStyle = "rgba(3, 6, 10, 0.92)";
		ctx.fillRect(x, y, w, h);
		marco(ctx, x, y, w, h, CIAN, 1, 0.55);
		linea(ctx, x, y + tam * 2, x + w, y + tam * 2, CIAN, 0.3, 0.7);
		texto(ctx, titulo, x + tam, y + tam * 1.35, GRIS, tam * 0.85);
	}

	/* --- Escena web: código → página -------------------------------------- */

	const CODIGO_WEB = [
		[["<nav>", CIAN], [" logo + menú ", TINTA], ["</nav>", CIAN]],
		[["<h1>", CIAN], ["Tu negocio, en línea", TINTA], ["</h1>", CIAN]],
		[["<p>", CIAN], ["Rápido. Seguro. Tuyo.", GRIS], ["</p>", CIAN]],
		[["<button>", CIAN], ["Comprar", TINTA], ["</button>", CIAN]],
		[["<img ", CIAN], ["src=", GRIS], ['"producto.jpg"', MAGENTA], [">", CIAN]],
		[["<section ", CIAN], ["class=", GRIS], ['"tienda"', MAGENTA], [">", CIAN]],
		[["pagos", TINTA], [" = ", GRIS], ["True", MAGENTA]],
		[["$ ", GRIS], ["deploy --production", CIAN]],
	];
	const PASO_WEB = 780; // ms por línea: escribir + trazar
	const CICLO_WEB = CODIGO_WEB.length * PASO_WEB + 4200;

	function escenaWeb(ctx, w, h, t) {
		const tam = Math.max(10.5, Math.min(13.5, w / 44));
		// Navegador
		const bx = w * 0.14, by = h * 0.07, bw = w * 0.8, bh = h * 0.55;
		ctx.fillStyle = "rgba(11, 16, 23, 0.7)";
		ctx.fillRect(bx, by, bw, bh);
		marco(ctx, bx, by, bw, bh, CIAN, 1, 0.8, 1.1);
		const barH = tam * 2.1;
		linea(ctx, bx, by + barH, bx + bw, by + barH, CIAN, 0.5, 0.8);
		marco(ctx, bx + tam, by + tam * 0.45, bw * 0.55, barH - tam * 0.9, CIAN, 1, 0.35, 0.7);
		texto(ctx, "https://tu-negocio.co", bx + tam * 1.6, by + barH * 0.66, GRIS, tam * 0.85);

		const px = bx + tam * 1.2, py = by + barH + tam * 1.2;
		const pw = bw - tam * 2.4, ph = bh - barH - tam * 2.4;
		const k = (i) => suave(tramo(t, i * PASO_WEB + PASO_WEB * 0.5, PASO_WEB * 0.55));

		// 1 nav
		marco(ctx, px, py, pw * 0.1, tam * 1.1, CIAN, k(0));
		for (let i = 0; i < 4; i++) barra(ctx, px + pw * (0.42 + i * 0.1), py + tam * 0.45, pw * 0.06, 2, GRIS, k(0), 0.8);
		marco(ctx, px + pw * 0.86, py, pw * 0.14, tam * 1.1, MAGENTA, k(0));
		// 2 titular
		barra(ctx, px, py + ph * 0.2, pw * 0.44, tam * 0.75, TINTA, k(1));
		barra(ctx, px, py + ph * 0.2 + tam * 1.25, pw * 0.3, tam * 0.75, TINTA, k(1));
		// 3 párrafo
		barra(ctx, px, py + ph * 0.2 + tam * 2.9, pw * 0.38, 2, GRIS, k(2));
		barra(ctx, px, py + ph * 0.2 + tam * 3.5, pw * 0.3, 2, GRIS, k(2));
		// 4 botón
		if (k(3) > 0) {
			ctx.fillStyle = c(CIAN, 0.85 * k(3));
			ctx.fillRect(px, py + ph * 0.2 + tam * 4.6, pw * 0.16, tam * 1.5);
			ctx.shadowColor = c(CIAN, 0.8);
			ctx.shadowBlur = 16 * k(3);
			ctx.fillRect(px, py + ph * 0.2 + tam * 4.6, pw * 0.16 * k(3), tam * 1.5);
			ctx.shadowBlur = 0;
		}
		// 5 imagen
		const ix = px + pw * 0.54, iy = py + ph * 0.14, iw = pw * 0.46, ih = ph * 0.42;
		marco(ctx, ix, iy, iw, ih, CIAN, k(4));
		if (k(4) >= 1) {
			linea(ctx, ix, iy, ix + iw, iy + ih, CIAN, 0.25, 0.7);
			linea(ctx, ix + iw, iy, ix, iy + ih, CIAN, 0.25, 0.7);
		}
		// 6 tienda: tres productos
		for (let i = 0; i < 3; i++) {
			const cx = px + i * (pw * 0.345), cy = py + ph * 0.66, cw = pw * 0.31, ch = ph * 0.34;
			const kk = suave(tramo(t, 5 * PASO_WEB + PASO_WEB * 0.45 + i * 120, PASO_WEB * 0.5));
			marco(ctx, cx, cy, cw, ch, CIAN, kk);
			barra(ctx, cx + tam * 0.6, cy + ch - tam * 1.3, cw * 0.45, 2, GRIS, kk, 0.8);
			// 7 pagos: cada producto recibe su precio
			if (k(6) > 0) texto(ctx, "$", cx + cw - tam * 1.5, cy + ch - tam * 0.8, MAGENTA, tam * 1.05, k(6), 600);
		}
		// 8 deploy: estado en vivo
		if (k(7) > 0) {
			const pulso = sinMovimiento ? 1 : 0.6 + 0.4 * Math.sin(t / 260);
			ctx.fillStyle = c(CIAN, pulso * k(7));
			ctx.fillRect(bx + bw - tam * 9.2, by + barH * 0.42, 6, 6);
			texto(ctx, "EN LÍNEA · 0.8s", bx + bw - tam * 8.2, by + barH * 0.66, CIAN, tam * 0.8, k(7), 600);
		}

		// Editor
		const ex = w * 0.04, ey = h * 0.49, ew = w * 0.64;
		const altoLinea = tam * 1.7;
		const eh = tam * 3.2 + CODIGO_WEB.length * altoLinea;
		panelEditor(ctx, ex, ey, ew, eh, "index.html", tam);
		CODIGO_WEB.forEach((partes, i) => {
			const chars = Math.floor(tramo(t, i * PASO_WEB, PASO_WEB * 0.45) * largo(partes));
			if (chars <= 0) return;
			const y = ey + tam * 3.4 + i * altoLinea;
			texto(ctx, String(i + 1).padStart(2, " "), ex + tam * 0.7, y, GRIS, tam * 0.85, 0.5);
			const fin = codigo(ctx, partes, ex + tam * 2.8, y, tam, chars);
			const escribiendo = chars < largo(partes) || (i === CODIGO_WEB.length - 1 && t > i * PASO_WEB);
			if (escribiendo && Math.floor(t / 420) % 2 === 0) {
				ctx.fillStyle = c(CIAN, 0.9);
				ctx.fillRect(fin + 2, y - tam * 0.85, tam * 0.55, tam * 1.05);
			}
		});
	}

	/* --- Escena Python: la película en vivo -------------------------------- */

	const CODIGO_PY = [
		[["ventas", TINTA], [" = ", GRIS], ["[1200, 800, 340]", MAGENTA]],
		[["total", TINTA], [" = ", GRIS], ["0", MAGENTA]],
		[["for ", CIAN], ["venta ", TINTA], ["in ", CIAN], ["ventas", TINTA], [":", GRIS]],
		[["    total ", TINTA], ["+= ", GRIS], ["venta", TINTA]],
		[["print", CIAN], ["(total)", TINTA]],
	];
	// Cada paso: línea activa, estado de las variables y salida
	const PASOS_PY = [
		{ l: 0, v: { ventas: "[1200, 800, 340]" } },
		{ l: 1, v: { ventas: "[1200, 800, 340]", total: "0" }, cambio: "total" },
		{ l: 2, v: { ventas: "[1200, 800, 340]", total: "0", venta: "1200" }, cambio: "venta" },
		{ l: 3, v: { ventas: "[1200, 800, 340]", total: "1200", venta: "1200" }, cambio: "total" },
		{ l: 2, v: { ventas: "[1200, 800, 340]", total: "1200", venta: "800" }, cambio: "venta" },
		{ l: 3, v: { ventas: "[1200, 800, 340]", total: "2000", venta: "800" }, cambio: "total" },
		{ l: 2, v: { ventas: "[1200, 800, 340]", total: "2000", venta: "340" }, cambio: "venta" },
		{ l: 3, v: { ventas: "[1200, 800, 340]", total: "2340", venta: "340" }, cambio: "total" },
		{ l: 4, v: { ventas: "[1200, 800, 340]", total: "2340", venta: "340" }, salida: "2340" },
	];
	const ESCRIBIR_PY = 1800;
	const PASO_PY = 720;
	const CICLO_PY = ESCRIBIR_PY + PASOS_PY.length * PASO_PY + 3600;

	function escenaPython(ctx, w, h, t) {
		const tam = Math.max(11, Math.min(14.5, w / 40));
		const altoLinea = tam * 1.9;
		// Editor
		const ex = w * 0.06, ey = h * 0.13, ew = w * 0.7;
		const eh = tam * 3.4 + CODIGO_PY.length * altoLinea;
		panelEditor(ctx, ex, ey, ew, eh, "ventas.py", tam);

		let escritos = Math.floor(tramo(t, 0, ESCRIBIR_PY) * CODIGO_PY.reduce((n, p) => n + largo(p), 0));
		const paso = t < ESCRIBIR_PY ? -1 : Math.min(PASOS_PY.length - 1, Math.floor((t - ESCRIBIR_PY) / PASO_PY));
		const estado = paso >= 0 ? PASOS_PY[paso] : null;

		CODIGO_PY.forEach((partes, i) => {
			const y = ey + tam * 3.5 + i * altoLinea;
			if (estado && estado.l === i) {
				ctx.fillStyle = c(CIAN, 0.12);
				ctx.fillRect(ex + 1, y - tam * 1.2, ew - 2, altoLinea);
				ctx.fillStyle = c(CIAN, 0.9);
				ctx.fillRect(ex + 1, y - tam * 1.2, 2, altoLinea);
			}
			const n = Math.min(largo(partes), Math.max(0, escritos));
			escritos -= largo(partes);
			if (n <= 0) return;
			texto(ctx, String(i + 1), ex + tam * 0.8, y, GRIS, tam * 0.85, 0.5);
			const fin = codigo(ctx, partes, ex + tam * 2.4, y, tam, n);
			if (n < largo(partes) && Math.floor(t / 300) % 2 === 0) {
				ctx.fillStyle = c(CIAN, 0.9);
				ctx.fillRect(fin + 2, y - tam * 0.85, tam * 0.55, tam * 1.05);
			}
		});

		// Panel de variables (la película)
		const vx = w * 0.4, vy = ey + eh + tam * 1.6, vw = w * 0.54;
		const filas = ["ventas", "total", "venta"];
		const vh = tam * 3.2 + filas.length * altoLinea;
		ctx.fillStyle = "rgba(3, 6, 10, 0.92)";
		ctx.fillRect(vx, vy, vw, vh);
		marco(ctx, vx, vy, vw, vh, MAGENTA, 1, 0.6);
		linea(ctx, vx, vy + tam * 2, vx + vw, vy + tam * 2, MAGENTA, 0.3, 0.7);
		texto(ctx, "VARIABLES", vx + tam, vy + tam * 1.35, MAGENTA, tam * 0.8, 0.9, 600);
		filas.forEach((nombre, i) => {
			const y = vy + tam * 3.5 + i * altoLinea;
			texto(ctx, nombre, vx + tam, y, GRIS, tam * 0.95);
			const valor = estado?.v[nombre];
			if (!valor) {
				texto(ctx, "·", vx + vw * 0.42, y, GRIS, tam, 0.4);
				return;
			}
			const recien = estado.cambio === nombre;
			const brillo = recien ? 1 - tramo(t, ESCRIBIR_PY + paso * PASO_PY, PASO_PY) : 0;
			if (recien) {
				ctx.fillStyle = c(CIAN, 0.18 * (0.4 + brillo));
				ctx.fillRect(vx + vw * 0.4, y - tam * 1.1, vw * 0.56, altoLinea * 0.9);
			}
			texto(ctx, valor, vx + vw * 0.42, y, recien ? CIAN : TINTA, tam, 1, recien ? 600 : 400);
		});

		// Consola
		const cy = vy + vh + tam * 1.2;
		const salida = estado?.salida;
		texto(ctx, ">>>", w * 0.06, cy + tam, GRIS, tam * 0.9, 0.7);
		if (salida) {
			const a = suave(tramo(t, ESCRIBIR_PY + paso * PASO_PY, 300));
			texto(ctx, salida, w * 0.06 + tam * 3, cy + tam, CIAN, tam * 1.3, a, 700);
			texto(ctx, "¡ahh, ya entendí!", w * 0.06 + tam * 8, cy + tam, MAGENTA, tam * 0.9, a * 0.9);
		}
	}

	/* --- Escena agentes: RAG con supervisor (hoja de vida) ----------------- */

	// Una consulta entra, el supervisor reparte a tres agentes, el retriever
	// busca en el índice vectorial y la respuesta sale con sus fuentes.
	const CONSULTA = "¿Qué controles pide el MSA de PQRs?";
	const RESPUESTA = ["Cifrado en tránsito, IAM por rol,", "trazas en CloudWatch y revisión humana."];
	const T_AG = { escribir: 1500, subir: 2200, repartir: 3000, buscar: 4000, hallar: 4900, volver: 5600, unir: 6300, responder: 8400 };
	const CICLO_AG = T_AG.responder + 3800;

	// Pulso que viaja de a hacia b
	function viaje(ctx, ax, ay, bx, by, k, rgb) {
		if (k <= 0) return;
		const f = Math.min(1, k);
		linea(ctx, ax, ay, ax + (bx - ax) * f, ay + (by - ay) * f, rgb, 0.7, 1);
		if (f < 1) {
			ctx.fillStyle = c(rgb, 1);
			ctx.shadowColor = c(rgb, 0.9);
			ctx.shadowBlur = 12;
			ctx.fillRect(ax + (bx - ax) * f - 3, ay + (by - ay) * f - 3, 6, 6);
			ctx.shadowBlur = 0;
		}
	}

	function nodo(ctx, x, y, w, h, nombre, sub, rgb, k, activo, tam) {
		if (k <= 0) return;
		ctx.fillStyle = activo ? c(rgb, 0.14) : "rgba(3, 6, 10, 0.9)";
		ctx.fillRect(x, y, w, h);
		marco(ctx, x, y, w, h, rgb, k, activo ? 1 : 0.6, activo ? 1.2 : 1);
		if (k < 1) return;
		texto(ctx, nombre, x + tam * 0.8, y + h * 0.44, activo ? rgb : TINTA, tam * 0.9, 1, 600);
		texto(ctx, sub, x + tam * 0.8, y + h * 0.78, GRIS, tam * 0.75, 0.85);
	}

	function escenaAgentes(ctx, w, h, t) {
		const tam = Math.max(10, Math.min(13.5, w / 46));
		const k = (ini, dur) => suave(tramo(t, ini, dur));

		// Consulta
		const qx = w * 0.06, qy = h * 0.05, qw = w * 0.88, qh = tam * 4.4;
		panelEditor(ctx, qx, qy, qw, qh, "consulta", tam);
		const escritos = Math.floor(tramo(t, 0, T_AG.escribir) * CONSULTA.length);
		const finQ = texto(ctx, CONSULTA.slice(0, escritos), qx + tam, qy + tam * 3.4, TINTA, tam);
		if (t < T_AG.subir && Math.floor(t / 380) % 2 === 0) {
			ctx.fillStyle = c(CIAN, 0.9);
			ctx.fillRect(qx + tam + finQ + 2, qy + tam * 2.55, tam * 0.55, tam * 1.05);
		}

		// Supervisor
		const sw = w * 0.36, sh = tam * 3.6, sx = w * 0.5 - sw / 2, sy = h * 0.21;
		const supActivo = (t > T_AG.subir && t < T_AG.repartir + 400) || (t > T_AG.unir - 300 && t < T_AG.unir + 500);
		viaje(ctx, w * 0.5, qy + qh, w * 0.5, sy, tramo(t, T_AG.escribir, T_AG.subir - T_AG.escribir), CIAN);
		nodo(ctx, sx, sy, sw, sh, "SUPERVISOR", "LangGraph", MAGENTA, k(T_AG.escribir + 300, 500), supActivo, tam);

		// Tres agentes
		const aw = w * 0.27, ah = tam * 3.6, ay = h * 0.37;
		const agentes = [
			{ x: w * 0.06, n: "retriever", s: "busca contexto" },
			{ x: w * 0.5 - aw / 2, n: "analista", s: "arma el borrador" },
			{ x: w * 0.94 - aw, n: "verificador", s: "cita y valida" },
		];
		agentes.forEach((a, i) => {
			const ini = T_AG.repartir + i * 160;
			const cx = a.x + aw / 2;
			viaje(ctx, w * 0.5, sy + sh, cx, ay, tramo(t, ini - 600, 600), MAGENTA);
			const activo = i === 0 ? t > T_AG.repartir && t < T_AG.volver + 300 : t > T_AG.volver - 200 && t < T_AG.unir;
			nodo(ctx, a.x, ay, aw, ah, a.n, a.s, CIAN, k(ini - 200, 400), activo, tam);
			// De vuelta al supervisor
			if (t > T_AG.volver) viaje(ctx, cx, ay, w * 0.5 + (i - 1) * tam * 1.2, sy + sh, tramo(t, T_AG.volver + i * 140, 600), CIAN);
		});

		// Índice vectorial
		const ox = w * 0.06, oy = h * 0.54, ow = w * 0.4, oh = h * 0.22;
		const kIdx = k(T_AG.repartir, 600);
		if (kIdx > 0) {
			ctx.fillStyle = "rgba(3, 6, 10, 0.9)";
			ctx.fillRect(ox, oy, ow, oh);
			marco(ctx, ox, oy, ow, oh, CIAN, kIdx, 0.45);
			texto(ctx, "OpenSearch", ox + tam * 0.8, oy + tam * 1.5, GRIS, tam * 0.75, kIdx);
			viaje(ctx, agentes[0].x + aw / 2, ay + ah, ox + ow / 2, oy, tramo(t, T_AG.buscar - 500, 500), CIAN);
			const cols = 9, filas = 4;
			const gx = ox + tam * 0.8, gy = oy + tam * 2.4;
			const cw = (ow - tam * 1.6) / cols, ch = (oh - tam * 3.2) / filas;
			const barrido = tramo(t, T_AG.buscar, T_AG.hallar - T_AG.buscar);
			const hallados = [5, 12, 30];
			for (let f = 0; f < filas; f++) {
				for (let col = 0; col < cols; col++) {
					const i = f * cols + col;
					const visto = barrido * cols > col;
					const es = hallados.includes(i) && t > T_AG.hallar;
					ctx.fillStyle = es ? c(MAGENTA, 0.9) : c(visto && t < T_AG.hallar ? CIAN : GRIS, visto && t < T_AG.hallar ? 0.5 : 0.2 * kIdx);
					if (es) { ctx.shadowColor = c(MAGENTA, 0.9); ctx.shadowBlur = 10; }
					ctx.fillRect(gx + col * cw + 2, gy + f * ch + 2, cw - 5, ch - 5);
					ctx.shadowBlur = 0;
				}
			}
		}

		// Respuesta con fuentes
		const rx = w * 0.52, ry = h * 0.54, rw = w * 0.42, rh = h * 0.22;
		const kR = k(T_AG.unir, 500);
		if (kR > 0) {
			ctx.fillStyle = "rgba(3, 6, 10, 0.92)";
			ctx.fillRect(rx, ry, rw, rh);
			marco(ctx, rx, ry, rw, rh, MAGENTA, kR, 0.6);
			texto(ctx, "RESPUESTA", rx + tam * 0.8, ry + tam * 1.5, MAGENTA, tam * 0.75, kR, 600);
			viaje(ctx, w * 0.5, sy + sh, rx + rw / 2, ry, tramo(t, T_AG.unir - 400, 500), MAGENTA);
			const total = RESPUESTA.join("").length;
			let resta = Math.floor(tramo(t, T_AG.unir + 300, T_AG.responder - T_AG.unir - 900) * total);
			const tamR = Math.min(tam * 0.85, (rw - tam * 1.6) / 24);
			RESPUESTA.forEach((l, i) => {
				if (resta <= 0) return;
				texto(ctx, l.slice(0, resta), rx + tam * 0.8, ry + tam * 3.2 + i * tamR * 1.6, TINTA, tamR);
				resta -= l.length;
			});
			const kF = k(T_AG.responder - 500, 400);
			if (kF > 0) {
				const fy = ry + rh - tam * 1.1;
				const a1 = texto(ctx, "[fuente 1]", rx + tam * 0.8, fy, CIAN, tamR, kF, 600);
				texto(ctx, "[fuente 2]", rx + tam * 1.6 + a1, fy, CIAN, tamR, kF, 600);
			}
		}
	}

	/* --- Piso en fuga ------------------------------------------------------- */

	function escenaPiso(ctx, w, h, t) {
		const horizonte = h * 0.32;
		const fx = w / 2;
		for (let i = -14; i <= 14; i++) {
			linea(ctx, fx + i * (w / 90), horizonte, fx + i * (w / 10), h + 20, CIAN, 0.28 * (1 - Math.abs(i) / 16), 0.8);
		}
		const desplazo = sinMovimiento ? 0 : (t / 2600) % 1;
		for (let j = 0; j < 14; j++) {
			const z = (j + desplazo) / 14;
			const y = horizonte + (h - horizonte) * z * z;
			linea(ctx, 0, y, w, y, j % 5 === 4 ? MAGENTA : CIAN, 0.3 * z, 0.8);
		}
		linea(ctx, 0, horizonte, w, horizonte, MAGENTA, 0.7, 1);
	}

	/* --- Motor ------------------------------------------------------------- */

	const ESCENAS = {
		web: { dibujar: escenaWeb, ciclo: CICLO_WEB, final: CODIGO_WEB.length * PASO_WEB + 400 },
		python: { dibujar: escenaPython, ciclo: CICLO_PY, final: ESCRIBIR_PY + PASOS_PY.length * PASO_PY },
		agentes: { dibujar: escenaAgentes, ciclo: CICLO_AG, final: T_AG.responder + 200 },
		piso: { dibujar: escenaPiso, ciclo: 0, final: 0 },
	};

	function preparar(canvas) {
		const dato = canvas.dataset.muro;
		const escena = ESCENAS[dato === "celosia" ? "piso" : dato in ESCENAS ? dato : "web"];
		let medida = null;
		let inicio = 0;
		let visible = false;
		let raf = 0;

		const medir = () => {
			const dpr = Math.min(window.devicePixelRatio || 1, 2);
			const w = canvas.clientWidth;
			const h = canvas.clientHeight;
			if (!w || !h) return null;
			canvas.width = Math.round(w * dpr);
			canvas.height = Math.round(h * dpr);
			const ctx = canvas.getContext("2d");
			ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
			return { ctx, w, h };
		};

		const pintar = (t) => {
			if (!medida) return;
			medida.ctx.clearRect(0, 0, medida.w, medida.h);
			escena.dibujar(medida.ctx, medida.w, medida.h, t);
		};

		const cuadro = (ahora) => {
			const trans = ahora - inicio;
			pintar(escena.ciclo ? trans % escena.ciclo : trans);
			if (visible) raf = requestAnimationFrame(cuadro);
		};

		const quieto = () => {
			medida = medir();
			pintar(escena.final);
		};

		// Espera la fuente mono para que el código no salte al cargar
		const listo = document.fonts ? document.fonts.ready : Promise.resolve();
		let obs;
		let desmontado = false;
		listo.then(() => {
			if (desmontado) return;
			if (sinMovimiento || !("IntersectionObserver" in window)) {
				quieto();
				return;
			}
			obs = new IntersectionObserver(
				(entradas) => {
					const ahora = entradas.some((e) => e.isIntersecting);
					if (ahora && !visible) {
						visible = true;
						medida = medida || medir();
						if (!inicio) inicio = performance.now();
						raf = requestAnimationFrame(cuadro);
					} else if (!ahora && visible) {
						visible = false;
						cancelAnimationFrame(raf);
					}
				},
				{ threshold: 0.05 },
			);
			obs.observe(canvas);
		});

		let espera;
		const redimensionar = () => {
			clearTimeout(espera);
			espera = setTimeout(() => {
				if (sinMovimiento) quieto();
				else medida = medir();
			}, 120);
		};
		let ro;
		if ("ResizeObserver" in window) {
			ro = new ResizeObserver(redimensionar);
			ro.observe(canvas);
		} else window.addEventListener("resize", redimensionar);

		// Desmontar: la app (React) lo llama al salir de la ruta
		return () => {
			desmontado = true;
			visible = false;
			cancelAnimationFrame(raf);
			clearTimeout(espera);
			obs?.disconnect();
			ro?.disconnect();
			window.removeEventListener("resize", redimensionar);
		};
	}

	// La landing monta todo lo que haya; la app llama a montar() por su cuenta
	window.JuanCodeMuro = { montar: preparar };
	if (!window.JuanCodeMuroManual) {
		for (const canvas of document.querySelectorAll("canvas[data-muro]")) preparar(canvas);
	}
})();
