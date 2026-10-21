-- ============================================================================
--  CONTENIDO DEL LIBRO — generado por scripts/build-contenido.mjs
--  No editar a mano: se regenera con `npm run content:build`.
--  Solo toca las filas con source = 'seed'.
-- ============================================================================

INSERT INTO parts (number, title, emoji, track) VALUES (1, 'Los cuatro patrones', '✍️', 'nivel0')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji, track) VALUES (2, 'El contador K', '🔑', 'nivel0')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji, track) VALUES (3, 'Examen', '🎯', 'nivel0')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;

-- ── Capítulo 1: I. Llenar un vector (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 1, 'I. Llenar un vector', '📥', 'El punto de partida. Si no sabes hacer esto, no puedes hacer nada más.', '<p class="jc-plana-sub">Aprende los patrones de memoria. Cuando los dedos los escriban solos, aprobaste.</p>

<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<div class="jc-plana-intro">
  <p>Esta sección <strong>NO es para pensar — es para REPETIR</strong>. Vas a escribir los mismos patrones muchas veces, con pequeños cambios. Es la plana de primaria del programador. Cuando puedas escribir el esqueleto sin mirar, estás listo para el examen del juez.</p>
</div>

<h2>Cómo se hace una plana</h2>

<ol>
  <li>Lee el esqueleto del patrón <strong>una vez</strong>, despacio.</li>
  <li>Tápalo y escríbelo <strong>tres veces</strong> en un cuaderno o en el editor, sin mirar.</li>
  <li>Haz los ejercicios del patrón (están al final de cada capítulo, con el número del patrón: <code>II.3</code>, <code>V-B.2</code>…). En cada uno cambia <strong>solo</strong> lo que el enunciado pide.</li>
  <li>Si te equivocas en el esqueleto, vuelve al paso 2. Sin vergüenza: así se aprende la plana.</li>
</ol>

<p>Todos los ejercicios leen como el juez: primero <code>N</code>, después los datos, <strong>uno por línea</strong>, con <code>input()</code> sin mensajes. El botón <em>Ver solución</em> está ahí para comparar <strong>después</strong> de intentarlo, no antes.</p>

<table>
  <thead>
    <tr><th>Siempre así</th><th>Para qué</th></tr>
  </thead>
  <tbody>
    <tr><td><code>vector = [0] * n</code></td><td>Crear un vector de n enteros</td></tr>
    <tr><td><code>nombres = [""] * n</code></td><td>Crear un vector de n textos</td></tr>
    <tr><td><code>for i in range(n):</code></td><td>Recorrer por índice</td></tr>
    <tr><td><code>vector[i] = valor</code></td><td>Guardar en una casilla</td></tr>
    <tr><td><code>k = 0</code> … <code>k = k + 1</code></td><td>Contador manual para copiar a un vector nuevo</td></tr>
    <tr><td><code>print("Total: " + str(total))</code></td><td>Pegar texto y números (o <code>print(a, b, c)</code>)</td></tr>
  </tbody>
</table>

<h2>El esqueleto</h2>

<p>El punto de partida. Si no sabes hacer esto, no puedes hacer nada más. <strong>Memorízalo en los dedos.</strong></p>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto I · escríbelo 3 veces</p>
<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())</code></pre>
</div>

<p>Cuatro líneas que van al principio de <strong>todos</strong> los ejercicios de este capítulo. Lo que cambia entre ejercicios es lo que viene después:</p>

<table>
  <thead>
    <tr><th>Quiero…</th><th>Escribo después del esqueleto</th></tr>
  </thead>
  <tbody>
    <tr><td>Todos, en orden</td><td><code>for i in range(n):</code> → <code>print(vector[i])</code></td></tr>
    <tr><td>Todos, al revés</td><td><code>for i in range(n - 1, -1, -1):</code> → <code>print(vector[i])</code></td></tr>
    <tr><td>El primero / el último</td><td><code>vector[0]</code> / <code>vector[n - 1]</code></td></tr>
    <tr><td>El del medio</td><td><code>vector[n // 2]</code></td></tr>
    <tr><td>Textos en vez de números</td><td><code>[""] * n</code> y <code>input()</code> sin <code>int()</code></td></tr>
  </tbody>
</table>

<p>Ejercicios: <strong>I.1 a I.6</strong>.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 1 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 1 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'I.1 — Imprimir tal cual', 'facil', '<p>Lee <code>N</code> y luego <code>N</code> números enteros, uno por línea. Guárdalos en un vector e imprímelos tal cual, uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
5
8
-2
0
7</code></pre><p>Salida:</p><pre><code>5
8
-2
0
7</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

for i in range(n):
    print(vector[i])</code></pre><p>Dos ciclos iguales: el primero LLENA, el segundo IMPRIME. Nunca mezcles los dos trabajos al empezar.</p>', '[{"stdin":"5\n5\n8\n-2\n0\n7\n","expected_output":"5\n8\n-2\n0\n7"},{"stdin":"3\n1\n2\n3\n","expected_output":"1\n2\n3"},{"stdin":"1\n42\n","expected_output":"42"}]', '# I.1 — Imprimir tal cual
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'I.2 — Imprimir al revés', 'facil', '<p>Lee <code>N</code> números y guárdalos en un vector. Imprímelos en orden <strong>inverso</strong>: del último al primero, uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
5
8
-2
0
7</code></pre><p>Salida:</p><pre><code>7
0
-2
8
5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

for i in range(n - 1, -1, -1):
    print(vector[i])</code></pre><p><code>range(n - 1, -1, -1)</code> arranca en la última posición y baja hasta 0. El <code>-1</code> del medio es el tope: no entra.</p>', '[{"stdin":"5\n5\n8\n-2\n0\n7\n","expected_output":"7\n0\n-2\n8\n5"},{"stdin":"3\n1\n2\n3\n","expected_output":"3\n2\n1"},{"stdin":"1\n9\n","expected_output":"9"}]', '# I.2 — Imprimir al revés
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'I.3 — El primero y el último', 'facil', '<p>Lee <code>N</code> números. Imprime solo el <strong>primero</strong> y el <strong>último</strong> del vector, cada uno en su línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
5
8
-2
0
7</code></pre><p>Salida:</p><pre><code>5
7</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

print(vector[0])
print(vector[n - 1])</code></pre><p>La última posición es <code>n - 1</code>, no <code>n</code>: con 5 números las posiciones van de 0 a 4.</p>', '[{"stdin":"5\n5\n8\n-2\n0\n7\n","expected_output":"5\n7"},{"stdin":"2\n4\n10\n","expected_output":"4\n10"},{"stdin":"3\n6\n6\n1\n","expected_output":"6\n1"}]', '# I.3 — El primero y el último
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'I.4 — El del medio', 'facil', '<p>Lee <code>N</code> números. Imprime el que está en la posición <code>N // 2</code>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
5
8
-2
0
7</code></pre><p>Salida:</p><pre><code>-2</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

print(vector[n // 2])</code></pre><p><code>//</code> es división entera: con 5 elementos da 2, con 4 da 2 también.</p>', '[{"stdin":"5\n5\n8\n-2\n0\n7\n","expected_output":"-2"},{"stdin":"4\n4\n10\n20\n30\n","expected_output":"20"},{"stdin":"1\n9\n","expected_output":"9"}]', '# I.4 — El del medio
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, 'I.5 — Vector de nombres', 'facil', '<p>Lee <code>N</code> y luego <code>N</code> nombres, uno por línea. Guárdalos en un vector de textos e imprímelos en el mismo orden.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>3
Ana
Luis
Marta</code></pre><p>Salida:</p><pre><code>Ana
Luis
Marta</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
</code></pre>', '<pre><code>n = int(input())
nombres = [""] * n
for i in range(n):
    nombres[i] = input()

for i in range(n):
    print(nombres[i])</code></pre><p>Para textos el vector nace con <code>[""] * n</code> y se lee con <code>input()</code> SIN <code>int()</code>.</p>', '[{"stdin":"3\nAna\nLuis\nMarta\n","expected_output":"Ana\nLuis\nMarta"},{"stdin":"1\nPedro\n","expected_output":"Pedro"},{"stdin":"4\nSol\nJuan\nEva\nTom\n","expected_output":"Sol\nJuan\nEva\nTom"}]', '# I.5 — Vector de nombres
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 6, 'I.6 — Cada número con su posición', 'facil', '<p>Lee <code>N</code> números. Imprime cada uno con su posición, con este formato exacto:</p><pre><code>Posicion 0: 5</code></pre><p>Arma el texto con <code>+</code> y <code>str()</code>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>3
5
8
-2</code></pre><p>Salida:</p><pre><code>Posicion 0: 5
Posicion 1: 8
Posicion 2: -2</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

for i in range(n):
    print("Posicion " + str(i) + ": " + str(vector[i]))</code></pre><p>Un número no se puede pegar a un texto con <code>+</code>: primero pasa por <code>str()</code>. Ojo con los espacios dentro de las comillas.</p>', '[{"stdin":"3\n5\n8\n-2\n","expected_output":"Posicion 0: 5\nPosicion 1: 8\nPosicion 2: -2"},{"stdin":"1\n10\n","expected_output":"Posicion 0: 10"},{"stdin":"4\n1\n2\n3\n4\n","expected_output":"Posicion 0: 1\nPosicion 1: 2\nPosicion 2: 3\nPosicion 3: 4"}]', '# I.6 — Cada número con su posición
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'En este curso, ¿cómo se crea un vector para guardar n números enteros?', NULL, '{"options":[{"id":"a","text":"vector = [0] * n"},{"id":"b","text":"vector = []"},{"id":"c","text":"vector = [n]"},{"id":"d","text":"vector = [0, n]"}]}', '{"option_id":"a"}', '[0] * n crea de una vez n casillas en cero, que luego se llenan por índice con vector[i] = valor. [n] es un vector de UNA casilla que guarda el número n.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Hay que guardar n nombres. ¿Cómo nace el vector?', NULL, '{"options":[{"id":"a","text":"nombres = [\"\"] * n"},{"id":"b","text":"nombres = [0] * n"},{"id":"c","text":"nombres = \"\" * n"},{"id":"d","text":"nombres = [n] * \"\""}]}', '{"option_id":"a"}', 'Para textos el relleno es el texto vacío "". "" * n (sin corchetes) es un solo texto vacío, no un vector.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'vector = [4, 7, 1]
for i in range(2, -1, -1):
    print(vector[i])', '{"options":[{"id":"a","text":"1\n7\n4"},{"id":"b","text":"4\n7\n1"},{"id":"c","text":"7\n4"},{"id":"d","text":"1\n7"}]}', '{"option_id":"a"}', 'range(2, -1, -1) da 2, 1, 0: recorre del último al primero.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Debe imprimir el ÚLTIMO número leído. ¿En qué línea está el error?', NULL, '{"lines":["n = int(input())","vector = [0] * n","for i in range(n):","    vector[i] = int(input())","print(vector[n])"]}', '{"line_number":5}', 'Con n casillas las posiciones van de 0 a n - 1. vector[n] se sale: IndexError. Es vector[n - 1].', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'facil', 'Completa de memoria el esqueleto I.', NULL, '{"code":"n = ___1___\nvector = ___2___\nfor i in range(___3___):\n    vector[i] = int(input())","blanks":[{"id":"1","pista":"leer N como entero"},{"id":"2","pista":"vector de n ceros"},{"id":"3","pista":"cuántas vueltas"}]}', '{"answers":{"1":["int(input())"],"2":["[0] * n","[0]*n"],"3":["n"]}}', 'Leer n, crear el vector con [0] * n y llenarlo casilla por casilla.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Si n = 5, ¿cuál es la posición del último elemento?', NULL, '{"options":[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"-5"}]}', '{"option_id":"a"}', 'Las posiciones arrancan en 0: van de 0 a 4.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'nivel0';

-- ── Capítulo 2: II. Recorrer y contar (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 2, 'II. Recorrer y contar', '🔢', 'Cuántos cumplen una condición. El 70% de los ejercicios de examen.', '<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<p>Cuenta cuántos elementos cumplen una condición. Es el <strong>70% de los ejercicios de examen</strong>.</p>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto II · escríbelo 3 veces</p>
<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condición):
        cuenta = cuenta + 1

print(cuenta)</code></pre>
</div>

<p>La plana de este patrón es cambiar <strong>solo la condición</strong>:</p>

<table>
  <thead>
    <tr><th>El enunciado dice…</th><th>Condición</th></tr>
  </thead>
  <tbody>
    <tr><td>positivos</td><td><code>vector[i] &gt; 0</code></td></tr>
    <tr><td>negativos</td><td><code>vector[i] &lt; 0</code></td></tr>
    <tr><td>ceros</td><td><code>vector[i] == 0</code></td></tr>
    <tr><td>pares</td><td><code>vector[i] % 2 == 0</code></td></tr>
    <tr><td>impares</td><td><code>vector[i] % 2 == 1</code></td></tr>
    <tr><td>mayores a 10</td><td><code>vector[i] &gt; 10</code></td></tr>
    <tr><td>divisibles por 3</td><td><code>vector[i] % 3 == 0</code></td></tr>
    <tr><td>mayores de edad</td><td><code>edades[i] &gt;= 18</code></td></tr>
  </tbody>
</table>

<p>Tres reglas que no se negocian: <code>cuenta = 0</code> va <strong>antes</strong> del <code>for</code>; <code>cuenta = cuenta + 1</code> va <strong>dentro</strong> del <code>if</code>; el <code>print</code> va <strong>afuera</strong>, al final.</p>

<p>Ejercicios: <strong>II.1 a II.8</strong>.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 1 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 2 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'II.1 — Contar positivos', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son <strong>positivos</strong> (mayores que 0).</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>4</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] &gt; 0:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] &gt; 0</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"4"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"3"},{"stdin":"3\n0\n0\n6\n","expected_output":"1"}]', '# II.1 — Contar positivos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'II.2 — Contar negativos', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son <strong>negativos</strong> (menores que 0).</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>2</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] &lt; 0:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] &lt; 0</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"2"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"1"},{"stdin":"3\n0\n0\n6\n","expected_output":"0"}]', '# II.2 — Contar negativos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'II.3 — Contar ceros', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son exactamente <strong>cero</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>2</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] == 0:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] == 0</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"2"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"0"},{"stdin":"3\n0\n0\n6\n","expected_output":"2"}]', '# II.3 — Contar ceros
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'II.4 — Contar pares', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son <strong>pares</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] % 2 == 0:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] % 2 == 0</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"5"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"2"},{"stdin":"3\n0\n0\n6\n","expected_output":"3"}]', '# II.4 — Contar pares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, 'II.5 — Contar impares', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son <strong>impares</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] % 2 == 1:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] % 2 == 1</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"3"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"2"},{"stdin":"3\n0\n0\n6\n","expected_output":"0"}]', '# II.5 — Contar impares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 6, 'II.6 — Contar mayores a 10', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son <strong>mayores a 10</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>2</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] &gt; 10:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] &gt; 10</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"2"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"1"},{"stdin":"3\n0\n0\n6\n","expected_output":"0"}]', '# II.6 — Contar mayores a 10
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 7, 'II.7 — Contar divisibles por 3', 'facil', '<p>Lee <code>N</code> números. Imprime cuántos son <strong>divisibles por 3</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>8
4
-3
0
12
7
-8
0
15</code></pre><p>Salida:</p><pre><code>5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] % 3 == 0:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>Lo único que cambió respecto al esqueleto es la condición: <code>vector[i] % 3 == 0</code>. Todo lo demás es la plana.</p>', '[{"stdin":"8\n4\n-3\n0\n12\n7\n-8\n0\n15\n","expected_output":"5"},{"stdin":"4\n9\n2\n-11\n30\n","expected_output":"2"},{"stdin":"3\n0\n0\n6\n","expected_output":"3"}]', '# II.7 — Contar divisibles por 3
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 8, 'II.8 — Contar mayores de edad', 'facil', '<p>Lee <code>N</code> edades. Imprime cuántas personas son <strong>mayores de edad</strong> (18 o más).</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
17
18
25
9
40</code></pre><p>Salida:</p><pre><code>3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

