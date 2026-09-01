import { useEffect, useState } from "react";
import { BloqueCodigo } from "~/components/ui";
import type { PreguntaPublica, Respuesta } from "~/lib/bank.server";

/* -------------------------------------------------------------------------- */
/*  Etiquetas                                                                  */
/* -------------------------------------------------------------------------- */

export const NOMBRE_TIPO: Record<string, string> = {
	mcq: "Opción múltiple",
	predict_output: "¿Qué imprime?",
	find_bug: "Caza el bug",
	parsons: "Arma el código",
};

export const EMOJI_TIPO: Record<string, string> = {
	mcq: "❓",
	predict_output: "⚡",
	find_bug: "🕵️",
	parsons: "🧩",
};

/* -------------------------------------------------------------------------- */
/*  Pregunta                                                                   */
/* -------------------------------------------------------------------------- */

export type CorreccionUI = {
	acerto: boolean;
	correcta: unknown;
	explanation: string;
};

/**
 * Dibuja una pregunta del banco y devuelve la respuesta del estudiante.
 * No sabe nada de la respuesta correcta hasta que el servidor manda
 * `correccion` (después de calificar).
 */
export function Pregunta({
	pregunta,
	respuesta,
	onRespuesta,
	correccion,
}: {
	pregunta: PreguntaPublica;
	respuesta: Respuesta;
	onRespuesta: (r: Respuesta) => void;
	correccion?: CorreccionUI | null;
}) {
	const bloqueada = Boolean(correccion);

	return (
		<div className="space-y-5">
			<div className="flex flex-wrap items-center gap-2">
				<span className="jc-badge text-[var(--color-cyan)]">
					{EMOJI_TIPO[pregunta.type]} {NOMBRE_TIPO[pregunta.type] ?? pregunta.type}
				</span>
				<span className={`jc-badge jc-badge-${pregunta.difficulty}`}>
					{pregunta.difficulty}
				</span>
			</div>

			<h2 className="jc-display text-xl leading-snug sm:text-2xl">
				{pregunta.prompt}
			</h2>

			{pregunta.codeSnippet && pregunta.type !== "find_bug" && (
				<BloqueCodigo codigo={pregunta.codeSnippet} />
			)}

			{(pregunta.type === "mcq" || pregunta.type === "predict_output") && (
				<Opciones
					pregunta={pregunta}
					respuesta={respuesta}
					onRespuesta={onRespuesta}
					correccion={correccion}
					bloqueada={bloqueada}
				/>
			)}

			{pregunta.type === "find_bug" && (
				<Lineas
					pregunta={pregunta}
					respuesta={respuesta}
					onRespuesta={onRespuesta}
					correccion={correccion}
					bloqueada={bloqueada}
				/>
			)}

			{pregunta.type === "parsons" && (
				<Parsons
					pregunta={pregunta}
					respuesta={respuesta}
					onRespuesta={onRespuesta}
					correccion={correccion}
					bloqueada={bloqueada}
				/>
			)}

			{correccion && <Explicacion correccion={correccion} pregunta={pregunta} />}
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  mcq · predict_output                                                       */
/* -------------------------------------------------------------------------- */

type SubProps = {
	pregunta: PreguntaPublica;
	respuesta: Respuesta;
	onRespuesta: (r: Respuesta) => void;
	correccion?: CorreccionUI | null;
	bloqueada: boolean;
};

function Opciones({ pregunta, respuesta, onRespuesta, correccion, bloqueada }: SubProps) {
	const marcada = (respuesta as { option_id?: string } | null)?.option_id;
	const correcta = correccion?.correcta as string | undefined;

	return (
		<div className="space-y-3">
			{(pregunta.opciones ?? []).map((op, i) => {
				const activa = marcada === op.id;
				const esCorrecta = bloqueada && correcta === op.id;
				const esErrorTuyo = bloqueada && activa && correcta !== op.id;

				return (
					<button
						key={op.id}
						type="button"
						disabled={bloqueada}
						onClick={() => onRespuesta({ option_id: op.id })}
						className={`flex w-full items-start gap-3 rounded-2xl border p-4 text-left transition ${
							esCorrecta
								? "border-[rgba(52,224,122,.6)] bg-[rgba(52,224,122,.1)]"
								: esErrorTuyo
									? "border-[rgba(255,77,255,.6)] bg-[rgba(255,77,255,.08)]"
									: activa
										? "border-[rgba(0,229,255,.6)] bg-[rgba(0,229,255,.09)]"
										: "border-[var(--color-borde)] bg-white/[0.03] hover:border-white/25 hover:bg-white/[0.06]"
						} ${bloqueada ? "cursor-default" : ""}`}
					>
						<span
							className={`jc-mono grid h-7 w-7 shrink-0 place-items-center rounded-lg border text-xs uppercase ${
								activa || esCorrecta
									? "border-transparent bg-[var(--color-cyan)] text-[#08131a]"
									: "border-[var(--color-borde)] text-[var(--color-tinta-2)]"
							}`}
						>
							{op.id || String.fromCharCode(97 + i)}
						</span>
						<span className="flex-1 whitespace-pre-wrap">{op.text}</span>
						{esCorrecta && <span aria-hidden="true">✅</span>}
						{esErrorTuyo && <span aria-hidden="true">❌</span>}
					</button>
				);
			})}
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  find_bug — se toca la línea del error                                      */
/* -------------------------------------------------------------------------- */

function Lineas({ pregunta, respuesta, onRespuesta, correccion, bloqueada }: SubProps) {
	const marcada = (respuesta as { line_number?: number } | null)?.line_number;
	const correcta = correccion?.correcta as number | undefined;

	return (
		<div className="overflow-hidden rounded-xl border border-[var(--color-borde)] bg-black/60">
			{(pregunta.lineas ?? []).map((texto, i) => {
				const n = i + 1;
				const activa = marcada === n;
				const esCorrecta = bloqueada && correcta === n;
				const esErrorTuyo = bloqueada && activa && correcta !== n;

				return (
					<button
						key={n}
						type="button"
						disabled={bloqueada}
						onClick={() => onRespuesta({ line_number: n })}
						className={`jc-mono flex w-full items-start gap-3 px-3 py-1.5 text-left text-[0.82rem] leading-relaxed transition sm:text-sm ${
							esCorrecta
								? "bg-[rgba(52,224,122,.16)]"
								: esErrorTuyo
									? "bg-[rgba(255,77,255,.14)]"
									: activa
										? "bg-[rgba(0,229,255,.14)]"
										: "hover:bg-white/5"
						} ${bloqueada ? "cursor-default" : ""}`}
					>
						<span className="w-6 shrink-0 select-none text-right text-[var(--color-tinta-2)]">
							{n}
						</span>
						<span className="flex-1 whitespace-pre text-[#d7dcff]">{texto || " "}</span>
						{esCorrecta && <span aria-hidden="true">🐛</span>}
					</button>
				);
			})}
			{!bloqueada && (
				<p className="border-t border-[var(--color-borde)] px-3 py-2 text-xs text-[var(--color-tinta-2)]">
					Toca la línea donde está el error.
				</p>
			)}
		</div>
	);
}

/* -------------------------------------------------------------------------- */
/*  parsons — ordenar líneas y darles la indentación correcta                  */
/* -------------------------------------------------------------------------- */

type Pieza = { id: string; text: string; indent: number };

function Parsons({ pregunta, respuesta, onRespuesta, correccion, bloqueada }: SubProps) {
	const piezasIniciales: Pieza[] = (pregunta.piezas ?? []).map((p) => ({
		...p,
		indent: 0,
	}));

	const [orden, setOrden] = useState<Pieza[]>(
		(respuesta as { order?: Pieza[] } | null)?.order?.length
			? ((respuesta as { order: Pieza[] }).order.map((o) => ({
					...o,
					text: piezasIniciales.find((p) => p.id === o.id)?.text ?? "",
				})) as Pieza[])
			: piezasIniciales,
	);
	const [arrastrando, setArrastrando] = useState<number | null>(null);

	/* Al cambiar de pregunta se vuelve a empezar con sus piezas. El orden que
	   se entrega YA es una respuesta válida (mala, pero válida), así que se
	   reporta de una: si no, el botón de responder nunca se habilitaría para
	   quien crea que el orden dado es el correcto. */
	useEffect(() => {
		setOrden(piezasIniciales);
		if (!bloqueada) {
			onRespuesta({
				order: piezasIniciales.map((p) => ({ id: p.id, indent: p.indent })),
			});
		}
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [pregunta.id]);

	const aplicar = (siguiente: Pieza[]) => {
		setOrden(siguiente);
		onRespuesta({ order: siguiente.map((p) => ({ id: p.id, indent: p.indent })) });
	};

	const mover = (i: number, delta: number) => {
		const j = i + delta;
		if (j < 0 || j >= orden.length) return;
		const copia = [...orden];
		[copia[i], copia[j]] = [copia[j], copia[i]];
		aplicar(copia);
	};

	const indentar = (i: number, delta: number) => {
		const copia = [...orden];
		copia[i] = { ...copia[i], indent: Math.max(0, Math.min(4, copia[i].indent + delta)) };
		aplicar(copia);
	};

	const soltarEn = (destino: number) => {
		if (arrastrando === null || arrastrando === destino) return;
		const copia = [...orden];
		const [pieza] = copia.splice(arrastrando, 1);
		copia.splice(destino, 0, pieza);
		setArrastrando(null);
		aplicar(copia);
	};

	const solucion = correccion?.correcta as Pieza[] | undefined;

	return (
		<div className="space-y-4">
			<p className="text-sm text-[var(--color-tinta-2)]">
				Ordena las líneas y dales su indentación. En escritorio puedes arrastrarlas;
				en el celular usa ↑ ↓ para el orden y → ← para meter o sacar el bloque.
			</p>

			<ol className="space-y-2">
				{orden.map((pieza, i) => (
					<li
						key={pieza.id}
						draggable={!bloqueada}
						onDragStart={() => setArrastrando(i)}
						onDragOver={(e) => e.preventDefault()}
						onDrop={() => soltarEn(i)}
						className={`flex items-stretch gap-2 rounded-xl border bg-black/40 p-2 transition ${
							arrastrando === i
								? "border-[rgba(0,229,255,.6)]"
								: "border-[var(--color-borde)]"
						}`}
					>
						<span className="jc-mono grid w-6 shrink-0 place-items-center text-xs text-[var(--color-tinta-2)]">
							{i + 1}
						</span>

						<code
							className="jc-mono flex-1 self-center whitespace-pre text-[0.82rem] text-[#d7dcff] sm:text-sm"
							style={{ paddingLeft: `${pieza.indent * 1.6}rem` }}
						>
							{pieza.text}
						</code>

						{!bloqueada && (
							<span className="flex shrink-0 items-center gap-1">
								<BotonPieza etiqueta="Subir" onClick={() => mover(i, -1)}>
									↑
								</BotonPieza>
								<BotonPieza etiqueta="Bajar" onClick={() => mover(i, 1)}>
									↓
								</BotonPieza>
								<BotonPieza etiqueta="Sacar del bloque" onClick={() => indentar(i, -1)}>
									←
								</BotonPieza>
								<BotonPieza etiqueta="Meter en el bloque" onClick={() => indentar(i, 1)}>
									→
								</BotonPieza>
							</span>
						)}
					</li>
				))}
			</ol>

			{bloqueada && solucion && (
				<div>
					<p className="jc-mono mb-2 text-xs tracking-[0.18em] text-[var(--color-verde)] uppercase">
						así iba
					</p>
					<pre className="jc-mono overflow-x-auto rounded-xl border border-[rgba(52,224,122,.35)] bg-black/60 p-4 text-sm text-[#d7dcff]">
						<code>
							{solucion.map((l) => `${"    ".repeat(l.indent)}${l.text}`).join("\n")}
						</code>
					</pre>
				</div>
			)}
		</div>
	);
}

function BotonPieza({
	children,
	etiqueta,
	onClick,
}: {
	children: React.ReactNode;
	etiqueta: string;
	onClick: () => void;
}) {
	return (
		<button
			type="button"
			aria-label={etiqueta}
			title={etiqueta}
			onClick={onClick}
			className="grid h-8 w-8 place-items-center rounded-lg border border-[var(--color-borde)]
				bg-white/5 text-sm text-[var(--color-tinta-2)] transition hover:border-[rgba(0,229,255,.5)]
				hover:text-[var(--color-cyan)]"
		>
			{children}
		</button>
	);
}

/* -------------------------------------------------------------------------- */
/*  Explicación                                                                */
/* -------------------------------------------------------------------------- */

function Explicacion({
	correccion,
	pregunta,
}: {
	correccion: CorreccionUI;
	pregunta: PreguntaPublica;
}) {
	const textoCorrecto =
		pregunta.type === "find_bug"
			? `El error está en la línea ${correccion.correcta}.`
			: null;

	return (
		<div
			className={`rounded-2xl border p-5 ${
				correccion.acerto
					? "border-[rgba(52,224,122,.4)] bg-[rgba(52,224,122,.07)]"
					: "border-[rgba(255,169,77,.4)] bg-[rgba(255,169,77,.07)]"
			}`}
		>
			<p className="jc-display text-lg">
				{correccion.acerto ? "✅ Correcto" : "❌ Casi"}
			</p>
			{textoCorrecto && !correccion.acerto && (
				<p className="mt-1 text-sm text-[var(--color-tinta-2)]">{textoCorrecto}</p>
			)}
			{correccion.explanation && (
				<p className="mt-2 text-[0.95rem] leading-relaxed text-[var(--color-tinta-2)]">
					{correccion.explanation}
				</p>
			)}
		</div>
	);
}
