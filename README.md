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

### 🔐 Regla de oro

**La calificación de quizzes y la creación de desbloqueos ocurren SIEMPRE en el
servidor.** El loader de `/libro/capitulo/:number/quiz` nunca envía `is_correct`
al navegador: solo manda el enunciado y los textos de las opciones. El `action`
del mismo archivo compara contra la base de datos, guarda el intento y, si el
score alcanza el `passing_score`, crea el `unlock` del capítulo siguiente.
Ver `app/routes/quiz.tsx`.

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
│   └── admin.quiz.tsx
└── routes.ts
drizzle/0000_init.sql         ← migración generada por drizzle-kit
seeds/seed.sql                ← las 6 partes y los 24 capítulos del libro
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
```

Para generar el secreto:

```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### 4. Migraciones y seed

```bash
npm run db:migrate:local     # crea las tablas en la D1 local
npm run db:seed:local        # inserta las 6 partes y los 24 capítulos
```

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

Los capítulos **1 y 2** vienen publicados con contenido real, 2 ejercicios y un
quiz de 5 preguntas cada uno (`passing_score` 80). Del **3 al 24** son
placeholders con título, emoji y descripción, en estado borrador
(`published = false`): no aparecen para los estudiantes hasta que el profe los
publique desde `/admin/capitulos`.

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