cuenta = 0
for i in range(n):
    if vector[i] (condicion):
        cuenta = cuenta + 1

print(cuenta)</code></pre>', '<pre><code>n = int(input())
edades = [0] * n
for i in range(n):
    edades[i] = int(input())

cuenta = 0
for i in range(n):
    if edades[i] &gt;= 18:
        cuenta = cuenta + 1

print(cuenta)</code></pre><p>El vector cambió de nombre (<code>edades</code>) y la condición es <code>&gt;= 18</code>: con 18 ya cuenta. El esqueleto es idéntico.</p>', '[{"stdin":"5\n17\n18\n25\n9\n40\n","expected_output":"3"},{"stdin":"2\n5\n12\n","expected_output":"0"},{"stdin":"1\n18\n","expected_output":"1"}]', '# II.8 — Contar mayores de edad
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'El enunciado dice: "imprime cuántos estudiantes sacaron más de 80". ¿Qué patrón es?', NULL, '{"options":[{"id":"a","text":"II. Recorrer y contar"},{"id":"b","text":"III. Recorrer y acumular"},{"id":"c","text":"IV. Buscar máximo"},{"id":"d","text":"V. Copiar con k"}]}', '{"option_id":"a"}', '"Cuántos" = contar: cuenta = cuenta + 1 dentro de un if.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'vector = [3, -1, 0, 5]
cuenta = 0
for i in range(4):
    if vector[i] > 0:
        cuenta = cuenta + 1
print(cuenta)', '{"options":[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"8"}]}', '{"option_id":"a"}', 'Solo 3 y 5 son mayores que 0. El 0 no es positivo.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Debe contar los negativos. ¿En qué línea está el error?', NULL, '{"lines":["for i in range(n):","    cuenta = 0","    if vector[i] < 0:","        cuenta = cuenta + 1","print(cuenta)"]}', '{"line_number":2}', 'El contador nace dentro del for y vuelve a 0 en cada vuelta. cuenta = 0 va ANTES del ciclo.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué condición cuenta los IMPARES?', NULL, '{"options":[{"id":"a","text":"vector[i] % 2 == 1"},{"id":"b","text":"vector[i] / 2 == 1"},{"id":"c","text":"vector[i] // 2 == 1"},{"id":"d","text":"vector[i] % 1 == 2"}]}', '{"option_id":"a"}', '% da el residuo: un impar deja residuo 1 al dividir entre 2.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'edades = [17, 18, 30, 12]
cuenta = 0
for i in range(4):
    if edades[i] >= 18:
        cuenta = cuenta + 1
print(cuenta)', '{"options":[{"id":"a","text":"2"},{"id":"b","text":"1"},{"id":"c","text":"3"},{"id":"d","text":"4"}]}', '{"option_id":"a"}', '18 y 30 cumplen >= 18. El 18 cuenta porque la condición incluye el igual.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'facil', 'Completa el contador de divisibles por 3.', NULL, '{"code":"cuenta = ___1___\nfor i in range(n):\n    if vector[i] % 3 == 0:\n        cuenta = ___2___\nprint(cuenta)","blanks":[{"id":"1","pista":"valor inicial"},{"id":"2","pista":"sumar uno"}]}', '{"answers":{"1":["0"],"2":["cuenta + 1","cuenta+1","1 + cuenta","1+cuenta"]}}', 'El contador nace en 0 y sube de a uno dentro del if.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'nivel0';

