import { error } from "../../../lib/seguridad.js";
import { sesionValida } from "../../../lib/seguridad.js";

/**
 * Puerta del panel: todo lo que cuelga de /api/admin/ exige sesión, salvo el
 * propio login. Sin esto, cada endpoint tendría que acordarse de revisar.
 */
export async function onRequest(context) {
	const { request, env, next } = context;
	const ruta = new URL(request.url).pathname;

	if (ruta.endsWith("/login")) return next();

	if (!(await sesionValida(request, env.ADMIN_PASSWORD))) {
		return error("Sesión no válida. Vuelve a entrar.", 401);
	}

	return next();
}
