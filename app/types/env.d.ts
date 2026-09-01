/**
 * Secretos que NO viven en wrangler.jsonc.
 *
 *  - Local  -> archivo .dev.vars (o .env)
 *  - Remoto -> npx wrangler secret put NOMBRE
 *
 * Este archivo se escribe a mano: `wrangler types` regenera
 * worker-configuration.d.ts y borraría estas líneas si estuvieran allí.
 */
interface Env {
	/** Usuario único del profesor */
	TEACHER_USERNAME: string;
	/** Contraseña del profesor */
	TEACHER_PASSWORD: string;
	/** Secreto de firma de cookies de Better Auth */
	BETTER_AUTH_SECRET: string;
}
