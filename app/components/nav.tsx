import { Form, Link, NavLink } from "react-router";
import type { Track } from "~/db/schema";
import type { SessionUser } from "~/lib/auth.server";
import { rutaLibro, tracksVisibles } from "~/lib/tracks";

export function Logo({ size = "md" }: { size?: "md" | "lg" }) {
	return (
		<span className="inline-flex items-center gap-2.5">
			<span
				className={`jc-mono grid place-items-center bg-[var(--color-cyan)] leading-none font-bold text-[var(--color-sobre)] ${
					size === "lg" ? "px-2.5 py-1.5 text-lg" : "px-1.5 py-1 text-[0.8rem]"
				}`}
			>
				&lt;J&gt;
			</span>
			<span
				className={`font-extrabold tracking-[0.06em] [font-variation-settings:'wdth'_125] ${size === "lg" ? "text-2xl" : "text-base"}`}
			>
				JUANCODE
			</span>
		</span>
	);
}

export type NavStats = {
	xp: number;
	emoji: string;
	nombre: string;
	progreso: number;
};

export function Nav({ user, stats }: { user: SessionUser; stats?: NavStats }) {
	const esProfe = user.role === "teacher";

	// Con los dos libros asignados, el link lleva al selector; con uno solo,
	// directo a ese libro. Nadie ve una puerta que no puede abrir.
	const libros = esProfe ? ["basico", "avanzado"] : tracksVisibles(user.track);
	const destinoLibro = libros.length > 1 ? "/tracks" : rutaLibro(libros[0] as Track);

	return (
		<header className="sticky top-0 z-40 border-b-2 border-[var(--color-borde)] bg-noche/90 backdrop-blur-md">
			<div className="mx-auto flex max-w-6xl items-center gap-4 px-5 py-3">
				<Link to={destinoLibro} className="shrink-0">
					<Logo />
				</Link>

				<nav className="ml-2 hidden items-center gap-1 sm:flex">
					<NavItem to={destinoLibro}>
						{libros.length > 1 ? "Mis libros" : "El libro"}
					</NavItem>
					<NavItem to="/practica">Práctica</NavItem>
					{!esProfe && <NavItem to="/ranking">Ranking</NavItem>}
					{esProfe && <NavItem to="/admin">Panel</NavItem>}
				</nav>

				{/* Nivel y XP del estudiante */}
				{stats && (
					<Link
						to="/perfil"
						title={`${stats.xp} XP`}
						className="ml-auto flex min-w-0 items-center gap-2 border
							border-[var(--color-borde)] bg-tinta/5 px-3 py-1.5 transition hover:bg-tinta/10"
					>
						<span className="text-sm">{stats.emoji}</span>
						<span className="hidden text-xs font-semibold sm:inline">{stats.nombre}</span>
						<span className="h-1.5 w-14 overflow-hidden rounded-full bg-tinta/15">
							<span
								className="block h-full rounded-full"
								style={{
									width: `${stats.progreso}%`,
									background: "var(--color-cyan)",
								}}
							/>
						</span>
						<span className="jc-mono text-[0.65rem] text-[var(--color-dorado)]">
							{stats.xp}
						</span>
					</Link>
				)}

				<div className={`${stats ? "" : "ml-auto"} flex items-center gap-3`}>
					<span className="hidden text-sm text-[var(--color-tinta-2)] sm:inline">
						{user.name}
					</span>
					<Form method="post" action="/logout">
						<button type="submit" className="jc-btn jc-btn-sm jc-btn-ghost">
							Salir
						</button>
					</Form>
				</div>
			</div>
		</header>
	);
}

function NavItem({ to, children }: { to: string; children: React.ReactNode }) {
	return (
		<NavLink
			to={to}
			className={({ isActive }) =>
				`border-b-2 px-3 py-1.5 text-[0.95rem] font-semibold transition ${
					isActive
						? "border-[var(--color-cyan)] text-[var(--color-tinta)]"
						: "border-transparent text-[var(--color-tinta-2)] hover:text-[var(--color-tinta)]"
				}`
			}
		>
			{children}
		</NavLink>
	);
}
