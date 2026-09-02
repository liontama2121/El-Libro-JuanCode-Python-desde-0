import { useState } from "react";
import type { Pelicula } from "~/lib/traces";

/**
 * 🎬 La película en vivo.
 *
 * Prueba de escritorio interactiva: cada "siguiente paso" agrega UNA fila a la
 * tabla y concatena lo que el programa imprime en la consola de abajo.
 *
 * Todo el estado es un número: cuántos pasos se han dado. La fila resaltada es
 * siempre la última, así que no hay que guardar nada más.
 */
export function TraceStepper({ pelicula }: { pelicula: Pelicula }) {
	const { title, description, code, columns, pasos } = pelicula;
	const [dados, setDados] = useState(0);

	const total = pasos.length;
	const termino = dados >= total && total > 0;
	const visibles = pasos.slice(0, dados);
	const salida = visibles.map((p) => p.out).join("");

	const lineas = code.split("\n");

	return (
		<div className="jc-glass overflow-hidden">
			{/* Encabezado ------------------------------------------------------- */}
			<div className="border-b border-[var(--color-borde)] px-5 py-4 sm:px-6">
				<h3 className="jc-display text-lg sm:text-xl">{title}</h3>
				{description && (
					<p className="mt-1 text-sm text-[var(--color-tinta-2)]">
						{description}
					</p>
				)}
			</div>

			<div className="space-y-5 p-4 sm:p-6">
				{/* Código, estilo editor ----------------------------------------- */}
				<div className="overflow-hidden rounded-xl border border-[var(--color-borde)] bg-[#12132b]">
					<div className="flex items-center gap-1.5 border-b border-[var(--color-borde)] px-3 py-2">
						<span className="h-2.5 w-2.5 rounded-full bg-[#ff5f57]" />
						<span className="h-2.5 w-2.5 rounded-full bg-[#febc2e]" />
						<span className="h-2.5 w-2.5 rounded-full bg-[#28c840]" />
						<span className="jc-mono ml-2 text-[0.62rem] tracking-[0.16em] text-[var(--color-tinta-2)] uppercase">
							programa.py
						</span>
					</div>
					<pre className="jc-mono overflow-x-auto px-4 py-3 text-[0.78rem] leading-[1.75] text-[#d7dcff] sm:text-[0.85rem]">
						{lineas.map((linea, i) => (
							// El código no cambia nunca: el índice sirve de key.
							<div key={i} className="flex gap-3">
								<span className="w-4 shrink-0 select-none text-right text-[var(--color-tinta-2)] opacity-50">
									{i + 1}
								</span>
								<span className="whitespace-pre">{linea || " "}</span>
							</div>
						))}
					</pre>
				</div>

				{/* Botonera ------------------------------------------------------- */}
				<div className="flex flex-wrap gap-2">
					<button
						type="button"
						disabled={termino}
						onClick={() => setDados((d) => Math.min(d + 1, total))}
						className="jc-btn jc-btn-primary flex-1 py-3 text-[0.95rem] sm:flex-none sm:py-2.5"
					>
						▶ Siguiente paso
					</button>
					<button
						type="button"
						disabled={termino}
						onClick={() => setDados(total)}
						className="jc-btn jc-btn-ghost flex-1 py-3 text-[0.95rem] sm:flex-none sm:py-2.5"
					>
						⏩ Ver todo
					</button>
					<button
						type="button"
						onClick={() => setDados(0)}
						className="jc-btn jc-btn-ghost flex-1 py-3 text-[0.95rem] sm:flex-none sm:py-2.5"
					>
						🔄 Reiniciar
					</button>
					<span className="jc-mono ml-auto self-center text-xs text-[var(--color-tinta-2)]">
						paso {dados} de {total}
					</span>
				</div>

				{/* Tabla de la prueba de escritorio ------------------------------ */}
				<div className="overflow-x-auto rounded-xl border border-[var(--color-borde)]">
					<table className="w-full min-w-[420px] text-left text-[0.8rem] sm:text-sm">
						<thead>
							<tr className="border-b border-[var(--color-borde)] bg-white/[0.04]">
								{columns.map((c) => (
									<th
										key={c}
										className="jc-mono px-3 py-2.5 text-[0.62rem] tracking-[0.12em] text-[var(--color-cyan)] uppercase sm:px-4 sm:text-[0.68rem]"
									>
										{c}
									</th>
								))}
							</tr>
						</thead>
						<tbody>
							{visibles.map((paso, i) => {
								const ultima = i === visibles.length - 1;
								return (
									// Los pasos son fijos y solo se agregan al final.
									<tr
										key={i}
										className={`border-b border-[var(--color-borde)] transition-colors last:border-0 ${
											ultima ? "bg-[rgba(0,229,255,.12)]" : ""
										}`}
									>
										{paso.cells.map((celda, j) => (
											<td
												key={j}
												className={`jc-mono px-3 py-2 align-top sm:px-4 ${
													paso.hl === j
														? "font-bold text-[var(--color-magenta)]"
														: "text-[var(--color-tinta)]"
												}`}
											>
												{celda}
											</td>
										))}
									</tr>
								);
							})}

							{visibles.length === 0 && (
								<tr>
									<td
										colSpan={Math.max(columns.length, 1)}
										className="px-4 py-8 text-center text-sm text-[var(--color-tinta-2)]"
									>
										Dale a <strong>▶ Siguiente paso</strong> para ver la primera
										fila
									</td>
								</tr>
							)}
						</tbody>
					</table>
				</div>

				{/* Consola -------------------------------------------------------- */}
				<div className="overflow-hidden rounded-xl border border-[var(--color-borde)] bg-black/70">
					<div className="jc-mono border-b border-[var(--color-borde)] px-4 py-2 text-[0.62rem] tracking-[0.16em] text-[var(--color-tinta-2)] uppercase">
						▶ salida en pantalla
					</div>
					<pre className="jc-mono min-h-[5.5rem] overflow-x-auto px-4 py-3 text-[0.8rem] leading-[1.7] text-[#5ce87a] sm:text-[0.85rem]" style={{ whiteSpace: "pre-wrap" }}>
						{salida || (
							<span className="text-[var(--color-tinta-2)] opacity-60">
								(todavía no ha impreso nada)
							</span>
						)}
					</pre>
				</div>

				{termino && (
					<p className="jc-anim-pop inline-flex items-center gap-2 rounded-full border border-[rgba(52,224,122,.4)] bg-[rgba(52,224,122,.1)] px-4 py-1.5 text-sm font-semibold text-[var(--color-verde)]">
						🏁 Programa terminado
					</p>
				)}
			</div>
		</div>
	);
}
