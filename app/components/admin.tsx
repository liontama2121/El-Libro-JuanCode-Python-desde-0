import { NavLink } from "react-router";
import { Nav } from "~/components/nav";
import { Toast } from "~/components/ui";
import type { SessionUser } from "~/lib/auth.server";

const TABS = [
	{ to: "/admin", label: "📊 Dashboard", end: true },
	{ to: "/admin/estudiantes", label: "🎓 Estudiantes", end: false },
	{ to: "/admin/capitulos", label: "📚 Capítulos", end: false },
];

export function AdminShell({
	user,
	titulo,
	descripcion,
	acciones,
	children,
}: {
	user: SessionUser;
	titulo: string;
	descripcion?: string;
	acciones?: React.ReactNode;
	children: React.ReactNode;
}) {
	return (
		<>
			<Nav user={user} />
			<Toast />

			<main className="mx-auto max-w-6xl px-5 py-10 pb-24">
				<div className="flex flex-wrap items-center gap-2 border-b border-[var(--color-borde)] pb-4">
					{TABS.map((t) => (
						<NavLink
							key={t.to}
							to={t.to}
							end={t.end}
							className={({ isActive }) =>
								`rounded-full px-4 py-1.5 text-sm font-semibold transition ${
									isActive
										? "bg-white/10 text-[var(--color-cyan)]"
										: "text-[var(--color-tinta-2)] hover:bg-white/5"
								}`
							}
						>
							{t.label}
						</NavLink>
					))}
				</div>

				<header className="jc-anim-in mt-8 flex flex-wrap items-end justify-between gap-4">
					<div>
						<h1 className="jc-display jc-grad text-4xl">{titulo}</h1>
						{descripcion && (
							<p className="mt-2 text-sm text-[var(--color-tinta-2)]">
								{descripcion}
							</p>
						)}
					</div>
					{acciones}
				</header>

				<div className="jc-anim-in mt-8">{children}</div>
			</main>
		</>
	);
}

export function Tabla({
	cabeceras,
	children,
}: {
	cabeceras: string[];
	children: React.ReactNode;
}) {
	return (
		<div className="jc-glass overflow-x-auto">
			<table className="w-full min-w-[640px] text-left text-sm">
				<thead>
					<tr className="border-b border-[var(--color-borde)]">
						{cabeceras.map((h) => (
							<th
								key={h}
								className="jc-mono px-5 py-3 text-[0.68rem] tracking-[0.16em] text-[var(--color-tinta-2)] uppercase"
							>
								{h}
							</th>
						))}
					</tr>
				</thead>
				<tbody>{children}</tbody>
			</table>
		</div>
	);
}

export function Vacio({ children }: { children: React.ReactNode }) {
	return (
		<p className="rounded-2xl border border-dashed border-[var(--color-borde)] p-10 text-center text-sm text-[var(--color-tinta-2)]">
			{children}
		</p>
	);
}

export function Aviso({
	tipo = "info",
	children,
}: {
	tipo?: "info" | "error" | "ok";
	children: React.ReactNode;
}) {
	const estilos = {
		info: "border-[var(--color-borde)] text-[var(--color-tinta-2)]",
		error:
			"border-[rgba(255,77,255,.35)] bg-[rgba(255,77,255,.08)] text-[var(--color-magenta)]",
		ok: "border-[rgba(52,224,122,.4)] bg-[rgba(52,224,122,.08)] text-[var(--color-verde)]",
	}[tipo];

	return (
		<p className={`rounded-xl border px-4 py-2 text-sm ${estilos}`}>{children}</p>
	);
}
