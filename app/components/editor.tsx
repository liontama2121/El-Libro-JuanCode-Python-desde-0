import { useRef, useState } from "react";

/**
 * Editor de código sencillo: textarea monoespaciado con números de línea y
 * Tab = 4 espacios (Shift+Tab saca la indentación).
 *
 * No es CodeMirror a propósito: pesa 0 KB extra, funciona igual en celular y
 * no pelea con el teclado virtual.
 */
export function EditorCodigo({
	valor,
	onCambio,
	nombre,
	filas = 14,
	soloLectura = false,
	etiqueta,
}: {
	valor: string;
	onCambio?: (v: string) => void;
	nombre?: string;
	filas?: number;
	soloLectura?: boolean;
	etiqueta?: string;
}) {
	const ref = useRef<HTMLTextAreaElement>(null);
	const [scroll, setScroll] = useState(0);

	const lineas = valor.split("\n").length;

	function manejarTab(e: React.KeyboardEvent<HTMLTextAreaElement>) {
		if (e.key !== "Tab") return;
		e.preventDefault();

		const el = e.currentTarget;
		const { selectionStart: ini, selectionEnd: fin } = el;

		if (e.shiftKey) {
			// Saca 4 espacios del principio de la línea
			const antes = valor.lastIndexOf("\n", ini - 1) + 1;
			const linea = valor.slice(antes, fin);
			const quitados = linea.replace(/^ {1,4}/, "");
			const delta = linea.length - quitados.length;
			if (delta === 0) return;
			const nuevo = valor.slice(0, antes) + quitados + valor.slice(fin);
			onCambio?.(nuevo);
			requestAnimationFrame(() => {
				el.selectionStart = el.selectionEnd = Math.max(antes, ini - delta);
			});
			return;
		}

		const nuevo = `${valor.slice(0, ini)}    ${valor.slice(fin)}`;
		onCambio?.(nuevo);
		requestAnimationFrame(() => {
			el.selectionStart = el.selectionEnd = ini + 4;
		});
	}

	return (
		<div>
			{etiqueta && <span className="jc-label">{etiqueta}</span>}
			<div className="flex overflow-hidden rounded-xl border border-[var(--color-borde)] bg-black/60">
				{/* Números de línea */}
				<div
					aria-hidden="true"
					className="jc-mono max-h-[60vh] shrink-0 select-none overflow-hidden border-r
						border-[var(--color-borde)] bg-black/40 px-2 py-3 text-right text-[0.8rem]
						leading-[1.6] text-[var(--color-tinta-2)]"
					style={{ transform: `translateY(-${scroll}px)` }}
				>
					{Array.from({ length: Math.max(lineas, filas) }, (_, i) => (
						<div key={i}>{i + 1}</div>
					))}
				</div>

				<textarea
					ref={ref}
					name={nombre}
					value={valor}
					readOnly={soloLectura}
					spellCheck={false}
					autoCapitalize="off"
					autoCorrect="off"
					rows={filas}
					onScroll={(e) => setScroll(e.currentTarget.scrollTop)}
					onChange={(e) => onCambio?.(e.target.value)}
					onKeyDown={manejarTab}
					className="jc-mono max-h-[60vh] flex-1 resize-y bg-transparent px-3 py-3
						text-[0.8rem] leading-[1.6] text-[#d7dcff] outline-none sm:text-sm"
					placeholder="# escribe tu código aquí"
				/>
			</div>
			{!soloLectura && (
				<p className="mt-1.5 text-xs text-[var(--color-tinta-2)]">
					Tab mete 4 espacios · Shift+Tab los saca
				</p>
			)}
		</div>
	);
}
