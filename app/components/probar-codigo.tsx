import { useEffect, useState } from "react";
import { useFetcher } from "react-router";
import { EditorCodigo } from "~/components/editor";

export type ResultadoTest = {
	n: number;
	stdin: string;
	esperado: string;
	obtenido: string;
	paso: boolean;
	error: string | null;
};

export type RespuestaProbar = {
	ok: boolean;
	passed: boolean;
	resultados: ResultadoTest[];
	error: string | null;
};

/**
 * Editor + "▶ Probar mi código". Manda el código a /api/probar, que lo corre
 * en el servidor contra los tests guardados del ejercicio y devuelve el
 * resultado de cada caso.
 */
export function ProbarCodigo({
	exerciseId,
	codigoInicial = "",
	etiqueta = "Tu código",
	filas = 12,
	onResultado,
	valor,
	onCambio,
}: {
	exerciseId: number;
	codigoInicial?: string;
	etiqueta?: string;
	filas?: number;
	/** Avisa al padre si el ejercicio quedó en verde (lo usa el parcial) */
	onResultado?: (passed: boolean) => void;
	/** Si el padre quiere quedarse con el código (parcial), lo controla él */
	valor?: string;
	onCambio?: (v: string) => void;
}) {
	const fetcher = useFetcher<RespuestaProbar>();
	const [propio, setPropio] = useState(codigoInicial);

	const controlado = valor !== undefined;
	const codigo = controlado ? valor : propio;
	const setCodigo = (v: string) => (controlado ? onCambio?.(v) : setPropio(v));

	const corriendo = fetcher.state !== "idle";
	const datos = fetcher.data;

	useEffect(() => {
		if (datos?.ok) onResultado?.(datos.passed);
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [datos]);

	const probar = () =>
		fetcher.submit(
			{ exerciseId: String(exerciseId), codigo },
			{ method: "post", action: "/api/probar" },
		);

	return (
		<div className="space-y-4">
			<EditorCodigo
				etiqueta={etiqueta}
				valor={codigo}
				onCambio={setCodigo}
				filas={filas}
			/>

			<div className="flex flex-wrap items-center gap-3">
				<button
					type="button"
					className="jc-btn jc-btn-primary"
					onClick={probar}
					disabled={corriendo}
				>
					{corriendo ? "Corriendo…" : "▶ Probar mi código"}
				</button>

				{datos?.ok && (
					<span
						className={`jc-mono text-sm ${
							datos.passed ? "text-[var(--color-verde)]" : "text-[var(--color-naranja)]"
						}`}
					>
						{datos.resultados.filter((r) => r.paso).length}/{datos.resultados.length} tests
						{datos.passed ? " ✅" : ""}
					</span>
				)}
			</div>

			{datos?.error && (
				<p className="rounded-xl border border-[color-mix(in_srgb,var(--color-naranja)_40%,transparent)] bg-[color-mix(in_srgb,var(--color-naranja)_8%,transparent)] px-4 py-2 text-sm text-[var(--color-naranja)]">
					{datos.error}
				</p>
			)}

			{datos?.resultados && datos.resultados.length > 0 && (
				<ol className="space-y-3">
					{datos.resultados.map((r) => (
						<li
							key={r.n}
							className={`rounded-2xl border p-4 ${
								r.paso
									? "border-[color-mix(in_srgb,var(--color-verde)_40%,transparent)] bg-[color-mix(in_srgb,var(--color-verde)_6%,transparent)]"
									: "border-[color-mix(in_srgb,var(--color-magenta)_35%,transparent)] bg-[color-mix(in_srgb,var(--color-magenta)_5%,transparent)]"
							}`}
						>
							<p className="jc-mono text-xs">
								{r.paso ? "✅" : "❌"} Caso {r.n}
							</p>

							{r.error ? (
								<pre className="jc-mono mt-2 overflow-x-auto text-xs text-[var(--color-magenta)]">
									<code>{r.error}</code>
								</pre>
							) : (
								!r.paso && (
									<div className="mt-3 grid gap-3 sm:grid-cols-2">
										<Bloque titulo="esperaba" texto={r.esperado} />
										<Bloque titulo="salió" texto={r.obtenido || "(nada)"} />
									</div>
								)
							)}

							{r.stdin && (
								<p className="jc-mono mt-2 text-[0.68rem] text-[var(--color-tinta-2)]">
									entrada: {r.stdin.replace(/\n/g, " ⏎ ")}
								</p>
							)}
						</li>
					))}
				</ol>
			)}
		</div>
	);
}

function Bloque({ titulo, texto }: { titulo: string; texto: string }) {
	return (
		<div>
			<p className="jc-mono text-[0.62rem] tracking-[0.16em] text-[var(--color-tinta-2)] uppercase">
				{titulo}
			</p>
			<pre className="jc-mono mt-1 overflow-x-auto rounded-lg border border-[var(--color-borde)] bg-codigo p-3 text-xs text-[#d7dcff]">
				<code>{texto}</code>
			</pre>
		</div>
	);
}
