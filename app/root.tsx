import {
	isRouteErrorResponse,
	Links,
	Meta,
	Outlet,
	Scripts,
	ScrollRestoration,
} from "react-router";

import type { Route } from "./+types/root";
import "./app.css";
import { Logo } from "./components/nav";

export const links: Route.LinksFunction = () => [
	{
		rel: "preload",
		href: "/fonts/archivo-latin.woff2",
		as: "font",
		type: "font/woff2",
		crossOrigin: "anonymous",
	},
];

export const meta: Route.MetaFunction = () => [
	{ title: "El Libro JuanCode — Python desde 0" },
	{
		name: "description",
		content:
			"Libro digital interactivo para aprender Python desde cero, capítulo a capítulo, con quiz para desbloquear el siguiente.",
	},
];

export function Layout({ children }: { children: React.ReactNode }) {
	return (
		<html lang="es">
			<head>
				<meta charSet="utf-8" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta name="theme-color" content="#05070b" />
				<Meta />
				<Links />
			</head>
			<body>
				{children}
				<ScrollRestoration />
				<Scripts />
			</body>
		</html>
	);
}

export default function App() {
	return <Outlet />;
}

export function ErrorBoundary({ error }: Route.ErrorBoundaryProps) {
	let titulo = "Algo se rompió";
	let detalle = "Ocurrió un error inesperado.";
	let stack: string | undefined;

	if (isRouteErrorResponse(error)) {
		titulo = error.status === 404 ? "404" : `Error ${error.status}`;
		detalle =
			error.status === 404
				? "Esta página no existe en el libro."
				: error.statusText || detalle;
	} else if (import.meta.env.DEV && error instanceof Error) {
		detalle = error.message;
		stack = error.stack;
	}

	return (
		<main className="mx-auto flex min-h-dvh max-w-2xl flex-col items-center justify-center gap-5 px-6 text-center">
			<Logo size="lg" />
			<h1 className="jc-display text-6xl">{titulo}</h1>
			<p className="text-[var(--color-tinta-2)]">{detalle}</p>
			<a className="jc-btn jc-btn-primary" href="/libro">
				Volver al libro
			</a>
			{stack && (
				<pre className="jc-mono w-full overflow-x-auto rounded-xl border border-[var(--color-borde)] bg-black/50 p-4 text-left text-xs">
					<code>{stack}</code>
				</pre>
			)}
		</main>
	);
}