-- ── Capítulo 3: III. Recorrer y acumular (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 3, 'III. Recorrer y acumular', '➕', 'Suma, promedio y totales.', '<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<p>Suma, promedio, totales. El patrón que resuelve <em>"imprime el total de X"</em>.</p>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto III · escríbelo 3 veces</p>
<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>
</div>

<table>
  <thead>
    <tr><th>Variación</th><th>Qué cambia</th></tr>
  </thead>
  <tbody>
    <tr><td>Promedio</td><td><code>print(suma // n)</code> al final</td></tr>
    <tr><td>Suma solo de algunos</td><td>Envolver la suma en un <code>if</code> (patrón II + III)</td></tr>
    <tr><td>Por posición</td><td>La condición mira <code>i</code>: <code>if i % 2 == 0:</code></td></tr>
    <tr><td>Multiplicación</td><td>Arranca en <code>1</code>: <code>producto = producto * vector[i]</code></td></tr>
    <tr><td>Promedio de algunos</td><td>Contar y sumar en el mismo <code>if</code>, dividir entre <code>cuenta</code></td></tr>
  </tbody>
</table>

<p>Ejercicios: <strong>III.1 a III.8</strong>.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 1 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 3 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'III.1 — Suma de todos', 'facil', '<p>Lee <code>N</code> números. Imprime la <strong>suma</strong> de todos.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
0
12
7
-8</code></pre><p>Salida:</p><pre><code>12</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre><p><code>suma</code> nace en 0 ANTES del ciclo. Si nace adentro, se borra en cada vuelta.</p>', '[{"stdin":"6\n4\n-3\n0\n12\n7\n-8\n","expected_output":"12"},{"stdin":"3\n10\n20\n30\n","expected_output":"60"},{"stdin":"1\n-5\n","expected_output":"-5"}]', '# III.1 — Suma de todos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'III.2 — Promedio entero', 'facil', '<p>Lee <code>N</code> números. Imprime el <strong>promedio</strong> usando división entera (<code>//</code>).</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
4
6
8
3</code></pre><p>Salida:</p><pre><code>5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma // n)</code></pre><p>Promedio = suma // cantidad. La división va DESPUÉS del ciclo, una sola vez.</p>', '[{"stdin":"4\n4\n6\n8\n3\n","expected_output":"5"},{"stdin":"3\n10\n20\n30\n","expected_output":"20"},{"stdin":"1\n7\n","expected_output":"7"}]', '# III.2 — Promedio entero
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'III.3 — Suma de positivos', 'facil', '<p>Lee <code>N</code> números. Imprime la suma <strong>solo de los positivos</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
0
12
7
-8</code></pre><p>Salida:</p><pre><code>23</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    if vector[i] &gt; 0:
        suma = suma + vector[i]

print(suma)</code></pre><p>Contar + sumar se combinan: el <code>if</code> del patrón II envuelve la línea del patrón III.</p>', '[{"stdin":"6\n4\n-3\n0\n12\n7\n-8\n","expected_output":"23"},{"stdin":"3\n10\n20\n30\n","expected_output":"60"},{"stdin":"1\n-5\n","expected_output":"0"}]', '# III.3 — Suma de positivos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'III.4 — Suma de pares', 'facil', '<p>Lee <code>N</code> números. Imprime la suma <strong>solo de los pares</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
0
12
7
-8</code></pre><p>Salida:</p><pre><code>8</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    if vector[i] % 2 == 0:
        suma = suma + vector[i]

print(suma)</code></pre><p>Mismo esqueleto que el anterior. Cambia la condición.</p>', '[{"stdin":"6\n4\n-3\n0\n12\n7\n-8\n","expected_output":"8"},{"stdin":"3\n10\n20\n30\n","expected_output":"60"},{"stdin":"1\n-5\n","expected_output":"0"}]', '# III.4 — Suma de pares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, 'III.5 — Suma de posiciones pares', 'medio', '<p>Lee <code>N</code> números. Imprime la suma de los que están en <strong>posiciones pares</strong> del vector (índices 0, 2, 4…).</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
0
12
7
-8</code></pre><p>Salida:</p><pre><code>11</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    if i % 2 == 0:
        suma = suma + vector[i]

print(suma)</code></pre><p>La trampa: la condición mira <code>i</code> (la posición), no <code>vector[i]</code> (el valor).</p>', '[{"stdin":"6\n4\n-3\n0\n12\n7\n-8\n","expected_output":"11"},{"stdin":"3\n10\n20\n30\n","expected_output":"40"},{"stdin":"1\n5\n","expected_output":"5"}]', '# III.5 — Suma de posiciones pares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 6, 'III.6 — Total a pagar', 'facil', '<p>Lee <code>N</code> precios de productos. Imprime el <strong>total a pagar</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>3
5000
7000
15000</code></pre><p>Salida:</p><pre><code>27000</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
precios = [0] * n
for i in range(n):
    precios[i] = int(input())

total = 0
for i in range(n):
    total = total + precios[i]

print(total)</code></pre><p>Es la suma con otros nombres. En el examen los enunciados disfrazan los patrones.</p>', '[{"stdin":"3\n5000\n7000\n15000\n","expected_output":"27000"},{"stdin":"1\n1200\n","expected_output":"1200"},{"stdin":"4\n300\n300\n300\n100\n","expected_output":"1000"}]', '# III.6 — Total a pagar
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 7, 'III.7 — Aprobados y su promedio', 'medio', '<p>Lee <code>N</code> calificaciones de 0 a 100. Se aprueba con 60 o más. Imprime en una línea cuántos aprobaron y en la siguiente el promedio (división entera) <strong>solo de los aprobados</strong>. Si nadie aprobó, el promedio es 0.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
80
45
60
99
30</code></pre><p>Salida:</p><pre><code>3
79</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
notas = [0] * n
for i in range(n):
    notas[i] = int(input())

cuenta = 0
suma = 0
for i in range(n):
    if notas[i] &gt;= 60:
        cuenta = cuenta + 1
        suma = suma + notas[i]

print(cuenta)
if cuenta &gt; 0:
    print(suma // cuenta)
else:
    print(0)</code></pre><p>Contador y acumulador viven juntos dentro del mismo <code>if</code>. El promedio divide entre <code>cuenta</code>, no entre <code>n</code>, y se protege de dividir entre 0.</p>', '[{"stdin":"5\n80\n45\n60\n99\n30\n","expected_output":"3\n79"},{"stdin":"2\n10\n20\n","expected_output":"0\n0"},{"stdin":"1\n100\n","expected_output":"1\n100"}]', '# III.7 — Aprobados y su promedio
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 8, 'III.8 — Multiplicación de todos', 'facil', '<p>Lee <code>N</code> números. Imprime la <strong>multiplicación</strong> de todos.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>3
2
3
4</code></pre><p>Salida:</p><pre><code>24</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]

print(suma)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

producto = 1
for i in range(n):
    producto = producto * vector[i]

print(producto)</code></pre><p>Para multiplicar se arranca en <strong>1</strong>. Si arrancas en 0, todo da 0.</p>', '[{"stdin":"3\n2\n3\n4\n","expected_output":"24"},{"stdin":"4\n5\n-1\n2\n10\n","expected_output":"-100"},{"stdin":"1\n7\n","expected_output":"7"}]', '# III.8 — Multiplicación de todos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Para MULTIPLICAR todos los números de un vector, ¿en qué valor arranca el acumulador?', NULL, '{"options":[{"id":"a","text":"1"},{"id":"b","text":"0"},{"id":"c","text":"vector[0] * 0"},{"id":"d","text":"n"}]}', '{"option_id":"a"}', 'Cualquier número por 0 da 0. El neutro de la multiplicación es 1, igual que el de la suma es 0.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Debe imprimir el promedio entero de los n números. ¿En qué línea está el error?', NULL, '{"lines":["suma = 0","for i in range(n):","    suma = suma + vector[i]","    print(suma // n)"]}', '{"line_number":4}', 'El print quedó dentro del ciclo: imprime n promedios parciales. El resultado va afuera, una sola vez.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'vector = [3, -2, 5, -1]
suma = 0
for i in range(4):
    if vector[i] > 0:
        suma = suma + vector[i]
print(suma)', '{"options":[{"id":"a","text":"8"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"10"}]}', '{"option_id":"a"}', 'Solo se suman 3 y 5. Los negativos no entran al if.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Para el promedio SOLO de los aprobados, ¿entre qué se divide la suma?', NULL, '{"options":[{"id":"a","text":"suma // cuenta (cuántos aprobaron)"},{"id":"b","text":"suma // n"},{"id":"c","text":"cuenta // suma"},{"id":"d","text":"suma // 2"}]}', '{"option_id":"a"}', 'El promedio de un grupo se divide entre el tamaño de ESE grupo, no entre todos.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Debe sumar los números que están en POSICIONES pares (0, 2, 4…). ¿En qué línea está el error?', NULL, '{"lines":["suma = 0","for i in range(n):","    if vector[i] % 2 == 0:","        suma = suma + vector[i]","print(suma)"]}', '{"line_number":3}', 'La condición mira el VALOR. Para la posición es if i % 2 == 0:.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'facil', 'Arma el bloque que imprime el promedio entero', NULL, '{"lines":[{"id":"l1","text":"suma = 0","indent":0},{"id":"l2","text":"for i in range(n):","indent":0},{"id":"l3","text":"suma = suma + vector[i]","indent":1},{"id":"l4","text":"print(suma // n)","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'La suma nace afuera, se acumula adentro y se divide una sola vez al final.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'nivel0';

-- ── Capítulo 4: IV. Buscar máximo / mínimo (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 4, 'IV. Buscar máximo / mínimo', '🏔️', 'El mejor, el peor, el extremo y dónde está.', '<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<p>Encontrar el mejor, el peor, el extremo. Clásico de examen.</p>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto IV · escríbelo 3 veces</p>
<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>
</div>

<p><code>mejor</code> arranca en <code>vector[0]</code>, <strong>nunca en 0</strong>. Si todos los números son negativos, un 0 inventado ganaría sin estar en el vector. Por eso el <code>for</code> arranca en 1: el primero ya está revisado.</p>

<table>
  <thead>
    <tr><th>Quiero…</th><th>Cambio</th></tr>
  </thead>
  <tbody>
    <tr><td>El menor</td><td><code>&lt;</code> en vez de <code>&gt;</code></td></tr>
    <tr><td>Mayor y menor a la vez</td><td>Dos variables y dos <code>if</code> separados en el mismo ciclo</td></tr>
    <tr><td>DÓNDE está el mayor</td><td>Guardar también <code>pos = i</code> dentro del <code>if</code>; imprimir <code>pos + 1</code></td></tr>
    <tr><td>El segundo más grande</td><td>Dos recorridos: el segundo se salta <code>pos</code></td></tr>
  </tbody>
</table>

<p>Ejercicios: <strong>IV.1 a IV.8</strong>.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 1 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 4 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'IV.1 — El mayor', 'facil', '<p>Lee <code>N</code> números. Imprime el <strong>mayor</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
15
12
7
-8</code></pre><p>Salida:</p><pre><code>15</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mayor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mayor:
        mayor = vector[i]

print(mayor)</code></pre><p><code>mayor</code> arranca en <code>vector[0]</code>, nunca en 0: con puros negativos, 0 ganaría sin estar en el vector.</p>', '[{"stdin":"6\n4\n-3\n15\n12\n7\n-8\n","expected_output":"15"},{"stdin":"3\n-5\n-2\n-9\n","expected_output":"-2"},{"stdin":"1\n6\n","expected_output":"6"}]', '# IV.1 — El mayor
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'IV.2 — El menor', 'facil', '<p>Lee <code>N</code> números. Imprime el <strong>menor</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
15
12
7
-8</code></pre><p>Salida:</p><pre><code>-8</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

menor = vector[0]
for i in range(1, n):
    if vector[i] &lt; menor:
        menor = vector[i]

print(menor)</code></pre><p>Igual al anterior con <code>&lt;</code> en vez de <code>&gt;</code>.</p>', '[{"stdin":"6\n4\n-3\n15\n12\n7\n-8\n","expected_output":"-8"},{"stdin":"3\n-5\n-2\n-9\n","expected_output":"-9"},{"stdin":"1\n6\n","expected_output":"6"}]', '# IV.2 — El menor
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'IV.3 — El mayor y el menor', 'facil', '<p>Lee <code>N</code> números. Imprime el mayor en una línea y el menor en la siguiente.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
4
-3
15
12
7
-8</code></pre><p>Salida:</p><pre><code>15
-8</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mayor = vector[0]
menor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mayor:
        mayor = vector[i]
    if vector[i] &lt; menor:
        menor = vector[i]

print(mayor)
print(menor)</code></pre><p>Dos <code>if</code> separados (no <code>elif</code>): un mismo número se revisa contra los dos.</p>', '[{"stdin":"6\n4\n-3\n15\n12\n7\n-8\n","expected_output":"15\n-8"},{"stdin":"3\n-5\n-2\n-9\n","expected_output":"-2\n-9"},{"stdin":"1\n6\n","expected_output":"6\n6"}]', '# IV.3 — El mayor y el menor
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'IV.4 — La edad del mayor', 'facil', '<p>Lee <code>N</code> edades. Imprime la edad de la persona <strong>mayor</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
17
45
30
9</code></pre><p>Salida:</p><pre><code>45</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
edades = [0] * n
for i in range(n):
    edades[i] = int(input())

mayor = edades[0]
for i in range(1, n):
    if edades[i] &gt; mayor:
        mayor = edades[i]

print(mayor)</code></pre><p>Patrón IV disfrazado.</p>', '[{"stdin":"4\n17\n45\n30\n9\n","expected_output":"45"},{"stdin":"1\n20\n","expected_output":"20"},{"stdin":"3\n3\n3\n2\n","expected_output":"3"}]', '# IV.4 — La edad del mayor
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, 'IV.5 — La nota más baja', 'facil', '<p>Lee <code>N</code> calificaciones. Imprime la <strong>más baja</strong>.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
80
45
60
99</code></pre><p>Salida:</p><pre><code>45</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
notas = [0] * n
for i in range(n):
    notas[i] = int(input())

menor = notas[0]
for i in range(1, n):
    if notas[i] &lt; menor:
        menor = notas[i]

print(menor)</code></pre><p>Patrón IV con <code>&lt;</code>.</p>', '[{"stdin":"4\n80\n45\n60\n99\n","expected_output":"45"},{"stdin":"1\n100\n","expected_output":"100"},{"stdin":"3\n70\n20\n20\n","expected_output":"20"}]', '# IV.5 — La nota más baja
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 6, 'IV.6 — Posición del mayor', 'medio', '<p>Lee <code>N</code> números. Imprime la <strong>posición</strong> del mayor contando desde 1 (es decir, el índice + 1). Si el mayor se repite, la primera vez que aparece.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
4
-3
15
12
7</code></pre><p>Salida:</p><pre><code>3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mayor = vector[0]
pos = 0
for i in range(1, n):
    if vector[i] &gt; mayor:
        mayor = vector[i]
        pos = i

print(pos + 1)</code></pre><p>Se guardan DOS cosas cuando aparece uno mejor: el valor y la posición. <code>&gt;</code> estricto deja la primera aparición.</p>', '[{"stdin":"5\n4\n-3\n15\n12\n7\n","expected_output":"3"},{"stdin":"3\n9\n9\n1\n","expected_output":"1"},{"stdin":"3\n1\n2\n3\n","expected_output":"3"}]', '# IV.6 — Posición del mayor
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 7, 'IV.7 — El segundo más grande', 'dificil', '<p>Lee <code>N</code> números (<code>N</code> ≥ 2). Imprime el segundo más grande: el mayor de todos <strong>sin contar la posición donde está el mayor</strong>. Si el mayor está repetido, el segundo vale lo mismo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
4
-3
15
12
7</code></pre><p>Salida:</p><pre><code>12</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mayor = vector[0]
pos = 0
for i in range(1, n):
    if vector[i] &gt; mayor:
        mayor = vector[i]
        pos = i

segundo = vector[0]
if pos == 0:
    segundo = vector[1]
for i in range(n):
    if i != pos and vector[i] &gt; segundo:
        segundo = vector[i]

print(segundo)</code></pre><p>Dos recorridos: el primero encuentra DÓNDE está el mayor, el segundo repite el patrón IV saltándose esa posición. El arranque de <code>segundo</code> no puede ser la posición del mayor.</p>', '[{"stdin":"5\n4\n-3\n15\n12\n7\n","expected_output":"12"},{"stdin":"3\n9\n9\n1\n","expected_output":"9"},{"stdin":"2\n20\n5\n","expected_output":"5"}]', '# IV.7 — El segundo más grande
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 8, 'IV.8 — Diferencia entre el más caro y el más barato', 'medio', '<p>Lee <code>N</code> precios. Imprime cuánto más caro es el más caro que el más barato.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
5000
12000
800
7000</code></pre><p>Salida:</p><pre><code>11200</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mejor = vector[0]
for i in range(1, n):
    if vector[i] &gt; mejor:
        mejor = vector[i]

print(mejor)</code></pre>', '<pre><code>n = int(input())
precios = [0] * n
for i in range(n):
    precios[i] = int(input())

caro = precios[0]
barato = precios[0]
for i in range(1, n):
    if precios[i] &gt; caro:
        caro = precios[i]
    if precios[i] &lt; barato:
        barato = precios[i]

print(caro - barato)</code></pre><p>Mayor y menor en el mismo ciclo, y una resta al final.</p>', '[{"stdin":"4\n5000\n12000\n800\n7000\n","expected_output":"11200"},{"stdin":"1\n300\n","expected_output":"0"},{"stdin":"2\n10\n10\n","expected_output":"0"}]', '# IV.8 — Diferencia entre el más caro y el más barato
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'vector = [-4, -9, -1]
mayor = 0
for i in range(3):
    if vector[i] > mayor:
        mayor = vector[i]
print(mayor)', '{"options":[{"id":"a","text":"0"},{"id":"b","text":"-1"},{"id":"c","text":"-4"},{"id":"d","text":"-9"}]}', '{"option_id":"a"}', 'Por eso el máximo arranca en vector[0] y no en 0: ningún negativo supera al 0, y se imprime un número que ni siquiera está en el vector.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma el bloque que busca la POSICIÓN del mayor e imprime esa posición contando desde 1', NULL, '{"lines":[{"id":"l1","text":"mayor = vector[0]","indent":0},{"id":"l2","text":"pos = 0","indent":0},{"id":"l3","text":"for i in range(1, n):","indent":0},{"id":"l4","text":"if vector[i] > mayor:","indent":1},{"id":"l5","text":"mayor = vector[i]","indent":2},{"id":"l6","text":"pos = i","indent":2},{"id":"l7","text":"print(pos + 1)","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7"]}', 'Cuando aparece uno mejor se actualizan las DOS cosas: el valor y la posición. La posición del vector arranca en 0, por eso se imprime pos + 1.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En el esqueleto del máximo, ¿por qué el for arranca en 1?', NULL, '{"options":[{"id":"a","text":"Porque vector[0] ya es el valor inicial de mejor"},{"id":"b","text":"Porque la posición 0 siempre es 0"},{"id":"c","text":"Porque range(n) daría error"},{"id":"d","text":"Para que el programa sea más rápido"}]}', '{"option_id":"a"}', 'mejor = vector[0] ya revisó la primera casilla; compararla consigo misma no cambia nada.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'vector = [3, 9, 2, 9]
mayor = vector[0]
pos = 0
for i in range(1, 4):
    if vector[i] > mayor:
        mayor = vector[i]
        pos = i
print(pos + 1)', '{"options":[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"1"},{"id":"d","text":"3"}]}', '{"option_id":"a"}', 'El 9 aparece en las posiciones 1 y 3. Con > estricto el segundo 9 no reemplaza al primero: pos queda en 1 y se imprime 2.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Debe imprimir el MENOR. ¿En qué línea está el error?', NULL, '{"lines":["menor = vector[0]","for i in range(1, n):","    if vector[i] > menor:","        menor = vector[i]","print(menor)"]}', '{"line_number":3}', 'Con > busca el mayor. Para el menor la comparación es <.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa: mayor y menor en el mismo ciclo.', NULL, '{"code":"mayor = ___1___\nmenor = vector[0]\nfor i in range(1, n):\n    if vector[i] > mayor:\n        mayor = vector[i]\n    if vector[i] ___2___ menor:\n        menor = vector[i]","blanks":[{"id":"1","pista":"valor inicial"},{"id":"2","pista":"comparación"}]}', '{"answers":{"1":["vector[0]"],"2":["<"]}}', 'Los dos arrancan en vector[0] y cada uno tiene su propio if.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'nivel0';

-- ── Capítulo 5: El contador K (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 5, 'El contador K', '🔑', 'Por qué i no sirve para el vector nuevo, y la plana de filtrar con k.', '<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<p class="jc-plana-sub">El concepto que te hace pasar de "copiar" a "reorganizar". Si entiendes esto, dominas el patrón V y todos los exámenes del juez.</p>

<h3>1. El problema</h3>

<p>Tenemos este vector:</p>

<div class="jc-vec" aria-label="vector: 5, -2, 0, 8, -7, 3, 0">
  <span class="jc-vec-etq">vector</span>
  <span class="jc-celda" data-i="0">5</span><span class="jc-celda es-si" data-i="1">-2</span><span class="jc-celda" data-i="2">0</span><span class="jc-celda" data-i="3">8</span><span class="jc-celda es-si" data-i="4">-7</span><span class="jc-celda" data-i="5">3</span><span class="jc-celda" data-i="6">0</span>
</div>

<p>Queremos un vector nuevo <strong>solo con los negativos</strong>. ¿Qué índice le pongo a cada negativo en el vector nuevo?</p>

<ul>
  <li><code>i = 0</code>, <code>vector[0] = 5</code> → no es negativo.</li>
  <li><code>i = 1</code>, <code>vector[1] = -2</code> → sí. ¿Lo pongo en <code>nuevo[1]</code>? ❌ dejaría <code>nuevo[0]</code> vacío.</li>
  <li><code>i = 4</code>, <code>vector[4] = -7</code> → sí. ¿Lo pongo en <code>nuevo[4]</code>? ❌ quedarían huecos.</li>
</ul>

<p>Usando el mismo <code>i</code> el resultado queda <strong>mal</strong>, lleno de huecos:</p>

<div class="jc-vec jc-vec-mal" aria-label="resultado mal: hueco, -2, hueco, hueco, -7, hueco, hueco">
  <span class="jc-vec-etq">❌ nuevo</span>
  <span class="jc-celda es-hueco" data-i="0">_</span><span class="jc-celda es-si" data-i="1">-2</span><span class="jc-celda es-hueco" data-i="2">_</span><span class="jc-celda es-hueco" data-i="3">_</span><span class="jc-celda es-si" data-i="4">-7</span><span class="jc-celda es-hueco" data-i="5">_</span><span class="jc-celda es-hueco" data-i="6">_</span>
</div>

<p>Lo que queremos es esto, con los negativos <strong>pegados al principio</strong>:</p>

<div class="jc-vec jc-vec-bien" aria-label="resultado deseado: -2, -7 y luego huecos">
  <span class="jc-vec-etq">✅ nuevo</span>
  <span class="jc-celda es-si" data-i="0">-2</span><span class="jc-celda es-si" data-i="1">-7</span><span class="jc-celda es-hueco" data-i="2">_</span><span class="jc-celda es-hueco" data-i="3">_</span><span class="jc-celda es-hueco" data-i="4">_</span><span class="jc-celda es-hueco" data-i="5">_</span><span class="jc-celda es-hueco" data-i="6">_</span>
</div>

<p class="jc-frase">Los índices del vector original NO sirven para el nuevo. Necesitamos un contador aparte.</p>

<h3>2. La solución: dos índices a distinto ritmo</h3>

<ul>
  <li><code>i</code> recorre <strong>todo</strong> el vector original. Siempre avanza, no se detiene.</li>
  <li><code>k</code> solo avanza cuando <strong>efectivamente copiamos</strong> algo al nuevo.</li>
</ul>

<blockquote>Imagina que revisas una lista de 7 personas (<code>i</code> avanza una por una) y anotas <strong>solo</strong> las que tienen pasaporte en una libreta nueva. El número de renglón de la libreta (<code>k</code>) solo aumenta cuando anotas a alguien.</blockquote>

<h3>3. Traza paso a paso</h3>

<pre><code>nuevo = [0] * 7
k = 0
for i in range(7):
    if vector[i] &lt; 0:
        nuevo[k] = vector[i]
        k = k + 1</code></pre>

<p>Mira cómo <code>i</code> camina por todo el vector mientras <code>k</code> espera en la siguiente casilla libre y solo salta cuando hay copia:</p>

<div class="jc-k-anim" role="img" aria-label="Animación: i recorre las 7 casillas del vector; cuando encuentra -2 lo copia en nuevo[0] y k pasa a 1; cuando encuentra -7 lo copia en nuevo[1] y k pasa a 2.">
  <div class="jc-vec">
    <span class="jc-vec-etq">vector</span>
    <span class="jc-celda jc-k-i" style="--paso: 0" data-i="0">5</span><span class="jc-celda jc-k-i es-si" style="--paso: 1" data-i="1">-2</span><span class="jc-celda jc-k-i" style="--paso: 2" data-i="2">0</span><span class="jc-celda jc-k-i" style="--paso: 3" data-i="3">8</span><span class="jc-celda jc-k-i es-si" style="--paso: 4" data-i="4">-7</span><span class="jc-celda jc-k-i" style="--paso: 5" data-i="5">3</span><span class="jc-celda jc-k-i" style="--paso: 6" data-i="6">0</span>
  </div>
  <div class="jc-vec">
    <span class="jc-vec-etq">nuevo</span>
    <span class="jc-celda jc-k-slot jc-k-slot0" data-i="0"><span class="jc-k-cero">0</span><span class="jc-k-dato jc-k-dato0">-2</span></span><span class="jc-celda jc-k-slot jc-k-slot1" data-i="1"><span class="jc-k-cero">0</span><span class="jc-k-dato jc-k-dato1">-7</span></span><span class="jc-celda jc-k-slot jc-k-slot2" data-i="2"><span class="jc-k-cero">0</span></span><span class="jc-celda" data-i="3"><span class="jc-k-cero">0</span></span><span class="jc-celda" data-i="4"><span class="jc-k-cero">0</span></span><span class="jc-celda" data-i="5"><span class="jc-k-cero">0</span></span><span class="jc-celda" data-i="6"><span class="jc-k-cero">0</span></span>
  </div>
  <p class="jc-k-leyenda"><span class="jc-k-marca-i">i</span> revisa una casilla por paso · <span class="jc-k-marca-k">k</span> marca la siguiente casilla libre de <code>nuevo</code></p>
</div>

<table class="jc-traza">
  <thead>
    <tr><th><code>i</code></th><th><code>vector[i]</code></th><th>¿&lt; 0?</th><th>Qué pasa</th><th><code>k</code> después</th><th><code>nuevo</code></th></tr>
  </thead>
  <tbody>
    <tr><td>0</td><td>5</td><td>No</td><td>nada; k no se mueve</td><td>0</td><td><code>[0, 0, 0, 0, 0, 0, 0]</code></td></tr>
    <tr class="es-copia"><td>1</td><td>-2</td><td>Sí</td><td><code>nuevo[0] = -2</code></td><td>1</td><td><code>[-2, 0, 0, 0, 0, 0, 0]</code></td></tr>
    <tr><td>2</td><td>0</td><td>No</td><td>nada</td><td>1</td><td><code>[-2, 0, 0, 0, 0, 0, 0]</code></td></tr>
    <tr><td>3</td><td>8</td><td>No</td><td>nada</td><td>1</td><td><code>[-2, 0, 0, 0, 0, 0, 0]</code></td></tr>
    <tr class="es-copia"><td>4</td><td>-7</td><td>Sí</td><td><code>nuevo[1] = -7</code></td><td>2</td><td><code>[-2, -7, 0, 0, 0, 0, 0]</code></td></tr>
    <tr><td>5</td><td>3</td><td>No</td><td>nada</td><td>2</td><td><code>[-2, -7, 0, 0, 0, 0, 0]</code></td></tr>
    <tr><td>6</td><td>0</td><td>No</td><td>nada</td><td>2</td><td><code>[-2, -7, 0, 0, 0, 0, 0]</code></td></tr>
  </tbody>
</table>

<p>Al terminar, <code>i</code> dio 7 vueltas y <code>k</code> vale <strong>2</strong>. Ese 2 dice dos cosas a la vez: <strong>cuántos se copiaron</strong> y <strong>dónde iría el siguiente</strong>. Los ceros que quedan detrás son relleno del <code>[0] * 7</code>, por eso se imprime solo hasta <code>k</code>:</p>

<pre><code>for i in range(k):
    print(nuevo[i])</code></pre>

<h3>4. Los tres errores con k</h3>

<p><strong>a) <code>k = k + 1</code> fuera del <code>if</code>.</strong> Avanza en todas las vueltas y vuelve a dejar huecos: es como usar <code>i</code>.</p>
<pre><code>    if vector[i] &lt; 0:
        nuevo[k] = vector[i]
    k = k + 1              # ❌ mal indentado</code></pre>

<p><strong>b) <code>k = 0</code> dentro del <code>for</code>.</strong> Se reinicia en cada vuelta y todo se escribe encima de <code>nuevo[0]</code>.</p>
<pre><code>for i in range(n):
    k = 0                  # ❌ va ANTES del for</code></pre>

<p><strong>c) Imprimir con <code>range(n)</code>.</strong> Salen los ceros de relleno y el juez marca respuesta incorrecta.</p>
<pre><code>for i in range(n):         # ❌ es range(k)
    print(nuevo[i])</code></pre>


<h2>V-A. Filtrar: la plana del contador k</h2>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto V-A · escríbelo 3 veces</p>
<pre><code>nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condición):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>
</div>

