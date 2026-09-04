-- ============================================================================
--  CONTENIDO DEL LIBRO — generado por scripts/build-contenido.mjs
--  No editar a mano: se regenera con `npm run content:build`.
--  Solo toca las filas con source = 'seed'.
-- ============================================================================

INSERT INTO parts (number, title, emoji, track) VALUES (1, 'Entrada y salida', '⚙️', 'avanzado')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (2, 'Estructuras', '🧱', 'avanzado')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (3, 'Recursión y búsqueda', '🌳', 'avanzado')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (4, 'Técnicas de diseño', '🧠', 'avanzado')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;

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
    FROM parts p WHERE p.number = 1
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
    FROM parts p WHERE p.number = 1
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
    FROM parts p WHERE p.number = 2
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

-- ── Capítulo 4: Recursión (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 4, 'Recursión', '🌀', 'Caso base, caso recursivo y qué pasa en el stack de llamadas.', '', 0, 'avanzado'
    FROM parts p WHERE p.number = 3
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'avanzado');

-- ── Capítulo 5: Backtracking (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 5, 'Backtracking', '🌳', 'El árbol de decisión y la poda de ramas que no llevan a nada.', '', 0, 'avanzado'
    FROM parts p WHERE p.number = 3
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'avanzado');

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
    FROM parts p WHERE p.number = 4
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

-- ── Capítulo 7: Programación Dinámica (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 7, 'Programación Dinámica', '📊', 'La tabla DP y la diferencia entre construirla hacia adelante o hacia atrás.', '', 0, 'avanzado'
    FROM parts p WHERE p.number = 4
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'avanzado');

-- ── Capítulo 8: Greedy y simulación (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 8, 'Greedy y simulación', '🎯', 'Cuándo la decisión codiciosa es correcta, y cuándo toca simular.', '', 0, 'avanzado'
    FROM parts p WHERE p.number = 4
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8 AND track = 'avanzado');

