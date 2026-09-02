# 📕 El Libro JuanCode — Python desde 0

Libro digital interactivo para aprender Python desde cero. Cada capítulo termina
en un quiz, y **aprobar el quiz del capítulo N desbloquea el capítulo N+1**.
El profesor gestiona estudiantes, capítulos, ejercicios y quizzes desde su panel.

Toda la interfaz está en español.

---

## 🧱 Stack

| Pieza | Tecnología |
|---|---|
| Framework | React Router v7 (modo framework, SSR) |
| Build | Vite 7 + Tailwind CSS v4 |
| Runtime | Cloudflare Workers (`@cloudflare/vite-plugin`) |
| Base de datos | Cloudflare D1 (binding `DB`) |
| ORM / migraciones | Drizzle ORM + drizzle-kit |
| Autenticación | Better Auth (adaptador Drizzle) con cookies de sesión |
| Modo Código | Piston (ejecuta Python de verdad contra los tests) |

### 🔐 Regla de oro

**Calificar, sumar XP y desbloquear ocurre SIEMPRE en el servidor.**

- El loader del quiz manda enunciados y opciones; `correct_json` nunca sale del
  servidor antes de que el estudiante responda (`lib/bank.server.ts`,
  función `aPublica`).
- Como el quiz saca 5 preguntas al azar del banco, el loader firma la lista de
  ids con HMAC (`lib/sign.server.ts`) y el action solo califica ese juego de
  preguntas: nadie puede cambiárselas por otras.
- En el arcade, responder solo corrige. La XP se calcula al terminar,
  recalificando todo en el servidor y contando cada pregunta una sola vez, para
  que no se pueda repetir una pregunta y farmear puntos.
- El Modo Código nunca confía en el cliente: recibe el id del ejercicio y el
  código, y lee los tests de la base.

---

## 🗂️ Estructura

```
app/
├── db/
│   ├── schema.ts             ← tablas Drizzle (auth + libro + progreso)
│   └── index.ts              ← getDb(env)
├── lib/
│   ├── auth.server.ts        ← Better Auth, requireUser / requireTeacher
│   ├── bootstrap.server.ts   ← crea al profe (.dev.vars) y al estudiante demo
│   ├── progress.server.ts    ← reglas de desbloqueo y estado de capítulos
│   ├── bank.server.ts        ← banco: selección y calificación de los 4 tipos
│   ├── sign.server.ts        ← firma HMAC de las preguntas servidas
│   ├── gamification.server.ts← XP, rachas e insignias (único que escribe stats)
│   ├── niveles.ts            ← niveles e insignias (puro, va también al cliente)
│   ├── arcade.ts             ← configuración de los modos del arcade
│   ├── piston.server.ts      ← Modo Código
│   └── format.ts
├── components/               ← nav, admin shell, UI (confetti, barras, badges)
├── routes/
│   ├── login.tsx             ← cards "Estudiante" y "Soy el profe"
│   ├── cambiar-password.tsx  ← cambio forzado en el primer ingreso
│   ├── libro.tsx             ← portada + índice agrupado por partes
│   ├── capitulo.tsx          ← lector (sidebar, contenido, ejercicios, quiz)
│   ├── quiz.tsx              ← quiz + calificación en servidor
│   ├── admin.tsx             ← dashboard del profe
│   ├── admin.estudiantes.tsx
│   ├── admin.estudiante.tsx  ← historial + desbloqueos manuales
│   ├── admin.capitulos.tsx
│   ├── admin.ejercicios.tsx
│   ├── admin.quiz.tsx
│   ├── admin.banco.tsx       ← banco de preguntas (+ importar / exportar)
│   ├── admin.ejercicio.tsx   ← tests y código inicial de un ejercicio
│   ├── practica.tsx          ← hub de práctica
│   ├── practica.simulacro-quiz.tsx
│   ├── practica.simulacro-parcial.tsx
│   ├── practica.arcade.tsx / .modo.tsx / .codigo.tsx
│   ├── perfil.tsx · ranking.tsx
│   └── api.probar.tsx        ← ruta de recurso del Modo Código
└── routes.ts
content/                      ← el libro escrito a mano (fuente de verdad)
├── libro.json                ← partes y ficha de cada capítulo
├── chapters/NN-slug.html     ← cuerpo del capítulo
├── bank/NN.json              ← banco de preguntas
└── exercises/NN.json         ← ejercicios
scripts/build-contenido.mjs   ← genera seeds/contenido.sql desde content/
drizzle/                      ← migraciones incrementales de drizzle-kit
seeds/banco.sql               ← migra las preguntas viejas al banco (una vez)
seeds/contenido.sql           ← GENERADO: no editar a mano
workers/app.ts                ← entrada del Worker
wrangler.jsonc
```

