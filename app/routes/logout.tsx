import { redirect } from "react-router";
import { cerrarSesion } from "~/lib/auth.server";
import type { Route } from "./+types/logout";

export async function action({ context, request }: Route.ActionArgs) {
	const headers = await cerrarSesion(context.cloudflare.env, request);
	return redirect("/login", { headers });
}

export async function loader() {
	return redirect("/login");
}
