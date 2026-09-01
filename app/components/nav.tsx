import { Form, Link, NavLink } from "react-router";
import type { SessionUser } from "~/lib/auth.server";

export function Logo({ size = "md" }: { size?: "md" | "lg" }) {
	return (
		<span className="inline-flex items-center gap-2">
			<span
				className={`jc-mono grid place-items-center rounded-lg border border-[var(--color-borde)] bg-white/5 font-bold text-[var(--color-cyan)] ${
					size === "lg" ? "h-11 w-11 text-lg" : "h-8 w-8 text-sm"
				}`}
			>
				&lt;J&gt;
			</span>
			<span
				className={`jc-display jc-grad ${size === "lg" ? "text-2xl" : "text-lg"}`}
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

	return (
		<header className="sticky top-0 z-40 border-b border-[var(--color-borde)] bg-[#0b0b16]/80 backdrop-blur-xl">
			<div className="mx-auto flex max-w-6xl items-center gap-4 px-5 py-3">
				<Link to="/libro" className="shrink-0">
					<Logo />
				</Link>

				<nav className="ml-2 hidden items-center gap-1 sm:flex">
					<NavItem to="/libro">📚 El libro</NavItem>
					<NavItem to="/practica">🎮 Práctica</NavItem>
					{!esProfe && <NavItem to="/ranking">🏆 Ranking</NavItem>}
					{esProfe && <NavItem to="/admin">🧑‍🏫 Panel</NavItem>}
				</nav>

				{/* Nivel y XP del estudiante */}
				{stats && (
					<Link
						to="/perfil"
						title={`${stats.xp} XP`}
						className="ml-auto flex min-w-0 items-center gap-2 rounded-full border
							border-[var(--color-borde)] bg-white/5 px-3 py-1.5 transition hover:bg-white/10"
					>
						<span className="text-sm">{stats.emoji}</span>
						<span className="hidden text-xs font-semibold sm:inline">{stats.nombre}</span>
						<span className="h-1.5 w-14 overflow-hidden rounded-full bg-black/50">
							<span
								className="block h-full rounded-full"
								style={{
									width: `${stats.progreso}%`,
									background:
										"linear-gradient(92deg, var(--color-cyan), var(--color-magenta))",
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
						{esProfe ? "👑" : "🎓"} {user.name}
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
				`rounded-full px-4 py-1.5 text-sm font-semibold transition ${
					isActive
						? "bg-white/10 text-[var(--color-cyan)]"
						: "text-[var(--color-tinta-2)] hover:bg-white/5 hover:text-[var(--color-tinta)]"
				}`
			}
		>
			{children}
		</NavLink>
	);
}
