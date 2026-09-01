import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { hashPassword } from "better-auth/crypto";
import { username as usernamePlugin } from "better-auth/plugins/username";
import { and, eq } from "drizzle-orm";
import { redirect } from "react-router";
import { getDb, schema, type Db } from "~/db";
import type { User } from "~/db/schema";

/** Dominio interno: Better Auth exige un email, pero aquí se entra con usuario. */
export const EMAIL_DOMAIN = "libro.juancode.local";

export function emailFor(usuario: string) {
	return `${usuario.trim().toLowerCase()}@${EMAIL_DOMAIN}`;
}

export type Auth = ReturnType<typeof createAuth>;

export function createAuth(env: Env, request: Request) {
	const db = getDb(env);

	return betterAuth({
		appName: "El Libro JuanCode",
		baseURL: new URL(request.url).origin,
		secret:
			env.BETTER_AUTH_SECRET ||
			"dev-secret-solo-para-local-cambiar-en-produccion",
		telemetry: { enabled: false },
		database: drizzleAdapter(db, {
			provider: "sqlite",
			schema,
			usePlural: true,
			// D1 no soporta transacciones interactivas de Drizzle.
			transaction: false,
		}),
		emailAndPassword: {
			enabled: true,
			requireEmailVerification: false,
			minPasswordLength: 6,
			autoSignIn: false,
		},
		session: {
			expiresIn: 60 * 60 * 24 * 30, // 30 días
			updateAge: 60 * 60 * 24,
		},
		user: {
			additionalFields: {
				// Nunca se pueden setear desde el cliente: los fija el servidor.
				role: { type: "string", defaultValue: "student", input: false },
				mustChangePassword: {
					type: "boolean",
					defaultValue: false,
					input: false,
				},
			},
		},
		plugins: [usernamePlugin({ displayUsername: false, minUsernameLength: 3 })],
	});
}

/* -------------------------------------------------------------------------- */
/*  Sesión                                                                     */
/* -------------------------------------------------------------------------- */

export type SessionUser = Pick<
	User,
	"id" | "name" | "username" | "role" | "mustChangePassword"
>;

export async function getSessionUser(
	env: Env,
	request: Request,
): Promise<SessionUser | null> {
	const auth = createAuth(env, request);
	const session = await auth.api.getSession({ headers: request.headers });
	if (!session?.user) return null;

	// La fuente de verdad de role / mustChangePassword es la tabla users.
	const db = getDb(env);
	const [row] = await db
		.select({
			id: schema.users.id,
			name: schema.users.name,
			username: schema.users.username,
			role: schema.users.role,
			mustChangePassword: schema.users.mustChangePassword,
		})
		.from(schema.users)
		.where(eq(schema.users.id, session.user.id))
		.limit(1);

	return row ?? null;
}

/** Exige sesión. Redirige a /login (y a /cambiar-password si toca). */
export async function requireUser(
	env: Env,
	request: Request,
	{ allowPasswordChange = false }: { allowPasswordChange?: boolean } = {},
): Promise<SessionUser> {
	const user = await getSessionUser(env, request);
	const url = new URL(request.url);

	if (!user) {
		const next = url.pathname + url.search;
		throw redirect(
			`/login${next && next !== "/" ? `?next=${encodeURIComponent(next)}` : ""}`,
		);
	}

	if (user.mustChangePassword && !allowPasswordChange) {
		throw redirect("/cambiar-password");
	}

	return user;
}

/** Exige sesión de profesor. */
export async function requireTeacher(
	env: Env,
	request: Request,
): Promise<SessionUser> {
	const user = await requireUser(env, request);
	if (user.role !== "teacher") {
		throw redirect("/libro?toast=" + encodeURIComponent("Zona solo para el profe 🔒"));
	}
	return user;
}

/* -------------------------------------------------------------------------- */
/*  Utilidades de contraseña / creación de usuarios                            */
/* -------------------------------------------------------------------------- */

/** Reescribe el hash de la cuenta 'credential' de un usuario. */
export async function setPasswordHash(
	db: Db,
	userId: string,
	plainPassword: string,
) {
	const hash = await hashPassword(plainPassword);
	const updated = await db
		.update(schema.accounts)
		.set({ password: hash, updatedAt: new Date() })
		.where(
			and(
				eq(schema.accounts.userId, userId),
				eq(schema.accounts.providerId, "credential"),
			),
		)
		.returning({ id: schema.accounts.id });

	if (updated.length === 0) {
		const now = new Date();
		await db.insert(schema.accounts).values({
			id: crypto.randomUUID(),
			userId,
			accountId: userId,
			providerId: "credential",
			issuer: "local:credential",
			password: hash,
			createdAt: now,
			updatedAt: now,
		});
	}
}

export type CrearUsuarioInput = {
	name: string;
	username: string;
	password: string;
	role?: "teacher" | "student";
	mustChangePassword?: boolean;
};

/**
 * Crea un usuario usando Better Auth (para que el hash lo genere la librería)
 * y luego fija en la BD los campos que el servidor controla.
 */
export async function crearUsuario(
	env: Env,
	request: Request,
	input: CrearUsuarioInput,
): Promise<{ ok: true; userId: string } | { ok: false; error: string }> {
	const auth = createAuth(env, request);
	const db = getDb(env);
	const usuario = input.username.trim().toLowerCase();

	const [existente] = await db
		.select({ id: schema.users.id })
		.from(schema.users)
		.where(eq(schema.users.username, usuario))
		.limit(1);

	if (existente) return { ok: false, error: "Ese usuario ya existe." };

	try {
		const res = await auth.api.signUpEmail({
			body: {
				name: input.name.trim(),
				email: emailFor(usuario),
				password: input.password,
				username: usuario,
			} as never,
		});

		const userId = (res as { user?: { id?: string } })?.user?.id;
		if (!userId) return { ok: false, error: "No se pudo crear el usuario." };

		await db
			.update(schema.users)
			.set({
				role: input.role ?? "student",
				mustChangePassword: input.mustChangePassword ?? false,
				emailVerified: true,
				updatedAt: new Date(),
			})
			.where(eq(schema.users.id, userId));

		return { ok: true, userId };
	} catch (error) {
		const message =
			error instanceof Error ? error.message : "Error creando el usuario.";
		return { ok: false, error: message };
	}
}

/** Inicia sesión por usuario/contraseña y devuelve las cookies a enviar. */
export async function iniciarSesion(
	env: Env,
	request: Request,
	usuario: string,
	password: string,
): Promise<{ ok: true; headers: Headers } | { ok: false; error: string }> {
	const auth = createAuth(env, request);
	try {
		const res = await auth.api.signInUsername({
			body: { username: usuario.trim().toLowerCase(), password },
			asResponse: true,
		});

		if (!res.ok) return { ok: false, error: "Usuario o contraseña incorrectos." };

		const headers = new Headers();
		for (const cookie of res.headers.getSetCookie()) {
			headers.append("Set-Cookie", cookie);
		}
		return { ok: true, headers };
	} catch {
		return { ok: false, error: "Usuario o contraseña incorrectos." };
	}
}

/** Cierra la sesión actual y devuelve las cookies de borrado. */
export async function cerrarSesion(env: Env, request: Request) {
	const auth = createAuth(env, request);
	const headers = new Headers();
	try {
		const res = await auth.api.signOut({
			headers: request.headers,
			asResponse: true,
		});
		for (const cookie of res.headers.getSetCookie()) {
			headers.append("Set-Cookie", cookie);
		}
	} catch {
		// sesión ya inválida: no pasa nada
	}
	return headers;
}