<p>Con vectores paralelos (nombre y nota de la misma persona) la condición mira un vector y se copia del otro, con el <strong>mismo</strong> <code>i</code>: <code>if notas[i] &gt;= 60:</code> → <code>aprobados[k] = nombres[i]</code>. Ejercicios: <strong>V-A.1 a V-A.7</strong>.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 2 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 5 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'V-A.1 — Copiar los negativos', 'facil', '<p>Lee <code>N</code> números. Copia los <strong>negativos</strong> a un vector nuevo usando el contador <code>k</code>, e imprime el vector nuevo (solo lo copiado), uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>-2
-7</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &lt; 0:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Es el ejemplo de la sección del contador K. Escríbelo sin mirar.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"-2\n-7"},{"stdin":"5\n-1\n4\n21\n-30\n6\n","expected_output":"-1\n-30"},{"stdin":"3\n12\n-12\n9\n","expected_output":"-12"}]', '# V-A.1 — Copiar los negativos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'V-A.2 — Copiar los positivos', 'facil', '<p>Lee <code>N</code> números. Copia los <strong>positivos</strong> a un vector nuevo usando el contador <code>k</code>, e imprime el vector nuevo (solo lo copiado), uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>5
8
3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &gt; 0:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Cambia una sola cosa: la condición.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"5\n8\n3"},{"stdin":"5\n-1\n4\n21\n-30\n6\n","expected_output":"4\n21\n6"},{"stdin":"3\n12\n-12\n9\n","expected_output":"12\n9"}]', '# V-A.2 — Copiar los positivos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'V-A.3 — Copiar los pares', 'facil', '<p>Lee <code>N</code> números. Copia los <strong>pares</strong> a un vector nuevo usando el contador <code>k</code>, e imprime el vector nuevo (solo lo copiado), uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>-2
0
8
0</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] % 2 == 0:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Fíjate que el 0 es par: también se copia.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"-2\n0\n8\n0"},{"stdin":"5\n-1\n4\n21\n-30\n6\n","expected_output":"4\n-30\n6"},{"stdin":"3\n12\n-12\n9\n","expected_output":"12\n-12"}]', '# V-A.3 — Copiar los pares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'V-A.4 — Copiar los mayores a 10', 'facil', '<p>Lee <code>N</code> números. Copia los <strong>mayores a 10</strong> a un vector nuevo usando el contador <code>k</code>, e imprime el vector nuevo (solo lo copiado), uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code></code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &gt; 10:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Imprime con <code>range(k)</code>: lo que hay después de <code>k</code> son ceros de relleno.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":""},{"stdin":"5\n-1\n4\n21\n-30\n6\n","expected_output":"21"},{"stdin":"3\n12\n-12\n9\n","expected_output":"12"}]', '# V-A.4 — Copiar los mayores a 10
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, 'V-A.5 — Copiar los mayores que X', 'medio', '<p>Lee <code>N</code>, luego <code>N</code> números y al final un número <code>X</code>. Copia a un vector nuevo los que son <strong>mayores que X</strong> e imprímelos uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
3
9
1
12
5
4</code></pre><p>Salida:</p><pre><code>9
12
5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
x = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &gt; x:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p><code>X</code> se lee DESPUÉS del vector, en el orden que dice el enunciado. Leer en otro orden es el error número uno con el juez.</p>', '[{"stdin":"5\n3\n9\n1\n12\n5\n4\n","expected_output":"9\n12\n5"},{"stdin":"3\n-1\n-5\n0\n-2\n","expected_output":"-1\n0"},{"stdin":"2\n7\n7\n6\n","expected_output":"7\n7"}]', '# V-A.5 — Copiar los mayores que X
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 6, 'V-A.6 — Nombres de los aprobados', 'medio', '<p>Lee <code>N</code>. Luego, por cada estudiante, una línea con su nombre y otra con su nota (0 a 100). Copia a un vector nuevo los <strong>nombres</strong> de quienes tienen 60 o más e imprímelos uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
Ana
80
Luis
45
Marta
60
Pedro
30</code></pre><p>Salida:</p><pre><code>Ana
Marta</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
nombres = [""] * n
notas = [0] * n
for i in range(n):
    nombres[i] = input()
    notas[i] = int(input())

