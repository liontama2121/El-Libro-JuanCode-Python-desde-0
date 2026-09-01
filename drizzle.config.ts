import { defineConfig } from "drizzle-kit";

/**
 * Solo se usa para GENERAR migraciones (`npm run db:generate`).
 * Las migraciones se aplican con `wrangler d1 migrations apply` (ver scripts).
 */
export default defineConfig({
	out: "./drizzle",
	schema: "./app/db/schema.ts",
	dialect: "sqlite",
});