---

## 🚀 Setup local

### 1. Instalar dependencias

```bash
npm install
```

### 2. Crear la base de datos D1

```bash
npx wrangler d1 create libro-juancode-db
```

El comando imprime algo así:

```jsonc
{
  "binding": "DB",
  "database_name": "libro-juancode-db",
  "database_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

Copia ese `database_id` dentro de `wrangler.jsonc`, reemplazando
`REEMPLAZA_CON_TU_DATABASE_ID`:

```jsonc
"d1_databases": [
  {
    "binding": "DB",
    "database_name": "libro-juancode-db",
    "database_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "migrations_dir": "drizzle"
  }
]
```

> Los assets estáticos (`build/client`) los enlaza automáticamente
> `@cloudflare/vite-plugin` al construir; no hace falta declararlos a mano.

### 3. Secretos

Copia `.dev.vars.example` a `.dev.vars` (ese archivo NO se sube al repo):

```bash
cp .dev.vars.example .dev.vars
```

```env
TEACHER_USERNAME=juancode
TEACHER_PASSWORD=tu-clave-de-profe
BETTER_AUTH_SECRET=una-cadena-larga-y-aleatoria

# Modo Código (opcional)
CODE_MODE_ENABLED=false
PISTON_URL=https://emkc.org/api/v2/piston/execute
```

Para generar el secreto:

```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### 4. Migraciones y seed

```bash
npm run db:migrate:local     # crea las tablas en la D1 local
npm run db:seed:local        # esqueleto + banco viejo + contenido de content/
```

`db:seed:local` hace tres cosas seguidas:

1. `npm run content:build` — lee `content/` y genera `seeds/contenido.sql`.
2. Migra al banco las preguntas que existieran en el formato viejo (en una base
   nueva no hace nada).
3. Aplica el contenido: partes, capítulos, ejercicios, quizzes y banco.

**Es idempotente**: se puede correr las veces que haga falta. Edita un archivo
de `content/`, vuelve a seedear y la base queda igual al archivo. Solo se
reescriben las filas con `source = 'seed'`; lo que el profe escriba desde
`/admin` queda marcado como `'profe'` y no se toca.

### 5. Correr

```bash
npm run dev
```

Abre <http://localhost:5173>. La primera visita a `/login` **aprovisiona sola**:

- la cuenta del profesor con lo que pusiste en `.dev.vars`
- un estudiante demo: usuario `demo`, contraseña `demo123`

(Se hace ahí y no en el `seed.sql` porque el hash de la contraseña lo tiene que
generar Better Auth. Si cambias `TEACHER_PASSWORD`, se resincroniza sola en el
siguiente `/login`.)

---

## ☁️ Deploy a Cloudflare

```bash
# 1. Migraciones y seed en la base remota
npm run db:migrate:remote
npm run db:seed:remote

# 2. Secretos de producción
npx wrangler secret put TEACHER_USERNAME
npx wrangler secret put TEACHER_PASSWORD
npx wrangler secret put BETTER_AUTH_SECRET

# 3. Build + deploy
npm run deploy
```

`npm run deploy` corre `react-router build` y luego `wrangler deploy`.

---

## 💻 Modo Código (ejecutar Python de verdad)

Con el Modo Código encendido, los ejercicios que tengan casos de prueba muestran
un botón **▶ Probar mi código**: el estudiante escribe Python, el servidor lo
ejecuta contra cada test y le muestra qué salió y qué se esperaba.

### Encenderlo

```env
CODE_MODE_ENABLED=true
PISTON_URL=https://tu-instancia-de-piston/api/v2/piston/execute
```

En producción:

```bash
npx wrangler secret put CODE_MODE_ENABLED   # true
npx wrangler secret put PISTON_URL
```

### ⚠️ La instancia pública de Piston ya no sirve

