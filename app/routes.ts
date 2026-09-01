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

	// Práctica (no desbloquea capítulos)
	route("practica", "routes/practica.tsx"),
	route("practica/simulacro-quiz", "routes/practica.simulacro-quiz.tsx"),
	route("practica/simulacro-parcial", "routes/practica.simulacro-parcial.tsx"),
	route("practica/arcade", "routes/practica.arcade.tsx"),
	route("practica/arcade/codigo", "routes/practica.arcade.codigo.tsx"),
	route("practica/arcade/:modo", "routes/practica.arcade.modo.tsx"),
	route("perfil", "routes/perfil.tsx"),

	// Modo Código (ruta de recurso)
	route("api/probar", "routes/api.probar.tsx"),
	route("ranking", "routes/ranking.tsx"),

	// Profesor
	route("admin", "routes/admin.tsx"),
	route("admin/estudiantes", "routes/admin.estudiantes.tsx"),
	route("admin/estudiante/:id", "routes/admin.estudiante.tsx"),
	route("admin/capitulos", "routes/admin.capitulos.tsx"),
	route("admin/banco", "routes/admin.banco.tsx"),
	route("admin/banco/export", "routes/admin.banco.export.tsx"),
	route("admin/ejercicio/:id", "routes/admin.ejercicio.tsx"),
	route("admin/capitulo/:id/ejercicios", "routes/admin.ejercicios.tsx"),
	route("admin/capitulo/:id/quiz", "routes/admin.quiz.tsx"),
] satisfies RouteConfig;
