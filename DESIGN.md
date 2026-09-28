---
name: JuanCode · Visor HUD
description: Interfaz de visor cyberpunk. Negro profundo, cian para la acción, magenta como segundo neón, código que se vuelve página.
colors:
  suelo: "#05070b"
  suelo-2: "#0b1017"
  suelo-3: "#131b26"
  tinta: "#e4f4f8"
  tinta-2: "#8ea3b3"
  cian: "#00e5ff"
  cian-claro: "#7ef3ff"
  sobre-cian: "#03141a"
  magenta: "#ff2bd6"
  verde: "#39ff9c"
  ambar: "#ffb020"
  violeta: "#a974ff"
  codigo: "#03060a"
  linea: "rgba(0, 229, 255, 0.14)"
  linea-fuerte: "rgba(0, 229, 255, 0.38)"
typography:
  display:
    fontFamily: "Archivo, ui-sans-serif, system-ui, sans-serif"
    fontSize: "clamp(36px, 4.3vw, 64px)"
    fontWeight: 700
    lineHeight: 1.02
    letterSpacing: "-0.015em"
  heading:
    fontFamily: "Archivo, ui-sans-serif, system-ui, sans-serif"
    fontSize: "clamp(30px, 3.6vw, 50px)"
    fontWeight: 700
    lineHeight: 1.05
    letterSpacing: "-0.015em"
  body:
    fontFamily: "Archivo, ui-sans-serif, system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
  etiqueta:
    fontFamily: "JetBrains Mono, ui-monospace, monospace"
    fontSize: "13px"
    fontWeight: 500
    lineHeight: 1.3
    letterSpacing: "0.14em"
  code:
    fontFamily: "JetBrains Mono, ui-monospace, monospace"
    fontSize: "0.92rem"
    fontWeight: 400
    lineHeight: 1.65
    letterSpacing: "normal"
rounded:
  none: "0px"
spacing:
  linea: "1px"
  sm: "8px"
  md: "16px"
  lg: "28px"
  seccion: "clamp(80px, 11vw, 150px)"
components:
  button-primary:
    backgroundColor: "{colors.cian}"
    textColor: "{colors.sobre-cian}"
    rounded: "{rounded.none}"
    padding: "0 24px"
    height: "52px"
  button-primary-hover:
    backgroundColor: "{colors.cian-claro}"
  button-linea:
    backgroundColor: "transparent"
    textColor: "{colors.tinta}"
    rounded: "{rounded.none}"
    padding: "0 24px"
    height: "52px"
  panel-mira:
    backgroundColor: "{colors.suelo-2}"
    textColor: "{colors.tinta}"
    rounded: "{rounded.none}"
    padding: "18px 22px"
  hueco-libre:
    backgroundColor: "{colors.cian}"
    textColor: "{colors.sobre-cian}"
    padding: "12px 14px"
---

# JuanCode · Visor HUD

## Overview

La marca JuanCode (landing en `landing/public` y El Libro en `app/`) es una interfaz de visor: negro profundo con retícula tenue, líneas de barrido de monitor, paneles de línea fina con esquinas de mira y neón cian y magenta. Solo tema oscuro.

La pieza firma es la **escena holográfica** en `<canvas>`, un solo motor compartido (`landing/public/assets/muro.js`, copiado en `public/muro.js` para la app y montado por `app/components/muro.tsx`):

- **web** (`/web`, portada): un editor escribe `index.html` línea por línea y cada línea traza su bloque en el wireframe de un navegador (nav, titular, botón, imagen, tienda, pagos, deploy en línea).
- **python** (`/clases`, login y portada del Libro): la película en vivo. El código se escribe, se ejecuta paso a paso con la línea activa resaltada y el panel de variables se actualiza hasta imprimir el resultado.
- **piso** (cierres de contacto): retícula en fuga hacia un horizonte magenta.