Desde el **15 de febrero de 2026** `https://emkc.org/api/v2/piston/execute`
responde `401` a quien no esté en su lista blanca. Hay que montar una propia
(es un `docker run`) y apuntar `PISTON_URL` ahí:

```bash
docker run -d --name piston -p 2000:2000 --privileged ghcr.io/engineer-man/piston
# y luego, dentro del contenedor, instalar el runtime de Python
docker exec piston /piston/cli/index.js ppman install python 3.10.0
```

`PISTON_URL=http://localhost:2000/api/v2/execute`

Si el motor rechaza la petición, la app **no se rompe**: el estudiante ve un
aviso explicando que el Modo Código no está disponible y el resto del libro
sigue funcionando igual. Con `CODE_MODE_ENABLED=false` el botón ni aparece y
el simulacro de parcial vuelve al checklist de autocalificación.

### Dónde aparece

| Sitio | Qué hace |
|---|---|
| Lector del capítulo | `▶ Probar mi código` en cada ejercicio con tests |
| Simulacro de parcial | Botón por punto; la nota sale sola de los tests |
| Arcade 💻 Modo código | Un ejercicio al azar con cronómetro y XP por dificultad |

Detalles: timeout de 10 s por ejecución, **20 ejecuciones por minuto y por
estudiante**, y cada intento queda guardado en la tabla `code_runs`. La salida
se compara normalizada (se ignoran espacios al final de línea y saltos
sobrantes), así que un enter de más no reprueba a nadie.

---

## ✍️ Escribir contenido

El libro vive en `content/`, no en la base de datos:

```
content/libro.json              partes y ficha de cada capítulo
content/chapters/07-ciclo-while.html
content/bank/07.json
content/exercises/07.json
```

Después de editar cualquiera de esos archivos:

```bash
npm run db:seed:local     # o :remote
```

`scripts/build-contenido.mjs` valida el contenido antes de generar el SQL
(que el `option_id` correcto exista, que `line_number` esté en rango, que cada
pregunta tenga explicación…) y **no genera nada si algo está mal**, diciendo
exactamente qué archivo y qué pregunta.

Un capítulo pasa a `published = true` solo cuando tiene las tres cosas: cuerpo,
banco y ejercicios. Mientras falte una, sigue siendo borrador y los estudiantes
no lo ven.

---

## 🌐 Conectar el dominio libro.juancode.co

1. En el dashboard de Cloudflare, el dominio `juancode.co` debe estar agregado
   como zona (sus nameservers apuntando a Cloudflare).
2. Añade la ruta en `wrangler.jsonc`:

   ```jsonc
   "routes": [
     { "pattern": "libro.juancode.co", "custom_domain": true }
   ]
   ```

3. Vuelve a desplegar:

   ```bash
   npm run deploy
   ```

   Cloudflare crea el registro DNS y el certificado TLS del subdominio solo.

Alternativa por dashboard: **Workers & Pages → libro-juancode → Settings →
Domains & Routes → Add → Custom domain →** `libro.juancode.co`.

---

## 📜 Scripts

| Script | Qué hace |
|---|---|
| `npm run dev` | Servidor de desarrollo (Vite + Workers local) |
| `npm run build` | Build de producción |
| `npm run deploy` | Build + `wrangler deploy` |
| `npm run db:generate` | Genera una migración nueva desde `app/db/schema.ts` |
| `npm run db:migrate:local` | Aplica migraciones a la D1 local |
| `npm run db:migrate:remote` | Aplica migraciones a la D1 de Cloudflare |
| `npm run db:seed:local` | Carga el contenido del libro en local |
| `npm run db:seed:remote` | Carga el contenido del libro en remoto |
| `npm run content:build` | Regenera `seeds/contenido.sql` desde `content/` |
| `npm run cf-typegen` | Regenera los tipos de bindings y de rutas |
| `npm run typecheck` | Tipos + rutas |
| `npm run check` | typecheck + build + `wrangler deploy --dry-run` |

---

## 📚 Contenido del libro

Seis partes, veinticuatro capítulos:

