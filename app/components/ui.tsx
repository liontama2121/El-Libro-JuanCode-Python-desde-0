import { useEffect, useRef, useState } from "react";
import { useSearchParams } from "react-router";

/* -------------------------------------------------------------------------- */
/*  Toast (se dispara con ?toast=mensaje)                                      */
/* -------------------------------------------------------------------------- */

export function Toast() {
	const [params, setParams] = useSearchParams();
	const mensaje = params.get("toast");
	const [visible, setVisible] = useState(Boolean(mensaje));

	useEffect(() => {
		if (!mensaje) return;
		setVisible(true);
		const t = setTimeout(() => {
			setVisible(false);
			const next = new URLSearchParams(params);
			next.delete("toast");
			setParams(next, { replace: true, preventScrollReset: true });
		}, 4200);
		return () => clearTimeout(t);
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [mensaje]);

	if (!mensaje || !visible) return null;

	return (
		<div className="pointer-events-none fixed inset-x-0 top-20 z-50 flex justify-center px-4">
			<div className="jc-anim-in jc-glass max-w-md px-5 py-3 text-center text-sm shadow-2xl">
				{mensaje}
			</div>
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  Toast de insignias ganadas                                                 */
/* -------------------------------------------------------------------------- */

export type InsigniaGanada = { emoji: string; nombre: string; texto: string };

/**
 * Aviso flotante cuando el estudiante gana insignias. Se apilan y se van
 * solas a los 6 segundos.
 */
export function ToastInsignias({ insignias }: { insignias: InsigniaGanada[] }) {
	const [visibles, setVisibles] = useState(insignias);

	useEffect(() => {
		setVisibles(insignias);
		if (insignias.length === 0) return;
		const t = setTimeout(() => setVisibles([]), 6000);
		return () => clearTimeout(t);
	}, [insignias]);

	if (visibles.length === 0) return null;

	return (
		<div className="pointer-events-none fixed inset-x-0 top-20 z-50 flex flex-col items-center gap-3 px-4">
			{visibles.map((i, k) => (
				<div
					key={i.nombre}
					className="jc-anim-pop w-full max-w-sm rounded-2xl border
						border-[rgba(255,212,59,.5)] bg-[#15131f]/95 px-5 py-4 text-center shadow-2xl"
					style={{ animationDelay: `${k * 160}ms` }}
				>
					<p className="jc-mono text-[0.62rem] tracking-[0.24em] text-[var(--color-dorado)] uppercase">
						insignia desbloqueada
					</p>
					<p className="jc-display mt-1.5 text-xl">
						{i.emoji} {i.nombre}
					</p>
					<p className="mt-1 text-sm text-[var(--color-tinta-2)]">{i.texto}</p>
				</div>
			))}
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  Barra de progreso                                                          */
/* -------------------------------------------------------------------------- */

export function BarraProgreso({
	valor,
	total,
	etiqueta,
}: {
	valor: number;
	total: number;
	etiqueta?: string;
}) {
	const pct = total > 0 ? Math.round((valor / total) * 100) : 0;
	return (
		<div className="w-full">
			{etiqueta && (
				<div className="mb-2 flex items-baseline justify-between">
					<span className="jc-mono text-xs tracking-[0.14em] text-[var(--color-tinta-2)] uppercase">
						{etiqueta}
					</span>
					<span className="jc-mono text-xs text-[var(--color-cyan)]">{pct}%</span>
				</div>
			)}
			<div className="h-2.5 w-full overflow-hidden rounded-full border border-[var(--color-borde)] bg-black/40">
				<div
					className="h-full rounded-full transition-[width] duration-700 ease-out"
					style={{
						width: `${pct}%`,
						background:
							"linear-gradient(92deg, var(--color-cyan), var(--color-purpura) 55%, var(--color-magenta))",
					}}
				/>
			</div>
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  Badge de dificultad                                                        */
/* -------------------------------------------------------------------------- */

const DIFICULTAD: Record<string, { clase: string; texto: string }> = {
	facil: { clase: "jc-badge-facil", texto: "fácil" },
	medio: { clase: "jc-badge-medio", texto: "medio" },
	dificil: { clase: "jc-badge-dificil", texto: "difícil" },
};

export function BadgeDificultad({ nivel }: { nivel: string }) {
	const d = DIFICULTAD[nivel] ?? DIFICULTAD.facil;
	return <span className={`jc-badge ${d.clase}`}>{d.texto}</span>;
}

/* -------------------------------------------------------------------------- */
/*  Score animado                                                              */
/* -------------------------------------------------------------------------- */

export function ScoreAnimado({
	score,
	aprobado,
}: {
	score: number;
	aprobado: boolean;
}) {
	const [valor, setValor] = useState(0);

	useEffect(() => {
		let raf = 0;
		const inicio = performance.now();
		const dur = 1100;
		const tick = (t: number) => {
			const p = Math.min(1, (t - inicio) / dur);
			const eased = 1 - (1 - p) ** 3;
			setValor(Math.round(score * eased));
			if (p < 1) raf = requestAnimationFrame(tick);
		};
		raf = requestAnimationFrame(tick);
		return () => cancelAnimationFrame(raf);
	}, [score]);

	const color = aprobado ? "var(--color-verde)" : "var(--color-naranja)";
	const circunferencia = 2 * Math.PI * 54;

	return (
		<div className="relative grid h-40 w-40 place-items-center">
			<svg className="absolute inset-0 -rotate-90" viewBox="0 0 120 120">
				<circle
					cx="60"
					cy="60"
					r="54"
					fill="none"
					stroke="rgba(255,255,255,.08)"
					strokeWidth="9"
				/>
				<circle
					cx="60"
					cy="60"
					r="54"
					fill="none"
					stroke={color}
					strokeWidth="9"
					strokeLinecap="round"
					strokeDasharray={circunferencia}
					strokeDashoffset={circunferencia * (1 - valor / 100)}
					style={{ transition: "stroke-dashoffset .12s linear" }}
				/>
			</svg>
			<div className="text-center">
				<div className="jc-display text-4xl" style={{ color }}>
					{valor}
				</div>
				<div className="jc-mono text-[0.65rem] tracking-[0.2em] text-[var(--color-tinta-2)] uppercase">
					puntos
				</div>
			</div>
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  Confetti (canvas, sin dependencias)                                        */
/* -------------------------------------------------------------------------- */

const COLORES = ["#00E5FF", "#FF4DFF", "#b975ff", "#34e07a", "#ffd43b", "#ffa94d"];

export function Confetti({ activo }: { activo: boolean }) {
	const ref = useRef<HTMLCanvasElement>(null);

	useEffect(() => {
		if (!activo) return;
		const canvas = ref.current;
		if (!canvas) return;
		const ctx = canvas.getContext("2d");
		if (!ctx) return;

		const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
		if (reduce) return;

		const dpr = Math.min(window.devicePixelRatio || 1, 2);
		const resize = () => {
			canvas.width = window.innerWidth * dpr;
			canvas.height = window.innerHeight * dpr;
			ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
		};
		resize();
		window.addEventListener("resize", resize);

		const piezas = Array.from({ length: 160 }, () => ({
			x: window.innerWidth / 2 + (Math.random() - 0.5) * 260,
			y: -20 - Math.random() * 220,
			vx: (Math.random() - 0.5) * 5,
			vy: 2 + Math.random() * 4.5,
			ancho: 5 + Math.random() * 7,
			alto: 8 + Math.random() * 9,
			rot: Math.random() * Math.PI,
			vrot: (Math.random() - 0.5) * 0.28,
			color: COLORES[Math.floor(Math.random() * COLORES.length)],
		}));

		let raf = 0;
		let frames = 0;
		const dibujar = () => {
			frames += 1;
			ctx.clearRect(0, 0, window.innerWidth, window.innerHeight);
			for (const p of piezas) {
				p.x += p.vx;
				p.y += p.vy;
				p.vy += 0.045;
				p.rot += p.vrot;
				ctx.save();
				ctx.translate(p.x, p.y);
				ctx.rotate(p.rot);
				ctx.fillStyle = p.color;
				ctx.globalAlpha = Math.max(0, 1 - frames / 340);
				ctx.fillRect(-p.ancho / 2, -p.alto / 2, p.ancho, p.alto);
				ctx.restore();
			}
			if (frames < 340) raf = requestAnimationFrame(dibujar);
			else ctx.clearRect(0, 0, window.innerWidth, window.innerHeight);
		};
		raf = requestAnimationFrame(dibujar);

		return () => {
			cancelAnimationFrame(raf);
			window.removeEventListener("resize", resize);
		};
	}, [activo]);

	if (!activo) return null;

	return (
		<canvas
			ref={ref}
			className="pointer-events-none fixed inset-0 z-50"
			aria-hidden="true"
		/>
	);
}

/* -------------------------------------------------------------------------- */
/*  Bloque de código simple (para code_snippet de las preguntas)               */
/* -------------------------------------------------------------------------- */

export function BloqueCodigo({ codigo }: { codigo: string }) {
	return (
		<pre className="jc-mono overflow-x-auto rounded-xl border border-[var(--color-borde)] border-l-[3px] border-l-[var(--color-cyan)] bg-black/60 p-4 text-sm leading-relaxed text-[#d7dcff]">
			<code>{codigo}</code>
		</pre>
	);
}
