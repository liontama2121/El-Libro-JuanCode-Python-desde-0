import { and, asc, eq, type SQL } from "drizzle-orm";
import { getDb, schema } from "~/db";
import { requireTeacher } from "~/lib/auth.server";
import { parse } from "~/lib/bank.server";
import type { Route } from "./+types/admin.banco.export";

/**
 * Ruta de recurso (sin componente): descarga el banco filtrado como JSON,
 * con el mismo formato que acepta la importación y que usa
 * `content/bank/NN.json`.
 *
 * Va aparte de /admin/banco porque una ruta con componente no puede devolver
 * un archivo: React Router espera datos del loader, no una Response.
 */
export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;
	await requireTeacher(env, request);
	const db = getDb(env);

	const url = new URL(request.url);
	const cap = Number(url.searchParams.get("cap")) || 0;
	const tipo = url.searchParams.get("tipo") || "";
	const dif = url.searchParams.get("dif") || "";

	const condiciones: SQL[] = [];
	if (cap) condiciones.push(eq(schema.questionBank.chapterId, cap));
	if (tipo) condiciones.push(eq(schema.questionBank.type, tipo));
	if (dif) condiciones.push(eq(schema.questionBank.difficulty, dif));

	const [capitulos, preguntas] = await Promise.all([
		db
			.select({ id: schema.chapters.id, number: schema.chapters.number })
			.from(schema.chapters),
		db
			.select()
			.from(schema.questionBank)
			.where(condiciones.length ? and(...condiciones) : undefined)
			.orderBy(asc(schema.questionBank.chapterId), asc(schema.questionBank.id)),
	]);

	const porId = new Map(capitulos.map((c) => [c.id, c.number]));
	const salida = preguntas.map((q) => ({
		chapter_number: porId.get(q.chapterId),
		type: q.type,
		difficulty: q.difficulty,
		prompt: q.prompt,
		code_snippet: q.codeSnippet,
		data: parse(q.dataJson),
		correct: parse(q.correctJson),
		explanation: q.explanation,
		active: q.active,
	}));

	const nombre = cap ? `banco-cap-${porId.get(cap) ?? cap}.json` : "banco.json";

	return new Response(JSON.stringify(salida, null, 2), {
		headers: {
			"Content-Type": "application/json; charset=utf-8",
			"Content-Disposition": `attachment; filename="${nombre}"`,
		},
	});
}