aprobados = [""] * n
k = 0
for i in range(n):
    if notas[i] &gt;= 60:
        aprobados[k] = nombres[i]
        k = k + 1

for i in range(k):
    print(aprobados[i])</code></pre><p>Vectores paralelos: la condición mira <code>notas[i]</code> pero se copia <code>nombres[i]</code>. Mismo <code>i</code> = misma persona.</p>', '[{"stdin":"4\nAna\n80\nLuis\n45\nMarta\n60\nPedro\n30\n","expected_output":"Ana\nMarta"},{"stdin":"2\nSol\n99\nJuan\n100\n","expected_output":"Sol\nJuan"},{"stdin":"3\nEva\n10\nTom\n75\nIvan\n59\n","expected_output":"Tom"}]', '# V-A.6 — Nombres de los aprobados
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 7, 'V-A.7 — Cuántos y cuáles divisibles por 3', 'medio', '<p>Lee <code>N</code> números. Copia a un vector nuevo los <strong>divisibles por 3</strong>. Imprime primero cuántos fueron y luego cada uno en su línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>3
0
3
0</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] % 3 == 0:
        nuevo[k] = vector[i]
        k = k + 1

print(k)
for i in range(k):
    print(nuevo[i])</code></pre><p>Al terminar el ciclo, <code>k</code> ya ES la cantidad copiada. No hace falta otro contador.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"3\n0\n3\n0"},{"stdin":"5\n-1\n4\n21\n-30\n6\n","expected_output":"3\n21\n-30\n6"},{"stdin":"3\n12\n-12\n9\n","expected_output":"3\n12\n-12\n9"}]', '# V-A.7 — Cuántos y cuáles divisibles por 3
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En el patrón de copiar a un vector nuevo, ¿qué representa k?', NULL, '{"options":[{"id":"a","text":"La siguiente casilla libre del vector nuevo, y también cuántos se han copiado"},{"id":"b","text":"La posición que se está revisando en el vector original"},{"id":"c","text":"El tamaño del vector original"},{"id":"d","text":"El valor más grande copiado hasta ahora"}]}', '{"option_id":"a"}', 'i recorre el original y avanza siempre; k solo avanza cuando se copia algo. Por eso al final k es la cantidad copiada.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Terminado el filtrado, ¿hasta dónde se recorre el vector nuevo para imprimir solo lo copiado?', NULL, '{"options":[{"id":"a","text":"for i in range(k):"},{"id":"b","text":"for i in range(n):"},{"id":"c","text":"for i in range(len(nuevo)):"},{"id":"d","text":"for i in range(k + 1):"}]}', '{"option_id":"a"}', 'nuevo tiene n casillas, pero solo las primeras k tienen datos copiados; el resto son ceros de relleno.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'vector = [4, -2, 7, -5]
nuevo = [0] * 4
k = 0
for i in range(4):
    if vector[i] < 0:
        nuevo[k] = vector[i]
        k = k + 1
print(k)
print(nuevo)', '{"options":[{"id":"a","text":"2\n[-2, -5, 0, 0]"},{"id":"b","text":"2\n[0, -2, 0, -5]"},{"id":"c","text":"4\n[-2, -5, 0, 0]"},{"id":"d","text":"2\n[-2, -5]"}]}', '{"option_id":"a"}', 'Los negativos quedan pegados al inicio gracias a k. Las casillas sobrantes siguen en 0 porque el vector nació con [0] * 4.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Debe copiar los negativos al vector nuevo. ¿En qué línea está el error?', NULL, '{"lines":["nuevo = [0] * n","k = 0","for i in range(n):","    if vector[i] < 0:","        nuevo[k] = vector[i]","    k = k + 1"]}', '{"line_number":6}', 'k = k + 1 quedó fuera del if: avanza en cada vuelta y deja huecos. Va indentado al mismo nivel de nuevo[k] = vector[i].', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Debe copiar los pares al vector nuevo. ¿En qué línea está el error?', NULL, '{"lines":["nuevo = [0] * n","for i in range(n):","    k = 0","    if vector[i] % 2 == 0:","        nuevo[k] = vector[i]","        k = k + 1"]}', '{"line_number":3}', 'k nace dentro del for y vuelve a 0 en cada vuelta: todos los pares se escriben encima de nuevo[0]. k = 0 va antes del ciclo.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa de memoria el esqueleto de copiar con k.', NULL, '{"code":"nuevo = ___1___\nk = 0\nfor i in range(n):\n    if vector[i] > 0:\n        nuevo[___2___] = vector[i]\n        k = ___3___\n\nfor i in range(___4___):\n    print(nuevo[i])","blanks":[{"id":"1","pista":"vector nuevo de n enteros"},{"id":"2","pista":"el índice del vector nuevo"},{"id":"3","pista":"avanzar el contador"},{"id":"4","pista":"solo lo copiado"}]}', '{"answers":{"1":["[0] * n","[0]*n"],"2":["k"],"3":["k + 1","k+1","1 + k","1+k"],"4":["k"]}}', 'Vector en ceros, escribir en nuevo[k], avanzar k solo al copiar, e imprimir hasta k.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'El vector ya está leído. Arma el bloque que copia los negativos a un vector nuevo e imprime cuántos fueron', NULL, '{"lines":[{"id":"l1","text":"nuevo = [0] * n","indent":0},{"id":"l2","text":"k = 0","indent":0},{"id":"l3","text":"for i in range(n):","indent":0},{"id":"l4","text":"if vector[i] < 0:","indent":1},{"id":"l5","text":"nuevo[k] = vector[i]","indent":2},{"id":"l6","text":"k = k + 1","indent":2},{"id":"l7","text":"print(k)","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7"]}', 'El vector nuevo y k nacen afuera. Dentro del if van juntas la copia y el avance de k. Al terminar, k ya es la cantidad.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'nivel0';

-- ── Capítulo 6: V. Copiar por grupos (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 6, 'V. Copiar por grupos', '🧩', 'Separar en dos vectores, reorganizar en uno y copiar con un giro.', '<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<p>Ya sabes filtrar con un <code>k</code>. Este capítulo trae las otras tres sublógicas del patrón V: separar en dos vectores, reorganizar en uno solo y copiar con un giro. Son 18 ejercicios: la plana más larga del libro.</p>

<h2>V-B. Separar: dos vectores, dos contadores</h2>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto V-B · escríbelo 3 veces</p>
<pre><code>grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condición):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>
</div>

<p>Cada vector nuevo tiene <strong>su propio</strong> contador. Ambos nacen de tamaño <code>n</code> porque, en el peor caso, todos caen en el mismo grupo. Si hay elementos que no van a ninguno (como el cero entre positivos y negativos), el <code>else</code> se cambia por <code>elif</code>. Ejercicios: <strong>V-B.1 a V-B.6</strong>.</p>

<h2>V-C. Reorganizar: un vector, un k, varias pasadas</h2>

<div class="jc-esqueleto">
  <p class="jc-esqueleto-tit">Esqueleto V-C · escríbelo 3 veces</p>
<pre><code>nuevo = [0] * n
k = 0
for i in range(n):              # pasada 1: el primer grupo
    if vector[i] (condición):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):              # pasada 2: el resto (condición contraria)
    if vector[i] (contraria):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>
</div>

<p>La clave: <strong>k no se reinicia</strong> entre pasadas. La segunda sigue escribiendo justo donde terminó la primera. Las condiciones deben ser opuestas exactas (<code>&gt; x</code> con <code>&lt;= x</code>), o algún elemento se pierde. Tres grupos = tres pasadas. Ejercicios: <strong>V-C.1 a V-C.6</strong>.</p>

<h2>V-D. Copiar con un giro</h2>

<p>El mismo esqueleto con una pieza distinta:</p>

<table>
  <thead>
    <tr><th>Giro</th><th>Qué cambia</th></tr>
  </thead>
  <tbody>
    <tr><td>Copiar al revés</td><td><code>k = n - 1</code> y <code>k = k - 1</code>: i sube, k baja</td></tr>
    <tr><td>Mayores al promedio</td><td>Primero patrón III para el promedio, después V-A</td></tr>
    <tr><td>Transformar al copiar</td><td><code>nuevo[k] = vector[i] * 2</code></td></tr>
    <tr><td>Por posición</td><td>La condición mira <code>i</code></td></tr>
    <tr><td>"Borrar" uno</td><td>Patrón IV para su posición, luego copiar con <code>if i != pos:</code></td></tr>
    <tr><td>Unir dos vectores</td><td>Un solo k que sigue del primer ciclo al segundo</td></tr>
  </tbody>
</table>

<p>Ejercicios: <strong>V-D.1 a V-D.6</strong>.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 2 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 6 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'V-B.1 — Separar pares e impares', 'medio', '<p>Lee <code>N</code> números. Sepáralos en dos vectores: <strong>pares</strong> e <strong>impares</strong>. Imprime <code>Pares:</code>, los pares uno por línea, luego <code>Impares:</code> y los impares.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
5
-2
0
8
-7
3</code></pre><p>Salida:</p><pre><code>Pares:
-2
0
8
Impares:
5
-7
3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condicion):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

pares = [0] * n
impares = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] % 2 == 0:
        pares[k1] = vector[i]
        k1 = k1 + 1
    else:
        impares[k2] = vector[i]
        k2 = k2 + 1

print("Pares:")
for i in range(k1):
    print(pares[i])
