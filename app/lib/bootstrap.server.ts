import { verifyPassword } from "better-auth/crypto";
import { and, eq } from "drizzle-orm";
import { getDb, schema } from "~/db";
import { crearUsuario, setPasswordHash } from "./auth.server";

/**
 * Aprovisiona las cuentas base. Es idempotente y se llama desde el loader
 * de /login, así que no hay ningún paso manual extra ni en local ni en prod.
 *
 *  - Profesor: cuenta única definida por TEACHER_USERNAME / TEACHER_PASSWORD.
 *    Si cambias la contraseña en el .env / secret, aquí se resincroniza.
 *  - Estudiante demo: usuario `demo`, contraseña `demo123` (solo si no existe).
 */
export async function bootstrapUsuarios(env: Env, request: Request) {
	const db = getDb(env);

	const teacherUsername = (env.TEACHER_USERNAME || "").trim().toLowerCase();
	const teacherPassword = env.TEACHER_PASSWORD || "";

	if (teacherUsername && teacherPassword) {
		const [teacher] = await db
			.select({ id: schema.users.id, role: schema.users.role })
			.from(schema.users)
			.where(eq(schema.users.username, teacherUsername))
			.limit(1);

		if (!teacher) {
			const res = await crearUsuario(env, request, {
				name: "JuanCode",
				username: teacherUsername,
				password: teacherPassword,
				role: "teacher",
				mustChangePassword: false,
			});

			// Antes esto fallaba en silencio: el profe no se creaba y el login
			// decia "usuario o contrasena incorrectos" sin pista de por que.
			if (!res.ok) {
				console.error(
					`[bootstrap] no se pudo crear al profe "${teacherUsername}" ` +
						`(clave de ${teacherPassword.length} caracteres): ${res.error}`,
				);
			}
		} else {
			const [cuenta] = await db
				.select({ password: schema.accounts.password })
				.from(schema.accounts)
				.where(
					and(
						eq(schema.accounts.userId, teacher.id),
						eq(schema.accounts.providerId, "credential"),
					),
				)
				.limit(1);

			const coincide = cuenta?.password
				? await verifyPassword({
						password: teacherPassword,
						hash: cuenta.password,
					}).catch(() => false)
				: false;

			if (!coincide) await setPasswordHash(db, teacher.id, teacherPassword);
			if (teacher.role !== "teacher") {
				await db
					.update(schema.users)
					.set({ role: "teacher", mustChangePassword: false })
					.where(eq(schema.users.id, teacher.id));
			}
		}
	}

	const [demo] = await db
		.select({ id: schema.users.id })
		.from(schema.users)
		.where(eq(schema.users.username, "demo"))
		.limit(1);

	if (!demo) {
		await crearUsuario(env, request, {
			name: "Estudiante Demo",
			username: "demo",
			password: "demo123",
			role: "student",
			mustChangePassword: false,
		});
	}
}
