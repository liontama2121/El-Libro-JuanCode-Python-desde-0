-- ============================================================================
--  CONTENIDO DEL LIBRO — generado por scripts/build-contenido.mjs
--  No editar a mano: se regenera con `npm run content:build`.
--  Solo toca las filas con source = 'seed'.
-- ============================================================================

INSERT INTO parts (number, title, emoji, track) VALUES (1, 'Entrada y salida', '⚙️', 'avanzado')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji, track) VALUES (2, 'Estructuras', '🧱', 'avanzado')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji, track) VALUES (3, 'Recursión y búsqueda', '🌳', 'avanzado')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji, track) VALUES (4, 'Técnicas de diseño', '🧠', 'avanzado')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji, track) VALUES (5, 'Recorridos y grafos', '🧭', 'avanzado')
  ON CONFLICT(track, number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;

-- ── Capítulo 1: Setup DOMjudge (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 1, 'Setup DOMjudge', '⚙️', 'Leer hasta EOF y responder casos múltiples como los pide el juez.', '<p class="jc-gancho">Tu programa funciona perfecto en tu computador. Lo subes a DOMjudge y te responde <strong>Wrong Answer</strong>. No es que el algoritmo esté mal: es que el juez no es una persona. No lee tus mensajes, no escribe cuando le pides datos, y compara tu salida carácter por carácter. Este módulo es sobre hablarle a esa máquina.</p>

<h2>📖 Enunciado</h2>

<div class="jc-problema">

<h3>Suma hasta el fin</h3>
<p><em>Problema introductorio — Lectura hasta EOF</em></p>

<p><strong>Descripción.</strong> Este ejercicio permite familiarizarse con el flujo de trabajo de DOMjudge. Se reciben varios pares de enteros y se debe imprimir la suma de cada par. La cantidad de pares no aparece al inicio: el programa debe continuar leyendo hasta alcanzar el fin del archivo, conocido como <strong>EOF</strong>.</p>

<p><strong>Entrada.</strong> La entrada contiene cero o más líneas. Cada línea contiene dos enteros <code>a</code> y <code>b</code>, separados por uno o más espacios, con −10⁹ ≤ a, b ≤ 10⁹. La entrada termina al alcanzar EOF.</p>

<p><strong>Salida.</strong> Por cada línea de entrada, imprima una línea con el valor <code>a + b</code>. No agregue etiquetas, mensajes ni texto adicional.</p>

<table>
  <thead>
    <tr><th>Ejemplo de entrada</th><th>Ejemplo de salida</th></tr>
  </thead>
  <tbody>
    <tr>
      <td><pre><code>2 3
-4 10
100 250</code></pre></td>
      <td><pre><code>5
6
350</code></pre></td>
    </tr>
  </tbody>
</table>

<p><strong>Observación.</strong> DOMjudge proporciona la entrada automáticamente. No use mensajes como "Ingrese un número". La solución debe funcionar aunque la cantidad de líneas cambie.</p>

</div>

<h2>💡 Análisis y estrategia</h2>

<p>Tres cosas que en clase no importan y aquí deciden si pasas o no:</p>

<h3>1. No hay contador: hay EOF</h3>

<p>En los ejercicios de clase te dicen <em>"lo primero que llega es cuántos casos son"</em>. Aquí no. El juez te entrega un archivo y tú lees <strong>hasta que se acabe</strong>. Ese final se llama EOF (<em>end of file</em>), y no es un valor que puedas comparar: es un estado.</p>

<pre><code># ❌ Esto espera un contador que nunca llega
n = int(input())
for _ in range(n):
    ...

# ❌ Esto espera una marca de fin que el enunciado no menciona
while True:
    a, b = map(int, input().split())
    if a == 0 and b == 0:
        break</code></pre>

<p>El enunciado dice <em>"la entrada termina al alcanzar EOF"</em>. Inventarse un <code>0 0</code> es responder otro problema.</p>

<h3>2. <code>sys.stdin</code> es un iterable de líneas</h3>

<p>La forma directa de decir "recorre lo que llegue, hasta donde llegue":</p>

<pre><code>import sys

for linea in sys.stdin:
    ...</code></pre>

<p>Ese <code>for</code> termina solo cuando el archivo se acaba. Es la misma idea de recorrer una lista, pero la lista la va entregando el juez.</p>

<p>La alternativa con <code>input()</code> también sirve — cuando no hay más datos, <code>input()</code> <strong>lanza una excepción</strong>:</p>

<pre><code>while True:
    try:
        linea = input()
    except EOFError:
        break
    ...</code></pre>

<p>Las dos son correctas. La primera es más corta y más rápida cuando la entrada es grande.</p>

<h3>3. Cero mensajes</h3>

<p>El juez compara tu salida con la esperada <strong>carácter por carácter</strong>. Un <code>print("Ingrese los números:")</code> mete una línea que no debería estar, y todo lo demás queda corrido. La respuesta es <strong>Wrong Answer</strong>, aunque tus sumas estén perfectas.</p>

<p>Regla: en competencia <strong>solo se imprime lo que el enunciado pide</strong>. Ni saludos, ni "El resultado es:", ni líneas de adorno.</p>

<h2>💻 Código paso a paso</h2>

<pre><code>import sys

for linea in sys.stdin:
    partes = linea.split()
    if len(partes) &lt; 2:
        continue
    a = int(partes[0])
    b = int(partes[1])
    print(a + b)</code></pre>

<table>
  <thead>
    <tr><th>Línea</th><th>Qué hace y por qué está ahí</th></tr>
  </thead>
  <tbody>
    <tr><td><code>import sys</code></td><td>Da acceso a <code>sys.stdin</code>, que es la entrada que el juez alimenta</td></tr>
    <tr><td><code>for linea in sys.stdin:</code></td><td>Recorre línea por línea <strong>hasta EOF</strong>. Sin contador y sin marca de fin</td></tr>
    <tr><td><code>linea.split()</code></td><td>Parte por espacios. Sin argumentos, <code>split()</code> trata varios espacios seguidos como uno solo — el enunciado dice "uno o más espacios"</td></tr>
    <tr><td><code>if len(partes) &lt; 2: continue</code></td><td>Blindaje: una línea vacía al final del archivo es normal. Sin esto, <code>partes[0]</code> reventaría con <code>IndexError</code></td></tr>
    <tr><td><code>int(partes[0])</code></td><td><code>split()</code> devuelve <strong>texto</strong>. Sin convertir, <code>a + b</code> pegaría <code>"2" + "3" = "23"</code></td></tr>
    <tr><td><code>print(a + b)</code></td><td>Una línea por cada par. Nada más</td></tr>
  </tbody>
</table>

<h3>La película de la entrada del ejemplo</h3>

<table>
  <thead>
    <tr><th>Vuelta</th><th>linea</th><th>partes</th><th>imprime</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td><code>"2 3\n"</code></td><td><code>["2", "3"]</code></td><td><code>5</code></td></tr>
    <tr><td>2</td><td><code>"-4 10\n"</code></td><td><code>["-4", "10"]</code></td><td><code>6</code></td></tr>
    <tr><td>3</td><td><code>"100 250"</code></td><td><code>["100", "250"]</code></td><td><code>350</code></td></tr>
    <tr><td>4</td><td>EOF</td><td>—</td><td>el <code>for</code> termina</td></tr>
  </tbody>
</table>

<p>Fíjate en que la entrada vacía también es válida: si el archivo no trae ninguna línea, el <code>for</code> no entra ni una vez y el programa no imprime nada. Eso es <strong>correcto</strong> según el enunciado ("cero o más líneas").</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Imprimir mensajes</h3>
<pre><code>print("Ingrese dos numeros:")   # ❌ Wrong Answer garantizado
a, b = map(int, input().split())</code></pre>
<p>En tu computador se ve amigable. Para el juez es una línea de más.</p>

<h3>2. Esperar un contador que no existe</h3>
<pre><code>n = int(input())    # ❌ se traga el primer par como si fuera n</code></pre>

<h3>3. Sumar texto sin convertir</h3>
<pre><code>a, b = linea.split()
print(a + b)        # ❌ imprime "23" en vez de 5</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Sin contador en el enunciado → <code>for linea in sys.stdin</code>.</li>
  <li><code>split()</code> sin argumentos, que aguanta espacios de más.</li>
  <li>Saltar las líneas que no traigan lo esperado.</li>
  <li>Convertir a <code>int</code> antes de operar.</li>
  <li>Imprimir <strong>solo</strong> lo que el enunciado pide.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>for linea in sys.stdin:</code></td><td>Recorre hasta EOF</td></tr>
    <tr><td><code>sys.stdin.read()</code></td><td>Trae toda la entrada de una vez, como un solo texto</td></tr>
    <tr><td><code>try: input() / except EOFError:</code></td><td>La otra forma de detectar el fin</td></tr>
    <tr><td><code>linea.split()</code></td><td>Parte por espacios, aguantando varios seguidos</td></tr>
    <tr><td><code>int(x)</code></td><td>Texto a número: sin esto, <code>+</code> concatena</td></tr>
    <tr><td><code>print(a + b)</code></td><td>Una línea de salida. Nada de mensajes</td></tr>
  </tbody>
</table>

<blockquote>El juez no lee lo que quisiste decir: compara lo que imprimiste, carácter por carácter. Programar para un juez es aprender a callarse.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 1 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 1 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Suma hasta el fin', 'facil', '<p>El ejercicio del enunciado, tal como lo pide el juez: lee pares de enteros <strong>hasta EOF</strong> e imprime la suma de cada par.</p><pre><code>Entrada:
2 3
-4 10
100 250

Salida:
5
6
350</code></pre><p>Sin contador al inicio, sin marca de fin, y <strong>sin un solo mensaje</strong> que el enunciado no pida.</p>', '<p><code>for linea in sys.stdin:</code> recorre hasta que se acabe la entrada. Acuérdate de convertir con <code>int()</code>: <code>split()</code> devuelve texto.</p>', '<pre><code>''''''
Programa: Suma hasta el fin
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Lee pares de enteros hasta EOF e imprime la suma de cada par,
    en el formato exacto que espera DOMjudge.
''''''

import sys

# Inicio
# sys.stdin se recorre como una lista de lineas: el for termina solo
# cuando la entrada se acaba. No hay contador ni marca de fin
for linea in sys.stdin:
    partes = linea.split()

    # Blindaje: una linea vacia al final del archivo es normal.
    # Sin esto, partes[0] reventaria con IndexError
    if len(partes) < 2:
        continue

    # split() devuelve TEXTO: sin int(), el + concatenaria
    a = int(partes[0])
    b = int(partes[1])

    print(a + b)
# Fin</code></pre><p>Tres decisiones que separan un <em>Accepted</em> de un <em>Wrong Answer</em>:</p><ul><li><strong>Leer hasta EOF, no hasta un contador.</strong> El enunciado dice "cero o más líneas" y "termina al alcanzar EOF". Un <code>n = int(input())</code> se tragaría el primer par creyendo que es la cantidad.</li><li><strong>El guardia de la línea corta.</strong> Casi todos los archivos terminan con un salto de línea, así que la última vuelta puede traer una línea vacía. <code>continue</code> la ignora sin romper nada.</li><li><strong>Nada de mensajes.</strong> El juez compara carácter por carácter. Un <code>print("Ingrese...")</code> desalinea toda la salida.</li></ul><p>La otra forma válida, si prefieres <code>input()</code>:</p><pre><code>while True:
    try:
        linea = input()
    except EOFError:
        break
    ...</code></pre><p>Al agotarse la entrada, <code>input()</code> no devuelve nada especial: <strong>lanza <code>EOFError</code></strong>. Por eso el corte va con <code>try/except</code> y no con una comparación.</p>', '[{"stdin":"2 3\n-4 10\n100 250\n","expected_output":"5\n6\n350\n"},{"stdin":"1000000000 1000000000\n","expected_output":"2000000000\n"},{"stdin":"5    7\n-3   -9\n","expected_output":"12\n-12\n"},{"stdin":"","expected_output":""},{"stdin":"8 9\n\n","expected_output":"17\n"}]', '''''''
Programa: Suma hasta el fin
Autor:
Fecha:
Descripcion:
''''''

import sys

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'La otra forma: try / except EOFError', 'facil', '<p>El mismo problema, pero leyendo con <code>input()</code> en vez de <code>sys.stdin</code>. Sirve para entender <strong>qué pasa exactamente</strong> cuando la entrada se acaba.</p><p>Misma entrada y misma salida que el ejercicio anterior.</p>', '<p><code>input()</code> no devuelve <code>None</code> ni cadena vacía al final: <strong>lanza <code>EOFError</code></strong>. El ciclo se corta atrapando esa excepción.</p>', '<pre><code>''''''
Programa: Suma hasta el fin (con input y EOFError)
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    La misma lectura hasta EOF, hecha con input() y try/except.
''''''

# Inicio
while True:
    try:
        linea = input()
    except EOFError:
        # La entrada se acabo: no es un error del programa, es el final
        break

    partes = linea.split()
    if len(partes) < 2:
        continue

    print(int(partes[0]) + int(partes[1]))
# Fin</code></pre><p>Las dos formas son correctas y el juez las acepta igual. La diferencia está en el detalle:</p><ul><li><strong>La excepción no es un fallo.</strong> <code>EOFError</code> es la manera que tiene Python de decir "ya no hay más". Atraparla es el uso legítimo de <code>try/except</code>, no un parche.</li><li><strong>El <code>break</code> va adentro del <code>except</code>.</strong> Puesto después del <code>try</code>, cortaría en la primera vuelta.</li><li><strong>Con entradas grandes, <code>sys.stdin</code> gana.</strong> <code>input()</code> hace más trabajo por línea; con cien mil líneas la diferencia se nota. Por eso la versión recomendada es la del ejercicio anterior.</li></ul>', '[{"stdin":"2 3\n-4 10\n100 250\n","expected_output":"5\n6\n350\n"},{"stdin":"","expected_output":""},{"stdin":"42 8\n","expected_output":"50\n"}]', '''''''
Programa: Suma hasta el fin (con input y EOFError)
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace `for linea in sys.stdin`?', NULL, '{"options":[{"id":"a","text":"Lee una línea"},{"id":"b","text":"Lee todas las líneas hasta EOF"},{"id":"c","text":"Lee un archivo específico del disco"},{"id":"d","text":"Espera a que el usuario escriba y presione Enter una vez"}]}', '{"option_id":"b"}', 'sys.stdin se comporta como una lista de líneas que el juez va entregando. El for termina solo cuando el archivo se acaba: eso es EOF, y no hace falta ni contador ni marca de fin.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Si usamos input() dentro de un bucle infinito, ¿cómo terminamos al llegar a EOF?', NULL, '{"options":[{"id":"a","text":"Con un break manual cuando llegue una línea vacía"},{"id":"b","text":"Con try / except EOFError"},{"id":"c","text":"No se puede: toca usar sys.stdin"},{"id":"d","text":"input() devuelve None y se compara con None"}]}', '{"option_id":"b"}', 'Al agotarse la entrada, input() no devuelve nada especial: lanza EOFError. Por eso el ciclo se corta atrapando la excepción, no comparando el valor.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué NO usar print("Ingrese numeros:") en DOMjudge?', NULL, '{"options":[{"id":"a","text":"Porque es lento"},{"id":"b","text":"Porque el juez compara la salida carácter por carácter y esa línea sobra"},{"id":"c","text":"No importa, el juez ignora los mensajes"},{"id":"d","text":"Porque print no funciona en DOMjudge"}]}', '{"option_id":"b"}', 'El juez no es una persona: no ve un mensaje amable, ve una línea de más. Todo lo que sigue queda corrido y la respuesta es Wrong Answer aunque tus cuentas estén bien.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'La entrada trae las líneas "2 3" y "10 20". ¿Qué imprime?', 'import sys

for linea in sys.stdin:
    a, b = linea.split()
    print(a + b)', '{"options":[{"id":"a","text":"23\n1020"},{"id":"b","text":"5\n30"},{"id":"c","text":"Lanza TypeError"},{"id":"d","text":"5 30"}]}', '{"option_id":"a"}', 'split() devuelve TEXTO. Sobre dos textos, el + concatena en vez de sumar: "2" + "3" es "23". Falta convertir con int() antes de operar.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este programa falla con Wrong Answer aunque las sumas están bien. ¿En qué línea está el problema?', NULL, '{"lines":["import sys","print(\"Ingrese los pares de numeros:\")","for linea in sys.stdin:","    a, b = map(int, linea.split())","    print(a + b)"]}', '{"line_number":2}', 'El mensaje sale por la misma salida que compara el juez. Esa línea extra desalinea todo lo demás. En competencia solo se imprime lo que el enunciado pide.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la lectura hasta EOF.', NULL, '{"code":"import sys\n\nfor linea in ___1___:\n    partes = linea.___2___\n    if len(partes) < 2:\n        continue\n    print(int(partes[0]) + int(partes[1]))","blanks":[{"id":"1","pista":"la entrada que alimenta el juez"},{"id":"2","pista":"partir la línea por espacios"}]}', '{"answers":{"1":["sys.stdin"],"2":["split()"]}}', 'sys.stdin recorrido con for llega hasta EOF sin necesitar contador. split() sin argumentos trata varios espacios seguidos como uno solo, que es justo lo que pide el enunciado.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'facil', 'Arma la solución de Suma hasta el fin', NULL, '{"lines":[{"id":"s1","text":"import sys","indent":0},{"id":"s2","text":"for linea in sys.stdin:","indent":0},{"id":"s3","text":"partes = linea.split()","indent":1},{"id":"s4","text":"if len(partes) < 2:","indent":1},{"id":"s5","text":"continue","indent":2},{"id":"s6","text":"print(int(partes[0]) + int(partes[1]))","indent":1}]}', '{"order":["s1","s2","s3","s4","s5","s6"]}', 'El guardia contra líneas cortas va ANTES de leer partes[0] y partes[1]. Si va después, una línea vacía al final del archivo revienta con IndexError.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'avanzado';

-- ── Capítulo 2: Strings avanzados (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 2, 'Strings avanzados', '🔤', 'split, join e indexado por posición sobre varias líneas.', '<p class="jc-gancho">Este problema no tiene un algoritmo difícil: es tomar una letra de cada palabra. Lo que tumba a la gente es el <strong>formato</strong> — las líneas en blanco entre casos, el <code>Case #k:</code> exacto, y una regla escondida en una sola frase del enunciado que cambia todo el resultado.</p>

<h2>📖 Enunciado</h2>

<div class="jc-problema">

<h3>Decodificando el mensaje</h3>
<p><em>Basado en Decoding the message</em></p>

<p><strong>Descripción.</strong> Chico y María viven en pueblos diferentes y envían mensajes por medio de sus padres. Para evitar que otras personas los lean, inventaron un código sencillo.</p>

<p>Para decodificar una línea se toma la <strong>primera letra de la primera palabra</strong>, la <strong>segunda letra de la segunda palabra</strong>, la <strong>tercera letra de la tercera palabra</strong> y así sucesivamente. Si una palabra no tiene la posición requerida, <strong>se ignora</strong> y se intenta obtener esa misma posición de la siguiente palabra. Al terminar la línea se termina también la palabra decodificada; la siguiente línea comienza otra vez desde la primera letra de la primera palabra.</p>

<p><strong>Entrada.</strong> La primera línea contiene el número de casos <code>T</code>, con 1 ≤ T ≤ 30. Después aparece una línea en blanco. Cada caso contiene entre 1 y 100 líneas. Cada línea contiene entre 1 y 30 palabras, separadas por uno o más espacios. Una palabra contiene únicamente letras A-Z, mayúsculas o minúsculas, con máximo 30 caracteres. Una línea en blanco marca el final de cada caso.</p>

<p><strong>Salida.</strong> Para cada caso imprima primero <code>Case #k:</code>, donde <code>k</code> comienza en 1. Después imprima, una por línea, las palabras obtenidas al decodificar cada línea del mensaje. Imprima una línea en blanco <strong>entre</strong> casos consecutivos.</p>

<table>
  <thead>
    <tr><th>Ejemplo de entrada</th><th>Ejemplo de salida</th></tr>
  </thead>
  <tbody>
    <tr>
      <td><pre><code>2

Hey good lawyer
as I previously previewed
yam does a soup

First I give money to Teresa
after I inform dad of
your horrible soup</code></pre></td>
      <td><pre><code>Case #1:
How
are
you

Case #2:
Fine
and
you</code></pre></td>
    </tr>
  </tbody>
</table>

</div>

<h2>💡 Análisis y estrategia</h2>

<h3>La regla que decide todo</h3>

<p>Léela otra vez: <em>"Si una palabra no tiene la posición requerida, se ignora y se intenta obtener <strong>esa misma posición</strong> de la siguiente palabra."</em></p>

<p>Eso significa que la posición <strong>no es el número de palabra</strong>. Es un contador propio que <strong>solo avanza cuando se logra tomar una letra</strong>.</p>

<pre><code># ❌ Lo que casi todos escriben primero
for i, palabra in enumerate(palabras):
    resultado.append(palabra[i])       # explota, y además está mal

# ✅ La posición es su propia variable
posicion = 0
for palabra in palabras:
    if posicion &lt; len(palabra):
        resultado.append(palabra[posicion])
        posicion += 1                  # solo avanza si tomó letra</code></pre>

<p>Con <code>"Hey good lawyer"</code> las dos versiones dan lo mismo, porque todas las palabras alcanzan. Pero mira qué pasa con <code>"as I previously previewed"</code>:</p>

<table>
  <thead>
    <tr><th>Palabra</th><th>posicion</th><th>¿alcanza?</th><th>Toma</th><th>posicion queda</th></tr>
  </thead>
  <tbody>
    <tr><td><code>as</code></td><td>0</td><td>✅ sí</td><td><b>a</b></td><td>1</td></tr>
    <tr><td><code>I</code></td><td>1</td><td>❌ mide 1, no hay posición 1</td><td>—</td><td><b>1</b> (no avanza)</td></tr>
    <tr><td><code>previously</code></td><td>1</td><td>✅ sí</td><td><b>r</b></td><td>2</td></tr>
    <tr><td><code>previewed</code></td><td>2</td><td>✅ sí</td><td><b>e</b></td><td>3</td></tr>
  </tbody>
</table>

<p>Resultado: <code>are</code>. Si la posición hubiera avanzado al saltarse la <code>I</code>, habría salido <code>aee</code> — y el juez diría Wrong Answer sin explicar por qué.</p>

<h3>Reiniciar en cada línea</h3>

<p><em>"Al terminar la línea se termina también la palabra decodificada; la siguiente línea comienza otra vez desde la primera letra."</em> Cada línea produce <strong>una palabra independiente</strong>: la posición vuelve a 0. Por eso vive dentro de la función, no afuera.</p>

<h3>El formato de la salida</h3>

<p>Tres detalles que el juez sí revisa:</p>

<ul>
  <li><code>Case #1:</code> — con almohadilla, sin espacio antes de los dos puntos, y empezando en <strong>1</strong>, no en 0.</li>
  <li>La línea en blanco va <strong>entre</strong> casos. No después del último.</li>
  <li>La primera línea de la entrada es <code>T</code>, y <strong>después viene una línea en blanco</strong> antes del primer caso.</li>
</ul>

<h2>💻 Código paso a paso</h2>

<pre><code>import sys

def decodificar_linea(linea):
    palabras = linea.split()
    resultado = []
    posicion = 0
    for palabra in palabras:
        if posicion &lt; len(palabra):
            resultado.append(palabra[posicion])
            posicion += 1
    return "".join(resultado)

data = sys.stdin.read().split("\n")
T = int(data[0].strip())
idx = 2  # saltar la línea en blanco que va después de T

for caso in range(1, T + 1):
    if caso &gt; 1:
        print()
    print(f"Case #{caso}:")
    while idx &lt; len(data) and data[idx].strip() != "":
        print(decodificar_linea(data[idx]))
        idx += 1
    idx += 1  # saltar la línea en blanco del final del caso</code></pre>

<table>
  <thead>
    <tr><th>Pieza</th><th>Por qué está ahí</th></tr>
  </thead>
  <tbody>
    <tr><td><code>sys.stdin.read().split("\n")</code></td><td>Trae toda la entrada de una vez. Con casos separados por líneas en blanco, es más cómodo tener la lista completa que ir leyendo de a una</td></tr>
    <tr><td><code>idx = 2</code></td><td><code>data[0]</code> es T y <code>data[1]</code> es la línea en blanco. El primer caso empieza en <code>data[2]</code></td></tr>
    <tr><td><code>if caso &gt; 1: print()</code></td><td>La línea en blanco va <strong>entre</strong> casos: se imprime antes de cada uno menos del primero. Así no sobra al final</td></tr>
    <tr><td><code>while … data[idx].strip() != ""</code></td><td>El caso se acaba en la línea en blanco. El <code>idx &lt; len(data)</code> protege el final del archivo</td></tr>
    <tr><td><code>idx += 1</code> al final</td><td>Salta esa línea en blanco para que el siguiente caso arranque en su primera línea</td></tr>
    <tr><td><code>posicion</code> dentro de la función</td><td>Nace en 0 en cada línea. Si viviera afuera, la segunda línea seguiría contando desde donde quedó la primera</td></tr>
  </tbody>
</table>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Usar el índice de la palabra como posición</h3>
<pre><code>for i, palabra in enumerate(palabras):
    resultado.append(palabra[i])   # ❌ IndexError, y la lógica es otra</code></pre>
<p>La posición avanza <strong>solo cuando se toma una letra</strong>. No es lo mismo que el número de palabra.</p>

<h3>2. No reiniciar la posición en cada línea</h3>
<pre><code>posicion = 0            # ❌ afuera del ciclo de líneas
for linea in lineas:
    ...</code></pre>

<h3>3. La línea en blanco de más al final</h3>
<pre><code>print(f"Case #{caso}:")
...
print()                 # ❌ deja una línea en blanco después del último caso</code></pre>
<p>"Entre casos" no es "después de cada caso". Imprimirla antes, saltándose el primero, deja el formato exacto.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Lee la regla del enunciado dos veces antes de codificar: aquí, "esa misma posición" lo cambia todo.</li>
  <li>El contador de posición es una variable propia, no el índice del ciclo.</li>
  <li>Lo que el enunciado dice que se reinicia, se reinicia — y donde toca.</li>
  <li>Separador entre bloques: imprímelo <strong>antes</strong> de cada uno menos del primero.</li>
  <li>Copia el <code>Case #k:</code> carácter por carácter del enunciado.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>sys.stdin.read().split("\n")</code></td><td>Toda la entrada como lista de líneas</td></tr>
    <tr><td><code>linea.split()</code></td><td>Palabras, aguantando varios espacios</td></tr>
    <tr><td><code>palabra[posicion]</code></td><td>La letra en esa posición (desde 0)</td></tr>
    <tr><td><code>len(palabra)</code></td><td>Para saber si la posición existe</td></tr>
    <tr><td><code>"".join(lista)</code></td><td>Pega las letras en una palabra</td></tr>
    <tr><td><code>linea.strip() != ""</code></td><td>¿La línea tiene algo?</td></tr>
    <tr><td><code>if caso &gt; 1: print()</code></td><td>Separador entre bloques, sin sobrar al final</td></tr>
  </tbody>
</table>

<blockquote>El algoritmo era tomar una letra. El problema era leer bien el enunciado.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 1 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 2 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Decodificando el mensaje', 'medio', '<p>El ejercicio completo del enunciado: varios casos, cada uno con varias líneas, separados por líneas en blanco.</p><pre><code>Entrada:
2

Hey good lawyer
as I previously previewed
yam does a soup

First I give money to Teresa
after I inform dad of
your horrible soup

Salida:
Case #1:
How
are
you

Case #2:
Fine
and
you</code></pre><p>Cuidado con dos cosas: la posición <strong>no avanza</strong> cuando una palabra es muy corta, y la línea en blanco va <strong>entre</strong> casos, no después del último.</p>', '<p>Lee todo de una con <code>sys.stdin.read().split("\n")</code> y muévete con un índice. La posición vive dentro de la función que decodifica una línea, para que nazca en 0 cada vez.</p>', '<pre><code>''''''
Programa: Decodificando el mensaje
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Decodifica cada linea tomando la letra de la posicion que avanza
    solo cuando la palabra alcanza, y respeta el formato de casos
    que exige el juez.
''''''

import sys


def decodificar_linea(linea):
    ''''''
    Decodifica una linea del mensaje.

    Parametros:
        linea (str): las palabras separadas por espacios

    Retorna:
        str: la palabra oculta en esa linea
    ''''''
    palabras = linea.split()
    resultado = []

    # La posicion nace en 0 en CADA linea: cada una produce su propia
    # palabra, independiente de la anterior
    posicion = 0

    for palabra in palabras:
        if posicion < len(palabra):
            resultado.append(palabra[posicion])
            # El incremento va ADENTRO del if: si la palabra no alcanza,
            # se busca esa MISMA posicion en la siguiente
            posicion += 1

    return "".join(resultado)


# Inicio
data = sys.stdin.read().split("\n")
T = int(data[0].strip())

# data[0] es T y data[1] es la linea en blanco: el primer caso empieza en 2
idx = 2

for caso in range(1, T + 1):
    # El separador va ENTRE casos: se imprime antes de cada uno menos
    # del primero, y asi no sobra al final
    if caso > 1:
        print()

    print(f"Case #{caso}:")

    # El caso se acaba en la linea en blanco
    while idx < len(data) and data[idx].strip() != "":
        print(decodificar_linea(data[idx]))
        idx += 1

    idx += 1  # saltar esa linea en blanco
# Fin</code></pre><p>El corazón del problema cabe en dos líneas, y una de ellas es la que casi todos ponen mal:</p><ul><li><strong><code>posicion += 1</code> va adentro del <code>if</code>.</strong> Es la traducción literal de <em>"se ignora y se intenta obtener esa misma posición de la siguiente palabra"</em>. Afuera, la posición avanzaría al saltar y <code>as I previously previewed</code> daría <code>aee</code> en vez de <code>are</code>.</li><li><strong>La posición vive dentro de la función.</strong> Así vuelve a 0 en cada línea sin tener que acordarse de reiniciarla.</li></ul><p>Y del formato:</p><ul><li><strong><code>idx = 2</code></strong> porque después de <code>T</code> viene una línea en blanco antes del primer caso.</li><li><strong>El <code>idx += 1</code> final va fuera del <code>while</code></strong>: es el que consume la línea en blanco que cerró el caso. Adentro se comería líneas del mensaje.</li><li><strong><code>if caso > 1: print()</code></strong> deja el separador exactamente entre bloques. Imprimirlo al final de cada caso agrega una línea de más al terminar, y para el juez eso ya es otra salida.</li></ul>', '[{"stdin":"2\n\nHey good lawyer\nas I previously previewed\nyam does a soup\n\nFirst I give money to Teresa\nafter I inform dad of\nyour horrible soup\n","expected_output":"Case #1:\nHow\nare\nyou\n\nCase #2:\nFine\nand\nyou\n"},{"stdin":"1\n\nHey good lawyer\n","expected_output":"Case #1:\nHow\n"},{"stdin":"1\n\na I xyz\n","expected_output":"Case #1:\nay\n"},{"stdin":"2\n\nHola\n\nQue tal\n","expected_output":"Case #1:\nH\n\nCase #2:\nQa\n"}]', '''''''
Programa: Decodificando el mensaje
Autor:
Fecha:
Descripcion:
''''''

import sys


def decodificar_linea(linea):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'La posición que no avanza', 'facil', '<p>Solo la parte difícil, para practicarla aislada. Escribe la función que decodifica <strong>una</strong> línea.</p><p>La entrada trae una línea de palabras; imprime la palabra decodificada.</p><pre><code>Entrada:
as I previously previewed

Salida:
are</code></pre><p>Prueba también con <code>a I xyz</code>: la respuesta es <code>ay</code>, no <code>aI</code> ni <code>az</code>.</p>', '<p>Dos variables: la lista de letras y la posición. La posición <strong>solo</strong> sube dentro del <code>if</code>.</p>', '<pre><code>''''''
Programa: Decodificar una linea
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Practica aislada de la regla que decide el problema: la posicion
    avanza solo cuando la palabra alcanza.
''''''


def decodificar_linea(linea):
    ''''''
    Toma la letra de la posicion actual de cada palabra que alcance.

    Parametros:
        linea (str): palabras separadas por espacios

    Retorna:
        str: la palabra decodificada
    ''''''
    resultado = []
    posicion = 0

    for palabra in linea.split():
        if posicion < len(palabra):
            resultado.append(palabra[posicion])
            posicion += 1

    return "".join(resultado)


# Inicio
print(decodificar_linea(input()))
# Fin</code></pre><p>Sigue la traza de <code>a I xyz</code>, que es el caso que descubre el error:</p><table><thead><tr><th>Palabra</th><th>posicion</th><th>¿alcanza?</th><th>Toma</th><th>posicion queda</th></tr></thead><tbody><tr><td><code>a</code></td><td>0</td><td>✅</td><td><b>a</b></td><td>1</td></tr><tr><td><code>I</code></td><td>1</td><td>❌ mide 1</td><td>—</td><td><b>1</b></td></tr><tr><td><code>xyz</code></td><td>1</td><td>✅</td><td><b>y</b></td><td>2</td></tr></tbody></table><p>Sale <code>ay</code>. Con el incremento afuera del <code>if</code> saldría <code>az</code>, que se ve razonable y está mal.</p>', '[{"stdin":"as I previously previewed\n","expected_output":"are\n"},{"stdin":"Hey good lawyer\n","expected_output":"How\n"},{"stdin":"a I xyz\n","expected_output":"ay\n"},{"stdin":"yam does a soup\n","expected_output":"you\n"},{"stdin":"I I I\n","expected_output":"I\n"}]', '''''''
Programa: Decodificar una linea
Autor:
Fecha:
Descripcion:
''''''


def decodificar_linea(linea):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Si una palabra es más corta que la posición actual, ¿qué pasa?', NULL, '{"options":[{"id":"a","text":"Se detiene la decodificación de esa línea"},{"id":"b","text":"Se salta la palabra y la posición NO avanza"},{"id":"c","text":"Se salta la palabra y la posición avanza igual"},{"id":"d","text":"Se toma la última letra de esa palabra"}]}', '{"option_id":"b"}', 'El enunciado dice que se intenta ''esa misma posición'' en la siguiente palabra. Si la posición avanzara al saltar, en ''as I previously previewed'' saldría ''aee'' en vez de ''are''.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Por qué se reinicia posicion = 0 en cada línea?', NULL, '{"options":[{"id":"a","text":"Por optimización"},{"id":"b","text":"Porque cada línea produce una palabra independiente"},{"id":"c","text":"Porque lo exige el formato del juez"},{"id":"d","text":"Para no pasarse del largo de la primera palabra"}]}', '{"option_id":"b"}', 'El enunciado es explícito: al terminar la línea termina la palabra decodificada, y la siguiente empieza otra vez desde la primera letra de la primera palabra.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'En "Hey good lawyer", ¿cuál es la palabra decodificada?', NULL, '{"options":[{"id":"a","text":"Hgl"},{"id":"b","text":"How"},{"id":"c","text":"Hoy"},{"id":"d","text":"Hew"}]}', '{"option_id":"b"}', 'H de ''Hey'' en la posición 0, o de ''good'' en la posición 1, w de ''lawyer'' en la posición 2. La respuesta ''Hgl'' sale de tomar siempre la primera letra.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime esta decodificación?', 'def decodificar(linea):
    resultado = []
    posicion = 0
    for palabra in linea.split():
        if posicion < len(palabra):
            resultado.append(palabra[posicion])
            posicion += 1
    return "".join(resultado)

print(decodificar("as I previously previewed"))', '{"options":[{"id":"a","text":"are"},{"id":"b","text":"aIpp"},{"id":"c","text":"aee"},{"id":"d","text":"aIre"}]}', '{"option_id":"a"}', '''as'' da la a y la posición pasa a 1. ''I'' mide 1 y no tiene posición 1: se salta SIN avanzar. ''previously'' da la r (posición 1) y ''previewed'' da la e (posición 2). Queda ''are''.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'Esta versión decodifica mal. ¿En qué línea está el error?', NULL, '{"lines":["resultado = []","posicion = 0","for palabra in linea.split():","    if posicion < len(palabra):","        resultado.append(palabra[posicion])","    posicion += 1"]}', '{"line_number":6}', 'El incremento quedó FUERA del if, así que la posición avanza aunque la palabra se haya saltado. Tiene que ir adentro: solo avanza cuando de verdad se tomó una letra.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la decodificación de una línea.', NULL, '{"code":"posicion = 0\nfor palabra in linea.split():\n    if ___1___:\n        resultado.append(palabra[posicion])\n        ___2___","blanks":[{"id":"1","pista":"¿la palabra alcanza para esa posición?"},{"id":"2","pista":"avanzar, y solo aquí adentro"}]}', '{"answers":{"1":["posicion < len(palabra)","len(palabra) > posicion"],"2":["posicion += 1","posicion = posicion + 1"]}}', 'La comparación evita el IndexError y el incremento adentro del if es lo que implementa ''se ignora y se intenta esa misma posición en la siguiente palabra''.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'La salida pide una línea en blanco ENTRE casos. ¿Cómo se logra sin que sobre al final?', NULL, '{"options":[{"id":"a","text":"Imprimirla antes de cada caso, saltándose el primero"},{"id":"b","text":"Imprimirla después de cada caso"},{"id":"c","text":"Imprimirla después de cada caso y borrar la última con rstrip()"},{"id":"d","text":"El juez ignora las líneas en blanco sobrantes"}]}', '{"option_id":"a"}', 'Con ''if caso > 1: print()'' el separador aparece exactamente entre bloques. Imprimirlo después deja una línea de más al final, y eso ya es otra salida para el juez.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma el recorrido de un caso completo', NULL, '{"lines":[{"id":"c1","text":"if caso > 1:","indent":0},{"id":"c2","text":"print()","indent":1},{"id":"c3","text":"print(f\"Case #{caso}:\")","indent":0},{"id":"c4","text":"while idx < len(data) and data[idx].strip() != \"\":","indent":0},{"id":"c5","text":"print(decodificar_linea(data[idx]))","indent":1},{"id":"c6","text":"idx += 1","indent":1},{"id":"c7","text":"idx += 1","indent":0}]}', '{"order":["c1","c2","c3","c4","c5","c6","c7"]}', 'El último idx += 1 va FUERA del while, con indentación 0: es el que salta la línea en blanco que cerró el caso. Adentro del while se saltarían líneas del mensaje.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'avanzado';

-- ── Capítulo 3: Matrices y vecinos (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 3, 'Matrices y vecinos', '🗺️', 'Listas de listas y el recorrido de las 8 direcciones.', '<p class="jc-gancho">Ocho vecinos. Suena fácil hasta que estás en la esquina de arriba a la izquierda y tres de esos vecinos no existen. Preguntar por ellos con <code>grid[-1][-1]</code> no da error en Python: <strong>da la esquina opuesta</strong>, y tu campo minado sale mal sin que nada se queje.</p>

<h2>📖 Enunciado</h2>

<div class="jc-problema">

<h3>Buscaminas</h3>

<p><strong>Descripción.</strong> Un campo de Buscaminas se representa mediante una cuadrícula. Cada celda contiene una mina, marcada con <code>*</code>, o está vacía, marcada con <code>.</code>. Para cada celda vacía se debe calcular cuántas minas existen entre sus <strong>ocho vecinas</strong>: horizontales, verticales y diagonales.</p>

<p><strong>Entrada.</strong> Varios campos. Cada campo comienza con dos enteros <code>n</code> y <code>m</code> (filas y columnas), 1 ≤ n, m ≤ 100. Siguen <code>n</code> líneas de <code>m</code> caracteres con <code>*</code> y <code>.</code>. Termina con <code>0 0</code> (esa línea <strong>no</strong> es un campo).</p>

<p><strong>Salida.</strong> Para cada campo imprima <code>Field #k:</code> (k empieza en 1). Luego la cuadrícula transformada: conserve cada <code>*</code> y reemplace cada <code>.</code> por el número de minas vecinas. Imprima una línea en blanco entre campos consecutivos.</p>

<table>
  <thead>
    <tr><th>Ejemplo de entrada</th><th>Ejemplo de salida</th></tr>
  </thead>
  <tbody>
    <tr>
      <td><pre><code>4 4
*...
....
.*..
....
3 5
**...
.....
.*...
0 0</code></pre></td>
      <td><pre><code>Field #1:
*100
2210
1*10
1110

Field #2:
**100
33200
1*100</code></pre></td>
    </tr>
  </tbody>
</table>

</div>

<h2>💡 Análisis y estrategia</h2>

<h3>La matriz es una lista de textos</h3>

<p>No hace falta convertirla a lista de listas: en Python, un texto ya se indexa por posición. <code>grid[i][j]</code> es el carácter de la fila <code>i</code>, columna <code>j</code>.</p>

<pre><code>grid = ["*...", "....", ".*..", "...."]
grid[0][0]   # ''*''
grid[2][1]   # ''*''</code></pre>

<h3>Los ocho vecinos, sin escribir ocho <code>if</code></h3>

<p>La forma torpe es listar las ocho posiciones a mano. La forma que se usa en competencia es recorrer los desplazamientos:</p>

<pre><code>for dx in (-1, 0, 1):
    for dy in (-1, 0, 1):
        if dx == 0 and dy == 0:
            continue          # ese es uno mismo, no un vecino
        ni, nj = i + dx, j + dy</code></pre>

<p>Las dos listas de tres valores dan <strong>nueve</strong> combinaciones: los ocho vecinos más <code>(0, 0)</code>, que es la celda misma. Por eso el <code>continue</code>.</p>

<table>
  <thead>
    <tr><th>dx, dy</th><th>−1</th><th>0</th><th>+1</th></tr>
  </thead>
  <tbody>
    <tr><th>−1</th><td>↖</td><td>↑</td><td>↗</td></tr>
    <tr><th>0</th><td>←</td><td><b>tú</b></td><td>→</td></tr>
    <tr><th>+1</th><td>↙</td><td>↓</td><td>↘</td></tr>
  </tbody>
</table>

<h3>El borde: la trampa silenciosa</h3>

<p>En la celda <code>(0, 0)</code>, el vecino de arriba a la izquierda sería <code>(-1, -1)</code>. En otros lenguajes eso revienta. En Python <strong>funciona</strong>: <code>grid[-1][-1]</code> es la última fila, última columna — la esquina opuesta del campo.</p>

<p>Tu programa no falla, no avisa, y cuenta minas que están al otro lado del tablero. Por eso la validación no es opcional:</p>

<pre><code>if 0 &lt;= ni &lt; n and 0 &lt;= nj &lt; m:
    ...</code></pre>

<p>Ese <code>0 &lt;= ni</code> es exactamente el que ataja los índices negativos.</p>

<h2>💻 Código paso a paso</h2>

<pre><code>import sys

def resolver_campo(grid, n, m):
    salida = []
    for i in range(n):
        fila = []
        for j in range(m):
            if grid[i][j] == ''*'':
                fila.append(''*'')
            else:
                minas = 0
                for dx in (-1, 0, 1):
                    for dy in (-1, 0, 1):
                        if dx == 0 and dy == 0:
                            continue
                        ni, nj = i + dx, j + dy
                        if 0 &lt;= ni &lt; n and 0 &lt;= nj &lt; m:
                            if grid[ni][nj] == ''*'':
                                minas += 1
                fila.append(str(minas))
        salida.append("".join(fila))
    return salida

data = sys.stdin.read().split("\n")
idx = 0
campo_num = 1
primero = True

while idx &lt; len(data):
    linea = data[idx].strip()
    if not linea:
        idx += 1
        continue
    partes = linea.split()
    n, m = int(partes[0]), int(partes[1])
    if n == 0 and m == 0:
        break
    idx += 1
    grid = []
    for _ in range(n):
        grid.append(data[idx])
        idx += 1

    if not primero:
        print()
    primero = False
    print(f"Field #{campo_num}:")
    for fila in resolver_campo(grid, n, m):
        print(fila)
    campo_num += 1</code></pre>

<table>
  <thead>
    <tr><th>Pieza</th><th>Por qué está ahí</th></tr>
  </thead>
  <tbody>
    <tr><td><code>if grid[i][j] == ''*'': fila.append(''*'')</code></td><td>Las minas se copian tal cual. Solo se cuentan vecinos de las celdas vacías</td></tr>
    <tr><td><code>for dx … for dy …</code></td><td>Los ocho vecinos en cuatro líneas, sin listar posiciones a mano</td></tr>
    <tr><td><code>if dx == 0 and dy == 0: continue</code></td><td>Salta la celda misma: no es vecina de sí misma</td></tr>
    <tr><td><code>0 &lt;= ni &lt; n and 0 &lt;= nj &lt; m</code></td><td>El borde. Sin esto, los índices negativos leen la esquina opuesta y el conteo sale mal en silencio</td></tr>
    <tr><td><code>str(minas)</code></td><td>La fila se arma con <code>join</code>, que solo pega textos</td></tr>
    <tr><td><code>if n == 0 and m == 0: break</code></td><td>La línea <code>0 0</code> cierra la entrada y <strong>no</strong> es un campo: no se imprime <code>Field #</code> para ella</td></tr>
    <tr><td><code>primero</code></td><td>El separador va entre campos: se imprime antes de cada uno menos del primero</td></tr>
  </tbody>
</table>

<h3>La película de una celda</h3>

<p>Campo del ejemplo, celda <code>(1, 0)</code> — fila 1, columna 0, que en la salida vale <code>2</code>:</p>

<table>
  <thead>
    <tr><th>dx, dy</th><th>Vecino</th><th>¿Existe?</th><th>Contenido</th><th>minas</th></tr>
  </thead>
  <tbody>
    <tr><td>−1, −1</td><td>(0, −1)</td><td>❌ nj &lt; 0</td><td>—</td><td>0</td></tr>
    <tr><td>−1, 0</td><td>(0, 0)</td><td>✅</td><td><b>*</b></td><td>1</td></tr>
    <tr><td>−1, +1</td><td>(0, 1)</td><td>✅</td><td>.</td><td>1</td></tr>
    <tr><td>0, −1</td><td>(1, −1)</td><td>❌ nj &lt; 0</td><td>—</td><td>1</td></tr>
    <tr><td>0, +1</td><td>(1, 1)</td><td>✅</td><td>.</td><td>1</td></tr>
    <tr><td>+1, −1</td><td>(2, −1)</td><td>❌ nj &lt; 0</td><td>—</td><td>1</td></tr>
    <tr><td>+1, 0</td><td>(2, 0)</td><td>✅</td><td>.</td><td>1</td></tr>
    <tr><td>+1, +1</td><td>(2, 1)</td><td>✅</td><td><b>*</b></td><td><b>2</b></td></tr>
  </tbody>
</table>

<p>Sin la validación, los tres vecinos con <code>nj = −1</code> habrían leído la <strong>última columna</strong> de esas filas. En este campo daría lo mismo por casualidad; en otro, no.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Confiar en que Python avisa del borde</h3>
<pre><code>if grid[i-1][j-1] == ''*'':   # ❌ con i=0, j=0 lee la esquina opuesta</code></pre>

<h3>2. Contarse a sí misma</h3>
<pre><code>for dx in (-1, 0, 1):
    for dy in (-1, 0, 1):
        # ❌ sin el continue, una celda con mina al lado suma de más
        #    y las vacías se cuentan a sí mismas cuando son ''*''</code></pre>

<h3>3. Imprimir un campo para la línea <code>0 0</code></h3>
<pre><code>n, m = 0, 0
print(f"Field #{campo_num}:")   # ❌ ese campo no existe</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>La matriz se recorre con dos ciclos: <code>i</code> filas, <code>j</code> columnas.</li>
  <li>Los vecinos, con <code>dx</code> y <code>dy</code> en <code>(-1, 0, 1)</code>, saltando <code>(0, 0)</code>.</li>
  <li><strong>Siempre</strong> validar <code>0 &lt;= ni &lt; n and 0 &lt;= nj &lt; m</code>.</li>
  <li>Lo que el enunciado manda conservar, se copia sin tocar.</li>
  <li>La marca de fin no es un caso: se detecta y se sale.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>grid[i][j]</code></td><td>Carácter de la fila i, columna j</td></tr>
    <tr><td><code>for dx in (-1, 0, 1)</code></td><td>Los desplazamientos de las 8 direcciones</td></tr>
    <tr><td><code>if dx == 0 and dy == 0: continue</code></td><td>Saltarse a uno mismo</td></tr>
    <tr><td><code>0 &lt;= ni &lt; n</code></td><td>El guardia del borde</td></tr>
    <tr><td><code>"".join(fila)</code></td><td>Pega la fila de caracteres en una línea</td></tr>
    <tr><td><code>str(numero)</code></td><td>Número a texto, para poder pegarlo</td></tr>
  </tbody>
</table>

<blockquote>En Python el índice −1 no es un error: es la última posición. Por eso el borde se valida a mano — nadie te va a avisar.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 2 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 3 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Buscaminas', 'medio', '<p>El ejercicio completo: varios campos, cada uno con sus dimensiones, hasta la línea <code>0 0</code>.</p><pre><code>Entrada:
4 4
*...
....
.*..
....
3 5
**...
.....
.*...
0 0

Salida:
Field #1:
*100
2210
1*10
1110

Field #2:
**100
33200
1*100</code></pre><p>Las minas se copian tal cual. Cada <code>.</code> se reemplaza por cuántas minas tiene entre sus <strong>ocho</strong> vecinas.</p>', '<p>Recorre <code>dx</code> y <code>dy</code> en <code>(-1, 0, 1)</code>, sáltate <code>(0, 0)</code> y valida <code>0 &lt;= ni &lt; n and 0 &lt;= nj &lt; m</code> antes de mirar la celda.</p>', '<pre><code>''''''
Programa: Buscaminas
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta las minas vecinas de cada celda vacia y reconstruye el campo
    en el formato que pide el juez.
''''''

import sys


def resolver_campo(grid, n, m):
    ''''''
    Reemplaza cada celda vacia por su numero de minas vecinas.

    Parametros:
        grid (list): las n lineas del campo
        n (int): filas
        m (int): columnas

    Retorna:
        list: las n lineas transformadas
    ''''''
    salida = []

    for i in range(n):
        fila = []
        for j in range(m):
            # Las minas se conservan tal cual: solo se cuentan vecinos
            # de las celdas vacias
            if grid[i][j] == ''*'':
                fila.append(''*'')
                continue

            minas = 0

            # Las nueve combinaciones de dx y dy son los 8 vecinos
            # mas la celda misma
            for dx in (-1, 0, 1):
                for dy in (-1, 0, 1):
                    if dx == 0 and dy == 0:
                        continue

                    ni = i + dx
                    nj = j + dy

                    # El guardia del borde. Sin el, por la izquierda
                    # Python lee desde el final (indice negativo) y por
                    # la derecha lanza IndexError
                    if 0 <= ni < n and 0 <= nj < m:
                        if grid[ni][nj] == ''*'':
                            minas += 1

            fila.append(str(minas))

        salida.append("".join(fila))

    return salida


# Inicio
data = sys.stdin.read().split("\n")
idx = 0
campo_num = 1
primero = True

while idx < len(data):
    linea = data[idx].strip()

    if not linea:
        idx += 1
        continue

    partes = linea.split()
    n = int(partes[0])
    m = int(partes[1])

    # "0 0" cierra la entrada y NO es un campo: no lleva Field #
    if n == 0 and m == 0:
        break

    idx += 1
    grid = []
    for _ in range(n):
        grid.append(data[idx])
        idx += 1

    # El separador va ENTRE campos
    if not primero:
        print()
    primero = False

    print(f"Field #{campo_num}:")
    for fila in resolver_campo(grid, n, m):
        print(fila)

    campo_num += 1
# Fin</code></pre><p>Lo que decide este problema no es contar: es <strong>el borde</strong>.</p><ul><li><strong>Los índices negativos no fallan en Python.</strong> Desde la celda (0,0), el vecino de arriba a la izquierda es <code>grid[-1][-1]</code>, que devuelve la esquina opuesta del campo. El programa corre, no avisa nada y cuenta minas que están al otro lado.</li><li><strong>Los positivos sí fallan.</strong> En la esquina derecha, la columna <code>m</code> no existe y salta <code>IndexError</code>. Por eso hay que validar los dos extremos, no solo uno.</li><li><strong>El <code>continue</code> de <code>(0,0)</code></strong> evita que una celda se mire a sí misma.</li></ul><p>Y del formato: la línea <code>0 0</code> <strong>no</strong> es un campo — imprimirle un <code>Field #</code> ya es otra salida — y el separador va entre campos, no después de cada uno.</p>', '[{"stdin":"4 4\n*...\n....\n.*..\n....\n3 5\n**...\n.....\n.*...\n0 0\n","expected_output":"Field #1:\n*100\n2210\n1*10\n1110\n\nField #2:\n**100\n33200\n1*100\n"},{"stdin":"1 1\n*\n0 0\n","expected_output":"Field #1:\n*\n"},{"stdin":"1 1\n.\n0 0\n","expected_output":"Field #1:\n0\n"},{"stdin":"2 2\n**\n**\n0 0\n","expected_output":"Field #1:\n**\n**\n"},{"stdin":"3 3\n...\n.*.\n...\n0 0\n","expected_output":"Field #1:\n111\n1*1\n111\n"}]', '''''''
Programa: Buscaminas
Autor:
Fecha:
Descripcion:
''''''

import sys


def resolver_campo(grid, n, m):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'El vecindario de una celda', 'facil', '<p>Solo la parte que se equivoca todo el mundo: contar los vecinos de <strong>una</strong> celda, incluida la de una esquina.</p><p>La entrada trae <code>n</code> y <code>m</code>, luego el campo, y en la última línea la fila y la columna de la celda a consultar. Imprime cuántas minas tiene alrededor.</p><pre><code>Entrada:
3 3
*.*
...
*.*
1 1

Salida:
4</code></pre>', '<p>Si la celda consultada es una mina, el enunciado igual pide contar sus vecinas. El guardia del borde va <strong>antes</strong> de leer <code>grid[ni][nj]</code>.</p>', '<pre><code>''''''
Programa: Vecinos de una celda
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Practica aislada del recorrido de las 8 direcciones con validacion
    de bordes.
''''''

import sys


def contar_vecinas(grid, n, m, i, j):
    ''''''
    Cuenta las minas alrededor de la celda (i, j).

    Parametros:
        grid (list): lineas del campo
        n (int): filas
        m (int): columnas
        i (int): fila de la celda
        j (int): columna de la celda

    Retorna:
        int: cuantas de las 8 vecinas son minas
    ''''''
    minas = 0

    for dx in (-1, 0, 1):
        for dy in (-1, 0, 1):
            if dx == 0 and dy == 0:
                continue

            ni = i + dx
            nj = j + dy

            if 0 <= ni < n and 0 <= nj < m:
                if grid[ni][nj] == ''*'':
                    minas += 1

    return minas


# Inicio
data = sys.stdin.read().split("\n")

primera = data[0].split()
n = int(primera[0])
m = int(primera[1])

grid = []
for k in range(1, n + 1):
    grid.append(data[k])

consulta = data[n + 1].split()
i = int(consulta[0])
j = int(consulta[1])

print(contar_vecinas(grid, n, m, i, j))
# Fin</code></pre><p>Pruébalo con la celda <code>0 0</code> de ese mismo campo: ella misma es una mina, y sus tres vecinas que existen — derecha, abajo y diagonal — están vacías, así que la respuesta es <strong>0</strong>. Si tu programa devuelve 2, te falta el guardia del borde: está leyendo las minas de la esquina opuesta por índice negativo.</p><p>El orden dentro del ciclo es el que importa: primero se descarta <code>(0,0)</code>, después se calcula el vecino, y <strong>solo entonces</strong> se pregunta si existe. Preguntar después de leer <code>grid[ni][nj]</code> ya sería tarde.</p>', '[{"stdin":"3 3\n*.*\n...\n*.*\n1 1\n","expected_output":"4\n"},{"stdin":"3 3\n*.*\n...\n*.*\n0 0\n","expected_output":"0\n"},{"stdin":"4 4\n*...\n....\n.*..\n....\n1 0\n","expected_output":"2\n"},{"stdin":"2 2\n**\n**\n0 0\n","expected_output":"3\n"},{"stdin":"1 1\n.\n0 0\n","expected_output":"0\n"}]', '''''''
Programa: Vecinos de una celda
Autor:
Fecha:
Descripcion:
''''''

import sys


def contar_vecinas(grid, n, m, i, j):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuántos vecinos tiene una celda interna de la cuadrícula?', NULL, '{"options":[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"9"},{"id":"d","text":"Depende del tamaño del campo"}]}', '{"option_id":"b"}', 'Horizontales, verticales y diagonales: 8. Las nueve combinaciones de dx y dy incluyen (0,0), que es la celda misma y no cuenta.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué hay que validar `0 <= ni < n`?', NULL, '{"options":[{"id":"a","text":"Por rendimiento"},{"id":"b","text":"Para no salirse de la matriz: en Python un índice negativo lee desde el final y cuenta minas del otro lado del campo"},{"id":"c","text":"Por el formato de salida que pide el juez"},{"id":"d","text":"Para que no se repitan vecinos"}]}', '{"option_id":"b"}', 'grid[-1][-1] no lanza error: devuelve la esquina opuesta. El programa corre, no avisa nada y el conteo sale mal. Ese es el peor tipo de bug.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Con dx y dy en (-1, 0, 1) se generan 9 combinaciones. ¿Por qué se salta (0, 0)?', NULL, '{"options":[{"id":"a","text":"Porque siempre es una mina"},{"id":"b","text":"Porque es la celda misma, no un vecino"},{"id":"c","text":"Para ahorrar memoria"},{"id":"d","text":"Porque ya se contó en la iteración anterior"}]}', '{"option_id":"b"}', 'Sumar 0 a la fila y 0 a la columna deja la misma posición. Sin el continue, una celda se contaría a sí misma.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'El campo es 4×4 y se cuentan los vecinos de la esquina superior DERECHA (0, 3), sin validar el borde. ¿Qué pasa?', 'campo = ["*...", "....", ".*..", "...."]

minas = 0
i, j = 0, 3
for dx in (-1, 0, 1):
    for dy in (-1, 0, 1):
        if dx == 0 and dy == 0:
            continue
        if campo[i + dx][j + dy] == ''*'':
            minas += 1
print(minas)', '{"options":[{"id":"a","text":"Lanza IndexError"},{"id":"b","text":"Imprime 0"},{"id":"c","text":"Imprime 1"},{"id":"d","text":"Imprime 2"}]}', '{"option_id":"a"}', 'Aquí está la asimetría que hay que conocer: el vecino de la derecha es la columna 4, que NO existe, y un índice positivo fuera de rango sí lanza IndexError. En cambio, en la esquina izquierda los índices negativos no fallan: leen desde el final en silencio. Por eso hay que validar los dos lados.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este conteo funciona en el centro del campo pero se rompe o miente en los bordes. ¿En qué línea falta algo?', NULL, '{"lines":["for dx in (-1, 0, 1):","    for dy in (-1, 0, 1):","        if dx == 0 and dy == 0:","            continue","        ni, nj = i + dx, j + dy","        if grid[ni][nj] == ''*'':","            minas += 1"]}', '{"line_number":6}', 'Antes de leer grid[ni][nj] falta preguntar si esa celda existe: 0 <= ni < n and 0 <= nj < m. Sin ese guardia, por la izquierda cuenta minas del otro extremo del campo y por la derecha lanza IndexError.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el recorrido de los ocho vecinos.', NULL, '{"code":"for dx in (-1, 0, 1):\n    for dy in (-1, 0, 1):\n        if ___1___:\n            continue\n        ni, nj = i + dx, j + dy\n        if ___2___ and 0 <= nj < m:\n            if grid[ni][nj] == ''*'':\n                minas += 1","blanks":[{"id":"1","pista":"cuando el desplazamiento es nulo, esa es la celda misma"},{"id":"2","pista":"la fila del vecino tiene que existir"}]}', '{"answers":{"1":["dx == 0 and dy == 0"],"2":["0 <= ni < n"]}}', 'El primer hueco evita contarse a uno mismo; el segundo ataja los índices negativos, que en Python no fallan sino que leen desde el final de la lista.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'La entrada termina con la línea "0 0". ¿Qué hay que hacer con ella?', NULL, '{"options":[{"id":"a","text":"Procesarla como un campo vacío e imprimir su Field #"},{"id":"b","text":"Detectarla y salir sin imprimir nada para ella"},{"id":"c","text":"Imprimir una línea en blanco y seguir leyendo"},{"id":"d","text":"Ignorarla: el archivo se acaba ahí de todos modos"}]}', '{"option_id":"b"}', 'El enunciado lo dice: esa línea NO es un campo. Imprimir un ''Field #'' de más es una salida distinta a la esperada, aunque todo lo anterior esté bien.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma el conteo de minas vecinas de una celda', NULL, '{"lines":[{"id":"v1","text":"minas = 0","indent":0},{"id":"v2","text":"for dx in (-1, 0, 1):","indent":0},{"id":"v3","text":"for dy in (-1, 0, 1):","indent":1},{"id":"v4","text":"if dx == 0 and dy == 0:","indent":2},{"id":"v5","text":"continue","indent":3},{"id":"v6","text":"ni, nj = i + dx, j + dy","indent":2},{"id":"v7","text":"if 0 <= ni < n and 0 <= nj < m and grid[ni][nj] == ''*'':","indent":2},{"id":"v8","text":"minas += 1","indent":3}]}', '{"order":["v1","v2","v3","v4","v5","v6","v7","v8"]}', 'El orden importa: primero se descarta la celda misma, después se calcula el vecino, y solo entonces se pregunta si existe y si tiene mina. Validar después de leer grid[ni][nj] ya sería tarde.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'avanzado';

-- ── Capítulo 4: Recursión (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 4, 'Recursión', '🌀', 'Caso base, caso recursivo y qué pasa en el stack de llamadas.', '<p class="jc-gancho">Una función que se llama a sí misma suena a truco de magia hasta que ves el stack. No hay magia: hay una pila de llamadas esperando su turno para devolver. Este módulo es sobre escribir la receta antes del código, porque el 90% de los errores de recursión son un caso base mal puesto.</p>

<h2>💡 La idea recursiva</h2>

<p>Resolver un problema construyendo la respuesta desde una <strong>versión más pequeña de sí mismo</strong>. La función delega un subproblema estrictamente menor y combina lo que reciba.</p>

<h3>La receta, antes de escribir código</h3>

<ol>
  <li><strong>Identificar el caso base</strong> — dónde para.</li>
  <li><strong>Definir una reducción</strong> que acerque al caso base.</li>
  <li><strong>Delegar</strong> exactamente ese subproblema reducido.</li>
  <li><strong>Combinar</strong> la respuesta recibida.</li>
  <li><strong>Comprobar que toda entrada válida progresa</strong> hacia el caso base.</li>
  <li><strong>Trazar un ejemplo pequeño</strong> antes de programar.</li>
</ol>

<p>El paso 5 es el que se salta todo el mundo, y es el que produce el <code>RecursionError</code>.</p>

<h2>🔍 Ejemplo introductorio: suma recursiva</h2>

<p>Definición matemática:</p>

<pre><code>S(n) = 0                si n = 0
S(n) = n + S(n − 1)     si n &gt; 0</code></pre>

<pre><code>def sumar(n):
    if n == 0:          # caso base
        return 0
    return n + sumar(n - 1)</code></pre>

<h3>El stack, de bajada y de subida</h3>

<pre><code>S(4) = 4 + S(3)
     = 4 + 3 + S(2)
     = 4 + 3 + 2 + S(1)
     = 4 + 3 + 2 + 1 + S(0)

Retorno: S(0)=0 → S(1)=1 → S(2)=3 → S(3)=6 → S(4)=10</code></pre>

<p>Fíjate en las dos mitades. <strong>Bajando</strong>, cada llamada queda congelada esperando; <strong>subiendo</strong>, cada una completa su suma con lo que recibió. Todas esas llamadas congeladas viven en la <strong>pila</strong>, y ocupan memoria de verdad.</p>

<h3>Pila contra cola</h3>

<table>
  <thead><tr><th></th><th>Recursión de pila</th><th>Recursión de cola</th></tr></thead>
  <tbody>
    <tr><td>Cómo se ve</td><td><code>return n + sumar(n − 1)</code></td><td><code>return suma_cola(n − 1, total + n)</code></td></tr>
    <tr><td>Al volver</td><td>queda una operación pendiente (el <code>+ n</code>)</td><td>no queda nada pendiente</td></tr>
  </tbody>
</table>

<pre><code>def suma_cola(n, total=0):
    if n == 0:
        return total
    return suma_cola(n - 1, total + n)</code></pre>

<p>En otros lenguajes la versión de cola se optimiza y no crece la pila. <strong>En Python no</strong>: las dos consumen la misma profundidad, y las dos revientan alrededor de las mil llamadas. Saber la diferencia sirve para el parcial; en competencia, lo que salva es no recursar tan hondo.</p>

<h2>📖 El problema</h2>

<div class="jc-problema">

<h3>Superdígito</h3>
<p><em>Basado en Super Digit</em></p>

<p><strong>Descripción.</strong> El superdígito de un entero se define recursivamente:</p>
<ul>
  <li>Si el número tiene un solo dígito, ese dígito <strong>es</strong> su superdígito.</li>
  <li>En otro caso, se suman sus dígitos y se calcula el superdígito del resultado.</li>
</ul>

<p>Se recibe un número decimal <code>n</code> y un entero <code>k</code>. El número completo <code>p</code> se forma concatenando <code>n</code> consigo mismo exactamente <code>k</code> veces. Debe calcularse el superdígito de <code>p</code> <strong>sin construir necesariamente toda la cadena</strong>.</p>

<p><strong>Entrada.</strong> Una sola línea con la cadena decimal <code>n</code> y el entero <code>k</code>, separados por espacio. 1 ≤ |n| ≤ 10⁵, 1 ≤ k ≤ 10⁵.</p>

<p><strong>Salida.</strong> Un único dígito: el superdígito del número formado al repetir <code>n</code> exactamente <code>k</code> veces.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>148 3</code></td><td><code>3</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> La concatenación es 148148148. Suma = 39; luego 3+9 = 12; finalmente 1+2 = 3.</p>

</div>

<h2>💡 Análisis y estrategia</h2>

<h3>La trampa del enunciado</h3>

<p>Con |n| = 10⁵ y k = 10⁵, la cadena concatenada tendría <strong>diez mil millones de caracteres</strong>. No cabe en memoria, y armarla es responder otro problema.</p>

<p>La salida está en una observación simple: <strong>sumar los dígitos de "n repetido k veces" es lo mismo que sumar los de n y multiplicar por k</strong>. Repetir el número repite exactamente sus dígitos.</p>

<pre><code>suma_base = suma de los dígitos de n
inicial   = suma_base × k</code></pre>

<p>Con <code>148</code> y k=3: 1+4+8 = 13, y 13 × 3 = <strong>39</strong>. Que es justo la suma de los dígitos de 148148148, sin haberla construido.</p>

<h3>Ahora sí, la recursión</h3>

<p>Aplicada al número ya reducido, la receta es directa:</p>

<table>
  <thead><tr><th>Paso de la receta</th><th>En este problema</th></tr></thead>
  <tbody>
    <tr><td>Caso base</td><td>El número tiene un solo dígito: <code>x &lt; 10</code></td></tr>
    <tr><td>Reducción</td><td>Reemplazar el número por la suma de sus dígitos</td></tr>
    <tr><td>Delegar</td><td><code>superdigito(suma)</code></td></tr>
    <tr><td>Combinar</td><td>Nada que combinar: se devuelve tal cual lo que llegue</td></tr>
    <tr><td>¿Progresa?</td><td>Sí: la suma de dígitos de un número de 2+ cifras siempre es menor que el número</td></tr>
  </tbody>
</table>

<h2>💻 Código paso a paso</h2>

<pre><code>def superdigito(x):
    if x &lt; 10:                    # CASO BASE
        return x

    suma = 0
    for c in str(x):              # REDUCCIÓN
        suma += int(c)

    return superdigito(suma)      # DELEGAR


linea = input().split()
n = linea[0]
k = int(linea[1])

suma_base = 0
for c in n:
    suma_base += int(c)

inicial = suma_base * k

print(superdigito(inicial))</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué está ahí</th></tr></thead>
  <tbody>
    <tr><td><code>if x &lt; 10: return x</code></td><td>El caso base. Va <strong>primero</strong>: es la condición de parada</td></tr>
    <tr><td><code>str(x)</code></td><td>Recorrer los dígitos de un número es más cómodo tratándolo como texto</td></tr>
    <tr><td><code>suma_base * k</code></td><td>El truco: evita construir una cadena de 10¹⁰ caracteres</td></tr>
    <tr><td><code>n</code> se lee como texto</td><td>Con <code>int(n)</code> se perderían los ceros a la izquierda y el número podría no caber cómodo</td></tr>
  </tbody>
</table>

<h3>La película con <code>148 3</code></h3>

<table>
  <thead><tr><th>Llamada</th><th>x</th><th>¿Caso base?</th><th>Suma de dígitos</th><th>Devuelve</th></tr></thead>
  <tbody>
    <tr><td>preparación</td><td>—</td><td>—</td><td>(1+4+8) × 3 = <b>39</b></td><td>—</td></tr>
    <tr><td>superdigito(39)</td><td>39</td><td>no</td><td>3+9 = 12</td><td>lo que devuelva superdigito(12)</td></tr>
    <tr><td>superdigito(12)</td><td>12</td><td>no</td><td>1+2 = 3</td><td>lo que devuelva superdigito(3)</td></tr>
    <tr><td>superdigito(3)</td><td>3</td><td><b>sí</b></td><td>—</td><td><b>3</b></td></tr>
  </tbody>
</table>

<p>Y de subida, cada llamada devuelve el 3 tal cual, porque en este problema no hay nada que combinar. Compáralo con <code>sumar(n)</code>, donde cada nivel tenía un <code>+ n</code> pendiente.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. El caso base después de la llamada recursiva</h3>
<pre><code>def superdigito(x):
    suma = sum(int(c) for c in str(x))
    return superdigito(suma)      # ❌ nunca para: RecursionError
    if x &lt; 10:
        return x</code></pre>

<h3>2. Construir la cadena completa</h3>
<pre><code>p = n * k                         # ❌ con k = 10⁵ son 10¹⁰ caracteres</code></pre>

<h3>3. Un caso base que no se alcanza</h3>
<pre><code>if x == 0:                        # ❌ la suma de dígitos nunca llega a 0
    return x</code></pre>
<p>El caso base tiene que ser alcanzable <strong>desde cualquier entrada válida</strong>. Ese es el paso 5 de la receta.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Escribe el caso base <strong>primero</strong>, siempre.</li>
  <li>Comprueba que la reducción de verdad acerca al caso base: si no encoge, no para.</li>
  <li>Traza un ejemplo pequeño a mano antes de correr nada.</li>
  <li>Si el enunciado da límites enormes, busca la propiedad matemática: casi siempre hay una que evita construir el monstruo.</li>
  <li>En Python la pila aguanta unas mil llamadas. Más hondo que eso, toca iterativo.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>if caso_base: return valor</code></td><td>La condición de parada, siempre de primera</td></tr>
    <tr><td><code>return f(entrada_reducida)</code></td><td>Delegar sin nada pendiente (cola)</td></tr>
    <tr><td><code>return n + f(n - 1)</code></td><td>Delegar con algo pendiente (pila)</td></tr>
    <tr><td><code>str(x)</code> · <code>int(c)</code></td><td>Recorrer los dígitos de un número</td></tr>
    <tr><td><code>sys.setrecursionlimit(…)</code></td><td>Sube el tope, pero no arregla un caso base malo</td></tr>
  </tbody>
</table>

<blockquote>Si la recursión no para, el problema casi nunca es la recursión: es que el caso base está mal puesto, o la reducción no encoge.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 3 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 4 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Superdígito', 'medio', '<p>La entrada trae la cadena <code>n</code> y el entero <code>k</code>, separados por espacio. Imprime el superdígito del número que resulta de repetir <code>n</code> exactamente <code>k</code> veces.</p><pre><code>Entrada:
148 3

Salida:
3</code></pre><p>148148148 → 39 → 12 → <strong>3</strong>.</p><p><em>Con |n| hasta 10⁵ y k hasta 10⁵, construir la cadena es imposible.</em> Hay que evitarlo.</p>', '<p>Repetir el número repite sus dígitos: la suma total es <code>suma(n) × k</code>. Sobre ese número ya reducido, aplica la recursión.</p>', '<pre><code>''''''
Programa: Superdigito
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Calcula el superdigito de n repetido k veces, sin construir la
    cadena concatenada.
''''''


def superdigito(x):
    ''''''
    Reduce un numero a un solo digito sumando sus cifras.

    Parametros:
        x (int): numero a reducir

    Retorna:
        int: su superdigito, entre 0 y 9
    ''''''
    # CASO BASE, siempre de primero: un solo digito ya es la respuesta
    if x < 10:
        return x

    # REDUCCION: la suma de digitos de un numero de 2+ cifras siempre
    # es menor que el numero, asi que esto SI progresa hacia el caso base
    suma = 0
    for c in str(x):
        suma += int(c)

    # DELEGAR. No hay nada que combinar al volver: se devuelve tal cual
    return superdigito(suma)


# Inicio
linea = input().split()
n = linea[0]          # se deja como TEXTO: solo interesan sus digitos
k = int(linea[1])

# El truco del problema: concatenar n consigo mismo k veces repite
# exactamente sus digitos, asi que la suma total es suma(n) * k.
# Con k = 10^5, construir la cadena serian 10^10 caracteres
suma_base = 0
for c in n:
    suma_base += int(c)

inicial = suma_base * k

print(superdigito(inicial))
# Fin</code></pre><p>El problema tiene dos partes y solo una es recursión.</p><p><strong>La observación matemática.</strong> Con <code>148</code> y k=3: los dígitos 1, 4 y 8 aparecen tres veces cada uno, así que la suma es (1+4+8) × 3 = 39 — exactamente la suma de los dígitos de 148148148, sin haberla escrito. Cuando un enunciado da límites absurdos (10⁵ × 10⁵), casi siempre te está avisando que hay una propiedad así.</p><p><strong>La recursión.</strong> Con el número ya reducido, la receta sale sola:</p><ul><li><strong>Caso base:</strong> <code>x &lt; 10</code>. Ponerlo en <code>x == 0</code> sería un error clásico: la suma de dígitos nunca llega a 0, y la función no pararía.</li><li><strong>Reducción:</strong> la suma de sus cifras, que siempre encoge.</li><li><strong>Combinar:</strong> nada. Este es un caso de recursión <em>de cola</em>: al volver no queda ninguna operación pendiente, a diferencia de <code>n + sumar(n-1)</code>.</li></ul>', '[{"stdin":"148 3\n","expected_output":"3\n"},{"stdin":"148 1\n","expected_output":"4\n"},{"stdin":"9875 1\n","expected_output":"2\n"},{"stdin":"9 1\n","expected_output":"9\n"},{"stdin":"123 100000\n","expected_output":"6\n"},{"stdin":"10 5\n","expected_output":"5\n"}]', '''''''
Programa: Superdigito
Autor:
Fecha:
Descripcion:
''''''


def superdigito(x):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'La suma que baja y sube', 'facil', '<p>Escribe las <strong>dos</strong> versiones recursivas de la suma 1 + 2 + … + n y muestra que dan lo mismo.</p><p>La entrada trae <code>n</code>. Imprime los dos resultados separados por espacio.</p><pre><code>Entrada:
4

Salida:
10 10</code></pre><p>La primera con la operación pendiente al volver (<em>pila</em>), la segunda acumulando en un parámetro (<em>cola</em>).</p>', '<p>Pila: <code>return n + sumar(n - 1)</code>. Cola: <code>return suma_cola(n - 1, total + n)</code>, con <code>total</code> como segundo parámetro que arranca en 0.</p>', '<pre><code>''''''
Programa: Suma recursiva, en pila y en cola
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Las dos formas de escribir la misma recursion, para ver la
    diferencia entre dejar una operacion pendiente y no dejarla.
''''''


def sumar(n):
    ''''''
    Suma 1 + 2 + ... + n dejando una operacion pendiente al volver.

    Parametros:
        n (int): hasta donde sumar

    Retorna:
        int: la suma
    ''''''
    if n == 0:
        return 0

    # El ''+ n'' queda PENDIENTE: esta llamada no puede terminar hasta
    # que la de adentro le responda. Eso es la pila creciendo
    return n + sumar(n - 1)


def suma_cola(n, total=0):
    ''''''
    La misma suma, acumulando en un parametro.

    Parametros:
        n (int): hasta donde sumar
        total (int): lo acumulado hasta ahora

    Retorna:
        int: la suma
    ''''''
    if n == 0:
        return total

    # Nada pendiente: lo que devuelva la llamada de adentro ES la
    # respuesta. Otros lenguajes optimizan esto y no crecen la pila;
    # Python NO lo hace
    return suma_cola(n - 1, total + n)


# Inicio
n = int(input())
print(sumar(n), suma_cola(n))
# Fin</code></pre><p>Con <code>n = 4</code>, la versión de pila baja congelando llamadas y sube completándolas:</p><pre><code>S(4) = 4 + S(3)
     = 4 + 3 + S(2)
     = 4 + 3 + 2 + S(1)
     = 4 + 3 + 2 + 1 + S(0)

Retorno: S(0)=0 → S(1)=1 → S(2)=3 → S(3)=6 → S(4)=10</code></pre><p>La de cola no acumula nada pendiente: cuando llega al caso base ya trae el total listo y solo lo devuelve.</p><p><strong>El detalle que importa en Python:</strong> las dos consumen la misma profundidad de pila. La optimización de llamada de cola existe en otros lenguajes, no aquí. Prueba con <code>n = 5000</code> y las dos revientan igual con <code>RecursionError</code>. Cuando la profundidad es el problema, la solución no es cambiar de estilo de recursión: es pasar a un ciclo.</p>', '[{"stdin":"4\n","expected_output":"10 10\n"},{"stdin":"0\n","expected_output":"0 0\n"},{"stdin":"1\n","expected_output":"1 1\n"},{"stdin":"100\n","expected_output":"5050 5050\n"}]', '''''''
Programa: Suma recursiva, en pila y en cola
Autor:
Fecha:
Descripcion:
''''''


def sumar(n):
    pass


def suma_cola(n, total=0):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es el caso base del superdígito?', NULL, '{"options":[{"id":"a","text":"Un número de un solo dígito"},{"id":"b","text":"Un número negativo"},{"id":"c","text":"Cero"},{"id":"d","text":"Cuando la suma deja de cambiar"}]}', '{"option_id":"a"}', 'El propio enunciado lo define: si tiene un solo dígito, ese dígito ES el superdígito. Poner el caso base en 0 sería un error, porque la suma de dígitos nunca llega a 0 y la recursión no pararía.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Si n = "148" y k = 3, ¿por qué NO construir la cadena "148148148"?', NULL, '{"options":[{"id":"a","text":"Es innecesario, y con k = 10⁵ la cadena tendría diez mil millones de caracteres"},{"id":"b","text":"Python no permite multiplicar cadenas"},{"id":"c","text":"Porque daría un resultado incorrecto"},{"id":"d","text":"Porque hay que convertirla a entero primero"}]}', '{"option_id":"a"}', 'Con este ejemplo pequeño funcionaría. El problema son los límites: |n| hasta 10⁵ y k hasta 10⁵. Repetir los dígitos multiplica su suma, así que suma(n) × k da lo mismo sin construir nada.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál es la reducción del problema del superdígito?', NULL, '{"options":[{"id":"a","text":"Reemplazar el número por la suma de sus dígitos"},{"id":"b","text":"Restarle 1 al número"},{"id":"c","text":"Dividirlo entre 10"},{"id":"d","text":"Quitarle el último dígito"}]}', '{"option_id":"a"}', 'Y esa reducción sí progresa: la suma de dígitos de cualquier número de dos o más cifras es siempre menor que el número, así que se acerca al caso base.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuánto vale superdigito(9875)?', NULL, '{"options":[{"id":"a","text":"2"},{"id":"b","text":"5"},{"id":"c","text":"29"},{"id":"d","text":"11"}]}', '{"option_id":"a"}', '9+8+7+5 = 29 → 2+9 = 11 → 1+1 = 2. Se repite hasta quedar en un solo dígito: por eso 29 y 11 no son respuestas válidas.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'En ''return n + sumar(n - 1)'' hay una operación pendiente al volver. ¿Cómo se llama esa forma y qué implica en Python?', NULL, '{"options":[{"id":"a","text":"Recursión de pila: cada llamada queda esperando en el stack, y Python revienta alrededor de las mil"},{"id":"b","text":"Recursión de cola: Python la optimiza y no crece el stack"},{"id":"c","text":"Recursión infinita"},{"id":"d","text":"Iteración disfrazada, sin costo de memoria"}]}', '{"option_id":"a"}', 'En la de cola —suma_cola(n-1, total+n)— no queda nada pendiente. Otros lenguajes la optimizan; Python NO, así que las dos consumen la misma profundidad de pila.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def sumar(n):
    if n == 0:
        return 0
    return n + sumar(n - 1)

print(sumar(4))', '{"options":[{"id":"a","text":"10"},{"id":"b","text":"4"},{"id":"c","text":"0"},{"id":"d","text":"RecursionError"}]}', '{"option_id":"a"}', '4+3+2+1+0 = 10. De bajada cada llamada queda congelada esperando; de subida completan: S(0)=0 → S(1)=1 → S(2)=3 → S(3)=6 → S(4)=10.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Este programa lanza RecursionError. ¿En qué línea está el problema?', NULL, '{"lines":["def superdigito(x):","    suma = sum(int(c) for c in str(x))","    return superdigito(suma)","    if x < 10:","        return x"]}', '{"line_number":3}', 'Se llama a sí misma ANTES de preguntar por el caso base, y las líneas 4 y 5 nunca se ejecutan. El caso base va de primero, siempre: es la condición de parada.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el superdígito.', NULL, '{"code":"def superdigito(x):\n    if ___1___:\n        return x\n\n    suma = 0\n    for c in str(x):\n        suma += int(c)\n\n    return ___2___","blanks":[{"id":"1","pista":"un solo dígito"},{"id":"2","pista":"delegar el mismo problema, ya reducido"}]}', '{"answers":{"1":["x < 10"],"2":["superdigito(suma)"]}}', 'El caso base es tener una sola cifra, y la delegación se hace sobre el número reducido. No hay nada que combinar al volver: se devuelve tal cual lo que llegue.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa el truco que evita construir la cadena gigante.', NULL, '{"code":"suma_base = 0\nfor c in n:\n    suma_base += int(c)\n\ninicial = suma_base ___1___ k\n\nprint(superdigito(inicial))","blanks":[{"id":"1","pista":"repetir el número repite sus dígitos"}]}', '{"answers":{"1":["*"]}}', 'Concatenar n consigo mismo k veces repite exactamente sus dígitos, así que la suma total es suma(n) × k. Con 148 y k=3: 13 × 3 = 39, la misma suma de 148148148.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma la función recursiva del superdígito', NULL, '{"lines":[{"id":"r1","text":"def superdigito(x):","indent":0},{"id":"r2","text":"if x < 10:","indent":1},{"id":"r3","text":"return x","indent":2},{"id":"r4","text":"suma = 0","indent":1},{"id":"r5","text":"for c in str(x):","indent":1},{"id":"r6","text":"suma += int(c)","indent":2},{"id":"r7","text":"return superdigito(suma)","indent":1}]}', '{"order":["r1","r2","r3","r4","r5","r6","r7"]}', 'El caso base arriba del todo. Si la llamada recursiva quedara antes, el resto del cuerpo sería código muerto y la función no pararía nunca.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'avanzado';

-- ── Capítulo 5: Backtracking (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 5, 'Backtracking', '🌳', 'El árbol de decisión y la poda de ramas que no llevan a nada.', '<p class="jc-gancho">Backtracking es fuerza bruta con memoria de dónde venías. Pruebas una opción, sigues, y si el camino no lleva a nada, <strong>deshaces</strong> y pruebas la siguiente. Todo el arte está en cortar ramas temprano: sin poda, el árbol crece hasta que el juez te da Time Limit.</p>

<h2>💡 La idea</h2>

<p>Backtracking explora un <strong>árbol de decisiones</strong>. En cada nodo hay una elección: tomar o no tomar, poner o no poner. Se avanza por una rama, y cuando la rama se muere, se regresa al nodo anterior y se toma la otra.</p>

<h3>El esqueleto</h3>

<pre><code>def explorar(estado):
    if es_solucion(estado):
        contar_o_guardar()
        return

    if no_puede_funcionar(estado):    # PODA
        return

    for opcion in opciones(estado):
        aplicar(opcion)               # elegir
        explorar(estado)              # seguir
        deshacer(opcion)              # BACKTRACK</code></pre>

<p>Los tres pilares:</p>

<table>
  <thead><tr><th>Pieza</th><th>Qué hace</th><th>Si falta</th></tr></thead>
  <tbody>
    <tr><td>Caso de éxito</td><td>Reconoce una solución completa</td><td>Nunca cuentas nada</td></tr>
    <tr><td><strong>Poda</strong></td><td>Abandona ramas imposibles</td><td>Funciona, pero se demora una eternidad</td></tr>
    <tr><td><strong>Deshacer</strong></td><td>Devuelve el estado como estaba</td><td>Las ramas se contaminan entre sí</td></tr>
  </tbody>
</table>

<p>La poda no cambia el resultado, cambia el tiempo. Y en competencia el tiempo <em>es</em> el resultado.</p>

<h2>📖 El problema</h2>

<div class="jc-problema">

<h3>Suma de potencias</h3>
<p><em>Basado en The Power Sum</em></p>

<p><strong>Descripción.</strong> Dados dos enteros <code>X</code> y <code>N</code>, hay que contar de cuántas formas se puede escribir <code>X</code> como la suma de las potencias <code>N</code>-ésimas de enteros positivos <strong>distintos</strong>.</p>

<p>Es decir, cuántos conjuntos <code>{a₁, a₂, …, a_k}</code> de enteros positivos distintos cumplen:</p>

<pre><code>X = a₁ᴺ + a₂ᴺ + … + a_kᴺ</code></pre>

<p><strong>Entrada.</strong> Dos líneas: <code>X</code> en la primera, <code>N</code> en la segunda. 1 ≤ X ≤ 1000, 2 ≤ N ≤ 10.</p>

<p><strong>Salida.</strong> Un entero: la cantidad de formas posibles.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody>
    <tr><td><code>10</code><br><code>2</code></td><td><code>1</code></td></tr>
    <tr><td><code>100</code><br><code>2</code></td><td><code>3</code></td></tr>
  </tbody>
</table>

<p><strong>Explicación.</strong> Para 10 con N=2 la única forma es 1² + 3² = 1 + 9. Para 100 con N=2 hay tres: 1²+3²+4²+5²+7², 6²+8², y 10².</p>

</div>

<h2>💡 Análisis y estrategia</h2>

<h3>Por qué no sirve un ciclo</h3>

<p>No se sabe de antemano <em>cuántos</em> números lleva la suma: para 100 una forma usa cinco números y otra usa uno solo. Con ciclos anidados habría que fijar la profundidad de antemano. Con recursión, no.</p>

<h3>La decisión, base por base</h3>

<p>Se recorren las bases en orden: 1, 2, 3, 4… y en cada una hay exactamente <strong>dos</strong> opciones:</p>

<ol>
  <li><strong>Usarla</strong> → el restante baja en <code>baseᴺ</code>, y se sigue desde <code>base + 1</code>.</li>
  <li><strong>No usarla</strong> → el restante queda igual, y se sigue desde <code>base + 1</code>.</li>
</ol>

<p>Que siempre se avance a <code>base + 1</code> es lo que garantiza los números <strong>distintos</strong> y que ningún conjunto se cuente dos veces: nunca se vuelve atrás a una base ya decidida.</p>

<h3>Los tres finales de una rama</h3>

<table>
  <thead><tr><th>Situación</th><th>Significa</th><th>Devuelve</th></tr></thead>
  <tbody>
    <tr><td><code>baseᴺ == restante</code></td><td>La suma cerró exacta</td><td><strong>1</strong> (una forma encontrada)</td></tr>
    <tr><td><code>baseᴺ &gt; restante</code></td><td>Ya se pasó, y las bases siguientes son aún mayores</td><td><strong>0</strong> — esta es la poda</td></tr>
    <tr><td>Ninguna de las dos</td><td>Todavía cabe</td><td>La suma de las dos ramas</td></tr>
  </tbody>
</table>

<p>La segunda fila es la clave. Como las potencias crecen, en cuanto <code>baseᴺ</code> se pasa del restante <strong>ninguna base mayor va a servir</strong>, y se corta el subárbol entero. Sin esa poda el programa probaría bases hasta el infinito.</p>

<h2>💻 Código paso a paso</h2>

<pre><code>def contar(restante, base, n):
    p = base ** n

    if p &gt; restante:        # PODA: ya se pasó, y las siguientes son mayores
        return 0

    if p == restante:       # ÉXITO: la suma cerró exacta
        return 1

    # Rama 1: usar esta base.  Rama 2: saltársela
    return contar(restante - p, base + 1, n) + contar(restante, base + 1, n)


x = int(input())
n = int(input())

print(contar(x, 1, n))</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué está ahí</th></tr></thead>
  <tbody>
    <tr><td><code>p = base ** n</code></td><td>Se calcula una sola vez; se usa tres veces</td></tr>
    <tr><td><code>if p &gt; restante: return 0</code></td><td>La poda. Va <strong>antes</strong> que el éxito porque descarta más rápido</td></tr>
    <tr><td><code>base + 1</code> en las dos ramas</td><td>Garantiza enteros distintos y que cada conjunto se cuente una sola vez</td></tr>
    <tr><td>Devolver la suma</td><td>Aquí no hay que deshacer nada: el estado viaja en los parámetros, no en una lista compartida</td></tr>
  </tbody>
</table>

<blockquote>Cuando el estado viaja como parámetro, el <em>backtrack</em> es gratis: al volver de la llamada, las variables de este nivel siguen intactas. Cuando el estado es una lista compartida, hay que hacer <code>pop()</code> a mano.</blockquote>

<h3>La película con <code>X = 10</code>, <code>N = 2</code></h3>

<table>
  <thead><tr><th>Llamada</th><th>base²</th><th>restante</th><th>Qué pasa</th></tr></thead>
  <tbody>
    <tr><td>contar(10, 1)</td><td>1</td><td>10</td><td>cabe → se abren dos ramas</td></tr>
    <tr><td>· contar(9, 2) <em>usó el 1</em></td><td>4</td><td>9</td><td>cabe → dos ramas</td></tr>
    <tr><td>· · contar(5, 3)</td><td>9</td><td>5</td><td>9 &gt; 5 → <b>poda, 0</b></td></tr>
    <tr><td>· · contar(9, 3) <em>saltó el 2</em></td><td>9</td><td>9</td><td>9 == 9 → <b>¡éxito, 1!</b> (1²+3²)</td></tr>
    <tr><td>· contar(10, 2) <em>saltó el 1</em></td><td>4</td><td>10</td><td>cabe → dos ramas</td></tr>
    <tr><td>· · contar(6, 3)</td><td>9</td><td>6</td><td>9 &gt; 6 → <b>poda, 0</b></td></tr>
    <tr><td>· · contar(10, 3)</td><td>9</td><td>10</td><td>cabe → dos ramas</td></tr>
    <tr><td>· · · contar(1, 4)</td><td>16</td><td>1</td><td>16 &gt; 1 → <b>poda, 0</b></td></tr>
    <tr><td>· · · contar(10, 4)</td><td>16</td><td>10</td><td>16 &gt; 10 → <b>poda, 0</b></td></tr>
  </tbody>
</table>

<p>Total: <strong>1</strong>. Nueve nodos visitados, para un árbol que sin poda sería infinito. Fíjate en que la respuesta sube sumándose por el árbol: cada nodo devuelve lo que le reporten sus dos hijos.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Sin poda</h3>
<pre><code>if p == restante:
    return 1
return contar(restante - p, base + 1, n) + contar(restante, base + 1, n)
# ❌ falta el ''if p > restante: return 0''</code></pre>
<p>La rama "no usar esta base" nunca termina: la base sube y sube y ninguna condición la para. <code>RecursionError</code>.</p>

<h3>2. No avanzar la base</h3>
<pre><code>return contar(restante - p, base, n) + contar(restante, base + 1, n)
#                                ↑ ❌ sin el +1</code></pre>
<p>Permitiría usar el mismo número varias veces, y el enunciado pide enteros <strong>distintos</strong>.</p>

<h3>3. Olvidar el deshacer (en la versión con lista)</h3>
<pre><code>actual.append(base)
explorar(...)
# ❌ falta actual.pop()</code></pre>
<p>La lista se va llenando con decisiones de ramas ya abandonadas, y todo lo que venga después trabaja con basura. Regla: <strong>por cada <code>append</code>, un <code>pop</code></strong>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Identifica la <strong>decisión</strong> que se repite: casi siempre es "tomar o no tomar".</li>
  <li>Escribe primero los finales de rama: éxito y poda. Sin ellos no para.</li>
  <li>La poda va <strong>antes</strong>: entre menos nodos se abran, mejor.</li>
  <li>Avanza siempre el índice (<code>base + 1</code>) para no repetir ni contar el mismo conjunto dos veces.</li>
  <li>Si el estado es una lista compartida, cada <code>append</code> necesita su <code>pop</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>if imposible: return 0</code></td><td>Poda: corta el subárbol completo</td></tr>
    <tr><td><code>if completo: return 1</code></td><td>Solución encontrada</td></tr>
    <tr><td><code>f(con) + f(sin)</code></td><td>Las dos ramas de "tomar o no tomar"</td></tr>
    <tr><td><code>base + 1</code></td><td>Elementos distintos, sin conjuntos repetidos</td></tr>
    <tr><td><code>append</code> … <code>pop</code></td><td>Backtrack manual sobre estado compartido</td></tr>
    <tr><td><code>base ** n</code></td><td>Potencia; guárdala en variable si se usa varias veces</td></tr>
  </tbody>
</table>

<blockquote>Fuerza bruta que se demora una eternidad y backtracking con buena poda son el mismo código. La diferencia son dos líneas.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 3 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 5 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Suma de potencias', 'medio', '<p>Cuenta de cuántas formas se puede escribir <code>X</code> como suma de potencias <code>N</code>-ésimas de enteros positivos <strong>distintos</strong>.</p><pre><code>Entrada:
100
2

Salida:
3</code></pre><p>Las tres formas son 1²+3²+4²+5²+7², 6²+8² y 10².</p>', '<p>Recorre las bases en orden. En cada una hay dos ramas: usarla (el restante baja) o saltarla (el restante queda igual). Las dos siguen con <code>base + 1</code>. Poda cuando <code>baseᴺ &gt; restante</code>.</p>', '<pre><code>''''''
Programa: Suma de potencias
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta de cuantas formas X se escribe como suma de potencias
    N-esimas de enteros positivos distintos, usando backtracking
    con poda.
''''''


def contar(restante, base, n):
    ''''''
    Cuenta las formas de completar ''restante'' usando bases desde ''base''.

    Parametros:
        restante (int): lo que falta por sumar
        base (int): primera base que todavia se puede usar
        n (int): exponente

    Retorna:
        int: cantidad de formas
    ''''''
    p = base ** n

    # PODA: las potencias solo crecen, asi que si esta ya se paso,
    # ninguna base mayor va a servir. Se corta el subarbol entero
    if p > restante:
        return 0

    # EXITO: la suma cerro exacta, es una forma valida
    if p == restante:
        return 1

    # Las dos ramas de la decision. Las DOS avanzan a base + 1: eso es
    # lo que garantiza enteros distintos y que no se repitan conjuntos
    usarla = contar(restante - p, base + 1, n)   # se toma esta base
    saltarla = contar(restante, base + 1, n)     # no se toma

    return usarla + saltarla


# Inicio
x = int(input())
n = int(input())

# Se arranca desde la base 1: la mas pequena posible
print(contar(x, 1, n))
# Fin</code></pre><p>El problema no se puede resolver con ciclos anidados porque <strong>no se sabe cuántos números lleva la suma</strong>: para 100 una forma usa cinco y otra usa uno. La recursión decide esa cantidad sobre la marcha.</p><p>Tres detalles que deciden si funciona:</p><ul><li><strong>La poda es la condición de parada.</strong> Sin <code>if p &gt; restante: return 0</code> la rama de "saltarla" no para nunca: la base sube y sube. Aquí la poda no es una optimización opcional.</li><li><strong>Va antes que el éxito.</strong> Descarta más ramas y más rápido; el orden entre las dos no cambia el resultado, pero sí el tiempo.</li><li><strong>Las dos ramas avanzan a <code>base + 1</code>.</strong> Si la rama de usarla se quedara en <code>base</code>, se podría repetir el mismo número; y si se pudiera retroceder, el conjunto {1,3} se contaría también como {3,1}.</li></ul><p>Fíjate en que no hay ningún <code>pop()</code>: como <code>restante</code> y <code>base</code> son parámetros, cada llamada tiene los suyos y el deshacer sale gratis.</p>', '[{"stdin":"10\n2\n","expected_output":"1\n"},{"stdin":"100\n2\n","expected_output":"3\n"},{"stdin":"100\n3\n","expected_output":"1\n"},{"stdin":"1\n2\n","expected_output":"1\n"},{"stdin":"800\n2\n","expected_output":"561\n"},{"stdin":"7\n3\n","expected_output":"0\n"}]', '''''''
Programa: Suma de potencias
Autor:
Fecha:
Descripcion:
''''''


def contar(restante, base, n):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Las formas, una por línea', 'medio', '<p>Igual que el anterior, pero ahora <strong>imprime las formas</strong>, una por línea, con las bases separadas por espacio y en orden creciente.</p><pre><code>Entrada:
100
2

Salida:
1 3 4 5 7
6 8
10</code></pre><p>Las formas salen en el orden en que el backtracking las encuentra: primero las que usan las bases más pequeñas.</p><p>Si no hay ninguna forma, no imprimas nada.</p>', '<p>Ahora sí hace falta una lista compartida: <code>actual.append(base)</code> antes de la llamada y <code>actual.pop()</code> después. Cuando el restante llega a 0, guarda una <em>copia</em> con <code>list(actual)</code>.</p>', '<pre><code>''''''
Programa: Formas de la suma de potencias
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Imprime cada forma de escribir X como suma de potencias N-esimas
    de enteros distintos. Backtracking con estado compartido.
''''''


def explorar(restante, base, n, actual, soluciones):
    ''''''
    Explora el arbol de decisiones guardando las formas completas.

    Parametros:
        restante (int): lo que falta por sumar
        base (int): primera base que todavia se puede usar
        n (int): exponente
        actual (list): bases elegidas en esta rama
        soluciones (list): donde se acumulan las formas encontradas

    Retorna:
        None: el resultado queda en ''soluciones''
    ''''''
    # EXITO: no falta nada por sumar. Se guarda una COPIA, porque
    # ''actual'' va a seguir cambiando cuando la recursion retroceda
    if restante == 0:
        soluciones.append(list(actual))
        return

    b = base
    while b ** n <= restante:
        # ELEGIR
        actual.append(b)

        # SEGUIR, siempre desde la base siguiente: enteros distintos
        explorar(restante - b ** n, b + 1, n, actual, soluciones)

        # DESHACER: por cada append, un pop. Sin esto la siguiente
        # vuelta del ciclo trabajaria con basura de la rama anterior
        actual.pop()

        b += 1


# Inicio
x = int(input())
n = int(input())

soluciones = []
explorar(x, 1, n, [], soluciones)

# El backtracking las encuentra en orden creciente de bases, asi que
# no hay que ordenar nada
for forma in soluciones:
    texto = ""
    for b in forma:
        if texto != "":
            texto += " "
        texto += str(b)
    print(texto)
# Fin</code></pre><p>Este es el mismo árbol del ejercicio anterior, pero ahora hay que <strong>recordar el camino</strong>, no solo contarlo. Ahí aparece el backtrack explícito.</p><ul><li><strong><code>list(actual)</code> y no <code>actual</code>.</strong> Guardar la lista misma sería guardar una referencia: cuando la recursión retroceda y haga <code>pop()</code>, la "solución" guardada se vacía con ella. Este es el error más caro del capítulo, porque el programa no falla — devuelve listas vacías.</li><li><strong>Un <code>pop</code> por cada <code>append</code>.</strong> Es la línea que le da nombre a la técnica: deshacer la decisión para dejar el estado como estaba.</li><li><strong>La poda ahora está en el <code>while</code>.</strong> <code>b ** n &lt;= restante</code> corta el ciclo apenas la potencia se pasa — como crecen, ninguna base mayor va a caber.</li><li><strong>El caso base cambió a <code>restante == 0</code>.</strong> Al contar bastaba detectar la última potencia; al construir la lista hay que llegar hasta el final con la decisión ya guardada.</li></ul>', '[{"stdin":"100\n2\n","expected_output":"1 3 4 5 7\n6 8\n10\n"},{"stdin":"10\n2\n","expected_output":"1 3\n"},{"stdin":"7\n3\n","expected_output":""},{"stdin":"1\n2\n","expected_output":"1\n"},{"stdin":"100\n3\n","expected_output":"1 2 3 4\n"}]', '''''''
Programa: Formas de la suma de potencias
Autor:
Fecha:
Descripcion:
''''''


def explorar(restante, base, n, actual, soluciones):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Códigos de Hamming', 'dificil', '<p>Un código binario de longitud <code>N</code> es una cadena de <code>N</code> ceros y unos. La <strong>distancia de Hamming</strong> entre dos códigos es en cuántas posiciones difieren.</p><p>Dados <code>N</code> y <code>H</code>, encuentra el conjunto <strong>más grande posible</strong> de códigos de longitud <code>N</code> tales que dos cualesquiera estén a distancia ≥ <code>H</code>. Imprime cuántos son y luego los códigos, uno por línea.</p><pre><code>Entrada:
3 2

Salida:
4
000
011
101
110</code></pre><p>Si hay varios conjuntos del mismo tamaño, imprime el que aparece primero explorando los códigos en orden numérico (000, 001, 010, …).</p><p>1 ≤ N ≤ 8, 1 ≤ H ≤ N.</p>', '<p>Recorre los códigos como números de 0 a 2ᴺ−1. En cada uno, dos ramas: agregarlo (si está a distancia ≥ H de <em>todos</em> los ya elegidos) o saltarlo. Guarda el mejor conjunto visto, y para formatear usa <code>bin(x)[2:].rjust(n, "0")</code>.</p>', '<pre><code>''''''
Programa: Codigos de Hamming
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Busca el conjunto mas grande de codigos binarios de longitud N a
    distancia de Hamming al menos H entre si, con backtracking.
''''''


def distancia(a, b, n):
    ''''''
    Cuenta en cuantas posiciones difieren dos codigos.

    Parametros:
        a (int): primer codigo, como numero
        b (int): segundo codigo, como numero
        n (int): longitud en bits

    Retorna:
        int: la distancia de Hamming
    ''''''
    # XOR deja un 1 en cada posicion donde los dos difieren
    x = a ^ b

    cuenta = 0
    for i in range(n):
        if x % 2 == 1:
            cuenta += 1
        x = x // 2

    return cuenta


def explorar(codigo, actual, n, h, total, mejor):
    ''''''
    Explora que codigos incluir, desde ''codigo'' en adelante.

    Parametros:
        codigo (int): primer codigo que todavia se puede considerar
        actual (list): codigos elegidos en esta rama
        n (int): longitud de los codigos
        h (int): distancia minima exigida
        total (int): cuantos codigos existen, 2**n
        mejor (list): caja de un elemento con el mejor conjunto visto

    Retorna:
        None: el resultado queda en ''mejor''
    ''''''
    # Se compara en cada nodo, no solo en las hojas: cualquier conjunto
    # parcial ya es un conjunto valido
    if len(actual) > len(mejor[0]):
        mejor[0] = list(actual)          # COPIA, no la lista misma

    for c in range(codigo, total):
        # PODA: si choca con alguno de los ya elegidos, esta rama no
        # existe. Basta con uno para descartarlo
        sirve = True
        for elegido in actual:
            if distancia(c, elegido, n) < h:
                sirve = False
                break

        if sirve:
            actual.append(c)                                  # elegir
            explorar(c + 1, actual, n, h, total, mejor)       # seguir
            actual.pop()                                      # deshacer


# Inicio
datos = input().split()
n = int(datos[0])
h = int(datos[1])

total = 2 ** n
mejor = [[]]

explorar(0, [], n, h, total, mejor)

print(len(mejor[0]))
for c in mejor[0]:
    # bin(5) da ''0b101'': se quita el ''0b'' y se rellena con ceros
    print(bin(c)[2:].rjust(n, "0"))
# Fin</code></pre><p>Este backtracking tiene una diferencia importante con la suma de potencias: <strong>no hay una condición de éxito puntual</strong>. Cualquier conjunto parcial ya es válido, y lo que se busca es el más grande. Por eso la comparación con <code>mejor</code> está al entrar a cada nodo, no en una hoja.</p><ul><li><strong>Los códigos como números.</strong> <code>a ^ b</code> deja un 1 en cada posición donde difieren, así que contar unos del XOR es la distancia. Comparar cadenas carácter por carácter también sirve, pero esto es más corto y más rápido.</li><li><strong>La poda es la restricción.</strong> Un código que choca con <strong>uno solo</strong> de los ya elegidos queda descartado — de ahí el <code>break</code>: no hace falta revisar los demás.</li><li><strong><code>range(codigo, total)</code>.</strong> Empezar en <code>codigo</code> y no en 0 evita generar el mismo conjunto en distinto orden. Es el mismo <code>base + 1</code> del otro problema.</li><li><strong><code>mejor</code> es una lista de un elemento.</strong> Un entero o una lista reasignada dentro de la función no saldría; una caja mutable sí. La alternativa limpia es devolver el mejor con <code>return</code> en cada nivel.</li></ul><p>Para N=3, H=2 el resultado son los cuatro códigos de paridad par: 000, 011, 101, 110. Cualquier par de ellos difiere en exactamente dos posiciones.</p>', '[{"stdin":"3 2\n","expected_output":"4\n000\n011\n101\n110\n"},{"stdin":"3 3\n","expected_output":"2\n000\n111\n"},{"stdin":"2 1\n","expected_output":"4\n00\n01\n10\n11\n"},{"stdin":"5 3\n","expected_output":"4\n00000\n00111\n11001\n11110\n"},{"stdin":"1 1\n","expected_output":"2\n0\n1\n"}]', '''''''
Programa: Codigos de Hamming
Autor:
Fecha:
Descripcion:
''''''


def distancia(a, b, n):
    pass


def explorar(codigo, actual, n, h, total, mejor):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la poda en el problema de la suma de potencias?', NULL, '{"options":[{"id":"a","text":"Si baseᴺ > restante, devolver 0: ninguna base mayor va a servir"},{"id":"b","text":"Si baseᴺ == restante, devolver 1"},{"id":"c","text":"Si el restante es par, saltarse la base"},{"id":"d","text":"Si base > 100, devolver 0"}]}', '{"option_id":"a"}', 'Las potencias solo crecen, así que si esta ya se pasó, todas las siguientes también. Ahí se corta el subárbol entero. La opción b es el caso de éxito, no la poda.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué las dos ramas llaman con ''base + 1'' y no con ''base''?', NULL, '{"options":[{"id":"a","text":"Para que los enteros sean distintos y cada conjunto se cuente una sola vez"},{"id":"b","text":"Para que la recursión sea más rápida"},{"id":"c","text":"Porque Python no permite repetir parámetros"},{"id":"d","text":"Para que el restante baje más rápido"}]}', '{"option_id":"a"}', 'Avanzar siempre significa que una base ya decidida no se vuelve a tocar. Con ''base'' en la rama de usar, se podría repetir el mismo número — y el enunciado pide distintos.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué pasa si se quita la poda ''if p > restante: return 0''?', NULL, '{"options":[{"id":"a","text":"La rama de ''no usar esta base'' nunca para: RecursionError"},{"id":"b","text":"Da una respuesta incorrecta pero termina"},{"id":"c","text":"No cambia nada"},{"id":"d","text":"Cuenta el doble de formas"}]}', '{"option_id":"a"}', 'Sin esa condición nada detiene a la base de subir. La poda no es solo optimización aquí: es la única condición de parada de esa rama.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Para X = 100 y N = 2 la respuesta es 3. ¿Cuáles son las tres formas?', NULL, '{"options":[{"id":"a","text":"1²+3²+4²+5²+7², 6²+8², y 10²"},{"id":"b","text":"10², 5²+5², y 6²+8²"},{"id":"c","text":"2²+4²+6²+8², 10², y 1²+3²+9²"},{"id":"d","text":"Solo 10² y 6²+8²"}]}', '{"option_id":"a"}', 'La opción b usa el 5 dos veces, y el enunciado exige enteros distintos. Verifica la primera: 1+9+16+25+49 = 100, y 36+64 = 100.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En la versión con lista compartida, ¿para qué sirve el pop() después de la llamada recursiva?', NULL, '{"options":[{"id":"a","text":"Para deshacer la decisión y dejar el estado como estaba antes de esta rama"},{"id":"b","text":"Para liberar memoria"},{"id":"c","text":"Para devolver el resultado"},{"id":"d","text":"Para ordenar la lista"}]}', '{"option_id":"a"}', 'Es el backtrack literal. Sin él, la rama siguiente encuentra la lista contaminada con decisiones de una rama ya abandonada. Regla: por cada append, un pop.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def contar(restante, base, n):
    p = base ** n
    if p > restante:
        return 0
    if p == restante:
        return 1
    return contar(restante - p, base + 1, n) + contar(restante, base + 1, n)

print(contar(10, 1, 2))', '{"options":[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"0"},{"id":"d","text":"3"}]}', '{"option_id":"a"}', 'La única forma es 1² + 3² = 1 + 9. Las demás ramas se podan: con base 3 el restante 5 ya no alcanza, y con base 4 (16) nada cabe.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este backtracking permite repetir números. ¿En qué línea está el error?', NULL, '{"lines":["def contar(restante, base, n):","    p = base ** n","    if p > restante:","        return 0","    if p == restante:","        return 1","    return contar(restante - p, base, n) + contar(restante, base + 1, n)"]}', '{"line_number":7}', 'La rama de ''usar esta base'' vuelve a entrar con la MISMA base, así que la puede usar otra vez. El enunciado pide enteros distintos: las dos ramas tienen que avanzar a base + 1.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el backtracking de la suma de potencias.', NULL, '{"code":"def contar(restante, base, n):\n    p = base ** n\n\n    if ___1___:\n        return 0\n\n    if p == restante:\n        return ___2___\n\n    return contar(restante - p, base + 1, n) + contar(___3___, base + 1, n)","blanks":[{"id":"1","pista":"la poda: ya se pasó"},{"id":"2","pista":"una forma encontrada"},{"id":"3","pista":"rama de saltarse esta base: el restante no cambia"}]}', '{"answers":{"1":["p > restante"],"2":["1"],"3":["restante"]}}', 'Tres piezas: poda, éxito y las dos ramas. En la de saltarse la base el restante queda igual — solo avanza la base.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa el backtrack manual sobre una lista compartida.', NULL, '{"code":"def explorar(restante, base, actual):\n    if restante == 0:\n        soluciones.append(list(actual))\n        return\n\n    for b in range(base, limite):\n        p = b * b\n        if p > restante:\n            break\n        actual.append(b)\n        explorar(restante - p, b + 1, actual)\n        actual.___1___()","blanks":[{"id":"1","pista":"deshacer la última decisión"}]}', '{"answers":{"1":["pop"]}}', 'Por cada append, un pop. Sin él, la siguiente vuelta del for arranca con la lista contaminada por la rama anterior.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma la función de conteo, con la poda en su lugar', NULL, '{"lines":[{"id":"b1","text":"def contar(restante, base, n):","indent":0},{"id":"b2","text":"p = base ** n","indent":1},{"id":"b3","text":"if p > restante:","indent":1},{"id":"b4","text":"return 0","indent":2},{"id":"b5","text":"if p == restante:","indent":1},{"id":"b6","text":"return 1","indent":2},{"id":"b7","text":"return contar(restante - p, base + 1, n) + contar(restante, base + 1, n)","indent":1}]}', '{"order":["b1","b2","b3","b4","b5","b6","b7"]}', 'La potencia se calcula una vez, la poda va antes del éxito porque descarta más rápido, y las dos ramas cierran la función.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué en este problema no hace falta escribir un ''deshacer'' explícito?', NULL, '{"options":[{"id":"a","text":"Porque el estado viaja en los parámetros, así que al volver de la llamada este nivel sigue intacto"},{"id":"b","text":"Porque no hay recursión de verdad"},{"id":"c","text":"Porque Python deshace solo"},{"id":"d","text":"Porque no hay poda"}]}', '{"option_id":"a"}', 'restante y base son parámetros: cada llamada tiene los suyos. El pop() a mano solo hace falta cuando todas las llamadas comparten la misma lista.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'avanzado';

-- ── Capítulo 6: Dividir y Conquistar (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 6, 'Dividir y Conquistar', '✂️', 'Burbuja contra Merge Sort: O(N²) contra O(N log N), y búsqueda binaria.', '<p class="jc-gancho">Tienes 100.000 números y hay que ordenarlos. Con burbuja el juez te da <strong>Time Limit Exceeded</strong>. Con merge sort, <strong>Accepted</strong> en menos de un segundo. Los dos ordenan bien; solo uno cabe en el tiempo. Este módulo es sobre esa diferencia — y sobre saberse los dos de memoria, porque en el parcial te los van a pedir escritos a mano.</p>

<h2>La idea: partir el problema</h2>

<p><strong>Dividir y conquistar</strong> es una receta de tres pasos:</p>

<ol>
  <li><strong>Dividir</strong> el problema en pedazos más pequeños del mismo tipo.</li>
  <li><strong>Conquistar</strong> cada pedazo (normalmente llamándose a sí mismo).</li>
  <li><strong>Combinar</strong> las respuestas en la respuesta final.</li>
</ol>

<p>Ordenar 8 números es difícil de un solo golpe. Ordenar 1 número es trivial. Merge sort baja de 8 a 1 partiendo por la mitad, y luego sube combinando.</p>

<h2>Burbuja: el que todos escriben primero</h2>

<pre><code>def burbuja(lista):
    n = len(lista)
    for i in range(n):
        intercambio = False
        for j in range(0, n - i - 1):
            if lista[j] &gt; lista[j + 1]:
                lista[j], lista[j + 1] = lista[j + 1], lista[j]
                intercambio = True
        if not intercambio:
            break
    return lista</code></pre>

<p>Compara <strong>vecinos</strong> y los intercambia si están al revés. En cada pasada, el número más grande "burbujea" hasta el final.</p>

<table>
  <thead>
    <tr><th>Pieza</th><th>Por qué está ahí</th></tr>
  </thead>
  <tbody>
    <tr><td><code>n - i - 1</code></td><td>Después de <code>i</code> pasadas, los últimos <code>i</code> ya quedaron en su sitio: no hay que volver a mirarlos</td></tr>
    <tr><td><code>lista[j], lista[j+1] = lista[j+1], lista[j]</code></td><td>El intercambio de Python, en una línea y sin variable auxiliar</td></tr>
    <tr><td><code>intercambio</code></td><td>La bandera: si una pasada completa no cambió nada, ya está ordenado y no hay nada más que hacer</td></tr>
  </tbody>
</table>

<h3>La película de una pasada</h3>

<p>Con <code>[5, 1, 4, 2]</code>, la primera pasada (<code>i = 0</code>):</p>

<table>
  <thead>
    <tr><th>j</th><th>Compara</th><th>¿Intercambia?</th><th>Queda</th></tr>
  </thead>
  <tbody>
    <tr><td>0</td><td>5 y 1</td><td>✅ sí</td><td>[<b>1, 5</b>, 4, 2]</td></tr>
    <tr><td>1</td><td>5 y 4</td><td>✅ sí</td><td>[1, <b>4, 5</b>, 2]</td></tr>
    <tr><td>2</td><td>5 y 2</td><td>✅ sí</td><td>[1, 4, <b>2, 5</b>]</td></tr>
  </tbody>
</table>

<p>El 5 llegó al final. Eso es lo que garantiza cada pasada: <strong>un número queda en su lugar definitivo</strong>. Por eso hacen falta <code>n</code> pasadas, y por eso son <code>n × n</code> comparaciones.</p>

<h2>Merge Sort: partir y mezclar</h2>

<pre><code>def merge_sort(lista):
    # CASO BASE
    if len(lista) &lt;= 1:
        return lista

    # DIVIDIR en dos mitades
    medio = len(lista) // 2
    izquierda = merge_sort(lista[:medio])
    derecha = merge_sort(lista[medio:])

    # MEZCLAR
    return merge(izquierda, derecha)</code></pre>

<p>Nueve líneas, y las tres partes de la receta están marcadas. El caso base va <strong>primero</strong>: sin él, la función se llamaría para siempre.</p>

<pre><code>def merge(izquierda, derecha):
    resultado = []
    i = 0  # indice izquierda
    j = 0  # indice derecha

    # Comparar y tomar el menor
    while i &lt; len(izquierda) and j &lt; len(derecha):
        if izquierda[i] &lt;= derecha[j]:
            resultado.append(izquierda[i])
            i = i + 1
        else:
            resultado.append(derecha[j])
            j = j + 1

    # Agregar restos de izquierda
    while i &lt; len(izquierda):
        resultado.append(izquierda[i])
        i = i + 1

    # Agregar restos de derecha
    while j &lt; len(derecha):
        resultado.append(derecha[j])
        j = j + 1

    return resultado</code></pre>

<p><code>merge</code> recibe <strong>dos listas ya ordenadas</strong> y las junta en una sola ordenada. Va tomando el menor de los dos frentes, uno a la vez.</p>

<h3>Los cuatro detalles que hay que saberse</h3>

<table>
  <thead>
    <tr><th>Detalle</th><th>Si lo cambias</th></tr>
  </thead>
  <tbody>
    <tr><td><code>and</code> en el primer <code>while</code></td><td>Con <code>or</code>, uno de los índices se sale de la lista y revienta con <code>IndexError</code></td></tr>
    <tr><td><code>&lt;=</code> y no <code>&lt;</code></td><td>Con <code>&lt;</code> el algoritmo deja de ser <strong>estable</strong>: dos elementos iguales se voltean</td></tr>
    <tr><td><code>//</code> y no <code>/</code></td><td><code>/</code> devuelve decimal, y <code>lista[:3.5]</code> es <code>TypeError</code></td></tr>
    <tr><td>Los dos <code>while</code> de restos</td><td>Sin ellos, el programa <strong>no falla</strong>: simplemente pierde elementos. El peor error posible, porque parece funcionar</td></tr>
  </tbody>
</table>

<h3>La película de una mezcla</h3>

<p>Mezclando <code>[3, 9, 27]</code> con <code>[10, 38]</code>:</p>

<table>
  <thead>
    <tr><th>i</th><th>j</th><th>Compara</th><th>Toma</th><th>resultado</th></tr>
  </thead>
  <tbody>
    <tr><td>0</td><td>0</td><td>3 ≤ 10</td><td>3</td><td>[3]</td></tr>
    <tr><td>1</td><td>0</td><td>9 ≤ 10</td><td>9</td><td>[3, 9]</td></tr>
    <tr><td>2</td><td>0</td><td>27 &gt; 10</td><td>10</td><td>[3, 9, 10]</td></tr>
    <tr><td>2</td><td>1</td><td>27 ≤ 38</td><td>27</td><td>[3, 9, 10, 27]</td></tr>
    <tr><td>3</td><td>1</td><td>se acabó la izquierda</td><td>—</td><td>sale del primer while</td></tr>
    <tr><td>3</td><td>1</td><td>resto de la derecha</td><td>38</td><td>[3, 9, 10, 27, 38]</td></tr>
  </tbody>
</table>

<p>Ese último paso es el que hacen los <code>while</code> de restos. Sin ellos, el 38 <strong>se pierde</strong> y la lista sale con 4 elementos en vez de 5.</p>

<h2>⚖️ La diferencia de complejidad</h2>

<p>Aquí está la razón de aprenderse los dos:</p>

<table>
  <thead>
    <tr><th></th><th>❌ Burbuja</th><th>✅ Merge Sort</th></tr>
  </thead>
  <tbody>
    <tr><td>Complejidad</td><td><code>O(N²)</code></td><td><code>O(N log N)</code></td></tr>
    <tr><td>Con N grande</td><td>Lento</td><td>Rápido y óptimo</td></tr>
    <tr><td>Memoria extra</td><td>Ninguna</td><td>Otra lista</td></tr>
    <tr><td>Mejor caso</td><td><code>O(N)</code> si ya está ordenado (por la bandera)</td><td><code>O(N log N)</code> siempre</td></tr>
  </tbody>
</table>

<p>Y esto no es teoría. Estas son <strong>comparaciones y segundos medidos</strong> con los dos programas de arriba:</p>

<table>
  <thead>
    <tr><th>N</th><th>Burbuja</th><th>Merge</th><th>Burbuja</th><th>Merge</th><th>Diferencia</th></tr>
  </thead>
  <tbody>
    <tr><td>100</td><td>4.872 comp.</td><td>543 comp.</td><td>0,000 s</td><td>0,000 s</td><td>4×</td></tr>
    <tr><td>500</td><td>123.319</td><td>3.869</td><td>0,013 s</td><td>0,001 s</td><td>15×</td></tr>
    <tr><td>1.000</td><td>499.380</td><td>8.715</td><td>0,058 s</td><td>0,002 s</td><td><b>30×</b></td></tr>
    <tr><td>2.000</td><td>1.997.460</td><td>19.434</td><td>0,236 s</td><td>0,004 s</td><td><b>59×</b></td></tr>
    <tr><td>4.000</td><td>7.996.919</td><td>42.851</td><td>1,002 s</td><td>0,007 s</td><td><b>138×</b></td></tr>
  </tbody>
</table>

<p>Mira la última columna: la diferencia <strong>crece</strong>. No es que el burbuja sea "un poco más lento", es que se despega. La razón está en cómo reacciona cada uno cuando doblas N:</p>

<blockquote>Al doblar N, el burbuja se pone <strong>4 veces</strong> más lento (2² = 4). El merge, apenas <strong>un poco más del doble</strong>.</blockquote>

<p>Llevado a tamaños de juez en línea:</p>

<table>
  <thead>
    <tr><th>N</th><th>N² (burbuja)</th><th>N·log₂N (merge)</th></tr>
  </thead>
  <tbody>
    <tr><td>1.000</td><td>1.000.000</td><td>9.965</td></tr>
    <tr><td>100.000</td><td>10.000.000.000</td><td>1.660.964</td></tr>
    <tr><td>1.000.000</td><td>1.000.000.000.000</td><td>19.931.568</td></tr>
  </tbody>
</table>

<p>Con un millón de datos, el burbuja pide <strong>un billón</strong> de comparaciones: horas. El merge pide 20 millones: <strong>segundos</strong>. Esa frase es la que te llevas al parcial.</p>

<h2>Búsqueda binaria: la misma idea, buscando</h2>

<p>Partir por la mitad también sirve para buscar — pero solo si la lista <strong>ya está ordenada</strong>.</p>

<pre><code>def busqueda_binaria(lista, objetivo):
    izq = 0
    der = len(lista) - 1

    while izq &lt;= der:
        medio = (izq + der) // 2

        if lista[medio] == objetivo:
            return medio
        if lista[medio] &lt; objetivo:
            izq = medio + 1      # está a la derecha
        else:
            der = medio - 1      # está a la izquierda

    return -1                    # no está</code></pre>

<p>Cada vuelta descarta <strong>la mitad</strong> de lo que queda. En un millón de elementos son 20 vueltas, no un millón: <code>O(log N)</code>.</p>

<p>Los dos <code>+1</code> y <code>-1</code> no son adorno: sin ellos, cuando <code>izq</code> y <code>der</code> se juntan el <code>while</code> no termina nunca.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. El caso base después de la recursión</h3>
<pre><code>def merge_sort(lista):        # ❌ RecursionError
    medio = len(lista) // 2
    izquierda = merge_sort(lista[:medio])
    if len(lista) &lt;= 1:
        return lista</code></pre>
<p>El caso base va <strong>primero</strong>. Es la condición de parada: si se pregunta después de llamarse, nunca para.</p>

<h3>2. Olvidar un <code>while</code> de restos</h3>
<pre><code>while i &lt; len(izquierda) and j &lt; len(derecha):
    ...
while i &lt; len(izquierda):     # ✅
    ...
# ❌ falta el de la derecha: se pierden elementos en silencio</code></pre>

<h3>3. Creer que el burbuja "sirve igual"</h3>
<p>Sirve, con 100 datos. Con 100.000 el juez te saca por tiempo. Ordenar bien no basta: hay que ordenar <strong>a tiempo</strong>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Caso base primero, siempre.</li>
  <li>Dividir por la mitad con <code>//</code>, nunca con <code>/</code>.</li>
  <li><code>lista[:medio]</code> y <code>lista[medio:]</code>: sin solapar y sin perder nada.</li>
  <li>Al mezclar: <code>and</code> en el while, <code>&lt;=</code> en la comparación, y los <strong>dos</strong> while de restos.</li>
  <li>Si el enunciado dice "N hasta 100.000", el burbuja ya no es opción.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Algoritmo</th><th>Complejidad</th><th>Cuándo</th></tr>
  </thead>
  <tbody>
    <tr><td>Burbuja</td><td><code>O(N²)</code></td><td>N pequeño, o cuando lo piden explícitamente</td></tr>
    <tr><td>Merge Sort</td><td><code>O(N log N)</code></td><td>Siempre que N sea grande</td></tr>
    <tr><td>Búsqueda binaria</td><td><code>O(log N)</code></td><td>Buscar en algo <strong>ya ordenado</strong></td></tr>
    <tr><td><code>sorted()</code></td><td><code>O(N log N)</code></td><td>En competencia, salvo que pidan implementarlo</td></tr>
  </tbody>
</table>

<blockquote>Los dos ordenan bien. Solo uno termina a tiempo. Sabérselos de memoria es saber cuál escribir — y por qué.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 4 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 6 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Burbuja de memoria', 'facil', '<p>Escribe el burbuja <strong>sin mirar</strong>. La entrada trae una línea con números separados por espacio; imprime la lista ordenada, también separada por espacios.</p><pre><code>Entrada:
5 1 4 2 8

Salida:
1 2 4 5 8</code></pre><p><em>Prohibido</em> <code>sorted()</code> y <code>.sort()</code>. La gracia es escribirlo de memoria.</p>', '<p>Dos ciclos: el de afuera cuenta las pasadas, el de adentro llega hasta <code>n - i - 1</code>. Adentro, comparas <code>lista[j]</code> con <code>lista[j + 1]</code>.</p>', '<pre><code>''''''
Programa: Ordenamiento burbuja
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Ordena una lista de numeros comparando vecinos, sin usar sorted().
''''''


def burbuja(lista):
    ''''''
    Ordena la lista de menor a mayor, en el mismo objeto.

    Parametros:
        lista (list): numeros a ordenar

    Retorna:
        list: la misma lista, ya ordenada
    ''''''
    n = len(lista)

    for i in range(n):
        # Bandera: si una pasada no intercambia nada, ya esta ordenado
        intercambio = False

        # -i porque los ultimos i ya quedaron en su sitio;
        # -1 porque adentro se mira j+1 y no puede salirse
        for j in range(0, n - i - 1):
            if lista[j] > lista[j + 1]:
                lista[j], lista[j + 1] = lista[j + 1], lista[j]
                intercambio = True

        if not intercambio:
            break

    return lista


# Inicio
numeros = [int(x) for x in input().split()]
print(" ".join(str(x) for x in burbuja(numeros)))
# Fin</code></pre><p>Tres piezas que hay que tener clarísimas para escribirlo de memoria:</p><ul><li><strong><code>n - i - 1</code></strong>. El <code>-i</code> es porque después de <code>i</code> pasadas los últimos <code>i</code> elementos ya están en su lugar definitivo: volver a mirarlos es trabajo perdido. El <code>-1</code> es porque adentro se lee <code>lista[j + 1]</code>, y sin él la última vuelta se saldría de la lista.</li><li><strong>El intercambio en una línea.</strong> Python arma primero la tupla de la derecha y después asigna, así que no hace falta variable auxiliar. Escrito en dos líneas sin auxiliar, se pierde un valor.</li><li><strong>La bandera.</strong> Sin ella el algoritmo hace sus N pasadas aunque la lista llegue ordenada. Con ella, ese caso se resuelve en una sola pasada: pasa de O(N²) a O(N).</li></ul>', '[{"stdin":"5 1 4 2 8\n","expected_output":"1 2 4 5 8\n"},{"stdin":"1 2 3\n","expected_output":"1 2 3\n"},{"stdin":"9 8 7 6 5\n","expected_output":"5 6 7 8 9\n"},{"stdin":"42\n","expected_output":"42\n"},{"stdin":"3 -1 3 0 -1\n","expected_output":"-1 -1 0 3 3\n"}]', '''''''
Programa: Ordenamiento burbuja
Autor:
Fecha:
Descripcion:
''''''


def burbuja(lista):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Merge Sort de memoria', 'medio', '<p>Ahora el que sí sirve con datos grandes. Misma entrada y misma salida que el anterior, pero con <code>merge_sort</code> y su <code>merge</code>.</p><pre><code>Entrada:
38 27 43 3 9 82 10

Salida:
3 9 10 27 38 43 82</code></pre><p><em>Prohibido</em> <code>sorted()</code> y <code>.sort()</code>.</p>', '<p>Dos funciones. <code>merge_sort</code> parte y se llama a sí misma; <code>merge</code> recibe dos listas <strong>ya ordenadas</strong> y las junta. No olvides los dos ciclos de restos al final.</p>', '<pre><code>''''''
Programa: Merge Sort
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Ordena dividiendo por la mitad y mezclando: O(N log N).
''''''


def merge_sort(lista):
    ''''''
    Ordena la lista dividiendo y conquistando.

    Parametros:
        lista (list): numeros a ordenar

    Retorna:
        list: una lista nueva, ordenada
    ''''''
    # CASO BASE: una lista de 0 o 1 elemento ya esta ordenada
    if len(lista) <= 1:
        return lista

    # DIVIDIR en dos mitades
    medio = len(lista) // 2
    izquierda = merge_sort(lista[:medio])
    derecha = merge_sort(lista[medio:])

    # MEZCLAR
    return merge(izquierda, derecha)


def merge(izquierda, derecha):
    ''''''
    Junta dos listas YA ordenadas en una sola ordenada.

    Parametros:
        izquierda (list): primera mitad, ordenada
        derecha (list): segunda mitad, ordenada

    Retorna:
        list: las dos mitades mezcladas en orden
    ''''''
    resultado = []
    i = 0  # indice izquierda
    j = 0  # indice derecha

    # Mientras queden elementos EN LAS DOS, se toma el menor.
    # Va ''and'': con ''or'' uno de los indices se sale de su lista
    while i < len(izquierda) and j < len(derecha):
        # ''<='' y no ''<'': con el igual, los empates los gana la izquierda
        # y el orden original de los iguales se conserva (es estable)
        if izquierda[i] <= derecha[j]:
            resultado.append(izquierda[i])
            i = i + 1
        else:
            resultado.append(derecha[j])
            j = j + 1

    # Una de las dos se acabo primero: lo que quede en la otra se copia
    # tal cual, porque ya viene ordenado. Sin estos dos ciclos el
    # programa NO falla: simplemente pierde elementos
    while i < len(izquierda):
        resultado.append(izquierda[i])
        i = i + 1

    while j < len(derecha):
        resultado.append(derecha[j])
        j = j + 1

    return resultado


# Inicio
numeros = [int(x) for x in input().split()]
print(" ".join(str(x) for x in merge_sort(numeros)))
# Fin</code></pre><p>El orden de las piezas <em>es</em> el algoritmo:</p><ul><li><strong>El caso base va primero.</strong> Es la condición de parada. Puesto después de las llamadas recursivas, la función nunca deja de llamarse: <code>RecursionError</code>.</li><li><strong><code>//</code> y no <code>/</code>.</strong> La división normal devuelve <code>3.5</code>, y <code>lista[:3.5]</code> es <code>TypeError</code>. El índice tiene que ser entero.</li><li><strong><code>[:medio]</code> y <code>[medio:]</code>.</strong> El primero no incluye la posición <code>medio</code> y el segundo sí: se tocan exactamente, sin perder ni repetir nada.</li><li><strong>Los dos <code>while</code> de restos.</strong> El error más difícil de cazar de todo el módulo. Sin ellos el programa corre, no lanza nada, y devuelve una lista incompleta.</li></ul><p>Compáralo con el burbuja del ejercicio anterior: con 4.000 números, el burbuja hace ocho millones de comparaciones y este hace cuarenta y dos mil.</p>', '[{"stdin":"38 27 43 3 9 82 10\n","expected_output":"3 9 10 27 38 43 82\n"},{"stdin":"5 4 3 2 1\n","expected_output":"1 2 3 4 5\n"},{"stdin":"7\n","expected_output":"7\n"},{"stdin":"2 1\n","expected_output":"1 2\n"},{"stdin":"4 4 2 4 2\n","expected_output":"2 2 4 4 4\n"}]', '''''''
Programa: Merge Sort
Autor:
Fecha:
Descripcion:
''''''


def merge_sort(lista):
    pass


def merge(izquierda, derecha):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, '¿Cuánto más lento?', 'medio', '<p>Cuenta las <strong>comparaciones</strong> que hace cada algoritmo sobre la misma lista y muestra la diferencia. La entrada trae los números en una línea.</p><pre><code>Entrada:
5 1 4 2 8 9 3 7

Salida:
Burbuja: 25 comparaciones
Merge:   14 comparaciones
Burbuja hace 1.8 veces mas</code></pre><p>La razón se imprime con un decimal.</p>', '<p>Un contador global (o una lista de un elemento) que aumentas justo antes de cada <code>if</code> de comparación. En el burbuja, la comparación es la del <code>if</code> de adentro; en el merge, la del primer <code>while</code>.</p>', '<pre><code>''''''
Programa: Comparar burbuja contra merge sort
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta las comparaciones de cada algoritmo sobre la misma lista para
    ver en numeros la diferencia entre O(N^2) y O(N log N).
''''''

comparaciones = {"burbuja": 0, "merge": 0}


def burbuja(lista):
    ''''''Ordena contando cada comparacion entre vecinos.''''''
    n = len(lista)

    for i in range(n):
        intercambio = False
        for j in range(0, n - i - 1):
            # Se cuenta ANTES del if: la comparacion ocurre igual,
            # intercambie o no
            comparaciones["burbuja"] += 1
            if lista[j] > lista[j + 1]:
                lista[j], lista[j + 1] = lista[j + 1], lista[j]
                intercambio = True
        if not intercambio:
            break

    return lista


def merge_sort(lista):
    ''''''Ordena dividiendo, contando las comparaciones de la mezcla.''''''
    if len(lista) <= 1:
        return lista

    medio = len(lista) // 2
    return merge(merge_sort(lista[:medio]), merge_sort(lista[medio:]))


def merge(izquierda, derecha):
    ''''''Mezcla dos listas ordenadas contando cada comparacion.''''''
    resultado = []
    i = 0
    j = 0

    while i < len(izquierda) and j < len(derecha):
        comparaciones["merge"] += 1
        if izquierda[i] <= derecha[j]:
            resultado.append(izquierda[i])
            i = i + 1
        else:
            resultado.append(derecha[j])
            j = j + 1

    while i < len(izquierda):
        resultado.append(izquierda[i])
        i = i + 1

    while j < len(derecha):
        resultado.append(derecha[j])
        j = j + 1

    return resultado


# Inicio
numeros = [int(x) for x in input().split()]

# Cada uno recibe SU copia: el burbuja ordena en el mismo objeto y le
# dejaria la lista ya ordenada al otro, que es justo su mejor caso
burbuja(list(numeros))
merge_sort(list(numeros))

print(f"Burbuja: {comparaciones[''burbuja'']} comparaciones")
print(f"Merge:   {comparaciones[''merge'']} comparaciones")

razon = comparaciones["burbuja"] / comparaciones["merge"]
print(f"Burbuja hace {razon:.1f} veces mas")
# Fin</code></pre><p>El detalle que decide si el experimento sirve o no es <code>list(numeros)</code>. El burbuja ordena <strong>sobre la misma lista</strong>, así que si le pasas el original, al merge le llega ya ordenada — su mejor caso — y la comparación queda amañada. Cada uno tiene que recibir su copia.</p><p>Y las comparaciones se cuentan <strong>antes</strong> del <code>if</code>, no adentro: la comparación ocurre siempre, haya intercambio o no. Contarla adentro mediría otra cosa.</p><p>Corre el programa con 8 números y verás una diferencia pequeña. Corre con 100 y verás por qué el juez rechaza el burbuja.</p>', '[{"stdin":"5 1 4 2 8 9 3 7\n","expected_output":"Burbuja: 25 comparaciones\nMerge:   14 comparaciones\nBurbuja hace 1.8 veces mas\n"},{"stdin":"2 1\n","expected_output":"Burbuja: 1 comparaciones\nMerge:   1 comparaciones\nBurbuja hace 1.0 veces mas\n"}]', '''''''
Programa: Comparar burbuja contra merge sort
Autor:
Fecha:
Descripcion:
''''''

comparaciones = {"burbuja": 0, "merge": 0}


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Buscar sin recorrer', 'dificil', '<p>Ordena con <code>merge_sort</code> y responde consultas con <strong>búsqueda binaria</strong>.</p><p>La primera línea trae los números de la lista. La segunda, los valores a buscar. Por cada uno imprime la posición donde quedó tras ordenar, o <code>-1</code> si no está.</p><pre><code>Entrada:
38 27 43 3 9
9 100 43

Salida:
3 9 27 38 43
9 -> posicion 1
100 -> no esta
43 -> posicion 4</code></pre>', '<p>Reusa el <code>merge_sort</code> del ejercicio 2. La búsqueda binaria mantiene dos límites, <code>izq</code> y <code>der</code>, y en cada vuelta descarta la mitad que no puede contener el objetivo.</p>', '<pre><code>''''''
Programa: Ordenar y buscar
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Ordena con merge sort y responde consultas con busqueda binaria,
    sin recorrer la lista completa en cada consulta.
''''''


def merge_sort(lista):
    ''''''Ordena la lista dividiendo por la mitad. O(N log N).''''''
    if len(lista) <= 1:
        return lista

    medio = len(lista) // 2
    return merge(merge_sort(lista[:medio]), merge_sort(lista[medio:]))


def merge(izquierda, derecha):
    ''''''Junta dos listas ya ordenadas en una sola ordenada.''''''
    resultado = []
    i = 0
    j = 0

    while i < len(izquierda) and j < len(derecha):
        if izquierda[i] <= derecha[j]:
            resultado.append(izquierda[i])
            i = i + 1
        else:
            resultado.append(derecha[j])
            j = j + 1

    while i < len(izquierda):
        resultado.append(izquierda[i])
        i = i + 1

    while j < len(derecha):
        resultado.append(derecha[j])
        j = j + 1

    return resultado


def busqueda_binaria(lista, objetivo):
    ''''''
    Busca un valor en una lista ORDENADA.

    Parametros:
        lista (list): numeros ordenados de menor a mayor
        objetivo (int): lo que se busca

    Retorna:
        int: la posicion donde esta, o -1 si no aparece
    ''''''
    izq = 0
    der = len(lista) - 1

    # ''<='' porque cuando izq y der se juntan todavia queda una casilla
    # por revisar: la de en medio de un rango de tamano 1
    while izq <= der:
        medio = (izq + der) // 2

        if lista[medio] == objetivo:
            return medio

        if lista[medio] < objetivo:
            izq = medio + 1   # el objetivo esta a la derecha
        else:
            der = medio - 1   # esta a la izquierda

    return -1


# Inicio
numeros = [int(x) for x in input().split()]
consultas = [int(x) for x in input().split()]

ordenada = merge_sort(numeros)
print(" ".join(str(x) for x in ordenada))

for valor in consultas:
    posicion = busqueda_binaria(ordenada, valor)
    if posicion == -1:
        print(f"{valor} -> no esta")
    else:
        print(f"{valor} -> posicion {posicion}")
# Fin</code></pre><p>Los tres detalles de la búsqueda binaria que se preguntan en el parcial:</p><ul><li><strong><code>while izq &lt;= der</code>, con el igual.</strong> Cuando los dos límites se juntan queda todavía una casilla por mirar. Con <code>&lt;</code> a secas, esa casilla nunca se revisa y el valor buscado se reporta como ausente.</li><li><strong><code>medio + 1</code> y <code>medio - 1</code>.</strong> Ya se comprobó que <code>medio</code> no es el objetivo, así que se descarta también esa posición. Si escribes <code>izq = medio</code>, el rango deja de encogerse y el <code>while</code> no termina nunca.</li><li><strong>El <code>return -1</code> va afuera del <code>while</code>.</strong> Solo se llega ahí cuando el rango se agotó por completo.</li></ul><p>Por qué importa: con 200.000 números, recorrer la lista en cada consulta son 200.000 pasos por consulta. La binaria son 18. Ordenas una vez y buscas barato para siempre.</p>', '[{"stdin":"38 27 43 3 9\n9 100 43\n","expected_output":"3 9 27 38 43\n9 -> posicion 1\n100 -> no esta\n43 -> posicion 4\n"},{"stdin":"5 3 1\n1 5 4\n","expected_output":"1 3 5\n1 -> posicion 0\n5 -> posicion 2\n4 -> no esta\n"}]', '''''''
Programa: Ordenar y buscar
Autor:
Fecha:
Descripcion:
''''''


def merge_sort(lista):
    pass


def merge(izquierda, derecha):
    pass


def busqueda_binaria(lista, objetivo):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma merge_sort. Ojo con el orden: hay una línea que si va en otro lugar, la función no para nunca.', NULL, '{"lines":[{"id":"l1","text":"def merge_sort(lista):","indent":0},{"id":"l2","text":"if len(lista) <= 1:","indent":1},{"id":"l3","text":"return lista","indent":2},{"id":"l4","text":"medio = len(lista) // 2","indent":1},{"id":"l5","text":"izquierda = merge_sort(lista[:medio])","indent":1},{"id":"l6","text":"derecha = merge_sort(lista[medio:])","indent":1},{"id":"l7","text":"return merge(izquierda, derecha)","indent":1}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7"]}', 'El caso base va de primero: es la condición de parada. Si se pregunta después de las llamadas recursivas, la función se llama para siempre y revienta con RecursionError.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la división de merge_sort. Son las tres piezas que más se equivocan.', NULL, '{"code":"medio = len(lista) ___1___ 2\nizquierda = merge_sort(lista[___2___])\nderecha = merge_sort(lista[___3___])","blanks":[{"id":"1","pista":"división entera, no decimal"},{"id":"2","pista":"desde el principio hasta el medio"},{"id":"3","pista":"desde el medio hasta el final"}]}', '{"answers":{"1":["//"],"2":[":medio"],"3":["medio:"]}}', 'Con / el medio queda decimal y lista[:3.5] lanza TypeError. Los dos cortes se tocan en ''medio'' sin solaparse: [:medio] no incluye esa posición y [medio:] sí, así que no se pierde ni se repite ningún elemento.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa el corazón de la mezcla.', NULL, '{"code":"while i < len(izquierda) ___1___ j < len(derecha):\n    if izquierda[i] ___2___ derecha[j]:\n        resultado.append(izquierda[i])\n        ___3___\n    else:\n        resultado.append(derecha[j])\n        j = j + 1","blanks":[{"id":"1","pista":"los DOS índices tienen que estar dentro"},{"id":"2","pista":"el que conserva el orden de los iguales"},{"id":"3","pista":"avanzar el índice de la izquierda"}]}', '{"answers":{"1":["and"],"2":["<="],"3":["i = i + 1","i += 1"]}}', 'Con ''or'' basta que un índice esté dentro para entrar, y el otro se sale de la lista: IndexError. Con ''<'' en vez de ''<='', dos elementos iguales se voltean y el algoritmo deja de ser estable.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el corazón del burbuja.', NULL, '{"code":"for j in range(0, n - i - 1):\n    if ___1___:\n        ___2___\n        intercambio = True","blanks":[{"id":"1","pista":"compara la casilla con su vecina de la derecha"},{"id":"2","pista":"el intercambio de Python, en una sola línea"}]}', '{"answers":{"1":["lista[j] > lista[j + 1]","lista[j + 1] < lista[j]"],"2":["lista[j], lista[j + 1] = lista[j + 1], lista[j]"]}}', 'El burbuja solo compara vecinos. El intercambio con una sola asignación no necesita variable auxiliar: Python arma la tupla de la derecha antes de asignar.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'Este merge no falla, no lanza ningún error... y devuelve listas incompletas. ¿Qué línea falta o sobra?', NULL, '{"lines":["while i < len(izquierda) and j < len(derecha):","    ...","while i < len(izquierda):","    resultado.append(izquierda[i])","    i = i + 1","return resultado"]}', '{"line_number":6}', 'Antes del return falta el while que vacía los restos de la derecha. Cuando la izquierda se acaba primero, lo que queda en la derecha nunca se copia: la lista sale con menos elementos y sin ningún mensaje de error. Es el peor error posible, porque parece funcionar.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué merge usa <= y no < al comparar?', NULL, '{"options":[{"id":"a","text":"Para que sea estable: dos elementos iguales conservan el orden en que venían"},{"id":"b","text":"Para que no se salga de la lista"},{"id":"c","text":"Porque con < el resultado sale al revés"},{"id":"d","text":"Da exactamente lo mismo"}]}', '{"option_id":"a"}', 'Con <= los empates los gana la izquierda, que es la mitad que venía primero. Importa cuando ordenas objetos por un campo: ''ordenar por nota'' no debería revolver a los que tienen la misma nota.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Ordenar 1.000 números con burbuja tarda 0,06 s. ¿Cuánto tardarán 4.000, aproximadamente?', NULL, '{"options":[{"id":"a","text":"Alrededor de 1 segundo: 16 veces más"},{"id":"b","text":"Alrededor de 0,24 s: 4 veces más"},{"id":"c","text":"Casi lo mismo, 0,06 s"},{"id":"d","text":"Alrededor de 0,12 s: el doble"}]}', '{"option_id":"a"}', 'El burbuja es O(N²): al multiplicar N por 4, el tiempo se multiplica por 4² = 16. Medido de verdad: 0,058 s con 1.000 y 1,002 s con 4.000. Esa es la trampa de O(N²) — no crece, se dispara.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'El burbuja de este módulo tiene una bandera ''intercambio''. ¿Para qué sirve?', NULL, '{"options":[{"id":"a","text":"Si una pasada completa no intercambia nada, la lista ya está ordenada y sale: eso lo hace O(N) en el mejor caso"},{"id":"b","text":"Para contar cuántos intercambios hubo"},{"id":"c","text":"Para saber si la lista tenía repetidos"},{"id":"d","text":"Para que el algoritmo sea estable"}]}', '{"option_id":"a"}', 'Sin bandera, el burbuja hace siempre sus N pasadas aunque ya esté ordenado. Con bandera, una lista ya ordenada se resuelve en una sola pasada. La complejidad depende del caso: no es un sello pegado al algoritmo.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def merge(izquierda, derecha):
    resultado = []
    i = j = 0
    while i < len(izquierda) and j < len(derecha):
        if izquierda[i] <= derecha[j]:
            resultado.append(izquierda[i]); i += 1
        else:
            resultado.append(derecha[j]); j += 1
    return resultado

print(merge([1, 4, 9], [2, 3]))', '{"options":[{"id":"a","text":"[1, 2, 3, 4]"},{"id":"b","text":"[1, 2, 3, 4, 9]"},{"id":"c","text":"[1, 4, 9, 2, 3]"},{"id":"d","text":"Lanza IndexError"}]}', '{"option_id":"a"}', 'A este merge le quitaron los while de restos. Cuando la derecha se agota (j llega a 2), el while termina y el 9 se queda sin copiar. No hay error: solo un resultado incompleto, que es lo difícil de detectar.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué necesita la búsqueda binaria para funcionar?', NULL, '{"options":[{"id":"a","text":"Que la lista esté ordenada"},{"id":"b","text":"Que la lista no tenga repetidos"},{"id":"c","text":"Que la lista tenga tamaño par"},{"id":"d","text":"Que los números sean positivos"}]}', '{"option_id":"a"}', 'Descartar media lista solo tiene sentido si el orden garantiza de qué lado está lo que buscas. Sobre una lista desordenada, la búsqueda binaria responde cualquier cosa.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'El enunciado dice: N puede llegar a 200.000. ¿Qué implica?', NULL, '{"options":[{"id":"a","text":"Que el burbuja no cabe en el tiempo: toca O(N log N)"},{"id":"b","text":"Que hay que usar más memoria"},{"id":"c","text":"Que hay que leer la entrada con input() en vez de sys.stdin"},{"id":"d","text":"Que no se puede usar recursión"}]}', '{"option_id":"a"}', 'N² con 200.000 son 40.000 millones de comparaciones. El límite de N en el enunciado no es un dato de adorno: te está diciendo qué complejidad tienes permitida.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma la búsqueda binaria', NULL, '{"lines":[{"id":"b1","text":"izq, der = 0, len(lista) - 1","indent":0},{"id":"b2","text":"while izq <= der:","indent":0},{"id":"b3","text":"medio = (izq + der) // 2","indent":1},{"id":"b4","text":"if lista[medio] == objetivo:","indent":1},{"id":"b5","text":"return medio","indent":2},{"id":"b6","text":"if lista[medio] < objetivo:","indent":1},{"id":"b7","text":"izq = medio + 1","indent":2},{"id":"b8","text":"else:","indent":1},{"id":"b9","text":"der = medio - 1","indent":2},{"id":"b10","text":"return -1","indent":0}]}', '{"order":["b1","b2","b3","b4","b5","b6","b7","b8","b9","b10"]}', 'El return -1 va afuera del while: solo se llega ahí cuando el rango se agotó sin encontrar nada. Y los +1 / -1 son los que evitan el ciclo infinito cuando izq y der se juntan.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'avanzado';

-- ── Capítulo 7: Programación Dinámica (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 7, 'Programación Dinámica', '📊', 'La tabla DP y la diferencia entre construirla hacia adelante o hacia atrás.', '<p class="jc-gancho">Dos problemas casi idénticos: contar formas de dar un cambio y llenar una cinta de cassette. El mismo tamaño de código, la misma tabla, los mismos dos ciclos. Lo único que cambia es <strong>hacia dónde va el ciclo de adentro</strong>. Y esa dirección decide si puedes repetir una moneda o no. Este módulo es sobre esa línea.</p>

<h2>💡 Qué es Programación Dinámica</h2>

<p>Una frase: <strong>no calcular dos veces lo mismo</strong>.</p>

<p>Se arma una tabla — la <code>dp</code> — donde cada casilla guarda la respuesta a un subproblema. Cuando el problema grande necesita esa respuesta, la <strong>consulta</strong> en vez de recalcularla.</p>

<p>Lo difícil de DP no es el código: son cuatro líneas. Lo difícil es responder <strong>qué significa exactamente <code>dp[i]</code></strong>. Si no puedes decirlo en una frase, todavía no tienes la solución.</p>

<h2>🏗️ Problema 1 — Edificio</h2>

<div class="jc-problema">
<p><strong>Descripción.</strong> Tienes pisos de distintos tamaños. Quieres construir una torre donde cada piso sea <strong>estrictamente mayor</strong> que el anterior. ¿Cuál es la altura máxima que puedes lograr?</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>5 7 -2 6 9 -3 8</code></td><td><code>35</code></td></tr></tbody>
</table>
</div>

<h3>La pregunta que hay que responder primero</h3>

<p><strong><code>dp[i]</code> = la altura máxima de una torre que termina en el piso <code>i</code>.</strong> Esa frase es la solución; lo demás es escribirla.</p>

<pre><code>def solve_edificio(pisos):
    if not pisos:
        return 0

    pisos_ordenados = sorted(pisos)       # ← lo que hace que todo funcione
    n = len(pisos_ordenados)

    dp = pisos_ordenados[:]               # cada piso solo ya es una torre

    for i in range(1, n):
        for j in range(i):
            if pisos_ordenados[j] &lt; pisos_ordenados[i]:
                dp[i] = max(dp[i], dp[j] + pisos_ordenados[i])

    return max(dp)</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué está ahí</th></tr>
  </thead>
  <tbody>
    <tr><td><code>sorted(pisos)</code></td><td>Ordenar garantiza que todo lo que está <strong>antes</strong> en la lista es candidato a ir <strong>abajo</strong> en la torre. Sin ordenar, habría que mirar la lista entera en cada paso</td></tr>
    <tr><td><code>dp = pisos_ordenados[:]</code></td><td>La copia es la torre de un solo piso. Es el punto de partida: siempre existe</td></tr>
    <tr><td><code>for j in range(i)</code></td><td>Prueba poner el piso <code>i</code> encima de cada piso anterior</td></tr>
    <tr><td><code>if …[j] &lt; …[i]</code></td><td>La regla del problema: estrictamente creciente. Con <code>&lt;=</code> aceptaría pisos iguales</td></tr>
    <tr><td><code>max(dp[i], dp[j] + …)</code></td><td>La decisión: ¿mejor solo, o encima de la mejor torre que termina en <code>j</code>?</td></tr>
    <tr><td><code>return max(dp)</code></td><td><strong>No</strong> es <code>dp[n-1]</code>: la mejor torre puede no terminar en el piso más grande</td></tr>
  </tbody>
</table>

<h3>La película con <code>[2, 5, 3]</code></h3>

<table>
  <thead><tr><th>Paso</th><th>Compara</th><th>Decide</th><th>dp queda</th></tr></thead>
  <tbody>
    <tr><td>ordenar</td><td>—</td><td><code>[2, 3, 5]</code></td><td><code>[2, 3, 5]</code></td></tr>
    <tr><td>i=1, j=0</td><td>¿2 &lt; 3? sí</td><td><code>max(3, 2+3)</code> = 5</td><td><code>[2, 5, 5]</code></td></tr>
    <tr><td>i=2, j=0</td><td>¿2 &lt; 5? sí</td><td><code>max(5, 2+5)</code> = 7</td><td><code>[2, 5, 7]</code></td></tr>
    <tr><td>i=2, j=1</td><td>¿3 &lt; 5? sí</td><td><code>max(7, 5+5)</code> = <b>10</b></td><td><code>[2, 5, 10]</code></td></tr>
  </tbody>
</table>

<p>Respuesta: <code>max(dp)</code> = <strong>10</strong>, la torre 2 + 3 + 5.</p>

<h3>Por qué la respuesta del ejemplo grande es 35 y no 30</h3>

<p>Con <code>[5, 7, -2, 6, 9, -3, 8]</code>, ordenado queda <code>[-3, -2, 5, 6, 7, 8, 9]</code>. Todos van en orden creciente, así que la torre <em>podría</em> usarlos todos: −3 −2 + 5 + 6 + 7 + 8 + 9 = <strong>30</strong>.</p>

<p>Pero la mejor torre es <strong>35</strong>: 5 + 6 + 7 + 8 + 9. <strong>Dejar fuera los negativos da más altura.</strong></p>

<p>Ese es todo el punto del <code>max(dp[i], …)</code>: en cada paso el algoritmo puede decidir <em>empezar de nuevo</em> en vez de apilarse sobre lo anterior. Si el problema fuera "usa todos los que puedas", no habría nada que optimizar.</p>

<h2>💰 Problema 2 — Monedas</h2>

<div class="jc-problema">
<p><strong>Descripción.</strong> Con monedas de 50¢, 25¢, 10¢, 5¢ y 1¢, ¿de cuántas formas distintas se puede armar una cantidad? Cada combinación cuenta una sola vez, sin importar el orden.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>11</code></td><td><code>4</code> — (10+1) · (5+5+1) · (5+1×6) · (1×11)</td></tr></tbody>
</table>
</div>

<pre><code>def solve_monedas(cantidad):
    monedas = [50, 25, 10, 5, 1]

    dp = [0] * (cantidad + 1)
    dp[0] = 1                              # hay 1 forma de armar 0: ninguna moneda

    for moneda in monedas:                 # ← primero la moneda
        for m in range(moneda, cantidad + 1):   # ← ADELANTE
            dp[m] += dp[m - moneda]

    return dp[cantidad]</code></pre>

<p><strong><code>dp[m]</code> = de cuántas formas se arma la cantidad <code>m</code></strong> con las monedas consideradas hasta ahora.</p>

<p>El <code>dp[0] = 1</code> no es un truco: es el caso base. Hay exactamente una manera de armar cero centavos — no poner nada. Si fuera 0, toda la tabla quedaría en ceros, porque cada casilla se construye sumando desde otra.</p>

<h3>La película con cantidad = 5</h3>

<table>
  <thead><tr><th>Moneda</th><th>Qué hace</th><th>dp queda</th></tr></thead>
  <tbody>
    <tr><td>inicio</td><td>—</td><td><code>[1, 0, 0, 0, 0, 0]</code></td></tr>
    <tr><td>50, 25, 10</td><td>no caben en 5</td><td><code>[1, 0, 0, 0, 0, 0]</code></td></tr>
    <tr><td>5</td><td><code>dp[5] += dp[0]</code></td><td><code>[1, 0, 0, 0, 0, 1]</code></td></tr>
    <tr><td>1</td><td>llena todo, y <code>dp[5] += dp[4]</code></td><td><code>[1, 1, 1, 1, 1, <b>2</b>]</code></td></tr>
  </tbody>
</table>

<p>Dos formas: una de 5¢, o cinco de 1¢. ✅</p>

<h2>📼 Problema 3 — Cintas</h2>

<div class="jc-problema">
<p><strong>Descripción.</strong> Tienes una cinta de <code>N</code> minutos y varias pistas con sus duraciones. Quieres llenarla lo más posible, pero <strong>cada pista se usa una vez o ninguna</strong>: no puedes grabar la misma dos veces.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td>pistas <code>3 5</code>, cinta de <code>8</code></td><td><code>8</code></td></tr></tbody>
</table>
</div>

<pre><code>def solve_cintas(duraciones, minutos_totales):
    dp = [0] * (minutos_totales + 1)

    for duracion in duraciones:
        for m in range(minutos_totales, duracion - 1, -1):   # ← ATRÁS
            dp[m] = max(dp[m], dp[m - duracion] + duracion)

    return dp[minutos_totales]</code></pre>

<p><strong><code>dp[m]</code> = los minutos máximos que se pueden llenar teniendo <code>m</code> minutos de cinta.</strong></p>

<h2>🔑 ADELANTE contra ATRÁS: la línea que lo cambia todo</h2>

<p>Compara los dos ciclos de adentro:</p>

<pre><code># Monedas — se puede repetir la misma moneda
for m in range(moneda, cantidad + 1):        # de menor a mayor

# Cintas — cada pista, una sola vez
for m in range(minutos_totales, duracion - 1, -1):   # de mayor a menor</code></pre>

<h3>Por qué ir hacia adelante repite</h3>

<p>Con una pista de 3 minutos y una cinta de 5, yendo <strong>adelante</strong>:</p>

<table>
  <thead><tr><th>m</th><th>Consulta</th><th>Valor de esa casilla</th><th>dp[m] queda</th></tr></thead>
  <tbody>
    <tr><td>3</td><td><code>dp[0] + 3</code></td><td>0 — casilla limpia</td><td>3</td></tr>
    <tr><td>4</td><td><code>dp[1] + 3</code></td><td>0 — casilla limpia</td><td>3</td></tr>
    <tr><td>5</td><td><code>dp[2] + 3</code></td><td>0</td><td>3</td></tr>
    <tr><td>6</td><td><code>dp[3] + 3</code></td><td><b>3 — ¡esa casilla ya usó la pista!</b></td><td><b>6</b> ❌</td></tr>
  </tbody>
</table>

<p>En <code>m = 6</code> consulta <code>dp[3]</code>, que <strong>ya fue actualizado en esta misma pasada</strong>. Resultado: la pista de 3 minutos se grabó dos veces.</p>

<h3>Por qué ir hacia atrás no repite</h3>

<p>Recorriendo de mayor a menor, <code>dp[m - duracion]</code> es una casilla que <strong>todavía no se ha tocado</strong> en esta pasada: guarda el resultado <em>sin</em> esta pista. Por eso cada pista entra máximo una vez.</p>

<table>
  <thead>
    <tr><th></th><th>💰 Monedas</th><th>📼 Cintas</th></tr>
  </thead>
  <tbody>
    <tr><td>Dirección</td><td><b>ADELANTE</b></td><td><b>ATRÁS</b></td></tr>
    <tr><td>Repetir el mismo elemento</td><td>✅ permitido</td><td>❌ prohibido</td></tr>
    <tr><td>Nombre clásico</td><td>Mochila ilimitada</td><td>Mochila 0/1</td></tr>
    <tr><td>La casilla consultada</td><td>ya incluye este elemento</td><td>todavía no lo incluye</td></tr>
  </tbody>
</table>

<blockquote>Si el enunciado dice "puedes usar cada cosa las veces que quieras" → adelante. Si dice "cada cosa una sola vez" → atrás. Es la primera pregunta que hay que hacerle a un problema de mochila.</blockquote>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Devolver <code>dp[n-1]</code> en vez de <code>max(dp)</code></h3>
<pre><code>return dp[n - 1]     # ❌ asume que la mejor torre termina en el piso más grande</code></pre>
<p>En <code>[5, 7, -2, …]</code> la mejor termina en el 9, sí — pero en otros casos no. Si <code>dp[i]</code> es "torres que terminan en i", la respuesta es el máximo de todas.</p>

<h3>2. Poner <code>dp[0] = 0</code> en Monedas</h3>
<pre><code>dp[0] = 0            # ❌ toda la tabla queda en ceros</code></pre>

<h3>3. Cambiar el <code>-1</code> del <code>range</code> en Cintas</h3>
<pre><code>for m in range(minutos_totales, duracion - 1, 1):   # ❌ va adelante, repite pistas
                                                     #    y además no ejecuta nada</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Escribe en una frase qué significa <code>dp[i]</code>. Si no puedes, aún no tienes la solución.</li>
  <li>Define el caso base: <code>dp[0]</code> casi siempre es 1 (contar) o 0 (maximizar).</li>
  <li>Decide la dirección del ciclo interno: <strong>adelante</strong> si se puede repetir, <strong>atrás</strong> si no.</li>
  <li>La transición siempre es una decisión: <code>max</code> entre usarlo y no usarlo, o <code>+=</code> para contar.</li>
  <li>Al final, ¿la respuesta es la última casilla o el máximo de todas? Depende de lo que <code>dp[i]</code> signifique.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Problema</th><th>dp[i] significa</th><th>Ciclo</th><th>Complejidad</th></tr></thead>
  <tbody>
    <tr><td>🏗️ Edificio</td><td>altura máxima terminando en <code>i</code></td><td>doble, sobre pisos ordenados</td><td><code>O(N²)</code></td></tr>
    <tr><td>💰 Monedas</td><td>formas de armar <code>i</code></td><td>moneda → cantidad, <b>adelante</b></td><td><code>O(N × M)</code></td></tr>
    <tr><td>📼 Cintas</td><td>minutos llenados con <code>i</code> de cinta</td><td>pista → cinta, <b>atrás</b></td><td><code>O(N × P)</code></td></tr>
  </tbody>
</table>

<blockquote>Los tres problemas tienen el mismo esqueleto. Lo que cambia es qué guarda la tabla y hacia dónde corre el ciclo — y de eso depende toda la respuesta.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 4 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 7 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Edificio', 'medio', '<p>Construye la torre más alta posible: cada piso tiene que ser <strong>estrictamente mayor</strong> que el que tiene debajo.</p><p>La entrada trae los tamaños de los pisos en una línea. Imprime la altura máxima.</p><pre><code>Entrada:
5 7 -2 6 9 -3 8

Salida:
35</code></pre><p>Ojo con ese ejemplo: usar los siete pisos da 30. La mejor torre <strong>deja fuera los negativos</strong>.</p>', '<p>Ordena primero. <code>dp[i]</code> = altura máxima de una torre que <strong>termina</strong> en el piso <code>i</code>. La respuesta es <code>max(dp)</code>, no <code>dp[-1]</code>.</p>', '<pre><code>''''''
Programa: Edificio
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Altura maxima de una torre con pisos estrictamente crecientes,
    resuelto con programacion dinamica en O(N^2).
''''''


def solve_edificio(pisos):
    ''''''
    Calcula la altura maxima de la torre.

    Parametros:
        pisos (list): tamanos de los pisos disponibles

    Retorna:
        int: la altura de la mejor torre
    ''''''
    if not pisos:
        return 0

    # Ordenar es lo que hace que la DP funcione: garantiza que todo lo
    # que esta antes en la lista puede ir DEBAJO en la torre
    pisos_ordenados = sorted(pisos)
    n = len(pisos_ordenados)

    # dp[i] = altura maxima de una torre que TERMINA en el piso i.
    # Se arranca con cada piso solo, que ya es una torre valida
    dp = pisos_ordenados[:]

    for i in range(1, n):
        for j in range(i):
            # Estrictamente creciente: con <= aceptaria pisos iguales
            if pisos_ordenados[j] < pisos_ordenados[i]:
                # La decision: quedarse solo, o apilarse sobre la mejor
                # torre que termina en j
                dp[i] = max(dp[i], dp[j] + pisos_ordenados[i])

    # max(dp) y no dp[-1]: la mejor torre no tiene por que terminar en
    # el piso mas grande
    return max(dp)


# Inicio
pisos = [int(x) for x in input().split()]
print(solve_edificio(pisos))
# Fin</code></pre><p>Las dos líneas que deciden si el programa está bien:</p><ul><li><strong><code>dp = pisos_ordenados[:]</code></strong> — el punto de partida es cada piso solo. Si empezaras en ceros, el <code>max</code> nunca podría escoger "empezar aquí".</li><li><strong><code>return max(dp)</code></strong> — como <code>dp[i]</code> significa "torre que termina en <code>i</code>", hay que mirar todas.</li></ul><p>Y el caso del enunciado enseña de qué se trata realmente la DP. Con <code>[-3, -2, 5, 6, 7, 8, 9]</code> todos van en orden creciente, así que <em>caben</em> todos: suman 30. Pero el <code>max</code> de la transición le permite al algoritmo <strong>arrancar de nuevo</strong> en el 5 y dejar los negativos afuera: 5+6+7+8+9 = <strong>35</strong>. Si el problema fuera "usa todos los que puedas", no habría nada que optimizar.</p>', '[{"stdin":"5 7 -2 6 9 -3 8\n","expected_output":"35\n"},{"stdin":"2 5 3\n","expected_output":"10\n"},{"stdin":"10 5 8\n","expected_output":"23\n"},{"stdin":"1 2 3 4 5\n","expected_output":"15\n"},{"stdin":"7\n","expected_output":"7\n"},{"stdin":"-5 -3 -1\n","expected_output":"-1\n"}]', '''''''
Programa: Edificio
Autor:
Fecha:
Descripcion:
''''''


def solve_edificio(pisos):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Monedas — contar formas', 'medio', '<p>Con monedas de 50¢, 25¢, 10¢, 5¢ y 1¢, ¿de cuántas formas distintas se puede armar una cantidad?</p><p>La entrada trae la cantidad. El orden no cuenta: <code>5+1</code> y <code>1+5</code> son la misma forma.</p><pre><code>Entrada:
11

Salida:
4</code></pre><p>Las cuatro: 10+1 · 5+5+1 · 5+1×6 · 1×11.</p>', '<p><code>dp[0] = 1</code> — hay una forma de armar cero: no usar nada. Y el ciclo de la cantidad va <strong>hacia adelante</strong>, porque una misma moneda se puede repetir.</p>', '<pre><code>''''''
Programa: Monedas
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta de cuantas formas distintas se arma una cantidad, con
    monedas que se pueden repetir (mochila ilimitada).
''''''


def solve_monedas(cantidad):
    ''''''
    Cuenta las combinaciones de monedas que suman la cantidad.

    Parametros:
        cantidad (int): centavos a armar

    Retorna:
        int: cuantas formas distintas hay
    ''''''
    monedas = [50, 25, 10, 5, 1]

    # dp[m] = de cuantas formas se arma la cantidad m
    dp = [0] * (cantidad + 1)

    # Caso base: hay UNA forma de armar 0, no poner ninguna moneda.
    # Con 0 aqui, toda la tabla quedaria en ceros
    dp[0] = 1

    # La moneda por fuera y la cantidad por dentro: asi cada combinacion
    # se cuenta una sola vez, sin importar el orden
    for moneda in monedas:
        # ADELANTE: dp[m - moneda] ya incluye esta moneda, y por eso se
        # puede usar varias veces
        for m in range(moneda, cantidad + 1):
            dp[m] += dp[m - moneda]

    return dp[cantidad]


# Inicio
print(solve_monedas(int(input())))
# Fin</code></pre><p>Dos decisiones y una consecuencia:</p><ul><li><strong>La moneda por fuera.</strong> Así se cuentan <em>combinaciones</em>, no <em>permutaciones</em>. Si el ciclo de la cantidad fuera el de afuera, <code>5+1</code> y <code>1+5</code> contarían como dos formas distintas y el resultado se dispararía.</li><li><strong>El ciclo interno hacia adelante.</strong> Cuando llega a <code>m</code>, la casilla <code>dp[m - moneda]</code> <strong>ya fue actualizada</strong> con esta misma moneda en esta pasada. Eso es exactamente lo que permite repetirla.</li></ul><p>Compáralo con el ejercicio de las Cintas: mismo esqueleto, ciclo al revés, y la moneda deja de poder repetirse.</p>', '[{"stdin":"11\n","expected_output":"4\n"},{"stdin":"5\n","expected_output":"2\n"},{"stdin":"0\n","expected_output":"1\n"},{"stdin":"25\n","expected_output":"13\n"},{"stdin":"100\n","expected_output":"292\n"}]', '''''''
Programa: Monedas
Autor:
Fecha:
Descripcion:
''''''


def solve_monedas(cantidad):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Cintas — cada pista una vez', 'dificil', '<p>Tienes una cinta de <code>N</code> minutos y varias pistas. Llénala lo más posible, pero <strong>cada pista se graba una vez o ninguna</strong>.</p><p>La primera línea trae las duraciones; la segunda, los minutos de la cinta.</p><pre><code>Entrada:
30 25 50 20
100

Salida:
100</code></pre><p>Este es el mismo código de Monedas con <strong>una línea distinta</strong>. Encuéntrala.</p>', '<p>El ciclo de la cinta va de mayor a menor: <code>range(total, duracion - 1, -1)</code>. Así <code>dp[m - duracion]</code> todavía no incluye esta pista.</p>', '<pre><code>''''''
Programa: Cintas
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Llena una cinta al maximo usando cada pista a lo sumo una vez
    (mochila 0/1).
''''''


def solve_cintas(duraciones, minutos_totales):
    ''''''
    Calcula los minutos maximos que se pueden grabar.

    Parametros:
        duraciones (list): duracion de cada pista
        minutos_totales (int): largo de la cinta

    Retorna:
        int: minutos llenados en el mejor caso
    ''''''
    # dp[m] = minutos maximos que se pueden llenar teniendo m de cinta
    dp = [0] * (minutos_totales + 1)

    for duracion in duraciones:
        # ATRAS. Es LA linea que separa este problema del de Monedas:
        # al ir de mayor a menor, dp[m - duracion] todavia NO incluye
        # esta pista, asi que entra maximo una vez
        for m in range(minutos_totales, duracion - 1, -1):
            # No grabarla, o grabarla: se escoge lo que llene mas
            dp[m] = max(dp[m], dp[m - duracion] + duracion)

    return dp[minutos_totales]


# Inicio
duraciones = [int(x) for x in input().split()]
minutos = int(input())
print(solve_cintas(duraciones, minutos))
# Fin</code></pre><p>Para ver por qué la dirección importa, hay que escoger bien el ejemplo: con una pista de 3 minutos y una cinta de <strong>5</strong>, adelante y atrás dan lo mismo. El error solo se asoma cuando la cinta es <strong>al menos el doble</strong> de la pista.</p><p>Con una pista de 3 y una cinta de 6:</p><table><thead><tr><th>m</th><th>Consulta</th><th>Vale</th><th>dp[m]</th></tr></thead><tbody><tr><td>3</td><td><code>dp[0] + 3</code></td><td>0</td><td>3</td></tr><tr><td>4</td><td><code>dp[1] + 3</code></td><td>0</td><td>3</td></tr><tr><td>5</td><td><code>dp[2] + 3</code></td><td>0</td><td>3</td></tr><tr><td>6</td><td><code>dp[3] + 3</code></td><td><b>3 — ya usó la pista</b></td><td><b>6</b> ❌</td></tr></tbody></table><p>Yendo hacia atrás, cuando se calcula <code>dp[6]</code> la casilla <code>dp[3]</code> todavía está intacta, así que la pista no se puede grabar dos veces. Resultado correcto: 3.</p>', '[{"stdin":"30 25 50 20\n100\n","expected_output":"100\n"},{"stdin":"3 5\n8\n","expected_output":"8\n"},{"stdin":"3\n6\n","expected_output":"3\n"},{"stdin":"5 10 15\n30\n","expected_output":"30\n"},{"stdin":"3 7 5\n15\n","expected_output":"15\n"},{"stdin":"7 11\n10\n","expected_output":"7\n"}]', '''''''
Programa: Cintas
Autor:
Fecha:
Descripcion:
''''''


def solve_cintas(duraciones, minutos_totales):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué es indispensable ordenar los pisos antes de la DP del Edificio?', NULL, '{"options":[{"id":"a","text":"Para garantizar que todo lo que está antes en la lista puede ir abajo en la torre"},{"id":"b","text":"Para que el algoritmo sea más rápido"},{"id":"c","text":"Para poder usar max() al final"},{"id":"d","text":"Porque sorted() elimina los repetidos"}]}', '{"option_id":"a"}', 'Ordenados, basta mirar hacia atrás: todos los índices j < i son candidatos a quedar debajo. Sin ordenar habría que recorrer la lista entera en cada paso y la comparación pierde sentido.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué representa exactamente dp[i] en el problema del Edificio?', NULL, '{"options":[{"id":"a","text":"La altura máxima de una torre que TERMINA en el piso i"},{"id":"b","text":"La altura máxima usando los primeros i pisos"},{"id":"c","text":"El tamaño del piso i"},{"id":"d","text":"Cuántos pisos caben debajo del i"}]}', '{"option_id":"a"}', 'Por eso la respuesta final es max(dp) y no dp[n-1]: la mejor torre no tiene por qué terminar en el piso más grande. Si dp[i] fuera ''con los primeros i'', la respuesta sí sería la última casilla.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'Si la entrada del Edificio es [10, 5, 8], ¿cuál es la salida?', NULL, '{"options":[{"id":"a","text":"23"},{"id":"b","text":"18"},{"id":"c","text":"10"},{"id":"d","text":"15"}]}', '{"option_id":"a"}', 'Ordenado queda [5, 8, 10] y los tres van en orden creciente, así que la torre los usa todos: 5 + 8 + 10 = 23.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Con pisos [5, 7, -2, 6, 9, -3, 8] la respuesta es 35, no 30. ¿Por qué?', NULL, '{"options":[{"id":"a","text":"Porque conviene dejar fuera los negativos: 5+6+7+8+9 da más que usarlos todos"},{"id":"b","text":"Porque los negativos no se pueden ordenar"},{"id":"c","text":"Porque la torre solo admite cinco pisos"},{"id":"d","text":"Porque 30 sería la respuesta si no se ordenara"}]}', '{"option_id":"a"}', 'Usarlos todos da -3-2+5+6+7+8+9 = 30. El max() de la transición permite EMPEZAR DE NUEVO en vez de apilarse sobre lo anterior, y ahí está la ganancia: 35. Si el problema fuera ''usa todos los que puedas'', no habría nada que optimizar.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En Monedas, ¿por qué dp[0] = 1 y no 0?', NULL, '{"options":[{"id":"a","text":"Es el caso base: hay exactamente una forma de armar 0, no usar ninguna moneda"},{"id":"b","text":"Para que el índice 0 no quede vacío"},{"id":"c","text":"Porque siempre existe la moneda de 1¢"},{"id":"d","text":"Es indiferente, el resultado es el mismo"}]}', '{"option_id":"a"}', 'Cada casilla se construye sumando desde otra anterior. Con dp[0] = 0 toda la tabla quedaría en ceros: no habría de dónde partir.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'La ÚNICA diferencia real entre el código de Monedas y el de Cintas es:', NULL, '{"options":[{"id":"a","text":"La dirección del ciclo interno: adelante permite repetir, atrás no"},{"id":"b","text":"Que uno usa max() y el otro suma"},{"id":"c","text":"El tamaño de la tabla dp"},{"id":"d","text":"Que Cintas necesita ordenar las pistas"}]}', '{"option_id":"a"}', 'Hacia adelante, dp[m - x] ya fue actualizado en esta misma pasada y por eso el elemento se puede repetir. Hacia atrás, esa casilla todavía no incluye el elemento, así que entra máximo una vez.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'Cintas mal hecho: el ciclo va hacia ADELANTE. ¿Qué imprime?', 'duraciones = [3]
total = 6
dp = [0] * (total + 1)

for d in duraciones:
    for m in range(d, total + 1):        # adelante, deberia ser atras
        dp[m] = max(dp[m], dp[m - d] + d)

print(dp[total])', '{"options":[{"id":"a","text":"6"},{"id":"b","text":"3"},{"id":"c","text":"0"},{"id":"d","text":"9"}]}', '{"option_id":"a"}', 'En m=6 consulta dp[3], que YA fue actualizado en esta misma pasada con la pista de 3 minutos. Resultado: la misma pista se grabó dos veces. Con el ciclo hacia atrás daría 3, que es lo correcto.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este Edificio devuelve un resultado menor del que debería. ¿En qué línea está el error?', NULL, '{"lines":["pisos_ordenados = sorted(pisos)","dp = pisos_ordenados[:]","for i in range(1, len(pisos_ordenados)):","    for j in range(i):","        if pisos_ordenados[j] < pisos_ordenados[i]:","            dp[i] = max(dp[i], dp[j] + pisos_ordenados[i])","return dp[-1]"]}', '{"line_number":7}', 'dp[i] es la altura de la torre que TERMINA en i, así que la respuesta es max(dp). Devolver la última casilla asume que la mejor torre termina en el piso más grande, y eso no siempre pasa.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa las dos versiones. La diferencia es una sola cosa.', NULL, '{"code":"# Monedas: se puede repetir la misma moneda\nfor moneda in monedas:\n    for m in range(moneda, cantidad + 1):\n        dp[m] ___1___ dp[m - moneda]\n\n# Cintas: cada pista una sola vez\nfor duracion in duraciones:\n    for m in range(total, duracion - 1, ___2___):\n        dp[m] = max(dp[m], dp[m - duracion] + duracion)","blanks":[{"id":"1","pista":"contar formas: se acumulan"},{"id":"2","pista":"el paso que hace que el ciclo vaya al revés"}]}', '{"answers":{"1":["+="],"2":["-1"]}}', 'Monedas cuenta formas, así que acumula con +=. Cintas maximiza, así que usa max(). Y el -1 del range es lo que hace el recorrido hacia atrás: sin él, cada pista se usaría varias veces.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el corazón de la DP del Edificio.', NULL, '{"code":"for i in range(1, n):\n    for j in range(i):\n        if ___1___:\n            dp[i] = max(dp[i], ___2___)","blanks":[{"id":"1","pista":"el piso de abajo tiene que ser estrictamente menor"},{"id":"2","pista":"la mejor torre que termina en j, más este piso"}]}', '{"answers":{"1":["pisos_ordenados[j] < pisos_ordenados[i]"],"2":["dp[j] + pisos_ordenados[i]"]}}', 'La comparación implementa ''estrictamente creciente'': con <= aceptaría pisos iguales. Y la transición es la decisión clave: quedarse solo, o apilarse sobre la mejor torre que termina en j.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la complejidad del Edificio?', NULL, '{"options":[{"id":"a","text":"O(N²)"},{"id":"b","text":"O(N)"},{"id":"c","text":"O(N log N)"},{"id":"d","text":"O(2^N)"}]}', '{"option_id":"a"}', 'Dos ciclos anidados sobre los pisos: por cada i se miran todos los j anteriores. El sorted() aporta N log N, que queda absorbido por el N².', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Con monedas [5, 1] y cantidad 6, ¿cuántas formas hay?', NULL, '{"options":[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"1"},{"id":"d","text":"6"}]}', '{"option_id":"a"}', 'Solo dos: 5+1, o seis monedas de 1. El orden no cuenta como forma distinta, por eso 1+5 no se suma aparte.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma la mochila 0/1 de las Cintas', NULL, '{"lines":[{"id":"k1","text":"dp = [0] * (minutos_totales + 1)","indent":0},{"id":"k2","text":"for duracion in duraciones:","indent":0},{"id":"k3","text":"for m in range(minutos_totales, duracion - 1, -1):","indent":1},{"id":"k4","text":"dp[m] = max(dp[m], dp[m - duracion] + duracion)","indent":2},{"id":"k5","text":"return dp[minutos_totales]","indent":0}]}', '{"order":["k1","k2","k3","k4","k5"]}', 'El ciclo de las pistas va por fuera y el de la cinta por dentro, hacia atrás. Invertirlos rompe la garantía de usar cada pista una sola vez.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'avanzado';

-- ── Capítulo 8: Greedy y simulación (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 8, 'Greedy y simulación', '🎯', 'Cuándo la decisión codiciosa es correcta, y cuándo toca simular.', '<p class="jc-gancho">Greedy es la técnica más corta de escribir y la más fácil de equivocar. Tomas la mejor opción local y sigues, sin volver atrás. Cuando funciona, el código son cinco líneas. Cuando no, produce una respuesta bonita y equivocada — y el juez no te dice cuál de las dos cosas pasó.</p>

<h2>💡 Las dos técnicas del módulo</h2>

<table>
  <thead><tr><th></th><th>Greedy</th><th>Simulación</th></tr></thead>
  <tbody>
    <tr><td>Qué hace</td><td>Decide con una regla y nunca se arrepiente</td><td>Sigue las reglas del enunciado, paso por paso</td></tr>
    <tr><td>Lo difícil</td><td><strong>Demostrar</strong> que la regla es correcta</td><td>No equivocarse en un detalle</td></tr>
    <tr><td>Se reconoce por</td><td>"mínimo", "máximo", "el mejor"</td><td>"cuántos caben", "cuántos pasos", "qué queda al final"</td></tr>
  </tbody>
</table>

<p>Las dos son lo contrario de backtracking y DP: aquí <strong>no se explora</strong>. Hay un solo camino y se recorre una vez.</p>

<h2>🔍 Cuándo funciona greedy (y cuándo no)</h2>

<p>Greedy es correcto cuando la decisión localmente óptima <strong>nunca cierra la puerta</strong> a la solución global. Eso hay que argumentarlo, no suponerlo.</p>

<h3>El contraejemplo que hay que tener siempre a la mano</h3>

<p>Dar cambio de <strong>6</strong> con monedas de <strong>{1, 3, 4}</strong>:</p>

<table>
  <thead><tr><th>Estrategia</th><th>Elige</th><th>Monedas</th></tr></thead>
  <tbody>
    <tr><td>Greedy (la más grande que quepa)</td><td>4 + 1 + 1</td><td><b>3</b></td></tr>
    <tr><td>Óptimo</td><td>3 + 3</td><td><b>2</b></td></tr>
  </tbody>
</table>

<p>El mismo problema con monedas {1, 5, 10, 25} sí funciona con greedy. La técnica no depende solo del problema: <strong>depende de los datos</strong>. Por eso, antes de escribir greedy, se busca un contraejemplo pequeño. Si aparece, toca DP.</p>

<blockquote>Regla práctica: si no sabes <em>por qué</em> tu greedy es correcto, no es que sea correcto — es que todavía no encontraste el caso donde falla.</blockquote>

<h2>📖 Problema 1 — Vito''s Family</h2>

<div class="jc-problema">

<h3>Vito''s Family</h3>
<p><em>Basado en Vito''s Family</em></p>

<p><strong>Descripción.</strong> La familia de Vito vive en una calle donde las casas están numeradas. Los parientes viven en las posiciones s₁, s₂, …, sₙ. Vito quiere escoger <strong>una</strong> posición X donde vivir que minimice la suma total de distancias a todos sus parientes:</p>

<pre><code>Σ |X − sᵢ|</code></pre>

<p><strong>Entrada.</strong> Una línea con las posiciones, separadas por espacios.</p>

<p><strong>Salida.</strong> Un entero: la suma mínima de distancias.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>2 6 4</code></td><td><code>4</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> Viviendo en la posición 4: |4−2| + |4−4| + |4−6| = 2 + 0 + 2 = 4.</p>

</div>

<h3>El teorema que resuelve todo</h3>

<p><strong>La mediana minimiza la suma de distancias absolutas.</strong> No hay que probar posiciones: se ordena y se toma el elemento del centro.</p>

<table>
  <thead><tr><th>Qué minimizas</th><th>Con qué</th></tr></thead>
  <tbody>
    <tr><td>Σ |X − sᵢ| — distancias</td><td>La <strong>mediana</strong></td></tr>
    <tr><td>Σ (X − sᵢ)² — cuadrados</td><td>La <strong>media</strong></td></tr>
  </tbody>
</table>

<p><strong>Por qué.</strong> Párate en cualquier punto y muévete un metro a la derecha. Te alejas un metro de cada pariente que quedó a la izquierda, y te acercas un metro de cada uno que está a la derecha. Mientras haya más gente a la derecha que a la izquierda, moverte <em>mejora</em> la suma. El punto donde deja de mejorar es exactamente aquel donde hay la misma cantidad a cada lado: la mediana.</p>

<p>Ese razonamiento es la parte importante del problema. El código son cuatro líneas.</p>

<h3>Código</h3>

<pre><code>linea = input()
posiciones = [int(x) for x in linea.split()]

posiciones.sort()
mediana = posiciones[len(posiciones) // 2]

suma = 0
for p in posiciones:
    suma += abs(mediana - p)

print(suma)</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué</th></tr></thead>
  <tbody>
    <tr><td><code>.sort()</code></td><td>Sin ordenar, "el del centro" no significa nada</td></tr>
    <tr><td><code>len // 2</code></td><td>Con n impar da el centro exacto</td></tr>
    <tr><td><code>abs()</code></td><td>La distancia no tiene signo</td></tr>
  </tbody>
</table>

<p>Con n <strong>par</strong> hay dos candidatos a mediana, y <em>cualquiera de los dos —y todo lo que hay entre ellos— da la misma suma</em>. Con <code>[1, 2, 3, 4]</code>: vivir en 2 da 1+0+1+2 = 4, y vivir en 3 da 2+1+0+1 = 4. Por eso <code>len // 2</code> sirve sin caso especial.</p>

<h3>La película con <code>2 6 4</code></h3>

<table>
  <thead><tr><th>Paso</th><th>Estado</th></tr></thead>
  <tbody>
    <tr><td>Leer</td><td><code>[2, 6, 4]</code></td></tr>
    <tr><td>Ordenar</td><td><code>[2, 4, 6]</code></td></tr>
    <tr><td>Mediana</td><td><code>posiciones[1]</code> = <b>4</b></td></tr>
    <tr><td>Sumar</td><td>|4−2| + |4−4| + |4−6| = 2 + 0 + 2 = <b>4</b></td></tr>
  </tbody>
</table>

<p>Compruébalo a mano: X=3 da 5, X=5 da 5. El 4 es el mínimo.</p>

<h2>📖 Problema 2 — Canada Goose</h2>

<div class="jc-problema">

<h3>Canada Goose</h3>
<p><em>Simulación</em></p>

<p><strong>Descripción.</strong> Se quieren construir edificios en fila sobre un terreno de longitud <code>L</code>. Cada edificio ocupa <code>H</code> metros y necesita un espacio mínimo de <code>S</code> metros entre él y el siguiente. ¿Cuántos edificios caben?</p>

<p><strong>Entrada.</strong> Tres enteros <code>L</code>, <code>H</code> y <code>S</code> en una línea.</p>

<p><strong>Salida.</strong> El número máximo de edificios que caben.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>50 15 5</code></td><td><code>2</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> El primero ocupa de 0 a 15; el segundo, de 20 a 35. Un tercero empezaría en 40 y terminaría en 55, que se pasa de 50.</p>

</div>

<h3>Aquí no hay técnica: hay reglas</h3>

<p>No es DP, no es recursión, no hay nada que optimizar. Se ponen edificios mientras quepan. La única decisión de diseño es <strong><code>while</code> y no <code>for</code></strong>: no se sabe de antemano cuántas vueltas van a ser.</p>

<pre><code>datos = input().split()
L = int(datos[0])
H = int(datos[1])
S = int(datos[2])

edificios = 0
pos = 0

while pos + H &lt;= L:      # ¿cabe otro edificio desde aquí?
    edificios += 1
    pos += H + S         # avanza el edificio Y su separación

print(edificios)</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué</th></tr></thead>
  <tbody>
    <tr><td><code>pos + H &lt;= L</code></td><td>La pregunta exacta: ¿el edificio termina dentro del terreno?</td></tr>
    <tr><td><code>&lt;=</code> y no <code>&lt;</code></td><td>Un edificio que termina justo en el borde sí cabe</td></tr>
    <tr><td><code>pos += H + S</code></td><td>El siguiente arranca después del edificio <em>y</em> de la separación</td></tr>
    <tr><td>La separación no se resta al final</td><td>Después del último edificio no hace falta espacio: por eso la condición mira solo <code>H</code></td></tr>
  </tbody>
</table>

<h3>La película con <code>50 15 5</code></h3>

<table>
  <thead><tr><th>Vuelta</th><th>pos</th><th>pos + H</th><th>¿≤ 50?</th><th>edificios</th><th>pos nueva</th></tr></thead>
  <tbody>
    <tr><td>1</td><td>0</td><td>15</td><td>sí</td><td>1</td><td>20</td></tr>
    <tr><td>2</td><td>20</td><td>35</td><td>sí</td><td>2</td><td>40</td></tr>
    <tr><td>3</td><td>40</td><td>55</td><td><b>no</b></td><td>—</td><td>sale del ciclo</td></tr>
  </tbody>
</table>

<p>Resultado: <strong>2</strong>. Fíjate en que el caso <code>H &gt; L</code> no necesita tratamiento aparte: la condición del <code>while</code> es falsa desde la primera vuelta y el programa imprime 0.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Confundir mediana con media</h3>
<pre><code>mediana = sum(posiciones) / len(posiciones)   # ❌ eso es el promedio</code></pre>
<p>Con <code>[1, 2, 100]</code> el promedio es 34.33 y da una suma de 131,33; la mediana es 2 y da 99. La media minimiza los <strong>cuadrados</strong>, no las distancias.</p>

<h3>2. Tomar la mediana sin ordenar</h3>
<pre><code>mediana = posiciones[len(posiciones) // 2]    # ❌ falta el sort()</code></pre>
<p>Con <code>[2, 6, 4]</code> tomaría el 6 y daría 8 en vez de 4. El error es silencioso: el programa corre y da un número.</p>

<h3>3. Usar <code>for</code> en la simulación</h3>
<pre><code>for i in range(L // H):      # ❌ ignora la separación S</code></pre>
<p>Con <code>50 15 5</code> daría 3. Cuando no sabes cuántas vueltas son, el ciclo es <code>while</code>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Antes de escribir greedy, <strong>busca un contraejemplo pequeño</strong>. Si lo encuentras, era DP.</li>
  <li>Si el enunciado pide minimizar distancias absolutas, la respuesta es la mediana. Si pide cuadrados, la media.</li>
  <li>Ordenar es casi siempre el primer paso de un greedy.</li>
  <li>En simulación no optimices: traduce las reglas del enunciado tal cual, una línea por regla.</li>
  <li>Si no sabes cuántas vueltas dará el ciclo, es <code>while</code>.</li>
  <li>Traza el ejemplo del enunciado a mano antes de enviar. En simulación, los errores son de <code>&lt;</code> contra <code>&lt;=</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>lista.sort()</code></td><td>Ordena en el sitio; casi todo greedy empieza aquí</td></tr>
    <tr><td><code>lista[len(lista) // 2]</code></td><td>La mediana, <strong>ya ordenada</strong></td></tr>
    <tr><td><code>abs(a - b)</code></td><td>Distancia entre dos posiciones</td></tr>
    <tr><td><code>sum(l) / len(l)</code></td><td>La media — minimiza cuadrados, <em>no</em> distancias</td></tr>
    <tr><td><code>while condicion:</code></td><td>Repetir sin saber cuántas veces</td></tr>
    <tr><td><code>pos += H + S</code></td><td>Avanzar en una simulación de ocupación</td></tr>
  </tbody>
</table>

<blockquote>Greedy que no sabes demostrar es una apuesta. A veces la ganas, y eso es lo peligroso: aprendes que la técnica funciona justo antes del problema donde no.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 4 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 8 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Vito''s Family', 'medio', '<p>Los parientes de Vito viven en las posiciones que trae la entrada, separadas por espacio. Escoge la posición X que minimice la suma de distancias <code>Σ|X − sᵢ|</code> e imprime esa suma mínima.</p><pre><code>Entrada:
2 6 4

Salida:
4</code></pre><p>Viviendo en la 4: |4−2| + |4−4| + |4−6| = 4.</p>', '<p>No pruebes todas las posiciones. La <strong>mediana</strong> minimiza la suma de distancias absolutas: ordena y toma <code>posiciones[len(posiciones) // 2]</code>.</p>', '<pre><code>''''''
Programa: Vito''s Family
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Encuentra la suma minima de distancias a un conjunto de posiciones
    en una calle, usando el teorema de la mediana.
''''''


def suma_minima(posiciones):
    ''''''
    Calcula la minima suma de distancias absolutas a todas las casas.

    Parametros:
        posiciones (list): numeros de casa de los parientes

    Retorna:
        int: la suma minima
    ''''''
    # Sin ordenar, ''el del centro'' no significa nada
    posiciones.sort()

    # TEOREMA: la mediana minimiza la suma de distancias absolutas.
    # No hay que probar posiciones: se toma el elemento central
    mediana = posiciones[len(posiciones) // 2]

    suma = 0
    for p in posiciones:
        # abs porque la distancia no tiene signo: da igual si el
        # pariente vive a la izquierda o a la derecha
        suma += abs(mediana - p)

    return suma


# Inicio
posiciones = [int(x) for x in input().split()]
print(suma_minima(posiciones))
# Fin</code></pre><p>Todo el problema es el teorema. <strong>La mediana minimiza Σ|X − sᵢ|; la media minimiza Σ(X − sᵢ)².</strong> Son cosas distintas y confundirlas es el error clásico: con <code>[1, 2, 100]</code> el promedio es 34,33 y da 131,33, mientras que la mediana es 2 y da 99.</p><p><strong>Por qué la mediana.</strong> Párate en cualquier punto y muévete un metro a la derecha: te alejas un metro de cada pariente que quedó a la izquierda y te acercas un metro de cada uno que está a la derecha. Mientras haya más gente a la derecha, moverte mejora la suma. Donde deja de mejorar es donde hay la misma cantidad a cada lado — la mediana.</p><p><strong>Con n par</strong> hay dos candidatos, y cualquiera de los dos (y todo lo que hay entre ellos) da la misma suma: con <code>[1,2,3,4]</code>, vivir en 2 da 4 y vivir en 3 también. Por eso <code>len // 2</code> no necesita un caso especial.</p><p>Compáralo con la fuerza bruta: probar todas las posiciones sería O(rango × N). Aquí es O(N log N) por el sort, y ese log N se lo lleva todo.</p>', '[{"stdin":"2 6 4\n","expected_output":"4\n"},{"stdin":"1 2 3 4 5\n","expected_output":"6\n"},{"stdin":"1 2 3 4\n","expected_output":"4\n"},{"stdin":"7\n","expected_output":"0\n"},{"stdin":"10 10 10\n","expected_output":"0\n"},{"stdin":"1 100\n","expected_output":"99\n"},{"stdin":"2 4 6 8 10 12\n","expected_output":"18\n"}]', '''''''
Programa: Vito''s Family
Autor:
Fecha:
Descripcion:
''''''


def suma_minima(posiciones):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Canada Goose', 'facil', '<p>Sobre un terreno en fila de longitud <code>L</code> se quieren construir edificios. Cada edificio ocupa <code>H</code> metros y necesita <code>S</code> metros de separación con el siguiente. ¿Cuántos caben?</p><pre><code>Entrada:
50 15 5

Salida:
2</code></pre><p>El primero va de 0 a 15, el segundo de 20 a 35. Un tercero terminaría en 55 y se pasa.</p>', '<p>Simulación pura: una posición y un contador. Mientras <code>pos + H &lt;= L</code>, cuenta un edificio y avanza <code>pos += H + S</code>. Con <code>while</code>, porque no sabes cuántas vueltas serán.</p>', '<pre><code>''''''
Programa: Canada Goose
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta cuantos edificios de ancho H, separados S metros entre si,
    caben en un terreno de longitud L. Simulacion con while.
''''''


def cuantos_caben(longitud, ancho, separacion):
    ''''''
    Cuenta los edificios que caben en el terreno.

    Parametros:
        longitud (int): largo total del terreno
        ancho (int): metros que ocupa cada edificio
        separacion (int): metros minimos entre un edificio y el siguiente

    Retorna:
        int: cantidad maxima de edificios
    ''''''
    edificios = 0
    pos = 0     # donde empieza el proximo edificio

    # WHILE y no FOR: la cantidad de vueltas es justamente la respuesta,
    # asi que no se puede poner en un range
    while pos + ancho <= longitud:
        edificios += 1

        # El siguiente arranca despues del edificio Y de su separacion
        pos += ancho + separacion

    return edificios


# Inicio
datos = input().split()
L = int(datos[0])
H = int(datos[1])
S = int(datos[2])

print(cuantos_caben(L, H, S))
# Fin</code></pre><p>Aquí no hay técnica que descubrir: hay reglas que traducir. Toda la dificultad está en los detalles.</p><ul><li><strong><code>&lt;=</code> y no <code>&lt;</code>.</strong> Un edificio que termina justo en el borde sí cabe. Este es el error típico de las simulaciones, y el que hace que la respuesta se salga por uno.</li><li><strong>La separación se suma al avanzar, no a la condición.</strong> Después del <em>último</em> edificio no hace falta espacio libre — por eso la pregunta es <code>pos + H &lt;= L</code> y no <code>pos + H + S &lt;= L</code>.</li><li><strong>El caso <code>H &gt; L</code> no necesita un if.</strong> La condición del while es falsa desde la primera vuelta y el programa imprime 0 solo.</li><li><strong><code>L // H</code> no sirve.</strong> Con 50, 15, 5 daría 3 porque ignora la separación. La división entera solo funcionaría si S fuera 0.</li></ul><p>La traza con <code>50 15 5</code>: pos=0 cabe (15≤50) → 1 edificio, pos=20; pos=20 cabe (35≤50) → 2 edificios, pos=40; pos=40 no cabe (55&gt;50) → sale. Respuesta <strong>2</strong>.</p>', '[{"stdin":"50 15 5\n","expected_output":"2\n"},{"stdin":"30 15 5\n","expected_output":"1\n"},{"stdin":"100 20 10\n","expected_output":"3\n"},{"stdin":"10 15 5\n","expected_output":"0\n"},{"stdin":"15 15 5\n","expected_output":"1\n"},{"stdin":"7 3 0\n","expected_output":"2\n"},{"stdin":"1000 1 1\n","expected_output":"500\n"}]', '''''''
Programa: Canada Goose
Autor:
Fecha:
Descripcion:
''''''


def cuantos_caben(longitud, ancho, separacion):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'El greedy que falla', 'medio', '<p>Dar cambio con el mínimo número de monedas, de dos maneras, para ver dónde se rompe greedy.</p><p>La entrada trae la cantidad en la primera línea y las denominaciones en la segunda.</p><pre><code>Entrada:
6
1 3 4

Salida:
3 2</code></pre><p>Primero el resultado del <strong>greedy</strong> (tomar siempre la moneda más grande que quepa) y después el <strong>óptimo</strong> real. Aquí greedy da 4+1+1 = 3 monedas, pero 3+3 = 2 era mejor.</p><p>Puedes asumir que siempre existe la moneda de 1, así que siempre hay solución.</p>', '<p>El greedy: ordena las monedas de mayor a menor y ve restando. El óptimo: una tabla <code>dp[c]</code> = mínimo de monedas para la cantidad <code>c</code>, llenada de 0 hasta la cantidad pedida.</p>', '<pre><code>''''''
Programa: Cambio greedy contra cambio optimo
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Compara la estrategia codiciosa con la solucion optima por
    programacion dinamica, para ver cuando greedy se equivoca.
''''''


def cambio_greedy(cantidad, monedas):
    ''''''
    Da el cambio tomando siempre la moneda mas grande que quepa.

    Parametros:
        cantidad (int): total a completar
        monedas (list): denominaciones disponibles

    Retorna:
        int: cuantas monedas usa esta estrategia
    ''''''
    # De mayor a menor: la regla codiciosa es ''la mas grande que quepa''
    ordenadas = sorted(monedas, reverse=True)

    usadas = 0
    restante = cantidad

    for m in ordenadas:
        # Se toman todas las que quepan de esta denominacion y NO se
        # vuelve atras. Ahi esta el riesgo del greedy
        usadas += restante // m
        restante = restante % m

    return usadas


def cambio_optimo(cantidad, monedas):
    ''''''
    Da el cambio minimo real, probando todas las combinaciones con DP.

    Parametros:
        cantidad (int): total a completar
        monedas (list): denominaciones disponibles

    Retorna:
        int: el minimo numero de monedas posible
    ''''''
    # dp[c] = minimo de monedas para armar exactamente c.
    # El infinito marca ''todavia no se sabe si se puede''
    infinito = cantidad + 1
    dp = [infinito] * (cantidad + 1)
    dp[0] = 0     # armar 0 no cuesta ninguna moneda

    for c in range(1, cantidad + 1):
        for m in monedas:
            # Solo sirve si la moneda cabe y si el resto era alcanzable
            if m <= c and dp[c - m] + 1 < dp[c]:
                dp[c] = dp[c - m] + 1

    return dp[cantidad]


# Inicio
cantidad = int(input())
monedas = [int(x) for x in input().split()]

print(cambio_greedy(cantidad, monedas), cambio_optimo(cantidad, monedas))
# Fin</code></pre><p>Este ejercicio existe para una sola cosa: <strong>ver con tus propios ojos que greedy puede estar equivocado y no avisar</strong>.</p><p>Con monedas <code>{1, 3, 4}</code> y cantidad 6, greedy toma el 4 —la más grande que cabe— y se queda atrapado con un 2 que solo puede pagar con dos monedas de 1. La solución de 3+3 nunca la considera, porque <strong>nunca vuelve atrás</strong>. Con <code>{1, 5, 10, 25}</code>, en cambio, los dos resultados coinciden siempre.</p><ul><li><strong>La diferencia de costo.</strong> El greedy es O(N log N) por el sort; la DP es O(cantidad × N). La DP siempre acierta, pero paga por ello.</li><li><strong>El <code>infinito = cantidad + 1</code>.</strong> Ninguna solución real puede usar más monedas que la cantidad misma (con monedas de 1), así que ese valor funciona como "imposible" sin importar <code>float(''inf'')</code>.</li><li><strong><code>dp[0] = 0</code> es el caso base.</strong> Sin él la tabla entera queda en infinito y nada se puede construir.</li></ul><p>La lección práctica: antes de escribir un greedy, busca un contraejemplo pequeño. Si lo encuentras, el problema era DP.</p>', '[{"stdin":"6\n1 3 4\n","expected_output":"3 2\n"},{"stdin":"30\n1 5 10 25\n","expected_output":"2 2\n"},{"stdin":"8\n1 4 5\n","expected_output":"4 2\n"},{"stdin":"0\n1 2 5\n","expected_output":"0 0\n"},{"stdin":"7\n1 2 5\n","expected_output":"2 2\n"}]', '''''''
Programa: Cambio greedy contra cambio optimo
Autor:
Fecha:
Descripcion:
''''''


def cambio_greedy(cantidad, monedas):
    pass


def cambio_optimo(cantidad, monedas):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué minimiza la suma de distancias absolutas Σ|X − sᵢ|?', NULL, '{"options":[{"id":"a","text":"La mediana"},{"id":"b","text":"La media (el promedio)"},{"id":"c","text":"El valor más grande"},{"id":"d","text":"El valor más pequeño"}]}', '{"option_id":"a"}', 'La media minimiza los cuadrados, Σ(X−sᵢ)². Con [1, 2, 100] la media es 34,33 y da 131,33; la mediana es 2 y da 99. Confundirlas es el error clásico de este problema.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', 'En Vito''s Family con [1, 2, 3, 4, 5], ¿cuál es la mediana?', NULL, '{"options":[{"id":"a","text":"3"},{"id":"b","text":"2"},{"id":"c","text":"4"},{"id":"d","text":"15"}]}', '{"option_id":"a"}', 'Cinco elementos ordenados: el del centro es posiciones[5 // 2] = posiciones[2] = 3. La suma de distancias queda 2+1+0+1+2 = 6.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Para dar cambio de 6 con monedas de {1, 3, 4}, greedy toma la más grande que quepa. ¿Qué pasa?', NULL, '{"options":[{"id":"a","text":"Da 3 monedas (4+1+1), pero el óptimo son 2 (3+3): greedy falla"},{"id":"b","text":"Da el óptimo, 2 monedas"},{"id":"c","text":"No termina"},{"id":"d","text":"Da 6 monedas de 1"}]}', '{"option_id":"a"}', 'El mismo problema con {1, 5, 10, 25} sí funciona con greedy. La técnica depende de los datos, no solo del enunciado: por eso siempre se busca un contraejemplo pequeño antes de escribirla.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En Canada Goose, ¿por qué el ciclo es while y no for?', NULL, '{"options":[{"id":"a","text":"Porque no se sabe de antemano cuántas iteraciones van a ser"},{"id":"b","text":"Porque es más rápido"},{"id":"c","text":"Porque for no permite contar"},{"id":"d","text":"Porque hay que recorrer una lista"}]}', '{"option_id":"a"}', 'La cantidad de edificios es justamente la respuesta: no se puede poner en un range. Un for con range(L // H) además ignoraría la separación S.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Con L=100, H=20, S=10, ¿cuántos edificios caben?', NULL, '{"options":[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"2"}]}', '{"option_id":"a"}', 'Ocupan 0–20, 30–50 y 60–80. El cuarto empezaría en 90 y terminaría en 110, que se pasa de 100. Contestar 4 es olvidar que el último también necesita caber entero.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'L, H, S = 30, 15, 5
edificios = 0
pos = 0
while pos + H <= L:
    edificios += 1
    pos += H + S
print(edificios)', '{"options":[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"0"},{"id":"d","text":"3"}]}', '{"option_id":"a"}', 'Primera vuelta: 0+15 ≤ 30, se cuenta y pos pasa a 20. Segunda: 20+15 = 35 > 30, sale. Solo 1. Con 30 // 15 daría 2, pero eso ignora los 5 metros de separación.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Este programa da 8 en vez de 4 con la entrada ''2 6 4''. ¿En qué línea está el error?', NULL, '{"lines":["posiciones = [int(x) for x in input().split()]","mediana = posiciones[len(posiciones) // 2]","suma = 0","for p in posiciones:","    suma += abs(mediana - p)","print(suma)"]}', '{"line_number":2}', 'Falta ordenar antes. Sin sort(), posiciones[1] es el 6 y no el 4, y la suma da 4+0+2 = 8. El error es silencioso: el programa corre y entrega un número.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la solución de Vito''s Family.', NULL, '{"code":"posiciones = [int(x) for x in input().split()]\n\nposiciones.___1___()\nmediana = posiciones[___2___]\n\nsuma = 0\nfor p in posiciones:\n    suma += ___3___(mediana - p)\n\nprint(suma)","blanks":[{"id":"1","pista":"primer paso de casi todo greedy"},{"id":"2","pista":"el del centro"},{"id":"3","pista":"la distancia no tiene signo"}]}', '{"answers":{"1":["sort"],"2":["len(posiciones) // 2"],"3":["abs"]}}', 'Ordenar, tomar el del centro, sumar distancias. Sin el sort, el índice del centro no significa nada.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la simulación de Canada Goose.', NULL, '{"code":"edificios = 0\npos = 0\n\nwhile pos + H ___1___ L:\n    edificios += 1\n    pos += ___2___\n\nprint(edificios)","blanks":[{"id":"1","pista":"uno que termina justo en el borde sí cabe"},{"id":"2","pista":"el edificio Y su separación"}]}', '{"answers":{"1":["<="],"2":["H + S"]}}', 'Con < se perdería el edificio que termina exactamente en L. Y avanzar solo H olvidaría la separación obligatoria hacia el siguiente.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'facil', 'Arma la simulación de Canada Goose', NULL, '{"lines":[{"id":"g1","text":"edificios = 0","indent":0},{"id":"g2","text":"pos = 0","indent":0},{"id":"g3","text":"while pos + H <= L:","indent":0},{"id":"g4","text":"edificios += 1","indent":1},{"id":"g5","text":"pos += H + S","indent":1},{"id":"g6","text":"print(edificios)","indent":0}]}', '{"order":["g1","g2","g3","g4","g5","g6"]}', 'Contador y posición antes del ciclo; dentro, contar y avanzar. El caso H > L no necesita línea aparte: la condición es falsa desde la primera vuelta e imprime 0.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'En Vito''s Family con una cantidad PAR de parientes, ¿qué pasa?', NULL, '{"options":[{"id":"a","text":"Las dos medianas —y todo lo que hay entre ellas— dan la misma suma"},{"id":"b","text":"Hay que promediar las dos medianas"},{"id":"c","text":"El problema no tiene solución"},{"id":"d","text":"Hay que probar todas las posiciones"}]}', '{"option_id":"a"}', 'Con [1,2,3,4]: vivir en 2 da 1+0+1+2 = 4, y vivir en 3 da 2+1+0+1 = 4. Por eso len // 2 funciona sin caso especial.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'avanzado';

-- ── Capítulo 9: Kadane (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 9, 'Kadane', '📈', 'La mejor racha contigua: programación dinámica con dos variables.', '<p class="jc-gancho">Toda la programación dinámica del módulo 7 necesitaba una tabla. Este algoritmo resuelve un problema del mismo tipo con <strong>dos variables</strong> y una sola pasada. Es la versión más elegante de la misma pregunta: <em>¿cuál es la mejor solución que termina exactamente aquí?</em></p>

<h2>📖 El problema</h2>

<div class="jc-problema">

<h3>Máxima subsecuencia contigua</h3>

<p><strong>Descripción.</strong> Dado un arreglo con números positivos y negativos, encuentra la <strong>suma máxima</strong> de una subsecuencia <strong>contigua</strong> — elementos consecutivos, sin saltarse ninguno del medio.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody>
    <tr>
      <td><code>-2 1 -3 4 -1 2 1 -5 4</code></td>
      <td><code>6</code> — la racha <code>[4, -1, 2, 1]</code></td>
    </tr>
  </tbody>
</table>

</div>

<p>Ojo con la palabra <strong>contigua</strong>. Si pudieras escoger elementos sueltos, la respuesta sería trivial: sumar todos los positivos. Aquí, si te llevas el 4 y el 2, te tienes que llevar también el −1 que está en medio.</p>

<h2>💡 Análisis y estrategia</h2>

<h3>La solución ingenua y por qué no sirve</h3>

<p>Probar todas las subsecuencias: para cada inicio, todos los finales. Son <code>O(N²)</code> pares y sumar cada uno lo lleva a <code>O(N³)</code>, o <code>O(N²)</code> si acumulas. Con 100.000 elementos, ninguna de las dos pasa.</p>

<h3>La pregunta que lo resuelve todo</h3>

<p>En cada posición hay <strong>una sola decisión</strong>:</p>

<blockquote>¿Me conviene <strong>seguir</strong> la racha que traigo, o <strong>empezar una nueva</strong> aquí mismo?</blockquote>

<p>Y la respuesta es aritmética pura: si lo que traes acumulado es negativo, arrastrarlo solo te resta. Mejor empezar de cero.</p>

<pre><code>max_actual = max(arr[i], max_actual + arr[i])</code></pre>

<table>
  <thead><tr><th>Opción</th><th>Significa</th></tr></thead>
  <tbody>
    <tr><td><code>arr[i]</code></td><td>Empezar una racha nueva justo aquí</td></tr>
    <tr><td><code>max_actual + arr[i]</code></td><td>Extender la racha que venía</td></tr>
  </tbody>
</table>

<h3>Dos variables, dos preguntas distintas</h3>

<p>Esta es la parte que más se confunde:</p>

<table>
  <thead><tr><th>Variable</th><th>Responde</th></tr></thead>
  <tbody>
    <tr><td><code>max_actual</code></td><td>¿Cuál es la mejor racha que <strong>termina en esta posición</strong>?</td></tr>
    <tr><td><code>max_global</code></td><td>¿Cuál es la mejor racha <strong>vista hasta ahora</strong>, termine donde termine?</td></tr>
  </tbody>
</table>

<p>La primera puede bajar; la segunda nunca. Por eso hacen falta las dos: <code>max_actual</code> es la que trabaja y <code>max_global</code> es la que recuerda.</p>

<h2>💻 Código paso a paso</h2>

<pre><code>def kadane(arr):
    if not arr:
        return 0

    max_actual = arr[0]
    max_global = arr[0]

    for i in range(1, len(arr)):
        max_actual = max(arr[i], max_actual + arr[i])
        max_global = max(max_global, max_actual)

    return max_global</code></pre>

<table>
  <thead><tr><th>Línea</th><th>Por qué está ahí</th></tr></thead>
  <tbody>
    <tr><td><code>max_actual = arr[0]</code></td><td>Se arranca con el primer elemento, <strong>no con 0</strong>. Con 0, un arreglo de puros negativos daría 0, y 0 no es una subsecuencia válida si hay que tomar al menos un elemento</td></tr>
    <tr><td><code>range(1, len(arr))</code></td><td>El elemento 0 ya se usó para inicializar</td></tr>
    <tr><td><code>max(arr[i], max_actual + arr[i])</code></td><td>La decisión: empezar de nuevo o seguir</td></tr>
    <tr><td><code>max(max_global, max_actual)</code></td><td>Guardar la mejor racha vista. Va <strong>después</strong> de actualizar <code>max_actual</code></td></tr>
  </tbody>
</table>

<h3>La película completa</h3>

<p>Con <code>[-2, 1, -3, 4, -1, 2, 1, -5, 4]</code>:</p>

<table>
  <thead>
    <tr><th>i</th><th>arr[i]</th><th>Decisión</th><th>max_actual</th><th>max_global</th></tr>
  </thead>
  <tbody>
    <tr><td>0</td><td>−2</td><td>inicio</td><td>−2</td><td>−2</td></tr>
    <tr><td>1</td><td>1</td><td><code>max(1, −1)</code> → <b>empieza de nuevo</b></td><td>1</td><td>1</td></tr>
    <tr><td>2</td><td>−3</td><td><code>max(−3, −2)</code> → sigue</td><td>−2</td><td>1</td></tr>
    <tr><td>3</td><td>4</td><td><code>max(4, 2)</code> → <b>empieza de nuevo</b></td><td>4</td><td>4</td></tr>
    <tr><td>4</td><td>−1</td><td><code>max(−1, 3)</code> → sigue</td><td>3</td><td>4</td></tr>
    <tr><td>5</td><td>2</td><td><code>max(2, 5)</code> → sigue</td><td>5</td><td>5</td></tr>
    <tr><td>6</td><td>1</td><td><code>max(1, 6)</code> → sigue</td><td>6</td><td><b>6</b></td></tr>
    <tr><td>7</td><td>−5</td><td><code>max(−5, 1)</code> → sigue</td><td>1</td><td>6</td></tr>
    <tr><td>8</td><td>4</td><td><code>max(4, 5)</code> → sigue</td><td>5</td><td>6</td></tr>
  </tbody>
</table>

<p>Resultado: <strong>6</strong>, la racha <code>[4, −1, 2, 1]</code>.</p>

<p>Fíjate en <code>i = 3</code>: traía <code>max_actual = −2</code> y el elemento es 4. Seguir daría 2; empezar de nuevo da 4. <strong>Ahí nace la racha ganadora.</strong> Un acumulado negativo siempre conviene botarlo.</p>

<h2>🔑 El concepto: DP sin tabla</h2>

<p>Kadane <strong>es</strong> programación dinámica. Compáralo con el Edificio del módulo 7:</p>

<table>
  <thead><tr><th></th><th>🏗️ Edificio</th><th>📈 Kadane</th></tr></thead>
  <tbody>
    <tr><td><code>dp[i]</code> significa</td><td>mejor torre que termina en <code>i</code></td><td>mejor racha que termina en <code>i</code></td></tr>
    <tr><td>Cómo se guarda</td><td>una tabla de N casillas</td><td><strong>una variable</strong></td></tr>
    <tr><td>Por qué</td><td>consulta cualquier <code>dp[j]</code> anterior</td><td>solo necesita la casilla <strong>inmediatamente</strong> anterior</td></tr>
    <tr><td>Respuesta final</td><td><code>max(dp)</code></td><td><code>max_global</code></td></tr>
    <tr><td>Complejidad</td><td><code>O(N²)</code> · memoria <code>O(N)</code></td><td><code>O(N)</code> · memoria <code>O(1)</code></td></tr>
  </tbody>
</table>

<blockquote>Cuando la transición de una DP solo mira <strong>un paso atrás</strong>, la tabla sobra: basta una variable. Ese cambio convierte O(N²) en O(N).</blockquote>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Inicializar en 0</h3>
<pre><code>max_actual = max_global = 0     # ❌ con puros negativos devuelve 0</code></pre>
<p>Con <code>[-1, -2, -3]</code> la respuesta correcta es <strong>−1</strong>: el menos malo. Devolver 0 equivale a decir "no tomo nada", y eso solo vale si el enunciado permite la subsecuencia vacía. Léelo con cuidado, porque las dos versiones existen.</p>

<h3>2. Actualizar <code>max_global</code> antes que <code>max_actual</code></h3>
<pre><code>max_global = max(max_global, max_actual)   # ❌ compara con el valor viejo
max_actual = max(arr[i], max_actual + arr[i])</code></pre>
<p>Se pierde la última racha. El orden es: primero decides, después guardas.</p>

<h3>3. Confundir contigua con cualquiera</h3>
<pre><code>return sum(x for x in arr if x &gt; 0)   # ❌ eso resuelve otro problema</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Pregúntate qué es "lo mejor que termina exactamente aquí".</li>
  <li>Si eso solo depende del paso anterior, cambia la tabla por una variable.</li>
  <li>Lleva aparte el mejor global: lo actual sube y baja, lo global no.</li>
  <li>Inicializa con el primer elemento, no con cero, salvo que el enunciado permita lo vacío.</li>
  <li>Un acumulado negativo se bota: nunca ayuda a lo que viene.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>max_actual = max(arr[i], max_actual + arr[i])</code></td><td>Seguir o empezar de nuevo</td></tr>
    <tr><td><code>max_global = max(max_global, max_actual)</code></td><td>Recordar la mejor racha</td></tr>
    <tr><td>Inicializar en <code>arr[0]</code></td><td>Funciona con puros negativos</td></tr>
    <tr><td>Inicializar en <code>0</code></td><td>Solo si se permite la subsecuencia vacía</td></tr>
    <tr><td>Complejidad</td><td><code>O(N)</code> tiempo, <code>O(1)</code> memoria</td></tr>
  </tbody>
</table>

<blockquote>Si lo que traes acumulado es negativo, déjalo ir. Esa frase de una línea es todo el algoritmo.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 4 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 9 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 9 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'La mejor racha', 'medio', '<p>Encuentra la suma máxima de una subsecuencia <strong>contigua</strong>. La entrada trae los números en una línea.</p><pre><code>Entrada:
-2 1 -3 4 -1 2 1 -5 4

Salida:
6</code></pre><p>Ojo con el caso de puros negativos: la respuesta es el <strong>menos malo</strong>, no cero. Aquí la subsecuencia tiene que tener al menos un elemento.</p>', '<p>Dos variables. En cada paso: <code>max(arr[i], max_actual + arr[i])</code> — empezar de nuevo o seguir. Inicializa con <code>arr[0]</code>, no con 0.</p>', '<pre><code>''''''
Programa: Maxima subsecuencia contigua (Kadane)
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Encuentra la mejor racha contigua en una sola pasada, con dos
    variables y sin tabla: O(N) tiempo, O(1) memoria.
''''''


def kadane(arr):
    ''''''
    Calcula la suma maxima de una subsecuencia contigua.

    Parametros:
        arr (list): numeros, pueden ser negativos

    Retorna:
        int: la mejor suma contigua
    ''''''
    if not arr:
        return 0

    # Se arranca con el primer elemento y NO con 0: asi, si todos son
    # negativos, la respuesta es el menos malo y no un cero inventado
    max_actual = arr[0]   # mejor racha que TERMINA en la posicion actual
    max_global = arr[0]   # mejor racha vista en todo el recorrido

    for i in range(1, len(arr)):
        # La unica decision del algoritmo: si lo acumulado es negativo,
        # arrastrarlo solo resta, asi que conviene empezar de nuevo
        max_actual = max(arr[i], max_actual + arr[i])

        # Va DESPUES: max_global tiene que ver el valor recien calculado
        max_global = max(max_global, max_actual)

    return max_global


# Inicio
numeros = [int(x) for x in input().split()]
print(kadane(numeros))
# Fin</code></pre><p>Todo el algoritmo cabe en una frase: <strong>si lo que traes acumulado es negativo, déjalo ir</strong>. Nada que venga después mejora por cargar un lastre.</p><p>Los dos detalles que deciden si está bien:</p><ul><li><strong>Inicializar en <code>arr[0]</code>.</strong> Con 0, un arreglo de puros negativos devuelve 0 — que significa "no tomo nada". Eso solo es correcto si el enunciado permite la subsecuencia vacía. Léelo: las dos versiones del problema existen y piden inicializaciones distintas.</li><li><strong>El orden dentro del ciclo.</strong> Primero se decide <code>max_actual</code>, después se guarda en <code>max_global</code>. Al revés, se compara contra el valor de la vuelta anterior y se pierde la racha del último elemento.</li></ul><p>Compáralo con el Edificio del módulo 7: la misma pregunta — <em>¿cuál es la mejor solución que termina aquí?</em> — pero como la transición solo mira un paso atrás, la tabla de N casillas se reduce a una variable.</p>', '[{"stdin":"-2 1 -3 4 -1 2 1 -5 4\n","expected_output":"6\n"},{"stdin":"3 -1 4 -1 2 1 -5 4\n","expected_output":"8\n"},{"stdin":"-1 -2 -3 -4\n","expected_output":"-1\n"},{"stdin":"1 2 3 4 5\n","expected_output":"15\n"},{"stdin":"5 -1 5 -1 5\n","expected_output":"13\n"},{"stdin":"-7\n","expected_output":"-7\n"}]', '''''''
Programa: Maxima subsecuencia contigua (Kadane)
Autor:
Fecha:
Descripcion:
''''''


def kadane(arr):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, '¿Dónde empieza y dónde termina?', 'dificil', '<p>Además de la suma, imprime <strong>en qué posiciones</strong> está la mejor racha.</p><pre><code>Entrada:
-2 1 -3 4 -1 2 1 -5 4

Salida:
6 3 6</code></pre><p>Es decir: suma 6, desde el índice 3 hasta el 6 (los elementos <code>4 -1 2 1</code>).</p><p>Si hay empate, quédate con la racha que aparece <strong>primero</strong>.</p>', '<p>Cuando el <code>max</code> escoge <code>arr[i]</code>, ahí empieza una racha nueva: guarda ese índice. Cuando <code>max_actual</code> supera a <code>max_global</code>, ahí cierras la mejor.</p>', '<pre><code>''''''
Programa: Kadane con posiciones
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Kadane que ademas reporta donde empieza y donde termina la mejor
    racha contigua.
''''''


def kadane_con_indices(arr):
    ''''''
    Encuentra la mejor racha contigua y sus limites.

    Parametros:
        arr (list): numeros, pueden ser negativos

    Retorna:
        tuple: (suma, indice_inicio, indice_fin)
    ''''''
    max_actual = arr[0]
    max_global = arr[0]

    inicio_actual = 0   # donde arranca la racha que se esta armando
    inicio = 0          # donde arranca la mejor racha encontrada
    fin = 0

    for i in range(1, len(arr)):
        # Si conviene empezar de nuevo, la racha nace AQUI: se anota
        if arr[i] > max_actual + arr[i]:
            max_actual = arr[i]
            inicio_actual = i
        else:
            max_actual = max_actual + arr[i]

        # Estrictamente mayor: con >= se quedaria con la ultima racha
        # empatada, y el enunciado pide la primera
        if max_actual > max_global:
            max_global = max_actual
            inicio = inicio_actual
            fin = i

    return max_global, inicio, fin


# Inicio
numeros = [int(x) for x in input().split()]
suma, i, j = kadane_con_indices(numeros)
print(suma, i, j)
# Fin</code></pre><p>El cambio respecto al Kadane simple es que ya no basta con saber <em>cuánto</em>: hay que saber <em>cuándo</em> el algoritmo tomó cada decisión. Por eso el <code>max</code> se abre en un <code>if</code>.</p><ul><li><strong><code>inicio_actual</code> se mueve solo cuando la racha se reinicia.</strong> Esa es la rama en la que el algoritmo decidió botar lo acumulado.</li><li><strong>Hay dos "inicio" distintos.</strong> <code>inicio_actual</code> es el de la racha que se está armando; <code>inicio</code> es el de la mejor encontrada. Confundirlos hace que se reporten posiciones de una racha que no ganó.</li><li><strong><code>&gt;</code> y no <code>&gt;=</code>.</strong> Con <code>&gt;=</code>, una racha empatada posterior desplazaría a la primera. El enunciado pide la primera, así que la comparación tiene que ser estricta.</li></ul>', '[{"stdin":"-2 1 -3 4 -1 2 1 -5 4\n","expected_output":"6 3 6\n"},{"stdin":"1 2 3\n","expected_output":"6 0 2\n"},{"stdin":"-5 -2 -9\n","expected_output":"-2 1 1\n"},{"stdin":"2 -1 2\n","expected_output":"3 0 2\n"},{"stdin":"4\n","expected_output":"4 0 0\n"}]', '''''''
Programa: Kadane con posiciones
Autor:
Fecha:
Descripcion:
''''''


def kadane_con_indices(arr):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 9 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué representa max_actual en Kadane?', NULL, '{"options":[{"id":"a","text":"La mejor suma de una racha que TERMINA exactamente en la posición actual"},{"id":"b","text":"La mejor suma vista en todo el arreglo"},{"id":"c","text":"La suma de todos los elementos hasta la posición actual"},{"id":"d","text":"El elemento más grande visto hasta ahora"}]}', '{"option_id":"a"}', 'Esa es la pregunta de cualquier DP: cuál es la mejor solución que termina aquí. max_global es otra cosa — la mejor vista hasta ahora, termine donde termine. Por eso hacen falta las dos.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Si TODOS los números son negativos, ¿qué devuelve este Kadane?', NULL, '{"options":[{"id":"a","text":"El menos negativo de todos"},{"id":"b","text":"0"},{"id":"c","text":"La suma de todos"},{"id":"d","text":"None"}]}', '{"option_id":"a"}', 'Con [-1,-2,-3,-4] devuelve -1. Como se inicializa en arr[0] y no en 0, siempre toma al menos un elemento. Si el enunciado permitiera la subsecuencia vacía, habría que inicializar en 0 — son dos versiones distintas del problema.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la complejidad de Kadane?', NULL, '{"options":[{"id":"a","text":"O(N) en tiempo, O(1) en memoria"},{"id":"b","text":"O(N²) en tiempo, O(N) en memoria"},{"id":"c","text":"O(N log N) en tiempo"},{"id":"d","text":"O(N) en tiempo, O(N) en memoria"}]}', '{"option_id":"a"}', 'Una sola pasada y dos variables. Ahí está la gracia: es una DP donde la transición solo mira un paso atrás, así que la tabla sobra.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Para [3, -1, 4, -1, 2, 1, -5, 4], ¿cuál es el resultado?', NULL, '{"options":[{"id":"a","text":"8"},{"id":"b","text":"7"},{"id":"c","text":"9"},{"id":"d","text":"13"}]}', '{"option_id":"a"}', 'La mejor racha es [3,-1,4,-1,2,1] = 8. El 13 sale de sumar solo los positivos, pero la subsecuencia tiene que ser CONTIGUA: si te llevas el 3 y el 4, te llevas también el -1 del medio.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'Este Kadane inicializa en 0. ¿Qué imprime?', 'def kadane(arr):
    max_actual = 0
    max_global = 0
    for x in arr:
        max_actual = max(x, max_actual + x)
        max_global = max(max_global, max_actual)
    return max_global

print(kadane([-1, -2, -3, -4]))', '{"options":[{"id":"a","text":"0"},{"id":"b","text":"-1"},{"id":"c","text":"-10"},{"id":"d","text":"Lanza ValueError"}]}', '{"option_id":"a"}', 'max_global arranca en 0 y nunca baja, así que devuelve 0: ''no tomo nada''. Si el enunciado exige al menos un elemento, la respuesta correcta era -1. Por eso la inicialización depende de lo que pida el problema.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'Este Kadane pierde la última racha buena. ¿En qué línea está el error?', NULL, '{"lines":["max_actual = arr[0]","max_global = arr[0]","for i in range(1, len(arr)):","    max_global = max(max_global, max_actual)","    max_actual = max(arr[i], max_actual + arr[i])","return max_global"]}', '{"line_number":4}', 'Guarda el máximo ANTES de actualizar max_actual, así que compara contra el valor de la vuelta anterior y nunca ve la racha del último elemento. El orden correcto es: primero decidir, después guardar.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el corazón de Kadane.', NULL, '{"code":"max_actual = arr[0]\nmax_global = arr[0]\n\nfor i in range(1, len(arr)):\n    max_actual = max(___1___, max_actual + arr[i])\n    max_global = max(___2___, max_actual)","blanks":[{"id":"1","pista":"empezar una racha nueva justo aquí"},{"id":"2","pista":"la mejor racha vista hasta ahora"}]}', '{"answers":{"1":["arr[i]"],"2":["max_global"]}}', 'Las dos opciones del primer max son: arrancar de nuevo en arr[i], o extender lo que traía. El segundo max es la memoria: max_global nunca baja.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué Kadane no necesita una tabla dp como el problema del Edificio?', NULL, '{"options":[{"id":"a","text":"Porque su transición solo mira el paso inmediatamente anterior"},{"id":"b","text":"Porque el arreglo está ordenado"},{"id":"c","text":"Porque no es programación dinámica"},{"id":"d","text":"Porque solo funciona con arreglos pequeños"}]}', '{"option_id":"a"}', 'El Edificio consulta cualquier dp[j] anterior, así que necesita guardarlos todos. Kadane solo necesita el de un paso atrás, y para eso basta una variable. Esa diferencia es la que convierte O(N²) en O(N).', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma el algoritmo de Kadane', NULL, '{"lines":[{"id":"kd1","text":"max_actual = arr[0]","indent":0},{"id":"kd2","text":"max_global = arr[0]","indent":0},{"id":"kd3","text":"for i in range(1, len(arr)):","indent":0},{"id":"kd4","text":"max_actual = max(arr[i], max_actual + arr[i])","indent":1},{"id":"kd5","text":"max_global = max(max_global, max_actual)","indent":1},{"id":"kd6","text":"return max_global","indent":0}]}', '{"order":["kd1","kd2","kd3","kd4","kd5","kd6"]}', 'Dentro del ciclo, la actualización de max_actual va primero: max_global tiene que comparar contra el valor recién calculado, no contra el de la vuelta pasada.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En [-2, 1, ...], al llegar al 1 el algoritmo decide empezar de nuevo. ¿Por qué?', NULL, '{"options":[{"id":"a","text":"Porque lo acumulado era negativo: arrastrarlo solo resta"},{"id":"b","text":"Porque 1 es positivo y -2 no"},{"id":"c","text":"Porque es el segundo elemento"},{"id":"d","text":"Porque el arreglo tiene más negativos que positivos"}]}', '{"option_id":"a"}', 'max(1, -2+1) = max(1, -1) = 1. La regla general: si el acumulado es negativo, botarlo siempre conviene, porque cualquier cosa que venga después queda mejor sin ese lastre.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'avanzado';

-- ── Capítulo 10: Búsqueda binaria (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 10, 'Búsqueda binaria', '🔍', 'La plantilla exacta, los ±1 que cuelgan el programa y buscar el primero que cumple.', '<p class="jc-gancho">La búsqueda binaria es cuatro líneas que casi nadie escribe bien a la primera. El <code>+1</code> y el <code>−1</code> mal puestos no dan una respuesta equivocada: <strong>cuelgan el programa</strong>. Y cuando la dominas, resulta que sirve para muchísimo más que buscar un número en una lista.</p>

<h2>💡 La plantilla, memorizada</h2>

<p>En el módulo 6 ya viste la idea de partir el problema por la mitad. Aquí lo que importa es la <strong>plantilla exacta</strong>, porque en competencia se escribe de memoria y sin dudar:</p>

<pre><code>def buscar(arr, x):
    izq = 0
    der = len(arr) - 1

    while izq &lt;= der:
        medio = (izq + der) // 2

        if arr[medio] == x:
            return medio

        if arr[medio] &lt; x:
            izq = medio + 1      # el objetivo está a la derecha
        else:
            der = medio - 1      # el objetivo está a la izquierda

    return -1                    # no está</code></pre>

<p>Requisito no negociable: <strong>el arreglo tiene que estar ordenado</strong>. Sobre datos desordenados no falla con error — devuelve basura.</p>

<h3>Las cuatro piezas que no se pueden cambiar</h3>

<table>
  <thead><tr><th>Pieza</th><th>Por qué así</th><th>Si la cambias</th></tr></thead>
  <tbody>
    <tr><td><code>der = len(arr) - 1</code></td><td>El último índice válido</td><td><code>IndexError</code> al leer <code>arr[medio]</code></td></tr>
    <tr><td><code>while izq &lt;= der</code></td><td>Con <code>izq == der</code> todavía queda un elemento por revisar</td><td>Con <code>&lt;</code>, no encuentra elementos que están</td></tr>
    <tr><td><code>izq = medio + 1</code></td><td>El del medio ya se descartó</td><td>Sin el <code>+1</code>: <strong>ciclo infinito</strong></td></tr>
    <tr><td><code>der = medio - 1</code></td><td>Igual, por el otro lado</td><td>Sin el <code>−1</code>: <strong>ciclo infinito</strong></td></tr>
  </tbody>
</table>

<p><strong>Por qué se cuelga.</strong> Cuando quedan dos elementos, <code>(izq + der) // 2</code> devuelve <code>izq</code> por la división entera. Si haces <code>izq = medio</code> en vez de <code>medio + 1</code>, <code>izq</code> no se mueve, el rango no encoge y el <code>while</code> gira para siempre. No es un detalle de estilo: es la diferencia entre resolver y recibir Time Limit.</p>

<h3>Por qué log N importa</h3>

<table>
  <thead><tr><th>N</th><th>Lineal (peor caso)</th><th>Binaria</th></tr></thead>
  <tbody>
    <tr><td>1 000</td><td>1 000 pasos</td><td>10</td></tr>
    <tr><td>1 000 000</td><td>1 000 000</td><td>20</td></tr>
    <tr><td>1 000 000 000</td><td>mil millones</td><td><b>30</b></td></tr>
  </tbody>
</table>

<p>Cada paso bota la mitad. Multiplicar el tamaño por mil solo agrega diez pasos.</p>

<h2>🔍 La variante que de verdad se usa: el primero que cumple</h2>

<p>Buscar un valor exacto es el caso fácil. En competencia casi siempre se pide otra cosa: <strong>el primer elemento que cumple una condición</strong> — el primer <code>≥ x</code>, el primer día en que alcanza, la mínima capacidad que sirve.</p>

<p>La plantilla cambia, y hay que aprendérsela aparte:</p>

<pre><code>def primero_que_cumple(arr, x):
    izq = 0
    der = len(arr)          # ojo: len, NO len - 1

    while izq &lt; der:        # ojo: &lt;, NO &lt;=
        medio = (izq + der) // 2

        if arr[medio] &gt;= x:
            der = medio     # este sirve, pero quizá hay uno mejor a la izquierda
        else:
            izq = medio + 1 # este no sirve, descartado

    return izq              # queda apuntando al primero que cumple</code></pre>

<table>
  <thead><tr><th>Diferencia</th><th>Búsqueda exacta</th><th>Primero que cumple</th></tr></thead>
  <tbody>
    <tr><td>Rango</td><td><code>[0, len−1]</code></td><td><code>[0, len)</code></td></tr>
    <tr><td>Condición</td><td><code>izq &lt;= der</code></td><td><code>izq &lt; der</code></td></tr>
    <tr><td>Cuando sirve</td><td>Devuelve de una</td><td><code>der = medio</code> — <em>sin</em> el −1, porque el candidato no se descarta</td></tr>
    <tr><td>Devuelve</td><td>El índice, o −1</td><td><code>izq</code>: el primero que cumple, o <code>len</code> si ninguno</td></tr>
  </tbody>
</table>

<p>Con <code>[1, 3, 3, 3, 5, 7]</code> buscando el primer <code>≥ 3</code>: devuelve <strong>1</strong>, el primer 3 de los tres. La búsqueda exacta habría devuelto cualquiera de ellos.</p>

<blockquote>La regla mental: si el elemento del medio <em>ya sirve</em>, no lo botes — muévete hacia la izquierda dejándolo dentro del rango (<code>der = medio</code>). Si no sirve, descártalo (<code>izq = medio + 1</code>).</blockquote>

<h2>🚀 Búsqueda binaria sobre la respuesta</h2>

<p>El salto conceptual del módulo: <strong>no hace falta un arreglo</strong>. Basta con que la pregunta tenga esta forma:</p>

<pre><code>si una respuesta R sirve, entonces cualquier R más grande también sirve</code></pre>

<p>Eso convierte el espacio de respuestas en una recta ordenada de <code>NO NO NO SÍ SÍ SÍ</code>, y se busca binariamente <strong>la frontera</strong>.</p>

<p>Ejemplo: hay que repartir una pila de paquetes en <code>D</code> días, en orden, y se busca la <strong>mínima capacidad diaria</strong> que alcanza.</p>

<table>
  <thead><tr><th>Pregunta</th><th>Respuesta</th></tr></thead>
  <tbody>
    <tr><td>¿Cuál es el rango de la respuesta?</td><td>De <code>max(pesos)</code> — al menos el paquete más pesado — a <code>sum(pesos)</code> — todo en un día</td></tr>
    <tr><td>¿Cómo verifico un candidato?</td><td>Simulo los días con esa capacidad y cuento cuántos necesito</td></tr>
    <tr><td>¿Es monótono?</td><td>Sí: con más capacidad nunca hacen falta más días</td></tr>
  </tbody>
</table>

<pre><code>def dias_necesarios(pesos, cap):
    dias = 1
    carga = 0
    for p in pesos:
        if carga + p &gt; cap:
            dias += 1
            carga = 0
        carga += p
    return dias


def capacidad_minima(pesos, D):
    izq = max(pesos)
    der = sum(pesos)

    while izq &lt; der:
        medio = (izq + der) // 2
        if dias_necesarios(pesos, medio) &lt;= D:
            der = medio          # sirve: busca una capacidad menor
        else:
            izq = medio + 1      # no alcanza: sube

    return izq</code></pre>

<p>Es la plantilla de "el primero que cumple", con la condición cambiada por una simulación. Con pesos <code>1..10</code> y D=5, la respuesta es <strong>15</strong>: probar una por una las capacidades entre 10 y 55 funcionaría, pero con sumas de millones no.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. El ciclo infinito</h3>
<pre><code>if arr[medio] &lt; x:
    izq = medio          # ❌ falta el +1</code></pre>
<p>Con dos elementos, <code>medio</code> es <code>izq</code>, así que <code>izq</code> no se mueve nunca. El programa no falla: se queda pensando hasta que el juez lo mata.</p>

<h3>2. Buscar en un arreglo sin ordenar</h3>
<pre><code>print(buscar([5, 2, 9, 1], 9))   # ❌ devuelve -1 aunque el 9 está</code></pre>
<p>La binaria descarta media lista confiando en el orden. Sin orden, descarta justo donde estaba la respuesta.</p>

<h3>3. Mezclar las dos plantillas</h3>
<pre><code>der = len(arr) - 1
while izq &lt; der:          # ❌ mezcla: se salta el último elemento</code></pre>
<p><code>len−1</code> va con <code>&lt;=</code>, y <code>len</code> va con <code>&lt;</code>. Cada plantilla completa, o falla por uno.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Verifica que esté <strong>ordenado</strong>. Si no, ordena primero — sigue siendo O(N log N).</li>
  <li>Escoge plantilla: valor exacto (<code>len−1</code>, <code>&lt;=</code>) o primero que cumple (<code>len</code>, <code>&lt;</code>).</li>
  <li>Cada rama tiene que <strong>encoger el rango</strong>. Si una deja <code>izq</code> y <code>der</code> igual que estaban, se cuelga.</li>
  <li>Si el enunciado pide "el mínimo X tal que…", piensa en binaria <strong>sobre la respuesta</strong>: define el rango y escribe la función que verifica un candidato.</li>
  <li>Prueba siempre con 1 elemento, 2 elementos, el primero y el último. Ahí viven todos los errores.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>izq, der = 0, len(arr) - 1</code></td><td>Rango cerrado, va con <code>while izq &lt;= der</code></td></tr>
    <tr><td><code>izq, der = 0, len(arr)</code></td><td>Rango medio abierto, va con <code>while izq &lt; der</code></td></tr>
    <tr><td><code>medio = (izq + der) // 2</code></td><td>El del centro; con dos elementos, el de la izquierda</td></tr>
    <tr><td><code>izq = medio + 1</code></td><td>Descartar el medio y todo lo de la izquierda</td></tr>
    <tr><td><code>der = medio</code></td><td>El medio sirve, pero puede haber uno mejor antes</td></tr>
    <tr><td><code>return izq</code></td><td>Al salir, apunta a la frontera entre NO y SÍ</td></tr>
  </tbody>
</table>

<blockquote>Si tu búsqueda binaria se cuelga, no la mires entera: mira si alguna rama puede dejar el rango igual que estaba.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 5 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 10 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 10 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Buscar el índice', 'facil', '<p>La primera línea trae un arreglo <strong>ya ordenado</strong> y la segunda un número por buscar. Imprime su índice, o <code>-1</code> si no está.</p><pre><code>Entrada:
2 5 8 12 16 23 38 56 72 91
23

Salida:
5</code></pre><p>Se pide el <strong>índice</strong> (contando desde 0), no el valor.</p>', '<p>La plantilla: <code>izq = 0</code>, <code>der = len(arr) - 1</code>, <code>while izq &lt;= der</code>. Y los <code>±1</code>: <code>izq = medio + 1</code>, <code>der = medio - 1</code>.</p>', '<pre><code>''''''
Programa: Busqueda binaria
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Encuentra el indice de un valor en un arreglo ordenado botando
    la mitad del rango en cada paso.
''''''


def buscar(arr, x):
    ''''''
    Busca x en un arreglo ordenado.

    Parametros:
        arr (list): numeros en orden creciente
        x (int): valor buscado

    Retorna:
        int: el indice donde esta, o -1 si no aparece
    ''''''
    izq = 0
    der = len(arr) - 1     # ultimo indice VALIDO

    # <= y no <: cuando izq y der se juntan todavia queda un
    # elemento sin revisar, y podria ser justo el que se busca
    while izq <= der:
        medio = (izq + der) // 2

        if arr[medio] == x:
            return medio

        if arr[medio] < x:
            # El objetivo esta a la derecha. El +1 es obligatorio:
            # sin el, con dos elementos izq no se mueve y el ciclo
            # gira para siempre
            izq = medio + 1
        else:
            der = medio - 1

    # Solo se llega aqui si el rango se agoto sin encontrarlo
    return -1


# Inicio
arr = [int(x) for x in input().split()]
objetivo = int(input())

print(buscar(arr, objetivo))
# Fin</code></pre><p>Esta plantilla se escribe de memoria. Los cuatro detalles que la hacen funcionar:</p><ul><li><strong><code>der = len(arr) - 1</code>.</strong> Es el último índice válido. Con <code>len(arr)</code> el primer <code>arr[medio]</code> puede salirse y dar <code>IndexError</code>.</li><li><strong><code>while izq &lt;= der</code>.</strong> Con <code>&lt;</code> el arreglo de un solo elemento nunca se revisa, y el último tampoco.</li><li><strong>Los <code>±1</code>.</strong> El elemento del medio ya se comparó, así que se descarta. Y esa es la única garantía de que el rango encoge: <code>(izq + der) // 2</code> con dos elementos devuelve <code>izq</code>, así que <code>izq = medio</code> deja todo igual y el programa se cuelga.</li><li><strong>El <code>return -1</code> va fuera del while.</strong> Adentro cortaría la búsqueda en el primer elemento que no coincide.</li></ul><p>Y el requisito que no se ve en el código: <strong>el arreglo tiene que estar ordenado</strong>. Con <code>[5, 2, 9, 1]</code> buscando el 9, devuelve −1 aunque está — porque descartó justo la mitad donde vivía.</p>', '[{"stdin":"2 5 8 12 16 23 38 56 72 91\n23\n","expected_output":"5\n"},{"stdin":"2 5 8 12 16 23 38 56 72 91\n2\n","expected_output":"0\n"},{"stdin":"2 5 8 12 16 23 38 56 72 91\n91\n","expected_output":"9\n"},{"stdin":"2 5 8 12 16 23 38 56 72 91\n7\n","expected_output":"-1\n"},{"stdin":"4\n4\n","expected_output":"0\n"},{"stdin":"4\n9\n","expected_output":"-1\n"},{"stdin":"1 2\n2\n","expected_output":"1\n"}]', '''''''
Programa: Busqueda binaria
Autor:
Fecha:
Descripcion:
''''''


def buscar(arr, x):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'El primero que cumple', 'medio', '<p>Con el arreglo ordenado de la primera línea y el número <code>x</code> de la segunda, imprime el índice del <strong>primer</strong> elemento que sea <code>&gt;= x</code>. Si ninguno lo es, imprime <code>len(arr)</code>.</p><pre><code>Entrada:
1 3 3 3 5 7
3

Salida:
1</code></pre><p>Hay tres treses: se pide el primero, no cualquiera.</p>', '<p>Otra plantilla: <code>der = len(arr)</code> y <code>while izq &lt; der</code>. Si el del medio cumple, <code>der = medio</code> (sin −1, porque es candidato); si no cumple, <code>izq = medio + 1</code>. Al salir, devuelve <code>izq</code>.</p>', '<pre><code>''''''
Programa: Primer elemento que cumple
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Encuentra la frontera: el primer indice cuyo valor es mayor o
    igual a x, en un arreglo ordenado.
''''''


def primero_que_cumple(arr, x):
    ''''''
    Busca el primer indice con arr[i] >= x.

    Parametros:
        arr (list): numeros en orden creciente
        x (int): valor de corte

    Retorna:
        int: el indice de la frontera, o len(arr) si ninguno cumple
    ''''''
    izq = 0
    der = len(arr)         # rango medio abierto: len, NO len - 1

    # < y no <=: aqui der no es un indice a revisar, es el limite
    while izq < der:
        medio = (izq + der) // 2

        if arr[medio] >= x:
            # Este SIRVE, pero puede haber uno mejor a la izquierda.
            # No se descarta: se deja dentro del rango
            der = medio
        else:
            # Este NO sirve, y nada a su izquierda tampoco
            izq = medio + 1

    # izq y der se juntaron exactamente en la frontera
    return izq


# Inicio
arr = [int(x) for x in input().split()]
x = int(input())

print(primero_que_cumple(arr, x))
# Fin</code></pre><p>Esta es la variante que de verdad se usa en competencia. Buscar un valor exacto es el caso fácil; lo que casi siempre se pide es <strong>la frontera</strong>: el primer día que alcanza, la primera posición que sirve, el primer <code>≥ x</code>.</p><p>Las diferencias con la plantilla clásica no son estéticas — hay que aprenderse las dos completas:</p><table><thead><tr><th></th><th>Valor exacto</th><th>Primero que cumple</th></tr></thead><tbody><tr><td>Rango</td><td><code>[0, len−1]</code></td><td><code>[0, len)</code></td></tr><tr><td>Condición</td><td><code>izq &lt;= der</code></td><td><code>izq &lt; der</code></td></tr><tr><td>Cuando sirve</td><td><code>return medio</code></td><td><code>der = medio</code>, sin −1</td></tr><tr><td>Devuelve</td><td>índice o −1</td><td><code>izq</code>: la frontera</td></tr></tbody></table><p><strong>La asimetría es intencional.</strong> El <code>+1</code> de la rama que no cumple es lo que hace encoger el rango; el <code>der = medio</code> de la otra conserva al candidato. Poner <code>der = medio - 1</code> ahí botaría precisamente la respuesta cuando el del medio ya era el primero bueno.</p><p>Si ningún elemento cumple, <code>izq</code> termina valiendo <code>len(arr)</code> — un índice que no existe, y que justamente significa "no hay".</p>', '[{"stdin":"1 3 3 3 5 7\n3\n","expected_output":"1\n"},{"stdin":"1 3 3 3 5 7\n4\n","expected_output":"4\n"},{"stdin":"1 3 3 3 5 7\n0\n","expected_output":"0\n"},{"stdin":"1 3 3 3 5 7\n8\n","expected_output":"6\n"},{"stdin":"1 3 3 3 5 7\n7\n","expected_output":"5\n"},{"stdin":"5\n5\n","expected_output":"0\n"}]', '''''''
Programa: Primer elemento que cumple
Autor:
Fecha:
Descripcion:
''''''


def primero_que_cumple(arr, x):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Binaria sobre la respuesta', 'dificil', '<p>Hay que despachar una pila de paquetes en exactamente <code>D</code> días o menos, <strong>en el orden en que están</strong>. Cada día el camión carga paquetes consecutivos sin pasarse de su capacidad. ¿Cuál es la <strong>mínima capacidad diaria</strong> que alcanza?</p><p>La primera línea trae los pesos y la segunda el número de días.</p><pre><code>Entrada:
1 2 3 4 5 6 7 8 9 10
5

Salida:
15</code></pre><p>Con capacidad 15: días (1,2,3,4,5), (6,7), (8), (9), (10) — cinco días. Con 14 ya no alcanza.</p>', '<p>No hay arreglo que buscar: se busca sobre la <strong>respuesta</strong>. Va de <code>max(pesos)</code> a <code>sum(pesos)</code>, y es monótona (con más capacidad nunca hacen falta más días). Escribe una función que, dada una capacidad, simule y cuente los días.</p>', '<pre><code>''''''
Programa: Capacidad minima de despacho
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Busqueda binaria sobre la respuesta: encuentra la menor capacidad
    diaria que permite despachar todos los paquetes en D dias.
''''''


def dias_necesarios(pesos, cap):
    ''''''
    Simula el despacho con una capacidad dada.

    Parametros:
        pesos (list): peso de cada paquete, en orden
        cap (int): capacidad diaria del camion

    Retorna:
        int: cuantos dias se necesitan con esa capacidad
    ''''''
    dias = 1
    carga = 0

    for p in pesos:
        # Si este paquete no cabe hoy, arranca un dia nuevo
        if carga + p > cap:
            dias += 1
            carga = 0
        carga += p

    return dias


def capacidad_minima(pesos, D):
    ''''''
    Encuentra la minima capacidad que alcanza para D dias.

    Parametros:
        pesos (list): peso de cada paquete, en orden
        D (int): dias disponibles

    Retorna:
        int: la capacidad minima suficiente
    ''''''
    # El rango de la respuesta, no de un arreglo:
    #   minimo -> el paquete mas pesado tiene que caber solo
    #   maximo -> todo en un solo dia
    izq = max(pesos)
    der = sum(pesos)

    # Misma plantilla del ''primero que cumple'', con la condicion
    # cambiada por una simulacion
    while izq < der:
        medio = (izq + der) // 2

        if dias_necesarios(pesos, medio) <= D:
            der = medio          # sirve: intenta con menos capacidad
        else:
            izq = medio + 1      # no alcanza: hay que subir

    return izq


# Inicio
pesos = [int(x) for x in input().split()]
D = int(input())

print(capacidad_minima(pesos, D))
# Fin</code></pre><p>Este es el salto del módulo: <strong>la búsqueda binaria no necesita un arreglo</strong>. Necesita monotonía.</p><p>La pregunta clave es: <em>si una capacidad R alcanza, ¿alcanza también R+1?</em> Sí — con más espacio nunca hacen falta más días. Eso convierte el espacio de respuestas en una recta de <code>NO NO NO SÍ SÍ SÍ</code>, y lo que se busca es la frontera. Exactamente el ejercicio anterior, cambiando <code>arr[medio] &gt;= x</code> por <code>dias_necesarios(pesos, medio) &lt;= D</code>.</p><ul><li><strong>El rango no se inventa.</strong> Por debajo de <code>max(pesos)</code> el paquete más pesado no cabe ni yendo solo: sería imposible. Por encima de <code>sum(pesos)</code> no se gana nada, porque ya cabe todo en un día.</li><li><strong>La función que verifica es una simulación.</strong> Cuenta días con esa capacidad, sin optimizar nada. Es el módulo de simulación reaparecido dentro de este.</li><li><strong>El costo.</strong> O(N log(suma)): la simulación recorre los N paquetes y se repite unas 30 veces. Probar capacidad por capacidad sería O(N × suma), imposible con sumas de millones.</li></ul><p>Cuando un enunciado dice "el mínimo X tal que…" o "el máximo X tal que…", esta es la técnica que hay que probar primero.</p>', '[{"stdin":"1 2 3 4 5 6 7 8 9 10\n5\n","expected_output":"15\n"},{"stdin":"3 2 2 4 1 4\n3\n","expected_output":"6\n"},{"stdin":"1 2 3 1 1\n4\n","expected_output":"3\n"},{"stdin":"7\n1\n","expected_output":"7\n"},{"stdin":"1 1 1 1\n2\n","expected_output":"2\n"},{"stdin":"1 2 3 4 5 6 7 8 9 10\n1\n","expected_output":"55\n"}]', '''''''
Programa: Capacidad minima de despacho
Autor:
Fecha:
Descripcion:
''''''


def dias_necesarios(pesos, cap):
    pass


def capacidad_minima(pesos, D):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 10 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué requisito tiene la búsqueda binaria?', NULL, '{"options":[{"id":"a","text":"Que el arreglo esté ordenado"},{"id":"b","text":"Que el arreglo tenga un tamaño par"},{"id":"c","text":"Que no haya elementos repetidos"},{"id":"d","text":"Que todos los números sean positivos"}]}', '{"option_id":"a"}', 'La binaria descarta media lista confiando en el orden. Sin orden no lanza error: devuelve basura, que es peor.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Qué pasa si escribes ''izq = medio'' en vez de ''izq = medio + 1''?', NULL, '{"options":[{"id":"a","text":"Ciclo infinito: con dos elementos, medio es izq y el rango no encoge"},{"id":"b","text":"Devuelve el índice equivocado"},{"id":"c","text":"Lanza IndexError"},{"id":"d","text":"No cambia nada, solo es más lento"}]}', '{"option_id":"a"}', '(izq + der) // 2 con dos elementos da izq por la división entera. Si izq no se mueve, el while gira para siempre. El programa no falla: recibe Time Limit.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Con N = 1 000 000 000, ¿cuántos pasos hace la búsqueda binaria en el peor caso?', NULL, '{"options":[{"id":"a","text":"Unos 30"},{"id":"b","text":"Unos 1000"},{"id":"c","text":"Mil millones"},{"id":"d","text":"Unos 100 000"}]}', '{"option_id":"a"}', 'log₂(10⁹) ≈ 30. Cada paso bota la mitad, así que multiplicar el tamaño por mil solo agrega diez pasos.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'En la plantilla del ''primero que cumple'', ¿por qué se escribe ''der = medio'' y no ''der = medio - 1''?', NULL, '{"options":[{"id":"a","text":"Porque el elemento del medio ya cumple: es candidato y no se puede descartar"},{"id":"b","text":"Porque el rango es cerrado"},{"id":"c","text":"Porque así es más rápido"},{"id":"d","text":"Porque der arranca en len(arr) - 1"}]}', '{"option_id":"a"}', 'La regla mental: si el del medio ya sirve, muévete a la izquierda dejándolo dentro del rango. Solo se descarta lo que NO cumple, con izq = medio + 1.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Cuándo se puede hacer búsqueda binaria sobre la RESPUESTA, sin arreglo?', NULL, '{"options":[{"id":"a","text":"Cuando si una respuesta R sirve, toda R mayor también sirve"},{"id":"b","text":"Cuando la respuesta es un número pequeño"},{"id":"c","text":"Siempre que haya un ciclo while"},{"id":"d","text":"Cuando los datos están ordenados"}]}', '{"option_id":"a"}', 'Esa monotonía convierte el espacio de respuestas en una recta de NO NO NO SÍ SÍ SÍ, y se busca la frontera. Sin monotonía, la binaria descarta la mitad equivocada.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def buscar(arr, x):
    izq, der = 0, len(arr) - 1
    while izq <= der:
        medio = (izq + der) // 2
        if arr[medio] == x:
            return medio
        if arr[medio] < x:
            izq = medio + 1
        else:
            der = medio - 1
    return -1

print(buscar([2, 5, 8, 12, 16, 23, 38, 56, 72, 91], 23))', '{"options":[{"id":"a","text":"5"},{"id":"b","text":"23"},{"id":"c","text":"6"},{"id":"d","text":"-1"}]}', '{"option_id":"a"}', 'Devuelve el ÍNDICE, no el valor. El 23 está en la posición 5, contando desde 0. Tres pasos: medio=4 (16<23) → medio=7 (56>23) → medio=5, encontrado.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este programa nunca encuentra el último elemento del arreglo. ¿En qué línea está el error?', NULL, '{"lines":["izq = 0","der = len(arr) - 1","while izq < der:","    medio = (izq + der) // 2","    if arr[medio] == x:","        return medio"]}', '{"line_number":3}', 'Con rango cerrado (len − 1) la condición tiene que ser izq <= der: cuando los dos se juntan todavía queda un elemento por revisar. len − 1 va con <=, y len va con <.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la búsqueda binaria clásica.', NULL, '{"code":"izq = 0\nder = ___1___\n\nwhile izq ___2___ der:\n    medio = (izq + der) // 2\n    if arr[medio] == x:\n        return medio\n    if arr[medio] < x:\n        izq = ___3___\n    else:\n        der = medio - 1\n\nreturn -1","blanks":[{"id":"1","pista":"el último índice válido"},{"id":"2","pista":"con rango cerrado todavía queda uno por revisar"},{"id":"3","pista":"el del medio ya se descartó"}]}', '{"answers":{"1":["len(arr) - 1"],"2":["<="],"3":["medio + 1"]}}', 'Las tres piezas van juntas: len − 1 con <=, y el + 1 que garantiza que el rango encoge. Sin ese + 1 el programa se cuelga.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa la plantilla del primer elemento que cumple arr[i] >= x.', NULL, '{"code":"izq = 0\nder = len(arr)\n\nwhile izq < der:\n    medio = (izq + der) // 2\n    if arr[medio] >= x:\n        der = ___1___\n    else:\n        izq = ___2___\n\nreturn izq","blanks":[{"id":"1","pista":"este candidato sirve: no lo descartes"},{"id":"2","pista":"este no sirve: fuera"}]}', '{"answers":{"1":["medio"],"2":["medio + 1"]}}', 'Asimétrico a propósito. El que cumple se conserva dentro del rango; el que no cumple se bota. Al salir, izq apunta a la frontera.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma la búsqueda binaria clásica', NULL, '{"lines":[{"id":"s1","text":"izq = 0","indent":0},{"id":"s2","text":"der = len(arr) - 1","indent":0},{"id":"s3","text":"while izq <= der:","indent":0},{"id":"s4","text":"medio = (izq + der) // 2","indent":1},{"id":"s5","text":"if arr[medio] == x:","indent":1},{"id":"s6","text":"return medio","indent":2},{"id":"s7","text":"if arr[medio] < x:","indent":1},{"id":"s8","text":"izq = medio + 1","indent":2},{"id":"s9","text":"else:","indent":1},{"id":"s10","text":"der = medio - 1","indent":2},{"id":"s11","text":"return -1","indent":0}]}', '{"order":["s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11"]}', 'El return -1 va FUERA del while: solo se llega ahí cuando el rango se agotó sin encontrar nada.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En [1, 3, 3, 3, 5, 7], ¿qué devuelve la plantilla del primer elemento >= 3?', NULL, '{"options":[{"id":"a","text":"1"},{"id":"b","text":"3"},{"id":"c","text":"2"},{"id":"d","text":"0"}]}', '{"option_id":"a"}', 'El índice del PRIMER 3, no su valor ni el de cualquiera de los tres. Esa es justamente la ventaja sobre la búsqueda exacta, que habría devuelto cualquiera de las tres posiciones.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'avanzado';

-- ── Capítulo 11: Two pointers (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 11, 'Two pointers', '👉', 'Dos índices que se acercan: cambiar O(N²) por O(N).', '<p class="jc-gancho">Dos índices moviéndose sobre el mismo arreglo. Suena a nada, y sin embargo convierte un O(N²) en O(N) — que es la diferencia entre 10¹⁰ operaciones y 10⁵. La técnica es fácil; lo difícil es <strong>justificar por qué se puede descartar lo que se descarta</strong>.</p>

<h2>💡 La idea</h2>

<p>En vez de dos ciclos anidados probando todos los pares, se ponen dos índices y en cada paso <strong>se mueve solo uno</strong>, el que corresponda. Como cada índice recorre el arreglo una vez y nunca retrocede, el total es O(N).</p>

<table>
  <thead><tr><th>Variante</th><th>Dónde arrancan</th><th>Para qué sirve</th></tr></thead>
  <tbody>
    <tr><td><strong>Extremos que se acercan</strong></td><td><code>i = 0</code>, <code>j = len−1</code></td><td>Pares que suman algo, palíndromos, áreas</td></tr>
    <tr><td><strong>Lento y rápido</strong></td><td>Los dos en 0</td><td>Filtrar, comprimir, eliminar duplicados en el sitio</td></tr>
  </tbody>
</table>

<p>Casi siempre la variante de extremos exige que el arreglo <strong>esté ordenado</strong>: el orden es lo que permite saber hacia dónde moverse.</p>

<h2>📖 El problema</h2>

<div class="jc-problema">

<h3>El par que suma</h3>

<p><strong>Descripción.</strong> Dado un arreglo <strong>ordenado</strong> de enteros y un objetivo <code>S</code>, encontrar dos elementos que sumen exactamente <code>S</code>.</p>

<p><strong>Entrada.</strong> Dos líneas: el arreglo ordenado, y el objetivo <code>S</code>.</p>

<p><strong>Salida.</strong> Los dos valores separados por espacio, el menor primero. Si no existe tal par, imprimir <code>NO</code>.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>1 3 4 7 11 15</code><br><code>11</code></td><td><code>4 7</code></td></tr></tbody>
</table>

</div>

<h3>La fuerza bruta y por qué no sirve</h3>

<pre><code>for i in range(len(arr)):
    for j in range(i + 1, len(arr)):
        if arr[i] + arr[j] == S:
            ...                       # O(N²)</code></pre>

<p>Con N = 10⁵ eso son <strong>cinco mil millones</strong> de pares. El juez te corta mucho antes.</p>

<h3>El razonamiento que lo cambia todo</h3>

<p>Con el arreglo ordenado, se pone un índice en cada extremo y se mira la suma:</p>

<table>
  <thead><tr><th>Si la suma…</th><th>Se hace</th><th>Por qué es seguro</th></tr></thead>
  <tbody>
    <tr><td>es igual a S</td><td>Se encontró</td><td>—</td></tr>
    <tr><td>es <strong>menor</strong> que S</td><td><code>i += 1</code></td><td><code>arr[i]</code> es el más pequeño disponible: emparejado con el más grande ya se queda corto, así que con ningún otro llega. Se descarta entero.</td></tr>
    <tr><td>es <strong>mayor</strong> que S</td><td><code>j -= 1</code></td><td>Simétrico: <code>arr[j]</code> es el más grande, y ni con el más pequeño baja de S.</td></tr>
  </tbody>
</table>

<p>Cada paso descarta un elemento <strong>para siempre</strong>, con argumento. Eso es lo que hace válido el O(N), y es lo que hay que saber explicar — no el código.</p>

<h2>💻 Código paso a paso</h2>

<pre><code>arr = [int(x) for x in input().split()]
S = int(input())

i = 0
j = len(arr) - 1

encontrado = False

while i &lt; j:                 # i &lt; j, no i &lt;= j: no se vale usar el mismo dos veces
    suma = arr[i] + arr[j]

    if suma == S:
        print(arr[i], arr[j])
        encontrado = True
        break

    if suma &lt; S:
        i += 1
    else:
        j -= 1

if not encontrado:
    print("NO")</code></pre>

<h3>La película con <code>[1, 3, 4, 7, 11, 15]</code> y S = 11</h3>

<table>
  <thead><tr><th>i</th><th>j</th><th>arr[i] + arr[j]</th><th>vs 11</th><th>Acción</th></tr></thead>
  <tbody>
    <tr><td>0</td><td>5</td><td>1 + 15 = 16</td><td>mayor</td><td>j → 4 (el 15 no sirve con nadie)</td></tr>
    <tr><td>0</td><td>4</td><td>1 + 11 = 12</td><td>mayor</td><td>j → 3</td></tr>
    <tr><td>0</td><td>3</td><td>1 + 7 = 8</td><td>menor</td><td>i → 1 (el 1 no le alcanza a nadie)</td></tr>
    <tr><td>1</td><td>3</td><td>3 + 7 = 10</td><td>menor</td><td>i → 2</td></tr>
    <tr><td>2</td><td>3</td><td>4 + 7 = 11</td><td><b>igual</b></td><td><b>4 7</b></td></tr>
  </tbody>
</table>

<p>Cinco pasos. La fuerza bruta habría probado quince pares.</p>

<h2>🔍 La otra variante: lento y rápido</h2>

<p>Cuando hay que <strong>reescribir el arreglo sin usar memoria extra</strong>, los dos índices arrancan juntos: uno recorre (rápido) y el otro marca dónde se escribe (lento).</p>

<pre><code>k = 0                            # última posición escrita

for i in range(1, len(arr)):     # i recorre
    if arr[i] != arr[k]:
        k += 1
        arr[k] = arr[i]          # se escribe solo cuando hay algo nuevo

# arr[0..k] son los únicos</code></pre>

<p>Con <code>[1, 1, 2, 2, 3]</code> queda <code>[1, 2, 3]</code> en las tres primeras posiciones, sin lista nueva. El índice lento va siempre detrás o igual que el rápido, así que nunca se pisa un dato que todavía no se ha leído.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Two pointers sobre un arreglo desordenado</h3>
<pre><code>arr = [10, 1, 7, 3]     # ❌ el razonamiento no aplica</code></pre>
<p>Si la suma se queda corta, mover <code>i</code> no garantiza nada: el siguiente podría ser más pequeño. Sin orden, la técnica no es válida — ordena primero, o usa un diccionario.</p>

<h3>2. <code>while i &lt;= j</code></h3>
<pre><code>while i &lt;= j:           # ❌ permite i == j</code></pre>
<p>Con <code>S = 8</code> y un 4 en el arreglo, respondería "4 y 4" usando el mismo elemento dos veces.</p>

<h3>3. Mover los dos a la vez</h3>
<pre><code>i += 1
j -= 1                  # ❌ en el mismo paso</code></pre>
<p>Se saltan pares sin revisarlos. En cada vuelta se mueve <strong>uno solo</strong>, el que el argumento permite descartar.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿El arreglo está ordenado? Si no, ordénalo — sigue siendo mejor que O(N²).</li>
  <li>Antes de escribir, di en voz alta <strong>por qué</strong> puedes descartar el elemento que descartas. Si no puedes, la técnica no aplica.</li>
  <li>Un solo índice se mueve por vuelta.</li>
  <li><code>while i &lt; j</code> cuando los dos elementos tienen que ser distintos.</li>
  <li>Si el problema es "filtrar o comprimir en el sitio", la variante es lento/rápido.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>i, j = 0, len(arr) - 1</code></td><td>Extremos que se van a acercar</td></tr>
    <tr><td><code>while i &lt; j:</code></td><td>Mientras no se crucen, sin repetir elemento</td></tr>
    <tr><td><code>i += 1</code> si la suma es corta</td><td>Descartar el menor disponible</td></tr>
    <tr><td><code>j -= 1</code> si la suma se pasa</td><td>Descartar el mayor disponible</td></tr>
    <tr><td><code>k</code> lento, <code>i</code> rápido</td><td>Reescribir el arreglo sin memoria extra</td></tr>
    <tr><td>O(N) en vez de O(N²)</td><td>Cada índice recorre una vez y no retrocede</td></tr>
  </tbody>
</table>

<blockquote>Two pointers no es "usar dos variables": es tener un argumento que te deja botar un candidato en cada paso y no volverlo a mirar.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 5 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 11 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 11 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'El par que suma', 'medio', '<p>La primera línea trae un arreglo <strong>ordenado</strong> y la segunda un objetivo <code>S</code>. Imprime dos elementos distintos que sumen exactamente <code>S</code>, el menor primero. Si no existe el par, imprime <code>NO</code>.</p><pre><code>Entrada:
1 3 4 7 11 15
11

Salida:
4 7</code></pre><p>Tiene que ser O(N): con N = 10⁵ probar todos los pares no pasa.</p>', '<p>Un índice en cada extremo. Si la suma se queda corta, sube el de la izquierda; si se pasa, baja el de la derecha. Piensa <em>por qué</em> es seguro descartar ese elemento.</p>', '<pre><code>''''''
Programa: El par que suma
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Encuentra dos elementos de un arreglo ordenado que sumen S,
    con dos indices que se acercan desde los extremos.
''''''


def par_que_suma(arr, S):
    ''''''
    Busca dos elementos distintos cuya suma sea S.

    Parametros:
        arr (list): numeros en orden creciente
        S (int): suma objetivo

    Retorna:
        tuple: los dos valores, o None si no existe el par
    ''''''
    i = 0
    j = len(arr) - 1

    # i < j y no i <= j: los dos elementos tienen que ser distintos.
    # Con <=, buscando S=8 en un arreglo con un 4, responderia ''4 y 4''
    while i < j:
        suma = arr[i] + arr[j]

        if suma == S:
            return (arr[i], arr[j])

        if suma < S:
            # arr[i] es el MENOR disponible: si emparejado con el mayor
            # ya se queda corto, con ningun otro llega. Se descarta
            i += 1
        else:
            # Simetrico: arr[j] es el mayor, y ni con el mas pequeno
            # baja de S
            j -= 1

    return None


# Inicio
arr = [int(x) for x in input().split()]
S = int(input())

par = par_que_suma(arr, S)

if par is None:
    print("NO")
else:
    print(par[0], par[1])
# Fin</code></pre><p>Lo importante de este ejercicio no es el código —son diez líneas— sino <strong>el argumento</strong>. En cada paso se descarta un elemento <em>para siempre</em>, y hay que poder justificar por qué:</p><ul><li><strong>Suma corta → sube <code>i</code>.</strong> <code>arr[i]</code> es el más pequeño que queda. Si ni sumándole el más grande alcanza S, con ningún otro va a alcanzar. Nunca será parte de la respuesta.</li><li><strong>Suma pasada → baja <code>j</code>.</strong> El mismo razonamiento al revés.</li></ul><p>Como cada índice avanza y no retrocede, entre los dos hacen a lo sumo N pasos: <strong>O(N)</strong>. La fuerza bruta con dos ciclos anidados sería O(N²), y con N = 10⁵ son cinco mil millones de pares.</p><p><strong>El requisito escondido:</strong> el arreglo tiene que estar ordenado. Con <code>[10, 1, 7, 3]</code> el argumento se cae — mover <code>i</code> no garantiza nada porque el siguiente podría ser menor. Si te dan datos desordenados: ordena primero (O(N log N), todavía mucho mejor) o usa un diccionario de vistos.</p>', '[{"stdin":"1 3 4 7 11 15\n11\n","expected_output":"4 7\n"},{"stdin":"2 7 11 15\n9\n","expected_output":"2 7\n"},{"stdin":"1 2 3\n7\n","expected_output":"NO\n"},{"stdin":"1 2 3 4\n5\n","expected_output":"1 4\n"},{"stdin":"5 5\n10\n","expected_output":"5 5\n"},{"stdin":"4\n8\n","expected_output":"NO\n"}]', '''''''
Programa: El par que suma
Autor:
Fecha:
Descripcion:
''''''


def par_que_suma(arr, S):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'El contenedor con más agua', 'dificil', '<p>La entrada trae las alturas de unas paredes verticales, una por posición. Escogiendo <strong>dos</strong> paredes, el agua que cabe entre ellas es <code>min(altura_i, altura_j) × (j − i)</code>: la altura la manda la pared más baja.</p><p>Imprime el área máxima posible.</p><pre><code>Entrada:
1 8 6 2 5 4 8 3 7

Salida:
49</code></pre><p>Las paredes en las posiciones 1 y 8 (alturas 8 y 7): min(8,7) × 7 = 49.</p>', '<p>Extremos que se acercan. En cada paso, mueve <strong>la pared más baja</strong>: es la que limita la altura, y moviendo la más alta el área nunca mejora.</p>', '<pre><code>''''''
Programa: El contenedor con mas agua
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Encuentra el area maxima entre dos paredes verticales, moviendo
    en cada paso la pared mas baja.
''''''


def area_maxima(alturas):
    ''''''
    Calcula el area maxima de agua entre dos paredes.

    Parametros:
        alturas (list): altura de cada pared, por posicion

    Retorna:
        int: el area maxima
    ''''''
    i = 0
    j = len(alturas) - 1
    mejor = 0

    while i < j:
        # La pared mas baja manda la altura; el ancho es la distancia
        altura = min(alturas[i], alturas[j])
        area = altura * (j - i)

        if area > mejor:
            mejor = area

        # SE MUEVE LA MAS BAJA. Moviendo la mas alta el ancho baja y la
        # altura sigue limitada por la baja: el area nunca mejoraria
        if alturas[i] < alturas[j]:
            i += 1
        else:
            j -= 1

    return mejor


# Inicio
alturas = [int(x) for x in input().split()]
print(area_maxima(alturas))
# Fin</code></pre><p>Este es el mismo esqueleto del ejercicio anterior, pero con un argumento distinto — y más sutil.</p><p><strong>Por qué se mueve la más baja.</strong> Estás en las posiciones <code>i</code> y <code>j</code>, con el ancho máximo que esas dos paredes pueden dar. Si mueves la <em>alta</em> hacia adentro, el ancho baja seguro, y la altura sigue limitada por la baja, que no cambió: el área solo puede empeorar. Es decir, la pared baja <strong>ya dio lo mejor que podía dar</strong> — su mejor área es la que acabas de calcular. Se descarta con tranquilidad.</p><ul><li><strong>Empieza con el ancho máximo.</strong> Arrancar en los extremos no es casualidad: el ancho solo puede encoger, así que cualquier mejora tiene que venir de más altura.</li><li><strong>Empate.</strong> Con <code>alturas[i] == alturas[j]</code> da igual cuál mover: la de este lado ya dio su máximo. El <code>else</code> se lo lleva.</li><li><strong>El área se calcula antes de mover.</strong> Si primero mueves, te pierdes el par actual — y podía ser el mejor.</li></ul><p>La fuerza bruta probaría los N(N−1)/2 pares. Esto es O(N) con dos variables, y con <code>[1,8,6,2,5,4,8,3,7]</code> llega a 49 sin mirar los 36 pares.</p>', '[{"stdin":"1 8 6 2 5 4 8 3 7\n","expected_output":"49\n"},{"stdin":"1 1\n","expected_output":"1\n"},{"stdin":"4 3 2 1 4\n","expected_output":"16\n"},{"stdin":"1 2 1\n","expected_output":"2\n"},{"stdin":"2 3 10 5 7 8 9\n","expected_output":"36\n"}]', '''''''
Programa: El contenedor con mas agua
Autor:
Fecha:
Descripcion:
''''''


def area_maxima(alturas):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Sin duplicados, sin lista nueva', 'medio', '<p>La entrada trae un arreglo <strong>ordenado</strong> con repetidos. Imprime los valores únicos separados por espacio, <strong>sin crear una lista nueva</strong>: hay que reescribir el mismo arreglo.</p><pre><code>Entrada:
1 1 2 2 3

Salida:
1 2 3</code></pre><p>Esta es la variante lento/rápido: un índice recorre y el otro marca dónde se escribe.</p>', '<p><code>k</code> es la última posición escrita y arranca en 0. Recorre con <code>i</code> desde 1: si <code>arr[i]</code> es distinto de <code>arr[k]</code>, sube <code>k</code> y escribe ahí. Al final los únicos son <code>arr[0..k]</code>.</p>', '<pre><code>''''''
Programa: Eliminar duplicados en el sitio
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Comprime un arreglo ordenado dejando solo los valores unicos, sin
    usar memoria extra: dos indices, uno lento y uno rapido.
''''''


def comprimir(arr):
    ''''''
    Deja los valores unicos al principio del arreglo.

    Parametros:
        arr (list): numeros en orden creciente, con repetidos

    Retorna:
        int: cuantos unicos quedaron; estan en arr[0..retorno-1]
    ''''''
    if len(arr) == 0:
        return 0

    # k = ultima posicion ESCRITA. El primer elemento siempre se queda
    k = 0

    # i = indice RAPIDO, recorre buscando algo nuevo
    for i in range(1, len(arr)):
        # Como el arreglo esta ordenado, los repetidos vienen seguidos:
        # basta comparar con el ultimo escrito, no con todos
        if arr[i] != arr[k]:
            k += 1
            arr[k] = arr[i]

    return k + 1


# Inicio
arr = [int(x) for x in input().split()]

cuantos = comprimir(arr)

texto = ""
for i in range(cuantos):
    if texto != "":
        texto += " "
    texto += str(arr[i])

print(texto)
# Fin</code></pre><p>La otra cara de two pointers: aquí los dos índices <strong>arrancan juntos</strong> y van en la misma dirección, a velocidades distintas.</p><ul><li><strong><code>k</code> nunca alcanza a <code>i</code>.</strong> Esa es la garantía de que se puede escribir sobre el mismo arreglo sin pisar datos: el lento siempre va detrás o igual, así que <code>arr[k+1] = arr[i]</code> nunca sobrescribe algo que todavía falta por leer.</li><li><strong>Comparar contra <code>arr[k]</code> y no contra <code>arr[i-1]</code>.</strong> Con un arreglo ordenado las dos funcionan, pero <code>arr[k]</code> es lo correcto conceptualmente: la pregunta es "¿esto ya lo escribí?".</li><li><strong>El arreglo tiene que estar ordenado.</strong> Es lo que hace que los repetidos vengan seguidos. Con <code>[1,2,1]</code> dejaría los tres.</li><li><strong>Devuelve la cantidad, no una lista.</strong> Ese es el punto del ejercicio: memoria O(1). Los elementos después de <code>k</code> quedan como basura y no se miran.</li></ul>', '[{"stdin":"1 1 2 2 3\n","expected_output":"1 2 3\n"},{"stdin":"1\n","expected_output":"1\n"},{"stdin":"2 2 2\n","expected_output":"2\n"},{"stdin":"1 2 3\n","expected_output":"1 2 3\n"},{"stdin":"0 0 1 1 1 2 2 3 3 4\n","expected_output":"0 1 2 3 4\n"}]', '''''''
Programa: Eliminar duplicados en el sitio
Autor:
Fecha:
Descripcion:
''''''


def comprimir(arr):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 11 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En el par que suma, si arr[i] + arr[j] es MENOR que S, ¿qué se hace y por qué?', NULL, '{"options":[{"id":"a","text":"i += 1, porque arr[i] es el menor disponible: ni con el mayor llega a S"},{"id":"b","text":"j -= 1, porque hay que bajar la suma"},{"id":"c","text":"Se mueven los dos a la vez"},{"id":"d","text":"Se reinicia j al final"}]}', '{"option_id":"a"}', 'Ese argumento es la técnica entera: si el elemento más pequeño emparejado con el más grande ya se queda corto, con ningún otro llega. Se descarta para siempre, y por eso el total es O(N).', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué requisito tiene la variante de two pointers desde los extremos?', NULL, '{"options":[{"id":"a","text":"Que el arreglo esté ordenado"},{"id":"b","text":"Que tenga tamaño par"},{"id":"c","text":"Que no tenga números negativos"},{"id":"d","text":"Ninguno"}]}', '{"option_id":"a"}', 'El orden es lo que permite saber hacia dónde moverse. Con [10, 1, 7, 3], mover i cuando la suma es corta no garantiza nada: el siguiente podría ser más pequeño.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué el ciclo es ''while i < j'' y no ''while i <= j''?', NULL, '{"options":[{"id":"a","text":"Para no usar el mismo elemento dos veces"},{"id":"b","text":"Para que sea más rápido"},{"id":"c","text":"Porque i nunca alcanza a j"},{"id":"d","text":"Para evitar un IndexError"}]}', '{"option_id":"a"}', 'Con <=, buscando S=8 en un arreglo con un 4, respondería ''4 y 4'' — el mismo elemento contado dos veces. El enunciado pide dos elementos distintos.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál es la complejidad de two pointers frente a la fuerza bruta?', NULL, '{"options":[{"id":"a","text":"O(N) contra O(N²)"},{"id":"b","text":"O(N log N) contra O(N²)"},{"id":"c","text":"O(N²) contra O(N³)"},{"id":"d","text":"Las dos son O(N)"}]}', '{"option_id":"a"}', 'Cada índice recorre el arreglo una vez y nunca retrocede, así que entre los dos hacen a lo sumo N pasos. Con N = 10⁵, la fuerza bruta serían cinco mil millones de pares.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Cuántas vueltas del while hace este programa antes de encontrar el par?', 'arr = [1, 3, 4, 7, 11, 15]
S = 11
i, j = 0, len(arr) - 1
vueltas = 0
while i < j:
    vueltas += 1
    s = arr[i] + arr[j]
    if s == S:
        break
    if s < S:
        i += 1
    else:
        j -= 1
print(vueltas)', '{"options":[{"id":"a","text":"5"},{"id":"b","text":"3"},{"id":"c","text":"6"},{"id":"d","text":"15"}]}', '{"option_id":"a"}', '16 (baja j), 12 (baja j), 8 (sube i), 10 (sube i), 11 (encontrado). Cinco vueltas contra los quince pares que probaría la fuerza bruta.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este programa se salta pares válidos. ¿En qué línea está el error?', NULL, '{"lines":["while i < j:","    suma = arr[i] + arr[j]","    if suma == S:","        return (arr[i], arr[j])","    i += 1","    j -= 1"]}', '{"line_number":5}', 'Mueve los dos índices en el mismo paso, sin mirar si la suma se pasó o se quedó corta. En cada vuelta se mueve UNO solo: el que el argumento permite descartar.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el par que suma S.', NULL, '{"code":"i = 0\nj = len(arr) - 1\n\nwhile i ___1___ j:\n    suma = arr[i] + arr[j]\n\n    if suma == S:\n        return (arr[i], arr[j])\n\n    if suma < S:\n        ___2___\n    else:\n        ___3___","blanks":[{"id":"1","pista":"sin repetir el mismo elemento"},{"id":"2","pista":"la suma es corta: sube el menor"},{"id":"3","pista":"la suma se pasa: baja el mayor"}]}', '{"answers":{"1":["<"],"2":["i += 1"],"3":["j -= 1"]}}', 'Suma corta → hay que subir, y solo se puede moviendo i. Suma pasada → hay que bajar, moviendo j. Nunca los dos a la vez.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa la variante lento/rápido que elimina duplicados en el sitio.', NULL, '{"code":"k = 0\n\nfor i in range(1, len(arr)):\n    if arr[i] != arr[___1___]:\n        k += 1\n        arr[k] = ___2___\n\n# arr[0..k] son los unicos","blanks":[{"id":"1","pista":"el último que se escribió"},{"id":"2","pista":"lo nuevo que encontró el rápido"}]}', '{"answers":{"1":["k"],"2":["arr[i]"]}}', 'k marca dónde se escribe e i recorre. Como k va siempre detrás o igual que i, nunca se pisa un dato sin leer.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma el par que suma S', NULL, '{"lines":[{"id":"t1","text":"i = 0","indent":0},{"id":"t2","text":"j = len(arr) - 1","indent":0},{"id":"t3","text":"while i < j:","indent":0},{"id":"t4","text":"suma = arr[i] + arr[j]","indent":1},{"id":"t5","text":"if suma == S:","indent":1},{"id":"t6","text":"return (arr[i], arr[j])","indent":2},{"id":"t7","text":"if suma < S:","indent":1},{"id":"t8","text":"i += 1","indent":2},{"id":"t9","text":"else:","indent":1},{"id":"t10","text":"j -= 1","indent":2}]}', '{"order":["t1","t2","t3","t4","t5","t6","t7","t8","t9","t10"]}', 'Los índices en los extremos, y dentro del ciclo una sola decisión: subir i o bajar j, nunca las dos.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Cuándo se usa la variante ''lento y rápido'' (los dos índices arrancando en 0)?', NULL, '{"options":[{"id":"a","text":"Cuando hay que filtrar o comprimir el arreglo en el sitio, sin memoria extra"},{"id":"b","text":"Cuando el arreglo no está ordenado"},{"id":"c","text":"Cuando se buscan pares que suman algo"},{"id":"d","text":"Cuando el arreglo tiene menos de 10 elementos"}]}', '{"option_id":"a"}', 'Uno recorre y el otro marca dónde escribir. Con [1,1,2,2,3] deja [1,2,3] en las tres primeras posiciones sin crear una lista nueva.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Si el arreglo NO está ordenado y hay que encontrar un par que sume S, ¿qué se hace?', NULL, '{"options":[{"id":"a","text":"Ordenarlo primero (O(N log N)) o usar un diccionario de vistos (O(N))"},{"id":"b","text":"Usar two pointers igual: funciona en cualquier orden"},{"id":"c","text":"Es imposible resolverlo"},{"id":"d","text":"Recorrerlo al revés"}]}', '{"option_id":"a"}', 'Two pointers sobre datos desordenados no falla con error: da respuestas incorrectas. Ordenar sigue siendo mucho mejor que el O(N²) de la fuerza bruta.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'avanzado';

-- ── Capítulo 12: Ventana deslizante (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 12, 'Ventana deslizante', '🪟', 'Reutilizar la cuenta anterior en vez de recalcular la ventana entera.', '<p class="jc-gancho">Recalcular la suma de cada ventana desde cero es hacer el mismo trabajo N veces. La ventana deslizante hace lo obvio y lo que casi nadie escribe a la primera: <strong>reutilizar la cuenta anterior</strong>. Entra uno, sale uno, y listo.</p>

<h2>💡 La idea</h2>

<p>Un subarreglo contiguo se puede ver como una ventana que se desliza. Al avanzar una posición, la ventana no cambia entera: <strong>gana un elemento por la derecha y pierde uno por la izquierda</strong>. Todo lo demás sigue igual, así que no hay que volver a sumarlo.</p>

<pre><code>suma_nueva = suma_vieja + arr[der] - arr[izq]</code></pre>

<p>Esa línea es el módulo entero. Convierte O(N × K) en O(N).</p>

<table>
  <thead><tr><th>Tipo</th><th>Cuándo</th><th>Cómo se mueve</th></tr></thead>
  <tbody>
    <tr><td><strong>Ventana fija</strong></td><td>El enunciado da el tamaño K</td><td>Entra uno, sale uno, siempre</td></tr>
    <tr><td><strong>Ventana variable</strong></td><td>Se pide "el más corto/largo que cumple…"</td><td>Crece por la derecha; encoge por la izquierda mientras se pueda</td></tr>
  </tbody>
</table>

<h2>📖 Problema 1 — Ventana fija</h2>

<div class="jc-problema">

<h3>La mejor ventana de K</h3>

<p><strong>Descripción.</strong> Dado un arreglo y un entero <code>K</code>, encontrar la suma máxima de <code>K</code> elementos <strong>consecutivos</strong>.</p>

<p><strong>Entrada.</strong> Dos líneas: el arreglo, y el valor de <code>K</code>.</p>

<p><strong>Salida.</strong> La suma máxima.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>2 1 5 1 3 2</code><br><code>3</code></td><td><code>9</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> La ventana <code>5 1 3</code> suma 9, más que cualquier otra de tamaño 3.</p>

</div>

<h3>El desperdicio de la fuerza bruta</h3>

<pre><code>for i in range(len(arr) - k + 1):
    suma = 0
    for j in range(i, i + k):     # ❌ vuelve a sumar todo
        suma += arr[j]</code></pre>

<p>Entre la ventana que empieza en <code>i</code> y la que empieza en <code>i+1</code> hay <strong>K−1 elementos idénticos</strong>. Sumarlos otra vez es tirar trabajo. Con N = 10⁵ y K = 10³ son 10⁸ operaciones.</p>

<h3>El código</h3>

<pre><code>arr = [int(x) for x in input().split()]
k = int(input())

# Primera ventana: esta sí toca sumarla completa
suma = 0
for i in range(k):
    suma += arr[i]

mejor = suma

for i in range(k, len(arr)):
    suma += arr[i] - arr[i - k]     # entra el nuevo, sale el que quedó atrás
    if suma &gt; mejor:
        mejor = suma

print(mejor)</code></pre>

<h3>La película con <code>[2, 1, 5, 1, 3, 2]</code>, K = 3</h3>

<table>
  <thead><tr><th>Ventana</th><th>Entra</th><th>Sale</th><th>Suma</th><th>Mejor</th></tr></thead>
  <tbody>
    <tr><td><code>2 1 5</code></td><td>—</td><td>—</td><td>8</td><td>8</td></tr>
    <tr><td><code>1 5 1</code></td><td>1</td><td>2</td><td>8 + 1 − 2 = 7</td><td>8</td></tr>
    <tr><td><code>5 1 3</code></td><td>3</td><td>1</td><td>7 + 3 − 1 = <b>9</b></td><td><b>9</b></td></tr>
    <tr><td><code>1 3 2</code></td><td>2</td><td>5</td><td>9 + 2 − 5 = 6</td><td>9</td></tr>
  </tbody>
</table>

<p>Cuatro sumas de dos términos, en vez de cuatro sumas de tres elementos cada una. Con K grande la diferencia es brutal.</p>

<h2>📖 Problema 2 — Ventana variable</h2>

<div class="jc-problema">

<h3>El subarreglo más corto</h3>

<p><strong>Descripción.</strong> Dado un arreglo de enteros <strong>positivos</strong> y un objetivo <code>S</code>, encontrar la longitud del subarreglo contiguo <strong>más corto</strong> cuya suma sea al menos <code>S</code>.</p>

<p><strong>Entrada.</strong> Dos líneas: el arreglo, y el objetivo <code>S</code>.</p>

<p><strong>Salida.</strong> La longitud mínima, o <code>0</code> si ningún subarreglo alcanza.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>2 3 1 2 4 3</code><br><code>7</code></td><td><code>2</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> <code>4 3</code> suma 7 con solo dos elementos.</p>

</div>

<p>Aquí el tamaño no lo da el enunciado: es lo que se busca. La ventana <strong>respira</strong>.</p>

<pre><code>izq = 0
suma = 0
mejor = len(arr) + 1          # un valor imposible, marca "todavía nada"

for der in range(len(arr)):
    suma += arr[der]                      # CRECE por la derecha

    while suma &gt;= S:                      # ENCOGE mientras siga cumpliendo
        if der - izq + 1 &lt; mejor:
            mejor = der - izq + 1
        suma -= arr[izq]
        izq += 1

if mejor == len(arr) + 1:
    print(0)
else:
    print(mejor)</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué</th></tr></thead>
  <tbody>
    <tr><td><code>while</code> y no <code>if</code></td><td>Después de encoger una vez puede que <em>siga</em> cumpliendo: hay que seguir encogiendo</td></tr>
    <tr><td>Se mide antes de encoger</td><td>La ventana actual cumple; la de después de restar quizá no</td></tr>
    <tr><td>Números positivos</td><td>Es lo que garantiza que al quitar por la izquierda la suma <strong>baja</strong>. Con negativos esto no funciona</td></tr>
    <tr><td><code>len(arr) + 1</code></td><td>Longitud imposible, sirve de "infinito" sin importar nada</td></tr>
  </tbody>
</table>

<p><strong>Por qué sigue siendo O(N)</strong> aunque haya un <code>while</code> dentro de un <code>for</code>: <code>izq</code> solo avanza y nunca retrocede, así que en toda la ejecución se mueve como máximo N veces. Los dos índices juntos hacen 2N pasos.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Recalcular la ventana entera</h3>
<pre><code>suma = sum(arr[i:i+k])       # ❌ dentro del ciclo, es O(N × K) otra vez</code></pre>
<p><code>sum()</code> de un pedazo no es gratis: recorre los K elementos. Escribirlo corto no lo hace rápido.</p>

<h3>2. <code>if</code> en vez de <code>while</code> al encoger</h3>
<pre><code>if suma &gt;= S:                # ❌ encoge una sola vez
    ...</code></pre>
<p>Con <code>[1, 4, 4]</code> y S = 4, la respuesta es 1. Con <code>if</code>, la ventana no alcanza a encogerse hasta ese único elemento.</p>

<h3>3. Ventana variable con números negativos</h3>
<p>Todo el argumento de "quito por la izquierda y la suma baja" se cae. Si el enunciado permite negativos, esto no es ventana deslizante: es otro problema (mira Kadane, o sumas acumuladas).</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿El enunciado dice "contiguo" o "consecutivos"? Es candidato a ventana.</li>
  <li>¿Da el tamaño? Ventana fija: entra uno, sale uno.</li>
  <li>¿Pide el más corto o el más largo que cumple? Ventana variable: crece con el <code>for</code>, encoge con un <code>while</code>.</li>
  <li>Verifica que los datos sean positivos antes de confiar en el encogimiento.</li>
  <li>Nunca uses <code>sum()</code> de un pedazo dentro del ciclo: ahí se pierde toda la ganancia.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>suma += arr[i] - arr[i - k]</code></td><td>Deslizar una ventana fija</td></tr>
    <tr><td><code>for der in range(len(arr))</code></td><td>La ventana crece por la derecha</td></tr>
    <tr><td><code>while cumple: … izq += 1</code></td><td>La ventana encoge por la izquierda</td></tr>
    <tr><td><code>der - izq + 1</code></td><td>El tamaño actual de la ventana</td></tr>
    <tr><td><code>mejor = len(arr) + 1</code></td><td>"Infinito" para un mínimo de longitudes</td></tr>
    <tr><td>O(N)</td><td>Porque <code>izq</code> solo avanza, nunca retrocede</td></tr>
  </tbody>
</table>

<blockquote>Si dentro del ciclo vuelves a recorrer la ventana, no estás deslizando: estás haciendo fuerza bruta con nombre bonito.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 5 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 12 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 12 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'La mejor ventana de K', 'medio', '<p>La primera línea trae el arreglo y la segunda el tamaño <code>K</code>. Imprime la suma máxima de <code>K</code> elementos <strong>consecutivos</strong>.</p><pre><code>Entrada:
2 1 5 1 3 2
3

Salida:
9</code></pre><p>La ventana <code>5 1 3</code> suma 9. Tiene que ser O(N): nada de recalcular la ventana entera cada vez.</p>', '<p>Suma la primera ventana completa. Después, en cada paso: <code>suma += arr[i] - arr[i - k]</code>. Entra el nuevo, sale el que quedó K posiciones atrás.</p>', '<pre><code>''''''
Programa: La mejor ventana de K
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Suma maxima de K elementos consecutivos, deslizando una ventana
    en vez de recalcularla en cada posicion.
''''''


def mejor_ventana(arr, k):
    ''''''
    Encuentra la suma maxima de k elementos consecutivos.

    Parametros:
        arr (list): numeros
        k (int): tamano de la ventana

    Retorna:
        int: la suma maxima
    ''''''
    # La PRIMERA ventana si toca sumarla completa: es la unica
    suma = 0
    for i in range(k):
        suma += arr[i]

    mejor = suma

    for i in range(k, len(arr)):
        # ENTRA arr[i] por la derecha, SALE arr[i - k] por la izquierda.
        # Los k - 2 del medio no se vuelven a tocar: ahi esta la ganancia
        suma += arr[i] - arr[i - k]

        if suma > mejor:
            mejor = suma

    return mejor


# Inicio
arr = [int(x) for x in input().split()]
k = int(input())

print(mejor_ventana(arr, k))
# Fin</code></pre><p>La fuerza bruta hace esto:</p><pre><code>for i in range(len(arr) - k + 1):
    suma = sum(arr[i:i+k])      # recorre los k elementos otra vez</code></pre><p>Y ahí está el desperdicio: entre la ventana que empieza en <code>i</code> y la que empieza en <code>i+1</code> hay <strong>K−1 elementos idénticos</strong>. Solo cambian los dos de los bordes.</p><ul><li><strong><code>arr[i - k]</code> es el que sale.</strong> Está exactamente K posiciones atrás del que entra. Equivocarse por uno aquí es el error clásico: prueba con K=1, donde el que sale es el mismo de la vuelta anterior.</li><li><strong>Cuidado con <code>sum(arr[i:i+k])</code>.</strong> Escribirlo en una línea no lo hace rápido: sigue recorriendo K elementos. Con N = 10⁵ y K = 10³ son 10⁸ operaciones contra 10⁵.</li><li><strong>No inicialices <code>mejor</code> en 0.</strong> Con puros negativos la respuesta es negativa, y un 0 inicial se la comería. Por eso arranca en la suma de la primera ventana.</li></ul><p>La traza con <code>[2,1,5,1,3,2]</code> y K=3: 8 → 8+1−2 = 7 → 7+3−1 = <strong>9</strong> → 9+2−5 = 6.</p>', '[{"stdin":"2 1 5 1 3 2\n3\n","expected_output":"9\n"},{"stdin":"1 2 3 4 5\n2\n","expected_output":"9\n"},{"stdin":"5\n1\n","expected_output":"5\n"},{"stdin":"-1 -2 -3\n2\n","expected_output":"-3\n"},{"stdin":"1 1 1 1\n4\n","expected_output":"4\n"},{"stdin":"4 2 1 7 8 1 2 8 1 0\n3\n","expected_output":"16\n"}]', '''''''
Programa: La mejor ventana de K
Autor:
Fecha:
Descripcion:
''''''


def mejor_ventana(arr, k):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'El subarreglo más corto', 'dificil', '<p>La primera línea trae un arreglo de enteros <strong>positivos</strong> y la segunda un objetivo <code>S</code>. Imprime la longitud del subarreglo contiguo <strong>más corto</strong> cuya suma sea al menos <code>S</code>. Si ninguno alcanza, imprime <code>0</code>.</p><pre><code>Entrada:
2 3 1 2 4 3
7

Salida:
2</code></pre><p><code>4 3</code> suma 7 con solo dos elementos.</p>', '<p>Aquí el tamaño no lo da el enunciado: la ventana respira. Crece con el <code>for</code> por la derecha, y encoge con un <code>while</code> por la izquierda mientras siga cumpliendo.</p>', '<pre><code>''''''
Programa: El subarreglo mas corto
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Longitud del subarreglo contiguo mas corto con suma al menos S,
    con una ventana que crece y encoge.
''''''


def mas_corto(arr, S):
    ''''''
    Busca el subarreglo contiguo mas corto con suma >= S.

    Parametros:
        arr (list): enteros positivos
        S (int): suma minima exigida

    Retorna:
        int: la longitud minima, o 0 si ninguno alcanza
    ''''''
    izq = 0
    suma = 0

    # Longitud imposible: sirve de ''infinito'' sin importar nada
    mejor = len(arr) + 1

    for der in range(len(arr)):
        # CRECE por la derecha
        suma += arr[der]

        # ENCOGE mientras siga cumpliendo. WHILE y no IF: despues de
        # encoger una vez la ventana puede seguir alcanzando
        while suma >= S:
            # Se mide ANTES de restar: esta ventana cumple, la de
            # despues de quitar el de la izquierda quiza no
            if der - izq + 1 < mejor:
                mejor = der - izq + 1

            suma -= arr[izq]
            izq += 1

    if mejor == len(arr) + 1:
        return 0

    return mejor


# Inicio
arr = [int(x) for x in input().split()]
S = int(input())

print(mas_corto(arr, S))
# Fin</code></pre><p>La ventana variable es la versión difícil de la técnica, y tiene tres puntos donde todo el mundo se cae:</p><ul><li><strong><code>while</code> y no <code>if</code>.</strong> Con <code>[1, 4, 4]</code> y S = 4 la respuesta es 1. Un <code>if</code> encoge una sola vez por vuelta y nunca llega a la ventana de un solo elemento.</li><li><strong>Medir antes de restar.</strong> El orden importa: en el momento en que entras al <code>while</code>, la ventana <em>actual</em> es la que cumple.</li><li><strong>Los números tienen que ser positivos.</strong> Todo el argumento del encogimiento es "si quito por la izquierda, la suma baja". Con negativos eso es falso y la técnica no aplica — ese sería otro problema.</li></ul><p><strong>Por qué es O(N)</strong> aunque haya un <code>while</code> dentro de un <code>for</code>: <code>izq</code> solo avanza, nunca retrocede. En toda la ejecución se mueve como máximo N veces, así que entre los dos índices hacen 2N pasos. Contar ciclos anidados no sirve para esta técnica; hay que contar cuánto se mueve cada índice en total.</p>', '[{"stdin":"2 3 1 2 4 3\n7\n","expected_output":"2\n"},{"stdin":"1 4 4\n4\n","expected_output":"1\n"},{"stdin":"1 1 1 1\n7\n","expected_output":"0\n"},{"stdin":"5\n5\n","expected_output":"1\n"},{"stdin":"1 2 3 4\n10\n","expected_output":"4\n"},{"stdin":"1 2 3 4\n11\n","expected_output":"0\n"}]', '''''''
Programa: El subarreglo mas corto
Autor:
Fecha:
Descripcion:
''''''


def mas_corto(arr, S):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'La racha sin repetir', 'dificil', '<p>La entrada trae una cadena. Imprime la longitud de la <strong>subcadena contigua más larga sin caracteres repetidos</strong>.</p><pre><code>Entrada:
abcabcbb

Salida:
3</code></pre><p>La mejor es <code>abc</code>, con 3. Si la cadena está vacía, imprime 0.</p>', '<p>Ventana variable con un diccionario: guarda la última posición donde viste cada carácter. Si el carácter que entra ya está <em>dentro</em> de la ventana, salta <code>izq</code> justo después de su aparición anterior.</p>', '<pre><code>''''''
Programa: La racha sin repetir
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Longitud de la subcadena contigua mas larga sin caracteres
    repetidos, con ventana variable y un diccionario de posiciones.
''''''


def sin_repetir(s):
    ''''''
    Busca la subcadena mas larga sin repetidos.

    Parametros:
        s (str): la cadena a analizar

    Retorna:
        int: la longitud maxima
    ''''''
    ultimo = {}    # caracter -> ultima posicion donde aparecio
    izq = 0
    mejor = 0

    for der in range(len(s)):
        c = s[der]

        # Solo importa si la aparicion anterior esta DENTRO de la
        # ventana. Si quedo atras de izq, ya no cuenta como repetido
        if c in ultimo and ultimo[c] >= izq:
            # Salto directo: la ventana empieza justo despues del
            # repetido, sin ir quitando uno por uno
            izq = ultimo[c] + 1

        ultimo[c] = der

        if der - izq + 1 > mejor:
            mejor = der - izq + 1

    return mejor


# Inicio
s = input()
print(sin_repetir(s))
# Fin</code></pre><p>Esta es la ventana variable en su forma más útil: la condición ya no es una suma, sino <strong>"no hay repetidos adentro"</strong>. Y el diccionario es lo que permite verificarla sin recorrer la ventana.</p><ul><li><strong><code>ultimo[c] &gt;= izq</code> es la clave.</strong> Que un carácter haya aparecido antes no lo hace un repetido: solo cuenta si esa aparición sigue <em>dentro</em> de la ventana. Sin esa comparación, <code>izq</code> podría saltar hacia atrás y romper todo.</li><li><strong>El salto en vez del encogimiento uno por uno.</strong> Aquí no hace falta un <code>while</code>: se sabe exactamente dónde tiene que quedar la izquierda, así que se salta de una.</li><li><strong><code>ultimo[c] = der</code> va después del salto.</strong> Al revés, se sobrescribe la posición vieja justo antes de necesitarla.</li><li><strong>Se mide en cada vuelta.</strong> La ventana siempre es válida al final del cuerpo del ciclo, así que ahí se compara.</li></ul><p>Con <code>pwwkew</code> la respuesta es 3 (<code>wke</code>), no 4: <code>pwke</code> no es contiguo. La palabra "contigua" del enunciado es la que descarta esa trampa.</p>', '[{"stdin":"abcabcbb\n","expected_output":"3\n"},{"stdin":"bbbbb\n","expected_output":"1\n"},{"stdin":"pwwkew\n","expected_output":"3\n"},{"stdin":"abcdef\n","expected_output":"6\n"},{"stdin":"au\n","expected_output":"2\n"},{"stdin":"\n","expected_output":"0\n"}]', '''''''
Programa: La racha sin repetir
Autor:
Fecha:
Descripcion:
''''''


def sin_repetir(s):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 12 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la línea que define la ventana deslizante de tamaño fijo?', NULL, '{"options":[{"id":"a","text":"suma += arr[i] - arr[i - k]"},{"id":"b","text":"suma = sum(arr[i:i+k])"},{"id":"c","text":"suma += arr[i]"},{"id":"d","text":"suma = max(suma, arr[i])"}]}', '{"option_id":"a"}', 'Entra uno por la derecha, sale uno por la izquierda, y los K−2 del medio no se vuelven a tocar. La opción b recorre los K elementos cada vez: es la fuerza bruta escrita corta.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué la fuerza bruta desperdicia trabajo al recorrer ventanas de tamaño K?', NULL, '{"options":[{"id":"a","text":"Porque entre una ventana y la siguiente hay K−1 elementos idénticos que vuelve a sumar"},{"id":"b","text":"Porque usa demasiada memoria"},{"id":"c","text":"Porque recorre el arreglo al revés"},{"id":"d","text":"Porque ordena el arreglo"}]}', '{"option_id":"a"}', 'Solo cambian los dos de los bordes. Con N = 10⁵ y K = 10³, recalcular todo son 10⁸ operaciones contra 10⁵ deslizando.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'En la ventana variable, ¿por qué el encogimiento se hace con while y no con if?', NULL, '{"options":[{"id":"a","text":"Porque después de encoger una vez la ventana puede seguir cumpliendo, y hay que seguir encogiendo"},{"id":"b","text":"Porque if no permite restar"},{"id":"c","text":"Porque el for ya usa un if"},{"id":"d","text":"Porque while es más rápido"}]}', '{"option_id":"a"}', 'Con [1, 4, 4] y S = 4 la respuesta es 1. Un if encoge una sola vez y nunca llega a la ventana de un solo elemento.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué la ventana variable sigue siendo O(N), si tiene un while dentro de un for?', NULL, '{"options":[{"id":"a","text":"Porque izq solo avanza y nunca retrocede: en total se mueve como máximo N veces"},{"id":"b","text":"Porque el while casi nunca se ejecuta"},{"id":"c","text":"Porque el arreglo está ordenado"},{"id":"d","text":"No lo es: es O(N²)"}]}', '{"option_id":"a"}', 'Los dos índices juntos hacen a lo sumo 2N pasos. Contar ciclos anidados no sirve aquí: hay que contar cuánto se mueve cada índice en toda la ejecución.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Qué requisito tienen los datos para que la ventana variable funcione?', NULL, '{"options":[{"id":"a","text":"Que sean positivos, para que quitar por la izquierda baje la suma"},{"id":"b","text":"Que estén ordenados"},{"id":"c","text":"Que no haya repetidos"},{"id":"d","text":"Que la cantidad sea par"}]}', '{"option_id":"a"}', 'Con negativos, quitar un elemento por la izquierda puede SUBIR la suma, y todo el argumento del encogimiento se cae. Ese caso es otro problema: Kadane o sumas acumuladas.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'arr = [2, 1, 5, 1, 3, 2]
k = 3
suma = sum(arr[:k])
mejor = suma
for i in range(k, len(arr)):
    suma += arr[i] - arr[i - k]
    if suma > mejor:
        mejor = suma
print(mejor)', '{"options":[{"id":"a","text":"9"},{"id":"b","text":"8"},{"id":"c","text":"14"},{"id":"d","text":"6"}]}', '{"option_id":"a"}', 'Las ventanas suman 8, 7, 9 y 6. La mejor es 5 1 3 = 9. El 14 sería la suma de todo el arreglo, que no es una ventana de tamaño 3.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este programa vuelve a ser O(N × K). ¿En qué línea está el problema?', NULL, '{"lines":["mejor = 0","for i in range(len(arr) - k + 1):","    suma = sum(arr[i:i+k])","    if suma > mejor:","        mejor = suma","print(mejor)"]}', '{"line_number":3}', 'sum() de un pedazo recorre los K elementos en cada vuelta. Escribirlo en una línea no lo hace rápido: sigue siendo la fuerza bruta.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa la ventana fija de tamaño k.', NULL, '{"code":"suma = 0\nfor i in range(k):\n    suma += arr[i]\n\nmejor = suma\n\nfor i in range(k, len(arr)):\n    suma += arr[i] - arr[___1___]\n    if suma > mejor:\n        mejor = ___2___","blanks":[{"id":"1","pista":"el que sale por la izquierda"},{"id":"2","pista":"la suma de la ventana actual"}]}', '{"answers":{"1":["i - k"],"2":["suma"]}}', 'El que sale está exactamente k posiciones atrás del que entra. La primera ventana sí hay que sumarla completa: es la única.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa la ventana variable que busca el subarreglo más corto con suma >= S.', NULL, '{"code":"izq = 0\nsuma = 0\nmejor = len(arr) + 1\n\nfor der in range(len(arr)):\n    suma += arr[der]\n\n    ___1___ suma >= S:\n        if der - izq + 1 < mejor:\n            mejor = der - izq + 1\n        suma -= arr[izq]\n        izq += ___2___","blanks":[{"id":"1","pista":"puede seguir cumpliendo después de encoger"},{"id":"2","pista":"la izquierda avanza una posición"}]}', '{"answers":{"1":["while"],"2":["1"]}}', 'Crece con el for, encoge con el while. Y se mide ANTES de restar, porque la ventana de después de restar quizá ya no cumple.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma la ventana variable del subarreglo más corto', NULL, '{"lines":[{"id":"w1","text":"izq = 0","indent":0},{"id":"w2","text":"suma = 0","indent":0},{"id":"w3","text":"mejor = len(arr) + 1","indent":0},{"id":"w4","text":"for der in range(len(arr)):","indent":0},{"id":"w5","text":"suma += arr[der]","indent":1},{"id":"w6","text":"while suma >= S:","indent":1},{"id":"w7","text":"if der - izq + 1 < mejor:","indent":2},{"id":"w8","text":"mejor = der - izq + 1","indent":3},{"id":"w9","text":"suma -= arr[izq]","indent":2},{"id":"w10","text":"izq += 1","indent":2}]}', '{"order":["w1","w2","w3","w4","w5","w6","w7","w8","w9","w10"]}', 'Primero entra el elemento nuevo, después se intenta encoger. Medir va antes de restar: la ventana actual cumple, la siguiente puede que no.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En [2, 3, 1, 2, 4, 3] con S = 7, ¿cuál es la longitud del subarreglo más corto con suma al menos 7?', NULL, '{"options":[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"6"}]}', '{"option_id":"a"}', 'El 4 y el 3 del final suman exactamente 7 con dos elementos. Hay uno de tres que también alcanza (1 2 4 suma 7), pero se pide el más corto.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'avanzado';

-- ── Capítulo 13: BFS — camino más corto (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 13, 'BFS — camino más corto', '🌐', 'Explorar por niveles con una cola: la primera vez que lo ves, es el camino mínimo.', '<p class="jc-gancho">BFS explora por niveles: primero todo lo que está a un paso, después todo lo que está a dos. Por eso <strong>la primera vez que llega a una celda, llegó por el camino más corto</strong>. Esa propiedad no es un detalle: es toda la razón para usarlo.</p>

<h2>💡 La idea</h2>

<p>Se usa una <strong>cola</strong>: lo primero que entra es lo primero que sale. Se saca una celda, se meten sus vecinos no visitados, se repite. Como los vecinos de nivel 1 entraron antes que los de nivel 2, salen antes — y el recorrido avanza en ondas.</p>

<pre><code>Salida = S, muro = #

. . . .        0 1 2 3
S # # .   →    ↓ # # 4      cada número es la distancia
. . . .        1 2 3 4      desde la salida</code></pre>

<blockquote><strong>La propiedad clave:</strong> en un grafo donde todos los pasos cuestan lo mismo, la primera vez que BFS visita un nodo lo hace con la distancia mínima. Por eso se marca visitado <em>al encolar</em> y no al sacar.</blockquote>

<h3>BFS contra DFS</h3>

<table>
  <thead><tr><th></th><th>BFS</th><th>DFS</th></tr></thead>
  <tbody>
    <tr><td>Estructura</td><td>Cola (<code>popleft</code>)</td><td>Pila o recursión</td></tr>
    <tr><td>Cómo explora</td><td>Por niveles, en ondas</td><td>Hasta el fondo, después retrocede</td></tr>
    <tr><td>Sirve para</td><td><strong>Camino más corto</strong></td><td>Conectividad, componentes, ciclos</td></tr>
  </tbody>
</table>

<p>DFS también encuentra <em>un</em> camino. BFS encuentra <strong>el más corto</strong>. Si el enunciado dice "mínimo número de pasos", es BFS y no hay discusión.</p>

<h2>📖 El problema</h2>

<div class="jc-problema">

<h3>El laberinto</h3>

<p><strong>Descripción.</strong> Un mapa rectangular donde <code>.</code> es una casilla libre y <code>#</code> es un muro. Empezando en la esquina superior izquierda, hay que llegar a la inferior derecha moviéndose en las <strong>cuatro direcciones</strong> (arriba, abajo, izquierda, derecha), una casilla por paso.</p>

<p><strong>Entrada.</strong> La primera línea trae dos enteros: filas y columnas. Después vienen las filas del mapa.</p>

<p><strong>Salida.</strong> El mínimo número de pasos, o <code>-1</code> si no hay camino.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>3 4</code><br><code>....</code><br><code>.##.</code><br><code>....</code></td><td><code>5</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> Bajando por la primera columna y avanzando por la última fila: 2 + 3 = 5 pasos.</p>

</div>

<h2>💻 Código paso a paso</h2>

<pre><code>from collections import deque

datos = input().split()
n = int(datos[0])
m = int(datos[1])

grid = []
for i in range(n):
    grid.append(input())

# dist[f][c] = pasos desde la salida. -1 significa "no visitada"
dist = []
for i in range(n):
    dist.append([-1] * m)

dist[0][0] = 0
cola = deque()
cola.append((0, 0))

# Las cuatro direcciones: arriba, abajo, izquierda, derecha
direcciones = [(-1, 0), (1, 0), (0, -1), (0, 1)]

while len(cola) &gt; 0:
    f, c = cola.popleft()               # POPLEFT: cola, no pila

    for df, dc in direcciones:
        nf = f + df
        nc = c + dc

        if 0 &lt;= nf &lt; n and 0 &lt;= nc &lt; m:          # dentro del mapa
            if grid[nf][nc] == "." and dist[nf][nc] == -1:
                dist[nf][nc] = dist[f][c] + 1     # marcar AL ENCOLAR
                cola.append((nf, nc))

print(dist[n - 1][m - 1])</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué</th></tr></thead>
  <tbody>
    <tr><td><code>popleft()</code></td><td>Cola. Con <code>pop()</code> sería una pila y el recorrido pasa a ser DFS: los caminos que encuentre ya no son mínimos</td></tr>
    <tr><td><code>dist</code> hace de visitados</td><td>Dos cosas en una matriz: <code>-1</code> es "no visitada" y cualquier otro valor es la distancia</td></tr>
    <tr><td>Marcar <strong>al encolar</strong></td><td>Si se marca al sacar, la misma celda entra varias veces y la cola explota</td></tr>
    <tr><td>Chequear límites <em>antes</em></td><td>En Python <code>grid[-1]</code> no falla: da la última fila. El error sería silencioso</td></tr>
    <tr><td><code>dist[n-1][m-1]</code></td><td>Si quedó en −1 es que nunca se llegó: justo el <code>-1</code> que pide el enunciado</td></tr>
  </tbody>
</table>

<h3>La película, en ondas</h3>

<p>Con el mapa del ejemplo, así crecen las distancias:</p>

<pre><code>Nivel 0:  (0,0)
Nivel 1:  (0,1)  (1,0)
Nivel 2:  (0,2)  (2,0)
Nivel 3:  (0,3)  (2,1)
Nivel 4:  (1,3)  (2,2)
Nivel 5:  (2,3)   ← la meta</code></pre>

<p>Fíjate en que la meta aparece en el nivel 5 y no antes: eso <em>es</em> la respuesta. Y aparece una sola vez, porque al encolarla quedó marcada.</p>

<h2>🔍 La variante: varias fuentes a la vez</h2>

<p>Si en vez de una salida hay muchas —un incendio que empieza en varias casillas, por ejemplo— <strong>se meten todas en la cola al principio, todas con distancia 0</strong>. El resto del código no cambia.</p>

<pre><code>for i in range(n):
    for j in range(m):
        if grid[i][j] == "F":
            dist[i][j] = 0
            cola.append((i, j))</code></pre>

<p>El resultado es la distancia de cada celda <strong>a la fuente más cercana</strong>, calculada en una sola pasada. Hacer un BFS por fuente y quedarse con el mínimo daría lo mismo, pero costaría F veces más.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Marcar visitado al sacar de la cola</h3>
<pre><code>f, c = cola.popleft()
dist[f][c] = ...          # ❌ tarde</code></pre>
<p>Entre que una celda se encola y se saca, otros vecinos la pueden encolar otra vez. La cola crece sin control y el programa se demora una eternidad — o da distancias mayores que las reales.</p>

<h3>2. Usar <code>pop()</code> en vez de <code>popleft()</code></h3>
<pre><code>f, c = cola.pop()         # ❌ eso es una pila: se volvió DFS</code></pre>
<p>Sigue encontrando un camino, pero ya no el más corto. Y es el error más difícil de ver, porque el programa <em>funciona</em> en los casos pequeños.</p>

<h3>3. Índices negativos sin revisar</h3>
<pre><code>if grid[nf][nc] == ".":   # ❌ sin chequear límites primero</code></pre>
<p>Con <code>nf = -1</code>, Python devuelve la última fila en vez de fallar. El recorrido se teletransporta de un borde al otro y nadie se entera.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿El enunciado dice "mínimo número de pasos/movimientos"? BFS.</li>
  <li><code>deque</code> y <code>popleft</code>. Nunca <code>pop()</code>.</li>
  <li>Marca visitado <strong>al encolar</strong>, no al sacar.</li>
  <li>Chequea límites antes de leer la casilla.</li>
  <li>Una matriz <code>dist</code> con <code>-1</code> sirve de visitados y de respuesta al mismo tiempo.</li>
  <li>¿Varias salidas? Todas a la cola con distancia 0, y una sola pasada.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>from collections import deque</code></td><td>La cola eficiente de Python</td></tr>
    <tr><td><code>cola.append(x)</code></td><td>Encolar por el final</td></tr>
    <tr><td><code>cola.popleft()</code></td><td>Sacar por el frente — esto es lo que hace BFS</td></tr>
    <tr><td><code>[(-1,0), (1,0), (0,-1), (0,1)]</code></td><td>Las cuatro direcciones</td></tr>
    <tr><td><code>dist[nf][nc] == -1</code></td><td>"Todavía no visitada"</td></tr>
    <tr><td><code>0 &lt;= nf &lt; n and 0 &lt;= nc &lt; m</code></td><td>Dentro del mapa</td></tr>
  </tbody>
</table>

<blockquote>Si tu BFS da caminos más largos de lo que deberían, mira dos líneas: si estás usando <code>pop()</code>, y si marcas visitado al sacar.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 5 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 13 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 13 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'El laberinto', 'medio', '<p>La primera línea trae filas y columnas. Después vienen las filas del mapa, con <code>.</code> para casilla libre y <code>#</code> para muro.</p><p>Imprime el mínimo número de pasos desde la esquina superior izquierda hasta la inferior derecha, moviéndote en las cuatro direcciones. Si no hay camino, imprime <code>-1</code>.</p><pre><code>Entrada:
3 4
....
.##.
....

Salida:
5</code></pre>', '<p><code>deque</code> y <code>popleft()</code>. Una matriz <code>dist</code> llena de <code>-1</code> sirve de visitados y de respuesta. Marca la distancia <strong>al encolar</strong>, nunca al sacar.</p>', '<pre><code>''''''
Programa: El laberinto
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Camino mas corto en una cuadricula con muros, usando BFS: se
    explora por niveles con una cola.
''''''

from collections import deque


def pasos_minimos(grid, n, m):
    ''''''
    Calcula el minimo de pasos de la esquina (0,0) a la (n-1,m-1).

    Parametros:
        grid (list): filas del mapa, con ''.'' libre y ''#'' muro
        n (int): cantidad de filas
        m (int): cantidad de columnas

    Retorna:
        int: pasos minimos, o -1 si no hay camino
    ''''''
    if grid[0][0] == "#":
        return -1

    # dist hace de dos cosas: -1 es ''no visitada'', y cualquier otro
    # valor es la distancia desde la salida
    dist = []
    for i in range(n):
        dist.append([-1] * m)

    dist[0][0] = 0

    cola = deque()
    cola.append((0, 0))

    # arriba, abajo, izquierda, derecha
    direcciones = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    while len(cola) > 0:
        # POPLEFT: saca por el frente. Con pop() seria una pila y el
        # recorrido pasaria a ser DFS, que no da caminos minimos
        f, c = cola.popleft()

        for df, dc in direcciones:
            nf = f + df
            nc = c + dc

            # Los limites SIEMPRE se revisan antes de leer la casilla:
            # en Python grid[-1] no falla, devuelve la ultima fila
            if 0 <= nf < n and 0 <= nc < m:
                if grid[nf][nc] == "." and dist[nf][nc] == -1:
                    # Marcar AL ENCOLAR. Si se marcara al sacar, la
                    # misma celda entraria varias veces a la cola
                    dist[nf][nc] = dist[f][c] + 1
                    cola.append((nf, nc))

    return dist[n - 1][m - 1]


# Inicio
datos = input().split()
n = int(datos[0])
m = int(datos[1])

grid = []
for i in range(n):
    grid.append(input())

print(pasos_minimos(grid, n, m))
# Fin</code></pre><p><strong>Por qué BFS y no DFS:</strong> DFS también encuentra <em>un</em> camino, pero BFS encuentra <strong>el más corto</strong>. Explora en ondas — primero todo lo que está a un paso, después todo lo que está a dos — así que la primera vez que toca una celda, llegó por el camino mínimo. Cuando el enunciado dice "mínimo número de pasos", no hay discusión.</p><p>Las tres líneas donde se pierde todo:</p><ul><li><strong><code>popleft()</code>, no <code>pop()</code>.</strong> El segundo saca por el final, o sea una pila. El programa sigue funcionando y dando respuestas — solo que más largas. Es el error más difícil de ver, porque en mapas pequeños suele coincidir.</li><li><strong>Marcar al encolar.</strong> Entre que una celda entra a la cola y sale, sus otros vecinos la volverían a encolar. La cola crece sin control.</li><li><strong>Límites antes de leer.</strong> Con <code>nf = -1</code>, Python devuelve la última fila en vez de fallar, y el recorrido se teletransporta de un borde al otro.</li></ul><p>El <code>-1</code> final sale gratis: si la meta nunca entró en ninguna onda, su casilla quedó con el <code>-1</code> inicial. Costo: O(N × M), porque cada celda entra a la cola a lo sumo una vez.</p>', '[{"stdin":"3 4\n....\n.##.\n....\n","expected_output":"5\n"},{"stdin":"3 3\n..#\n##.\n...\n","expected_output":"-1\n"},{"stdin":"1 1\n.\n","expected_output":"0\n"},{"stdin":"2 2\n.#\n..\n","expected_output":"2\n"},{"stdin":"3 2\n..\n#.\n#.\n","expected_output":"3\n"},{"stdin":"2 2\n.#\n#.\n","expected_output":"-1\n"}]', '''''''
Programa: El laberinto
Autor:
Fecha:
Descripcion:
''''''

from collections import deque


def pasos_minimos(grid, n, m):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'El incendio', 'dificil', '<p>El mismo formato de mapa, pero ahora hay tres símbolos: <code>.</code> casilla libre, <code>#</code> muro, y <code>F</code> una casilla donde ya hay fuego. Cada minuto el fuego se propaga a las casillas libres vecinas (cuatro direcciones).</p><p>Imprime en cuántos minutos arde <strong>toda</strong> casilla libre. Si alguna nunca se quema, imprime <code>-1</code>.</p><pre><code>Entrada:
3 4
F...
....
....

Salida:
5</code></pre><p>La esquina más lejana está a 5 pasos del fuego.</p>', '<p>BFS de <strong>varias fuentes</strong>: mete TODAS las <code>F</code> en la cola al principio, todas con distancia 0. El resto del BFS no cambia. La respuesta es la mayor distancia entre las casillas libres.</p>', '<pre><code>''''''
Programa: El incendio
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Minutos hasta que arda toda la cuadricula, con BFS de varias
    fuentes: todos los focos arrancan a la vez.
''''''

from collections import deque


def minutos_totales(grid, n, m):
    ''''''
    Calcula cuando arde la ultima casilla libre.

    Parametros:
        grid (list): filas del mapa, con ''.'', ''#'' y ''F''
        n (int): cantidad de filas
        m (int): cantidad de columnas

    Retorna:
        int: minutos hasta quemarlo todo, o -1 si algo no se quema
    ''''''
    dist = []
    for i in range(n):
        dist.append([-1] * m)

    cola = deque()

    # LA UNICA DIFERENCIA con el BFS normal: todas las fuentes entran
    # a la cola de una vez, todas con distancia 0. Asi cada celda
    # termina con la distancia a la fuente MAS CERCANA, en una pasada
    for i in range(n):
        for j in range(m):
            if grid[i][j] == "F":
                dist[i][j] = 0
                cola.append((i, j))

    direcciones = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    while len(cola) > 0:
        f, c = cola.popleft()

        for df, dc in direcciones:
            nf = f + df
            nc = c + dc

            if 0 <= nf < n and 0 <= nc < m:
                # El fuego pasa por todo lo que no sea muro
                if grid[nf][nc] != "#" and dist[nf][nc] == -1:
                    dist[nf][nc] = dist[f][c] + 1
                    cola.append((nf, nc))

    # La respuesta es la PEOR distancia entre las casillas libres:
    # el incendio termina cuando arde la ultima
    peor = 0
    for i in range(n):
        for j in range(m):
            if grid[i][j] == ".":
                if dist[i][j] == -1:
                    return -1      # esta casilla quedo aislada
                if dist[i][j] > peor:
                    peor = dist[i][j]

    return peor


# Inicio
datos = input().split()
n = int(datos[0])
m = int(datos[1])

grid = []
for i in range(n):
    grid.append(input())

print(minutos_totales(grid, n, m))
# Fin</code></pre><p>El truco de este problema es darse cuenta de que <strong>no hay que hacer un BFS por foco</strong>. Metiendo todas las fuentes en la cola con distancia 0, la propia mecánica de las ondas hace el trabajo: la primera onda que alcanza una celda viene, por construcción, del foco más cercano.</p><ul><li><strong>Un BFS por foco también funcionaría</strong>, quedándose con el mínimo — pero costaría F veces más. Con muchos focos, eso es la diferencia entre pasar y no pasar.</li><li><strong>La respuesta es el máximo, no el mínimo.</strong> El incendio termina cuando arde la <em>última</em> casilla, así que se busca la peor distancia.</li><li><strong>El <code>-1</code> se revisa solo sobre las casillas <code>.</code>.</strong> Los muros nunca se visitan y siempre quedan en −1: incluirlos daría −1 siempre.</li><li><strong>Sin fuego inicial</strong> la cola arranca vacía, el <code>while</code> no se ejecuta, y cualquier casilla libre queda en −1. El programa responde −1 sin necesidad de un caso especial.</li></ul>', '[{"stdin":"3 4\nF...\n....\n....\n","expected_output":"5\n"},{"stdin":"3 4\nF..#\n...#\n..F.\n","expected_output":"2\n"},{"stdin":"1 1\nF\n","expected_output":"0\n"},{"stdin":"2 2\nF.\n#.\n","expected_output":"2\n"},{"stdin":"2 3\n.F.\n...\n","expected_output":"2\n"},{"stdin":"2 3\nF.#\n.#.\n","expected_output":"-1\n"}]', '''''''
Programa: El incendio
Autor:
Fecha:
Descripcion:
''''''

from collections import deque


def minutos_totales(grid, n, m):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 13 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué estructura usa BFS y por qué?', NULL, '{"options":[{"id":"a","text":"Una cola: lo primero que entra es lo primero que sale, así explora por niveles"},{"id":"b","text":"Una pila: explora hasta el fondo primero"},{"id":"c","text":"Un diccionario ordenado por distancia"},{"id":"d","text":"Una lista que se ordena en cada paso"}]}', '{"option_id":"a"}', 'Los vecinos de nivel 1 entran antes que los de nivel 2, así que salen antes. Con una pila el recorrido pasa a ser DFS y los caminos que encuentra ya no son mínimos.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué BFS encuentra el camino MÁS CORTO?', NULL, '{"options":[{"id":"a","text":"Porque explora por niveles: la primera vez que llega a una celda, llegó con la distancia mínima"},{"id":"b","text":"Porque prueba todos los caminos y compara"},{"id":"c","text":"Porque ordena las celdas por distancia"},{"id":"d","text":"Porque usa recursión"}]}', '{"option_id":"a"}', 'Vale cuando todos los pasos cuestan lo mismo. Por eso se marca visitado AL ENCOLAR: la primera llegada ya es la mejor, y cualquier otra sería más larga.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Qué pasa si marcas la celda como visitada al SACARLA de la cola en vez de al encolarla?', NULL, '{"options":[{"id":"a","text":"La misma celda se encola varias veces y la cola crece sin control"},{"id":"b","text":"No cambia nada"},{"id":"c","text":"El programa lanza IndexError"},{"id":"d","text":"Se vuelve DFS"}]}', '{"option_id":"a"}', 'Entre que una celda entra y sale, otros vecinos la vuelven a encolar. El programa se demora una eternidad y puede reportar distancias mayores que las reales.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Si cambias popleft() por pop(), ¿qué pasa?', NULL, '{"options":[{"id":"a","text":"El recorrido se vuelve DFS: encuentra un camino, pero no el más corto"},{"id":"b","text":"El programa se cuelga"},{"id":"c","text":"No compila"},{"id":"d","text":"Es igual, solo más rápido"}]}', '{"option_id":"a"}', 'pop() saca por el final: eso es una pila. Es el error más difícil de detectar, porque en mapas pequeños el resultado suele coincidir con el correcto.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En un laberinto de N filas por M columnas, ¿cuál es la complejidad de BFS?', NULL, '{"options":[{"id":"a","text":"O(N × M): cada celda entra a la cola a lo sumo una vez"},{"id":"b","text":"O(N × M × 4!)"},{"id":"c","text":"O(2^(N×M))"},{"id":"d","text":"O(N + M)"}]}', '{"option_id":"a"}', 'Marcar al encolar garantiza que ninguna celda entra dos veces, y de cada una se revisan 4 vecinos: eso es una constante.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'En este mapa 3x4, ¿cuántos pasos mínimos hay de la esquina superior izquierda a la inferior derecha?', '....
.##.
....', '{"options":[{"id":"a","text":"5"},{"id":"b","text":"6"},{"id":"c","text":"7"},{"id":"d","text":"-1, no hay camino"}]}', '{"option_id":"a"}', 'Bajando por la primera columna (2 pasos) y avanzando por la última fila (3 pasos): 5. También se puede por arriba, con la misma cuenta — los muros del centro no alargan el camino.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'Este BFS puede leer casillas equivocadas sin dar error. ¿En qué línea está el problema?', NULL, '{"lines":["for df, dc in direcciones:","    nf = f + df","    nc = c + dc","    if grid[nf][nc] == ''.'' and dist[nf][nc] == -1:","        dist[nf][nc] = dist[f][c] + 1","        cola.append((nf, nc))"]}', '{"line_number":4}', 'Lee la casilla antes de verificar los límites. Con nf = -1 Python no falla: devuelve la última fila, y el recorrido se teletransporta de un borde al otro sin que nadie se entere.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el núcleo del BFS.', NULL, '{"code":"dist[0][0] = 0\ncola = deque()\ncola.append((0, 0))\n\nwhile len(cola) > 0:\n    f, c = cola.___1___()\n\n    for df, dc in direcciones:\n        nf = f + df\n        nc = c + dc\n        if 0 <= nf < n and 0 <= nc < m:\n            if grid[nf][nc] == \".\" and dist[nf][nc] == ___2___:\n                dist[nf][nc] = dist[f][c] + 1\n                cola.append((nf, nc))","blanks":[{"id":"1","pista":"sacar por el frente: eso es una cola"},{"id":"2","pista":"la marca de ''no visitada''"}]}', '{"answers":{"1":["popleft"],"2":["-1"]}}', 'popleft es lo que hace que sea BFS. Y la matriz dist sirve de dos cosas: −1 significa no visitada, y cualquier otro valor es la distancia.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa el BFS de varias fuentes (todas arrancan a la vez).', NULL, '{"code":"cola = deque()\n\nfor i in range(n):\n    for j in range(m):\n        if grid[i][j] == \"F\":\n            dist[i][j] = ___1___\n            cola.___2___((i, j))\n\n# el resto del BFS no cambia","blanks":[{"id":"1","pista":"todas las fuentes arrancan igual"},{"id":"2","pista":"meter a la cola"}]}', '{"answers":{"1":["0"],"2":["append"]}}', 'Metiendo todas las fuentes con distancia 0, una sola pasada da la distancia de cada celda a la fuente MÁS CERCANA. Un BFS por fuente daría lo mismo pero costaría F veces más.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arma el ciclo principal de BFS', NULL, '{"lines":[{"id":"q1","text":"while len(cola) > 0:","indent":0},{"id":"q2","text":"f, c = cola.popleft()","indent":1},{"id":"q3","text":"for df, dc in direcciones:","indent":1},{"id":"q4","text":"nf = f + df","indent":2},{"id":"q5","text":"nc = c + dc","indent":2},{"id":"q6","text":"if 0 <= nf < n and 0 <= nc < m:","indent":2},{"id":"q7","text":"if grid[nf][nc] == ''.'' and dist[nf][nc] == -1:","indent":3},{"id":"q8","text":"dist[nf][nc] = dist[f][c] + 1","indent":4},{"id":"q9","text":"cola.append((nf, nc))","indent":4}]}', '{"order":["q1","q2","q3","q4","q5","q6","q7","q8","q9"]}', 'Primero los límites, después el contenido de la casilla. Y la distancia se asigna justo antes de encolar: esa es la marca de visitado.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Al terminar el BFS, ¿cómo se sabe que no había camino a la meta?', NULL, '{"options":[{"id":"a","text":"Porque dist en la meta quedó en -1: nunca se visitó"},{"id":"b","text":"Porque la cola quedó llena"},{"id":"c","text":"Porque el programa lanza una excepción"},{"id":"d","text":"Porque dist en la meta quedó en 0"}]}', '{"option_id":"a"}', 'El −1 inicial nunca se sobrescribió, así que la celda quedó fuera de todas las ondas. Y ese −1 es justo lo que el enunciado pide imprimir.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'avanzado';

-- ── Capítulo 14: DFS — componentes conexas (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 14, 'DFS — componentes conexas', '🕳️', 'Hasta el fondo antes de retroceder. Un DFS lanzado = una componente.', '<p class="jc-gancho">DFS va hasta el fondo antes de retroceder. Y de ahí sale la idea que resuelve media docena de problemas de concurso: <strong>un DFS lanzado desde una celda pinta toda su componente</strong>. Así que contar componentes es contar cuántas veces tuviste que lanzarlo.</p>

<h2>💡 La idea</h2>

<p>La estructura de datos es una <strong>pila</strong> (o la pila de llamadas, si lo escribes recursivo). Se saca el último que entró, se meten sus vecinos, y el recorrido se hunde por una rama hasta que no puede más.</p>

<pre><code>for cada celda:
    if es tierra and no visitada:
        componentes += 1
        dfs(celda)           # marca TODA la isla de una vez</code></pre>

<p>El <code>for</code> exterior no encuentra islas: encuentra <strong>puntos de partida</strong>. Cada vez que entra al <code>if</code> es porque tropezó con una isla que nadie había pintado.</p>

<h3>BFS o DFS: cuál usar</h3>

<table>
  <thead><tr><th>Necesitas</th><th>Usa</th></tr></thead>
  <tbody>
    <tr><td>Camino más corto, mínimo de pasos</td><td><strong>BFS</strong> (módulo anterior)</td></tr>
    <tr><td>Contar componentes, tamaños, "¿están conectados?"</td><td><strong>DFS</strong> o BFS, da igual</td></tr>
  </tbody>
</table>

<p>Para conectividad las dos sirven — lo único que importa es visitar todo. DFS suele escribirse más corto.</p>

<h2>📖 El problema</h2>

<div class="jc-problema">

<h3>Contar islas</h3>

<p><strong>Descripción.</strong> Un mapa donde <code>#</code> es tierra y <code>.</code> es agua. Dos casillas de tierra pertenecen a la misma isla si están pegadas en alguna de las <strong>cuatro direcciones</strong> (arriba, abajo, izquierda, derecha).</p>

<p><strong>Entrada.</strong> La primera línea trae filas y columnas. Después, las filas del mapa.</p>

<p><strong>Salida.</strong> Cuántas islas hay.</p>

<table>
  <thead><tr><th>Entrada</th><th>Salida</th></tr></thead>
  <tbody><tr><td><code>3 3</code><br><code>#.#</code><br><code>...</code><br><code>#.#</code></td><td><code>4</code></td></tr></tbody>
</table>

<p><strong>Explicación.</strong> Las cuatro esquinas son tierra, y ninguna toca a otra por los lados.</p>

</div>

<h2>💻 Código paso a paso</h2>

<p>La versión <strong>iterativa</strong>, que es la que conviene en competencia:</p>

<pre><code>datos = input().split()
n = int(datos[0])
m = int(datos[1])

grid = []
for i in range(n):
    grid.append(input())

visitado = []
for i in range(n):
    visitado.append([False] * m)

direcciones = [(-1, 0), (1, 0), (0, -1), (0, 1)]

islas = 0

for i in range(n):
    for j in range(m):
        if grid[i][j] == "#" and not visitado[i][j]:
            islas += 1                       # una isla nueva

            pila = [(i, j)]
            visitado[i][j] = True

            while len(pila) &gt; 0:
                f, c = pila.pop()            # POP: el último que entró

                for df, dc in direcciones:
                    nf = f + df
                    nc = c + dc

                    if 0 &lt;= nf &lt; n and 0 &lt;= nc &lt; m:
                        if grid[nf][nc] == "#" and not visitado[nf][nc]:
                            visitado[nf][nc] = True
                            pila.append((nf, nc))

print(islas)</code></pre>

<table>
  <thead><tr><th>Pieza</th><th>Por qué</th></tr></thead>
  <tbody>
    <tr><td><code>pila.pop()</code></td><td>Saca el último: eso es DFS. Cambiándolo por <code>popleft()</code> sería BFS, y para contar islas da exactamente lo mismo</td></tr>
    <tr><td>El doble <code>for</code> exterior</td><td>Busca puntos de partida. Sin él, solo se contaría la isla que toque la primera celda</td></tr>
    <tr><td><code>islas += 1</code> <em>antes</em> del recorrido</td><td>Se cuenta al descubrir la isla, no por cada celda que se visita</td></tr>
    <tr><td>Marcar al apilar</td><td>Igual que en BFS: si no, la misma celda entra varias veces</td></tr>
  </tbody>
</table>

<h3>Por qué es O(N × M) aunque haya tres ciclos anidados</h3>

<p>El doble <code>for</code> pasa por cada celda una vez. El <code>while</code> de adentro procesa cada celda <strong>a lo sumo una vez en toda la ejecución</strong>, porque queda marcada. Sumado: cada celda se toca un número constante de veces.</p>

<h2>🔍 La versión recursiva y su trampa</h2>

<pre><code>def dfs(f, c):
    visitado[f][c] = True
    for df, dc in direcciones:
        nf, nc = f + df, c + dc
        if 0 &lt;= nf &lt; n and 0 &lt;= nc &lt; m:
            if grid[nf][nc] == "#" and not visitado[nf][nc]:
                dfs(nf, nc)</code></pre>

<p>Más corta y más bonita. Y con un mapa de 1000×1000 lleno de tierra, <strong>revienta</strong>: la recursión se hunde un millón de niveles y el límite de Python está cerca de mil. En concursos con mapas grandes, iterativo.</p>

<h2>🔍 Cuatro vecinos u ocho</h2>

<p>Muchos enunciados consideran también las diagonales. El cambio es una sola lista:</p>

<pre><code>direcciones = [(-1,-1), (-1,0), (-1,1),
               ( 0,-1),         ( 0,1),
               ( 1,-1), ( 1,0), ( 1,1)]</code></pre>

<p>Con el mapa <code>#.#</code> / <code>.#.</code> / <code>#.#</code> la diferencia es enorme: <strong>5 islas</strong> con cuatro direcciones, <strong>1 sola</strong> con ocho. Lee bien el enunciado antes de escribir la lista.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Contar celdas en vez de componentes</h3>
<pre><code>if grid[i][j] == "#":
    islas += 1            # ❌ sin mirar si ya está visitada</code></pre>
<p>Eso cuenta casillas de tierra, no islas. El <code>not visitado[i][j]</code> es lo que convierte el conteo en componentes.</p>

<h3>2. No marcar antes de apilar</h3>
<pre><code>pila.append((nf, nc))     # ❌ sin visitado[nf][nc] = True</code></pre>
<p>La misma celda entra a la pila por cada vecino que la vea. En un mapa grande, la memoria se acaba.</p>

<h3>3. Recursión en mapas grandes</h3>
<pre><code>dfs(0, 0)                 # ❌ con 10⁶ celdas: RecursionError</code></pre>
<p>Subir el límite con <code>sys.setrecursionlimit</code> ayuda a veces, pero lo seguro es la pila explícita.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿"Cuántos grupos", "cuántas regiones", "¿están conectados?" Es componentes conexas.</li>
  <li>Doble <code>for</code> buscando puntos de partida, y un recorrido que pinta toda la componente.</li>
  <li>Suma <strong>uno por componente</strong>, no uno por celda.</li>
  <li>Marca visitado al apilar/encolar.</li>
  <li>Lee si son 4 vecinos u 8 antes de escribir la lista de direcciones.</li>
  <li>Mapa grande → pila explícita, no recursión.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead><tr><th>Escribes</th><th>Pasa esto</th></tr></thead>
  <tbody>
    <tr><td><code>pila.pop()</code></td><td>Saca el último: DFS</td></tr>
    <tr><td><code>cola.popleft()</code></td><td>Saca el primero: BFS</td></tr>
    <tr><td><code>if es_tierra and not visitado</code></td><td>Encontraste una componente nueva</td></tr>
    <tr><td>4 direcciones</td><td><code>[(-1,0),(1,0),(0,-1),(0,1)]</code></td></tr>
    <tr><td>8 direcciones</td><td>Las 4 anteriores más las diagonales</td></tr>
    <tr><td>Tamaño de la componente</td><td>Contar celdas dentro del <code>while</code> de este recorrido</td></tr>
  </tbody>
</table>

<blockquote>Contar componentes no es contar celdas: es contar cuántas veces tuviste que <em>empezar</em> a recorrer.</blockquote>', 1, 'avanzado'
    FROM parts p WHERE p.number = 5 AND p.track = 'avanzado'
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 14 AND track = 'avanzado'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 14 AND track = 'avanzado');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Contar islas', 'medio', '<p>La primera línea trae filas y columnas. Después vienen las filas del mapa, con <code>#</code> para tierra y <code>.</code> para agua.</p><p>Dos casillas de tierra son la misma isla si están pegadas en alguna de las <strong>cuatro direcciones</strong>. Imprime cuántas islas hay.</p><pre><code>Entrada:
3 3
#.#
...
#.#

Salida:
4</code></pre>', '<p>Doble <code>for</code> buscando tierra <strong>no visitada</strong>: cada vez que la encuentres, suma una isla y lanza un recorrido que marque toda la componente. Usa una pila explícita, no recursión.</p>', '<pre><code>''''''
Programa: Contar islas
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta las componentes conexas de tierra en una cuadricula, con
    DFS iterativo (pila explicita).
''''''


def contar_islas(grid, n, m):
    ''''''
    Cuenta cuantas islas hay en el mapa.

    Parametros:
        grid (list): filas del mapa, con ''#'' tierra y ''.'' agua
        n (int): cantidad de filas
        m (int): cantidad de columnas

    Retorna:
        int: numero de componentes conexas de tierra
    ''''''
    visitado = []
    for i in range(n):
        visitado.append([False] * m)

    direcciones = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    islas = 0

    # Este doble for NO recorre islas: busca PUNTOS DE PARTIDA.
    # Quien recorre la isla completa es el while de abajo
    for i in range(n):
        for j in range(m):
            # El ''not visitado'' es lo que convierte el conteo de
            # celdas en un conteo de componentes
            if grid[i][j] == "#" and not visitado[i][j]:
                islas += 1

                pila = [(i, j)]
                visitado[i][j] = True

                while len(pila) > 0:
                    # POP saca el ultimo que entro: eso es DFS. Con
                    # popleft seria BFS, y para contar da lo mismo
                    f, c = pila.pop()

                    for df, dc in direcciones:
                        nf = f + df
                        nc = c + dc

                        if 0 <= nf < n and 0 <= nc < m:
                            if grid[nf][nc] == "#" and not visitado[nf][nc]:
                                # Marcar AL APILAR: si no, la celda
                                # entra una vez por cada vecino que
                                # la vea
                                visitado[nf][nc] = True
                                pila.append((nf, nc))

    return islas


# Inicio
datos = input().split()
n = int(datos[0])
m = int(datos[1])

grid = []
for i in range(n):
    grid.append(input())

print(contar_islas(grid, n, m))
# Fin</code></pre><p>La idea completa cabe en una frase: <strong>un recorrido lanzado desde una celda pinta toda su componente</strong>, así que contar componentes es contar cuántas veces tuviste que <em>empezar</em> a recorrer.</p><ul><li><strong>El contador sube al descubrir la isla</strong>, antes del <code>while</code>. Adentro contaría una vez por celda.</li><li><strong>Marcar al apilar.</strong> Igual que en BFS: si se marca al sacar, la misma celda entra a la pila una vez por cada vecino que la vea, y en un mapa grande la memoria se acaba.</li><li><strong>Iterativo y no recursivo.</strong> La versión con <code>def dfs(f, c)</code> es más corta y más bonita, pero con un mapa de 1000×1000 lleno de tierra se hunde un millón de niveles: el límite de Python está cerca de mil.</li></ul><p><strong>Y es O(N × M)</strong>, aunque haya un <code>while</code> dentro de un doble <code>for</code>. Contar ciclos anidados engaña; hay que contar cuántas veces se toca cada celda en total, y cada una se procesa a lo sumo una vez porque queda marcada.</p>', '[{"stdin":"3 3\n#.#\n...\n#.#\n","expected_output":"4\n"},{"stdin":"2 3\n###\n###\n","expected_output":"1\n"},{"stdin":"2 2\n..\n..\n","expected_output":"0\n"},{"stdin":"3 2\n#.\n..\n..\n","expected_output":"1\n"},{"stdin":"3 3\n#.#\n.#.\n#.#\n","expected_output":"5\n"},{"stdin":"1 5\n#.##.\n","expected_output":"2\n"}]', '''''''
Programa: Contar islas
Autor:
Fecha:
Descripcion:
''''''


def contar_islas(grid, n, m):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'La isla más grande, con diagonales', 'dificil', '<p>El mismo mapa, pero ahora dos casillas son la misma isla si se tocan en cualquiera de las <strong>ocho direcciones</strong> (incluidas las diagonales).</p><p>Imprime dos números separados por espacio: cuántas islas hay y cuántas casillas tiene la más grande. Si no hay tierra, imprime <code>0 0</code>.</p><pre><code>Entrada:
3 3
#.#
.#.
#.#

Salida:
1 5</code></pre><p>Con diagonales, el centro conecta las cuatro esquinas: una sola isla de 5 casillas.</p>', '<p>Mismo esqueleto, dos cambios: la lista de direcciones tiene 8 pares, y dentro del <code>while</code> hay que contar las celdas que se sacan de la pila.</p>', '<pre><code>''''''
Programa: La isla mas grande, con diagonales
Autor:    Ana Gomez
Fecha:    2026-09-04
Descripcion:
    Cuenta las componentes conexas de tierra usando 8 vecinos y
    reporta ademas el tamano de la mayor.
''''''


def analizar(grid, n, m):
    ''''''
    Cuenta las islas y mide la mas grande, con vecindad de 8.

    Parametros:
        grid (list): filas del mapa, con ''#'' tierra y ''.'' agua
        n (int): cantidad de filas
        m (int): cantidad de columnas

    Retorna:
        tuple: (cantidad de islas, tamano de la mayor)
    ''''''
    visitado = []
    for i in range(n):
        visitado.append([False] * m)

    # LAS 8 DIRECCIONES: las 9 combinaciones de -1, 0 y 1 menos el
    # (0,0), que es la celda misma. Cambiar de 4 a 8 vecinos es
    # cambiar unicamente esta lista
    direcciones = [(-1, -1), (-1, 0), (-1, 1),
                   (0, -1), (0, 1),
                   (1, -1), (1, 0), (1, 1)]

    islas = 0
    mayor = 0

    for i in range(n):
        for j in range(m):
            if grid[i][j] == "#" and not visitado[i][j]:
                islas += 1

                pila = [(i, j)]
                visitado[i][j] = True

                # El tamano se cuenta POR ISLA, asi que la variable
                # se reinicia aqui y no afuera
                tam = 0

                while len(pila) > 0:
                    f, c = pila.pop()
                    tam += 1     # cada celda sale de la pila una vez

                    for df, dc in direcciones:
                        nf = f + df
                        nc = c + dc

                        if 0 <= nf < n and 0 <= nc < m:
                            if grid[nf][nc] == "#" and not visitado[nf][nc]:
                                visitado[nf][nc] = True
                                pila.append((nf, nc))

                if tam > mayor:
                    mayor = tam

    return islas, mayor


# Inicio
datos = input().split()
n = int(datos[0])
m = int(datos[1])

grid = []
for i in range(n):
    grid.append(input())

cantidad, tamano = analizar(grid, n, m)
print(cantidad, tamano)
# Fin</code></pre><p>Dos variantes sobre el mismo esqueleto, y las dos aparecen todo el tiempo en concursos.</p><ul><li><strong>La vecindad la manda el enunciado.</strong> Con el mapa <code>#.#</code> / <code>.#.</code> / <code>#.#</code>: son <strong>5 islas</strong> con cuatro direcciones y <strong>1 sola</strong> con ocho. Es la misma cuadrícula y la misma técnica — cambia una lista. Leer mal esa parte del enunciado es la forma más rápida de perder el problema.</li><li><strong>Contar al sacar de la pila y no al apilar.</strong> Cada celda sale exactamente una vez, así que <code>tam</code> queda exacto. Contando al apilar también funcionaría aquí, pero habría que acordarse de sumar la celda inicial, que se apiló aparte.</li><li><strong><code>tam</code> se reinicia dentro del <code>if</code>.</strong> Es el tamaño de <em>esta</em> isla. Declararlo afuera acumularía todas.</li><li><strong>El caso sin tierra sale gratis:</strong> el <code>if</code> nunca se cumple, y las dos variables se quedan en 0.</li></ul>', '[{"stdin":"3 3\n#.#\n.#.\n#.#\n","expected_output":"1 5\n"},{"stdin":"3 3\n#.#\n...\n#.#\n","expected_output":"4 1\n"},{"stdin":"2 3\n###\n###\n","expected_output":"1 6\n"},{"stdin":"2 2\n..\n..\n","expected_output":"0 0\n"},{"stdin":"3 2\n#.\n..\n..\n","expected_output":"1 1\n"},{"stdin":"1 5\n#.##.\n","expected_output":"2 2\n"}]', '''''''
Programa: La isla mas grande, con diagonales
Autor:
Fecha:
Descripcion:
''''''


def analizar(grid, n, m):
    pass


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 14 AND track = 'avanzado');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué estructura usa DFS?', NULL, '{"options":[{"id":"a","text":"Una pila: saca el último que entró y se hunde por una rama"},{"id":"b","text":"Una cola: saca el primero que entró"},{"id":"c","text":"Un diccionario"},{"id":"d","text":"Una lista ordenada"}]}', '{"option_id":"a"}', 'Con pop() saca el último; con popleft() sería BFS. Para contar componentes las dos dan el mismo resultado: lo único que importa es visitar todo.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En el conteo de islas, ¿qué hace realmente el doble for exterior?', NULL, '{"options":[{"id":"a","text":"Busca puntos de partida: celdas de tierra que nadie visitó todavía"},{"id":"b","text":"Cuenta las celdas de tierra"},{"id":"c","text":"Recorre cada isla completa"},{"id":"d","text":"Ordena las celdas"}]}', '{"option_id":"a"}', 'Quien recorre la isla es el DFS. El for solo busca dónde empezar: cada vez que entra al if es porque tropezó con una componente que nadie había pintado.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué el algoritmo es O(N × M) si tiene un while dentro de un doble for?', NULL, '{"options":[{"id":"a","text":"Porque cada celda se procesa a lo sumo una vez en toda la ejecución: queda marcada"},{"id":"b","text":"Porque el while casi nunca entra"},{"id":"c","text":"No lo es: es O(N² × M²)"},{"id":"d","text":"Porque las islas son pequeñas"}]}', '{"option_id":"a"}', 'Contar ciclos anidados engaña. Hay que contar cuántas veces se toca cada celda en total: el for la mira una vez, y el while la procesa como máximo una vez.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Con el mapa #.# / .#. / #.# ¿cuántas islas hay con 4 direcciones y cuántas con 8?', NULL, '{"options":[{"id":"a","text":"5 con cuatro direcciones, 1 con ocho"},{"id":"b","text":"5 en los dos casos"},{"id":"c","text":"1 con cuatro, 5 con ocho"},{"id":"d","text":"4 con cuatro, 2 con ocho"}]}', '{"option_id":"a"}', 'Con cuatro direcciones ninguna de las cinco celdas toca a otra por los lados. Con las diagonales, el centro las conecta todas. Por eso hay que leer bien el enunciado antes de escribir la lista de direcciones.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuándo conviene BFS en vez de DFS?', NULL, '{"options":[{"id":"a","text":"Cuando se pide el camino más corto o el mínimo de pasos"},{"id":"b","text":"Cuando hay que contar componentes"},{"id":"c","text":"Cuando el mapa tiene diagonales"},{"id":"d","text":"Cuando el mapa es pequeño"}]}', '{"option_id":"a"}', 'BFS explora por niveles, así que la primera vez que llega a una celda llegó por el camino mínimo. Para conectividad las dos técnicas sirven igual.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'Con 4 direcciones, ¿cuántas islas tiene este mapa?', '#.#
...
#.#', '{"options":[{"id":"a","text":"4"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"8"}]}', '{"option_id":"a"}', 'Las cuatro esquinas son tierra y ninguna toca a otra por arriba, abajo, izquierda o derecha. Con ocho direcciones tampoco se juntan: las diagonales las separa una casilla de agua.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este programa cuenta celdas de tierra en vez de islas. ¿En qué línea está el error?', NULL, '{"lines":["for i in range(n):","    for j in range(m):","        if grid[i][j] == ''#'':","            islas += 1","            pila = [(i, j)]","            visitado[i][j] = True"]}', '{"line_number":3}', 'Falta el ''and not visitado[i][j]''. Sin esa condición, cada celda de una misma isla vuelve a sumar. Esa comprobación es lo que convierte el conteo en componentes.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'medio', 'Completa el conteo de componentes.', NULL, '{"code":"islas = 0\n\nfor i in range(n):\n    for j in range(m):\n        if grid[i][j] == \"#\" and ___1___ visitado[i][j]:\n            islas += 1\n\n            pila = [(i, j)]\n            visitado[i][j] = True\n\n            while len(pila) > 0:\n                f, c = pila.___2___()","blanks":[{"id":"1","pista":"todavía nadie la pintó"},{"id":"2","pista":"saca el último que entró"}]}', '{"answers":{"1":["not"],"2":["pop"]}}', 'El ''not visitado'' es lo que hace que se cuente una vez por isla y no una por celda. Y pop() saca el último: eso es lo que hace que el recorrido sea DFS.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'fill_blank', 'dificil', 'Completa la lista de las 8 direcciones (con diagonales).', NULL, '{"code":"direcciones = [(-1, -1), (-1, 0), (-1, 1),\n               ( 0, -1),          ( 0, ___1___),\n               ( 1, -1), ( 1, 0), ( ___2___, 1)]","blanks":[{"id":"1","pista":"una columna a la derecha, misma fila"},{"id":"2","pista":"una fila abajo"}]}', '{"answers":{"1":["1"],"2":["1"]}}', 'Son las 9 combinaciones de −1, 0 y 1 menos el (0,0), que es la celda misma. Cambiar de 4 a 8 vecinos es cambiar solo esta lista.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arma el conteo de islas con DFS iterativo', NULL, '{"lines":[{"id":"d1","text":"for i in range(n):","indent":0},{"id":"d2","text":"for j in range(m):","indent":1},{"id":"d3","text":"if grid[i][j] == ''#'' and not visitado[i][j]:","indent":2},{"id":"d4","text":"islas += 1","indent":3},{"id":"d5","text":"pila = [(i, j)]","indent":3},{"id":"d6","text":"visitado[i][j] = True","indent":3},{"id":"d7","text":"while len(pila) > 0:","indent":3},{"id":"d8","text":"f, c = pila.pop()","indent":4},{"id":"d9","text":"for df, dc in direcciones:","indent":4}]}', '{"order":["d1","d2","d3","d4","d5","d6","d7","d8","d9"]}', 'El contador sube al DESCUBRIR la isla, antes de recorrerla. Si estuviera dentro del while, contaría una vez por celda.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué en competencia se prefiere el DFS iterativo al recursivo?', NULL, '{"options":[{"id":"a","text":"Porque con un mapa de 1000×1000 la recursión se hunde un millón de niveles y revienta"},{"id":"b","text":"Porque el recursivo da resultados incorrectos"},{"id":"c","text":"Porque Python no permite funciones recursivas"},{"id":"d","text":"Porque el iterativo usa menos memoria en todos los casos"}]}', '{"option_id":"a"}', 'El límite de recursión de Python está cerca de mil llamadas. La versión recursiva es más corta y más bonita, pero con mapas grandes lanza RecursionError.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'avanzado';

