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

export function Nav({ user }: { user: SessionUser }) {
	const esProfe = user.role === "teacher";

	return (
		<header className="sticky top-0 z-40 border-b border-[var(--color-borde)] bg-[#0b0b16]/80 backdrop-blur-xl">
			<div className="mx-auto flex max-w-6xl items-center gap-4 px-5 py-3">
				<Link to="/libro" className="shrink-0">
					<Logo />
				</Link>

				<nav className="ml-2 hidden items-center gap-1 sm:flex">
					<NavItem to="/libro">📚 El libro</NavItem>
					{esProfe && <NavItem to="/admin">🧑‍🏫 Panel</NavItem>}
				</nav>

				<div className="ml-auto flex items-center gap-3">
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
