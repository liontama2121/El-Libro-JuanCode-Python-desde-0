import { and, eq, gte, sql } from "drizzle-orm";
import { type Db, schema } from "~/db";

/* -------------------------------------------------------------------------- */
/*  Modo Código — ejecuta Python de verdad contra los tests del ejercicio      */
/* -------------------------------------------------------------------------- */

const PISTON_POR_DEFECTO = "https://emkc.org/api/v2/piston/execute";
const LENGUAJE = "python";
const VERSION = "3.10.0";

/** Se corta la ejecución a los 10 s. */
const TIMEOUT_MS = 10_000;

/** Tope por estudiante para no quemar la cuota pública de Piston. */
export const LIMITE_POR_MINUTO = 20;

export type Test = { stdin: string; expected_output: string };

export type ResultadoTest = {
	n: number;
	stdin: string;
	esperado: string;
	obtenido: string;
	paso: boolean;
	error: string | null;
};

export type Ejecucion = {
	ok: boolean;
	/** Todos los tests en verde */
	passed: boolean;
	resultados: ResultadoTest[];
	/** Motivo por el que ni siquiera se pudo correr */
	error: string | null;
};

export function modoCodigoActivo(env: Env) {
	return String(env.CODE_MODE_ENABLED ?? "").toLowerCase() === "true";
}

function urlPiston(env: Env) {
	return env.PISTON_URL || PISTON_POR_DEFECTO;
}

/**
 * Normaliza la salida antes de comparar: se ignoran los espacios al final de
 * cada línea y los saltos sobrantes al principio y al final. Un estudiante no
 * debería perder un punto por un enter de más.
 */
export function normalizar(texto: string) {
	return texto
		.replace(/\r\n/g, "\n")
		.split("\n")
		.map((l) => l.replace(/\s+$/, ""))
		.join("\n")
		.trim();
}

export function leerTests(json: string | null): Test[] {
	if (!json) return [];
	try {
		const crudo = JSON.parse(json);
		if (!Array.isArray(crudo)) return [];
		return crudo.map((t) => ({
			stdin: String(t?.stdin ?? ""),
			expected_output: String(t?.expected_output ?? ""),
		}));
	} catch {
		return [];
	}
}

/** ¿Este estudiante ya gastó sus ejecuciones del minuto? */
export async function pasoElLimite(db: Db, userId: string) {
	const desde = new Date(Date.now() - 60_000);
	const [{ n }] = await db
		.select({ n: sql<number>`count(*)` })
		.from(schema.codeRuns)
		.where(
			and(eq(schema.codeRuns.userId, userId), gte(schema.codeRuns.createdAt, desde)),
		);
	return Number(n) >= LIMITE_POR_MINUTO;
}

async function ejecutarUno(env: Env, codigo: string, stdin: string) {
	const control = new AbortController();
	const corte = setTimeout(() => control.abort(), TIMEOUT_MS);

	try {
		const res = await fetch(urlPiston(env), {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			signal: control.signal,
			body: JSON.stringify({
				language: LENGUAJE,
				version: VERSION,
				files: [{ name: "main.py", content: codigo }],
				stdin,
				run_timeout: TIMEOUT_MS,
				compile_timeout: TIMEOUT_MS,
			}),
		});

		if (!res.ok) {
			// Desde el 15/02/2026 la instancia pública de Piston es solo por lista
			// blanca: si sale 401/403 hay que apuntar PISTON_URL a una propia.
			const aviso =
				res.status === 401 || res.status === 403
					? "El motor de Python rechazó la petición. La instancia pública de Piston es solo por lista blanca: monta la tuya y ponla en PISTON_URL."
					: `El motor respondió ${res.status}.`;
			return { salida: "", error: aviso };
		}

		const datos = (await res.json()) as {
			run?: { stdout?: string; stderr?: string; output?: string; code?: number };
			message?: string;
		};

		if (datos.message) return { salida: "", error: datos.message };

		const run = datos.run ?? {};
		const stderr = (run.stderr ?? "").trim();
		return {
			salida: run.stdout ?? run.output ?? "",
			// stderr con código 0 suele ser un warning: no se trata como error
			error: stderr && run.code !== 0 ? stderr : null,
		};
	} catch (e) {
		const abortado = e instanceof Error && e.name === "AbortError";
		return {
			salida: "",
			error: abortado
				? "Se pasó de los 10 segundos. ¿Hay un ciclo infinito?"
				: "No se pudo contactar el motor de Python.",
		};
	} finally {
		clearTimeout(corte);
	}
}

/**
 * Corre el código contra cada test y guarda el intento.
 * Siempre en el servidor: el estudiante nunca ejecuta nada del profesor.
 */
export async function correrTests(
	env: Env,
	db: Db,
	{
		userId,
		exerciseId,
		codigo,
		tests,
	}: { userId: string; exerciseId: number | null; codigo: string; tests: Test[] },
): Promise<Ejecucion> {
	if (!modoCodigoActivo(env)) {
		return {
			ok: false,
			passed: false,
			resultados: [],
			error: "El Modo Código está apagado (CODE_MODE_ENABLED).",
		};
	}
	if (!codigo.trim()) {
		return { ok: false, passed: false, resultados: [], error: "No escribiste código." };
	}
	if (tests.length === 0) {
		return {
			ok: false,
			passed: false,
			resultados: [],
			error: "Este ejercicio todavía no tiene casos de prueba.",
		};
	}
	if (await pasoElLimite(db, userId)) {
		return {
			ok: false,
			passed: false,
			resultados: [],
			error: `Vas muy rápido: máximo ${LIMITE_POR_MINUTO} ejecuciones por minuto. Espera un momento.`,
		};
	}

	const resultados: ResultadoTest[] = [];
	for (const [i, test] of tests.entries()) {
		const { salida, error } = await ejecutarUno(env, codigo, test.stdin);
		const obtenido = normalizar(salida);
		const esperado = normalizar(test.expected_output);
		resultados.push({
			n: i + 1,
			stdin: test.stdin,
			esperado,
			obtenido,
			paso: !error && obtenido === esperado,
			error,
		});
	}

	const passed = resultados.every((r) => r.paso);

	await db.insert(schema.codeRuns).values({
		userId,
		exerciseId,
		code: codigo,
		passed,
		resultsJson: JSON.stringify(resultados),
	});

	return { ok: true, passed, resultados, error: null };
}