print("Impares:")
for i in range(k2):
    print(impares[i])</code></pre><p>Cada vector tiene SU contador: <code>k1</code> solo avanza al copiar a <code>pares</code>, <code>k2</code> al copiar a <code>impares</code>.</p>', '[{"stdin":"6\n5\n-2\n0\n8\n-7\n3\n","expected_output":"Pares:\n-2\n0\n8\nImpares:\n5\n-7\n3"},{"stdin":"4\n1\n2\n3\n4\n","expected_output":"Pares:\n2\n4\nImpares:\n1\n3"},{"stdin":"3\n-6\n11\n4\n","expected_output":"Pares:\n-6\n4\nImpares:\n11"}]', '# V-B.1 — Separar pares e impares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'V-B.2 — Separar positivos y negativos', 'medio', '<p>Lee <code>N</code> números. Copia los <strong>positivos</strong> a un vector y los <strong>negativos</strong> a otro (los ceros no van a ninguno). Imprime <code>Positivos:</code> y sus valores, luego <code>Negativos:</code> y los suyos.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
5
-2
0
8
-7
3</code></pre><p>Salida:</p><pre><code>Positivos:
5
8
3
Negativos:
-2
-7</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condicion):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

positivos = [0] * n
negativos = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] &gt; 0:
        positivos[k1] = vector[i]
        k1 = k1 + 1
    elif vector[i] &lt; 0:
        negativos[k2] = vector[i]
        k2 = k2 + 1

print("Positivos:")
for i in range(k1):
    print(positivos[i])
print("Negativos:")
for i in range(k2):
    print(negativos[i])</code></pre><p>Aquí no hay <code>else</code> sino <code>elif</code>: el cero no cumple ninguna y se queda por fuera.</p>', '[{"stdin":"6\n5\n-2\n0\n8\n-7\n3\n","expected_output":"Positivos:\n5\n8\n3\nNegativos:\n-2\n-7"},{"stdin":"4\n1\n2\n3\n4\n","expected_output":"Positivos:\n1\n2\n3\n4\nNegativos:"},{"stdin":"3\n-6\n11\n4\n","expected_output":"Positivos:\n11\n4\nNegativos:\n-6"}]', '# V-B.2 — Separar positivos y negativos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'V-B.3 — Aprobados y reprobados', 'medio', '<p>Lee <code>N</code> notas de 0 a 100. Separa las <strong>aprobadas</strong> (60 o más) de las <strong>reprobadas</strong>. Imprime <code>Aprobadas:</code> y sus notas, luego <code>Reprobadas:</code> y las suyas.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
80
45
60
99
30</code></pre><p>Salida:</p><pre><code>Aprobadas:
80
60
99
Reprobadas:
45
30</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condicion):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>', '<pre><code>n = int(input())
notas = [0] * n
for i in range(n):
    notas[i] = int(input())

aprobadas = [0] * n
reprobadas = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if notas[i] &gt;= 60:
        aprobadas[k1] = notas[i]
        k1 = k1 + 1
    else:
        reprobadas[k2] = notas[i]
        k2 = k2 + 1

print("Aprobadas:")
for i in range(k1):
    print(aprobadas[i])
print("Reprobadas:")
for i in range(k2):
    print(reprobadas[i])</code></pre><p>Patrón V-B con otros nombres.</p>', '[{"stdin":"5\n80\n45\n60\n99\n30\n","expected_output":"Aprobadas:\n80\n60\n99\nReprobadas:\n45\n30"},{"stdin":"2\n10\n20\n","expected_output":"Aprobadas:\nReprobadas:\n10\n20"},{"stdin":"2\n100\n59\n","expected_output":"Aprobadas:\n100\nReprobadas:\n59"}]', '# V-B.3 — Aprobados y reprobados
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'V-B.4 — Mayores y menores de edad', 'medio', '<p>Lee <code>N</code> edades. Separa <strong>mayores de edad</strong> (18 o más) y <strong>menores</strong>. Imprime <code>Mayores:</code> y sus edades, luego <code>Menores:</code> y las suyas.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
17
18
25
9
40</code></pre><p>Salida:</p><pre><code>Mayores:
18
25
40
Menores:
17
9</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condicion):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>', '<pre><code>n = int(input())
edades = [0] * n
for i in range(n):
    edades[i] = int(input())

mayores = [0] * n
menores = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if edades[i] &gt;= 18:
        mayores[k1] = edades[i]
        k1 = k1 + 1
    else:
        menores[k2] = edades[i]
        k2 = k2 + 1

print("Mayores:")
for i in range(k1):
    print(mayores[i])
print("Menores:")
for i in range(k2):
    print(menores[i])</code></pre><p>Si un grupo queda vacío, solo se imprime su título: <code>range(0)</code> no da vueltas.</p>', '[{"stdin":"5\n17\n18\n25\n9\n40\n","expected_output":"Mayores:\n18\n25\n40\nMenores:\n17\n9"},{"stdin":"2\n5\n12\n","expected_output":"Mayores:\nMenores:\n5\n12"},{"stdin":"2\n18\n30\n","expected_output":"Mayores:\n18\n30\nMenores:"}]', '# V-B.4 — Mayores y menores de edad
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, 'V-B.5 — Precios baratos y caros', 'medio', '<p>Lee <code>N</code> precios. Son <strong>baratos</strong> los menores a 10000 y <strong>caros</strong> los demás. Imprime <code>Baratos:</code> y sus precios, luego <code>Caros:</code> y los suyos.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
5000
12000
800
10000</code></pre><p>Salida:</p><pre><code>Baratos:
5000
800
Caros:
12000
10000</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condicion):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>', '<pre><code>n = int(input())
precios = [0] * n
for i in range(n):
    precios[i] = int(input())

baratos = [0] * n
caros = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if precios[i] &lt; 10000:
        baratos[k1] = precios[i]
        k1 = k1 + 1
    else:
        caros[k2] = precios[i]
        k2 = k2 + 1

print("Baratos:")
for i in range(k1):
    print(baratos[i])
print("Caros:")
for i in range(k2):
    print(caros[i])</code></pre><p>El 10000 exacto no es menor a 10000: va a caros.</p>', '[{"stdin":"4\n5000\n12000\n800\n10000\n","expected_output":"Baratos:\n5000\n800\nCaros:\n12000\n10000"},{"stdin":"1\n300\n","expected_output":"Baratos:\n300\nCaros:"},{"stdin":"2\n25000\n9999\n","expected_output":"Baratos:\n9999\nCaros:\n25000"}]', '# V-B.5 — Precios baratos y caros
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 6, 'V-B.6 — Separar por posición', 'medio', '<p>Lee <code>N</code> números. Copia a un vector los que están en <strong>posiciones pares</strong> (0, 2, 4…) y a otro los de <strong>posiciones impares</strong>. Imprime <code>Pares:</code> y los primeros, luego <code>Impares:</code> y los segundos.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
5
-2
0
8
-7
3</code></pre><p>Salida:</p><pre><code>Pares:
5
0
-7
Impares:
-2
8
3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

grupo1 = [0] * n
grupo2 = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if vector[i] (condicion):
        grupo1[k1] = vector[i]
        k1 = k1 + 1
    else:
        grupo2[k2] = vector[i]
        k2 = k2 + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

pares = [0] * n
impares = [0] * n
k1 = 0
k2 = 0
for i in range(n):
    if i % 2 == 0:
        pares[k1] = vector[i]
        k1 = k1 + 1
    else:
        impares[k2] = vector[i]
        k2 = k2 + 1

print("Pares:")
for i in range(k1):
    print(pares[i])
print("Impares:")
for i in range(k2):
    print(impares[i])</code></pre><p>La condición mira <code>i</code>, pero se copia <code>vector[i]</code>.</p>', '[{"stdin":"6\n5\n-2\n0\n8\n-7\n3\n","expected_output":"Pares:\n5\n0\n-7\nImpares:\n-2\n8\n3"},{"stdin":"3\n1\n2\n3\n","expected_output":"Pares:\n1\n3\nImpares:\n2"},{"stdin":"1\n42\n","expected_output":"Pares:\n42\nImpares:"}]', '# V-B.6 — Separar por posición
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 7, 'V-C.1 — Negativos primero', 'medio', '<p>Lee <code>N</code> números. Arma un vector nuevo con <strong>primero los negativos</strong> y después el resto, cada grupo en el orden en que llegó. Imprime el vector nuevo completo, uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>-2
-7
5
0
8
3
0</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):          # pasada 1: el primer grupo
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):          # pasada 2: el resto, MISMO k
    if not (vector[i] (condicion)):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &lt; 0:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):
    if vector[i] &gt;= 0:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre><p>Dos pasadas por el vector original y UN solo <code>k</code>: la segunda pasada sigue escribiendo donde quedó la primera. No se reinicia <code>k</code>.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"-2\n-7\n5\n0\n8\n3\n0"},{"stdin":"3\n4\n-1\n-2\n","expected_output":"-1\n-2\n4"},{"stdin":"4\n0\n9\n0\n-3\n","expected_output":"-3\n0\n9\n0"}]', '# V-C.1 — Negativos primero
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 8, 'V-C.2 — Pares primero', 'medio', '<p>Lee <code>N</code> números. Arma un vector nuevo con <strong>primero los pares</strong> y después los impares, conservando el orden de llegada. Imprímelo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>-2
0
8
0
5
-7
3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):          # pasada 1: el primer grupo
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):          # pasada 2: el resto, MISMO k
    if not (vector[i] (condicion)):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] % 2 == 0:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):
    if vector[i] % 2 == 1:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre><p>Las dos condiciones son opuestas: entre las dos pasadas se copia TODO, por eso el vector queda lleno.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"-2\n0\n8\n0\n5\n-7\n3"},{"stdin":"3\n4\n-1\n-2\n","expected_output":"4\n-2\n-1"},{"stdin":"4\n0\n9\n0\n-3\n","expected_output":"0\n0\n9\n-3"}]', '# V-C.2 — Pares primero
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 9, 'V-C.3 — Ceros al final', 'medio', '<p>Lee <code>N</code> números. Arma un vector nuevo con todos los <strong>distintos de cero</strong> primero y los <strong>ceros al final</strong>. Imprímelo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>5
-2
8
-7
3
0
0</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):          # pasada 1: el primer grupo
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):          # pasada 2: el resto, MISMO k
    if not (vector[i] (condicion)):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] != 0:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):
    if vector[i] == 0:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre><p>Clásico de examen: "mueve los ceros al final". Es el patrón V-C.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"5\n-2\n8\n-7\n3\n0\n0"},{"stdin":"3\n4\n-1\n-2\n","expected_output":"4\n-1\n-2"},{"stdin":"4\n0\n9\n0\n-3\n","expected_output":"9\n-3\n0\n0"}]', '# V-C.3 — Ceros al final
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 10, 'V-C.4 — Tres grupos: negativos, ceros, positivos', 'dificil', '<p>Lee <code>N</code> números. Arma un vector nuevo con primero los <strong>negativos</strong>, luego los <strong>ceros</strong> y al final los <strong>positivos</strong>, cada grupo en orden de llegada. Imprímelo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>-2
-7
0
0
5
8
3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):          # pasada 1: el primer grupo
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):          # pasada 2: el resto, MISMO k
    if not (vector[i] (condicion)):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &lt; 0:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):
    if vector[i] == 0:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):
    if vector[i] &gt; 0:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre><p>Tres grupos = tres pasadas. Mismo <code>k</code> en las tres.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"-2\n-7\n0\n0\n5\n8\n3"},{"stdin":"3\n4\n-1\n-2\n","expected_output":"-1\n-2\n4"},{"stdin":"4\n0\n9\n0\n-3\n","expected_output":"-3\n0\n0\n9"}]', '# V-C.4 — Tres grupos: negativos, ceros, positivos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 11, 'V-C.5 — Aprobadas primero', 'medio', '<p>Lee <code>N</code> notas de 0 a 100. Arma un vector nuevo con primero las <strong>aprobadas</strong> (60 o más) y luego las reprobadas. Imprímelo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
80
45
60
99
30</code></pre><p>Salida:</p><pre><code>80
60
99
45
30</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):          # pasada 1: el primer grupo
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):          # pasada 2: el resto, MISMO k
    if not (vector[i] (condicion)):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
