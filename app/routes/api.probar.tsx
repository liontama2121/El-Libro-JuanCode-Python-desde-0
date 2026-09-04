import { eq } from "drizzle-orm";
import { getDb, schema } from "~/db";
import { requireUser } from "~/lib/auth.server";
import { correrTests, leerTests, modoCodigoActivo } from "~/lib/piston.server";
import { cargarCapitulosVisibles } from "~/lib/progress.server";
import type { Route } from "./+types/api.probar";

/**
 * Ruta de recurso del Modo Código: recibe el código del estudiante y lo corre
 * contra los tests del ejercicio.
 *
 * Los tests SIEMPRE se leen de la base: el cliente manda el id del ejercicio y
 * su código, nunca los casos de prueba ni la salida esperada.
 */
export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request);
	const db = getDb(env);

	if (!modoCodigoActivo(env)) {
		return {
			ok: false as const,
			passed: false,
			resultados: [],
			error: "El Modo Código está apagado por ahora.",
		};
	}

	const form = await request.formData();
	const exerciseId = Number(form.get("exerciseId"));
	const codigo = String(form.get("codigo") || "");

	const [ejercicio] = await db
		.select()
		.from(schema.exercises)
		.where(eq(schema.exercises.id, exerciseId))
		.limit(1);

	if (!ejercicio) {
		return {
			ok: false as const,
			passed: false,
			resultados: [],
			error: "Ese ejercicio no existe.",
		};
	}

	// Solo se puede probar código de capítulos que el estudiante tenga abiertos.
	const capitulos = await cargarCapitulosVisibles(
		db,
		user.id,
		user.role === "teacher",
		user.track,
	);
	const capitulo = capitulos.find((c) => c.id === ejercicio.chapterId);
	if (!capitulo || capitulo.estado === "bloqueado") {
		return {
			ok: false as const,
			passed: false,
			resultados: [],
			error: "Ese capítulo todavía está bloqueado.",
		};
	}

	return correrTests(env, db, {
		userId: user.id,
		exerciseId: ejercicio.id,
		codigo,
		tests: leerTests(ejercicio.testsJson),
	});
}

export async function loader() {
	return new Response("Method not allowed", { status: 405 });
}
