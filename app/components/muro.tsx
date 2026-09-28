import { useEffect, useRef } from "react";

/* ==========================================================================
   Escena holográfica — la misma de juancode.co.
   El motor vive en /muro.js (copia de landing/public/assets/muro.js) para
   que la landing y el libro dibujen exactamente lo mismo. Aquí solo se carga
   una vez y se monta/desmonta el canvas con la ruta.

   escena="python" → la película en vivo (el código se ejecuta y las
   variables cambian); escena="web" → código que arma una página.
   ========================================================================== */

type Motor = { montar: (canvas: HTMLCanvasElement) => () => void };

let cargando: Promise<Motor> | null = null;

function cargarMotor(): Promise<Motor> {
	const w = window as unknown as { JuanCodeMuro?: Motor; JuanCodeMuroManual?: boolean };
	// La app monta cada canvas desde React; el script no debe montar por su cuenta
	w.JuanCodeMuroManual = true;
	if (w.JuanCodeMuro) return Promise.resolve(w.JuanCodeMuro);
	cargando ??= new Promise((resolver, rechazar) => {
		const s = document.createElement("script");
		s.src = "/muro.js";
		s.async = true;
		s.onload = () => (w.JuanCodeMuro ? resolver(w.JuanCodeMuro) : rechazar(new Error("muro.js sin motor")));
		s.onerror = rechazar;
		document.head.appendChild(s);
	});
	return cargando;
}

export function Muro({
	escena = "python",
	className = "",
}: {
	escena?: "python" | "web" | "piso";
	className?: string;
}) {
	const ref = useRef<HTMLCanvasElement>(null);

	useEffect(() => {
		const canvas = ref.current;
		if (!canvas) return;
		let desmontar: (() => void) | undefined;
		let vivo = true;
		cargarMotor()
			.then((motor) => {
				if (vivo) desmontar = motor.montar(canvas);
			})
			.catch(() => {
				// Sin la escena la página sigue completa: es decoración.
			});
		return () => {
			vivo = false;
			desmontar?.();
		};
	}, [escena]);

	return (
		<canvas
			ref={ref}
			data-muro={escena}
			aria-hidden="true"
			className={`block h-full w-full ${className}`}
		/>
	);
}