notas = [0] * n
for i in range(n):
    notas[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if notas[i] &gt;= 60:
        nuevo[k] = notas[i]
        k = k + 1
for i in range(n):
    if notas[i] &lt; 60:
        nuevo[k] = notas[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre><p>Patrón V-C con otro nombre.</p>', '[{"stdin":"5\n80\n45\n60\n99\n30\n","expected_output":"80\n60\n99\n45\n30"},{"stdin":"2\n10\n20\n","expected_output":"10\n20"},{"stdin":"2\n59\n100\n","expected_output":"100\n59"}]', '# V-C.5 — Aprobadas primero
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 12, 'V-C.6 — Mayores que X primero', 'dificil', '<p>Lee <code>N</code>, luego <code>N</code> números y al final <code>X</code>. Arma un vector nuevo con primero los <strong>mayores que X</strong> y después el resto. Imprímelo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
3
9
1
12
5
4</code></pre><p>Salida:</p><pre><code>9
12
5
3
1</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):          # pasada 1: el primer grupo
    if vector[i] (condicion):
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):          # pasada 2: el resto, MISMO k
    if not (vector[i] (condicion)):
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())
x = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &gt; x:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(n):
    if vector[i] &lt;= x:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(n):
    print(nuevo[i])</code></pre><p>El opuesto de <code>&gt; x</code> es <code>&lt;= x</code>, no <code>&lt; x</code>: si te equivocas, el que es igual a X se pierde.</p>', '[{"stdin":"5\n3\n9\n1\n12\n5\n4\n","expected_output":"9\n12\n5\n3\n1"},{"stdin":"3\n-1\n-5\n0\n-2\n","expected_output":"-1\n0\n-5"},{"stdin":"2\n7\n7\n6\n","expected_output":"7\n7"}]', '# V-C.6 — Mayores que X primero
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 13, 'V-D.1 — Copiar al revés con k', 'medio', '<p>Lee <code>N</code> números. Cópialos a un vector nuevo <strong>al revés</strong>: el primero queda de último. Usa un <code>k</code> que arranque en <code>n - 1</code> y baje. Imprime el nuevo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
5
-2
0
8</code></pre><p>Salida:</p><pre><code>8
0
-2
5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if (condicion sobre vector[i] o sobre i):
        nuevo[k] = (lo que se copia)
        k = k + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = n - 1
for i in range(n):
    nuevo[k] = vector[i]
    k = k - 1

for i in range(n):
    print(nuevo[i])</code></pre><p><code>i</code> sube y <code>k</code> baja: dos índices a distinto ritmo, la idea central del contador.</p>', '[{"stdin":"4\n5\n-2\n0\n8\n","expected_output":"8\n0\n-2\n5"},{"stdin":"3\n1\n2\n3\n","expected_output":"3\n2\n1"},{"stdin":"1\n7\n","expected_output":"7"}]', '# V-D.1 — Copiar al revés con k
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 14, 'V-D.2 — Copiar los mayores al promedio', 'dificil', '<p>Lee <code>N</code> números. Calcula el promedio (división entera) y copia a un vector nuevo los que son <strong>mayores al promedio</strong>. Imprímelos uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
4
10
6
1
9</code></pre><p>Salida:</p><pre><code>10
9</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if (condicion sobre vector[i] o sobre i):
        nuevo[k] = (lo que se copia)
        k = k + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + vector[i]
promedio = suma // n

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &gt; promedio:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Patrón III y después patrón V. Primero hay que tener el promedio completo; por eso son dos ciclos.</p>', '[{"stdin":"5\n4\n10\n6\n1\n9\n","expected_output":"10\n9"},{"stdin":"3\n3\n3\n9\n","expected_output":"9"},{"stdin":"2\n-5\n5\n","expected_output":"5"}]', '# V-D.2 — Copiar los mayores al promedio
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 15, 'V-D.3 — El doble de los positivos', 'medio', '<p>Lee <code>N</code> números. Copia a un vector nuevo el <strong>doble</strong> de cada positivo. Imprímelos uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>7
5
-2
0
8
-7
3
0</code></pre><p>Salida:</p><pre><code>10
16
6</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if (condicion sobre vector[i] o sobre i):
        nuevo[k] = (lo que se copia)
        k = k + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if vector[i] &gt; 0:
        nuevo[k] = vector[i] * 2
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Se puede transformar al copiar: a la derecha del <code>=</code> va cualquier cálculo.</p>', '[{"stdin":"7\n5\n-2\n0\n8\n-7\n3\n0\n","expected_output":"10\n16\n6"},{"stdin":"5\n-1\n4\n21\n-30\n6\n","expected_output":"8\n42\n12"},{"stdin":"3\n12\n-12\n9\n","expected_output":"24\n18"}]', '# V-D.3 — El doble de los positivos
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 16, 'V-D.4 — Copiar posiciones impares', 'medio', '<p>Lee <code>N</code> números. Copia a un vector nuevo los que están en <strong>posiciones impares</strong> (1, 3, 5…). Imprímelos uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
5
-2
0
8
-7
3</code></pre><p>Salida:</p><pre><code>-2
8
3</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if (condicion sobre vector[i] o sobre i):
        nuevo[k] = (lo que se copia)
        k = k + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if i % 2 == 1:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Condición sobre <code>i</code>, copia de <code>vector[i]</code>.</p>', '[{"stdin":"6\n5\n-2\n0\n8\n-7\n3\n","expected_output":"-2\n8\n3"},{"stdin":"3\n1\n2\n3\n","expected_output":"2"},{"stdin":"2\n10\n20\n","expected_output":"20"}]', '# V-D.4 — Copiar posiciones impares
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 17, 'V-D.5 — Copiar todos menos el mayor', 'dificil', '<p>Lee <code>N</code> números (<code>N</code> ≥ 2). Copia a un vector nuevo todos <strong>menos el mayor</strong> (si se repite, solo se quita su primera aparición). Imprime los copiados uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
4
-3
15
12
7</code></pre><p>Salida:</p><pre><code>4
-3
12
7</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if (condicion sobre vector[i] o sobre i):
        nuevo[k] = (lo que se copia)
        k = k + 1</code></pre>', '<pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

mayor = vector[0]
pos = 0
for i in range(1, n):
    if vector[i] &gt; mayor:
        mayor = vector[i]
        pos = i

nuevo = [0] * n
k = 0
for i in range(n):
    if i != pos:
        nuevo[k] = vector[i]
        k = k + 1

