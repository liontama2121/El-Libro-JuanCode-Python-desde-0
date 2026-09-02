# JuanCode — Página principal y agenda

La web de **juancode.co**: la portada que separa los dos caminos, la página de
clases con **la disponibilidad en vivo**, la de desarrollo web con el portafolio,
y un **panel privado** donde Juan marca a mano qué horas tiene ocupadas.

Todo vive en el mismo repo y sale en el mismo deploy: Cloudflare Pages para el
sitio, Pages Functions para la API y D1 para la agenda.

```
public/                       lo que se publica
├── index.html                la portada: clases o página web
├── clases/index.html         las clases + la agenda en vivo
├── web/index.html            desarrollo web + portafolio
├── panel-juancode/index.html el panel privado (link oculto + clave)
└── assets/                   config.js, estilos y scripts
functions/                    la API (Pages Functions)
├── api/disponibilidad.js     GET  lo que está libre (público)
└── api/admin/…               login y agenda (solo con sesión)
lib/                          reglas de la agenda y seguridad
migrations/                   esquema de D1
docs/                         el diseño de referencia
```

---

## 🚪 Dos caminos, sin revolverlos

La portada (`/`) no vende nada: da la bienvenida y pregunta a qué vienes.

| Camino | Qué hay adentro |
|---|---|
| **`/clases`** 🐍 | Quién soy · qué incluyen las clases · El Libro JuanCode · **la agenda en vivo** · contacto con la palabra **"PARCIAL"** |
| **`/web`** 🌐 | Quién soy · qué hago en desarrollo web · portafolio con los proyectos en línea · contacto con la palabra **"WEB"** |

Un estudiante que viene por su parcial no se topa con el portafolio, y un
negocio que viene por su página no se topa con la agenda de clases.

---

## 🗓️ Cómo funciona la agenda

**No hay autoservicio ni pagos en línea.** Juan controla su agenda a mano y la
página la muestra en vivo:

1. En **`/panel-juancode`** (con clave) ve las próximas 3 semanas, lunes a
   viernes, con las 5 horas de cada día.
2. **Toca una hora** y cambia de libre a ocupada, o al revés. También puede
   **cerrar el día completo** de un solo golpe.
3. En **`/clases#agenda`** cualquiera ve lo que quedó libre. Toca una hora y se
   abre WhatsApp con el mensaje ya escrito:
   *"¡Hola Juan! Vi en tu agenda que tienes libre el jueves 3 de septiembre de
   7:00 a 8:00 p.m. ¿Lo cuadramos? 🐍"*
4. El pago se cuadra por chat.

La agenda pública **se refresca sola cada minuto** y también al volver a la
pestaña. Si Juan marca una hora desde el celular, quien esté mirando la página
deja de verla libre sin tener que recargar.

Una hora puede estar en tres estados:

| Estado | Qué significa |
|---|---|
| **Libre** | Nadie la marcó y falta tiempo suficiente. Se ve verde y se puede tocar. |
| **Ocupada** | Juan la marcó (o cerró el día). Se ve apagada. |
| **Ya pasó** | Arrancó, o faltan menos de 2 horas. No sale en la página pública. |

> El **motivo** que Juan escribe al marcar una hora ("clase con Ana", "viaje") es
> privado: solo lo devuelve la API del panel. La agenda pública dice "Ocupado" y
> nada más. El motivo se usa una vez y el campo se limpia solo, para que no se le
> pegue al siguiente clic.

---

## ⚙️ Lo que se configura

### `public/assets/config.js` — lo que ve el navegador

```js
window.JUANCODE = {
  WHATSAPP_URL:  "https://wa.me/573046452629",
  LIBRO_URL:     "https://libro-juancode.juankmolina2121.workers.dev",
  TIKTOK_URL:    "https://www.tiktok.com/@juancode",
  INSTAGRAM_URL: "https://www.instagram.com/juancode",
};
```

De ahí leen los botones de WhatsApp, el de El Libro, las redes y el mensaje
prellenado de cada hora libre.

### `lib/agenda.js` — las reglas de la agenda

Una constante por regla. Cambiar el horario es cambiar una línea:

```js
export const HORAS = [18, 19, 20, 21, 22];   // 6:00 a 10:00 p.m. (clases de 1 hora)
export const DIAS_ADELANTE = 21;             // hasta 3 semanas hacia adelante
export const DIAS_HABILES = [1, 2, 3, 4, 5]; // lunes a viernes
export const ANTICIPACION_HORAS = 2;         // no se ofrece con menos de 2 h
```

La zona horaria es **America/Bogota** y se calcula **siempre en el servidor**: el
reloj del computador de quien mira la página no decide nada.

### Secretos

`ADMIN_PASSWORD` es la clave del panel. En local va en `.dev.vars` (copia
`.dev.vars.example`); en producción, en el panel de Cloudflare Pages.

---

