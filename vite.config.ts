import { reactRouter } from "@react-router/dev/vite";
import { cloudflare } from "@cloudflare/vite-plugin";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

// Dependencias del servidor que se pre-empaquetan al arrancar `npm run dev`.
// Si no se declaran, Vite las descubre a mitad del primer render de SSR,
// vuelve a optimizar y esa primera petición falla con "Invalid hook call".
const SSR_DEPS = [
	"isbot",
	"react",
	"react-dom",
	"react-dom/server",
	"react-router",
	"better-auth",
	"better-auth/crypto",
	"better-auth/adapters/drizzle",
	"better-auth/plugins/username",
	"drizzle-orm",
	"drizzle-orm/d1",
	"drizzle-orm/sqlite-core",
];

export default defineConfig({
	plugins: [
		cloudflare({ viteEnvironment: { name: "ssr" } }),
		tailwindcss(),
		reactRouter(),
		tsconfigPaths(),
	],
	environments: {
		ssr: {
			optimizeDeps: { include: SSR_DEPS },
		},
	},
});
