# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

- **Primary: dueños de negocio en Colombia** (y algunos fuera) que necesitan presencia digital: landing, tienda con pagos, plataforma a la medida o asistente con IA. Llegan desde TikTok/Instagram @juancode o por referido, leen en el celular, comparan precio y confianza, y deciden por WhatsApp. Prioridad actual del negocio.
- **Secundario: estudiantes universitarios** con un parcial de programación (Python) encima, o que arrancan desde cero. Buscan clases 1 a 1 y reservan una hora libre de la agenda.
- **Usuarios del Libro:** estudiantes con cuenta que leen capítulos, resuelven quiz, practican (arcade, simulacros, modo código) y ven su progreso/ranking.
- **Juan (profe/admin):** gestiona estudiantes, capítulos, ejercicios, banco de preguntas, películas y su agenda privada.

## Product Purpose

JuanCode es la marca personal de Juan, ingeniero de sistemas y arquitecto de software en Bogotá. Dos líneas separadas a propósito:

1. **Desarrollo web / arquitectura digital** (`/web`): sitios y plataformas hechos a mano, cotización por WhatsApp y calculadora de precio en 60 segundos.
2. **Clases de programación 1 a 1** (`/clases`): agenda en vivo que Juan controla a mano, y **El Libro JuanCode** (app React Router): libro digital de Python desde 0, capítulos bloqueados por quiz.

La portada (`/`) solo da la bienvenida y separa los dos caminos. Éxito = un negocio escribe por WhatsApp para cotizar; un estudiante reserva hora; un lector avanza de capítulo.

## Positioning

Arquitecto de software que trabaja directo con el dueño del negocio: "cimientos primero, estética después, todo dura años". Empieza por tres preguntas (quién entra, qué debe hacer ahí, cómo crece el negocio en 2 años) y dibuja el plano antes del código. Sin plantillas, sin agencia, código entregado al cliente. En clases: explicar paso a paso hasta el "¡ahh, ya entendí!", con la "película en vivo" del libro (ver variables setearse línea por línea).

## Operating Context

- Contacto y cierre ocurren por WhatsApp con mensajes pre-escritos por CTA (palabras clave "WEB" y "PARCIAL").
- Pagos 50/50 (arranque y entrega), transferencia, Nequi, Bancolombia; PayPal/SWIFT fuera del país.
- Agenda: lunes a viernes 6:00-11:00 p.m. hora Colombia, sesiones de 1 hora, refresco automático cada minuto.
- Landing en Cloudflare Pages + Functions + D1; Libro en Cloudflare Workers + D1 + Better Auth; Modo Código ejecuta Python real (Piston).

## Capabilities and Constraints

- Landing estática HTML/CSS/JS sin framework (`landing/public`), scripts propios: `config.js`, `main.js`, `agenda.js`, `calculadora.js`, `panel.js`. Sin build step.
- App: React Router v7 SSR, Tailwind v4, tokens en `app/app.css` (utilidades `jc-*`).
- Rutas, anclas (`#agenda`, `#calculadora`, `#libro`, etc.), IDs usados por JS y links de WhatsApp no cambian.
- Calificación, XP y desbloqueo siempre en servidor.
- Toda la interfaz en español.

## Brand Commitments

- Nombre y logo **`<J> JUANCODE`** se conservan.
- Voz cercana, tuteo, español colombiano ("¿Lo cuadramos?", "Que ese parcial no te tumbe el semestre").
- Emojis NO son obligatorios; pueden reemplazarse por íconos.

## Evidence on Hand

- Portafolio real en línea: Sharick Platform, Inalper Photography, Mr. Capacho Coffee, ADS Pharma, El Armario de Lina, La Caleñita (URLs en `landing/public/web/index.html`).
- Precios reales: Esencial desde $1.000.000 COP, Pro desde $2.500.000, Custom desde $3.000.000; 6 meses de mantenimiento incluidos.
- Credenciales: Ing. de Sistemas, AWS Certified, arquitecto de software, +5 años en la web, @juancode.
- Libro: 24 capítulos, 96 ejercicios, quiz por capítulo.
- **Ausente:** foto de Juan, capturas del portafolio y del libro, testimonios, logos de clientes. No inventar testimonios ni métricas.

## Product Principles

1. Separar los caminos: un negocio no se topa con la agenda de clases ni un estudiante con el portafolio.
2. Probar, no prometer: proyectos vivos, precios visibles, agenda real.
3. Cada acción termina en una conversación humana por WhatsApp.
4. Lo técnico sirve al dueño del negocio; se explica en su idioma.

## Accessibility & Inclusion

Lectura en celular primero; contraste AA; respetar `prefers-reduced-motion`; todo funciona sin JavaScript donde sea posible (links de WhatsApp directos en HTML).
