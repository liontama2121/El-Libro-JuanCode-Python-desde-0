import { eq } from "drizzle-orm";
import { useState } from "react";
import { Form, redirect, useNavigation } from "react-router";
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
		<main className="mx-auto flex min-h-dvh max-w-4xl flex-col items-center justify-center gap-10 px-5 py-16">
			<div className="jc-anim-in text-center">
				<Logo size="lg" />
				<h1 className="jc-display jc-grad mt-6 text-5xl sm:text-6xl">
					El Libro JuanCode
				</h1>
				<p className="mt-3 text-[var(--color-tinta-2)]">
					Python desde 0, capítulo a capítulo. 🐍
				</p>
			</div>

			{modo === null ? (
				<div className="jc-anim-in grid w-full gap-5 sm:grid-cols-2">
					<CardModo
						emoji="🎓"
						titulo="Estudiante"
						texto="Entra con el usuario y la contraseña que te dio el profe."
						onClick={() => setModo("estudiante")}
					/>
					<CardModo
						emoji="🧑‍🏫"
						titulo="Soy el profe"
						texto="Panel de estudiantes, capítulos, ejercicios y quizzes."
						onClick={() => setModo("profesor")}
					/>
				</div>
			) : (
				<Form
					method="post"
					key={modo}
					className="jc-anim-in jc-glass w-full max-w-md p-7"
				>
					<input type="hidden" name="modo" value={modo} />
					<input type="hidden" name="next" value={loaderData.next} />

					<div className="mb-5 flex items-center justify-between">
						<h2 className="jc-display text-2xl">
							{modo === "profesor" ? "🧑‍🏫 Profe" : "🎓 Estudiante"}
						</h2>
						<button
							type="button"
							className="jc-mono text-xs text-[var(--color-tinta-2)] underline"
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
						<p className="mt-4 rounded-xl border border-[rgba(255,77,255,.35)] bg-[rgba(255,77,255,.08)] px-4 py-2 text-sm text-[var(--color-magenta)]">
							{error}
						</p>
					)}

					<button
						type="submit"
						className="jc-btn jc-btn-primary mt-6 w-full"
						disabled={enviando}
					>
						{enviando ? "Entrando…" : "Entrar 🚀"}
					</button>

					{modo === "estudiante" && (
						<p className="jc-mono mt-4 text-center text-xs text-[var(--color-tinta-2)]">
							demo / demo123
						</p>
					)}
				</Form>
			)}
		</main>
	);
}

function CardModo({
	emoji,
	titulo,
	texto,
	onClick,
}: {
	emoji: string;
	titulo: string;
	texto: string;
	onClick: () => void;
}) {
	return (
		<button
			type="button"
			onClick={onClick}
			className="jc-glass group p-7 text-left transition hover:-translate-y-1 hover:border-[rgba(0,229,255,.45)]"
		>
			<div className="text-4xl">{emoji}</div>
			<h2 className="jc-display mt-4 text-2xl group-hover:text-[var(--color-cyan)]">
				{titulo}
			</h2>
			<p className="mt-2 text-sm text-[var(--color-tinta-2)]">{texto}</p>
			<span className="jc-mono mt-5 inline-block text-xs tracking-[0.18em] text-[var(--color-cyan)] uppercase">
				entrar →
			</span>
		</button>
	);
}
