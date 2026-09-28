import { eq } from "drizzle-orm";
import { useState } from "react";
import { Form, redirect, useNavigation } from "react-router";
import { ArrowRight } from "@phosphor-icons/react";
import { Muro } from "~/components/muro";
import { Logo } from "~/components/nav";
import { getDb, schema } from "~/db";
import { getSessionUser, iniciarSesion } from "~/lib/auth.server";
import { bootstrapUsuarios } from "~/lib/bootstrap.server";
import type { Route } from "./+types/login";

export const meta: Route.MetaFunction = () => [
	{ title: "Entrar — El Libro JuanCode" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const env = context.cloudflare.env;

	// Aprovisiona profe (desde .env) y estudiante demo. Idempotente.
	await bootstrapUsuarios(env, request);

	const user = await getSessionUser(env, request);
	if (user) {
		if (user.mustChangePassword) throw redirect("/cambiar-password");
		throw redirect(user.role === "teacher" ? "/admin" : "/libro");
	}

	const next = new URL(request.url).searchParams.get("next") ?? "";
	return { next };
}

export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const form = await request.formData();

	const modo = String(form.get("modo") || "estudiante");
	const usuario = String(form.get("usuario") || "").trim();
	const password = String(form.get("password") || "");
	const next = String(form.get("next") || "");

	if (!usuario || !password) {
		return { error: "Escribe tu usuario y tu contraseña.", modo };
	}

	const resultado = await iniciarSesion(env, request, usuario, password);
	if (!resultado.ok) return { error: resultado.error, modo };

	const db = getDb(env);
	const [fila] = await db
		.select({
			role: schema.users.role,
			mustChangePassword: schema.users.mustChangePassword,
		})
		.from(schema.users)
		.where(eq(schema.users.username, usuario.toLowerCase()))
		.limit(1);

	if (modo === "profesor" && fila?.role !== "teacher") {
		return { error: "Esa cuenta no es la del profe.", modo };
	}
	if (modo === "estudiante" && fila?.role === "teacher") {
		return { error: "Entra por la tarjeta “Soy el profe”.", modo };
	}

	const destino = fila?.mustChangePassword
		? "/cambiar-password"
		: next && next.startsWith("/")
			? next
			: fila?.role === "teacher"
				? "/admin"
				: "/libro";

	return redirect(destino, { headers: resultado.headers });
}

export default function Login({ actionData, loaderData }: Route.ComponentProps) {
	const [modo, setModo] = useState<"estudiante" | "profesor" | null>(null);
	const navigation = useNavigation();
	const enviando = navigation.state === "submitting";
	const error = actionData?.error;

	return (
		<main className="grid min-h-dvh lg:grid-cols-[1.1fr_0.9fr]">
			<div className="flex flex-col justify-center gap-10 px-5 py-14 sm:px-12 lg:px-20">
			<div className="jc-anim-in">
				<Logo size="lg" />
				<h1 className="jc-display mt-10 text-5xl sm:text-7xl">
					El Libro JuanCode
				</h1>
				<p className="mt-4 text-lg text-[var(--color-tinta-2)]">
					Python desde 0, capítulo a capítulo.
				</p>
			</div>

			{modo === null ? (
				<div className="jc-anim-in grid w-full max-w-xl border-t border-[var(--color-cyan)]">
					<CardModo
						titulo="Estudiante"
						texto="Entra con el usuario y la contraseña que te dio el profe."
						onClick={() => setModo("estudiante")}
					/>
					<CardModo
						titulo="Soy el profe"
						texto="Panel de estudiantes, capítulos, ejercicios y quizzes."
						onClick={() => setModo("profesor")}
					/>
				</div>
			) : (
				<Form
					method="post"
					key={modo}
					className="jc-anim-in jc-glass w-full max-w-md p-7 shadow-[var(--sombra)]"
				>
					<input type="hidden" name="modo" value={modo} />
					<input type="hidden" name="next" value={loaderData.next} />

					<div className="mb-5 flex items-center justify-between">
						<h2 className="jc-display text-2xl">
							{modo === "profesor" ? "Profe" : "Estudiante"}
						</h2>
						<button
							type="button"
							className="text-sm font-semibold text-[var(--color-tinta-2)] underline underline-offset-4 hover:text-[var(--color-cyan)]"
							onClick={() => setModo(null)}
						>
							cambiar
						</button>
					</div>

					<div className="space-y-4">
						<div>
							<label className="jc-label" htmlFor="usuario">
								Usuario
							</label>
							<input
								id="usuario"
								name="usuario"
								className="jc-input jc-mono"
								autoComplete="username"
								autoFocus
								required
							/>
						</div>
						<div>
							<label className="jc-label" htmlFor="password">
								Contraseña
							</label>
							<input
								id="password"
								name="password"
								type="password"
								className="jc-input"
								autoComplete="current-password"
								required
							/>
						</div>
					</div>

					{error && (
						<p className="mt-4 rounded-xl border border-[color-mix(in_srgb,var(--color-magenta)_35%,transparent)] bg-[color-mix(in_srgb,var(--color-magenta)_8%,transparent)] px-4 py-2 text-sm text-[var(--color-magenta)]">
							{error}
						</p>
					)}

					<button
						type="submit"
						className="jc-btn jc-btn-primary mt-6 w-full"
						disabled={enviando}
					>
						{enviando ? "Entrando…" : "Entrar"}
					</button>

					{modo === "estudiante" && (
						<p className="jc-mono mt-4 text-center text-xs text-[var(--color-tinta-2)]">
							demo / demo123
						</p>
					)}
				</Form>
			)}
			</div>
			<div className="relative hidden border-l border-[var(--color-borde)] lg:block">
				<Muro />
				<p className="absolute right-10 bottom-10 left-10 jc-glass px-6 py-5 backdrop-blur-sm">
					<span className="jc-mono block text-xs tracking-[0.14em] text-[var(--color-cyan)] uppercase">
						Cimientos primero
					</span>
					<span className="jc-display mt-1 block text-2xl">
						Cada quiz aprobado abre el siguiente capítulo.
					</span>
				</p>
			</div>
		</main>
	);
}

function CardModo({
	titulo,
	texto,
	onClick,
}: {
	titulo: string;
	texto: string;
	onClick: () => void;
}) {
	return (
		<button
			type="button"
			onClick={onClick}
			className="group flex items-center gap-6 border-b-2 border-[var(--color-borde)] py-6 text-left transition-colors hover:border-[var(--color-cyan)]"
		>
			<span className="min-w-0 flex-1">
				<span className="jc-display block text-3xl transition-colors group-hover:text-[var(--color-cyan)]">
					{titulo}
				</span>
				<span className="mt-1 block text-[var(--color-tinta-2)]">{texto}</span>
			</span>
			<ArrowRight
				size={26}
				aria-hidden="true"
				className="shrink-0 text-[var(--color-cyan)] transition-transform duration-300 group-hover:translate-x-1.5"
			/>
		</button>
	);
}
