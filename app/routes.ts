import { type RouteConfig, index, route } from "@react-router/dev/routes";

export default [
	index("routes/home.tsx"),

	route("login", "routes/login.tsx"),
	route("logout", "routes/logout.tsx"),
	route("cambiar-password", "routes/cambiar-password.tsx"),

	// Estudiante
	route("libro", "routes/libro.tsx"),
	route("libro/capitulo/:number", "routes/capitulo.tsx"),
	route("libro/capitulo/:number/quiz", "routes/quiz.tsx"),

	// Profesor
	route("admin", "routes/admin.tsx"),
	route("admin/estudiantes", "routes/admin.estudiantes.tsx"),
	route("admin/estudiante/:id", "routes/admin.estudiante.tsx"),
	route("admin/capitulos", "routes/admin.capitulos.tsx"),
	route("admin/capitulo/:id/ejercicios", "routes/admin.ejercicios.tsx"),
	route("admin/capitulo/:id/quiz", "routes/admin.quiz.tsx"),
] satisfies RouteConfig;
