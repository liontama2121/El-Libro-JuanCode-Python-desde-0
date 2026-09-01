import { redirect } from "react-router";
import type { Route } from "./+types/home";

export async function loader({ context }: Route.LoaderArgs) {
	// La portada del libro es /libro; la protección de sesión vive allí.
	void context;
	return redirect("/libro");
}

export default function Home() {
	return null;
}
