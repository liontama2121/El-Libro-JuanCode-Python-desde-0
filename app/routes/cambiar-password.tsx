import { eq } from "drizzle-orm";
import { Form, redirect, useNavigation } from "react-router";
import { Logo } from "~/components/nav";
import { getDb, schema } from "~/db";
import { requireUser, setPasswordHash } from "~/lib/auth.server";
import type { Route } from "./+types/cambiar-password";

export const meta: Route.MetaFunction = () => [
	{ title: "Cambiar contraseña — El Libro JuanCode" },
];

export async function loader({ context, request }: Route.LoaderArgs) {
	const user = await requireUser(context.cloudflare.env, request, {
		allowPasswordChange: true,
	});
	return { user, obligatorio: user.mustChangePassword };
}

export async function action({ context, request }: Route.ActionArgs) {
	const env = context.cloudflare.env;
	const user = await requireUser(env, request, { allowPasswordChange: true });

	const form = await request.formData();
	const nueva = String(form.get("nueva") || "");
	const repetir = String(form.get("repetir") || "");

	if (nueva.length < 6) {
		return { error: "La contraseña necesita al menos 6 caracteres." };
	}
	if (nueva !== repetir) {
		return { error: "Las dos contraseñas no coinciden." };
	}

	const db = getDb(env);
	await setPasswordHash(db, user.id, nueva);
	await db
		.update(schema.users)
		.set({ mustChangePassword: false, updatedAt: new Date() })
		.where(eq(schema.users.id, user.id));

	return redirect(
		`${user.role === "teacher" ? "/admin" : "/libro"}?toast=${encodeURIComponent(
			"Contraseña actualizada ✅",
		)}`,
	);
}

export default function CambiarPassword({
	loaderData,
	actionData,
}: Route.ComponentProps) {
	const navigation = useNavigation();
	const enviando = navigation.state === "submitting";

	return (
		<main className="mx-auto flex min-h-dvh max-w-md flex-col items-center justify-center gap-8 px-5 py-16">
			<Logo size="lg" />

			<Form method="post" className="jc-anim-in jc-glass w-full p-7">
				<h1 className="jc-display jc-grad text-3xl">Nueva contraseña</h1>
				<p className="mt-2 text-sm text-[var(--color-tinta-2)]">
					{loaderData.obligatorio
						? `Hola ${loaderData.user.name} 👋 Antes de empezar, cambia la contraseña temporal que te dio el profe.`
						: "Elige una contraseña nueva para tu cuenta."}
				</p>

				<div className="mt-6 space-y-4">
					<div>
						<label className="jc-label" htmlFor="nueva">
							Contraseña nueva
						</label>
						<input
							id="nueva"
							name="nueva"
							type="password"
							className="jc-input"
							autoComplete="new-password"
							minLength={6}
							autoFocus
							required
						/>
					</div>
					<div>
						<label className="jc-label" htmlFor="repetir">
							Repítela
						</label>
						<input
							id="repetir"
							name="repetir"
							type="password"
							className="jc-input"
							autoComplete="new-password"
							minLength={6}
							required
						/>
					</div>
				</div>

				{actionData?.error && (
					<p className="mt-4 rounded-xl border border-[rgba(255,77,255,.35)] bg-[rgba(255,77,255,.08)] px-4 py-2 text-sm text-[var(--color-magenta)]">
						{actionData.error}
					</p>
				)}

				<button
					type="submit"
					className="jc-btn jc-btn-primary mt-6 w-full"
					disabled={enviando}
				>
					{enviando ? "Guardando…" : "Guardar y entrar"}
				</button>
			</Form>
		</main>
	);
}
