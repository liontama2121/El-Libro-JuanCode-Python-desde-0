# ✅ CHECKLIST — El Libro JuanCode

> Se marca cuando está **escrito, con tipos limpios y probado a mano** con el
> estudiante demo (`demo` / `demo123`) o con el profe.

---

## Fase 1 — base (hecha antes de este plan)

- [x] Lector `/libro` con índice por partes y desbloqueo por quiz o manual
- [x] Panel `/admin` (estudiantes, capítulos, ejercicios, quizzes)
- [x] Calificación y desbloqueos siempre en el servidor

---

## Fase A — Banco de preguntas + simulacros

### Esquema
- [x] `question_bank` (mcq · predict_output · find_bug · parsons)
- [x] `practice_attempts`
- [x] `exercises.tests_json` y `exercises.starter_code`
- [x] Migración incremental `drizzle/0001_banco_y_practica.sql`
- [x] Migración de datos: `questions`/`options` viejas → banco (`seeds/banco.sql`)

### Quiz del capítulo
- [x] Saca 5 preguntas ALEATORIAS del banco en cada intento
- [x] Conserva `passing_score` y la regla de desbloqueo del capítulo siguiente
- [x] Las preguntas servidas van firmadas (HMAC) para que no se puedan cambiar
- [x] `correct_json` nunca sale del servidor antes de calificar

### Estudiante
- [x] `/practica` — hub con las tres tarjetas
- [x] `/practica/simulacro-quiz` — capítulos, 10/20/30, cronómetro opcional
- [x] Resultado: score, desglose por capítulo, revisión de falladas, repetir falladas
- [x] Guarda `practice_attempts` y NO desbloquea capítulos
- [x] `/practica/simulacro-parcial` — 4 puntos (1 fácil, 2 medios, 1 difícil), 90 min
- [x] Editor de código con números de línea y Tab = 4 espacios
- [x] Soluciones documentadas + checklist de autocalificación

### Profesor
- [x] `/admin/banco` — filtros por capítulo/tipo/dificultad
- [x] Formulario dinámico por tipo + vista previa de lo que verá el estudiante
- [x] Activar / desactivar / eliminar
- [x] Importar JSON masivo con errores por fila
- [x] Exportar JSON (`/admin/banco/export`, ruta de recurso)
- [x] `/admin/ejercicio/:id` — tabla de tests (stdin / salida esperada) y `starter_code`

---

## Fase B — Arcade + gamificación

### Esquema
- [x] `user_stats` (xp, level, streak_days, best_streak, last_activity_date, badges_json)
- [x] `settings` (por ahora: mostrar u ocultar el ranking)
- [x] Migración incremental `drizzle/0002_gamificacion.sql`

### XP y niveles (todo en el servidor, `lib/gamification.server.ts`)
- [x] +100 al aprobar el quiz de un capítulo, **solo la primera vez**
- [x] +5 por correcta en el simulacro de quiz
- [x] +10 / +20 / +30 por acierto en arcade según dificultad
- [x] +50% mientras la racha de aciertos seguidos sea ≥ 5
- [x] +25 el primer rato de cada día; la racha diaria se pierde al saltarse un día
- [x] Niveles 🌱 Novato · 📦 Aprendiz · 💻 Programador · 🧠 Hacker · 🏆 Maestro JuanCode
- [x] Barra de nivel en el nav

### Insignias
- [x] Las nueve del plan, con contadores para Cazador de bugs y Arquitecto
- [x] Toast animado al ganarlas

### Arcade
- [x] `/practica/arcade` — menú con estado del jugador
- [x] ⚡ Relámpago (60 s, predict_output, racha)
- [x] 🕵️ Detective (find_bug, 3 vidas, explicación inmediata)
- [x] 🧩 Rompecabezas (parsons, arrastrar en escritorio y ↑↓←→ en celular, 3 vidas)
- [x] 🎲 Sorpresa (mezcla de los tres, 10 preguntas)
- [x] 🗓️ Reto del día (semilla = fecha, un intento diario, tabla de posiciones)
- [x] Feedback inmediato, confetti al llevar racha, shake al fallar, sonido con toggle
- [x] La XP se paga al terminar, recalificando en el servidor: no se puede repetir
      una pregunta para farmear
- [x] Solo preguntas de capítulos desbloqueados

### Pantallas
- [x] `/perfil` — XP, nivel, rachas, insignias, historial y actividad de 30 días
- [x] `/ranking` — top por XP con el puesto propio resaltado
- [x] El profe muestra u oculta el ranking desde `/admin`
- [x] Dashboard del profe con nivel, XP, racha y último arcade

---

## Fase C — Modo Código (Piston) + contenido completo

### Modo Código
- [x] Tabla `code_runs` y `lib/piston.server.ts`
- [x] Timeout de 10 s y 20 ejecuciones por minuto y estudiante
- [x] Salida comparada normalizada (espacios y saltos sobrantes)
- [x] `/api/probar` como ruta de recurso: los tests se leen de la base
- [x] `▶ Probar mi código` en el lector del capítulo
- [x] Nota automática en el simulacro de parcial
- [x] Arcade 💻 Modo código
- [x] `CODE_MODE_ENABLED` y `PISTON_URL` documentados en el README
- [x] ⚠️ La instancia pública de Piston es whitelist-only desde el 15/02/2026:
      hay que montar una propia (documentado). Sin motor la app no se rompe.

### Pipeline de contenido
- [x] `content/libro.json`, `content/chapters`, `content/bank`, `content/exercises`
- [x] `scripts/build-contenido.mjs` valida y genera `seeds/contenido.sql`
- [x] Seed idempotente por número de capítulo
- [x] Columna `source`: el seed solo pisa lo suyo, lo del profe no se toca
- [x] Un capítulo se publica solo cuando tiene cuerpo, banco y ejercicios
- [x] `/admin/capitulo/:id/quiz` explica que el quiz sale del banco (las tablas
      `questions` / `options` quedaron como legado)
- [x] `npm run content:verificar` corre cada solución documentada contra sus
      propios tests: es el control de calidad del contenido

### Los 24 capítulos
- [x] 1 🐍 ¿Qué es programar?
- [x] 2 📦 Variables y tipos de datos
- [x] 3 ⌨️ input() y conversiones
- [x] 4 🧮 Operadores
- [x] 5 📝 Strings a fondo
- [x] 6 🔀 Condicionales
- [x] 7 ⏳ while (contadores, sumatorias y banderas)
- [x] 8 🔢 for y range()
- [x] 9 🎛️ break, continue y anidados
- [x] 10 📋 Listas
- [x] 11 🎯 Tuplas y sets
- [x] 12 🗂️ Diccionarios
- [x] 13 ⚡ Comprehensions
- [x] 14 🧰 Funciones
- [x] 15 🛡️ Errores y excepciones
- [x] 16 📚 Módulos, pip y entornos
- [x] 17 📁 Archivos
- [x] 18 🏛️ Clases y objetos
- [x] 19 🧬 Herencia y métodos especiales
- [ ] 20 🏗️ Proyecto: Sistema Bancario
- [ ] 21 🗄️ SQL desde cero
- [ ] 22 🐼 Pandas
- [ ] 23 🤖 IA aplicada
- [ ] 24 🚀 FastAPI y despliegue