## 🚀 Montarlo desde cero

```bash
npm install
npx wrangler d1 create juancode-agenda   # copia el database_id a wrangler.jsonc
npm run db:migrate:local                 # base local
npm run db:migrate:remote                # la base de verdad
cp .dev.vars.example .dev.vars           # y escribe tu ADMIN_PASSWORD
npm run dev                              # http://127.0.0.1:8788
```

En producción, la clave se pone así:

```bash
npx wrangler pages secret put ADMIN_PASSWORD
```

### Publicar

```bash
npm run deploy
```

O conectando el repo desde el panel de Cloudflare Pages:

| Campo | Valor |
|---|---|
| Framework preset | **None** |
| Build command | *(vacío)* |
| Build output directory | `public` |

Después, en **Settings → Functions → Bindings**, agrega `DB` (D1). Cada
`git push` a `main` vuelve a desplegar.

---

## 🔒 El panel privado

Vive en **`/panel-juancode`**. No está enlazado desde ninguna página, les pide a
los buscadores que no lo indexen (`noindex, nofollow`) y pide clave.

| Riesgo | Qué lo frena |
|---|---|
| Que alguien lo encuentre | Ruta no enlazada + `noindex` + clave |
| Probar claves a lo bruto | Máximo 5 intentos por hora por IP |
| Adivinar la cookie de sesión | Firmada con HMAC-SHA256, comparada en tiempo constante, vencida a las 8 horas |
| Robar la cookie | `HttpOnly`, `SameSite=Lax` y `Secure` en https |
| Marcar horas sin permiso | Todo `/api/admin/*` pasa por un middleware que exige sesión |
| Ver con quién tiene clase | Los motivos nunca salen en la API pública |

**El link es media llave.** `noindex` evita que salga en Google, pero no es un
candado: el candado es la clave. Guarda el link y no lo compartas.

---

## ✅ Probado de punta a punta

Con `npm run dev` corriendo:

| Prueba | Resultado |
|---|---|
| `/api/admin/agenda` sin sesión | `401` |
| Marcar una hora sin sesión | `401` |
| Clave incorrecta | `401` — *"Clave incorrecta."* |
| Tocar una hora libre en el panel | Pasa a ocupada y el contador baja |
| "Cerrar el día" | Las 5 horas quedan ocupadas y el botón cambia a "Abrir el día" |
| Volver a `/clases` | Esa hora ya aparece ocupada |
| El motivo privado en la API pública | Vacío: no se filtra |
| Link de WhatsApp de una hora libre | Abre el chat con el día y la hora ya escritos |

---

## 🎨 Identidad JuanCode

| Token | Valor |
|---|---|
| Fondo | `#070A12` con malla de puntos de 28px |
| Cyan · Magenta · Púrpura | `#00E5FF` · `#FF4DFF` · `#b975ff` |
| Verde · Dorado | `#34e07a` · `#ffd43b` |
| Títulos | Sora 800, con gradiente cyan → púrpura → magenta |
| Cuerpo | Manrope · Código y etiquetas: JetBrains Mono |
| Cards | glass: `rgba(255,255,255,.045)` + borde `rgba(255,255,255,.09)` + blur |

Punto de quiebre único: **880px**. Todo apila a una columna en celular, que es
donde llegan la mayoría de los estudiantes.

---

## 📁 Nota: este proyecto vive dentro del repo de El Libro

La landing está en la carpeta `landing/` del repo
`El-Libro-JuanCode-Python-desde-0`, pero **son dos proyectos distintos**: cada
uno con su `package.json`, su `wrangler.jsonc` y su base de datos.

Todos los comandos de este README se corren **desde `landing/`**:

```bash
cd landing
npm install
npm run dev
```

Y al conectar Cloudflare Pages hay que decirle dónde mirar:

| Campo | Valor |
|---|---|
| **Root directory** | `landing` |
| Build command | *(vacío)* |
| Build output directory | `public` |

Sin el **Root directory**, Pages intentaría publicar el repo del Libro.

### Tres piedras con las que ya nos tropezamos

1. **Build command vacío, de verdad vacío.** Si le pones `public` ahí, Cloudflare
   intenta *ejecutar* `public` como programa y falla con
   `/bin/sh: 1: public: not found`. `public` es la carpeta de salida, no un comando.
2. **Retry repite el mismo commit.** Si un deploy falló por algo que ya
   arreglaste en el repo, *Retry* lo vuelve a construir igual de roto. Usa
   **Deployments → Create deployment** para tomar el último commit de `main`.
3. **El binding de D1 se pone a mano.** Aunque `wrangler.jsonc` declare la base,
   el proyecto de Pages necesita: **Settings → Bindings → Add → D1**, con
   variable `DB` y base `juancode-agenda`. Sin eso, la agenda carga vacía y el
   panel no guarda nada. Igual con el secreto `ADMIN_PASSWORD`.
