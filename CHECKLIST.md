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

- [ ] Esquema `user_stats`
- [ ] Reglas de XP en el servidor
- [ ] Niveles e insignias
- [ ] `/practica/arcade` — Relámpago · Detective · Rompecabezas · Sorpresa · Reto del día
- [ ] `/perfil`
- [ ] `/ranking` (ocultable por el profe)
- [ ] Dashboard del profe con XP, nivel, racha y último arcade

---

## Fase C — Modo Código (Piston) + contenido completo

- [ ] Ejecución de Python contra Piston + tabla `code_runs`
- [ ] `▶ Probar mi código` en el lector, en el parcial y en el arcade
- [ ] Seed idempotente desde `content/chapters`, `content/bank`, `content/exercises`
- [ ] Los 24 capítulos escritos, con banco y ejercicios
- [ ] README con `PISTON_URL` y `CODE_MODE_ENABLED`