Las escenas se repiten mientras están en pantalla y se detienen fuera de ella; con movimiento reducido muestran el estado final, quieto.

**Mantenimiento:** si se edita `landing/public/assets/muro.js`, copiarlo a `public/muro.js`.

## Colors

- **Cian `#00e5ff`**: toda acción (botones primarios, enlaces, horas libres, estado activo) y el neón principal.
- **Magenta `#ff2bd6`**: segundo neón. Segundo servicio (IA), El Libro, ocupado/error, detalles de la escena.
- **Suelos** `#05070b` / `#0b1017` / `#131b26`; **tinta** `#e4f4f8`, **tinta-2** `#8ea3b3`.
- **Líneas**: cian a 14% (normal) y 38% (fuerte). Nunca bordes gruesos ni blancos.
- **App**: verde `#39ff9c` (correcto), ámbar `#ffb020` y dorado `#ffd24a` (XP, avisos), violeta `#a974ff` (tercer modo de práctica). Los tokens de la app conservan sus nombres (`cyan`, `magenta`, `purpura`…).
- El brillo es material del mundo: `box-shadow` y `text-shadow` de neón solo en acción, cifras y palabras clave; nunca en todo.

## Typography

**Archivo** autoalojada, en ancho 112 y peso 700 para titulares; texto en ancho 100. **JetBrains Mono** para botones (mayúsculas, +0.06em), etiquetas de visor (mayúsculas, +0.14em), cifras (precios, horarios, XP) y código. Una palabra clave por titular puede ir en `.neon` (cian con brillo).

## Layout

Contenedor de 1240px, gutter `clamp(18px, 4vw, 48px)`, secciones separadas por líneas de 1px. Hero dividido: texto a la izquierda, escena holográfica a la derecha con barrido vertical y placa con esquinas de mira. Cada sección usa una familia de composición distinta. Todo colapsa a una columna bajo 760px.

## Elevation & Depth

La profundidad es luz, no sombra: fondo con viñeta y retícula, paneles translúcidos (`rgba(11,16,23,.86)`) con `backdrop-filter` suave, y halos de neón en lo interactivo. Las líneas de barrido y la retícula son capas fijas sin eventos.

## Shapes

Todo recto (radio 0). Las esquinas de mira (corchetes de 14px en las cuatro esquinas) marcan los paneles importantes: placas, calculadora, precios, servicios, capturas, tarjetas de la app (`jc-glass`). Las píldoras solo existen en barras de progreso.

## Components

- **Botón primario**: cian lleno, texto oscuro, brillo; hover cian claro. **Botón línea**: borde cian tenue; hover cian con brillo.
- **Panel de mira**: fondo translúcido, línea fina, corchetes en las esquinas.
- **Servicios**: marcos de neón (cian para web, magenta para IA), no bloques llenos.
- **Precios**: bloque único; Pro resaltado con marco cian luminoso.
- **Proceso**: línea de tiempo en degradado cian→magenta con marcadores en rombo.
- **Agenda**: hueco libre = cian lleno con brillo; ocupado = borde magenta tenue, tachado.
- **Portafolio**: capturas reales dentro de marcos de mira; al pasar, la mira pasa a magenta.
- **Íconos**: Phosphor regular (autoalojado en la landing, `@phosphor-icons/react` en la app).

## Do's and Don'ts

- Do: cian = acción. Magenta como segundo, nunca compitiendo en el mismo control.
- Do: la escena cuenta el producto (código que construye una página; código que se ejecuta y cambia variables). Nada de decoración genérica.
- Do: respetar `prefers-reduced-motion` (escena quieta, sin barrido ni pulsos).
- Don't: texto degradado, orbes difusos, bordes gruesos, redondeos, emojis como íconos de interfaz (los emojis de contenido del Libro se quedan).
- Don't: eyebrows sobre titulares ni numeración de secciones.
- Don't: guiones largos en el copy. Voz cercana, tuteo, español colombiano.