| Parte | Capítulos |
|---|---|
| 🌱 I — Fundamentos | 1 🐍 ¿Qué es programar?, 2 📦 Variables y tipos de datos, 3 ⌨️ input() y conversiones, 4 🧮 Operadores, 5 📝 Strings a fondo |
| 🔀 II — Control de flujo | 6 🔀 Condicionales, 7 ⏳ while, 8 🔢 for y range(), 9 🎛️ break, continue y anidados |
| 📚 III — Estructuras de datos | 10 📋 Listas, 11 🎯 Tuplas y sets, 12 🗂️ Diccionarios, 13 ⚡ Comprehensions |
| 🧰 IV — Código organizado | 14 🧰 Funciones, 15 🛡️ Errores y excepciones, 16 📚 Módulos y pip, 17 📁 Archivos |
| 🏛️ V — POO | 18 🏛️ Clases y objetos, 19 🧬 Herencia y métodos especiales |
| 🚀 VI — Mundo real | 20 🏗️ Sistema Bancario, 21 🗄️ SQL, 22 🐼 Pandas, 23 🤖 IA aplicada, 24 🚀 FastAPI y despliegue |

Los **24 capítulos** están escritos y publicados. Cada uno trae:

- el cuerpo del capítulo con gancho, secciones paso a paso, los tres errores
  típicos, el patrón y la chuleta;
- **4 ejercicios** de fácil a difícil, con solución documentada al estilo
  universitario (`'''` de encabezado, `#Inicio` / `#Fin` y comentarios del *por qué*);
- un **banco de preguntas** (mínimo 15 en los capítulos 1–10 y 10 del 11 al 24)
  mezclando los cuatro tipos: `mcq`, `predict_output`, `find_bug` y `parsons`,
  cada una con su explicación.

En total: **314 preguntas de banco y 96 ejercicios**. El quiz de cada capítulo
saca **5 preguntas al azar** del banco en cada intento, así que dos intentos
nunca son iguales.

Un capítulo pasa a `published = true` solo cuando tiene cuerpo, banco y
ejercicios. El profe puede despublicar cualquiera desde `/admin/capitulos`.

`npm run content:verificar` corre cada solución documentada contra sus propios
tests (**102/102 en verde**). Quedan sin verificación automática los 3
ejercicios de salida libre de los capítulos 1 y 5, y los 12 de los capítulos
22–24, porque pandas, fastapi y las llamadas de red no corren en el verificador.

---

## 🧠 Reglas de negocio

- El capítulo **1 siempre está desbloqueado** para todo estudiante.
- El capítulo **N > 1** está desbloqueado si existe `unlock(user, N)`. Ese unlock
  nace de dos formas:
  - `source = 'quiz'` → el estudiante aprobó el quiz del capítulo N-1 con
    `score >= passing_score`;
  - `source = 'teacher'` → el profe lo abrió a mano desde `/admin/estudiante/:id`.
- Los **reintentos son ilimitados** y se guardan todos los intentos en
  `quiz_attempts` (fecha, capítulo, score, respuestas).
- Si un estudiante entra por URL a un capítulo bloqueado, se le redirige a
  `/libro` con el aviso *"Aprueba el quiz del capítulo anterior 🔒"*.
- El profesor ve todos los capítulos, publicados o no, sin candados.

---

## 🎨 Identidad JuanCode

- Fondo `#0b0b16` con glows radiales cyan / magenta / púrpura.
- Paleta: cyan `#00E5FF`, magenta `#FF4DFF`, púrpura `#b975ff`, verde `#34e07a`,
  naranja `#ffa94d`, dorado `#ffd43b`.
- Tipografías: **Sora** (títulos, 800), **Manrope** (cuerpo), **JetBrains Mono**
  (código y etiquetas).
- Cards glassmorphism, botones pill, títulos con degradado cyan→magenta,
  candados en gris apagado y borde verde en los capítulos completados.
- El lector usa un ancho de lectura de ~800px con interlineado generoso.

Los estilos base y las utilidades (`jc-glass`, `jc-btn`, `jc-prosa`, …) están en
`app/app.css`.

---

## 🗃️ Nota sobre el esquema de usuarios

Better Auth guarda el hash de la contraseña en su tabla `accounts`
(columna `password`, fila con `provider_id = 'credential'`), no en `users`. El
resto de campos del usuario —`name`, `username`, `role`, `must_change_password`,
`created_at`— sí viven en `users`, como en el diseño original. Las tablas
`sessions`, `accounts` y `verifications` son las que Better Auth necesita para
funcionar.