for i in range(k):
    print(nuevo[i])</code></pre><p>Patrón IV (posición del mayor) y luego patrón V con la condición <code>i != pos</code>. Así se "borra" sin métodos prohibidos.</p>', '[{"stdin":"5\n4\n-3\n15\n12\n7\n","expected_output":"4\n-3\n12\n7"},{"stdin":"3\n9\n9\n1\n","expected_output":"9\n1"},{"stdin":"2\n20\n5\n","expected_output":"5"}]', '# V-D.5 — Copiar todos menos el mayor
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 18, 'V-D.6 — Unir dos vectores', 'dificil', '<p>Lee <code>N</code> y <code>N</code> números (vector A). Luego lee <code>M</code> y <code>M</code> números (vector B). Arma un vector nuevo de tamaño <code>N + M</code> con todo A y después todo B. Imprímelo completo.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>3
1
2
3
2
8
9</code></pre><p>Salida:</p><pre><code>1
2
3
8
9</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code>n = int(input())
vector = [0] * n
for i in range(n):
    vector[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if (condicion sobre vector[i] o sobre i):
        nuevo[k] = (lo que se copia)
        k = k + 1</code></pre>', '<pre><code>n = int(input())
a = [0] * n
for i in range(n):
    a[i] = int(input())
m = int(input())
b = [0] * m
for i in range(m):
    b[i] = int(input())

nuevo = [0] * (n + m)
k = 0
for i in range(n):
    nuevo[k] = a[i]
    k = k + 1
for i in range(m):
    nuevo[k] = b[i]
    k = k + 1

for i in range(n + m):
    print(nuevo[i])</code></pre><p>El mismo <code>k</code> sigue de un ciclo al otro: termina A en la posición <code>n</code> y desde ahí empieza B.</p>', '[{"stdin":"3\n1\n2\n3\n2\n8\n9\n","expected_output":"1\n2\n3\n8\n9"},{"stdin":"1\n5\n3\n-1\n-2\n-3\n","expected_output":"5\n-1\n-2\n-3"},{"stdin":"2\n4\n4\n1\n0\n","expected_output":"4\n4\n0"}]', '# V-D.6 — Unir dos vectores
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'vector = [5, 0, 8, 0]
nuevo = [0] * 4
k = 0
for i in range(4):
    if vector[i] != 0:
        nuevo[k] = vector[i]
        k = k + 1
for i in range(4):
    if vector[i] == 0:
        nuevo[k] = vector[i]
        k = k + 1
print(nuevo)', '{"options":[{"id":"a","text":"[5, 8, 0, 0]"},{"id":"b","text":"[0, 0, 5, 8]"},{"id":"c","text":"[5, 0, 8, 0]"},{"id":"d","text":"IndexError"}]}', '{"option_id":"a"}', 'Dos pasadas con el MISMO k: la primera pone 5 y 8 en las casillas 0 y 1, la segunda sigue en la 2 con los ceros.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Al separar en dos vectores, ¿por qué cada uno lleva su propio contador?', NULL, '{"options":[{"id":"a","text":"Cada vector se llena a su ritmo: un solo k dejaría huecos en los dos"},{"id":"b","text":"Porque Python no deja usar k dos veces"},{"id":"c","text":"Para que el programa sea más corto"},{"id":"d","text":"No hace falta: se puede usar i en los dos"}]}', '{"option_id":"a"}', 'k1 cuenta lo que entró al primer vector y k2 lo del segundo. Son cantidades distintas.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Debe poner los negativos primero y después el resto. ¿En qué línea está el error?', NULL, '{"lines":["nuevo = [0] * n","k = 0","for i in range(n):","    if vector[i] < 0:","        nuevo[k] = vector[i]","        k = k + 1","k = 0","for i in range(n):","    if vector[i] >= 0:","        nuevo[k] = vector[i]","        k = k + 1"]}', '{"line_number":7}', 'Reiniciar k hace que la segunda pasada escriba encima de los negativos. En V-C, k NUNCA se reinicia.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'vector = [4, 7, 2, 8]
pares = [0] * 4
impares = [0] * 4
k1 = 0
k2 = 0
for i in range(4):
    if vector[i] % 2 == 0:
        pares[k1] = vector[i]
        k1 = k1 + 1
    else:
        impares[k2] = vector[i]
        k2 = k2 + 1
print(k1)
print(k2)', '{"options":[{"id":"a","text":"3\n1"},{"id":"b","text":"2\n2"},{"id":"c","text":"1\n3"},{"id":"d","text":"4\n0"}]}', '{"option_id":"a"}', '4, 2 y 8 son pares (k1 = 3); solo el 7 es impar (k2 = 1).', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Para mover los ceros al final usando UN solo vector nuevo, ¿cuántas pasadas por el original?', NULL, '{"options":[{"id":"a","text":"2"},{"id":"b","text":"1"},{"id":"c","text":"3"},{"id":"d","text":"n"}]}', '{"option_id":"a"}', 'Una para los distintos de cero y otra para los ceros, con el mismo k.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'vector = [1, 2, 3]
nuevo = [0] * 3
k = 2
for i in range(3):
    nuevo[k] = vector[i]
    k = k - 1
print(nuevo)', '{"options":[{"id":"a","text":"[3, 2, 1]"},{"id":"b","text":"[1, 2, 3]"},{"id":"c","text":"[0, 0, 3]"},{"id":"d","text":"IndexError"}]}', '{"option_id":"a"}', 'i sube de 0 a 2 mientras k baja de 2 a 0: el primero queda de último.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'nivel0';

-- ── Capítulo 7: Simulacro de examen (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 7, 'Simulacro de examen', '🎯', 'Cinco enunciados tipo juez que mezclan los patrones.', '<div class="jc-reglas" role="note">
  <strong>⚠️ Reglas del curso:</strong> no uses <code>.append()</code>, f-strings, <code>.map()</code> ni comprensiones. Todos los vectores se crean con <code>[0] * n</code> y se llenan por índice. Siempre.
</div>

<p>Los cinco últimos ejercicios están escritos como los del juez: un enunciado con historia que esconde dos o tres patrones. Reglas del simulacro:</p>

<ol>
  <li>Cronómetro: <strong>20 minutos por ejercicio</strong>.</li>
  <li>Antes de escribir código, lee el enunciado y anota qué patrón resuelve cada cosa que se pide imprimir. Debe tomarte <strong>menos de 30 segundos</strong>.</li>
  <li>Escribe primero el esqueleto I (leer el vector) y después cada patrón en su propio ciclo. No los mezcles.</li>
  <li>Copia el formato de salida <strong>letra por letra</strong>: espacios, dos puntos y mayúsculas cuentan para el juez.</li>
</ol>

<table>
  <thead>
    <tr><th>Si el enunciado dice…</th><th>Patrón</th></tr>
  </thead>
  <tbody>
    <tr><td>"cuántos…"</td><td>II · contar</td></tr>
    <tr><td>"el total", "la suma", "el promedio"</td><td>III · acumular</td></tr>
    <tr><td>"el mayor", "el menor", "el mejor", "quién ganó"</td><td>IV · máximo / mínimo (con <code>pos</code> si piden quién)</td></tr>
    <tr><td>"muestra los que…", "lista de…"</td><td>V-A · filtrar con k</td></tr>
    <tr><td>"separa en…"</td><td>V-B · dos vectores, dos k</td></tr>
    <tr><td>"primero los… y luego…", "al final los…"</td><td>V-C · varias pasadas, un k</td></tr>
  </tbody>
</table>

<p>Cuando resuelvas los cinco sin abrir la solución, presenta el quiz. Si lo apruebas, estás listo para el examen del juez.</p>', 1, 'nivel0'
    FROM parts p WHERE p.number = 3 AND p.track = 'nivel0'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 7 AND track = 'nivel0'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'nivel0');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, '🎯 Simulacro.1 — Temperaturas', 'medio', '<p>Una estación registró <code>N</code> temperaturas (enteros). Lee <code>N</code> y las temperaturas. Imprime, con este formato exacto:</p><pre><code>Bajo cero: (cuántas fueron menores a 0)
Maxima: (la temperatura más alta)</code></pre><p>y después, una por línea, las temperaturas bajo cero en el orden en que llegaron.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>6
3
-2
14
-5
0
9</code></pre><p>Salida:</p><pre><code>Bajo cero: 2
Maxima: 14
-2
-5</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code># 1. Lee el enunciado y subraya QUÉ se pide imprimir.
# 2. Por cada cosa que se pide, decide el patrón (contar, sumar, máximo, k).
# 3. Escribe primero la lectura del vector, después cada patrón por separado.</code></pre>', '<pre><code>n = int(input())
temps = [0] * n
for i in range(n):
    temps[i] = int(input())

bajo = [0] * n
k = 0
for i in range(n):
    if temps[i] &lt; 0:
        bajo[k] = temps[i]
        k = k + 1

maxima = temps[0]
for i in range(1, n):
    if temps[i] &gt; maxima:
        maxima = temps[i]

print("Bajo cero: " + str(k))
print("Maxima: " + str(maxima))
for i in range(k):
    print(bajo[i])</code></pre><p>Patrones: V-A (copiar bajo cero, y <code>k</code> sirve de contador) + IV (máximo). Cada cosa en su ciclo.</p>', '[{"stdin":"6\n3\n-2\n14\n-5\n0\n9\n","expected_output":"Bajo cero: 2\nMaxima: 14\n-2\n-5"},{"stdin":"2\n-1\n-8\n","expected_output":"Bajo cero: 2\nMaxima: -1\n-1\n-8"},{"stdin":"3\n20\n22\n18\n","expected_output":"Bajo cero: 0\nMaxima: 22"}]', '# 🎯 Simulacro.1 — Temperaturas
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, '🎯 Simulacro.2 — Tienda', 'medio', '<p>Lee <code>N</code> precios vendidos hoy. Imprime, con este formato exacto:</p><pre><code>Total: (suma)
Promedio: (suma // N)
Sobre el promedio: (cuántos precios son mayores al promedio)</code></pre><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
5000
12000
800
7000</code></pre><p>Salida:</p><pre><code>Total: 24800
Promedio: 6200
Sobre el promedio: 2</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code># 1. Lee el enunciado y subraya QUÉ se pide imprimir.
# 2. Por cada cosa que se pide, decide el patrón (contar, sumar, máximo, k).
# 3. Escribe primero la lectura del vector, después cada patrón por separado.</code></pre>', '<pre><code>n = int(input())
precios = [0] * n
for i in range(n):
    precios[i] = int(input())

total = 0
for i in range(n):
    total = total + precios[i]
promedio = total // n

cuenta = 0
for i in range(n):
    if precios[i] &gt; promedio:
        cuenta = cuenta + 1

print("Total: " + str(total))
print("Promedio: " + str(promedio))
print("Sobre el promedio: " + str(cuenta))</code></pre><p>Patrones: III (sumar) + II (contar con condición que depende del promedio).</p>', '[{"stdin":"4\n5000\n12000\n800\n7000\n","expected_output":"Total: 24800\nPromedio: 6200\nSobre el promedio: 2"},{"stdin":"2\n300\n300\n","expected_output":"Total: 600\nPromedio: 300\nSobre el promedio: 0"},{"stdin":"4\n1\n2\n3\n10\n","expected_output":"Total: 16\nPromedio: 4\nSobre el promedio: 1"}]', '# 🎯 Simulacro.2 — Tienda
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, '🎯 Simulacro.3 — Notas del curso', 'dificil', '<p>Lee <code>N</code>. Por cada estudiante llegan dos líneas: nombre y nota (0 a 100). Imprime:</p><pre><code>Promedio: (suma // N)
Mejor: (nombre de la nota más alta; si hay empate, el primero)
Reprobados:</code></pre><p>y debajo, uno por línea, los nombres con nota menor a 60.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
Ana
80
Luis
45
Marta
99
Pedro
30</code></pre><p>Salida:</p><pre><code>Promedio: 63
Mejor: Marta
Reprobados:
Luis
Pedro</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code># 1. Lee el enunciado y subraya QUÉ se pide imprimir.
# 2. Por cada cosa que se pide, decide el patrón (contar, sumar, máximo, k).
# 3. Escribe primero la lectura del vector, después cada patrón por separado.</code></pre>', '<pre><code>n = int(input())
nombres = [""] * n
notas = [0] * n
for i in range(n):
    nombres[i] = input()
    notas[i] = int(input())

suma = 0
for i in range(n):
    suma = suma + notas[i]

pos = 0
for i in range(1, n):
    if notas[i] &gt; notas[pos]:
        pos = i

reprobados = [""] * n
k = 0
for i in range(n):
    if notas[i] &lt; 60:
        reprobados[k] = nombres[i]
        k = k + 1

print("Promedio: " + str(suma // n))
print("Mejor: " + nombres[pos])
print("Reprobados:")
for i in range(k):
    print(reprobados[i])</code></pre><p>Patrones: III (suma) + IV (posición del mejor, para sacar el nombre con el mismo índice) + V-A (copiar nombres). Tres ciclos, tres ideas.</p>', '[{"stdin":"4\nAna\n80\nLuis\n45\nMarta\n99\nPedro\n30\n","expected_output":"Promedio: 63\nMejor: Marta\nReprobados:\nLuis\nPedro"},{"stdin":"2\nSol\n70\nJuan\n70\n","expected_output":"Promedio: 70\nMejor: Sol\nReprobados:"},{"stdin":"1\nEva\n10\n","expected_output":"Promedio: 10\nMejor: Eva\nReprobados:\nEva"}]', '# 🎯 Simulacro.3 — Notas del curso
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, '🎯 Simulacro.4 — Inventario', 'medio', '<p>Lee <code>N</code> cantidades en bodega. Imprime <code>Agotados: (cuántos están en 0)</code> y después el inventario reorganizado: primero los productos con existencias y al final los agotados, uno por línea.</p><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>5
5
0
12
0
3</code></pre><p>Salida:</p><pre><code>Agotados: 2
5
12
3
0
0</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code># 1. Lee el enunciado y subraya QUÉ se pide imprimir.
# 2. Por cada cosa que se pide, decide el patrón (contar, sumar, máximo, k).
# 3. Escribe primero la lectura del vector, después cada patrón por separado.</code></pre>', '<pre><code>n = int(input())
cantidades = [0] * n
for i in range(n):
    cantidades[i] = int(input())

nuevo = [0] * n
k = 0
for i in range(n):
    if cantidades[i] != 0:
        nuevo[k] = cantidades[i]
        k = k + 1
agotados = n - k
for i in range(n):
    if cantidades[i] == 0:
        nuevo[k] = cantidades[i]
        k = k + 1

print("Agotados: " + str(agotados))
for i in range(n):
    print(nuevo[i])</code></pre><p>Patrón V-C (ceros al final). Al terminar la primera pasada, <code>n - k</code> ya es la cantidad de ceros.</p>', '[{"stdin":"5\n5\n0\n12\n0\n3\n","expected_output":"Agotados: 2\n5\n12\n3\n0\n0"},{"stdin":"2\n0\n0\n","expected_output":"Agotados: 2\n0\n0"},{"stdin":"2\n7\n1\n","expected_output":"Agotados: 0\n7\n1"}]', '# 🎯 Simulacro.4 — Inventario
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 5, '🎯 Simulacro.5 — Maratón', 'dificil', '<p>Lee <code>N</code> tiempos en segundos de una carrera (el corredor 1 es el primero que llega en la entrada). Imprime:</p><pre><code>Ganador: (número de corredor, contando desde 1, con el menor tiempo)
Tiempo: (su tiempo)
Lentos: (cuántos tardaron más que el promedio, división entera)</code></pre><p><strong>Ejemplo</strong></p><p>Entrada:</p><pre><code>4
320
290
410
300</code></pre><p>Salida:</p><pre><code>Ganador: 2
Tiempo: 290
Lentos: 1</code></pre>', '<p>Esqueleto del patrón — escríbelo de memoria y cambia solo lo necesario:</p><pre><code># 1. Lee el enunciado y subraya QUÉ se pide imprimir.
# 2. Por cada cosa que se pide, decide el patrón (contar, sumar, máximo, k).
# 3. Escribe primero la lectura del vector, después cada patrón por separado.</code></pre>', '<pre><code>n = int(input())
tiempos = [0] * n
for i in range(n):
    tiempos[i] = int(input())

pos = 0
for i in range(1, n):
    if tiempos[i] &lt; tiempos[pos]:
        pos = i

suma = 0
for i in range(n):
    suma = suma + tiempos[i]
promedio = suma // n

lentos = 0
for i in range(n):
    if tiempos[i] &gt; promedio:
        lentos = lentos + 1

print("Ganador: " + str(pos + 1))
print("Tiempo: " + str(tiempos[pos]))
print("Lentos: " + str(lentos))</code></pre><p>Patrones: IV (posición del menor) + III (promedio) + II (contar). Guardar la POSICIÓN te da el número del corredor y su tiempo a la vez.</p>', '[{"stdin":"4\n320\n290\n410\n300\n","expected_output":"Ganador: 2\nTiempo: 290\nLentos: 1"},{"stdin":"1\n100\n","expected_output":"Ganador: 1\nTiempo: 100\nLentos: 0"},{"stdin":"3\n50\n50\n80\n","expected_output":"Ganador: 1\nTiempo: 50\nLentos: 1"}]', '# 🎯 Simulacro.5 — Maratón
# Escribe el esqueleto de memoria. Sin append, sin f-strings.

', 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'nivel0');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Enunciado: "imprime el total recaudado en el día". ¿Qué patrón?', NULL, '{"options":[{"id":"a","text":"II · contar"},{"id":"b","text":"III · acumular"},{"id":"c","text":"IV · máximo / mínimo"},{"id":"d","text":"V-A · filtrar con k"}]}', '{"option_id":"b"}', '"Total" = acumular con suma = suma + ...', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Enunciado: "imprime el NOMBRE del estudiante con la nota más alta". ¿Qué patrón?', NULL, '{"options":[{"id":"a","text":"IV · máximo guardando la posición"},{"id":"b","text":"II · contar"},{"id":"c","text":"III · acumular"},{"id":"d","text":"V-B · separar"}]}', '{"option_id":"a"}', 'Se busca el máximo de las notas guardando pos, y se imprime nombres[pos].', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Enunciado: "muestra el inventario con los productos agotados al final". ¿Qué patrón?', NULL, '{"options":[{"id":"a","text":"V-C · varias pasadas, un k"},{"id":"b","text":"V-A · filtrar"},{"id":"c","text":"IV · mínimo"},{"id":"d","text":"II · contar"}]}', '{"option_id":"a"}', '"Primero unos y al final otros" en un mismo vector es reorganizar: V-C.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Enunciado: "separa los clientes en VIP y normales". ¿Qué patrón?', NULL, '{"options":[{"id":"a","text":"V-B · dos vectores, dos k"},{"id":"b","text":"V-C · un vector, un k"},{"id":"c","text":"III · acumular"},{"id":"d","text":"IV · máximo"}]}', '{"option_id":"a"}', 'Separar en dos listas = dos vectores con su propio contador.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Enunciado: "muestra las temperaturas que superaron 30 grados". ¿Qué patrón?', NULL, '{"options":[{"id":"a","text":"II · contar"},{"id":"b","text":"III · acumular"},{"id":"c","text":"IV · máximo / mínimo"},{"id":"d","text":"V-A · filtrar con k"}]}', '{"option_id":"d"}', '"Muestra los que…" = filtrar a un vector nuevo con k e imprimir hasta k.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Enunciado: "¿cuántos días llovió más de 10 mm?". ¿Qué patrón?', NULL, '{"options":[{"id":"a","text":"II · contar"},{"id":"b","text":"III · acumular"},{"id":"c","text":"IV · máximo / mínimo"},{"id":"d","text":"V-A · filtrar con k"}]}', '{"option_id":"a"}', '"Cuántos" = contar.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'nivel0';

