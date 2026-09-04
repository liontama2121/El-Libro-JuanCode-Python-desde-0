-- ============================================================================
--  CONTENIDO DEL LIBRO — generado por scripts/build-contenido.mjs
--  No editar a mano: se regenera con `npm run content:build`.
--  Solo toca las filas con source = 'seed'.
-- ============================================================================

INSERT INTO parts (number, title, emoji, track) VALUES (1, 'Fundamentos', '🌱', 'basico')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (2, 'Control de flujo', '🔀', 'basico')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (3, 'Estructuras de datos', '📚', 'basico')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (4, 'Código organizado', '🧰', 'basico')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (5, 'Programación orientada a objetos', '🏛️', 'basico')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;
INSERT INTO parts (number, title, emoji, track) VALUES (6, 'Mundo real', '🚀', 'basico')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji, track = excluded.track;

-- ── Capítulo 1: ¿Qué es programar? (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 1, '¿Qué es programar?', '🐍', 'La idea más importante del libro: darle instrucciones exactas a una máquina.', '<p class="jc-gancho">Son las 11 de la noche y tienes que sumar las ventas del día de la tienda: 340 tirillas de papel. A mano son dos horas y un dolor de cabeza. Con seis líneas de Python son dos segundos. La diferencia entre esas dos noches se llama <strong>programar</strong>.</p>

<h2>Programar es dar instrucciones exactas</h2>

<p>Un computador no adivina. No interpreta. No completa lo que falta. Hace <strong>exactamente</strong> lo que le pides, en el orden en que se lo pides, y si algo no cuadra se detiene y te avisa.</p>

<p>Piensa en una receta de arroz con pollo. Si escribes <em>"echar el huevo"</em> sin decir antes <em>"romper el huevo"</em>, terminas con cáscara en la sartén. El computador es igual de literal, pero mucho más rápido y nunca se cansa.</p>

<p>Entonces programar son dos cosas, y la primera es la difícil:</p>

<ol>
  <li><strong>Pensar</strong> el problema en pasos tan pequeños que una máquina los pueda seguir.</li>
  <li><strong>Escribir</strong> esos pasos en un idioma que la máquina entienda.</li>
</ol>

<p>El idioma de este libro es Python. Lo escogimos porque se lee casi como inglés y no estorba mientras aprendes lo primero, que es lo que de verdad cuesta.</p>

<h2>Tu primer programa</h2>

<p>La instrucción <code>print()</code> muestra algo en pantalla. Lo que va entre paréntesis es el <strong>argumento</strong>: el dato con el que trabaja la instrucción.</p>

<pre><code>print("Hola, mundo")
print("Estoy aprendiendo Python con JuanCode")</code></pre>

<p>Si ejecutas eso, ves dos líneas. Vamos línea por línea, que es como se lee un programa:</p>

<table>
  <thead>
    <tr><th>Línea</th><th>Qué hace Python</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>Busca la instrucción <code>print</code>, toma el texto <code>"Hola, mundo"</code> y lo escribe en pantalla. Al terminar, baja el cursor a la línea siguiente.</td></tr>
    <tr><td>2</td><td>Hace lo mismo con el segundo texto. Por eso salen dos renglones y no uno.</td></tr>
  </tbody>
</table>

<p>El texto entre comillas se llama <strong>string</strong> (cadena de caracteres). Las comillas no se imprimen: solo le marcan a Python dónde empieza y dónde termina el texto. Sirven las dobles <code>"así"</code> y las sencillas <code>''así''</code>, mientras abras y cierres con la misma.</p>

<h3>Imprimir varias cosas de una vez</h3>

<p>Si le pasas varios argumentos separados por comas, <code>print()</code> los pone en la misma línea y les mete un espacio entre cada uno. Este truco lo vamos a usar durante los primeros capítulos:</p>

<pre><code>print("Total del día:", 340, "tirillas")</code></pre>

<p>Sale: <code>Total del día: 340 tirillas</code>. Fíjate en que <code>340</code> va sin comillas porque es un número, no un texto. En el capítulo 5 aprenderás las f-strings, que son la forma moderna de hacer esto mismo.</p>

<h2>Comentarios: notas para humanos</h2>

<p>Todo lo que va después de <code>#</code> lo ignora Python. Está ahí para que tu yo del futuro entienda qué estabas pensando.</p>

<pre><code># Programa de bienvenida del curso
# Autor: Ana Gómez

print("Bienvenido al Libro JuanCode")  # esto también es comentario</code></pre>

<p>Un buen comentario no repite lo que ya dice el código. Explica <strong>por qué</strong>:</p>

<pre><code>print("Total:", 340)   # mal: "imprime el total"
print("Total:", 340)   # bien: el conteo del día lo entrega la caja registradora</code></pre>

<h2>Los errores no son regaños</h2>

<p>Cuando algo no cuadra, Python no se queda callado: te dice en qué línea se rompió y por qué. Leer ese mensaje es la mitad del oficio.</p>

<pre><code>print("Hola"
</code></pre>

<p>Python responde algo como <code>SyntaxError: unexpected EOF while parsing</code>, que traducido es: <em>"abriste un paréntesis y nunca lo cerraste; se me acabó el archivo esperándolo"</em>. Ningún programador escribe sin errores. Los buenos simplemente los leen rápido.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Escribir <code>Print</code> con mayúscula</h3>
<pre><code>Print("Hola")   # NameError: name ''Print'' is not defined</code></pre>
<p>Python distingue mayúsculas de minúsculas. <code>print</code>, <code>Print</code> y <code>PRINT</code> son tres nombres distintos y solo el primero existe.</p>

<h3>2. Olvidar los paréntesis</h3>
<pre><code>print "Hola"    # SyntaxError</code></pre>
<p>En Python 3 <code>print</code> es una función, y a una función siempre se la llama con paréntesis.</p>

<h3>3. Dejar el texto sin comillas</h3>
<pre><code>print(Hola)     # NameError: name ''Hola'' is not defined</code></pre>
<p>Sin comillas, Python cree que <code>Hola</code> es el nombre de algo que guardaste antes. Como no existe, se queja.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Escribe lo que quieres que pase, en español, en pasos numerados.</li>
  <li>Traduce cada paso a una línea de Python.</li>
  <li>Ejecuta. Si sale error, lee la última línea del mensaje: ahí está el motivo.</li>
  <li>Arregla una cosa a la vez y vuelve a ejecutar.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>print("texto")</code></td><td>Muestra el texto en pantalla</td></tr>
    <tr><td><code>print("a", "b")</code></td><td>Muestra <code>a b</code> en la misma línea</td></tr>
    <tr><td><code>print()</code></td><td>Deja un renglón en blanco</td></tr>
    <tr><td><code># nota</code></td><td>Comentario: Python lo ignora</td></tr>
    <tr><td><code>"texto"</code> o <code>''texto''</code></td><td>Un string</td></tr>
  </tbody>
</table>

<blockquote>Programar no es memorizar comandos. Es aprender a partir un problema grande en pasos tan pequeños que hasta una máquina los pueda seguir.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 1
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 1 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Ficha de presentación', 'facil', '<p>Escriba un programa que muestre en pantalla, en <strong>tres líneas separadas</strong>:</p><ul><li>Su nombre completo.</li><li>Su ciudad.</li><li>Una razón por la que quiere aprender a programar.</li></ul><p><em>Nota:</em> el contenido de los textos es libre, pero deben salir exactamente tres renglones.</p>', '<p>Necesitas tres llamadas a <code>print()</code>, una debajo de la otra. Cada <code>print()</code> baja el cursor a la línea siguiente, así que no hay que hacer nada extra.</p>', '<pre><code># Ficha de presentación del estudiante
print("Ana Gómez")
print("Bogotá")
print("Quiero automatizar el inventario de la tienda de mi mamá")</code></pre><p>Línea por línea:</p><ol><li>Un comentario para que se sepa de qué es el programa. Python lo ignora.</li><li><code>print("Ana Gómez")</code> escribe el nombre y baja de línea.</li><li>Lo mismo con la ciudad.</li><li>Lo mismo con la razón. Tres <code>print()</code>, tres renglones.</li></ol>', NULL, NULL, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Recibo de la tienda', 'facil', '<p>Una tienda vendió hoy <strong>340</strong> unidades. Escriba un programa que muestre exactamente:</p><pre><code>TIENDA LA ESQUINA
Ventas del dia: 340 unidades
Gracias por su compra</code></pre><p><em>Nota:</em> el número debe ir como número, no dentro del texto.</p>', '<p>Para la línea del medio usa <code>print()</code> con tres argumentos separados por comas: el texto de la izquierda, el número y el texto de la derecha. Recuerda que las comas ponen un espacio automático.</p>', '<pre><code># Recibo simple de cierre del día
print("TIENDA LA ESQUINA")
print("Ventas del dia:", 340, "unidades")
print("Gracias por su compra")</code></pre><p>La línea 3 es la interesante: <code>print()</code> recibe <strong>tres argumentos</strong> y los une con un espacio entre cada uno. Por eso no hay que escribir el espacio a mano dentro de las comillas. El <code>340</code> va sin comillas porque es un número.</p>', '[{"stdin":"","expected_output":"TIENDA LA ESQUINA\nVentas del dia: 340 unidades\nGracias por su compra"}]', '# Recibo simple de cierre del día
', 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Caza el error', 'medio', '<p>El siguiente programa no ejecuta. Encuentre los <strong>tres</strong> errores, corríjalos y entregue el programa funcionando.</p><pre><code>Print("Inicio")
print("Mitad"
print(Fin)</code></pre><p><em>Nota:</em> la salida esperada son tres líneas: <code>Inicio</code>, <code>Mitad</code> y <code>Fin</code>.</p>', '<p>Revise tres cosas distintas: cómo se escribe el nombre de la función, si todos los paréntesis se cierran, y si todo texto está entre comillas.</p>', '<pre><code>print("Inicio")
print("Mitad")
print("Fin")</code></pre><p>Los tres errores eran:</p><ol><li><code>Print</code> con mayúscula: la función se llama <code>print</code>. Da <code>NameError</code>.</li><li>Falta cerrar el paréntesis en la línea 2. Da <code>SyntaxError</code>.</li><li><code>Fin</code> sin comillas: Python cree que es el nombre de un dato guardado y no lo encuentra. Da <code>NameError</code>.</li></ol>', '[{"stdin":"","expected_output":"Inicio\nMitad\nFin"}]', 'Print("Inicio")
print("Mitad"
print(Fin)
', 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Volante de la panadería', 'dificil', '<p>Arme el volante de una panadería. El programa debe mostrar exactamente:</p><pre><code>==============================
     PANADERIA EL TRIGAL
==============================
Pan            600
Bunuelo       1500
Avena         2500
------------------------------
Abrimos de 6 a 8</code></pre><p><em>Nota:</em> los precios deben quedar alineados a la derecha y todo el volante debe salir de un solo programa, sin usar variables todavía.</p>', '<p>No hay magia: son ocho <code>print()</code>. Para alinear, cuente los espacios dentro del string y escríbalos a mano. Para las líneas de <code>=</code> puede usar <code>"=" * 30</code>, que repite el carácter 30 veces.</p>', '<pre><code># Volante de precios de la panadería
print("=" * 30)
print("     PANADERIA EL TRIGAL")
print("=" * 30)
print("Pan            600")
print("Bunuelo       1500")
print("Avena         2500")
print("-" * 30)
print("Abrimos de 6 a 8")</code></pre><p>Dos cosas nuevas:</p><ul><li><code>"=" * 30</code> repite el carácter treinta veces. Multiplicar un texto por un número lo repite; lo veremos a fondo en el capítulo 5.</li><li>La alineación se logra contando espacios dentro de las comillas. Es incómodo, y por eso en el capítulo 5 aprenderás a alinear de verdad con f-strings.</li></ul>', NULL, '# Volante de precios de la panadería
', 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué es programar, en una frase?', NULL, '{"options":[{"id":"a","text":"Escribir instrucciones exactas para que una máquina las ejecute en orden"},{"id":"b","text":"Memorizar todos los comandos de un lenguaje"},{"id":"c","text":"Reparar computadores que fallan"},{"id":"d","text":"Diseñar la parte visual de una página web"}]}', '{"option_id":"a"}', 'La máquina no adivina: hace exactamente lo que le pides, en el orden en que se lo pides.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Para qué sirven las comillas en print("Hola")?', NULL, '{"options":[{"id":"a","text":"Le indican a Python dónde empieza y termina el texto"},{"id":"b","text":"Hacen que el texto salga en negrilla"},{"id":"c","text":"Son decorativas, se pueden quitar"},{"id":"d","text":"Convierten el texto en número"}]}', '{"option_id":"a"}', 'Sin comillas Python cree que Hola es el nombre de un dato guardado y lanza NameError.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace Python con una línea que empieza por #?', NULL, '{"options":[{"id":"a","text":"La ignora por completo: es un comentario"},{"id":"b","text":"La imprime en pantalla"},{"id":"c","text":"La ejecuta más rápido"},{"id":"d","text":"Lanza un error de sintaxis"}]}', '{"option_id":"a"}', 'Los comentarios son notas para humanos. Python los salta.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál de estas líneas está escrita correctamente?', NULL, '{"options":[{"id":"a","text":"print(\"Hola\")"},{"id":"b","text":"Print(\"Hola\")"},{"id":"c","text":"print \"Hola\""},{"id":"d","text":"print(Hola)"}]}', '{"option_id":"a"}', 'print en minúscula, con paréntesis y con el texto entre comillas. Las otras tres fallan en una de esas tres cosas.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál de estos comentarios es realmente útil?', NULL, '{"options":[{"id":"a","text":"# el conteo del día lo entrega la caja registradora"},{"id":"b","text":"# imprime el total"},{"id":"c","text":"# print"},{"id":"d","text":"# línea 3"}]}', '{"option_id":"a"}', 'Un buen comentario explica el porqué, no repite lo que el código ya dice.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'El computador ejecuta las instrucciones…', NULL, '{"options":[{"id":"a","text":"En el orden en que están escritas, de arriba hacia abajo"},{"id":"b","text":"En el orden que él considere más rápido"},{"id":"c","text":"Todas al mismo tiempo"},{"id":"d","text":"Empezando por la última línea"}]}', '{"option_id":"a"}', 'El orden importa: por eso hay que romper el huevo antes de echarlo.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print("Hola")
print("JuanCode")', '{"options":[{"id":"a","text":"Hola\nJuanCode"},{"id":"b","text":"HolaJuanCode"},{"id":"c","text":"Hola JuanCode"},{"id":"d","text":"Solo Hola"}]}', '{"option_id":"a"}', 'Cada print() escribe y baja de línea, así que salen dos renglones.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print("Total:", 340, "unidades")', '{"options":[{"id":"a","text":"Total: 340 unidades"},{"id":"b","text":"Total:340unidades"},{"id":"c","text":"Total: , 340 , unidades"},{"id":"d","text":"Error: no se puede mezclar texto y número"}]}', '{"option_id":"a"}', 'Las comas de print() separan argumentos y meten un espacio entre cada uno.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', '# print("Uno")
print("Dos")', '{"options":[{"id":"a","text":"Dos"},{"id":"b","text":"Uno\nDos"},{"id":"c","text":"Uno"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'La primera línea es un comentario: Python la ignora por completo.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print("A")
print()
print("B")', '{"options":[{"id":"a","text":"A, un renglón en blanco, y B"},{"id":"b","text":"A y B pegados"},{"id":"c","text":"A B"},{"id":"d","text":"Error: print() necesita argumentos"}]}', '{"option_id":"a"}', 'print() sin argumentos solo baja de línea: sirve para separar bloques de salida.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print("-" * 5)', '{"options":[{"id":"a","text":"-----"},{"id":"b","text":"- * 5"},{"id":"c","text":"-5"},{"id":"d","text":"Error: no se puede multiplicar texto"}]}', '{"option_id":"a"}', 'Multiplicar un texto por un número lo repite. Sirve para dibujar separadores.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Este programa no corre. ¿En qué línea está el error?', NULL, '{"lines":["print(\"Inicio\")","Print(\"Mitad\")","print(\"Fin\")"]}', '{"line_number":2}', 'Python distingue mayúsculas: la función es print, no Print. Da NameError.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["print(\"Menu del dia\")","print(\"Sopa\")","print(Jugo)","print(\"Postre\")"]}', '{"line_number":3}', 'Jugo va sin comillas, así que Python lo busca como un dato guardado y no existe.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["print(\"Cierre de caja\")","print(\"Total:\", 340","print(\"Gracias\")"]}', '{"line_number":2}', 'Falta cerrar el paréntesis. Python sigue leyendo esperando el cierre y termina en SyntaxError.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que imprime el recibo de la tienda', NULL, '{"lines":[{"id":"l1","text":"# Recibo de cierre del día","indent":0},{"id":"l2","text":"print(\"TIENDA LA ESQUINA\")","indent":0},{"id":"l3","text":"print(\"Ventas del dia:\", 340, \"unidades\")","indent":0},{"id":"l4","text":"print(\"Gracias por su compra\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'Primero el comentario que explica el programa, y después las tres líneas del recibo en el orden en que deben salir.', 1, 'seed'
    FROM chapters WHERE number = 1 AND track = 'basico';

-- ── Capítulo 2: Variables y tipos de datos (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 2, 'Variables y tipos de datos', '📦', 'Cajas con nombre para guardar información, y los cuatro tipos básicos.', '<p class="jc-gancho">Estás calculando cuánto le queda a un cliente después de pagar tres cuotas. Sin variables tendrías que volver a escribir el saldo en cada línea, y si el número cambia, cambiarlo en diez sitios. Con variables lo escribes una vez y el programa se encarga del resto.</p>

<h2>Una variable es una caja con nombre</h2>

<p>Una <strong>variable</strong> guarda un dato para usarlo después. Se crea con el signo <code>=</code>: a la izquierda el nombre, a la derecha el valor.</p>

<pre><code>nombre = "Ana"
edad = 17
saldo = 250000

print(nombre)
print(saldo)</code></pre>

<p>Paso a paso, lo que hace Python:</p>

<table>
  <thead>
    <tr><th>Línea</th><th>Qué pasa por dentro</th></tr>
  </thead>
  <tbody>
    <tr><td><code>nombre = "Ana"</code></td><td>Guarda el texto <code>"Ana"</code> en memoria y le cuelga la etiqueta <code>nombre</code>.</td></tr>
    <tr><td><code>edad = 17</code></td><td>Guarda el número 17 con la etiqueta <code>edad</code>.</td></tr>
    <tr><td><code>print(nombre)</code></td><td>Busca la etiqueta <code>nombre</code>, encuentra <code>"Ana"</code> y lo imprime.</td></tr>
  </tbody>
</table>

<p>Ojo con algo que confunde a todo el mundo: el <code>=</code> aquí <strong>no</strong> significa "es igual a" como en matemáticas. Significa "guarda esto acá". Por eso esta línea, que en matemáticas sería imposible, en Python tiene todo el sentido:</p>

<pre><code>contador = 0
contador = contador + 1   # ahora contador vale 1</code></pre>

<p>Python primero resuelve el lado derecho (<code>0 + 1</code>) y después mete el resultado en la caja. Es la base de los contadores que vas a usar en el capítulo 7.</p>

<h3>Reglas para los nombres</h3>

<ul>
  <li>Solo letras, números y guion bajo. No pueden empezar por número.</li>
  <li>Sin espacios: se usa <code>snake_case</code>, como <code>nota_final</code> o <code>saldo_actual</code>.</li>
  <li>Que digan qué guardan. <code>edad</code> le gana a <code>x</code> siempre.</li>
  <li>Python distingue mayúsculas: <code>Saldo</code> y <code>saldo</code> son dos cajas distintas.</li>
</ul>

<h2>Los cuatro tipos básicos</h2>

<p>Python decide el tipo solo, mirando el valor que le diste.</p>

<table>
  <thead>
    <tr><th>Tipo</th><th>Qué guarda</th><th>Ejemplo</th></tr>
  </thead>
  <tbody>
    <tr><td><code>str</code></td><td>Texto</td><td><code>"Cartagena"</code></td></tr>
    <tr><td><code>int</code></td><td>Números enteros</td><td><code>250000</code></td></tr>
    <tr><td><code>float</code></td><td>Números con decimales</td><td><code>4.5</code></td></tr>
    <tr><td><code>bool</code></td><td>Verdadero o falso</td><td><code>True</code></td></tr>
  </tbody>
</table>

<p>Dos detalles que cuestan puntos en los parciales: <code>True</code> y <code>False</code> van con mayúscula inicial, y <code>"17"</code> con comillas es <strong>texto</strong>, no número.</p>

<pre><code>print(type("Cartagena"))   # str
print(type(250000))        # int
print(type(4.5))           # float
print(type(True))          # bool</code></pre>

<p>En Colombia los precios se escriben con puntos de miles, pero en Python el punto es el separador decimal. <code>1.500</code> para Python es "uno coma cinco", no mil quinientos. Los miles se escriben pelados: <code>1500</code>. Si quieres separarlos para leerlos mejor, Python acepta guion bajo: <code>1_500_000</code>.</p>

<h2>El tipo cambia lo que hacen los operadores</h2>

<p>El mismo símbolo <code>+</code> hace cosas distintas según con qué trabaje:</p>

<pre><code>print(2 + 3)            # 5      -> suma
print("2" + "3")        # 23     -> pega los textos
print("Hola " + "Ana")  # Hola Ana</code></pre>

<p>Y mezclar tipos incompatibles revienta:</p>

<pre><code>edad = 17
print("Edad: " + edad)   # TypeError: can only concatenate str (not "int") to str</code></pre>

<p>Ese <code>TypeError</code> te está diciendo: <em>"a un texto solo le puedo pegar otro texto"</em>. La solución es convertir.</p>

<h3>Convertir de un tipo a otro</h3>

<pre><code>edad = 17
print("Edad: " + str(edad))   # Edad: 17    -> el número se vuelve texto

texto = "25"
print(int(texto) + 5)         # 30          -> el texto se vuelve número

print(float("4.5") + 0.5)     # 5.0</code></pre>

<p>Y hay un atajo que ya conoces: las comas de <code>print()</code> convierten solas.</p>

<pre><code>print("Edad:", edad)   # Edad: 17 — sin str(), sin errores</code></pre>

<h2>La película de un programa con variables</h2>

<p>Cuando un programa cambia el valor de sus variables, la única forma de entenderlo es seguirlo línea por línea. Este calcula el saldo de una cuenta después de dos movimientos:</p>

<pre><code>saldo = 250000      # línea 1
saldo = saldo - 80000   # línea 2: retiro
saldo = saldo + 30000   # línea 3: consignación
print("Saldo final:", saldo)</code></pre>

<table>
  <thead>
    <tr><th>Después de…</th><th><code>saldo</code> vale</th><th>Por qué</th></tr>
  </thead>
  <tbody>
    <tr><td>línea 1</td><td>250000</td><td>Se crea la caja con el saldo inicial</td></tr>
    <tr><td>línea 2</td><td>170000</td><td>Resuelve <code>250000 - 80000</code> y lo vuelve a guardar</td></tr>
    <tr><td>línea 3</td><td>200000</td><td>Resuelve <code>170000 + 30000</code> y lo vuelve a guardar</td></tr>
  </tbody>
</table>

<p>La caja es siempre la misma; lo que cambia es lo que hay adentro. Esa tabla —qué vale cada variable después de cada línea— es la herramienta que te va a salvar en los ciclos.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Usar una variable antes de crearla</h3>
<pre><code>print(total)     # NameError: name ''total'' is not defined
total = 100</code></pre>
<p>Python lee de arriba hacia abajo. Cuando llegó al <code>print</code>, la caja <code>total</code> todavía no existía.</p>

<h3>2. Creer que el resultado se guarda solo</h3>
<pre><code>saldo = 250000
saldo - 80000          # esto calcula 170000 y lo bota
print(saldo)           # 250000 — nada cambió</code></pre>
<p>Calcular no es guardar. Si no hay <code>saldo = ...</code>, el resultado se pierde.</p>

<h3>3. Sumar texto con número</h3>
<pre><code>precio = "1500"
print(precio + 500)    # TypeError</code></pre>
<p>Ese <code>1500</code> entre comillas es texto. O le quitas las comillas, o usas <code>int(precio) + 500</code>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Todo dato que vayas a usar más de una vez merece una variable.</li>
  <li>Ponle un nombre que se lea solo, en <code>snake_case</code>.</li>
  <li>Si lo vas a mostrar, es texto. Si vas a hacer cuentas, es número.</li>
  <li>Cuando cruzas de un lado al otro, convierte con <code>str()</code>, <code>int()</code> o <code>float()</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>saldo = 250000</code></td><td>Crea la caja <code>saldo</code> con ese número</td></tr>
    <tr><td><code>type(saldo)</code></td><td>Dice de qué tipo es</td></tr>
    <tr><td><code>str(17)</code></td><td><code>"17"</code> — número a texto</td></tr>
    <tr><td><code>int("17")</code></td><td><code>17</code> — texto a número entero</td></tr>
    <tr><td><code>float("4.5")</code></td><td><code>4.5</code> — texto a decimal</td></tr>
    <tr><td><code>1_500_000</code></td><td>Un millón y medio, más fácil de leer</td></tr>
  </tbody>
</table>

<blockquote>Regla de oro: si vas a mostrarlo, es texto. Si vas a hacer cuentas con eso, es número. Convierte cuando cruces de un lado al otro.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 1
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 2 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Ficha del estudiante', 'facil', '<p>Cree tres variables: <code>nombre</code> (texto), <code>edad</code> (entero) y <code>estatura</code> (decimal). Luego muestre una sola línea con el formato:</p><pre><code>Ana tiene 17 anios y mide 1.62 metros</code></pre><p><em>Nota:</em> use las comas de <code>print()</code>, no concatenación con <code>+</code>.</p>', '<p>Las comas de <code>print()</code> aceptan textos y números mezclados y ponen un espacio entre cada argumento. Por eso no necesitas <code>str()</code>.</p>', '<pre><code># Ficha basica del estudiante
nombre = "Ana"
edad = 17
estatura = 1.62

print(nombre, "tiene", edad, "anios y mide", estatura, "metros")</code></pre><p>Las tres primeras líneas crean las cajas. La última las usa: <code>print()</code> recibe seis argumentos y los pega con un espacio entre cada uno. Si hubieras usado <code>+</code> tendrías que convertir <code>edad</code> y <code>estatura</code> con <code>str()</code>.</p>', '[{"stdin":"","expected_output":"Ana tiene 17 anios y mide 1.62 metros"}]', '# Ficha basica del estudiante
', 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Movimientos de la cuenta', 'facil', '<p>Una cuenta de ahorros arranca con <strong>250000</strong> pesos. Se hace un retiro de <strong>80000</strong> y luego una consignación de <strong>30000</strong>.</p><p>Escriba un programa que muestre el saldo después de cada movimiento:</p><pre><code>Saldo inicial: 250000
Despues del retiro: 170000
Saldo final: 200000</code></pre>', '<p>Usa <strong>una sola</strong> variable <code>saldo</code> y ve reasignándola: <code>saldo = saldo - 80000</code>. Imprime después de cada cambio.</p>', '<pre><code># Movimientos de una cuenta de ahorros
saldo = 250000
print("Saldo inicial:", saldo)

saldo = saldo - 80000     # retiro
print("Despues del retiro:", saldo)

saldo = saldo + 30000     # consignacion
print("Saldo final:", saldo)</code></pre><p>La clave es que la caja <code>saldo</code> es siempre la misma; lo que cambia es su contenido. Python primero resuelve el lado derecho (<code>250000 - 80000</code>) y después guarda el resultado en la misma variable.</p>', '[{"stdin":"","expected_output":"Saldo inicial: 250000\nDespues del retiro: 170000\nSaldo final: 200000"}]', '# Movimientos de una cuenta de ahorros
saldo = 250000
', 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'La calculadora que se rompió', 'medio', '<p>Este programa debería sumar dos números pero imprime <code>1020</code> en vez de <code>30</code>:</p><pre><code>a = "10"
b = "20"
print(a + b)</code></pre><p>Explique por qué pasa y entregue el programa corregido, que debe imprimir:</p><pre><code>30</code></pre>', '<p>Mire las comillas. Con dos <code>str</code>, el operador <code>+</code> no suma: pega. Hay dos formas de arreglarlo y ambas son válidas.</p>', '<p><code>a</code> y <code>b</code> son <code>str</code>, no <code>int</code>. Con textos, <code>+</code> concatena: <code>"10" + "20"</code> da <code>"1020"</code>.</p><pre><code># Los datos son numeros desde el principio: se quitan las comillas
a = 10
b = 20
print(a + b)          # 30</code></pre><p>Hay una segunda forma, igual de válida, para cuando el dato <em>tiene</em> que llegar como texto:</p><pre><code>a = "10"
b = "20"
print(int(a) + int(b))   # 30</code></pre><p>La primera es mejor cuando el dato siempre es número. La segunda es la que vas a usar en el capítulo 3, cuando el dato venga de <code>input()</code>, que siempre entrega texto.</p>', '[{"stdin":"","expected_output":"30"}]', 'a = "10"
b = "20"
print(a + b)
', 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Liquidación de la quincena', 'dificil', '<p>Un empleado de una tienda gana <strong>7000</strong> pesos la hora y trabajó <strong>96</strong> horas en la quincena. Le descuentan el <strong>4%</strong> de salud y el <strong>4%</strong> de pensión sobre el total.</p><p>Escriba un programa que calcule y muestre:</p><pre><code>Total devengado: 672000
Salud: 26880.0
Pension: 26880.0
Neto a pagar: 618240.0</code></pre><p><em>Nota:</em> use variables con nombres claros para el valor de la hora, las horas y cada descuento. Nada de números sueltos repetidos.</p>', '<p>Calcula primero el total devengado y guárdalo. Los descuentos son <code>total * 0.04</code>. El neto es el total menos los dos descuentos. Fíjate en que multiplicar un <code>int</code> por un <code>float</code> da <code>float</code>: por eso salen los <code>.0</code>.</p>', '<pre><code># Liquidacion de quincena de un empleado de tienda
valor_hora = 7000
horas_trabajadas = 96
porcentaje_salud = 0.04
porcentaje_pension = 0.04

total_devengado = valor_hora * horas_trabajadas
salud = total_devengado * porcentaje_salud
pension = total_devengado * porcentaje_pension
neto = total_devengado - salud - pension

print("Total devengado:", total_devengado)
print("Salud:", salud)
print("Pension:", pension)
print("Neto a pagar:", neto)</code></pre><p>Por qué queda así de largo y está bien que lo esté:</p><ul><li>Cada dato de entrada tiene su variable con nombre propio. Si mañana la hora sube a 7500, se cambia <strong>un</strong> número.</li><li><code>total_devengado</code> es <code>int</code> (7000 × 96 = 672000), pero al multiplicarlo por <code>0.04</code> el resultado es <code>float</code>. Por eso salen los decimales.</li><li>El neto se calcula a partir de las variables anteriores, no repitiendo cuentas.</li></ul>', '[{"stdin":"","expected_output":"Total devengado: 672000\nSalud: 26880.0\nPension: 26880.0\nNeto a pagar: 618240.0"}]', '# Liquidacion de quincena de un empleado de tienda
valor_hora = 7000
horas_trabajadas = 96
', 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué significa el signo = en Python?', NULL, '{"options":[{"id":"a","text":"Guarda en la variable de la izquierda el valor de la derecha"},{"id":"b","text":"Compara si los dos lados son iguales"},{"id":"c","text":"Suma los dos lados"},{"id":"d","text":"Declara una constante que no se puede cambiar"}]}', '{"option_id":"a"}', 'El = es asignación. Comparar es == , que verás en el capítulo 4.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿De qué tipo es la variable precio en precio = "1990"?', NULL, '{"options":[{"id":"a","text":"str, porque está entre comillas"},{"id":"b","text":"int, porque solo tiene dígitos"},{"id":"c","text":"float, porque representa dinero"},{"id":"d","text":"bool"}]}', '{"option_id":"a"}', 'Las comillas mandan: todo lo que va entre comillas es texto, aunque parezca número.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál de estos nombres de variable es válido?', NULL, '{"options":[{"id":"a","text":"nota_final"},{"id":"b","text":"2do_intento"},{"id":"c","text":"nota final"},{"id":"d","text":"nota-final"}]}', '{"option_id":"a"}', 'Solo letras, números y guion bajo, y sin empezar por número. El guion medio Python lo lee como una resta.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En Python, ¿qué representa el literal 1.500?', NULL, '{"options":[{"id":"a","text":"Uno coma cinco: el punto es el separador decimal"},{"id":"b","text":"Mil quinientos"},{"id":"c","text":"Un error de sintaxis"},{"id":"d","text":"El texto \"1.500\""}]}', '{"option_id":"a"}', 'Mil quinientos se escribe 1500 o 1_500. El punto siempre es decimal.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué tipo devuelve la operación 7000 * 0.04?', NULL, '{"options":[{"id":"a","text":"float"},{"id":"b","text":"int"},{"id":"c","text":"str"},{"id":"d","text":"bool"}]}', '{"option_id":"a"}', 'Si uno de los dos es float, el resultado es float. Por eso los descuentos salen con .0', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'x = 5
x = x + 3
print(x)', '{"options":[{"id":"a","text":"8"},{"id":"b","text":"5"},{"id":"c","text":"53"},{"id":"d","text":"Error: no se puede usar x en su propia asignación"}]}', '{"option_id":"a"}', 'Python resuelve primero el lado derecho (5 + 3) y después guarda el 8 en la misma caja.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print("2" + "3")', '{"options":[{"id":"a","text":"23"},{"id":"b","text":"5"},{"id":"c","text":"2 3"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'Con textos el + pega en vez de sumar. Para sumar habría que convertir con int().', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'saldo = 250000
saldo - 80000
print(saldo)', '{"options":[{"id":"a","text":"250000"},{"id":"b","text":"170000"},{"id":"c","text":"0"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'La línea 2 calcula 170000 y lo bota: sin una asignación, el resultado se pierde.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'edad = 17
print("Edad:", edad)', '{"options":[{"id":"a","text":"Edad: 17"},{"id":"b","text":"TypeError"},{"id":"c","text":"Edad:17"},{"id":"d","text":"Edad: edad"}]}', '{"option_id":"a"}', 'Las comas de print() aceptan tipos mezclados: no hace falta str(). Con + sí daría TypeError.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'a = 10
b = a
a = 99
print(b)', '{"options":[{"id":"a","text":"10"},{"id":"b","text":"99"},{"id":"c","text":"1099"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'b se llevó una copia del valor que a tenía en ese momento. Cambiar a después no afecta a b.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'print(type(4.5))', '{"options":[{"id":"a","text":"class ''float''"},{"id":"b","text":"class ''int''"},{"id":"c","text":"class ''str''"},{"id":"d","text":"4.5"}]}', '{"option_id":"a"}', 'type() dice de qué tipo es el dato. Con decimales, siempre float.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', '¿En qué línea está el error?', NULL, '{"lines":["edad = 17","print(\"Edad: \" + edad)","print(\"fin\")"]}', '{"line_number":2}', 'No se puede pegar texto con número usando +. Faltaba str(edad), o usar las comas de print().', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["print(total)","total = 100","print(total)"]}', '{"line_number":1}', 'Python lee de arriba hacia abajo: cuando llegó al primer print, la variable total todavía no existía.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que calcula el neto de la quincena', NULL, '{"lines":[{"id":"l1","text":"valor_hora = 7000","indent":0},{"id":"l2","text":"horas = 96","indent":0},{"id":"l3","text":"total = valor_hora * horas","indent":0},{"id":"l4","text":"descuentos = total * 0.08","indent":0},{"id":"l5","text":"print(\"Neto:\", total - descuentos)","indent":0}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Una variable no se puede usar antes de crearse: primero los datos de entrada, luego los cálculos que dependen de ellos y al final la salida.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa que muestra el saldo tras dos movimientos', NULL, '{"lines":[{"id":"l1","text":"saldo = 250000","indent":0},{"id":"l2","text":"saldo = saldo - 80000","indent":0},{"id":"l3","text":"saldo = saldo + 30000","indent":0},{"id":"l4","text":"print(\"Saldo final:\", saldo)","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'El orden de los movimientos cambia el resultado intermedio, y el print va de último para ver el saldo ya actualizado.', 1, 'seed'
    FROM chapters WHERE number = 2 AND track = 'basico';

-- ── Capítulo 3: input() y conversiones (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 3, 'input() y conversiones', '⌨️', 'Pedirle datos al usuario y convertirlos al tipo correcto.', '<p class="jc-gancho">Hasta ahora tus programas siempre hacen lo mismo porque los datos están escritos adentro. Un cajero que solo sabe retirar 80000 pesos no le sirve a nadie. Lo que falta es que el programa <strong>pregunte</strong>.</p>

<h2><code>input()</code>: el programa pregunta y espera</h2>

<p>La instrucción <code>input()</code> muestra un mensaje, detiene el programa y espera a que el usuario escriba algo y presione Enter. Lo que haya escrito queda como resultado.</p>

<pre><code>nombre = input("¿Cómo te llamas? ")
print("Mucho gusto,", nombre)</code></pre>

<p>Paso a paso:</p>

<table>
  <thead>
    <tr><th>Momento</th><th>Qué pasa</th></tr>
  </thead>
  <tbody>
    <tr><td>Antes</td><td>Python muestra <code>¿Cómo te llamas?</code> y se queda quieto.</td></tr>
    <tr><td>El usuario escribe <code>Ana</code> y da Enter</td><td><code>input()</code> devuelve el texto <code>"Ana"</code>.</td></tr>
    <tr><td>Después</td><td>Ese texto se guarda en <code>nombre</code> y el programa sigue.</td></tr>
  </tbody>
</table>

<p>Fíjate en el espacio al final del mensaje: <code>"¿Cómo te llamas? "</code>. Sin él, el cursor queda pegado a la pregunta y se ve feo. Es un detalle de un renglón que separa un programa cuidado de uno hecho a la carrera.</p>

<h2>La trampa: <code>input()</code> SIEMPRE devuelve texto</h2>

<p>Esta es la fuente número uno de errores en este punto del curso. Aunque el usuario escriba <code>25</code>, lo que llega es el <strong>texto</strong> <code>"25"</code>.</p>

<pre><code>edad = input("Edad: ")     # el usuario escribe 25
print(edad + 1)            # TypeError: can only concatenate str (not "int") to str</code></pre>

<p>Y lo peor no es que falle: es cuando <em>no</em> falla y da un resultado equivocado.</p>

<pre><code>cantidad = input("Cantidad: ")   # el usuario escribe 3
print(cantidad * 2)              # imprime 33, no 6</code></pre>

<p>Python multiplicó el texto <code>"3"</code> por 2 y lo repitió. El programa corrió feliz y entregó basura. Por eso la regla es tajante: <strong>todo dato numérico que venga de <code>input()</code> hay que convertirlo</strong>.</p>

<h3>La conversión va pegada al input</h3>

<pre><code>edad = int(input("Edad: "))            # texto -> entero
precio = float(input("Precio: "))      # texto -> decimal

print("El año que viene tendrás", edad + 1)</code></pre>

<p>Se lee de adentro hacia afuera: primero corre <code>input(...)</code>, que entrega texto; ese texto entra en <code>int(...)</code>, que entrega un número; y ese número se guarda en la variable.</p>

<h2>Cuándo <code>int()</code> se queja</h2>

<p><code>int()</code> solo convierte lo que de verdad es un entero escrito con dígitos:</p>

<pre><code>int("25")      # 25   ✅
int(" 25 ")    # 25   ✅ los espacios sobrantes no molestan
int("25.7")    # ValueError ❌ eso es un decimal, no un entero
int("veinte")  # ValueError ❌
int("")        # ValueError ❌ el usuario solo dio Enter</code></pre>

<p><code>ValueError</code> significa "el tipo está bien (es un texto) pero el contenido no me sirve". Si esperas decimales, usa <code>float()</code>, que sí acepta <code>"25.7"</code>. Y si necesitas un entero a partir de un decimal, convierte en dos pasos: <code>int(float("25.7"))</code> da 25 (recorta, no redondea).</p>

<p>Por ahora, si el usuario escribe cualquier cosa, el programa se cae. Eso está bien: en el capítulo 15 aprenderás a atraparlo con <code>try / except</code>.</p>

<h2>Documentar como en la universidad</h2>

<p>Desde este capítulo, todos los programas del libro se entregan documentados. No es adorno: es lo que te van a calificar.</p>

<pre><code>''''''
Programa: Calculadora de descuento
Autor:    Ana Gómez
Fecha:    2026-03-14
Descripción:
    Pide el precio de un producto y el porcentaje de descuento,
    y muestra cuánto se ahorra y cuánto queda por pagar.
''''''

# Inicio
precio = float(input("Precio del producto: "))
descuento = float(input("Descuento (%): "))

# El porcentaje se divide entre 100 para volverlo proporción
ahorro = precio * (descuento / 100)
total = precio - ahorro

print("Te ahorras:", ahorro)
print("Total a pagar:", total)
# Fin</code></pre>

<p>Las tres partes:</p>

<ul>
  <li><strong>El encabezado</strong> entre <code>''''''</code>: qué programa es, quién lo hizo, cuándo y qué hace. Ese bloque se llama <em>docstring</em>.</li>
  <li><strong><code># Inicio</code> y <code># Fin</code></strong>: marcan dónde arranca y termina la lógica.</li>
  <li><strong>Comentarios de porqué</strong>: adentro, solo donde una línea necesita explicación. No comentes lo obvio.</li>
</ul>

<h2>La película de un programa con input</h2>

<p>Supongamos que el usuario escribe <code>12000</code> y luego <code>3</code>:</p>

<pre><code>precio = int(input("Precio: "))       # línea 1
cantidad = int(input("Cantidad: "))   # línea 2
total = precio * cantidad             # línea 3
print("Total:", total)                # línea 4</code></pre>

<table>
  <thead>
    <tr><th>Después de…</th><th><code>precio</code></th><th><code>cantidad</code></th><th><code>total</code></th></tr>
  </thead>
  <tbody>
    <tr><td>línea 1</td><td>12000</td><td>no existe</td><td>no existe</td></tr>
    <tr><td>línea 2</td><td>12000</td><td>3</td><td>no existe</td></tr>
    <tr><td>línea 3</td><td>12000</td><td>3</td><td>36000</td></tr>
  </tbody>
</table>

<p>Si en la línea 1 hubiera faltado el <code>int()</code>, en la línea 3 <code>total</code> valdría <code>"120001200012000"</code>. Corre igual, y está mal.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Olvidar el <code>int()</code></h3>
<pre><code>cantidad = input("Cantidad: ")
print(cantidad * 2)     # "33" en vez de 6</code></pre>
<p>El más peligroso, porque no siempre revienta: a veces solo entrega un número equivocado.</p>

<h3>2. Convertir a <code>int</code> algo con decimales</h3>
<pre><code>precio = int(input("Precio: "))    # el usuario escribe 12500.50 -> ValueError</code></pre>
<p>Si el dato puede llevar centavos, es <code>float()</code>.</p>

<h3>3. Poner el mensaje en un <code>print</code> aparte</h3>
<pre><code>print("Edad: ")
edad = int(input())     # funciona, pero el cursor queda en otra línea</code></pre>
<p>El mensaje va <em>dentro</em> del <code>input()</code>. Para eso está.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Pide el dato con <code>input("mensaje: ")</code>, con espacio al final.</li>
  <li>Si es número, envuélvelo de una en <code>int()</code> o <code>float()</code>.</li>
  <li>Calcula con variables de nombre claro.</li>
  <li>Muestra el resultado con <code>print()</code>.</li>
  <li>Documenta: encabezado <code>''''''</code>, <code># Inicio</code>, <code># Fin</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>input("Nombre: ")</code></td><td>Pregunta y devuelve lo escrito, siempre como texto</td></tr>
    <tr><td><code>int(input("Edad: "))</code></td><td>Pregunta y convierte a entero</td></tr>
    <tr><td><code>float(input("Precio: "))</code></td><td>Pregunta y convierte a decimal</td></tr>
    <tr><td><code>int("25.7")</code></td><td><code>ValueError</code>: para eso está <code>float()</code></td></tr>
    <tr><td><code>int(float("25.7"))</code></td><td><code>25</code> — recorta los decimales</td></tr>
  </tbody>
</table>

<blockquote>Todo lo que entra por el teclado es texto. Si vas a hacer cuentas con eso, conviértelo en la misma línea en que lo pides.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 1
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 3 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Saludo personalizado', 'facil', '<p>Solicitar al usuario su nombre y su ciudad. Mostrar un saludo con el formato:</p><pre><code>Hola Ana , bienvenida desde Bogota</code></pre><p><em>Nota:</em> use las comas de <code>print()</code>. El programa debe ir documentado con encabezado y secciones <code>#Inicio</code> / <code>#Fin</code>.</p>', '<p>Dos <code>input()</code>, dos variables y un <code>print()</code> con varios argumentos. Aquí no hay que convertir nada: nombre y ciudad son textos.</p>', '<pre><code>''''''
Programa: Saludo personalizado
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide el nombre y la ciudad del usuario y muestra un saludo.
''''''

# Inicio
nombre = input("Nombre: ")
ciudad = input("Ciudad: ")

print("Hola", nombre, ", bienvenida desde", ciudad)
# Fin</code></pre><p>Línea por línea:</p><ol><li>El encabezado documenta el programa. No lo ejecuta Python, pero es lo primero que lee quien califica.</li><li><code>input("Nombre: ")</code> muestra el mensaje, espera el Enter y devuelve lo escrito.</li><li>Como los dos datos son texto, no hace falta <code>int()</code> ni <code>float()</code>.</li><li>Las comas de <code>print()</code> ponen los espacios; por eso la coma del saludo queda separada.</li></ol>', '[{"stdin":"Ana\nBogota\n","expected_output":"Nombre: Ciudad: Hola Ana , bienvenida desde Bogota"}]', '''''''
Programa: Saludo personalizado
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Total de la compra', 'facil', '<p>Solicitar el precio unitario de un producto y la cantidad comprada. Calcular y mostrar el total:</p><pre><code>Total a pagar: 36000</code></pre><p><em>Nota:</em> el precio y la cantidad son enteros. Recuerde que <code>input()</code> entrega texto.</p>', '<p>Envuelve cada <code>input()</code> en <code>int()</code> desde el momento en que pides el dato. Si no, <code>precio * cantidad</code> repetirá el texto en vez de multiplicar.</p>', '<pre><code>''''''
Programa: Total de la compra
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide precio unitario y cantidad, y calcula el total a pagar.
''''''

# Inicio
precio = int(input("Precio unitario: "))
cantidad = int(input("Cantidad: "))

total = precio * cantidad

print("Total a pagar:", total)
# Fin</code></pre><p>La conversión va pegada al <code>input()</code>: se lee de adentro hacia afuera. Primero <code>input()</code> entrega el texto <code>"12000"</code>, después <code>int()</code> lo vuelve el número <code>12000</code>, y ese número se guarda. Sin el <code>int()</code>, <code>"12000" * 3</code> daría el texto repetido tres veces.</p>', '[{"stdin":"12000\n3\n","expected_output":"Precio unitario: Cantidad: Total a pagar: 36000"},{"stdin":"2500\n10\n","expected_output":"Precio unitario: Cantidad: Total a pagar: 25000"}]', '''''''
Programa: Total de la compra
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Descuento del almacén', 'medio', '<p>Solicitar el precio de un producto (puede tener decimales) y el porcentaje de descuento. Calcular y mostrar cuánto se ahorra el cliente y cuánto debe pagar:</p><pre><code>Te ahorras: 15000.0
Total a pagar: 85000.0</code></pre><p><em>Nota:</em> el porcentaje se recibe como número entre 0 y 100.</p>', '<p>Use <code>float()</code> porque el precio puede llevar centavos. Para pasar de porcentaje a proporción, divida entre 100: un 15% es <code>15 / 100</code>, o sea <code>0.15</code>.</p>', '<pre><code>''''''
Programa: Descuento del almacen
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide el precio de un producto y el porcentaje de descuento,
    y muestra el ahorro y el total a pagar.
''''''

# Inicio
precio = float(input("Precio del producto: "))
descuento = float(input("Descuento (%): "))

# El porcentaje se divide entre 100 para volverlo proporcion
ahorro = precio * (descuento / 100)
total = precio - ahorro

print("Te ahorras:", ahorro)
print("Total a pagar:", total)
# Fin</code></pre><p>Tres decisiones que valen puntos:</p><ul><li><code>float()</code> y no <code>int()</code>: un precio puede ser <code>99500.50</code>.</li><li>El paréntesis en <code>(descuento / 100)</code> deja clarísimo qué se divide primero, aunque la precedencia ya lo haría bien.</li><li>El ahorro se guarda en su propia variable porque se necesita dos veces: para mostrarlo y para restarlo.</li></ul>', '[{"stdin":"100000\n15\n","expected_output":"Precio del producto: Descuento (%): Te ahorras: 15000.0\nTotal a pagar: 85000.0"}]', '''''''
Programa: Descuento del almacen
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Cambio del cajero', 'dificil', '<p>Un cajero de tienda necesita saber con cuántos billetes devolver el cambio. Solicitar el valor de la compra y con cuánto paga el cliente. Calcular el cambio y descomponerlo en billetes de <strong>50000</strong>, <strong>20000</strong>, <strong>10000</strong> y el resto suelto:</p><pre><code>Cambio: 87000
Billetes de 50000: 1
Billetes de 20000: 1
Billetes de 10000: 1
Suelto: 7000</code></pre><p><em>Nota:</em> use división entera <code>//</code> para saber cuántos billetes caben y módulo <code>%</code> para lo que sobra.</p>', '<p><code>87000 // 50000</code> da 1 (cuántos caben) y <code>87000 % 50000</code> da 37000 (lo que sobra). Repite la pareja con cada denominación, arrastrando siempre el sobrante.</p>', '<pre><code>''''''
Programa: Cambio del cajero
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula el cambio de una compra y lo descompone en billetes
    de 50000, 20000 y 10000, mostrando el suelto restante.
''''''

# Inicio
compra = int(input("Valor de la compra: "))
pago = int(input("Paga con: "))

cambio = pago - compra
print("Cambio:", cambio)

# Con cada denominacion: cuantos caben (//) y cuanto sobra (%)
billetes_50 = cambio // 50000
resto = cambio % 50000

billetes_20 = resto // 20000
resto = resto % 20000

billetes_10 = resto // 10000
suelto = resto % 10000

print("Billetes de 50000:", billetes_50)
print("Billetes de 20000:", billetes_20)
print("Billetes de 10000:", billetes_10)
print("Suelto:", suelto)
# Fin</code></pre><p>La idea completa, con 87000 de cambio:</p><table><thead><tr><th>Paso</th><th>Cuentan</th><th>Sobra</th></tr></thead><tbody><tr><td>50000</td><td>87000 // 50000 = 1</td><td>87000 % 50000 = 37000</td></tr><tr><td>20000</td><td>37000 // 20000 = 1</td><td>37000 % 20000 = 17000</td></tr><tr><td>10000</td><td>17000 // 10000 = 1</td><td>17000 % 10000 = 7000</td></tr></tbody></table><p>La variable <code>resto</code> se va reasignando: siempre guarda lo que queda por repartir. Ese patrón —dividir, guardar el sobrante y seguir— aparece en muchísimos ejercicios.</p>', '[{"stdin":"13000\n100000\n","expected_output":"Valor de la compra: Paga con: Cambio: 87000\nBilletes de 50000: 1\nBilletes de 20000: 1\nBilletes de 10000: 1\nSuelto: 7000"}]', '''''''
Programa: Cambio del cajero
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué tipo devuelve siempre input()?', NULL, '{"options":[{"id":"a","text":"str, sin importar lo que escriba el usuario"},{"id":"b","text":"int si el usuario escribe dígitos"},{"id":"c","text":"El tipo que Python adivine del contenido"},{"id":"d","text":"float, para poder hacer cuentas"}]}', '{"option_id":"a"}', 'input() siempre entrega texto. Por eso hay que convertir con int() o float() cuando el dato es numérico.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Dónde va el mensaje que ve el usuario al pedir un dato?', NULL, '{"options":[{"id":"a","text":"Dentro del paréntesis del input()"},{"id":"b","text":"En un print() de la línea anterior"},{"id":"c","text":"En un comentario"},{"id":"d","text":"En el encabezado del programa"}]}', '{"option_id":"a"}', 'input("Edad: ") muestra el mensaje y deja el cursor a continuación. Con print() aparte el cursor baja de línea.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'El usuario debe escribir un precio que puede llevar centavos. ¿Cómo se pide?', NULL, '{"options":[{"id":"a","text":"float(input(\"Precio: \"))"},{"id":"b","text":"int(input(\"Precio: \"))"},{"id":"c","text":"input(float(\"Precio: \"))"},{"id":"d","text":"str(input(\"Precio: \"))"}]}', '{"option_id":"a"}', 'int() revienta con "12500.50". Para decimales se usa float(), y la conversión envuelve al input().', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué error lanza int("veinte")?', NULL, '{"options":[{"id":"a","text":"ValueError"},{"id":"b","text":"TypeError"},{"id":"c","text":"NameError"},{"id":"d","text":"SyntaxError"}]}', '{"option_id":"a"}', 'El tipo es correcto (un texto), pero el contenido no representa un entero: eso es ValueError.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué debe llevar el encabezado documentado de un programa?', NULL, '{"options":[{"id":"a","text":"Nombre del programa, autor, fecha y descripción, entre comillas triples"},{"id":"b","text":"Solo el nombre del archivo"},{"id":"c","text":"La lista completa de variables usadas"},{"id":"d","text":"El resultado esperado del programa"}]}', '{"option_id":"a"}', 'El bloque entre '''''' documenta qué es el programa y quién lo hizo. Adentro van las secciones #Inicio y #Fin.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'El usuario escribe 3. ¿Qué imprime este programa?', 'cantidad = input("Cantidad: ")
print(cantidad * 2)', '{"options":[{"id":"a","text":"33"},{"id":"b","text":"6"},{"id":"c","text":"3 3"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'Falta el int(): multiplicar un texto por 2 lo repite. Corre sin error y entrega basura, que es lo peligroso.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'El usuario escribe 25. ¿Qué imprime este programa?', 'edad = int(input("Edad: "))
print(edad + 1)', '{"options":[{"id":"a","text":"26"},{"id":"b","text":"251"},{"id":"c","text":"TypeError"},{"id":"d","text":"ValueError"}]}', '{"option_id":"a"}', 'Con el int() la suma es aritmética. Sin él, sería TypeError al mezclar texto y número.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print(int(" 25 "))', '{"options":[{"id":"a","text":"25"},{"id":"b","text":"ValueError"},{"id":"c","text":"\" 25 \""},{"id":"d","text":"2 5"}]}', '{"option_id":"a"}', 'int() ignora los espacios de sobra a lado y lado. Lo que no acepta son letras ni decimales.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'print(int(float("25.7")))', '{"options":[{"id":"a","text":"25"},{"id":"b","text":"26"},{"id":"c","text":"25.7"},{"id":"d","text":"ValueError"}]}', '{"option_id":"a"}', 'float() acepta el decimal y int() recorta la parte decimal: no redondea, la corta.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'El usuario escribe 12000 y luego 3. ¿Qué imprime?', 'precio = input("Precio: ")
cantidad = int(input("Cantidad: "))
print(precio * cantidad)', '{"options":[{"id":"a","text":"120001200012000"},{"id":"b","text":"36000"},{"id":"c","text":"TypeError"},{"id":"d","text":"12000 3"}]}', '{"option_id":"a"}', 'precio quedó como texto: texto por entero repite el texto tres veces. El error está en la línea 1, no en la 3.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe sumar 1 a la edad. ¿En qué línea está el error?', NULL, '{"lines":["edad = input(\"Edad: \")","print(edad + 1)"]}', '{"line_number":1}', 'Falta convertir: debía ser int(input("Edad: ")). El síntoma sale en la línea 2, pero el error se cometió en la 1.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El precio puede tener centavos. ¿En qué línea está el error?', NULL, '{"lines":["''''''","Programa: Compra","''''''","# Inicio","precio = int(input(\"Precio: \"))","print(\"Precio:\", precio)","# Fin"]}', '{"line_number":5}', 'Con centavos, int() lanza ValueError. Ahí va float().', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["nombre = input(\"Nombre: \")","edad = int(input(\"Edad: \")","print(nombre, edad)"]}', '{"line_number":2}', 'Falta un paréntesis de cierre: se abrieron int( e input( y solo se cerró uno.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que calcula el total de una compra', NULL, '{"lines":[{"id":"l1","text":"precio = int(input(\"Precio unitario: \"))","indent":0},{"id":"l2","text":"cantidad = int(input(\"Cantidad: \"))","indent":0},{"id":"l3","text":"total = precio * cantidad","indent":0},{"id":"l4","text":"print(\"Total a pagar:\", total)","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'Primero se piden los dos datos, después se calcula con ellos y de último se muestra. No se puede calcular con algo que aún no se pidió.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa documentado que calcula el descuento', NULL, '{"lines":[{"id":"l1","text":"''''''","indent":0},{"id":"l2","text":"Programa: Descuento del almacen","indent":0},{"id":"l3","text":"''''''","indent":0},{"id":"l4","text":"# Inicio","indent":0},{"id":"l5","text":"precio = float(input(\"Precio: \"))","indent":0},{"id":"l6","text":"descuento = float(input(\"Descuento (%): \"))","indent":0},{"id":"l7","text":"total = precio - precio * (descuento / 100)","indent":0},{"id":"l8","text":"print(\"Total a pagar:\", total)","indent":0},{"id":"l9","text":"# Fin","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7","l8","l9"]}', 'El encabezado abre y cierra con '''''', y toda la lógica queda encerrada entre #Inicio y #Fin.', 1, 'seed'
    FROM chapters WHERE number = 3 AND track = 'basico';

-- ── Capítulo 4: Operadores (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 4, 'Operadores', '🧮', 'Aritméticos, de comparación y lógicos, con su orden de precedencia.', '<p class="jc-gancho">Un parqueadero cobra 3000 la primera hora y 1500 cada hora adicional. ¿Cuánto le cobras a alguien que estuvo 4 horas y 20 minutos? Todo eso son operadores: dividir, sacar el resto, comparar y decidir.</p>

<h2>Los aritméticos</h2>

<table>
  <thead>
    <tr><th>Operador</th><th>Qué hace</th><th>Ejemplo</th><th>Resultado</th></tr>
  </thead>
  <tbody>
    <tr><td><code>+</code></td><td>Suma</td><td><code>7 + 2</code></td><td><code>9</code></td></tr>
    <tr><td><code>-</code></td><td>Resta</td><td><code>7 - 2</code></td><td><code>5</code></td></tr>
    <tr><td><code>*</code></td><td>Multiplica</td><td><code>7 * 2</code></td><td><code>14</code></td></tr>
    <tr><td><code>/</code></td><td>Divide (siempre decimal)</td><td><code>7 / 2</code></td><td><code>3.5</code></td></tr>
    <tr><td><code>//</code></td><td>División entera</td><td><code>7 // 2</code></td><td><code>3</code></td></tr>
    <tr><td><code>%</code></td><td>Resto de la división</td><td><code>7 % 2</code></td><td><code>1</code></td></tr>
    <tr><td><code>**</code></td><td>Potencia</td><td><code>7 ** 2</code></td><td><code>49</code></td></tr>
  </tbody>
</table>

<p>Los tres primeros no tienen misterio. Los que hay que entender de verdad son <code>/</code>, <code>//</code> y <code>%</code>.</p>

<h3><code>/</code> siempre devuelve decimal</h3>

<pre><code>print(10 / 2)     # 5.0  <- no 5
print(10 / 3)     # 3.3333333333333335</code></pre>

<p>Aunque la división sea exacta, <code>/</code> entrega <code>float</code>. Si necesitas un entero, usa <code>//</code>.</p>

<h3><code>//</code> y <code>%</code> son una pareja</h3>

<p>Piensa en repartir 17 dulces entre 5 niños:</p>

<pre><code>print(17 // 5)    # 3  <- a cada niño le tocan 3
print(17 % 5)     # 2  <- sobran 2</code></pre>

<p>Esa pareja resuelve una cantidad enorme de problemas reales:</p>

<ul>
  <li><strong>¿Es par?</strong> <code>numero % 2 == 0</code></li>
  <li><strong>¿Cuántos billetes de 50000 caben?</strong> <code>monto // 50000</code></li>
  <li><strong>Convertir minutos a horas y minutos:</strong> <code>total // 60</code> y <code>total % 60</code></li>
</ul>

<h2>La precedencia: quién va primero</h2>

<p>Python no lee de izquierda a derecha a secas. Respeta el orden de siempre:</p>

<ol>
  <li><code>()</code> paréntesis</li>
  <li><code>**</code> potencia</li>
  <li><code>*</code> <code>/</code> <code>//</code> <code>%</code></li>
  <li><code>+</code> <code>-</code></li>
</ol>

<pre><code>print(2 + 3 * 4)      # 14, no 20: primero multiplica
print((2 + 3) * 4)    # 20: el paréntesis manda</code></pre>

<p>El error clásico del promedio:</p>

<pre><code>nota1 = 4.0
nota2 = 3.0

print(nota1 + nota2 / 2)      # 5.5  ❌ dividió solo la segunda nota
print((nota1 + nota2) / 2)    # 3.5  ✅</code></pre>

<p>Consejo que vale por todo el capítulo: <strong>cuando dudes, pon paréntesis</strong>. No cuestan nada y le dicen al que lee exactamente qué querías.</p>

<h2>Los de comparación: preguntas de sí o no</h2>

<p>Estos no calculan: <em>responden</em>. El resultado es siempre <code>True</code> o <code>False</code>.</p>

<table>
  <thead>
    <tr><th>Operador</th><th>Pregunta</th><th>Ejemplo</th><th>Resultado</th></tr>
  </thead>
  <tbody>
    <tr><td><code>==</code></td><td>¿Son iguales?</td><td><code>3 == 3</code></td><td><code>True</code></td></tr>
    <tr><td><code>!=</code></td><td>¿Son distintos?</td><td><code>3 != 3</code></td><td><code>False</code></td></tr>
    <tr><td><code>&gt;</code></td><td>¿Mayor?</td><td><code>5 &gt; 3</code></td><td><code>True</code></td></tr>
    <tr><td><code>&lt;</code></td><td>¿Menor?</td><td><code>5 &lt; 3</code></td><td><code>False</code></td></tr>
    <tr><td><code>&gt;=</code></td><td>¿Mayor o igual?</td><td><code>3 &gt;= 3</code></td><td><code>True</code></td></tr>
    <tr><td><code>&lt;=</code></td><td>¿Menor o igual?</td><td><code>2 &lt;= 3</code></td><td><code>True</code></td></tr>
  </tbody>
</table>

<p><strong>Un signo igual guarda, dos preguntan.</strong> Confundirlos es el error más común del curso:</p>

<pre><code>edad = 18      # guarda 18 en edad
edad == 18     # pregunta si edad vale 18 -> True</code></pre>

<p>Python permite encadenar comparaciones como en matemáticas, y se lee precioso:</p>

<pre><code>nota = 3.8
print(3.0 &lt;= nota &lt;= 5.0)    # True</code></pre>

<h2>Los lógicos: unir varias preguntas</h2>

<table>
  <thead>
    <tr><th>Operador</th><th>Es verdadero cuando…</th></tr>
  </thead>
  <tbody>
    <tr><td><code>and</code></td><td>las dos partes son verdaderas</td></tr>
    <tr><td><code>or</code></td><td>al menos una parte es verdadera</td></tr>
    <tr><td><code>not</code></td><td>invierte: lo verdadero se vuelve falso</td></tr>
  </tbody>
</table>

<pre><code>edad = 20
tiene_cedula = True

print(edad &gt;= 18 and tiene_cedula)   # True: cumple las dos
print(edad &lt; 18 or tiene_cedula)     # True: basta con una
print(not tiene_cedula)              # False</code></pre>

<h3>La tabla de la verdad, en una frase</h3>

<table>
  <thead>
    <tr><th>A</th><th>B</th><th>A and B</th><th>A or B</th></tr>
  </thead>
  <tbody>
    <tr><td>True</td><td>True</td><td>True</td><td>True</td></tr>
    <tr><td>True</td><td>False</td><td>False</td><td>True</td></tr>
    <tr><td>False</td><td>True</td><td>False</td><td>True</td></tr>
    <tr><td>False</td><td>False</td><td>False</td><td>False</td></tr>
  </tbody>
</table>

<p><code>and</code> es exigente: si algo falla, todo falla. <code>or</code> es conforme: con una le basta.</p>

<h2>La película de un cálculo</h2>

<p>El parqueadero: 3000 la primera hora y 1500 cada hora adicional. Un carro estuvo 260 minutos y se cobra por hora empezada.</p>

<pre><code>minutos = 260
horas = minutos // 60        # línea 1
sobrante = minutos % 60      # línea 2
if sobrante &gt; 0:             # (esto lo verás en el capítulo 6)
    horas = horas + 1
total = 3000 + (horas - 1) * 1500
print("Total:", total)</code></pre>

<table>
  <thead>
    <tr><th>Después de…</th><th><code>horas</code></th><th><code>sobrante</code></th><th><code>total</code></th></tr>
  </thead>
  <tbody>
    <tr><td>línea 1</td><td>4</td><td>—</td><td>—</td></tr>
    <tr><td>línea 2</td><td>4</td><td>20</td><td>—</td></tr>
    <tr><td>ajuste por hora empezada</td><td>5</td><td>20</td><td>—</td></tr>
    <tr><td>cálculo final</td><td>5</td><td>20</td><td>3000 + 4×1500 = 9000</td></tr>
  </tbody>
</table>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Usar <code>=</code> donde va <code>==</code></h3>
<pre><code>if edad = 18:      # SyntaxError
if edad == 18:     # ✅</code></pre>

<h3>2. Olvidar el paréntesis del promedio</h3>
<pre><code>promedio = nota1 + nota2 / 2       # ❌
promedio = (nota1 + nota2) / 2     # ✅</code></pre>

<h3>3. Escribir la condición como se habla</h3>
<pre><code>if nota == 3 or 4:        # ❌ no hace lo que crees
if nota == 3 or nota == 4:  # ✅</code></pre>
<p>La primera versión pregunta "¿nota es 3?" y luego evalúa "¿4?", que para Python es verdadero por ser distinto de cero. La condición sale siempre verdadera.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Para cuentas exactas de conteo, <code>//</code> y <code>%</code>. Para promedios y plata, <code>/</code>.</li>
  <li>Cuando mezcles operaciones, pon paréntesis aunque no hagan falta.</li>
  <li>Una comparación siempre entrega <code>True</code> o <code>False</code>: puedes guardarla en una variable.</li>
  <li>Cada parte de un <code>and</code> / <code>or</code> tiene que ser una comparación completa.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>7 / 2</code></td><td><code>3.5</code> — siempre decimal</td></tr>
    <tr><td><code>7 // 2</code></td><td><code>3</code> — cuántas veces cabe</td></tr>
    <tr><td><code>7 % 2</code></td><td><code>1</code> — lo que sobra</td></tr>
    <tr><td><code>n % 2 == 0</code></td><td><code>True</code> si <code>n</code> es par</td></tr>
    <tr><td><code>(a + b) / 2</code></td><td>Promedio bien calculado</td></tr>
    <tr><td><code>3.0 &lt;= n &lt;= 5.0</code></td><td>¿Está en el rango?</td></tr>
    <tr><td><code>a and b</code> · <code>a or b</code></td><td>Las dos · al menos una</td></tr>
  </tbody>
</table>

<blockquote>Un signo igual guarda. Dos signos igual preguntan. Esa sola frase te ahorra la mitad de los errores del próximo capítulo.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 1
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 4 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Promedio de tres notas', 'facil', '<p>Solicitar tres notas de un estudiante (de 0.0 a 5.0). Calcular y mostrar el promedio:</p><pre><code>Promedio: 3.5</code></pre><p><em>Nota:</em> cuidado con la precedencia de operadores.</p>', '<p>Las tres notas se suman <strong>primero</strong> y el resultado se divide entre 3. Sin paréntesis, Python solo divide la última nota.</p>', '<pre><code>''''''
Programa: Promedio de tres notas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide tres notas de 0.0 a 5.0 y muestra el promedio.
''''''

# Inicio
nota1 = float(input("Nota 1: "))
nota2 = float(input("Nota 2: "))
nota3 = float(input("Nota 3: "))

# Los parentesis son obligatorios: sin ellos solo se dividiria nota3
promedio = (nota1 + nota2 + nota3) / 3

print("Promedio:", promedio)
# Fin</code></pre><p>Con notas 4.0, 3.0 y 3.5: <code>(4.0 + 3.0 + 3.5) / 3</code> = <code>10.5 / 3</code> = <code>3.5</code>. Sin los paréntesis Python haría <code>4.0 + 3.0 + (3.5 / 3)</code> = <code>8.166…</code>, que corre sin error y está mal.</p>', '[{"stdin":"4.0\n3.0\n3.5\n","expected_output":"Nota 1: Nota 2: Nota 3: Promedio: 3.5"}]', '''''''
Programa: Promedio de tres notas
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Minutos a horas y minutos', 'facil', '<p>Solicitar una cantidad de minutos y mostrarla en horas y minutos:</p><pre><code>260 minutos son 4 horas y 20 minutos</code></pre><p><em>Nota:</em> use división entera y módulo. No use decimales.</p>', '<p><code>260 // 60</code> dice cuántas horas completas caben, y <code>260 % 60</code> dice cuántos minutos sobran. Son la misma pareja de siempre.</p>', '<pre><code>''''''
Programa: Conversor de minutos
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Convierte una cantidad de minutos a horas y minutos.
''''''

# Inicio
total_minutos = int(input("Minutos: "))

horas = total_minutos // 60      # cuantas horas completas caben
minutos = total_minutos % 60     # lo que sobra

print(total_minutos, "minutos son", horas, "horas y", minutos, "minutos")
# Fin</code></pre><p>Es el mismo patrón del cambio del cajero: <code>//</code> dice cuántas veces cabe la unidad grande y <code>%</code> dice qué queda suelto. Si hubieras usado <code>/</code> obtendrías <code>4.333…</code>, que no sirve para separar horas de minutos.</p>', '[{"stdin":"260\n","expected_output":"Minutos: 260 minutos son 4 horas y 20 minutos"},{"stdin":"45\n","expected_output":"Minutos: 45 minutos son 0 horas y 45 minutos"}]', '''''''
Programa: Conversor de minutos
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Verificaciones de un cliente', 'medio', '<p>Solicitar la edad de un cliente y el saldo de su cuenta. Mostrar, con <code>True</code> o <code>False</code>, tres verificaciones:</p><pre><code>Es mayor de edad: True
Tiene saldo suficiente (>= 50000): True
Puede retirar: True</code></pre><p><em>Nota:</em> puede retirar si es mayor de edad <strong>y</strong> tiene saldo suficiente. No use <code>if</code> todavía: guarde cada comparación en una variable.</p>', '<p>Una comparación devuelve <code>True</code> o <code>False</code>, así que se puede guardar igual que un número: <code>mayor = edad >= 18</code>. Después une las dos con <code>and</code>.</p>', '<pre><code>''''''
Programa: Verificaciones de un cliente
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Verifica si un cliente es mayor de edad, si tiene saldo
    suficiente y si por lo tanto puede retirar.
''''''

# Inicio
edad = int(input("Edad: "))
saldo = int(input("Saldo: "))

# Cada comparacion devuelve True o False y se puede guardar
es_mayor = edad >= 18
tiene_saldo = saldo >= 50000
puede_retirar = es_mayor and tiene_saldo

print("Es mayor de edad:", es_mayor)
print("Tiene saldo suficiente (>= 50000):", tiene_saldo)
print("Puede retirar:", puede_retirar)
# Fin</code></pre><p>Lo importante del ejercicio es ver que <code>edad >= 18</code> <strong>es un valor</strong>, igual que <code>3 + 4</code> lo es. Guardarlo en una variable con nombre claro hace que la última línea se lea sola: <code>es_mayor and tiene_saldo</code>.</p>', '[{"stdin":"20\n80000\n","expected_output":"Edad: Saldo: Es mayor de edad: True\nTiene saldo suficiente (>= 50000): True\nPuede retirar: True"},{"stdin":"16\n80000\n","expected_output":"Edad: Saldo: Es mayor de edad: False\nTiene saldo suficiente (>= 50000): True\nPuede retirar: False"}]', '''''''
Programa: Verificaciones de un cliente
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Tarifa del parqueadero', 'dificil', '<p>Un parqueadero cobra <strong>3000</strong> pesos la primera hora y <strong>1500</strong> cada hora adicional. Se cobra por <strong>hora empezada</strong>.</p><p>Solicitar los minutos que estuvo el vehículo y mostrar:</p><pre><code>Horas cobradas: 5
Total a pagar: 9000</code></pre><p><em>Nota:</em> 260 minutos son 4 horas y 20 minutos, así que se cobran 5 horas. No use <code>if</code>: resuélvalo con aritmética.</p>', '<p>Truco clásico para redondear hacia arriba con enteros: <code>(minutos + 59) // 60</code>. Sumar 59 hace que cualquier sobrante empuje a la siguiente hora, y si es exacto no cambia nada.</p>', '<pre><code>''''''
Programa: Tarifa del parqueadero
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula el cobro de un parqueadero que cobra 3000 la primera
    hora y 1500 cada hora adicional, por hora empezada.
''''''

# Inicio
PRIMERA_HORA = 3000
HORA_ADICIONAL = 1500

minutos = int(input("Minutos estacionado: "))

# Sumar 59 antes de dividir redondea hacia arriba sin usar if
horas = (minutos + 59) // 60

total = PRIMERA_HORA + (horas - 1) * HORA_ADICIONAL

print("Horas cobradas:", horas)
print("Total a pagar:", total)
# Fin</code></pre><p>Por qué funciona el redondeo:</p><table><thead><tr><th>Minutos</th><th>+59</th><th>// 60</th></tr></thead><tbody><tr><td>240 (4 h exactas)</td><td>299</td><td>4</td></tr><tr><td>241</td><td>300</td><td>5</td></tr><tr><td>260</td><td>319</td><td>5</td></tr></tbody></table><p>Los nombres en MAYÚSCULAS son la convención de Python para valores que no cambian durante el programa. Si mañana suben la tarifa, se toca una línea.</p>', '[{"stdin":"260\n","expected_output":"Minutos estacionado: Horas cobradas: 5\nTotal a pagar: 9000"},{"stdin":"60\n","expected_output":"Minutos estacionado: Horas cobradas: 1\nTotal a pagar: 3000"}]', '''''''
Programa: Tarifa del parqueadero
Autor:
Fecha:
Descripcion:
''''''

# Inicio
PRIMERA_HORA = 3000
HORA_ADICIONAL = 1500

# Fin
', 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la diferencia entre / y // ?', NULL, '{"options":[{"id":"a","text":"/ siempre da decimal; // da solo la parte entera"},{"id":"b","text":"Son lo mismo, // es más rápido"},{"id":"c","text":"// divide y / saca el resto"},{"id":"d","text":"// solo sirve con números negativos"}]}', '{"option_id":"a"}', '10 / 2 da 5.0 (float) y 10 // 3 da 3. Para el resto está el %.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cómo se pregunta si un número es par?', NULL, '{"options":[{"id":"a","text":"numero % 2 == 0"},{"id":"b","text":"numero / 2 == 0"},{"id":"c","text":"numero // 2 == 0"},{"id":"d","text":"numero == par"}]}', '{"option_id":"a"}', 'Un número es par cuando al dividirlo entre 2 no sobra nada, o sea cuando el resto es 0.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué diferencia hay entre = y == ?', NULL, '{"options":[{"id":"a","text":"= guarda un valor; == pregunta si dos cosas son iguales"},{"id":"b","text":"Son equivalentes"},{"id":"c","text":"= compara y == asigna"},{"id":"d","text":"== solo sirve con textos"}]}', '{"option_id":"a"}', 'Un signo igual guarda, dos preguntan. Usar = dentro de un if da SyntaxError.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuándo es verdadero A and B?', NULL, '{"options":[{"id":"a","text":"Solo cuando A y B son verdaderos los dos"},{"id":"b","text":"Cuando al menos uno es verdadero"},{"id":"c","text":"Cuando los dos son falsos"},{"id":"d","text":"Siempre que A sea verdadero"}]}', '{"option_id":"a"}', 'and es exigente: si una parte falla, todo falla. El conforme es or.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué if nota == 3 or 4: está mal?', NULL, '{"options":[{"id":"a","text":"Porque el 4 solo se evalúa como \"distinto de cero\", así que la condición siempre es verdadera"},{"id":"b","text":"Porque or no se puede usar con números"},{"id":"c","text":"Porque falta un paréntesis"},{"id":"d","text":"Porque nota debería ir después del or"}]}', '{"option_id":"a"}', 'Cada lado de un or tiene que ser una comparación completa: nota == 3 or nota == 4.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print(7 // 2, 7 % 2, 7 / 2)', '{"options":[{"id":"a","text":"3 1 3.5"},{"id":"b","text":"3.5 1 3"},{"id":"c","text":"3 3 3"},{"id":"d","text":"3.5 3.5 3.5"}]}', '{"option_id":"a"}', '// da cuántas veces cabe (3), % lo que sobra (1) y / el resultado exacto (3.5).', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print(2 + 3 * 4)', '{"options":[{"id":"a","text":"14"},{"id":"b","text":"20"},{"id":"c","text":"24"},{"id":"d","text":"9"}]}', '{"option_id":"a"}', 'La multiplicación va antes que la suma: 3*4 = 12, y 2 + 12 = 14.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'nota1 = 4.0
nota2 = 3.0
print(nota1 + nota2 / 2)', '{"options":[{"id":"a","text":"5.5"},{"id":"b","text":"3.5"},{"id":"c","text":"7.0"},{"id":"d","text":"3.0"}]}', '{"option_id":"a"}', 'Sin paréntesis solo se divide nota2: 4.0 + 1.5 = 5.5. El promedio correcto sería (nota1 + nota2) / 2.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print(10 / 2)', '{"options":[{"id":"a","text":"5.0"},{"id":"b","text":"5"},{"id":"c","text":"5.5"},{"id":"d","text":"2"}]}', '{"option_id":"a"}', 'El operador / siempre entrega float, aunque la división sea exacta.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'edad = 20
tiene_cedula = False
print(edad >= 18 and tiene_cedula)', '{"options":[{"id":"a","text":"False"},{"id":"b","text":"True"},{"id":"c","text":"20"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'La primera parte es True pero la segunda es False, y con and basta con que una falle.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'minutos = 260
print((minutos + 59) // 60)', '{"options":[{"id":"a","text":"5"},{"id":"b","text":"4"},{"id":"c","text":"4.33"},{"id":"d","text":"319"}]}', '{"option_id":"a"}', 'Sumar 59 antes de la división entera redondea hacia arriba: es el truco de la hora empezada.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'nota = 3.8
print(3.0 <= nota <= 5.0)', '{"options":[{"id":"a","text":"True"},{"id":"b","text":"False"},{"id":"c","text":"3.8"},{"id":"d","text":"SyntaxError"}]}', '{"option_id":"a"}', 'Python permite encadenar comparaciones igual que en matemáticas: pregunta si nota está dentro del rango.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe mostrar el promedio de dos notas. ¿En qué línea está el error?', NULL, '{"lines":["nota1 = 4.0","nota2 = 3.0","promedio = nota1 + nota2 / 2","print(promedio)"]}', '{"line_number":3}', 'Faltan los paréntesis: debía ser (nota1 + nota2) / 2. Corre sin error pero da un resultado equivocado.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["edad = int(input(\"Edad: \"))","es_mayor = edad => 18","print(es_mayor)"]}', '{"line_number":2}', 'El operador se escribe >=, no =>. El signo de comparación va primero.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que convierte minutos a horas y minutos', NULL, '{"lines":[{"id":"l1","text":"total_minutos = int(input(\"Minutos: \"))","indent":0},{"id":"l2","text":"horas = total_minutos // 60","indent":0},{"id":"l3","text":"minutos = total_minutos % 60","indent":0},{"id":"l4","text":"print(horas, \"horas y\", minutos, \"minutos\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', '// y % trabajan sobre el mismo dato de entrada, así que ambos van después de pedirlo y antes de mostrar.', 1, 'seed'
    FROM chapters WHERE number = 4 AND track = 'basico';

-- ── Capítulo 5: Strings a fondo (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 5, 'Strings a fondo', '📝', 'Indexación, slicing, métodos y f-strings.', '<p class="jc-gancho">El extracto bancario dice <code>ana gomez</code> y tiene que salir <code>Ana Gomez</code>. El precio es <code>1250000</code> y debe verse <code>$ 1,250,000</code>. Nada de eso es cuenta: es manejo de texto, y en programación se hace todo el día.</p>

<h2>Un string es una fila de casillas</h2>

<p>Cada carácter tiene una posición, y se cuenta <strong>desde cero</strong>.</p>

<pre><code>ciudad = "Cartagena"</code></pre>

<table>
  <thead>
    <tr><th>Carácter</th><td>C</td><td>a</td><td>r</td><td>t</td><td>a</td><td>g</td><td>e</td><td>n</td><td>a</td></tr>
  </thead>
  <tbody>
    <tr><th>Posición</th><td>0</td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td></tr>
    <tr><th>Desde atrás</th><td>-9</td><td>-8</td><td>-7</td><td>-6</td><td>-5</td><td>-4</td><td>-3</td><td>-2</td><td>-1</td></tr>
  </tbody>
</table>

<pre><code>print(ciudad[0])     # C   la primera
print(ciudad[3])     # t
print(ciudad[-1])    # a   la última, sin saber cuánto mide
print(len(ciudad))   # 9   cuántos caracteres tiene</code></pre>

<p>Ese <code>[-1]</code> es un regalo de Python: la última casilla, sin tener que calcular <code>len(ciudad) - 1</code>.</p>

<h3>Rebanadas (<em>slicing</em>)</h3>

<p>Con dos puntos se pide un pedazo: <code>texto[desde:hasta]</code>. El <code>desde</code> entra, el <code>hasta</code> <strong>no</strong>.</p>

<pre><code>print(ciudad[0:5])   # Carta   posiciones 0,1,2,3,4
print(ciudad[5:])    # gena    desde la 5 hasta el final
print(ciudad[:5])    # Carta   desde el principio hasta la 5
print(ciudad[-3:])   # ena     las últimas tres</code></pre>

<p>Lo de que el final no entre confunde al principio, pero tiene una ventaja: <code>texto[0:5]</code> siempre entrega exactamente 5 caracteres.</p>

<h2>Los métodos que vas a usar siempre</h2>

<p>Un <strong>método</strong> es una función que va pegada al dato con un punto. Todos estos devuelven un texto <em>nuevo</em>: el original nunca cambia.</p>

<pre><code>nombre = "  ana gomez  "

print(nombre.strip())       # "ana gomez"  quita espacios de los lados
print(nombre.upper())       # "  ANA GOMEZ  "
print(nombre.lower())       # "  ana gomez  "
print(nombre.title())       # "  Ana Gomez  "  primera letra de cada palabra
print(nombre.strip().title())  # "Ana Gomez"  encadenados</code></pre>

<p>Los de buscar y reemplazar:</p>

<pre><code>correo = "ana@juancode.co"

print(correo.replace("@", " arroba "))   # ana arroba juancode.co
print("@" in correo)                     # True   ¿lo contiene?
print(correo.startswith("ana"))          # True
print(correo.endswith(".co"))            # True
print(correo.find("@"))                  # 3      en qué posición está</code></pre>

<p>Y el que parte un texto en pedazos:</p>

<pre><code>fecha = "14/03/2026"
partes = fecha.split("/")     # ["14", "03", "2026"]
print(partes[2])              # 2026</code></pre>

<p><strong>Ojo con esto:</strong> como los métodos devuelven un texto nuevo, esto no hace nada:</p>

<pre><code>nombre = "  ana  "
nombre.strip()        # ❌ calcula el resultado y lo bota
print(nombre)         # "  ana  " — igualito

nombre = nombre.strip()   # ✅ hay que guardarlo</code></pre>

<h2>f-strings: la forma moderna de armar texto</h2>

<p>Hasta aquí veníamos usando las comas de <code>print()</code>. Funcionan, pero se quedan cortas apenas quieres controlar el formato. La solución son las <strong>f-strings</strong>: una <code>f</code> antes de las comillas y variables entre llaves.</p>

<pre><code>nombre = "Ana"
saldo = 1250000

print(f"{nombre} tiene {saldo} pesos")     # Ana tiene 1250000 pesos</code></pre>

<p>Adentro de las llaves cabe cualquier expresión:</p>

<pre><code>print(f"El doble es {saldo * 2}")
print(f"Inicial: {nombre[0]}")
print(f"En mayúsculas: {nombre.upper()}")</code></pre>

<h3>Formato: donde las f-strings se ganan el sueldo</h3>

<p>Después de la variable van dos puntos y el formato.</p>

<table>
  <thead>
    <tr><th>Escribes</th><th>Sale</th><th>Para qué</th></tr>
  </thead>
  <tbody>
    <tr><td><code>f"{4.5678:.2f}"</code></td><td><code>4.57</code></td><td>Dos decimales, redondeando</td></tr>
    <tr><td><code>f"{1250000:,}"</code></td><td><code>1,250,000</code></td><td>Separador de miles</td></tr>
    <tr><td><code>f"{0.15:.0%}"</code></td><td><code>15%</code></td><td>Porcentaje</td></tr>
    <tr><td><code>f"{''Pan'':&lt;10}"</code></td><td><code>Pan_______</code></td><td>Alinear a la izquierda en 10 espacios</td></tr>
    <tr><td><code>f"{600:&gt;10}"</code></td><td><code>_______600</code></td><td>Alinear a la derecha</td></tr>
  </tbody>
</table>

<p>Con eso, el volante de la panadería del capítulo 1 —el que tocó alinear contando espacios a mano— sale así:</p>

<pre><code>producto = "Bunuelo"
precio = 1500

print(f"{producto:&lt;15}{precio:&gt;8,}")    # Bunuelo           1,500</code></pre>

<p>De aquí en adelante, el libro usa f-strings. Las comas de <code>print()</code> siguen siendo válidas para cosas rápidas.</p>

<h2>La película de una limpieza de datos</h2>

<p>Llega el nombre <code>"  ANA gomez  "</code> desde un formulario y hay que dejarlo presentable:</p>

<pre><code>crudo = "  ANA gomez  "
paso1 = crudo.strip()        # línea 1
paso2 = paso1.lower()        # línea 2
limpio = paso2.title()       # línea 3
print(f"[{limpio}]")</code></pre>

<table>
  <thead>
    <tr><th>Después de…</th><th>Valor</th><th>Qué se arregló</th></tr>
  </thead>
  <tbody>
    <tr><td>línea 1</td><td><code>"ANA gomez"</code></td><td>Se fueron los espacios de los lados</td></tr>
    <tr><td>línea 2</td><td><code>"ana gomez"</code></td><td>Todo a minúsculas, para partir parejo</td></tr>
    <tr><td>línea 3</td><td><code>"Ana Gomez"</code></td><td>Primera letra de cada palabra en mayúscula</td></tr>
  </tbody>
</table>

<p>El <code>lower()</code> del paso 2 parece innecesario, pero sin él <code>title()</code> recibiría <code>"ANA gomez"</code> y dejaría <code>"Ana Gomez"</code> igual… en este caso. Con <code>"aNa GOMEZ"</code> el resultado sí cambiaría. Normalizar antes de formatear es la costumbre segura.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Creer que el método cambia la variable</h3>
<pre><code>nombre.upper()            # ❌ no hace nada visible
nombre = nombre.upper()   # ✅</code></pre>

<h3>2. Pasarse de posición</h3>
<pre><code>ciudad = "Cartagena"    # 9 letras: posiciones 0 a 8
print(ciudad[9])        # IndexError: string index out of range</code></pre>
<p>Con <code>len()</code> da 9, pero la última posición es 8. Por eso <code>[-1]</code> es más seguro.</p>

<h3>3. Olvidar la <code>f</code></h3>
<pre><code>print("{nombre} tiene {saldo}")     # imprime las llaves tal cual
print(f"{nombre} tiene {saldo}")    # ✅</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Todo texto que venga de afuera se limpia primero: <code>.strip()</code>.</li>
  <li>Si vas a comparar, normaliza a minúsculas: <code>.lower()</code>.</li>
  <li>Para mostrar, arma con f-string y formatea ahí mismo.</li>
  <li>Recuerda guardar: los métodos devuelven texto nuevo, no cambian el original.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>texto[0]</code> · <code>texto[-1]</code></td><td>Primer carácter · último</td></tr>
    <tr><td><code>texto[2:5]</code></td><td>De la 2 a la 4 (la 5 no entra)</td></tr>
    <tr><td><code>len(texto)</code></td><td>Cuántos caracteres tiene</td></tr>
    <tr><td><code>.strip()</code></td><td>Quita espacios de los lados</td></tr>
    <tr><td><code>.upper()</code> · <code>.lower()</code> · <code>.title()</code></td><td>MAYÚSCULAS · minúsculas · Cada Palabra</td></tr>
    <tr><td><code>.replace("a", "b")</code></td><td>Cambia todas las apariciones</td></tr>
    <tr><td><code>.split("/")</code></td><td>Parte el texto en una lista</td></tr>
    <tr><td><code>"@" in correo</code></td><td><code>True</code> si lo contiene</td></tr>
    <tr><td><code>f"{x:.2f}"</code> · <code>f"{x:,}"</code></td><td>Dos decimales · separador de miles</td></tr>
  </tbody>
</table>

<blockquote>Los métodos de texto no cambian la variable: devuelven una copia arreglada. Si no la guardas, se pierde.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 1
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 5 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Limpiar el nombre del formulario', 'facil', '<p>Solicitar el nombre completo de una persona tal como llega de un formulario (puede traer espacios de sobra y mayúsculas desordenadas). Mostrarlo limpio y con cada palabra en mayúscula inicial, entre corchetes:</p><pre><code>[Ana Gomez]</code></pre><p><em>Nota:</em> use f-string para la salida.</p>', '<p>Tres métodos encadenados: <code>.strip()</code> para los espacios, <code>.lower()</code> para partir parejo y <code>.title()</code> para las iniciales. Recuerde guardar el resultado.</p>', '<pre><code>''''''
Programa: Limpieza de nombres
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Toma un nombre como llega de un formulario y lo deja
    presentable: sin espacios sobrantes y con iniciales en mayuscula.
''''''

# Inicio
crudo = input("Nombre completo: ")

# Se normaliza a minusculas antes de formatear para que
# entradas como "aNa GOMEZ" queden igual de bien
limpio = crudo.strip().lower().title()

print(f"[{limpio}]")
# Fin</code></pre><p>Los tres métodos se encadenan de izquierda a derecha: el resultado de <code>.strip()</code> recibe <code>.lower()</code>, y el de ese recibe <code>.title()</code>. Los corchetes de la salida sirven para <em>ver</em> que los espacios se fueron.</p>', '[{"stdin":"  ANA gomez  \n","expected_output":"Nombre completo: [Ana Gomez]"},{"stdin":"juan CARLOS perez\n","expected_output":"Nombre completo: [Juan Carlos Perez]"}]', '''''''
Programa: Limpieza de nombres
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Datos de la cédula', 'facil', '<p>Solicitar un número de cédula. Mostrar cuántos dígitos tiene, su primer dígito y sus últimos cuatro:</p><pre><code>Digitos: 10
Primero: 1
Ultimos cuatro: 6789</code></pre><p><em>Nota:</em> trabaje la cédula como texto, no como número.</p>', '<p>Como es texto, sirve <code>len()</code>, <code>[0]</code> y la rebanada <code>[-4:]</code>, que toma las últimas cuatro casillas sin importar cuánto mida.</p>', '<pre><code>''''''
Programa: Datos de la cedula
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra la cantidad de digitos de una cedula, su primer
    digito y sus ultimos cuatro.
''''''

# Inicio
cedula = input("Cedula: ").strip()

print(f"Digitos: {len(cedula)}")
print(f"Primero: {cedula[0]}")
print(f"Ultimos cuatro: {cedula[-4:]}")
# Fin</code></pre><p>Por qué texto y no número: a un número no se le puede pedir <code>[0]</code>, y además un cero al principio se perdería. Las cédulas, los teléfonos y los códigos de barras son <strong>texto</strong> aunque estén hechos de dígitos.</p><p><code>[-4:]</code> se lee "desde la cuarta contando por detrás, hasta el final".</p>', '[{"stdin":"1023456789\n","expected_output":"Cedula: Digitos: 10\nPrimero: 1\nUltimos cuatro: 6789"}]', '''''''
Programa: Datos de la cedula
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Factura formateada', 'medio', '<p>Solicitar el nombre de un producto, su precio unitario y la cantidad. Mostrar una línea de factura con el nombre alineado a la izquierda en 15 espacios y el total alineado a la derecha en 12, con separador de miles:</p><pre><code>Producto       Total
Bunuelo           15,000</code></pre><p><em>Nota:</em> use f-strings con especificadores de formato.</p>', '<p><code>f"{texto:&lt;15}"</code> alinea a la izquierda rellenando hasta 15 caracteres. <code>f"{numero:&gt;12,}"</code> alinea a la derecha y mete el separador de miles.</p>', '<pre><code>''''''
Programa: Linea de factura
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra una linea de factura con el nombre del producto
    alineado a la izquierda y el total a la derecha.
''''''

# Inicio
producto = input("Producto: ").strip().title()
precio = int(input("Precio unitario: "))
cantidad = int(input("Cantidad: "))

total = precio * cantidad

print(f"{''Producto'':&lt;15}{''Total'':&gt;12}")
print(f"{producto:&lt;15}{total:&gt;12,}")
# Fin</code></pre><p>Lo que hace cada especificador:</p><ul><li><code>:&lt;15</code> — alinea a la izquierda y rellena con espacios hasta ocupar 15 caracteres.</li><li><code>:&gt;12,</code> — alinea a la derecha en 12 caracteres <strong>y</strong> agrega el separador de miles.</li></ul><p>Compárelo con el volante del capítulo 1, donde tocó contar espacios a mano dentro de las comillas. Esa es la diferencia que hacen las f-strings.</p>', NULL, '''''''
Programa: Linea de factura
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Validador de correo', 'dificil', '<p>Solicitar un correo electrónico y mostrar un informe:</p><pre><code>Correo: ana@juancode.co
Usuario: ana
Dominio: juancode.co
Tiene arroba: True
Es .co: True</code></pre><p><em>Nota:</em> el correo debe quedar sin espacios y en minúsculas. Para separar usuario y dominio use <code>split("@")</code>. No use <code>if</code>.</p>', '<p><code>"ana@juancode.co".split("@")</code> entrega una lista de dos textos: el de la posición 0 es el usuario y el de la 1 el dominio. Para las verificaciones sirven <code>in</code> y <code>.endswith()</code>.</p>', '<pre><code>''''''
Programa: Validador de correo
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Separa un correo en usuario y dominio y verifica que tenga
    arroba y que el dominio termine en .co
''''''

# Inicio
crudo = input("Correo: ")

# Los correos no distinguen mayusculas: se normaliza antes de nada
correo = crudo.strip().lower()

partes = correo.split("@")
usuario = partes[0]
dominio = partes[-1]   # [-1] evita romperse si no hubiera arroba

print(f"Correo: {correo}")
print(f"Usuario: {usuario}")
print(f"Dominio: {dominio}")
print(f"Tiene arroba: {''@'' in correo}")
print(f"Es .co: {correo.endswith(''.co'')}")
# Fin</code></pre><p>Dos detalles de oficio:</p><ul><li><code>partes[-1]</code> en vez de <code>partes[1]</code>: si el usuario escribe un correo sin arroba, <code>split</code> devuelve una lista de un solo elemento y <code>[1]</code> daría <code>IndexError</code>. Con <code>[-1]</code> el programa no se cae.</li><li>Adentro de una f-string con comillas dobles hay que usar comillas sencillas: <code>{''@'' in correo}</code>.</li></ul>', '[{"stdin":"  ANA@JuanCode.CO \n","expected_output":"Correo: Correo: ana@juancode.co\nUsuario: ana\nDominio: juancode.co\nTiene arroba: True\nEs .co: True"}]', '''''''
Programa: Validador de correo
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Desde qué número se cuentan las posiciones de un string?', NULL, '{"options":[{"id":"a","text":"Desde 0"},{"id":"b","text":"Desde 1"},{"id":"c","text":"Desde -1"},{"id":"d","text":"Depende del largo del texto"}]}', '{"option_id":"a"}', 'La primera casilla es la 0, así que en un texto de 9 letras la última es la 8.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la forma más segura de obtener el último carácter de un texto?', NULL, '{"options":[{"id":"a","text":"texto[-1]"},{"id":"b","text":"texto[len(texto)]"},{"id":"c","text":"texto[1]"},{"id":"d","text":"texto.last()"}]}', '{"option_id":"a"}', 'texto[len(texto)] se pasa por uno y da IndexError. Con [-1] no hay que calcular nada.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace nombre.upper() si no se guarda el resultado?', NULL, '{"options":[{"id":"a","text":"Nada visible: devuelve un texto nuevo y se pierde"},{"id":"b","text":"Cambia la variable nombre"},{"id":"c","text":"Lanza un error"},{"id":"d","text":"Imprime el texto en mayúsculas"}]}', '{"option_id":"a"}', 'Los métodos de texto no modifican el original: devuelven una copia. Hay que hacer nombre = nombre.upper().', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Para qué sirve la f antes de las comillas en f"Hola {nombre}"?', NULL, '{"options":[{"id":"a","text":"Para que Python reemplace lo que está entre llaves por su valor"},{"id":"b","text":"Para indicar que el texto está en formato UTF-8"},{"id":"c","text":"Para que el texto salga en negrilla"},{"id":"d","text":"Para convertir el texto en float"}]}', '{"option_id":"a"}', 'Sin la f, las llaves se imprimen tal cual. Con la f, adentro cabe cualquier expresión.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué una cédula se guarda como texto y no como número?', NULL, '{"options":[{"id":"a","text":"Porque no se hacen cuentas con ella y un cero inicial se perdería"},{"id":"b","text":"Porque los números enteros no aceptan más de 8 dígitos"},{"id":"c","text":"Porque input() no puede convertirla"},{"id":"d","text":"Porque ocupa menos memoria"}]}', '{"option_id":"a"}', 'Cédulas, teléfonos y códigos son identificadores, no cantidades: se manejan como texto.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'ciudad = "Cartagena"
print(ciudad[0], ciudad[-1])', '{"options":[{"id":"a","text":"C a"},{"id":"b","text":"C n"},{"id":"c","text":"Ca"},{"id":"d","text":"IndexError"}]}', '{"option_id":"a"}', '[0] es la primera letra y [-1] la última, que en Cartagena es otra a.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'ciudad = "Cartagena"
print(ciudad[0:5])', '{"options":[{"id":"a","text":"Carta"},{"id":"b","text":"Cartag"},{"id":"c","text":"artag"},{"id":"d","text":"Carta g"}]}', '{"option_id":"a"}', 'En una rebanada el inicio entra y el final no: se toman las posiciones 0, 1, 2, 3 y 4.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'nombre = "  ana  "
nombre.strip()
print(f"[{nombre}]")', '{"options":[{"id":"a","text":"[  ana  ]"},{"id":"b","text":"[ana]"},{"id":"c","text":"[]"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'El strip() calculó el texto limpio y lo botó porque nadie lo guardó. La variable sigue igual.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print(f"{4.5678:.2f}")', '{"options":[{"id":"a","text":"4.57"},{"id":"b","text":"4.56"},{"id":"c","text":"4.5678"},{"id":"d","text":"4.6"}]}', '{"option_id":"a"}', '.2f deja dos decimales y redondea: 4.5678 pasa a 4.57.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'saldo = 1250000
print(f"{saldo:,}")', '{"options":[{"id":"a","text":"1,250,000"},{"id":"b","text":"1.250.000"},{"id":"c","text":"1250000"},{"id":"d","text":"1250,000"}]}', '{"option_id":"a"}', 'La coma como especificador mete el separador de miles al estilo inglés.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'fecha = "14/03/2026"
partes = fecha.split("/")
print(partes[2])', '{"options":[{"id":"a","text":"2026"},{"id":"b","text":"03"},{"id":"c","text":"14"},{"id":"d","text":"/"}]}', '{"option_id":"a"}', 'split() parte el texto donde encuentra el separador y devuelve una lista: ["14", "03", "2026"].', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'print("  ANA gomez  ".strip().lower().title())', '{"options":[{"id":"a","text":"Ana Gomez"},{"id":"b","text":"  Ana Gomez  "},{"id":"c","text":"ANA GOMEZ"},{"id":"d","text":"ana gomez"}]}', '{"option_id":"a"}', 'Los métodos se encadenan de izquierda a derecha: primero se quitan espacios, luego se baja todo a minúsculas y al final se ponen las iniciales.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe mostrar el nombre en mayúsculas. ¿En qué línea está el error?', NULL, '{"lines":["nombre = input(\"Nombre: \")","nombre.upper()","print(nombre)"]}', '{"line_number":2}', 'Falta guardar: nombre = nombre.upper(). Así como está, el resultado se calcula y se bota.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["nombre = \"Ana\"","saldo = 1250000","print(\"{nombre} tiene {saldo}\")"]}', '{"line_number":3}', 'Falta la f antes de las comillas: sin ella las llaves se imprimen tal cual.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que separa un correo en usuario y dominio', NULL, '{"lines":[{"id":"l1","text":"crudo = input(\"Correo: \")","indent":0},{"id":"l2","text":"correo = crudo.strip().lower()","indent":0},{"id":"l3","text":"partes = correo.split(\"@\")","indent":0},{"id":"l4","text":"print(f\"Usuario: {partes[0]}\")","indent":0},{"id":"l5","text":"print(f\"Dominio: {partes[-1]}\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Primero se pide, después se normaliza, luego se parte y al final se muestran los pedazos.', 1, 'seed'
    FROM chapters WHERE number = 5 AND track = 'basico';

-- ── Capítulo 6: Condicionales (if / elif / else) (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 6, 'Condicionales (if / elif / else)', '🔀', 'Que el programa tome decisiones.', '<p class="jc-gancho">El cajero automático no le entrega plata a todo el mundo. Antes pregunta: ¿el saldo alcanza? ¿el monto es múltiplo de 10000? ¿la tarjeta está activa? Cada una de esas preguntas es un <code>if</code>, y hasta ahora tus programas no sabían hacer ninguna.</p>

<h2>El torniquete</h2>

<p>Un <code>if</code> es un torniquete: solo deja pasar si la condición es verdadera.</p>

<pre><code>edad = 20

if edad &gt;= 18:
    print("Puede entrar")</code></pre>

<p>Tres cosas que hay que mirar con lupa:</p>

<ol>
  <li>La condición va después del <code>if</code> y es una pregunta que da <code>True</code> o <code>False</code>.</li>
  <li>La línea termina en <strong>dos puntos</strong>. Ese <code>:</code> significa "aquí abre un bloque".</li>
  <li>Lo que va adentro va <strong>indentado</strong>: cuatro espacios. La indentación no es estética: es lo que le dice a Python qué está adentro y qué está afuera.</li>
</ol>

<pre><code>if edad &gt;= 18:
    print("Puede entrar")      # adentro: solo si es mayor
print("Siguiente en la fila")  # afuera: siempre</code></pre>

<h2><code>else</code>: el otro camino</h2>

<pre><code>saldo = 30000
retiro = 50000

if retiro &lt;= saldo:
    saldo = saldo - retiro
    print("Retiro aprobado")
else:
    print("Saldo insuficiente")

print("Saldo actual:", saldo)</code></pre>

<p><code>else</code> no lleva condición: es "en cualquier otro caso". Siempre se ejecuta exactamente uno de los dos bloques, nunca los dos y nunca ninguno.</p>

<h2><code>elif</code>: varios caminos</h2>

<p>Para más de dos casos no se encadenan <code>if</code> sueltos: se usa <code>elif</code> (contracción de <em>else if</em>).</p>

<pre><code>nota = 3.8

if nota &gt;= 4.5:
    print("Excelente")
elif nota &gt;= 4.0:
    print("Muy bien")
elif nota &gt;= 3.0:
    print("Aprobado")
else:
    print("Reprobado")</code></pre>

<p>Python revisa las condiciones <strong>de arriba hacia abajo y se detiene en la primera verdadera</strong>. Por eso el orden importa muchísimo. Si se escribiera al revés:</p>

<pre><code># ❌ MAL: el orden arruina la lógica
if nota &gt;= 3.0:
    print("Aprobado")
elif nota &gt;= 4.5:
    print("Excelente")     # nunca se alcanza</code></pre>

<p>Una nota de 4.8 entraría por la primera y diría "Aprobado". La segunda rama es inalcanzable. <strong>Regla: de lo más exigente a lo menos exigente.</strong></p>

<h2>La película de una decisión</h2>

<p>Sigamos <code>nota = 3.8</code> por el <code>elif</code> del ejemplo bueno:</p>

<table>
  <thead>
    <tr><th>Paso</th><th>Pregunta</th><th>Respuesta</th><th>Qué hace</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td><code>3.8 &gt;= 4.5</code></td><td>False</td><td>Sigue al siguiente <code>elif</code></td></tr>
    <tr><td>2</td><td><code>3.8 &gt;= 4.0</code></td><td>False</td><td>Sigue al siguiente</td></tr>
    <tr><td>3</td><td><code>3.8 &gt;= 3.0</code></td><td><strong>True</strong></td><td>Imprime "Aprobado" y <strong>sale de toda la cadena</strong></td></tr>
    <tr><td>4</td><td>—</td><td>—</td><td>El <code>else</code> ni se mira</td></tr>
  </tbody>
</table>

<p>Ese "sale de toda la cadena" es la diferencia entre <code>elif</code> y varios <code>if</code> seguidos. Con <code>if</code> sueltos, Python evalúa <em>todas</em> las condiciones.</p>

<h2>Condiciones compuestas</h2>

<p>Con <code>and</code>, <code>or</code> y <code>not</code> del capítulo 4:</p>

<pre><code>edad = 20
tiene_cedula = True
saldo = 80000

if edad &gt;= 18 and tiene_cedula:
    print("Puede abrir cuenta")

if saldo &lt; 50000 or not tiene_cedula:
    print("Necesita ir a la sucursal")</code></pre>

<p>Y si una condición se pone larga, guárdala en una variable con nombre. El programa se lee solo:</p>

<pre><code>es_cliente_nuevo = edad &gt;= 18 and tiene_cedula and saldo &gt;= 50000

if es_cliente_nuevo:
    print("Bienvenido al banco")</code></pre>

<h2><code>if</code> anidados: cuando una pregunta depende de otra</h2>

<pre><code>saldo = 100000
monto = 50000

if monto &lt;= saldo:
    if monto % 10000 == 0:
        print("Retiro aprobado")
    else:
        print("El cajero solo entrega múltiplos de 10000")
else:
    print("Saldo insuficiente")</code></pre>

<p>La segunda pregunta solo tiene sentido si la primera pasó, por eso va adentro. Fíjate en la indentación: el <code>else</code> de adentro está alineado con el <code>if</code> de adentro, y el de afuera con el de afuera. Python usa esa alineación para saber a quién pertenece cada <code>else</code>.</p>

<p>Cuidado con pasarse: más de dos o tres niveles anidados es señal de que el código se puede simplificar, casi siempre uniendo condiciones con <code>and</code>.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Olvidar los dos puntos</h3>
<pre><code>if edad &gt;= 18       # SyntaxError: expected '':''
    print("Pasa")</code></pre>

<h3>2. Mezclar indentaciones</h3>
<pre><code>if edad &gt;= 18:
    print("Pasa")
      print("Otra cosa")     # IndentationError</code></pre>
<p>Todas las líneas de un mismo bloque llevan exactamente la misma sangría. Cuatro espacios, siempre cuatro.</p>

<h3>3. Usar <code>=</code> en vez de <code>==</code></h3>
<pre><code>if nota = 5.0:      # SyntaxError
if nota == 5.0:     # ✅</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Escribe la pregunta como comparación: algo que dé <code>True</code> o <code>False</code>.</li>
  <li>Dos puntos, Enter, y todo lo de adentro con cuatro espacios.</li>
  <li>Si hay varios casos, ordénalos <strong>del más exigente al menos exigente</strong> con <code>elif</code>.</li>
  <li>Cierra con <code>else</code> para el caso que sobra: así ninguna entrada se queda sin respuesta.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>if cond:</code></td><td>Ejecuta el bloque solo si <code>cond</code> es verdadera</td></tr>
    <tr><td><code>elif cond2:</code></td><td>Se revisa solo si las anteriores fueron falsas</td></tr>
    <tr><td><code>else:</code></td><td>En cualquier otro caso</td></tr>
    <tr><td>Cuatro espacios</td><td>Marcan qué está adentro del bloque</td></tr>
    <tr><td><code>a and b</code> · <code>a or b</code></td><td>Unir condiciones</td></tr>
    <tr><td><code>n % 2 == 0</code></td><td>¿Es par?</td></tr>
  </tbody>
</table>

<blockquote>En un <code>elif</code>, Python se queda con la primera condición verdadera y no mira las demás. Por eso las condiciones van de la más exigente a la menos exigente.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 2
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 6 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, '¿Par o impar?', 'facil', '<p>Solicitar un número entero y mostrar si es par o impar:</p><pre><code>El 7 es impar</code></pre><p><em>Nota:</em> use el operador módulo.</p>', '<p>Un número es par cuando <code>numero % 2 == 0</code>. Con eso arma el <code>if</code> y el <code>else</code>.</p>', '<pre><code>''''''
Programa: Par o impar
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide un numero entero e indica si es par o impar.
''''''

# Inicio
numero = int(input("Numero: "))

# Un numero es par si al dividirlo entre 2 no sobra nada
if numero % 2 == 0:
    print(f"El {numero} es par")
else:
    print(f"El {numero} es impar")
# Fin</code></pre><p>Solo hay dos casos posibles y son excluyentes, así que <code>if / else</code> basta: siempre entra por exactamente uno.</p>', '[{"stdin":"7\n","expected_output":"Numero: El 7 es impar"},{"stdin":"10\n","expected_output":"Numero: El 10 es par"}]', '''''''
Programa: Par o impar
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Escala de notas', 'facil', '<p>Solicitar una nota entre 0.0 y 5.0 y mostrar su concepto según la escala:</p><table><thead><tr><th>Nota</th><th>Concepto</th></tr></thead><tbody><tr><td>4.5 a 5.0</td><td>Excelente</td></tr><tr><td>4.0 a 4.4</td><td>Muy bien</td></tr><tr><td>3.0 a 3.9</td><td>Aprobado</td></tr><tr><td>menor a 3.0</td><td>Reprobado</td></tr></tbody></table><pre><code>Nota 3.8: Aprobado</code></pre>', '<p>Use <code>elif</code> y ordene las condiciones de la más exigente a la menos exigente. Si empieza por <code>nota >= 3.0</code>, las demás nunca se alcanzan.</p>', '<pre><code>''''''
Programa: Escala de notas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Convierte una nota de 0.0 a 5.0 en su concepto cualitativo.
''''''

# Inicio
nota = float(input("Nota: "))

# Las condiciones van de la mas exigente a la menos exigente:
# Python se queda con la primera verdadera
if nota >= 4.5:
    concepto = "Excelente"
elif nota >= 4.0:
    concepto = "Muy bien"
elif nota >= 3.0:
    concepto = "Aprobado"
else:
    concepto = "Reprobado"

print(f"Nota {nota}: {concepto}")
# Fin</code></pre><p>Un detalle de estilo que vale la pena copiar: en vez de poner un <code>print()</code> dentro de cada rama, cada rama solo <strong>guarda</strong> el concepto y el <code>print()</code> va una sola vez al final. Si mañana cambia el formato del mensaje, se toca una línea y no cuatro.</p>', '[{"stdin":"3.8\n","expected_output":"Nota: Nota 3.8: Aprobado"},{"stdin":"4.7\n","expected_output":"Nota: Nota 4.7: Excelente"},{"stdin":"2.5\n","expected_output":"Nota: Nota 2.5: Reprobado"}]', '''''''
Programa: Escala de notas
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Retiro en el cajero', 'medio', '<p>Un cajero tiene un saldo de <strong>100000</strong> pesos y solo entrega billetes múltiplos de <strong>10000</strong>.</p><p>Solicitar el monto a retirar y mostrar una de tres respuestas:</p><ul><li><code>Retiro aprobado. Nuevo saldo: 50000</code></li><li><code>El cajero solo entrega multiplos de 10000</code></li><li><code>Saldo insuficiente</code></li></ul><p><em>Nota:</em> primero se verifica el saldo y solo después el múltiplo.</p>', '<p>Necesita un <code>if</code> anidado: la pregunta del múltiplo solo tiene sentido si el saldo alcanzó. El <code>else</code> de adentro se alinea con el <code>if</code> de adentro.</p>', '<pre><code>''''''
Programa: Retiro en el cajero
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Valida un retiro contra el saldo disponible y contra la
    restriccion de billetes de 10000.
''''''

# Inicio
SALDO_INICIAL = 100000
BILLETE = 10000

saldo = SALDO_INICIAL
monto = int(input("Monto a retirar: "))

if monto <= saldo:
    # La pregunta del multiplo solo tiene sentido si el saldo alcanzo
    if monto % BILLETE == 0:
        saldo = saldo - monto
        print(f"Retiro aprobado. Nuevo saldo: {saldo}")
    else:
        print(f"El cajero solo entrega multiplos de {BILLETE}")
else:
    print("Saldo insuficiente")
# Fin</code></pre><p>Por qué anidado y no dos <code>if</code> sueltos: si el saldo no alcanza, no importa si el monto es múltiplo o no; esa pregunta ni se hace. Anidar refleja exactamente eso.</p><p>La indentación es lo que amarra cada <code>else</code> con su <code>if</code>: el de adentro lleva cuatro espacios y el de afuera ninguno.</p>', '[{"stdin":"50000\n","expected_output":"Monto a retirar: Retiro aprobado. Nuevo saldo: 50000"},{"stdin":"35000\n","expected_output":"Monto a retirar: El cajero solo entrega multiplos de 10000"},{"stdin":"200000\n","expected_output":"Monto a retirar: Saldo insuficiente"}]', '''''''
Programa: Retiro en el cajero
Autor:
Fecha:
Descripcion:
''''''

# Inicio
SALDO_INICIAL = 100000
BILLETE = 10000

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Tarifa de servicios públicos', 'dificil', '<p>Una empresa cobra la energía por rangos de consumo mensual:</p><table><thead><tr><th>Consumo (kWh)</th><th>Precio por kWh</th></tr></thead><tbody><tr><td>0 a 150</td><td>500</td></tr><tr><td>151 a 300</td><td>700</td></tr><tr><td>más de 300</td><td>900</td></tr></tbody></table><p>Además, si el estrato es 1, 2 o 3 se aplica un <strong>subsidio del 20%</strong> sobre el total.</p><p>Solicitar el consumo y el estrato. Mostrar:</p><pre><code>Consumo: 200 kWh
Tarifa: 700
Subtotal: 140000
Subsidio: 28000.0
Total a pagar: 112000.0</code></pre><p><em>Nota:</em> el precio se aplica a <strong>todo</strong> el consumo, no por tramos.</p>', '<p>Primero un <code>elif</code> para escoger la tarifa según el consumo, y después un <code>if</code> aparte para el subsidio. Guarde la tarifa en una variable: así el cálculo del subtotal se escribe una sola vez.</p>', '<pre><code>''''''
Programa: Tarifa de servicios publicos
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula la factura de energia segun el rango de consumo y
    aplica subsidio a los estratos 1, 2 y 3.
''''''

# Inicio
SUBSIDIO = 0.20

consumo = int(input("Consumo en kWh: "))
estrato = int(input("Estrato: "))

# Primero se decide la tarifa segun el rango
if consumo <= 150:
    tarifa = 500
elif consumo <= 300:
    tarifa = 700
else:
    tarifa = 900

subtotal = consumo * tarifa

# El subsidio es una decision aparte: depende del estrato, no del consumo
if estrato <= 3:
    subsidio = subtotal * SUBSIDIO
else:
    subsidio = 0

total = subtotal - subsidio

print(f"Consumo: {consumo} kWh")
print(f"Tarifa: {tarifa}")
print(f"Subtotal: {subtotal}")
print(f"Subsidio: {subsidio}")
print(f"Total a pagar: {total}")
# Fin</code></pre><p>Tres decisiones de diseño que valen puntos en un parcial:</p><ul><li><strong>Dos decisiones separadas.</strong> La tarifa depende del consumo; el subsidio, del estrato. Mezclarlas en un solo <code>if</code> gigante daría seis ramas en vez de cinco líneas.</li><li><strong>Las condiciones usan <code>&lt;=</code> en cascada.</strong> Como el <code>elif</code> solo se evalúa si el anterior falló, cuando se llega a <code>consumo &lt;= 300</code> ya se sabe que es mayor que 150. No hay que escribir <code>150 &lt; consumo &lt;= 300</code>.</li><li><strong>Cada rama guarda un valor, no imprime.</strong> Los <code>print()</code> van todos juntos al final.</li></ul>', '[{"stdin":"200\n2\n","expected_output":"Consumo en kWh: Estrato: Consumo: 200 kWh\nTarifa: 700\nSubtotal: 140000\nSubsidio: 28000.0\nTotal a pagar: 112000.0"},{"stdin":"100\n5\n","expected_output":"Consumo en kWh: Estrato: Consumo: 100 kWh\nTarifa: 500\nSubtotal: 50000\nSubsidio: 0\nTotal a pagar: 50000"}]', '''''''
Programa: Tarifa de servicios publicos
Autor:
Fecha:
Descripcion:
''''''

# Inicio
SUBSIDIO = 0.20

# Fin
', 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué le dice a Python que una línea está dentro de un if?', NULL, '{"options":[{"id":"a","text":"La indentación: cuatro espacios al principio"},{"id":"b","text":"Las llaves { }"},{"id":"c","text":"Un punto y coma al final"},{"id":"d","text":"La palabra end"}]}', '{"option_id":"a"}', 'En Python el bloque ES la indentación. Sin sangría, la línea queda fuera del if.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué falta al final de la línea del if?', NULL, '{"options":[{"id":"a","text":"Dos puntos"},{"id":"b","text":"Punto y coma"},{"id":"c","text":"Una coma"},{"id":"d","text":"Nada"}]}', '{"option_id":"a"}', 'Los dos puntos anuncian que abre un bloque. Sin ellos, SyntaxError.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En una cadena if / elif / elif / else, ¿cuántos bloques se ejecutan?', NULL, '{"options":[{"id":"a","text":"Exactamente uno: el primero cuya condición sea verdadera"},{"id":"b","text":"Todos los que tengan condición verdadera"},{"id":"c","text":"Siempre el else también"},{"id":"d","text":"Ninguno si la primera condición falla"}]}', '{"option_id":"a"}', 'Python se queda con la primera verdadera y sale de toda la cadena. Con if sueltos sí se evaluarían todas.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué las condiciones de una escala de notas van de mayor a menor?', NULL, '{"options":[{"id":"a","text":"Porque Python toma la primera verdadera, y si empieza por la menos exigente las demás nunca se alcanzan"},{"id":"b","text":"Por estética, da igual el orden"},{"id":"c","text":"Porque elif solo acepta el operador >="},{"id":"d","text":"Porque else debe ir siempre de primero"}]}', '{"option_id":"a"}', 'Con nota >= 3.0 de primera, un 4.8 entraría por ahí y diría Aprobado.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Cuándo conviene anidar un if dentro de otro?', NULL, '{"options":[{"id":"a","text":"Cuando la segunda pregunta solo tiene sentido si la primera pasó"},{"id":"b","text":"Siempre que haya dos condiciones"},{"id":"c","text":"Cuando se quiere ahorrar líneas"},{"id":"d","text":"Nunca: anidar está prohibido"}]}', '{"option_id":"a"}', 'Si el saldo no alcanza, ni vale la pena preguntar si el monto es múltiplo. Si las dos preguntas son independientes, se unen con and.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'edad = 15
if edad >= 18:
    print("Pasa")
print("Siguiente")', '{"options":[{"id":"a","text":"Siguiente"},{"id":"b","text":"Pasa\nSiguiente"},{"id":"c","text":"Pasa"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'La condición es falsa, así que el bloque indentado se salta. El último print está afuera y siempre corre.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'nota = 4.8
if nota >= 3.0:
    print("Aprobado")
elif nota >= 4.5:
    print("Excelente")', '{"options":[{"id":"a","text":"Aprobado"},{"id":"b","text":"Excelente"},{"id":"c","text":"Aprobado\nExcelente"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'El orden está al revés: la primera condición ya es verdadera, así que el elif nunca se alcanza.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'saldo = 30000
retiro = 50000
if retiro <= saldo:
    saldo = saldo - retiro
    print("Aprobado")
else:
    print("Insuficiente")
print(saldo)', '{"options":[{"id":"a","text":"Insuficiente\n30000"},{"id":"b","text":"Aprobado\n-20000"},{"id":"c","text":"Insuficiente\n-20000"},{"id":"d","text":"Aprobado\n30000"}]}', '{"option_id":"a"}', 'La condición es falsa, así que el saldo no se toca y entra por el else.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'n = 12
if n % 2 == 0:
    print("par")
if n % 3 == 0:
    print("multiplo de 3")', '{"options":[{"id":"a","text":"par\nmultiplo de 3"},{"id":"b","text":"par"},{"id":"c","text":"multiplo de 3"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'Son dos if independientes, no una cadena: se evalúan los dos y los dos son verdaderos.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'consumo = 200
if consumo <= 150:
    tarifa = 500
elif consumo <= 300:
    tarifa = 700
else:
    tarifa = 900
print(consumo * tarifa)', '{"options":[{"id":"a","text":"140000"},{"id":"b","text":"100000"},{"id":"c","text":"180000"},{"id":"d","text":"700"}]}', '{"option_id":"a"}', '200 no es <= 150 pero sí <= 300, así que la tarifa queda en 700: 200 * 700 = 140000.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'saldo = 100000
monto = 35000
if monto <= saldo:
    if monto % 10000 == 0:
        print("Aprobado")
    else:
        print("Solo multiplos de 10000")
else:
    print("Insuficiente")', '{"options":[{"id":"a","text":"Solo multiplos de 10000"},{"id":"b","text":"Aprobado"},{"id":"c","text":"Insuficiente"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'El saldo alcanza, así que entra al if de adentro; 35000 % 10000 da 5000, no cero, y cae en el else interno.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', '¿En qué línea está el error?', NULL, '{"lines":["edad = int(input(\"Edad: \"))","if edad >= 18","    print(\"Mayor de edad\")"]}', '{"line_number":2}', 'Falta los dos puntos al final de la condición.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["nota = 4.0","if nota = 5.0:","    print(\"Perfecto\")"]}', '{"line_number":2}', 'Dentro de un if se compara con ==. Un solo = es asignación y da SyntaxError.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El else debería atender el caso contrario. ¿En qué línea está el error?', NULL, '{"lines":["saldo = 100000","monto = 50000","if monto <= saldo:","print(\"Aprobado\")","else:","    print(\"Insuficiente\")"]}', '{"line_number":4}', 'El print del bloque no está indentado: Python espera al menos una línea con sangría después de los dos puntos.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que dice si un número es par o impar', NULL, '{"lines":[{"id":"l1","text":"numero = int(input(\"Numero: \"))","indent":0},{"id":"l2","text":"if numero % 2 == 0:","indent":0},{"id":"l3","text":"print(f\"El {numero} es par\")","indent":1},{"id":"l4","text":"else:","indent":0},{"id":"l5","text":"print(f\"El {numero} es impar\")","indent":1}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Los print van indentados dentro de su rama, y el else se alinea con el if.', 1, 'seed'
    FROM chapters WHERE number = 6 AND track = 'basico';

-- ── Capítulo 7: Ciclo while (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 7, 'Ciclo while', '⏳', 'Repetir mientras se cumpla una condición, con contadores, sumatorias y banderas.', '<p class="jc-gancho">El cajero no te pregunta la clave una vez y se rinde: te deja intentar hasta tres veces. La caja de la tienda no cobra un producto: cobra hasta que digas "ya". Eso es repetir <em>mientras</em> algo se cumpla, y para eso está <code>while</code>.</p>

<h2>La alarma del despertador</h2>

<p><code>while</code> repite un bloque <strong>mientras</strong> su condición sea verdadera. Es una alarma: suena, revisa si ya te levantaste, y si no, vuelve a sonar.</p>

<pre><code>contador = 1

while contador &lt;= 3:
    print("Intento", contador)
    contador = contador + 1

print("Se acabaron los intentos")</code></pre>

<p>Las tres partes de todo <code>while</code>, y si falta una el programa se rompe:</p>

<table>
  <thead>
    <tr><th>Parte</th><th>Dónde va</th><th>En el ejemplo</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>Preparar</strong></td><td>Antes del ciclo</td><td><code>contador = 1</code></td></tr>
    <tr><td><strong>Preguntar</strong></td><td>En el <code>while</code></td><td><code>contador &lt;= 3</code></td></tr>
    <tr><td><strong>Avanzar</strong></td><td>Adentro del ciclo</td><td><code>contador = contador + 1</code></td></tr>
  </tbody>
</table>

<p>Si olvidas <em>avanzar</em>, la condición nunca cambia y el programa se queda repitiendo para siempre. Eso es un <strong>ciclo infinito</strong>, y es el error número uno de este capítulo.</p>

<h3>La película, vuelta a vuelta</h3>

<table>
  <thead>
    <tr><th>Vuelta</th><th><code>contador</code> al entrar</th><th>¿<code>&lt;= 3</code>?</th><th>Imprime</th><th><code>contador</code> al salir</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>1</td><td>Sí</td><td>Intento 1</td><td>2</td></tr>
    <tr><td>2</td><td>2</td><td>Sí</td><td>Intento 2</td><td>3</td></tr>
    <tr><td>3</td><td>3</td><td>Sí</td><td>Intento 3</td><td>4</td></tr>
    <tr><td>4</td><td>4</td><td><strong>No</strong></td><td>—</td><td>sale del ciclo</td></tr>
  </tbody>
</table>

<p>Esa tabla es la herramienta. Cada vez que un ciclo no te dé lo que esperas, hazla en papel con tres o cuatro vueltas. Casi siempre el error salta a la vista en la vuelta 1 o en la última.</p>

<h2>Los tres patrones: contador, sumatoria y bandera</h2>

<p>El 90% de los ciclos que vas a escribir en tu vida son uno de estos tres, o una mezcla. Y todos comparten la misma regla:</p>

<blockquote><strong>Nacen afuera, se actualizan adentro.</strong> La variable se crea <em>antes</em> del ciclo y se modifica <em>dentro</em> del ciclo.</blockquote>

<p>Si la creas adentro, se reinicia en cada vuelta y nunca acumula nada.</p>

<h3>1. Contador: ¿cuántos?</h3>

<p>Nace en <code>0</code> y sube de a uno cuando pasa lo que te interesa.</p>

<pre><code>aprobados = 0                 # nace afuera, en cero
n = 1

while n &lt;= 5:
    nota = float(input(f"Nota {n}: "))
    if nota &gt;= 3.0:
        aprobados = aprobados + 1     # se actualiza adentro
    n = n + 1

print("Aprobados:", aprobados)</code></pre>

<h3>2. Sumatoria: ¿cuánto en total?</h3>

<p>Nace en <code>0</code> y se le suma el valor de cada vuelta.</p>

<pre><code>total = 0                     # nace afuera, en cero
n = 1

while n &lt;= 5:
    venta = int(input(f"Venta {n}: "))
    total = total + venta             # se actualiza adentro
    n = n + 1

print("Total del día:", total)
print("Promedio:", total / 5)</code></pre>

<p>Fíjate en que el promedio se calcula <strong>después</strong> del ciclo, con la suma ya completa. Calcularlo adentro sería promediar datos incompletos.</p>

<h3>3. Bandera: ¿pasó al menos una vez?</h3>

<p>Nace en <code>False</code> y se pone en <code>True</code> apenas ocurre lo que buscabas. Nunca vuelve atrás.</p>

<pre><code>hubo_perdida = False          # nace afuera, en False
n = 1

while n &lt;= 5:
    venta = int(input(f"Venta {n}: "))
    if venta &lt; 0:
        hubo_perdida = True           # se actualiza adentro
    n = n + 1

if hubo_perdida:
    print("Ojo: hubo al menos una venta negativa")</code></pre>

<p>El error clásico con banderas es usar <code>else: hubo_perdida = False</code>. Eso borra el hallazgo en la siguiente vuelta. Una bandera se levanta y se queda levantada.</p>

<h3>Los tres juntos</h3>

<pre><code>total = 0             # sumatoria
cuantas = 0           # contador
hubo_grande = False   # bandera

n = 1
while n &lt;= 3:
    venta = int(input(f"Venta {n}: "))
    total = total + venta
    cuantas = cuantas + 1
    if venta &gt; 100000:
        hubo_grande = True
    n = n + 1

print(f"{cuantas} ventas, total {total}")
if hubo_grande:
    print("Hubo al menos una venta grande")</code></pre>

<h2>Atajos de actualización</h2>

<p>Escribir <code>total = total + venta</code> se vuelve cansón. Python tiene atajos:</p>

<table>
  <thead>
    <tr><th>Atajo</th><th>Es lo mismo que</th></tr>
  </thead>
  <tbody>
    <tr><td><code>n += 1</code></td><td><code>n = n + 1</code></td></tr>
    <tr><td><code>total += venta</code></td><td><code>total = total + venta</code></td></tr>
    <tr><td><code>saldo -= retiro</code></td><td><code>saldo = saldo - retiro</code></td></tr>
    <tr><td><code>precio *= 2</code></td><td><code>precio = precio * 2</code></td></tr>
  </tbody>
</table>

<h2>Ciclos que no saben cuántas vueltas darán</h2>

<p>Hasta aquí contábamos vueltas. Pero <code>while</code> brilla cuando el final depende del usuario:</p>

<pre><code>total = 0
producto = input("Producto (o ''fin'' para terminar): ")

while producto != "fin":
    precio = int(input("Precio: "))
    total += precio
    producto = input("Producto (o ''fin'' para terminar): ")

print("Total de la compra:", total)</code></pre>

<p>Ese <code>input()</code> repetido —uno antes del ciclo y otro al final del cuerpo— se llama <strong>lectura anticipada</strong>. El primero da el dato para la primera pregunta del <code>while</code>; el segundo prepara la vuelta siguiente. Sin el de adentro, el ciclo sería infinito.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Olvidar avanzar (ciclo infinito)</h3>
<pre><code>n = 1
while n &lt;= 3:
    print(n)      # imprime 1 para siempre</code></pre>
<p>Si tu programa se queda pegado, es esto. Detenlo con Ctrl+C y busca la línea que debía cambiar la variable de la condición.</p>

<h3>2. Crear el acumulador adentro</h3>
<pre><code>while n &lt;= 3:
    total = 0        # ❌ se reinicia en cada vuelta
    total += venta</code></pre>
<p>Nace afuera. Siempre.</p>

<h3>3. Bajar la bandera</h3>
<pre><code>if venta &lt; 0:
    hubo_perdida = True
else:
    hubo_perdida = False   # ❌ borra lo que ya se había encontrado</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li><strong>Prepara</strong> antes del ciclo: contadores y sumatorias en <code>0</code>, banderas en <code>False</code>.</li>
  <li><strong>Pregunta</strong> en el <code>while</code>: la condición que mantiene vivo el ciclo.</li>
  <li><strong>Avanza</strong> adentro: cambia lo que la condición mira, o el ciclo no termina.</li>
  <li><strong>Concluye</strong> después: promedios, mensajes y decisiones van fuera, con los datos ya completos.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>while cond:</code></td><td>Repite mientras <code>cond</code> sea verdadera</td></tr>
    <tr><td><code>contador = 0</code> · <code>contador += 1</code></td><td>Contar cuántas veces</td></tr>
    <tr><td><code>total = 0</code> · <code>total += valor</code></td><td>Acumular una suma</td></tr>
    <tr><td><code>bandera = False</code> · <code>bandera = True</code></td><td>Recordar que algo pasó</td></tr>
    <tr><td><code>while dato != "fin":</code></td><td>Repetir hasta que el usuario diga basta</td></tr>
    <tr><td>Ctrl+C</td><td>Detener un ciclo infinito</td></tr>
  </tbody>
</table>

<blockquote>Contadores, sumatorias y banderas nacen afuera y se actualizan adentro. Si la variable nace adentro, cada vuelta la borra.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 2
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 7 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Cuenta regresiva', 'facil', '<p>Solicitar un número entero positivo y mostrar la cuenta regresiva hasta 1, y luego la palabra <code>Ya!</code>:</p><pre><code>5
4
3
2
1
Ya!</code></pre>', '<p>La variable arranca en el número que dio el usuario, la condición es <code>n >= 1</code> y adentro se resta uno con <code>n -= 1</code>.</p>', '<pre><code>''''''
Programa: Cuenta regresiva
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra una cuenta regresiva desde el numero indicado hasta 1.
''''''

# Inicio
n = int(input("Desde: "))

while n >= 1:
    print(n)
    n -= 1        # avanzar: sin esta linea el ciclo es infinito

print("Ya!")
# Fin</code></pre><p>Las tres partes están todas: preparar (<code>n</code> viene del input), preguntar (<code>n >= 1</code>) y avanzar (<code>n -= 1</code>). El <code>print("Ya!")</code> va fuera del ciclo, sin indentar, porque solo debe salir una vez al final.</p>', '[{"stdin":"5\n","expected_output":"Desde: 5\n4\n3\n2\n1\nYa!"}]', '''''''
Programa: Cuenta regresiva
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Ventas del día', 'facil', '<p>Solicitar <strong>5</strong> ventas del día. Al final mostrar el total y el promedio:</p><pre><code>Total: 250000
Promedio: 50000.0</code></pre><p><em>Nota:</em> use el patrón de sumatoria.</p>', '<p><code>total</code> nace en 0 <strong>antes</strong> del ciclo y adentro crece con <code>total += venta</code>. El promedio se calcula después, cuando el total ya está completo.</p>', '<pre><code>''''''
Programa: Ventas del dia
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide cinco ventas y muestra el total y el promedio.
''''''

# Inicio
CUANTAS = 5

total = 0     # sumatoria: nace afuera, en cero
n = 1

while n <= CUANTAS:
    venta = int(input(f"Venta {n}: "))
    total += venta      # se actualiza adentro
    n += 1

# El promedio se calcula al final, con la suma ya completa
print(f"Total: {total}")
print(f"Promedio: {total / CUANTAS}")
# Fin</code></pre><p>Si <code>total = 0</code> estuviera dentro del ciclo, cada vuelta lo pondría en cero otra vez y al final valdría solo la última venta. Por eso nace afuera.</p>', '[{"stdin":"50000\n50000\n50000\n50000\n50000\n","expected_output":"Venta 1: Venta 2: Venta 3: Venta 4: Venta 5: Total: 250000\nPromedio: 50000.0"}]', '''''''
Programa: Ventas del dia
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CUANTAS = 5

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Informe de notas', 'medio', '<p>Solicitar <strong>5</strong> notas de un estudiante (de 0.0 a 5.0). Mostrar al final:</p><ul><li>cuántas aprobaron (nota mayor o igual a 3.0),</li><li>el promedio del curso,</li><li>y un aviso si hubo <strong>al menos una</strong> nota perfecta (5.0).</li></ul><pre><code>Aprobadas: 3
Promedio: 3.5
Hubo al menos un 5.0</code></pre><p><em>Nota:</em> use los tres patrones: contador, sumatoria y bandera.</p>', '<p>Tres variables nacen antes del ciclo: <code>aprobadas = 0</code>, <code>suma = 0.0</code> y <code>hubo_perfecta = False</code>. La bandera se levanta y no se vuelve a bajar: nada de <code>else</code>.</p>', '<pre><code>''''''
Programa: Informe de notas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide cinco notas y reporta cuantas aprobaron, el promedio
    y si hubo alguna nota perfecta.
''''''

# Inicio
CUANTAS = 5
MINIMA_APROBATORIA = 3.0

aprobadas = 0            # contador
suma = 0.0               # sumatoria
hubo_perfecta = False    # bandera

n = 1
while n <= CUANTAS:
    nota = float(input(f"Nota {n}: "))

    suma += nota
    if nota >= MINIMA_APROBATORIA:
        aprobadas += 1
    if nota == 5.0:
        # La bandera se levanta y se queda levantada:
        # no lleva else que la vuelva a bajar
        hubo_perfecta = True

    n += 1

print(f"Aprobadas: {aprobadas}")
print(f"Promedio: {suma / CUANTAS}")

if hubo_perfecta:
    print("Hubo al menos un 5.0")
# Fin</code></pre><p>Los tres patrones conviviendo, cada uno con su regla:</p><table><thead><tr><th>Variable</th><th>Nace en</th><th>Se actualiza</th></tr></thead><tbody><tr><td><code>aprobadas</code></td><td>0</td><td><code>+= 1</code> cuando se cumple la condición</td></tr><tr><td><code>suma</code></td><td>0.0</td><td><code>+= nota</code> en todas las vueltas</td></tr><tr><td><code>hubo_perfecta</code></td><td>False</td><td><code>= True</code> una vez y nunca vuelve atrás</td></tr></tbody></table>', '[{"stdin":"5.0\n4.0\n3.0\n2.0\n3.5\n","expected_output":"Nota 1: Nota 2: Nota 3: Nota 4: Nota 5: Aprobadas: 4\nPromedio: 3.5\nHubo al menos un 5.0"},{"stdin":"2.0\n2.0\n2.0\n2.0\n2.0\n","expected_output":"Nota 1: Nota 2: Nota 3: Nota 4: Nota 5: Aprobadas: 0\nPromedio: 2.0"}]', '''''''
Programa: Informe de notas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CUANTAS = 5
MINIMA_APROBATORIA = 3.0

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Caja de la tienda', 'dificil', '<p>Simular la caja de una tienda. Se piden productos y precios <strong>hasta que el usuario escriba <code>fin</code></strong> como nombre del producto.</p><p>Al terminar mostrar:</p><pre><code>Productos: 3
Total: 27000
El mas caro costo 15000</code></pre><p>Si no se registró ningún producto, mostrar únicamente:</p><pre><code>No se registro ninguna compra</code></pre><p><em>Nota:</em> use lectura anticipada.</p>', '<p>El primer <code>input()</code> del producto va <strong>antes</strong> del <code>while</code>, y el último dentro del ciclo, de último. Para el más caro, guarde <code>mayor = 0</code> y actualícelo cuando el precio lo supere.</p>', '<pre><code>''''''
Programa: Caja de la tienda
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Registra productos y precios hasta que el usuario escriba
    fin, y reporta cantidad, total y el producto mas caro.
''''''

# Inicio
cantidad = 0    # contador
total = 0       # sumatoria
mayor = 0       # el precio mas alto visto hasta ahora

# Lectura anticipada: este primer dato alimenta la primera
# pregunta del while
producto = input("Producto (o fin): ").strip().lower()

while producto != "fin":
    precio = int(input("Precio: "))

    cantidad += 1
    total += precio
    if precio > mayor:
        mayor = precio

    # Esta lectura prepara la vuelta siguiente:
    # sin ella el ciclo seria infinito
    producto = input("Producto (o fin): ").strip().lower()

if cantidad == 0:
    print("No se registro ninguna compra")
else:
    print(f"Productos: {cantidad}")
    print(f"Total: {total}")
    print(f"El mas caro costo {mayor}")
# Fin</code></pre><p>Tres ideas que se repiten toda la vida programando:</p><ul><li><strong>Lectura anticipada.</strong> Dos <code>input()</code> del mismo dato: uno antes del ciclo y otro al final del cuerpo. El de afuera arranca; el de adentro mantiene.</li><li><strong>El máximo se busca comparando.</strong> <code>mayor</code> nace en 0 y se reemplaza cada vez que aparece algo más grande. Es otro acumulador, solo que en vez de sumar, se queda con el mejor.</li><li><strong>El caso vacío.</strong> Si el usuario escribe <code>fin</code> de una, el ciclo no da ni una vuelta. Preguntarlo evita dividir entre cero o mostrar un informe sin datos.</li></ul>', '[{"stdin":"Pan\n5000\nLeche\n7000\nQueso\n15000\nfin\n","expected_output":"Producto (o fin): Precio: Producto (o fin): Precio: Producto (o fin): Precio: Producto (o fin): Productos: 3\nTotal: 27000\nEl mas caro costo 15000"},{"stdin":"fin\n","expected_output":"Producto (o fin): No se registro ninguna compra"}]', '''''''
Programa: Caja de la tienda
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuáles son las tres partes de todo ciclo while?', NULL, '{"options":[{"id":"a","text":"Preparar antes, preguntar en el while y avanzar adentro"},{"id":"b","text":"Abrir, cerrar y contar"},{"id":"c","text":"if, elif y else"},{"id":"d","text":"Inicio, cuerpo y return"}]}', '{"option_id":"a"}', 'Si falta avanzar, la condición nunca cambia y el ciclo es infinito.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Dónde nace un contador o una sumatoria?', NULL, '{"options":[{"id":"a","text":"Antes del ciclo, y se actualiza adentro"},{"id":"b","text":"Dentro del ciclo, para que se reinicie"},{"id":"c","text":"Después del ciclo"},{"id":"d","text":"Dentro del if"}]}', '{"option_id":"a"}', 'Nacen afuera, se actualizan adentro. Si nacen adentro, cada vuelta los borra.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿En qué valor nace una bandera?', NULL, '{"options":[{"id":"a","text":"En False, y se pone en True cuando ocurre lo que se busca"},{"id":"b","text":"En 0, y se suma de a uno"},{"id":"c","text":"En True, para poder bajarla"},{"id":"d","text":"En una cadena vacía"}]}', '{"option_id":"a"}', 'Una bandera se levanta y se queda levantada. Ponerle un else que la baje borra el hallazgo.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué es la lectura anticipada?', NULL, '{"options":[{"id":"a","text":"Pedir el dato una vez antes del while y otra al final del cuerpo"},{"id":"b","text":"Leer todos los datos de una vez al principio"},{"id":"c","text":"Usar input() dentro de la condición del while"},{"id":"d","text":"Adivinar el dato antes de pedirlo"}]}', '{"option_id":"a"}', 'El primer input alimenta la primera pregunta del while; el de adentro prepara la vuelta siguiente.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué el promedio se calcula después del ciclo y no adentro?', NULL, '{"options":[{"id":"a","text":"Porque adentro la suma todavía está incompleta"},{"id":"b","text":"Porque dentro del while no se puede dividir"},{"id":"c","text":"Porque el promedio necesita un if"},{"id":"d","text":"Da igual, es cuestión de gusto"}]}', '{"option_id":"a"}', 'En la vuelta 3 la suma solo tiene tres datos. El promedio se saca cuando el acumulador ya terminó.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'n = 1
while n <= 3:
    print(n)
    n += 1', '{"options":[{"id":"a","text":"1\n2\n3"},{"id":"b","text":"1\n2\n3\n4"},{"id":"c","text":"1 para siempre"},{"id":"d","text":"0\n1\n2"}]}', '{"option_id":"a"}', 'En la vuelta cuatro n vale 4, la condición falla y el ciclo termina sin imprimir.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'total = 0
n = 1
while n <= 4:
    total += n
    n += 1
print(total)', '{"options":[{"id":"a","text":"10"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"0"}]}', '{"option_id":"a"}', 'Va sumando 1 + 2 + 3 + 4 = 10. Es el patrón de sumatoria.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'n = 1
while n <= 3:
    total = 0
    total += n
    n += 1
print(total)', '{"options":[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"0"},{"id":"d","text":"1"}]}', '{"option_id":"a"}', 'total nace dentro del ciclo, así que cada vuelta lo pone en cero: al final solo guarda el último valor.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'n = 5
while n > 0:
    n -= 2
print(n)', '{"options":[{"id":"a","text":"-1"},{"id":"b","text":"0"},{"id":"c","text":"1"},{"id":"d","text":"5"}]}', '{"option_id":"a"}', 'Va 5, 3, 1 y luego -1. Con -1 la condición falla y sale. Restar de a dos puede saltarse el cero.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'bandera = False
n = 1
while n <= 3:
    if n == 2:
        bandera = True
    else:
        bandera = False
    n += 1
print(bandera)', '{"options":[{"id":"a","text":"False"},{"id":"b","text":"True"},{"id":"c","text":"2"},{"id":"d","text":"3"}]}', '{"option_id":"a"}', 'El else baja la bandera en la vuelta 3 y borra el hallazgo de la vuelta 2. Una bandera no lleva else.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Cuántas veces se imprime hola?', 'n = 0
while n < 3:
    print("hola")', '{"options":[{"id":"a","text":"Infinitas: nunca cambia n"},{"id":"b","text":"Tres veces"},{"id":"c","text":"Ninguna"},{"id":"d","text":"Una vez"}]}', '{"option_id":"a"}', 'Falta la parte de avanzar. La condición 0 < 3 siempre es verdadera.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe sumar cinco ventas. ¿En qué línea está el error?', NULL, '{"lines":["n = 1","while n <= 5:","    total = 0","    total += int(input())","    n += 1","print(total)"]}', '{"line_number":3}', 'La sumatoria nace dentro del ciclo y se reinicia en cada vuelta. Esa línea va antes del while.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este ciclo nunca termina. ¿En qué línea está el problema?', NULL, '{"lines":["n = 1","while n <= 3:","    print(n)","    n = 1"]}', '{"line_number":4}', 'Debía ser n += 1. Reasignar 1 deja la condición verdadera para siempre.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'El ciclo debe terminar cuando el usuario escriba fin, pero no termina. ¿Qué línea falta arreglar?', NULL, '{"lines":["producto = input(\"Producto: \")","while producto != \"fin\":","    precio = int(input(\"Precio: \"))","    total += precio","print(total)"]}', '{"line_number":4}', 'Falta volver a leer el producto al final del cuerpo: sin esa segunda lectura la condición nunca cambia.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa que suma cinco ventas y muestra el promedio', NULL, '{"lines":[{"id":"l1","text":"total = 0","indent":0},{"id":"l2","text":"n = 1","indent":0},{"id":"l3","text":"while n <= 5:","indent":0},{"id":"l4","text":"venta = int(input(f\"Venta {n}: \"))","indent":1},{"id":"l5","text":"total += venta","indent":1},{"id":"l6","text":"n += 1","indent":1},{"id":"l7","text":"print(f\"Promedio: {total / 5}\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7"]}', 'La sumatoria y el contador nacen afuera, el cuerpo del ciclo va indentado, y el promedio se calcula fuera con la suma completa.', 1, 'seed'
    FROM chapters WHERE number = 7 AND track = 'basico';

-- ── Capítulo 8: Ciclo for y range() (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 8, 'Ciclo for y range()', '🔢', 'Recorrer secuencias y contar de forma elegante.', '<p class="jc-gancho">Escribir un <code>while</code> para contar del 1 al 10 son cuatro líneas y tres oportunidades de olvidar el <code>n += 1</code>. Cuando sabes cuántas vueltas quieres, hay algo mejor: <code>for</code>.</p>

<h2><code>for</code>: recorrer, no contar</h2>

<p>Un <code>for</code> toma una colección y va sacando sus elementos uno por uno. Tú no manejas el contador: lo maneja Python.</p>

<pre><code>for letra in "Ana":
    print(letra)</code></pre>

<p>Sale <code>A</code>, <code>n</code>, <code>a</code>. La variable <code>letra</code> vale algo distinto en cada vuelta, y el ciclo termina solo cuando se acaba el texto. No hay condición que escribir ni contador que actualizar.</p>

<p>La forma general se lee casi en español:</p>

<pre><code>for cada_cosa in la_coleccion:
    # hacer algo con cada_cosa</code></pre>

<h2><code>range()</code>: la colección de números</h2>

<p>Para repetir un número fijo de veces se usa <code>range()</code>, que genera números.</p>

<table>
  <thead>
    <tr><th>Escribes</th><th>Genera</th><th>Se lee</th></tr>
  </thead>
  <tbody>
    <tr><td><code>range(5)</code></td><td>0, 1, 2, 3, 4</td><td>Cinco números empezando en 0</td></tr>
    <tr><td><code>range(1, 6)</code></td><td>1, 2, 3, 4, 5</td><td>Desde 1 hasta antes de 6</td></tr>
    <tr><td><code>range(0, 10, 2)</code></td><td>0, 2, 4, 6, 8</td><td>De 2 en 2</td></tr>
    <tr><td><code>range(5, 0, -1)</code></td><td>5, 4, 3, 2, 1</td><td>Hacia atrás</td></tr>
  </tbody>
</table>

<p><strong>El final nunca entra.</strong> Es la misma regla de las rebanadas del capítulo 5: <code>range(1, 6)</code> llega hasta el 5. Se siente raro dos días y después se vuelve cómodo, porque <code>range(5)</code> da exactamente 5 números.</p>

<pre><code>for n in range(1, 6):
    print(f"Intento {n}")</code></pre>

<p>Comparado con el <code>while</code> del capítulo anterior:</p>

<pre><code># while: tres partes que tú manejas
n = 1
while n &lt;= 5:
    print(f"Intento {n}")
    n += 1

# for: Python las maneja
for n in range(1, 6):
    print(f"Intento {n}")</code></pre>

<h3>¿Cuándo <code>for</code> y cuándo <code>while</code>?</h3>

<table>
  <thead>
    <tr><th>Usa</th><th>Cuando…</th><th>Ejemplo</th></tr>
  </thead>
  <tbody>
    <tr><td><code>for</code></td><td>sabes cuántas vueltas o tienes una colección</td><td>5 notas, las letras de un nombre</td></tr>
    <tr><td><code>while</code></td><td>el final depende de algo que pasa adentro</td><td>hasta que escriba "fin", hasta que acierte</td></tr>
  </tbody>
</table>

<h2>Los tres patrones, ahora con <code>for</code></h2>

<p>Contador, sumatoria y bandera funcionan igual: <strong>nacen afuera, se actualizan adentro</strong>. Lo único que cambia es quién lleva la cuenta de las vueltas.</p>

<pre><code>total = 0             # sumatoria
aprobadas = 0         # contador
hubo_perfecta = False # bandera

for n in range(1, 6):
    nota = float(input(f"Nota {n}: "))
    total += nota
    if nota &gt;= 3.0:
        aprobadas += 1
    if nota == 5.0:
        hubo_perfecta = True

print(f"Aprobadas: {aprobadas}")
print(f"Promedio: {total / 5}")</code></pre>

<h2>La película de un <code>for</code></h2>

<p>La tabla de multiplicar del 7, de 1 a 4:</p>

<pre><code>for i in range(1, 5):
    resultado = 7 * i
    print(f"7 x {i} = {resultado}")</code></pre>

<table>
  <thead>
    <tr><th>Vuelta</th><th><code>i</code></th><th><code>resultado</code></th><th>Imprime</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>1</td><td>7</td><td>7 x 1 = 7</td></tr>
    <tr><td>2</td><td>2</td><td>14</td><td>7 x 2 = 14</td></tr>
    <tr><td>3</td><td>3</td><td>21</td><td>7 x 3 = 21</td></tr>
    <tr><td>4</td><td>4</td><td>28</td><td>7 x 4 = 28</td></tr>
    <tr><td>5</td><td>—</td><td>—</td><td>El 5 no entra: se acabó el <code>range</code></td></tr>
  </tbody>
</table>

<h2>Recorrer con el índice</h2>

<p>A veces necesitas saber en qué posición vas. Dos formas:</p>

<pre><code>ciudad = "Cali"

# Por posición, usando range con len()
for i in range(len(ciudad)):
    print(i, ciudad[i])

# Más limpio: enumerate() entrega posición y valor juntos
for i, letra in enumerate(ciudad):
    print(i, letra)</code></pre>

<p><code>enumerate()</code> es la forma preferida. Si solo te importa el valor, recorre directo; si además necesitas la posición, usa <code>enumerate()</code>.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Creer que el final entra</h3>
<pre><code>for n in range(1, 5):
    print(n)          # 1, 2, 3, 4 — el 5 NO sale</code></pre>
<p>Si quieres llegar al 5, escribe <code>range(1, 6)</code>.</p>

<h3>2. Actualizar la variable del <code>for</code></h3>
<pre><code>for n in range(5):
    n = n + 10        # no sirve de nada: la próxima vuelta la reemplaza</code></pre>
<p>Esa variable la controla Python. Si necesitas otra cosa, usa una variable aparte.</p>

<h3>3. Usar <code>for</code> cuando no sabes cuántas vueltas</h3>
<pre><code># El usuario escribe hasta que quiera: eso es un while
for i in range(100):
    dato = input("Producto: ")    # ❌ ¿y si son 3? ¿y si son 200?</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿Sabes cuántas vueltas o tienes una colección? <code>for</code>. ¿No? <code>while</code>.</li>
  <li><code>range(a, b)</code> va de <code>a</code> hasta <code>b - 1</code>. El final nunca entra.</li>
  <li>Los acumuladores siguen naciendo antes del ciclo.</li>
  <li>Si necesitas la posición, <code>enumerate()</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>for x in "texto":</code></td><td>Recorre carácter por carácter</td></tr>
    <tr><td><code>for n in range(5):</code></td><td>0, 1, 2, 3, 4</td></tr>
    <tr><td><code>for n in range(1, 6):</code></td><td>1, 2, 3, 4, 5</td></tr>
    <tr><td><code>for n in range(0, 10, 2):</code></td><td>De 2 en 2</td></tr>
    <tr><td><code>for n in range(5, 0, -1):</code></td><td>Cuenta regresiva</td></tr>
    <tr><td><code>for i, v in enumerate(x):</code></td><td>Posición y valor a la vez</td></tr>
  </tbody>
</table>

<blockquote><code>for</code> cuando sabes cuántas vueltas; <code>while</code> cuando el final lo decide lo que pase adentro. Y en <code>range</code>, el final nunca entra.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 2
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 8 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Tabla de multiplicar', 'facil', '<p>Solicitar un número y mostrar su tabla de multiplicar del 1 al 10:</p><pre><code>7 x 1 = 7
7 x 2 = 14
...
7 x 10 = 70</code></pre>', '<p><code>range(1, 11)</code> genera del 1 al 10: recuerde que el final no entra, por eso es 11 y no 10.</p>', '<pre><code>''''''
Programa: Tabla de multiplicar
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra la tabla de multiplicar del numero indicado, del 1 al 10.
''''''

# Inicio
numero = int(input("Numero: "))

# range(1, 11) llega hasta 10: el final nunca entra
for i in range(1, 11):
    print(f"{numero} x {i} = {numero * i}")
# Fin</code></pre><p>Aquí no hay contador que actualizar: <code>i</code> la maneja Python. Compárelo con la versión en <code>while</code>, que necesitaría <code>i = 1</code> antes y <code>i += 1</code> adentro.</p>', '[{"stdin":"7\n","expected_output":"Numero: 7 x 1 = 7\n7 x 2 = 14\n7 x 3 = 21\n7 x 4 = 28\n7 x 5 = 35\n7 x 6 = 42\n7 x 7 = 49\n7 x 8 = 56\n7 x 9 = 63\n7 x 10 = 70"}]', '''''''
Programa: Tabla de multiplicar
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Contar vocales', 'facil', '<p>Solicitar una palabra o frase y contar cuántas vocales tiene:</p><pre><code>La frase tiene 5 vocales</code></pre><p><em>Nota:</em> deben contarse mayúsculas y minúsculas por igual.</p>', '<p>Recorra el texto con <code>for letra in frase:</code> y use <code>if letra in "aeiou"</code>. Normalice con <code>.lower()</code> para que las mayúsculas también cuenten.</p>', '<pre><code>''''''
Programa: Contador de vocales
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Cuenta cuantas vocales tiene una frase, sin distinguir
    mayusculas de minusculas.
''''''

# Inicio
VOCALES = "aeiou"

frase = input("Frase: ").lower()

vocales = 0     # contador: nace afuera

for letra in frase:
    if letra in VOCALES:
        vocales += 1

print(f"La frase tiene {vocales} vocales")
# Fin</code></pre><p>Dos cosas útiles:</p><ul><li><code>for letra in frase</code> recorre el texto carácter por carácter sin necesidad de índices.</li><li><code>letra in VOCALES</code> pregunta si ese carácter está dentro del texto <code>"aeiou"</code>. El operador <code>in</code> del capítulo 5 sirve para esto.</li></ul>', '[{"stdin":"Programar es bonito\n","expected_output":"Frase: La frase tiene 7 vocales"},{"stdin":"AEIOU\n","expected_output":"Frase: La frase tiene 5 vocales"}]', '''''''
Programa: Contador de vocales
Autor:
Fecha:
Descripcion:
''''''

# Inicio
VOCALES = "aeiou"

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Informe de ventas de la semana', 'medio', '<p>Solicitar las ventas de los <strong>7</strong> días de la semana. Mostrar al final:</p><pre><code>Total: 700000
Promedio: 100000.0
Mejor dia: 4 con 250000
Dias sin ventas: 1</code></pre><p><em>Nota:</em> el mejor día se numera de 1 a 7. Si hay empate, gana el primero.</p>', '<p>Cuatro variables nacen antes del ciclo: <code>total</code>, <code>mejor</code>, <code>dia_mejor</code> y <code>sin_ventas</code>. Para el máximo, actualice solo cuando la venta sea <strong>estrictamente mayor</strong>: así el empate lo gana el primero.</p>', '<pre><code>''''''
Programa: Informe de ventas de la semana
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide las ventas de los siete dias de la semana y reporta
    total, promedio, mejor dia y dias sin ventas.
''''''

# Inicio
DIAS = 7

total = 0          # sumatoria
mejor = -1         # el maximo visto hasta ahora
dia_mejor = 0      # en que dia ocurrio
sin_ventas = 0     # contador

for dia in range(1, DIAS + 1):
    venta = int(input(f"Ventas del dia {dia}: "))

    total += venta

    # Estrictamente mayor: en un empate se queda el primero
    if venta > mejor:
        mejor = venta
        dia_mejor = dia

    if venta == 0:
        sin_ventas += 1

print(f"Total: {total}")
print(f"Promedio: {total / DIAS}")
print(f"Mejor dia: {dia_mejor} con {mejor}")
print(f"Dias sin ventas: {sin_ventas}")
# Fin</code></pre><p>Dos decisiones importantes:</p><ul><li><strong><code>mejor = -1</code> y no 0.</strong> Si todas las ventas fueran 0, con <code>mejor = 0</code> la condición <code>venta > mejor</code> nunca se cumpliría y <code>dia_mejor</code> quedaría en 0. Arrancando por debajo del mínimo posible, la primera vuelta siempre entra.</li><li><strong>El máximo y su posición van juntos.</strong> Cada vez que se actualiza <code>mejor</code> hay que actualizar <code>dia_mejor</code> en la misma vuelta, o quedarían desfasados.</li></ul>', '[{"stdin":"100000\n50000\n100000\n250000\n100000\n100000\n0\n","expected_output":"Ventas del dia 1: Ventas del dia 2: Ventas del dia 3: Ventas del dia 4: Ventas del dia 5: Ventas del dia 6: Ventas del dia 7: Total: 700000\nPromedio: 100000.0\nMejor dia: 4 con 250000\nDias sin ventas: 1"}]', '''''''
Programa: Informe de ventas de la semana
Autor:
Fecha:
Descripcion:
''''''

# Inicio
DIAS = 7

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Amortización de un crédito', 'dificil', '<p>Un banco presta un monto a una tasa de interés mensual y el cliente abona una cuota fija cada mes.</p><p>Solicitar el monto del préstamo, la tasa mensual (en porcentaje) y la cuota. Mostrar la tabla de los primeros <strong>3</strong> meses y el saldo final:</p><pre><code>Mes 1: interes 20000 abono 80000 saldo 920000
Mes 2: interes 18400 abono 81600 saldo 838400
Mes 3: interes 16768 abono 83232 saldo 755168
Saldo despues de 3 meses: 755168</code></pre><p><em>Nota:</em> cada mes el interés se calcula sobre el saldo actual, el abono a capital es la cuota menos el interés, y el saldo baja ese abono. Redondee cada valor a entero con <code>round()</code>.</p>', '<p>El saldo nace antes del ciclo con el monto del préstamo. Dentro de cada vuelta, en este orden: interés sobre el saldo, abono = cuota − interés, saldo = saldo − abono.</p>', '<pre><code>''''''
Programa: Amortizacion de un credito
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra la tabla de amortizacion de los primeros meses de un
    credito de cuota fija, con interes sobre saldo.
''''''

# Inicio
MESES = 3

monto = int(input("Monto del prestamo: "))
tasa = float(input("Tasa mensual (%): "))
cuota = int(input("Cuota mensual: "))

saldo = monto     # el saldo nace afuera y va cambiando

for mes in range(1, MESES + 1):
    # El interes se cobra sobre lo que se debe HOY, no sobre el monto original
    interes = round(saldo * (tasa / 100))
    abono = cuota - interes
    saldo = saldo - abono

    print(f"Mes {mes}: interes {interes} abono {abono} saldo {saldo}")

print(f"Saldo despues de {MESES} meses: {saldo}")
# Fin</code></pre><p>La película con 1000000, 2% y cuota de 100000:</p><table><thead><tr><th>Mes</th><th>Saldo al entrar</th><th>Interés (2%)</th><th>Abono</th><th>Saldo al salir</th></tr></thead><tbody><tr><td>1</td><td>1000000</td><td>20000</td><td>80000</td><td>920000</td></tr><tr><td>2</td><td>920000</td><td>18400</td><td>81600</td><td>838400</td></tr><tr><td>3</td><td>838400</td><td>16768</td><td>83232</td><td>755168</td></tr></tbody></table><p>Ahí se ve por qué los créditos se sienten pesados al principio: la cuota es la misma, pero al comienzo casi todo se va en intereses y muy poco baja la deuda. A medida que el saldo cae, el interés cae y el abono crece.</p><p><strong>El orden dentro del ciclo no es negociable:</strong> si se descontara el abono antes de calcular el interés, se estaría cobrando interés sobre un saldo que el cliente ya pagó.</p>', '[{"stdin":"1000000\n2\n100000\n","expected_output":"Monto del prestamo: Tasa mensual (%): Cuota mensual: Mes 1: interes 20000 abono 80000 saldo 920000\nMes 2: interes 18400 abono 81600 saldo 838400\nMes 3: interes 16768 abono 83232 saldo 755168\nSaldo despues de 3 meses: 755168"}]', '''''''
Programa: Amortizacion de un credito
Autor:
Fecha:
Descripcion:
''''''

# Inicio
MESES = 3

# Fin
', 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuándo conviene usar for en vez de while?', NULL, '{"options":[{"id":"a","text":"Cuando se sabe cuántas vueltas serán o se recorre una colección"},{"id":"b","text":"Siempre: while quedó obsoleto"},{"id":"c","text":"Solo cuando hay que contar hacia atrás"},{"id":"d","text":"Cuando el final depende de lo que escriba el usuario"}]}', '{"option_id":"a"}', 'Si el final lo decide algo que pasa adentro (como escribir fin), eso es un while.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué genera range(1, 6)?', NULL, '{"options":[{"id":"a","text":"1, 2, 3, 4, 5"},{"id":"b","text":"1, 2, 3, 4, 5, 6"},{"id":"c","text":"0, 1, 2, 3, 4, 5"},{"id":"d","text":"6, 5, 4, 3, 2, 1"}]}', '{"option_id":"a"}', 'El final nunca entra: llega hasta el 5. Es la misma regla de las rebanadas de texto.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace enumerate() en un for?', NULL, '{"options":[{"id":"a","text":"Entrega la posición y el valor de cada elemento a la vez"},{"id":"b","text":"Cuenta cuántos elementos hay"},{"id":"c","text":"Ordena la colección"},{"id":"d","text":"Convierte la colección en números"}]}', '{"option_id":"a"}', 'for i, letra in enumerate(texto) evita tener que escribir range(len(texto)).', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En un for, ¿quién actualiza la variable del ciclo?', NULL, '{"options":[{"id":"a","text":"Python: por eso no hay que escribir n += 1"},{"id":"b","text":"El programador, igual que en el while"},{"id":"c","text":"Nadie: se queda en el primer valor"},{"id":"d","text":"El range solo la actualiza si se le pide"}]}', '{"option_id":"a"}', 'Esa es la ventaja del for: elimina la parte de avanzar, que es donde más se olvida uno.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Qué pasa si dentro de un for se hace n = n + 10 sobre la variable del ciclo?', NULL, '{"options":[{"id":"a","text":"Nada útil: la siguiente vuelta la reemplaza con el próximo valor del range"},{"id":"b","text":"El ciclo salta diez posiciones"},{"id":"c","text":"El ciclo se vuelve infinito"},{"id":"d","text":"Da un error de sintaxis"}]}', '{"option_id":"a"}', 'La variable la controla el for. Si se necesita otro valor, se usa una variable aparte.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'for n in range(3):
    print(n)', '{"options":[{"id":"a","text":"0\n1\n2"},{"id":"b","text":"1\n2\n3"},{"id":"c","text":"0\n1\n2\n3"},{"id":"d","text":"3"}]}', '{"option_id":"a"}', 'range con un solo argumento arranca en 0 y da esa cantidad de números.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'for letra in "Ana":
    print(letra)', '{"options":[{"id":"a","text":"A\nn\na"},{"id":"b","text":"Ana"},{"id":"c","text":"0\n1\n2"},{"id":"d","text":"A n a"}]}', '{"option_id":"a"}', 'Un for sobre un texto lo recorre carácter por carácter.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'total = 0
for n in range(1, 5):
    total += n
print(total)', '{"options":[{"id":"a","text":"10"},{"id":"b","text":"15"},{"id":"c","text":"4"},{"id":"d","text":"0"}]}', '{"option_id":"a"}', 'Suma 1 + 2 + 3 + 4. El 5 no entra porque el final del range queda por fuera.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'for n in range(5, 0, -1):
    print(n, end=" ")', '{"options":[{"id":"a","text":"5 4 3 2 1"},{"id":"b","text":"5 4 3 2 1 0"},{"id":"c","text":"0 1 2 3 4 5"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'El tercer argumento es el paso. Con -1 cuenta hacia atrás, y el 0 del final no entra.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'for i, letra in enumerate("Cali"):
    if i == 2:
        print(letra)', '{"options":[{"id":"a","text":"l"},{"id":"b","text":"a"},{"id":"c","text":"i"},{"id":"d","text":"C"}]}', '{"option_id":"a"}', 'Las posiciones son 0:C, 1:a, 2:l, 3:i. La posición 2 es la l.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Cuántas líneas imprime este programa?', 'for a in range(3):
    for b in range(4):
        print(a, b)', '{"options":[{"id":"a","text":"12"},{"id":"b","text":"7"},{"id":"c","text":"3"},{"id":"d","text":"4"}]}', '{"option_id":"a"}', 'El ciclo interno corre completo en cada vuelta del externo: 3 × 4 = 12.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe imprimir del 1 al 5. ¿En qué línea está el error?', NULL, '{"lines":["for n in range(1, 5):","    print(n)"]}', '{"line_number":1}', 'range(1, 5) llega hasta el 4. Para incluir el 5 hay que escribir range(1, 6).', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa debe sumar cinco números. ¿En qué línea está el error?', NULL, '{"lines":["for n in range(1, 6):","    total = 0","    total += n","print(total)"]}', '{"line_number":2}', 'La sumatoria nace dentro del ciclo: cada vuelta la reinicia. Esa línea va antes del for.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["numero = int(input(\"Numero: \"))","for i in range(1, 11)","    print(numero * i)"]}', '{"line_number":2}', 'Falta los dos puntos al final de la línea del for.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que cuenta las vocales de una frase', NULL, '{"lines":[{"id":"l1","text":"frase = input(\"Frase: \").lower()","indent":0},{"id":"l2","text":"vocales = 0","indent":0},{"id":"l3","text":"for letra in frase:","indent":0},{"id":"l4","text":"if letra in \"aeiou\":","indent":1},{"id":"l5","text":"vocales += 1","indent":2},{"id":"l6","text":"print(f\"Tiene {vocales} vocales\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6"]}', 'El contador nace antes del ciclo; el if va dentro del for y el incremento dentro del if, cada uno con su nivel de indentación.', 1, 'seed'
    FROM chapters WHERE number = 8 AND track = 'basico';

-- ── Capítulo 9: break, continue y ciclos anidados (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 9, 'break, continue y ciclos anidados', '🎛️', 'Controlar el flujo dentro de los ciclos.', '<p class="jc-gancho">Buscas un producto en el inventario y lo encuentras en la posición 3 de 500. ¿Sigues revisando los 497 restantes? El cajero te da tres intentos de clave, pero si aciertas al primero no te pide los otros dos. Eso es <code>break</code>.</p>

<h2><code>break</code>: salir ya</h2>

<p><code>break</code> corta el ciclo en seco. Ni termina la vuelta ni revisa la condición: sale.</p>

<pre><code>CLAVE = "1234"

for intento in range(1, 4):
    clave = input(f"Clave (intento {intento}): ")
    if clave == CLAVE:
        print("Bienvenido")
        break
    print("Clave incorrecta")</code></pre>

<p>Si acierta en el primer intento, el <code>break</code> se lleva el programa fuera del <code>for</code> y los intentos 2 y 3 no existen.</p>

<h3><code>else</code> del ciclo: lo que casi nadie sabe</h3>

<p>Un <code>for</code> o un <code>while</code> pueden llevar <code>else</code>. Ese bloque corre <strong>solo si el ciclo terminó sin <code>break</code></strong>. Es perfecto para el "no lo encontré":</p>

<pre><code>for intento in range(1, 4):
    clave = input(f"Clave (intento {intento}): ")
    if clave == CLAVE:
        print("Bienvenido")
        break
    print("Clave incorrecta")
else:
    print("Tarjeta bloqueada")</code></pre>

<p>Si acertó, hubo <code>break</code> y el <code>else</code> se salta. Si se acabaron los tres intentos, no hubo <code>break</code> y entra el <code>else</code>. Sin esto tocaría una bandera; con esto, nada.</p>

<h2><code>continue</code>: saltar esta vuelta</h2>

<p><code>continue</code> no sale del ciclo: se salta lo que falta de <em>esta</em> vuelta y pasa a la siguiente.</p>

<pre><code>total = 0

for n in range(1, 6):
    venta = int(input(f"Venta {n}: "))
    if venta &lt; 0:
        print("Valor inválido, se ignora")
        continue          # no suma, pasa a la venta siguiente
    total += venta

print("Total:", total)</code></pre>

<table>
  <thead>
    <tr><th>Palabra</th><th>Qué hace</th><th>Se usa para</th></tr>
  </thead>
  <tbody>
    <tr><td><code>break</code></td><td>Sale del ciclo entero</td><td>Ya encontré lo que buscaba</td></tr>
    <tr><td><code>continue</code></td><td>Salta a la vuelta siguiente</td><td>Este dato no me sirve, sigo</td></tr>
  </tbody>
</table>

<p>Consejo: úsalos con moderación. Un ciclo lleno de <code>continue</code> se vuelve difícil de seguir; muchas veces un <code>if</code> bien puesto es más claro.</p>

<h2>Ciclos anidados: un ciclo dentro de otro</h2>

<p>Cuando cada vuelta del ciclo de afuera necesita su propio ciclo adentro. La imagen mental: el de afuera son las filas, el de adentro las columnas.</p>

<pre><code>for fila in range(1, 4):
    for columna in range(1, 4):
        print(f"{fila}x{columna}", end="  ")
    print()      # baja de línea al terminar la fila</code></pre>

<p>Sale:</p>

<pre><code>1x1  1x2  1x3
2x1  2x2  2x3
3x1  3x2  3x3</code></pre>

<p>Lo esencial: <strong>el ciclo de adentro se ejecuta completo en cada vuelta del de afuera</strong>. Tres filas por tres columnas son nueve vueltas del cuerpo interno.</p>

<p>Ese <code>end="  "</code> le dice a <code>print()</code> que en vez de bajar de línea deje dos espacios. El <code>print()</code> pelado del final sí baja, y por eso cada fila queda en su renglón.</p>

<h3>La película de un anidado</h3>

<table>
  <thead>
    <tr><th>Vuelta externa</th><th><code>fila</code></th><th>Vueltas internas</th><th>Qué imprime</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>1</td><td><code>columna</code> = 1, 2, 3</td><td>1x1 1x2 1x3, y baja</td></tr>
    <tr><td>2</td><td>2</td><td><code>columna</code> = 1, 2, 3</td><td>2x1 2x2 2x3, y baja</td></tr>
    <tr><td>3</td><td>3</td><td><code>columna</code> = 1, 2, 3</td><td>3x1 3x2 3x3, y baja</td></tr>
  </tbody>
</table>

<h3><code>break</code> dentro de un anidado</h3>

<p>Cuidado con esto: <code>break</code> sale <strong>solo del ciclo que lo contiene</strong>, no de todos.</p>

<pre><code>for fila in range(1, 4):
    for columna in range(1, 4):
        if columna == 2:
            break          # corta las columnas, NO las filas
        print(fila, columna)</code></pre>

<p>Imprime <code>1 1</code>, <code>2 1</code> y <code>3 1</code>: en cada fila el ciclo interno se corta en la columna 2, pero el externo sigue tranquilo. Para salir de los dos hace falta una bandera o sacar el bloque a una función (capítulo 14).</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Usar <code>break</code> creyendo que salta la vuelta</h3>
<pre><code>for n in range(5):
    if n == 2:
        break        # ❌ se acabó el ciclo en el 2
        # continue   # ✅ esto era lo que querías</code></pre>

<h3>2. Poner el <code>continue</code> antes de actualizar en un <code>while</code></h3>
<pre><code>n = 0
while n &lt; 5:
    if n == 2:
        continue     # ❌ nunca llega al n += 1: ciclo infinito
    n += 1</code></pre>
<p>En un <code>for</code> no pasa, porque el contador lo lleva Python. En un <code>while</code>, sí: asegúrate de haber avanzado <em>antes</em> del <code>continue</code>.</p>

<h3>3. Reutilizar la misma variable en los dos ciclos</h3>
<pre><code>for i in range(3):
    for i in range(3):    # ❌ el interno pisa al externo
        print(i)</code></pre>
<p>Nombres distintos: <code>fila</code> y <code>columna</code>, o <code>i</code> y <code>j</code>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿Ya encontraste lo que buscabas? <code>break</code>.</li>
  <li>¿Este dato no sirve pero los demás sí? <code>continue</code>.</li>
  <li>¿Necesitas avisar que <em>no</em> lo encontraste? <code>else</code> del ciclo.</li>
  <li>En anidados: el de afuera son las filas, el de adentro las columnas, y <code>break</code> solo rompe el suyo.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>break</code></td><td>Sale del ciclo inmediatamente</td></tr>
    <tr><td><code>continue</code></td><td>Salta a la siguiente vuelta</td></tr>
    <tr><td><code>for … else:</code></td><td>El <code>else</code> corre solo si no hubo <code>break</code></td></tr>
    <tr><td><code>print(x, end="  ")</code></td><td>Imprime sin bajar de línea</td></tr>
    <tr><td><code>print()</code></td><td>Baja de línea</td></tr>
  </tbody>
</table>

<blockquote><code>break</code> sale del ciclo que lo contiene y nada más. En un anidado, romper el de adentro deja al de afuera dando vueltas.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 2
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 9 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 9 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Tres intentos de clave', 'facil', '<p>La clave del cajero es <code>1234</code>. Dar al usuario <strong>tres</strong> intentos. Si acierta, mostrar <code>Bienvenido</code> y terminar de inmediato. Si agota los tres, mostrar <code>Tarjeta bloqueada</code>.</p><pre><code>Clave (intento 1): Clave incorrecta
Clave (intento 2): Bienvenido</code></pre>', '<p>Use <code>break</code> al acertar y el <code>else</code> del <code>for</code> para el caso de que nunca se acertó. Ese <code>else</code> se salta si hubo <code>break</code>.</p>', '<pre><code>''''''
Programa: Tres intentos de clave
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Da tres intentos para escribir la clave del cajero y bloquea
    la tarjeta si se agotan.
''''''

# Inicio
CLAVE = "1234"
INTENTOS = 3

for intento in range(1, INTENTOS + 1):
    clave = input(f"Clave (intento {intento}): ").strip()

    if clave == CLAVE:
        print("Bienvenido")
        break

    print("Clave incorrecta")
else:
    # Este bloque solo corre si el for termino SIN break
    print("Tarjeta bloqueada")
# Fin</code></pre><p>El <code>else</code> del ciclo evita tener que llevar una bandera <code>acerto = False</code>. Es una de las pocas cosas que Python tiene y casi ningún otro lenguaje.</p>', '[{"stdin":"0000\n1234\n","expected_output":"Clave (intento 1): Clave incorrecta\nClave (intento 2): Bienvenido"},{"stdin":"1\n2\n3\n","expected_output":"Clave (intento 1): Clave incorrecta\nClave (intento 2): Clave incorrecta\nClave (intento 3): Clave incorrecta\nTarjeta bloqueada"}]', '''''''
Programa: Tres intentos de clave
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CLAVE = "1234"
INTENTOS = 3

# Fin
', 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Ventas ignorando inválidas', 'facil', '<p>Solicitar <strong>5</strong> ventas. Si alguna es negativa, avisar y no sumarla. Al final mostrar el total y cuántas se ignoraron:</p><pre><code>Total: 60000
Ignoradas: 1</code></pre>', '<p>Cuando la venta sea negativa, imprima el aviso, sume al contador de ignoradas y use <code>continue</code> para saltar la suma.</p>', '<pre><code>''''''
Programa: Ventas ignorando invalidas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Suma cinco ventas descartando las que vengan en negativo.
''''''

# Inicio
CUANTAS = 5

total = 0        # sumatoria
ignoradas = 0    # contador

for n in range(1, CUANTAS + 1):
    venta = int(input(f"Venta {n}: "))

    if venta < 0:
        print("Valor invalido, se ignora")
        ignoradas += 1
        continue    # se salta la suma y pasa a la venta siguiente

    total += venta

print(f"Total: {total}")
print(f"Ignoradas: {ignoradas}")
# Fin</code></pre><p><code>continue</code> deja el resto del cuerpo sin ejecutar, así que <code>total += venta</code> ni se toca. Lo mismo se podría hacer con un <code>else</code>, pero cuando el caso raro se descarta de una, <code>continue</code> deja el camino feliz sin indentar de más.</p>', '[{"stdin":"10000\n20000\n-5000\n15000\n15000\n","expected_output":"Venta 1: Venta 2: Venta 3: Valor invalido, se ignora\nVenta 4: Venta 5: Total: 60000\nIgnoradas: 1"}]', '''''''
Programa: Ventas ignorando invalidas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CUANTAS = 5

# Fin
', 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Tabla de multiplicar completa', 'medio', '<p>Mostrar las tablas de multiplicar del <strong>1 al 5</strong>, cada tabla en su propia línea:</p><pre><code>1x1=1  1x2=2  1x3=3  1x4=4  1x5=5
2x1=2  2x2=4  2x3=6  2x4=8  2x5=10
3x1=3  3x2=6  3x3=9  3x4=12  3x5=15
4x1=4  4x2=8  4x3=12  4x4=16  4x5=20
5x1=5  5x2=10  5x3=15  5x4=20  5x5=25</code></pre><p><em>Nota:</em> cada elemento va separado por dos espacios y no debe quedar salto de línea en medio de una fila.</p>', '<p>Dos <code>for</code> anidados: el de afuera es la tabla (la fila) y el de adentro el multiplicador (la columna). Use <code>end="  "</code> en el <code>print()</code> de adentro y un <code>print()</code> pelado al terminar cada fila.</p>', '<pre><code>''''''
Programa: Tablas de multiplicar del 1 al 5
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra en una cuadricula las tablas de multiplicar
    del 1 al 5.
''''''

# Inicio
HASTA = 5

for tabla in range(1, HASTA + 1):
    for multiplicador in range(1, HASTA + 1):
        # end="  " evita el salto de linea: la fila sigue creciendo
        print(f"{tabla}x{multiplicador}={tabla * multiplicador}", end="  ")

    # Al terminar la fila si se baja de linea
    print()
# Fin</code></pre><p>El ciclo de adentro se ejecuta <strong>completo</strong> en cada vuelta del de afuera: 5 tablas × 5 multiplicadores = 25 vueltas del cuerpo interno.</p><p>La posición del <code>print()</code> pelado es lo que hace la cuadrícula. Está indentado al nivel del <code>for</code> interno (dentro del externo, fuera del interno): por eso corre una vez por fila.</p>', '[{"stdin":"","expected_output":"1x1=1  1x2=2  1x3=3  1x4=4  1x5=5\n2x1=2  2x2=4  2x3=6  2x4=8  2x5=10\n3x1=3  3x2=6  3x3=9  3x4=12  3x5=15\n4x1=4  4x2=8  4x3=12  4x4=16  4x5=20\n5x1=5  5x2=10  5x3=15  5x4=20  5x5=25"}]', '''''''
Programa: Tablas de multiplicar del 1 al 5
Autor:
Fecha:
Descripcion:
''''''

# Inicio
HASTA = 5

# Fin
', 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, '¿Es primo?', 'dificil', '<p>Solicitar un número entero mayor que 1 y decir si es primo. Un número es primo si solo se puede dividir exactamente entre 1 y entre sí mismo.</p><pre><code>El 17 es primo</code></pre><pre><code>El 21 no es primo (divisible entre 3)</code></pre><p><em>Nota:</em> apenas encuentre un divisor debe dejar de buscar. No revise más allá de la mitad del número.</p>', '<p>Recorra los posibles divisores desde 2 hasta la mitad. Si alguno divide exacto (<code>numero % d == 0</code>), guarde ese divisor y use <code>break</code>. Use el <code>else</code> del <code>for</code> para el caso "no encontré ninguno".</p>', '<pre><code>''''''
Programa: Verificador de numeros primos
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Indica si un numero mayor que 1 es primo y, si no lo es,
    muestra el primer divisor encontrado.
''''''

# Inicio
numero = int(input("Numero: "))

# Ningun divisor puede ser mayor que la mitad del numero,
# asi que ahi se corta la busqueda
for divisor in range(2, numero // 2 + 1):
    if numero % divisor == 0:
        print(f"El {numero} no es primo (divisible entre {divisor})")
        break
else:
    # Solo llega aqui si el for termino sin encontrar divisores
    print(f"El {numero} es primo")
# Fin</code></pre><p>Tres ideas que valen para muchos problemas de búsqueda:</p><ul><li><strong><code>break</code> al primer hallazgo.</strong> Con 21, el 3 lo delata en la segunda vuelta; revisar hasta el 10 sería trabajo perdido.</li><li><strong>El <code>else</code> del ciclo es el "no encontré nada".</strong> Sin él tocaría una bandera <code>es_primo = True</code> y bajarla dentro del <code>if</code>.</li><li><strong>Cortar en la mitad.</strong> Si <code>numero</code> tuviera un divisor mayor que su mitad, el otro factor sería menor que 2, lo cual es imposible.</li></ul><p>Ojo con el caso del 2 y el 3: <code>range(2, 2)</code> y <code>range(2, 2)</code> quedan vacíos, el ciclo no da vueltas, no hay <code>break</code> y entra por el <code>else</code>. Correcto: 2 y 3 son primos.</p>', '[{"stdin":"17\n","expected_output":"Numero: El 17 es primo"},{"stdin":"21\n","expected_output":"Numero: El 21 no es primo (divisible entre 3)"},{"stdin":"2\n","expected_output":"Numero: El 2 es primo"}]', '''''''
Programa: Verificador de numeros primos
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 9 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace break dentro de un ciclo?', NULL, '{"options":[{"id":"a","text":"Sale del ciclo de inmediato"},{"id":"b","text":"Salta a la siguiente vuelta"},{"id":"c","text":"Reinicia el ciclo desde el principio"},{"id":"d","text":"Termina el programa"}]}', '{"option_id":"a"}', 'break corta el ciclo en seco: ni termina la vuelta ni vuelve a revisar la condición.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace continue?', NULL, '{"options":[{"id":"a","text":"Se salta lo que falta de esta vuelta y pasa a la siguiente"},{"id":"b","text":"Sale del ciclo"},{"id":"c","text":"Repite la misma vuelta otra vez"},{"id":"d","text":"Continúa con la siguiente línea del programa"}]}', '{"option_id":"a"}', 'El ciclo sigue vivo: solo se descarta el resto del cuerpo de esa vuelta.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuándo se ejecuta el else de un ciclo for?', NULL, '{"options":[{"id":"a","text":"Solo si el ciclo terminó sin haber pasado por un break"},{"id":"b","text":"Siempre al terminar el ciclo"},{"id":"c","text":"Cuando la colección está vacía"},{"id":"d","text":"Cada vez que la condición del if falla"}]}', '{"option_id":"a"}', 'Es el bloque del "no lo encontré": evita tener que llevar una bandera.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En dos ciclos anidados, ¿de cuál sale un break que está en el interno?', NULL, '{"options":[{"id":"a","text":"Solo del interno: el externo sigue dando vueltas"},{"id":"b","text":"De los dos"},{"id":"c","text":"Solo del externo"},{"id":"d","text":"Del programa entero"}]}', '{"option_id":"a"}', 'break rompe únicamente el ciclo que lo contiene. Para salir de los dos hace falta una bandera o una función.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Para qué sirve end="  " en un print()?', NULL, '{"options":[{"id":"a","text":"Para que no baje de línea y deje dos espacios en su lugar"},{"id":"b","text":"Para terminar el programa"},{"id":"c","text":"Para poner dos espacios al principio"},{"id":"d","text":"Para cerrar el ciclo"}]}', '{"option_id":"a"}', 'Por defecto print termina en salto de línea. Con end se cambia por lo que uno quiera.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'for n in range(5):
    if n == 2:
        break
    print(n)', '{"options":[{"id":"a","text":"0\n1"},{"id":"b","text":"0\n1\n3\n4"},{"id":"c","text":"0\n1\n2"},{"id":"d","text":"0\n1\n2\n3\n4"}]}', '{"option_id":"a"}', 'Al llegar al 2 sale del ciclo, así que el 3 y el 4 ni se miran.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'for n in range(5):
    if n == 2:
        continue
    print(n)', '{"options":[{"id":"a","text":"0\n1\n3\n4"},{"id":"b","text":"0\n1"},{"id":"c","text":"0\n1\n2\n3\n4"},{"id":"d","text":"2"}]}', '{"option_id":"a"}', 'Solo se salta la vuelta del 2: las demás siguen normales.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'for n in range(3):
    print(n)
else:
    print("listo")', '{"options":[{"id":"a","text":"0\n1\n2\nlisto"},{"id":"b","text":"0\n1\n2"},{"id":"c","text":"listo"},{"id":"d","text":"SyntaxError"}]}', '{"option_id":"a"}', 'No hubo break, así que el else del ciclo sí corre.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'for n in range(3):
    if n == 1:
        break
else:
    print("sin break")
print("fin")', '{"options":[{"id":"a","text":"fin"},{"id":"b","text":"sin break\nfin"},{"id":"c","text":"fin\nsin break"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'Hubo break, así que el else se salta. El print de afuera sí corre.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'for fila in range(1, 4):
    for col in range(1, 4):
        if col == 2:
            break
        print(fila, col)', '{"options":[{"id":"a","text":"1 1\n2 1\n3 1"},{"id":"b","text":"1 1"},{"id":"c","text":"1 1\n1 2\n1 3"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'El break corta solo el ciclo de las columnas; el de las filas sigue y vuelve a entrar tres veces.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este ciclo se queda pegado. ¿En qué línea está el problema?', NULL, '{"lines":["n = 0","while n < 5:","    if n == 2:","        continue","    n += 1"]}', '{"line_number":4}', 'El continue salta el n += 1, así que n se queda en 2 para siempre. En un while hay que avanzar antes del continue.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa debe saltarse los negativos pero suma mal. ¿En qué línea está el error?', NULL, '{"lines":["total = 0","for n in range(3):","    venta = int(input())","    if venta < 0:","        break","    total += venta","print(total)"]}', '{"line_number":5}', 'Ahí va continue, no break: con break el primer negativo acaba el ciclo y las ventas siguientes se pierden.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'La cuadrícula sale toda en una sola línea. ¿En qué línea está el error?', NULL, '{"lines":["for fila in range(1, 4):","    for col in range(1, 4):","        print(fila, col, end=\"  \")","        print()"]}', '{"line_number":4}', 'El print() que baja de línea quedó dentro del ciclo interno: debe estar al nivel del for interno, no adentro.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa de los tres intentos de clave', NULL, '{"lines":[{"id":"l1","text":"CLAVE = \"1234\"","indent":0},{"id":"l2","text":"for intento in range(1, 4):","indent":0},{"id":"l3","text":"clave = input(f\"Clave (intento {intento}): \")","indent":1},{"id":"l4","text":"if clave == CLAVE:","indent":1},{"id":"l5","text":"print(\"Bienvenido\")","indent":2},{"id":"l6","text":"break","indent":2},{"id":"l7","text":"print(\"Clave incorrecta\")","indent":1},{"id":"l8","text":"else:","indent":0},{"id":"l9","text":"print(\"Tarjeta bloqueada\")","indent":1}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7","l8","l9"]}', 'El else del ciclo se alinea con el for, no con el if: por eso solo corre si nunca hubo break.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la cuadrícula de tablas de multiplicar', NULL, '{"lines":[{"id":"l1","text":"for tabla in range(1, 6):","indent":0},{"id":"l2","text":"for mult in range(1, 6):","indent":1},{"id":"l3","text":"print(f\"{tabla}x{mult}={tabla * mult}\", end=\"  \")","indent":2},{"id":"l4","text":"print()","indent":1}]}', '{"order":["l1","l2","l3","l4"]}', 'El print() que baja de línea va al nivel del for interno: corre una vez por fila, cuando el ciclo de columnas ya terminó.', 1, 'seed'
    FROM chapters WHERE number = 9 AND track = 'basico';

-- ── Capítulo 10: Listas (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 10, 'Listas', '📋', 'La estructura de datos que más vas a usar.', '<p class="jc-gancho">Hasta ahora, para guardar cinco notas necesitabas cinco variables. ¿Y si son cuarenta estudiantes? ¿Y si no sabes cuántos son hasta que el usuario termine de escribir? Para eso existen las listas: <strong>una sola variable que guarda muchas cosas</strong>.</p>

<h2>Una lista es una fila de cajas numeradas</h2>

<pre><code>notas = [4.0, 3.5, 2.8, 5.0, 3.2]

print(notas)         # [4.0, 3.5, 2.8, 5.0, 3.2]
print(len(notas))    # 5
print(notas[0])      # 4.0   la primera
print(notas[-1])     # 3.2   la última</code></pre>

<p>Se indexa igual que un texto: desde cero, y con negativos desde atrás. También se rebana:</p>

<pre><code>print(notas[1:3])    # [3.5, 2.8]
print(notas[:2])     # [4.0, 3.5]
print(notas[-2:])    # [5.0, 3.2]</code></pre>

<p>Una lista puede tener de todo, aunque en la práctica casi siempre guarda cosas del mismo tipo:</p>

<pre><code>productos = ["pan", "leche", "queso"]
precios = [5000, 7000, 15000]
vacia = []</code></pre>

<h2>La diferencia grande: las listas SÍ cambian</h2>

<p>Los textos son inmutables: <code>nombre.upper()</code> devuelve uno nuevo. Las listas no: se modifican <strong>en el sitio</strong>.</p>

<pre><code>notas = [4.0, 3.5, 2.8]

notas[2] = 3.0          # cambiar una posición
notas.append(4.5)       # agregar al final
notas.insert(0, 5.0)    # meter en una posición
notas.remove(3.5)       # quitar por VALOR (el primero que encuentre)
ultima = notas.pop()    # sacar la última y quedársela

print(notas)</code></pre>

<table>
  <thead>
    <tr><th>Método</th><th>Qué hace</th><th>Ojo con…</th></tr>
  </thead>
  <tbody>
    <tr><td><code>.append(x)</code></td><td>Agrega al final</td><td>El más usado de todos</td></tr>
    <tr><td><code>.insert(i, x)</code></td><td>Mete en la posición <code>i</code></td><td>Corre todo lo demás</td></tr>
    <tr><td><code>.remove(x)</code></td><td>Quita por valor</td><td><code>ValueError</code> si no está</td></tr>
    <tr><td><code>.pop()</code></td><td>Saca la última y la devuelve</td><td><code>.pop(0)</code> saca la primera</td></tr>
    <tr><td><code>.sort()</code></td><td>Ordena la lista</td><td>Cambia el original, no devuelve nada</td></tr>
    <tr><td><code>.reverse()</code></td><td>Le da vuelta</td><td>También en el sitio</td></tr>
    <tr><td><code>.count(x)</code></td><td>Cuántas veces aparece</td><td></td></tr>
    <tr><td><code>.index(x)</code></td><td>En qué posición está</td><td><code>ValueError</code> si no está</td></tr>
  </tbody>
</table>

<p>Esa diferencia con los textos es la trampa número uno:</p>

<pre><code>nombre = "ana"
nombre.upper()          # ❌ no cambia nada, hay que guardar

notas = [3.0, 1.0]
notas.sort()            # ✅ la lista YA quedó ordenada
notas = notas.sort()    # ❌ ahora notas vale None</code></pre>

<h2>Las funciones que resuelven media tarea</h2>

<pre><code>notas = [4.0, 3.5, 2.8, 5.0, 3.2]

print(len(notas))        # 5      cuántas hay
print(sum(notas))        # 18.5   la suma
print(max(notas))        # 5.0    la mayor
print(min(notas))        # 2.8    la menor
print(sum(notas) / len(notas))   # 3.7  el promedio</code></pre>

<p>Todo lo que en el capítulo 7 hacías con sumatorias y máximos a mano, aquí es una línea. Los ciclos siguen sirviendo cuando la condición es más complicada.</p>

<h2>Recorrer una lista</h2>

<pre><code>productos = ["pan", "leche", "queso"]
precios = [5000, 7000, 15000]

# Solo los valores
for producto in productos:
    print(producto)

# Con la posición, cuando hay dos listas en paralelo
for i in range(len(productos)):
    print(f"{productos[i]}: {precios[i]}")

# Con enumerate, más limpio
for i, producto in enumerate(productos):
    print(f"{i + 1}. {producto} — {precios[i]}")</code></pre>

<p>Y el patrón de siempre —contador, sumatoria, bandera— sigue igual:</p>

<pre><code>caros = 0
total = 0

for precio in precios:
    total += precio
    if precio &gt; 10000:
        caros += 1

print(f"Total: {total}, caros: {caros}")</code></pre>

<h2>La película de una lista que crece</h2>

<p>Este es el patrón que vas a usar toda la vida: una lista vacía que se va llenando.</p>

<pre><code>aprobadas = []                        # nace afuera, vacía
notas = [4.0, 2.5, 3.8, 1.9, 5.0]

for nota in notas:
    if nota &gt;= 3.0:
        aprobadas.append(nota)        # se actualiza adentro

print(aprobadas)</code></pre>

<table>
  <thead>
    <tr><th>Vuelta</th><th><code>nota</code></th><th>¿≥ 3.0?</th><th><code>aprobadas</code> al terminar</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>4.0</td><td>Sí</td><td><code>[4.0]</code></td></tr>
    <tr><td>2</td><td>2.5</td><td>No</td><td><code>[4.0]</code></td></tr>
    <tr><td>3</td><td>3.8</td><td>Sí</td><td><code>[4.0, 3.8]</code></td></tr>
    <tr><td>4</td><td>1.9</td><td>No</td><td><code>[4.0, 3.8]</code></td></tr>
    <tr><td>5</td><td>5.0</td><td>Sí</td><td><code>[4.0, 3.8, 5.0]</code></td></tr>
  </tbody>
</table>

<p>Es la misma regla del capítulo 7: <strong>la lista nace afuera y se llena adentro</strong>. Si <code>aprobadas = []</code> estuviera dentro del <code>for</code>, cada vuelta la vaciaría.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Guardar el resultado de <code>.sort()</code></h3>
<pre><code>notas = notas.sort()   # ❌ notas queda en None
notas.sort()           # ✅</code></pre>
<p>Los métodos que modifican la lista devuelven <code>None</code>. Si necesitas una copia ordenada sin tocar el original, usa <code>sorted(notas)</code>.</p>

<h3>2. Pasarse de índice</h3>
<pre><code>notas = [4.0, 3.5, 2.8]   # posiciones 0, 1, 2
print(notas[3])           # IndexError: list index out of range</code></pre>

<h3>3. Borrar mientras se recorre</h3>
<pre><code>for nota in notas:
    if nota &lt; 3.0:
        notas.remove(nota)   # ❌ se salta elementos</code></pre>
<p>Al quitar un elemento, los de atrás se corren y el ciclo salta uno. Lo correcto es construir una lista nueva con las que sí quieres:</p>
<pre><code>buenas = []
for nota in notas:
    if nota &gt;= 3.0:
        buenas.append(nota)</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Lista vacía antes del ciclo, <code>.append()</code> adentro.</li>
  <li>Para totales rápidos: <code>len()</code>, <code>sum()</code>, <code>max()</code>, <code>min()</code>.</li>
  <li>Si vas a filtrar, construye una lista nueva. Nunca borres mientras recorres.</li>
  <li><code>.sort()</code> ordena en el sitio; <code>sorted()</code> devuelve una copia.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>lista = []</code></td><td>Lista vacía</td></tr>
    <tr><td><code>lista.append(x)</code></td><td>Agrega al final</td></tr>
    <tr><td><code>lista[0]</code> · <code>lista[-1]</code></td><td>Primera · última</td></tr>
    <tr><td><code>len(lista)</code> · <code>sum(lista)</code></td><td>Cuántas · la suma</td></tr>
    <tr><td><code>max(lista)</code> · <code>min(lista)</code></td><td>Mayor · menor</td></tr>
    <tr><td><code>lista.sort()</code></td><td>Ordena en el sitio</td></tr>
    <tr><td><code>sorted(lista)</code></td><td>Devuelve una copia ordenada</td></tr>
    <tr><td><code>x in lista</code></td><td><code>True</code> si está</td></tr>
  </tbody>
</table>

<blockquote>Las listas se modifican en el sitio; los textos no. Por eso <code>lista.sort()</code> se usa solo, y <code>texto.upper()</code> hay que guardarlo.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 3
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 10 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 10 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Estadísticas de notas', 'facil', '<p>Solicitar <strong>5</strong> notas y guardarlas en una lista. Mostrar:</p><pre><code>Notas: [4.0, 3.5, 2.8, 5.0, 3.2]
Promedio: 3.7
Mayor: 5.0
Menor: 2.8</code></pre><p><em>Nota:</em> use las funciones de lista, no ciclos para sumar.</p>', '<p>La lista nace vacía antes del ciclo y crece con <code>.append()</code>. Después, <code>sum()</code>, <code>max()</code> y <code>min()</code> hacen el resto.</p>', '<pre><code>''''''
Programa: Estadisticas de notas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Guarda cinco notas en una lista y muestra promedio,
    nota mayor y nota menor.
''''''

# Inicio
CUANTAS = 5

notas = []     # nace afuera, vacia

for n in range(1, CUANTAS + 1):
    nota = float(input(f"Nota {n}: "))
    notas.append(nota)     # se llena adentro

print(f"Notas: {notas}")
print(f"Promedio: {sum(notas) / len(notas)}")
print(f"Mayor: {max(notas)}")
print(f"Menor: {min(notas)}")
# Fin</code></pre><p>Compare con el capítulo 7: allá había que llevar la sumatoria a mano y buscar el máximo comparando vuelta a vuelta. Con una lista, <code>sum()</code> y <code>max()</code> lo hacen en una línea. El ciclo ahora solo sirve para <strong>llenar</strong> la lista.</p>', '[{"stdin":"4.0\n3.5\n2.8\n5.0\n3.2\n","expected_output":"Nota 1: Nota 2: Nota 3: Nota 4: Nota 5: Notas: [4.0, 3.5, 2.8, 5.0, 3.2]\nPromedio: 3.7\nMayor: 5.0\nMenor: 2.8"}]', '''''''
Programa: Estadisticas de notas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CUANTAS = 5

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Filtrar aprobadas', 'facil', '<p>Dada la lista de notas <code>[4.0, 2.5, 3.8, 1.9, 5.0]</code>, construir dos listas nuevas: una con las aprobadas (nota mayor o igual a 3.0) y otra con las reprobadas. Mostrar:</p><pre><code>Aprobadas: [4.0, 3.8, 5.0]
Reprobadas: [2.5, 1.9]
3 de 5 aprobaron</code></pre><p><em>Nota:</em> no modifique la lista original.</p>', '<p>Dos listas vacías antes del ciclo. Dentro, un <code>if / else</code> decide a cuál se hace <code>.append()</code>.</p>', '<pre><code>''''''
Programa: Filtro de notas aprobadas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Separa una lista de notas en aprobadas y reprobadas sin
    modificar la lista original.
''''''

# Inicio
MINIMA = 3.0

notas = [4.0, 2.5, 3.8, 1.9, 5.0]

aprobadas = []
reprobadas = []

for nota in notas:
    if nota >= MINIMA:
        aprobadas.append(nota)
    else:
        reprobadas.append(nota)

print(f"Aprobadas: {aprobadas}")
print(f"Reprobadas: {reprobadas}")
print(f"{len(aprobadas)} de {len(notas)} aprobaron")
# Fin</code></pre><p>Construir listas nuevas en vez de borrar de la original es la forma correcta de filtrar. Si dentro del <code>for</code> se hiciera <code>notas.remove(nota)</code>, al quitar un elemento los de atrás se corren y el ciclo se saltaría uno.</p>', '[{"stdin":"","expected_output":"Aprobadas: [4.0, 3.8, 5.0]\nReprobadas: [2.5, 1.9]\n3 de 5 aprobaron"}]', '''''''
Programa: Filtro de notas aprobadas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
MINIMA = 3.0
notas = [4.0, 2.5, 3.8, 1.9, 5.0]

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Inventario de la tienda', 'medio', '<p>Se tienen dos listas en paralelo:</p><pre><code>productos = ["pan", "leche", "queso", "cafe"]
precios = [5000, 7000, 15000, 12000]</code></pre><p>Mostrar el inventario numerado, el total y cuáles cuestan más de 10000:</p><pre><code>1. pan            5,000
2. leche          7,000
3. queso         15,000
4. cafe          12,000
Total: 39,000
Caros: [''queso'', ''cafe'']</code></pre><p><em>Nota:</em> el nombre va alineado a la izquierda en 12 espacios y el precio a la derecha en 8, con separador de miles.</p>', '<p>Dos listas en paralelo se recorren con <code>enumerate()</code> o con <code>range(len(...))</code>: la posición <code>i</code> sirve para las dos.</p>', '<pre><code>''''''
Programa: Inventario de la tienda
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra el inventario con precios alineados, el total y
    la lista de productos que cuestan mas de 10000.
''''''

# Inicio
CARO = 10000

productos = ["pan", "leche", "queso", "cafe"]
precios = [5000, 7000, 15000, 12000]

caros = []

# Dos listas en paralelo: la misma posicion i sirve para las dos
for i, producto in enumerate(productos):
    precio = precios[i]
    print(f"{i + 1}. {producto:<12}{precio:>8,}")

    if precio > CARO:
        caros.append(producto)

print(f"Total: {sum(precios):,}")
print(f"Caros: {caros}")
# Fin</code></pre><p>Dos listas en paralelo funcionan mientras se mantengan sincronizadas: el producto de la posición 2 va con el precio de la posición 2. Es frágil —si alguien agrega un producto y olvida el precio, todo se desalinea— y por eso en el capítulo 12 aparecen los diccionarios, que guardan la pareja junta.</p>', '[{"stdin":"","expected_output":"1. pan            5,000\n2. leche          7,000\n3. queso         15,000\n4. cafe          12,000\nTotal: 39,000\nCaros: [''queso'', ''cafe'']"}]', '''''''
Programa: Inventario de la tienda
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CARO = 10000
productos = ["pan", "leche", "queso", "cafe"]
precios = [5000, 7000, 15000, 12000]

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Podio de ventas', 'dificil', '<p>Solicitar las ventas de <strong>7</strong> vendedores (una por línea). Mostrar el podio de los tres mejores, con su número de vendedor original:</p><pre><code>1. Vendedor 4 - 250,000
2. Vendedor 1 - 180,000
3. Vendedor 6 - 150,000
Total del equipo: 800,000
Sobre el promedio: 3 vendedores</code></pre><p><em>Nota:</em> el número de vendedor es su posición original (de 1 a 7), aunque la lista se ordene.</p>', '<p>Si ordena la lista de ventas pierde quién era quién. Guarde parejas: una lista de listas <code>[venta, numero]</code>. Al ordenarla, Python compara primero el primer elemento de cada pareja.</p>', '<pre><code>''''''
Programa: Podio de ventas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide las ventas de siete vendedores y muestra el podio de
    los tres mejores, el total del equipo y cuantos estan sobre
    el promedio.
''''''

# Inicio
VENDEDORES = 7
PODIO = 3

ventas = []      # solo los numeros, para las cuentas
parejas = []     # [venta, numero de vendedor], para el podio

for n in range(1, VENDEDORES + 1):
    venta = int(input(f"Ventas del vendedor {n}: "))
    ventas.append(venta)
    parejas.append([venta, n])

# Al ordenar parejas, Python compara primero la venta.
# reverse=True deja de mayor a menor.
parejas.sort(reverse=True)

for puesto in range(PODIO):
    venta, numero = parejas[puesto]
    print(f"{puesto + 1}. Vendedor {numero} - {venta:,}")

total = sum(ventas)
promedio = total / VENDEDORES

sobre_promedio = 0
for venta in ventas:
    if venta > promedio:
        sobre_promedio += 1

print(f"Total del equipo: {total:,}")
print(f"Sobre el promedio: {sobre_promedio} vendedores")
# Fin</code></pre><p>La idea clave: <strong>si vas a ordenar, guarda el dato junto con su identidad</strong>. Ordenar solo las ventas destruye la información de quién vendió qué.</p><p><code>venta, numero = parejas[puesto]</code> es <em>desempaquetado</em>: una lista de dos elementos se reparte en dos variables de una sola línea. Se usa muchísimo y vuelve a aparecer en el capítulo 11.</p><p>Y ojo con el orden: el promedio necesita el total completo, así que la comparación va <strong>después</strong> del ciclo que llena la lista, no adentro.</p>', '[{"stdin":"180000\n90000\n50000\n250000\n30000\n150000\n50000\n","expected_output":"Ventas del vendedor 1: Ventas del vendedor 2: Ventas del vendedor 3: Ventas del vendedor 4: Ventas del vendedor 5: Ventas del vendedor 6: Ventas del vendedor 7: 1. Vendedor 4 - 250,000\n2. Vendedor 1 - 180,000\n3. Vendedor 6 - 150,000\nTotal del equipo: 800,000\nSobre el promedio: 3 vendedores"}]', '''''''
Programa: Podio de ventas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
VENDEDORES = 7
PODIO = 3

# Fin
', 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 10 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cómo se crea una lista vacía?', NULL, '{"options":[{"id":"a","text":"lista = []"},{"id":"b","text":"lista = ()"},{"id":"c","text":"lista = {}"},{"id":"d","text":"lista = \"\""}]}', '{"option_id":"a"}', 'Los corchetes son de listas. Los paréntesis hacen una tupla y las llaves un diccionario.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué método agrega un elemento al final de una lista?', NULL, '{"options":[{"id":"a","text":".append(x)"},{"id":"b","text":".add(x)"},{"id":"c","text":".insert(x)"},{"id":"d","text":".push(x)"}]}', '{"option_id":"a"}', 'append es el método más usado de todos. insert existe pero necesita también la posición.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál es la diferencia entre lista.sort() y sorted(lista)?', NULL, '{"options":[{"id":"a","text":"sort() ordena la lista original; sorted() devuelve una copia ordenada"},{"id":"b","text":"Son idénticos"},{"id":"c","text":"sort() solo funciona con números"},{"id":"d","text":"sorted() ordena al revés"}]}', '{"option_id":"a"}', 'sort() modifica en el sitio y devuelve None. Si necesitas conservar el original, usa sorted().', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué no se debe borrar elementos mientras se recorre una lista?', NULL, '{"options":[{"id":"a","text":"Porque al quitar uno, los de atrás se corren y el ciclo se salta elementos"},{"id":"b","text":"Porque Python lanza un error de sintaxis"},{"id":"c","text":"Porque las listas no se pueden modificar"},{"id":"d","text":"Porque el ciclo se vuelve infinito"}]}', '{"option_id":"a"}', 'Lo correcto es construir una lista nueva con los elementos que sí se quieren conservar.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Se quieren guardar ventas y saber después quién vendió cada una, pero hay que ordenarlas. ¿Qué conviene?', NULL, '{"options":[{"id":"a","text":"Guardar parejas [venta, vendedor] y ordenar esa lista"},{"id":"b","text":"Ordenar solo las ventas y recordar el orden de memoria"},{"id":"c","text":"Usar dos listas y ordenar las dos por separado"},{"id":"d","text":"No se puede: hay que dejarlas sin ordenar"}]}', '{"option_id":"a"}', 'Ordenar dos listas por separado las desincroniza. Si el dato va a moverse, su identidad tiene que viajar con él.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'notas = [4.0, 3.5, 2.8]
print(notas[0], notas[-1])', '{"options":[{"id":"a","text":"4.0 2.8"},{"id":"b","text":"4.0 3.5"},{"id":"c","text":"3.5 2.8"},{"id":"d","text":"IndexError"}]}', '{"option_id":"a"}', 'Igual que en los textos: [0] es el primero y [-1] el último.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'notas = [4.0, 3.0, 5.0]
print(sum(notas) / len(notas))', '{"options":[{"id":"a","text":"4.0"},{"id":"b","text":"12.0"},{"id":"c","text":"3.0"},{"id":"d","text":"5.0"}]}', '{"option_id":"a"}', '12.0 dividido entre 3 da 4.0: es el promedio en una sola línea.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'notas = [3.0, 1.0, 2.0]
notas = notas.sort()
print(notas)', '{"options":[{"id":"a","text":"None"},{"id":"b","text":"[1.0, 2.0, 3.0]"},{"id":"c","text":"[3.0, 1.0, 2.0]"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'sort() ordena en el sitio y devuelve None. Al reasignar, se pierde la lista.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'productos = ["pan", "leche"]
productos.append("queso")
productos.insert(0, "cafe")
print(productos)', '{"options":[{"id":"a","text":"[''cafe'', ''pan'', ''leche'', ''queso'']"},{"id":"b","text":"[''pan'', ''leche'', ''queso'', ''cafe'']"},{"id":"c","text":"[''cafe'', ''queso'', ''pan'', ''leche'']"},{"id":"d","text":"[''pan'', ''leche'', ''cafe'', ''queso'']"}]}', '{"option_id":"a"}', 'append pone al final; insert(0, x) mete al principio y corre todo lo demás.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'notas = [4.0, 2.5, 3.8]
buenas = []
for nota in notas:
    if nota >= 3.0:
        buenas.append(nota)
print(buenas)', '{"options":[{"id":"a","text":"[4.0, 3.8]"},{"id":"b","text":"[4.0, 2.5, 3.8]"},{"id":"c","text":"[2.5]"},{"id":"d","text":"[]"}]}', '{"option_id":"a"}', 'Es el patrón de filtrado: lista vacía afuera y append adentro solo cuando se cumple la condición.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'parejas = [[100, 1], [300, 2], [200, 3]]
parejas.sort(reverse=True)
print(parejas[0])', '{"options":[{"id":"a","text":"[300, 2]"},{"id":"b","text":"[100, 1]"},{"id":"c","text":"[200, 3]"},{"id":"d","text":"[3, 300]"}]}', '{"option_id":"a"}', 'Al ordenar listas de listas, Python compara primero el primer elemento. Con reverse=True queda de mayor a menor.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'notas = [1.0, 2.0, 3.0, 4.0]
for nota in notas:
    if nota < 3.0:
        notas.remove(nota)
print(notas)', '{"options":[{"id":"a","text":"[2.0, 3.0, 4.0]"},{"id":"b","text":"[3.0, 4.0]"},{"id":"c","text":"[1.0, 2.0, 3.0, 4.0]"},{"id":"d","text":"[]"}]}', '{"option_id":"a"}', 'Al borrar el 1.0 todo se corre y el ciclo salta el 2.0. Por eso nunca se borra mientras se recorre.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe llenar la lista con cinco notas. ¿En qué línea está el error?', NULL, '{"lines":["for n in range(5):","    notas = []","    notas.append(float(input()))","print(notas)"]}', '{"line_number":2}', 'La lista nace dentro del ciclo y cada vuelta la vacía. Esa línea va antes del for.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa debe mostrar la lista ordenada. ¿En qué línea está el error?', NULL, '{"lines":["notas = [3.0, 1.0, 2.0]","notas = notas.sort()","print(notas)"]}', '{"line_number":2}', 'sort() devuelve None. Basta con escribir notas.sort() sin asignar.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que guarda cinco notas y muestra el promedio', NULL, '{"lines":[{"id":"l1","text":"notas = []","indent":0},{"id":"l2","text":"for n in range(1, 6):","indent":0},{"id":"l3","text":"nota = float(input(f\"Nota {n}: \"))","indent":1},{"id":"l4","text":"notas.append(nota)","indent":1},{"id":"l5","text":"print(f\"Promedio: {sum(notas) / len(notas)}\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'La lista nace vacía antes del ciclo, se llena adentro, y el promedio se calcula al final con la lista completa.', 1, 'seed'
    FROM chapters WHERE number = 10 AND track = 'basico';

-- ── Capítulo 11: Tuplas y sets (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 11, 'Tuplas y sets', '🎯', 'Datos inmutables y colecciones sin repetidos.', '<p class="jc-gancho">Las coordenadas de una sucursal no deberían poder cambiarse por accidente. Y la lista de cédulas que entraron hoy no debería tener repetidos. Las listas no resuelven ninguna de las dos: para eso están las tuplas y los sets.</p>

<h2>Tuplas: listas que no se pueden tocar</h2>

<p>Una tupla se escribe con paréntesis y funciona igual que una lista… salvo que <strong>no se puede modificar</strong>.</p>

<pre><code>punto = (4.6, -74.1)          # latitud y longitud de Bogotá
colores = ("rojo", "azul")

print(punto[0])               # 4.6
print(len(colores))           # 2

punto[0] = 10                 # TypeError: ''tuple'' object does not support item assignment</code></pre>

<p>Eso que parece una limitación es la gracia: si un dato no debe cambiar, una tupla lo garantiza. Nadie va a borrarlo por error tres funciones más adelante.</p>

<table>
  <thead>
    <tr><th></th><th>Lista</th><th>Tupla</th></tr>
  </thead>
  <tbody>
    <tr><td>Se escribe</td><td><code>[1, 2, 3]</code></td><td><code>(1, 2, 3)</code></td></tr>
    <tr><td>¿Se puede cambiar?</td><td>Sí</td><td>No</td></tr>
    <tr><td>Se usa para</td><td>Cosas que crecen y se filtran</td><td>Datos fijos que van juntos</td></tr>
    <tr><td>Ejemplo</td><td>Las notas del curso</td><td>Una coordenada, una fecha</td></tr>
  </tbody>
</table>

<h3>Desempaquetado: la razón por la que se usan tanto</h3>

<pre><code>persona = ("Ana", 17, "Bogotá")

nombre, edad, ciudad = persona     # tres variables de un tirón
print(nombre)   # Ana
print(ciudad)   # Bogotá</code></pre>

<p>Funciona también con listas y es lo que permite el truco más elegante de Python:</p>

<pre><code>a = 1
b = 2
a, b = b, a      # intercambiar sin variable temporal
print(a, b)      # 2 1</code></pre>

<p>Y es lo que hace que <code>enumerate()</code> se vea tan bien: entrega tuplas de dos, y el <code>for</code> las desempaqueta.</p>

<pre><code>for i, letra in enumerate("Cali"):
    print(i, letra)</code></pre>

<p>Una tupla de un solo elemento necesita una coma final, o Python cree que es solo un paréntesis:</p>

<pre><code>uno = (5,)     # tupla de un elemento
no_es = (5)    # esto es el número 5, no una tupla</code></pre>

<h2>Sets: colecciones sin repetidos</h2>

<p>Un set se escribe con llaves y tiene dos superpoderes: <strong>no admite duplicados</strong> y <strong>busca instantáneamente</strong>.</p>

<pre><code>cedulas = {"1023", "1045", "1023", "1088"}
print(cedulas)         # {''1023'', ''1045'', ''1088''} — el repetido desapareció
print(len(cedulas))    # 3</code></pre>

<p>El uso más común es quitarle los repetidos a una lista:</p>

<pre><code>visitas = ["1023", "1045", "1023", "1088", "1045"]
unicas = set(visitas)

print(f"{len(visitas)} visitas de {len(unicas)} personas distintas")</code></pre>

<p>Métodos principales:</p>

<pre><code>s = {"pan", "leche"}

s.add("queso")        # agrega (si ya está, no hace nada)
s.discard("pan")      # quita sin quejarse si no está
print("leche" in s)   # True — y esta búsqueda es MUY rápida</code></pre>

<p>Dos advertencias importantes:</p>

<ul>
  <li><strong>Un set no tiene orden.</strong> No existe <code>s[0]</code>. Si necesitas orden, conviértelo: <code>sorted(s)</code>.</li>
  <li><strong>El set vacío es <code>set()</code>, no <code>{}</code></strong>. Las llaves vacías son un diccionario (capítulo 12).</li>
</ul>

<h3>Operaciones de conjuntos</h3>

<p>Esto es lo que en el colegio dibujaban con círculos:</p>

<pre><code>lunes = {"ana", "juan", "sofia"}
martes = {"juan", "sofia", "pedro"}

print(lunes | martes)   # unión: todos            {ana, juan, sofia, pedro}
print(lunes &amp; martes)   # intersección: los dos días  {juan, sofia}
print(lunes - martes)   # solo el lunes           {ana}</code></pre>

<p>Resolver "quiénes vinieron los dos días" con listas serían dos ciclos anidados. Con sets es un símbolo.</p>

<h2>La película de una deduplicación</h2>

<pre><code>visitas = ["1023", "1045", "1023", "1088"]
vistas = set()          # nace afuera, vacío
repetidas = 0

for cedula in visitas:
    if cedula in vistas:
        repetidas += 1
    else:
        vistas.add(cedula)</code></pre>

<table>
  <thead>
    <tr><th>Vuelta</th><th><code>cedula</code></th><th>¿ya estaba?</th><th><code>vistas</code></th><th><code>repetidas</code></th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>1023</td><td>No</td><td>{1023}</td><td>0</td></tr>
    <tr><td>2</td><td>1045</td><td>No</td><td>{1023, 1045}</td><td>0</td></tr>
    <tr><td>3</td><td>1023</td><td><strong>Sí</strong></td><td>{1023, 1045}</td><td>1</td></tr>
    <tr><td>4</td><td>1088</td><td>No</td><td>{1023, 1045, 1088}</td><td>1</td></tr>
  </tbody>
</table>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Intentar modificar una tupla</h3>
<pre><code>punto = (4.6, -74.1)
punto[0] = 5      # TypeError</code></pre>
<p>Si el dato tiene que cambiar, era una lista desde el principio.</p>

<h3>2. Creer que <code>{}</code> es un set vacío</h3>
<pre><code>s = {}            # ❌ esto es un diccionario
s = set()         # ✅</code></pre>

<h3>3. Pedirle una posición a un set</h3>
<pre><code>s = {"a", "b"}
print(s[0])       # TypeError: ''set'' object is not subscriptable</code></pre>
<p>Los sets no tienen orden. Si lo necesitas: <code>sorted(s)[0]</code>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿El dato va a cambiar? Lista. ¿Es fijo y va junto? Tupla.</li>
  <li>¿Te importan los repetidos o buscas mucho? Set.</li>
  <li>Para quitar duplicados: <code>set(mi_lista)</code>, y <code>sorted()</code> si quieres orden.</li>
  <li>Comparar dos grupos: <code>|</code>, <code>&amp;</code>, <code>-</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>t = (1, 2)</code></td><td>Tupla: no se puede cambiar</td></tr>
    <tr><td><code>a, b = t</code></td><td>Desempaqueta en dos variables</td></tr>
    <tr><td><code>a, b = b, a</code></td><td>Intercambia sin variable extra</td></tr>
    <tr><td><code>s = set()</code></td><td>Set vacío (¡no <code>{}</code>!)</td></tr>
    <tr><td><code>set(lista)</code></td><td>Quita los repetidos</td></tr>
    <tr><td><code>s.add(x)</code> · <code>s.discard(x)</code></td><td>Agregar · quitar</td></tr>
    <tr><td><code>a | b</code> · <code>a &amp; b</code> · <code>a - b</code></td><td>Unión · comunes · solo en a</td></tr>
  </tbody>
</table>

<blockquote>Lista si va a cambiar, tupla si es fija, set si no quieres repetidos. Escoger bien la estructura resuelve la mitad del problema antes de escribir el primer ciclo.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 3
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 11 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 11 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Ficha con desempaquetado', 'facil', '<p>Dada la tupla <code>persona = ("Ana", 17, "Bogota")</code>, desempaquetarla en tres variables y mostrar:</p><pre><code>Ana, de 17 anios, vive en Bogota</code></pre><p><em>Nota:</em> no use índices; use desempaquetado.</p>', '<p><code>nombre, edad, ciudad = persona</code> reparte los tres valores en una sola línea. El número de variables debe coincidir con el de elementos.</p>', '<pre><code>''''''
Programa: Ficha con desempaquetado
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Desempaqueta una tupla con los datos de una persona y los
    muestra en una frase.
''''''

# Inicio
persona = ("Ana", 17, "Bogota")

# Desempaquetado: tres variables de un tiron
nombre, edad, ciudad = persona

print(f"{nombre}, de {edad} anios, vive en {ciudad}")
# Fin</code></pre><p>Con índices habría que escribir <code>persona[0]</code>, <code>persona[1]</code> y <code>persona[2]</code>, que no dice nada sobre qué es cada uno. El desempaquetado les pone nombre.</p>', '[{"stdin":"","expected_output":"Ana, de 17 anios, vive en Bogota"}]', '''''''
Programa: Ficha con desempaquetado
Autor:
Fecha:
Descripcion:
''''''

# Inicio
persona = ("Ana", 17, "Bogota")

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Visitantes únicos', 'facil', '<p>Dada la lista de cédulas que registró la portería hoy:</p><pre><code>visitas = ["1023", "1045", "1023", "1088", "1045", "1023"]</code></pre><p>Mostrar cuántos registros hubo, cuántas personas distintas entraron y la lista de cédulas ordenada:</p><pre><code>Registros: 6
Personas distintas: 3
Cedulas: [''1023'', ''1045'', ''1088'']</code></pre>', '<p><code>set(visitas)</code> elimina los repetidos. Como un set no tiene orden, use <code>sorted()</code> para mostrarlo.</p>', '<pre><code>''''''
Programa: Visitantes unicos
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Cuenta cuantas personas distintas entraron a partir del
    registro de la porteria.
''''''

# Inicio
visitas = ["1023", "1045", "1023", "1088", "1045", "1023"]

# Un set no admite repetidos: los duplicados desaparecen solos
unicas = set(visitas)

print(f"Registros: {len(visitas)}")
print(f"Personas distintas: {len(unicas)}")
print(f"Cedulas: {sorted(unicas)}")
# Fin</code></pre><p>Sin sets tocaría un ciclo con una lista auxiliar y un <code>if cedula not in vistas</code>. Con un set es una línea, y además la búsqueda interna es mucho más rápida.</p><p><code>sorted()</code> se usa porque un set <strong>no tiene orden</strong>: imprimirlo directo daría un orden impredecible.</p>', '[{"stdin":"","expected_output":"Registros: 6\nPersonas distintas: 3\nCedulas: [''1023'', ''1045'', ''1088'']"}]', '''''''
Programa: Visitantes unicos
Autor:
Fecha:
Descripcion:
''''''

# Inicio
visitas = ["1023", "1045", "1023", "1088", "1045", "1023"]

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Asistencia de dos días', 'medio', '<p>Dos listas con los asistentes a un taller:</p><pre><code>lunes = ["ana", "juan", "sofia", "ana"]
martes = ["juan", "sofia", "pedro"]</code></pre><p>Mostrar, siempre ordenado alfabéticamente:</p><pre><code>Los dos dias: [''juan'', ''sofia'']
Solo el lunes: [''ana'']
Solo el martes: [''pedro'']
En total asistieron: 4 personas</code></pre>', '<p>Convierta las dos listas a sets y use los operadores de conjuntos: <code>&amp;</code> para los comunes, <code>-</code> para la diferencia y <code>|</code> para la unión.</p>', '<pre><code>''''''
Programa: Asistencia de dos dias
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Compara la asistencia de dos dias de taller usando
    operaciones de conjuntos.
''''''

# Inicio
lunes = ["ana", "juan", "sofia", "ana"]
martes = ["juan", "sofia", "pedro"]

# Los sets quitan los repetidos y permiten comparar grupos
grupo_lunes = set(lunes)
grupo_martes = set(martes)

print(f"Los dos dias: {sorted(grupo_lunes & grupo_martes)}")
print(f"Solo el lunes: {sorted(grupo_lunes - grupo_martes)}")
print(f"Solo el martes: {sorted(grupo_martes - grupo_lunes)}")
print(f"En total asistieron: {len(grupo_lunes | grupo_martes)} personas")
# Fin</code></pre><p>Los tres operadores en una frase:</p><table><thead><tr><th>Operador</th><th>Pregunta</th></tr></thead><tbody><tr><td><code>&amp;</code></td><td>¿Quiénes están en los dos?</td></tr><tr><td><code>-</code></td><td>¿Quiénes están en el primero pero no en el segundo?</td></tr><tr><td><code>|</code></td><td>¿Quiénes están en alguno de los dos?</td></tr></tbody></table><p>Resolver esto con listas serían tres ciclos anidados y una lista auxiliar por cada pregunta.</p>', '[{"stdin":"","expected_output":"Los dos dias: [''juan'', ''sofia'']\nSolo el lunes: [''ana'']\nSolo el martes: [''pedro'']\nEn total asistieron: 4 personas"}]', '''''''
Programa: Asistencia de dos dias
Autor:
Fecha:
Descripcion:
''''''

# Inicio
lunes = ["ana", "juan", "sofia", "ana"]
martes = ["juan", "sofia", "pedro"]

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Auditoría de transacciones', 'dificil', '<p>Un sistema bancario registra transacciones como tuplas <code>(codigo, cliente, monto)</code>. Por un error del servidor, algunas quedaron duplicadas.</p><pre><code>movimientos = [
    ("T1", "ana", 50000),
    ("T2", "juan", 120000),
    ("T1", "ana", 50000),
    ("T3", "sofia", 80000),
    ("T2", "juan", 120000),
]</code></pre><p>Mostrar el informe de auditoría:</p><pre><code>Registros recibidos: 5
Transacciones validas: 3
Duplicados descartados: 2
Total real: 250000
Clientes: [''ana'', ''juan'', ''sofia'']</code></pre><p><em>Nota:</em> una transacción está duplicada si su código ya apareció antes. Conserve la primera.</p>', '<p>Lleve un set de códigos ya vistos. En cada vuelta, si el código está en el set es duplicado; si no, se procesa y se agrega al set. Es el mismo patrón de bandera, pero con memoria.</p>', '<pre><code>''''''
Programa: Auditoria de transacciones
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Descarta transacciones duplicadas por codigo y calcula el
    total real del dia junto con la lista de clientes.
''''''

# Inicio
movimientos = [
    ("T1", "ana", 50000),
    ("T2", "juan", 120000),
    ("T1", "ana", 50000),
    ("T3", "sofia", 80000),
    ("T2", "juan", 120000),
]

codigos_vistos = set()   # memoria de lo ya procesado
clientes = set()         # sin repetidos por definicion
total = 0                # sumatoria
duplicados = 0           # contador

for codigo, cliente, monto in movimientos:
    if codigo in codigos_vistos:
        # Ya se proceso: se descarta y no se suma
        duplicados += 1
        continue

    codigos_vistos.add(codigo)
    clientes.add(cliente)
    total += monto

print(f"Registros recibidos: {len(movimientos)}")
print(f"Transacciones validas: {len(codigos_vistos)}")
print(f"Duplicados descartados: {duplicados}")
print(f"Total real: {total}")
print(f"Clientes: {sorted(clientes)}")
# Fin</code></pre><p>Tres cosas que se juntan aquí:</p><ul><li><strong>Desempaquetado en el <code>for</code>.</strong> <code>for codigo, cliente, monto in movimientos</code> reparte cada tupla en tres variables con nombre. Mucho más legible que <code>m[0]</code>, <code>m[1]</code>, <code>m[2]</code>.</li><li><strong>El set como memoria.</strong> <code>codigos_vistos</code> recuerda lo ya procesado. Preguntar <code>in</code> sobre un set es rapidísimo, incluso con millones de registros; sobre una lista sería lento.</li><li><strong><code>continue</code> para el caso raro.</strong> El duplicado se descarta de una y el camino feliz queda sin indentar de más.</li></ul>', '[{"stdin":"","expected_output":"Registros recibidos: 5\nTransacciones validas: 3\nDuplicados descartados: 2\nTotal real: 250000\nClientes: [''ana'', ''juan'', ''sofia'']"}]', '''''''
Programa: Auditoria de transacciones
Autor:
Fecha:
Descripcion:
''''''

# Inicio
movimientos = [
    ("T1", "ana", 50000),
    ("T2", "juan", 120000),
    ("T1", "ana", 50000),
    ("T3", "sofia", 80000),
    ("T2", "juan", 120000),
]

# Fin
', 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 11 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la diferencia principal entre una lista y una tupla?', NULL, '{"options":[{"id":"a","text":"La tupla no se puede modificar después de creada"},{"id":"b","text":"La tupla solo guarda números"},{"id":"c","text":"La lista no admite repetidos"},{"id":"d","text":"La tupla no tiene índices"}]}', '{"option_id":"a"}', 'Si el dato es fijo (una coordenada, una fecha), la tupla garantiza que nadie lo cambie por accidente.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cómo se crea un set vacío?', NULL, '{"options":[{"id":"a","text":"s = set()"},{"id":"b","text":"s = {}"},{"id":"c","text":"s = []"},{"id":"d","text":"s = ()"}]}', '{"option_id":"a"}', 'Las llaves vacías crean un diccionario, no un set. Es una de las trampas clásicas de Python.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Para qué sirve set(mi_lista)?', NULL, '{"options":[{"id":"a","text":"Para quitar los elementos repetidos"},{"id":"b","text":"Para ordenar la lista"},{"id":"c","text":"Para convertirla en texto"},{"id":"d","text":"Para contar cuántos elementos tiene"}]}', '{"option_id":"a"}', 'Un set no admite duplicados, así que convertir una lista los elimina de una.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué devuelve lunes & martes si ambos son sets?', NULL, '{"options":[{"id":"a","text":"Los elementos que están en los dos"},{"id":"b","text":"Todos los elementos de ambos"},{"id":"c","text":"Los que están solo en lunes"},{"id":"d","text":"True o False"}]}', '{"option_id":"a"}', '& es la intersección. | es la unión y - la diferencia.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué se usa un set como memoria de "lo ya visto" en vez de una lista?', NULL, '{"options":[{"id":"a","text":"Porque preguntar si algo está en un set es muchísimo más rápido"},{"id":"b","text":"Porque las listas no aceptan el operador in"},{"id":"c","text":"Porque los sets se ordenan solos"},{"id":"d","text":"Porque un set ocupa menos memoria siempre"}]}', '{"option_id":"a"}', 'Buscar en una lista obliga a recorrerla entera; en un set es prácticamente instantáneo.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'cedulas = {"1023", "1045", "1023"}
print(len(cedulas))', '{"options":[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"1"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'El 1023 repetido desaparece: un set guarda cada valor una sola vez.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'a = 1
b = 2
a, b = b, a
print(a, b)', '{"options":[{"id":"a","text":"2 1"},{"id":"b","text":"1 2"},{"id":"c","text":"2 2"},{"id":"d","text":"1 1"}]}', '{"option_id":"a"}', 'Python arma la tupla del lado derecho primero y después la desempaqueta: intercambia sin variable temporal.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'persona = ("Ana", 17)
nombre, edad = persona
print(nombre, edad + 1)', '{"options":[{"id":"a","text":"Ana 18"},{"id":"b","text":"Ana 17"},{"id":"c","text":"(''Ana'', 17) 18"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'El desempaquetado reparte los dos valores; la tupla no cambia, pero sus valores sí se pueden usar.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'a = {"ana", "juan"}
b = {"juan", "pedro"}
print(sorted(a - b))', '{"options":[{"id":"a","text":"[''ana'']"},{"id":"b","text":"[''juan'']"},{"id":"c","text":"[''ana'', ''pedro'']"},{"id":"d","text":"[''ana'', ''juan'', ''pedro'']"}]}', '{"option_id":"a"}', 'a - b son los que están en a pero no en b: juan está en los dos, así que sale.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa debe crear un set vacío. ¿En qué línea está el error?', NULL, '{"lines":["vistos = {}","vistos.add(\"1023\")","print(vistos)"]}', '{"line_number":1}', '{} crea un diccionario. El set vacío se escribe set().', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["punto = (4.6, -74.1)","punto[0] = 5.0","print(punto)"]}', '{"line_number":2}', 'Las tuplas no se pueden modificar. Si el dato tenía que cambiar, debía ser una lista.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que cuenta visitantes únicos', NULL, '{"lines":[{"id":"l1","text":"visitas = [\"1023\", \"1045\", \"1023\"]","indent":0},{"id":"l2","text":"unicas = set(visitas)","indent":0},{"id":"l3","text":"print(f\"Registros: {len(visitas)}\")","indent":0},{"id":"l4","text":"print(f\"Personas: {len(unicas)}\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'Primero los datos, después la conversión a set que quita repetidos, y al final los dos conteos.', 1, 'seed'
    FROM chapters WHERE number = 11 AND track = 'basico';

-- ── Capítulo 12: Diccionarios (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 12, 'Diccionarios', '🗂️', 'Guardar información con clave y valor.', '<p class="jc-gancho">En el capítulo 10 guardaste el inventario en dos listas paralelas: productos y precios. Funciona hasta que alguien agrega un producto y olvida el precio, y todo se desalinea. Un diccionario guarda la pareja junta, para siempre.</p>

<h2>Clave y valor: la agenda telefónica</h2>

<p>Un diccionario guarda parejas <strong>clave → valor</strong>. La clave es por lo que buscas; el valor es lo que encuentras.</p>

<pre><code>precios = {
    "pan": 5000,
    "leche": 7000,
    "queso": 15000,
}

print(precios["leche"])     # 7000
print(len(precios))         # 3</code></pre>

<p>La diferencia con una lista es que no buscas por <em>posición</em>, sino por <em>nombre</em>. En una agenda no buscas "el contacto número 47": buscas "Ana".</p>

<pre><code># Con listas paralelas (frágil)
productos = ["pan", "leche"]
precios_lista = [5000, 7000]
print(precios_lista[productos.index("leche")])   # incómodo

# Con diccionario (directo)
print(precios["leche"])</code></pre>

<h2>Crear, leer, cambiar y borrar</h2>

<pre><code>precios = {}                    # vacío

precios["pan"] = 5000           # crear
precios["leche"] = 7000
precios["pan"] = 5500           # cambiar (la clave ya existía)

print(precios["pan"])           # leer -> 5500
del precios["leche"]            # borrar

print(precios)                  # {''pan'': 5500}</code></pre>

<p>Una clave nunca se repite: asignarle un valor otra vez lo reemplaza. Eso es exactamente lo que se quiere en un inventario.</p>

<h3>Leer sin que reviente: <code>.get()</code></h3>

<pre><code>print(precios["arroz"])            # KeyError: ''arroz''
print(precios.get("arroz"))        # None — no se cae
print(precios.get("arroz", 0))     # 0 — valor por defecto</code></pre>

<p><code>.get()</code> con valor por defecto es la herramienta que hace elegante el conteo, como verás abajo.</p>

<pre><code>print("pan" in precios)     # True — preguntar antes de leer</code></pre>

<h2>Recorrer un diccionario</h2>

<pre><code>precios = {"pan": 5000, "leche": 7000, "queso": 15000}

for producto in precios:                    # recorre las CLAVES
    print(producto)

for producto, precio in precios.items():    # clave y valor a la vez
    print(f"{producto}: {precio}")

print(list(precios.keys()))     # [''pan'', ''leche'', ''queso'']
print(list(precios.values()))   # [5000, 7000, 15000]
print(sum(precios.values()))    # 27000</code></pre>

<p><code>.items()</code> entrega tuplas de dos, y el <code>for</code> las desempaqueta —el mismo truco del capítulo 11—. Es la forma normal de recorrer un diccionario.</p>

<h2>El patrón estrella: contar cosas</h2>

<p>Contar cuántas veces aparece cada elemento es el uso más común de un diccionario en la vida real.</p>

<pre><code>ventas = ["pan", "leche", "pan", "queso", "pan"]
conteo = {}                                  # nace afuera, vacío

for producto in ventas:
    conteo[producto] = conteo.get(producto, 0) + 1

print(conteo)     # {''pan'': 3, ''leche'': 1, ''queso'': 1}</code></pre>

<p>Esa línea de adentro merece leerse despacio: <em>"toma lo que ya había para este producto (o 0 si es la primera vez), súmale uno y vuélvelo a guardar"</em>.</p>

<table>
  <thead>
    <tr><th>Vuelta</th><th><code>producto</code></th><th><code>.get(producto, 0)</code></th><th><code>conteo</code> al terminar</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>pan</td><td>0 (no estaba)</td><td><code>{pan: 1}</code></td></tr>
    <tr><td>2</td><td>leche</td><td>0</td><td><code>{pan: 1, leche: 1}</code></td></tr>
    <tr><td>3</td><td>pan</td><td>1</td><td><code>{pan: 2, leche: 1}</code></td></tr>
    <tr><td>4</td><td>queso</td><td>0</td><td><code>{pan: 2, leche: 1, queso: 1}</code></td></tr>
    <tr><td>5</td><td>pan</td><td>2</td><td><code>{pan: 3, leche: 1, queso: 1}</code></td></tr>
  </tbody>
</table>

<h2>Diccionarios anidados: fichas completas</h2>

<p>El valor de una clave puede ser cualquier cosa: un número, una lista, u otro diccionario.</p>

<pre><code>clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000, "activa": True},
    "1045": {"nombre": "Juan", "saldo": 80000, "activa": False},
}

print(clientes["1023"]["nombre"])     # Ana

for cedula, datos in clientes.items():
    estado = "activa" if datos["activa"] else "bloqueada"
    print(f"{datos[''nombre'']}: {datos[''saldo'']} ({estado})")</code></pre>

<p>Así es como se ven los datos que vienen de una API o de un archivo JSON (capítulo 17). Un diccionario de diccionarios es la forma normal de representar registros.</p>

<p>Ese <code>"activa" if datos["activa"] else "bloqueada"</code> es un <strong>if en una línea</strong>: sirve cuando solo hay que escoger entre dos valores.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Leer una clave que no existe</h3>
<pre><code>precios["arroz"]           # KeyError
precios.get("arroz", 0)    # ✅</code></pre>

<h3>2. Usar una lista como clave</h3>
<pre><code>d = {[1, 2]: "x"}     # TypeError: unhashable type: ''list''
d = {(1, 2): "x"}     # ✅ una tupla sí sirve</code></pre>
<p>Las claves tienen que ser inmutables: textos, números o tuplas. Otra razón para que existan las tuplas.</p>

<h3>3. Creer que <code>for x in diccionario</code> da los valores</h3>
<pre><code>for x in precios:
    print(x)          # imprime pan, leche, queso — las CLAVES

for x in precios.values():
    print(x)          # ahora sí los precios</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿Buscas por nombre, código o cédula? Diccionario. ¿Por posición u orden? Lista.</li>
  <li>Para contar: <code>conteo[x] = conteo.get(x, 0) + 1</code>.</li>
  <li>Para recorrer parejas: <code>for clave, valor in d.items()</code>.</li>
  <li>Antes de leer una clave dudosa: <code>.get()</code> con valor por defecto, o <code>in</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>d = {}</code></td><td>Diccionario vacío</td></tr>
    <tr><td><code>d["k"] = v</code></td><td>Crea o reemplaza</td></tr>
    <tr><td><code>d["k"]</code></td><td>Lee (<code>KeyError</code> si no está)</td></tr>
    <tr><td><code>d.get("k", 0)</code></td><td>Lee con valor por defecto</td></tr>
    <tr><td><code>"k" in d</code></td><td>¿Existe la clave?</td></tr>
    <tr><td><code>del d["k"]</code></td><td>Borra la pareja</td></tr>
    <tr><td><code>d.items()</code></td><td>Parejas clave-valor</td></tr>
    <tr><td><code>d.keys()</code> · <code>d.values()</code></td><td>Solo claves · solo valores</td></tr>
    <tr><td><code>sum(d.values())</code></td><td>Suma todos los valores</td></tr>
  </tbody>
</table>

<blockquote>Lista para lo que va en orden; diccionario para lo que se busca por nombre. Y para contar cualquier cosa: <code>conteo.get(x, 0) + 1</code>.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 3
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 12 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 12 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Lista de precios', 'facil', '<p>Dado el diccionario de precios:</p><pre><code>precios = {"pan": 5000, "leche": 7000, "queso": 15000}</code></pre><p>Mostrar cada producto con su precio y el total del inventario:</p><pre><code>pan: 5,000
leche: 7,000
queso: 15,000
Total: 27,000</code></pre>', '<p>Recorra con <code>for producto, precio in precios.items():</code>. Para el total, <code>sum(precios.values())</code>.</p>', '<pre><code>''''''
Programa: Lista de precios
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra cada producto con su precio y el total del inventario.
''''''

# Inicio
precios = {"pan": 5000, "leche": 7000, "queso": 15000}

# .items() entrega tuplas (clave, valor) que el for desempaqueta
for producto, precio in precios.items():
    print(f"{producto}: {precio:,}")

print(f"Total: {sum(precios.values()):,}")
# Fin</code></pre><p>Compare con el ejercicio del inventario del capítulo 10: allá había dos listas paralelas y tocaba usar la posición <code>i</code> para cruzarlas. Aquí la pareja ya viene junta y no hay forma de desalinearla.</p>', '[{"stdin":"","expected_output":"pan: 5,000\nleche: 7,000\nqueso: 15,000\nTotal: 27,000"}]', '''''''
Programa: Lista de precios
Autor:
Fecha:
Descripcion:
''''''

# Inicio
precios = {"pan": 5000, "leche": 7000, "queso": 15000}

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Productos más vendidos', 'facil', '<p>Dada la lista de productos vendidos hoy:</p><pre><code>ventas = ["pan", "leche", "pan", "queso", "pan", "leche"]</code></pre><p>Contar cuántas veces se vendió cada uno y mostrarlos ordenados alfabéticamente:</p><pre><code>leche: 2
pan: 3
queso: 1
El mas vendido fue pan con 3</code></pre>', '<p>El patrón de conteo: <code>conteo[producto] = conteo.get(producto, 0) + 1</code>. Para el más vendido, <code>max(conteo, key=conteo.get)</code> devuelve la clave con el valor más alto.</p>', '<pre><code>''''''
Programa: Productos mas vendidos
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Cuenta cuantas veces se vendio cada producto y determina
    cual fue el mas vendido.
''''''

# Inicio
ventas = ["pan", "leche", "pan", "queso", "pan", "leche"]

conteo = {}    # nace afuera, vacio

for producto in ventas:
    # Lo que ya habia (o 0 si es la primera vez) mas uno
    conteo[producto] = conteo.get(producto, 0) + 1

for producto in sorted(conteo):
    print(f"{producto}: {conteo[producto]}")

# max con key=conteo.get compara por el VALOR y devuelve la CLAVE
mas_vendido = max(conteo, key=conteo.get)
print(f"El mas vendido fue {mas_vendido} con {conteo[mas_vendido]}")
# Fin</code></pre><p>Dos herramientas que valen oro:</p><ul><li><code>conteo.get(producto, 0) + 1</code> evita tener que preguntar <code>if producto in conteo</code> antes de sumar.</li><li><code>max(conteo, key=conteo.get)</code> recorre las claves pero compara por su valor. Sin el <code>key</code>, <code>max()</code> compararía los nombres alfabéticamente y devolvería <code>queso</code>.</li></ul>', '[{"stdin":"","expected_output":"leche: 2\npan: 3\nqueso: 1\nEl mas vendido fue pan con 3"}]', '''''''
Programa: Productos mas vendidos
Autor:
Fecha:
Descripcion:
''''''

# Inicio
ventas = ["pan", "leche", "pan", "queso", "pan", "leche"]

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Cajero con diccionario', 'medio', '<p>Un banco guarda sus clientes así:</p><pre><code>clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000},
    "1045": {"nombre": "Juan", "saldo": 80000},
}</code></pre><p>Solicitar una cédula y un monto a retirar. Mostrar:</p><ul><li>Si la cédula no existe: <code>Cliente no encontrado</code></li><li>Si el saldo no alcanza: <code>Ana, saldo insuficiente (tiene 250000)</code></li><li>Si alcanza: <code>Ana retiro 50000. Nuevo saldo: 200000</code></li></ul>', '<p>Primero verifique con <code>if cedula in clientes</code>. Al modificar el saldo, recuerde que <code>clientes[cedula]["saldo"]</code> es la ruta completa hasta el número.</p>', '<pre><code>''''''
Programa: Cajero con diccionario
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Busca un cliente por cedula y procesa un retiro validando
    que el saldo alcance.
''''''

# Inicio
clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000},
    "1045": {"nombre": "Juan", "saldo": 80000},
}

cedula = input("Cedula: ").strip()
monto = int(input("Monto a retirar: "))

if cedula not in clientes:
    print("Cliente no encontrado")
else:
    # cliente apunta al MISMO diccionario interno:
    # modificarlo modifica el original
    cliente = clientes[cedula]

    if monto > cliente["saldo"]:
        print(f"{cliente[''nombre'']}, saldo insuficiente (tiene {cliente[''saldo'']})")
    else:
        cliente["saldo"] -= monto
        print(f"{cliente[''nombre'']} retiro {monto}. Nuevo saldo: {cliente[''saldo'']}")
# Fin</code></pre><p>Lo importante: <code>cliente = clientes[cedula]</code> <strong>no hace una copia</strong>. Es otro nombre para el mismo diccionario interno, así que <code>cliente["saldo"] -= monto</code> actualiza los datos de verdad. Eso ahorra escribir <code>clientes[cedula]["saldo"]</code> cuatro veces.</p><p>Y ojo con las comillas dentro de la f-string: como el texto va con comillas dobles, adentro se usan sencillas: <code>{cliente[''nombre'']}</code>.</p>', '[{"stdin":"1023\n50000\n","expected_output":"Cedula: Monto a retirar: Ana retiro 50000. Nuevo saldo: 200000"},{"stdin":"1045\n90000\n","expected_output":"Cedula: Monto a retirar: Juan, saldo insuficiente (tiene 80000)"},{"stdin":"9999\n1000\n","expected_output":"Cedula: Monto a retirar: Cliente no encontrado"}]', '''''''
Programa: Cajero con diccionario
Autor:
Fecha:
Descripcion:
''''''

# Inicio
clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000},
    "1045": {"nombre": "Juan", "saldo": 80000},
}

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Boletín de calificaciones', 'dificil', '<p>Un curso guarda las notas así:</p><pre><code>curso = {
    "Ana": [4.5, 3.8, 5.0],
    "Juan": [2.5, 3.0, 2.8],
    "Sofia": [3.5, 4.0, 3.9],
}</code></pre><p>Mostrar el boletín con el promedio de cada estudiante y su estado, y al final el resumen del curso:</p><pre><code>Ana      4.43  APROBADO
Juan     2.77  REPROBADO
Sofia    3.80  APROBADO
---
Promedio del curso: 3.67
Aprobados: 2 de 3
Mejor promedio: Ana</code></pre><p><em>Nota:</em> aprueba con promedio mayor o igual a 3.0. Los promedios se muestran con dos decimales y el nombre alineado en 8 espacios.</p>', '<p>Recorra con <code>.items()</code>: el valor es una lista, así que <code>sum(notas) / len(notas)</code> da el promedio. Guarde los promedios en otro diccionario para poder sacar el mejor con <code>max(promedios, key=promedios.get)</code>.</p>', '<pre><code>''''''
Programa: Boletin de calificaciones
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula el promedio de cada estudiante, su estado y el
    resumen del curso.
''''''

# Inicio
MINIMA = 3.0

curso = {
    "Ana": [4.5, 3.8, 5.0],
    "Juan": [2.5, 3.0, 2.8],
    "Sofia": [3.5, 4.0, 3.9],
}

promedios = {}   # nombre -> promedio, para el resumen
aprobados = 0    # contador

for estudiante, notas in curso.items():
    promedio = sum(notas) / len(notas)
    promedios[estudiante] = promedio

    if promedio >= MINIMA:
        estado = "APROBADO"
        aprobados += 1
    else:
        estado = "REPROBADO"

    print(f"{estudiante:<8} {promedio:.2f}  {estado}")

print("---")

# El promedio del curso es el promedio de los promedios
del_curso = sum(promedios.values()) / len(promedios)

print(f"Promedio del curso: {del_curso:.2f}")
print(f"Aprobados: {aprobados} de {len(curso)}")
print(f"Mejor promedio: {max(promedios, key=promedios.get)}")
# Fin</code></pre><p>Tres ideas que se juntan:</p><ul><li><strong>Diccionario de listas.</strong> Cada valor es una lista completa, así que <code>sum()</code> y <code>len()</code> funcionan sobre él directamente.</li><li><strong>Un diccionario para el resumen.</strong> Guardar <code>promedios</code> aparte permite calcular después el mejor y el promedio del curso sin volver a recorrer las notas.</li><li><strong>Formato en la f-string.</strong> <code>{estudiante:&lt;8}</code> alinea el nombre y <code>{promedio:.2f}</code> deja dos decimales. Sin eso, la tabla no queda derecha.</li></ul>', '[{"stdin":"","expected_output":"Ana      4.43  APROBADO\nJuan     2.77  REPROBADO\nSofia    3.80  APROBADO\n---\nPromedio del curso: 3.67\nAprobados: 2 de 3\nMejor promedio: Ana"}]', '''''''
Programa: Boletin de calificaciones
Autor:
Fecha:
Descripcion:
''''''

# Inicio
MINIMA = 3.0

curso = {
    "Ana": [4.5, 3.8, 5.0],
    "Juan": [2.5, 3.0, 2.8],
    "Sofia": [3.5, 4.0, 3.9],
}

# Fin
', 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 12 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuándo conviene un diccionario en vez de una lista?', NULL, '{"options":[{"id":"a","text":"Cuando se busca por nombre, código o cédula en vez de por posición"},{"id":"b","text":"Cuando hay muchos datos"},{"id":"c","text":"Cuando los datos son números"},{"id":"d","text":"Cuando el orden importa"}]}', '{"option_id":"a"}', 'En una agenda uno no busca el contacto número 47: busca a Ana.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué pasa si se asigna un valor a una clave que ya existe?', NULL, '{"options":[{"id":"a","text":"Se reemplaza el valor anterior"},{"id":"b","text":"Se crea una segunda entrada con la misma clave"},{"id":"c","text":"Lanza KeyError"},{"id":"d","text":"No hace nada"}]}', '{"option_id":"a"}', 'Las claves nunca se repiten: volver a asignar es actualizar.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace d.get("arroz", 0) si la clave no existe?', NULL, '{"options":[{"id":"a","text":"Devuelve 0 sin lanzar error"},{"id":"b","text":"Lanza KeyError"},{"id":"c","text":"Crea la clave con valor 0"},{"id":"d","text":"Devuelve None"}]}', '{"option_id":"a"}', 'El segundo argumento es el valor por defecto. Sin él devolvería None, y con corchetes sería KeyError.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué recorre un for x in mi_diccionario?', NULL, '{"options":[{"id":"a","text":"Las claves"},{"id":"b","text":"Los valores"},{"id":"c","text":"Las parejas clave-valor"},{"id":"d","text":"Las posiciones"}]}', '{"option_id":"a"}', 'Para los valores está .values() y para las parejas .items().', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué una lista no puede ser clave de un diccionario?', NULL, '{"options":[{"id":"a","text":"Porque las claves deben ser inmutables, y una lista puede cambiar"},{"id":"b","text":"Porque las listas ocupan mucha memoria"},{"id":"c","text":"Porque las claves solo pueden ser texto"},{"id":"d","text":"Sí puede: es un error del enunciado"}]}', '{"option_id":"a"}', 'Una tupla sí sirve como clave, porque no puede cambiar. Es otra razón para que existan las tuplas.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'precios = {"pan": 5000, "leche": 7000}
print(sum(precios.values()))', '{"options":[{"id":"a","text":"12000"},{"id":"b","text":"2"},{"id":"c","text":"[''pan'', ''leche'']"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', '.values() entrega los precios y sum() los suma.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'conteo = {}
for p in ["pan", "pan", "leche"]:
    conteo[p] = conteo.get(p, 0) + 1
print(conteo)', '{"options":[{"id":"a","text":"{''pan'': 2, ''leche'': 1}"},{"id":"b","text":"{''pan'': 1, ''leche'': 1}"},{"id":"c","text":"{''pan'': 3}"},{"id":"d","text":"KeyError"}]}', '{"option_id":"a"}', 'Es el patrón de conteo: get devuelve 0 la primera vez y el acumulado las siguientes.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'd = {"a": 1}
d["a"] = 2
d["b"] = 3
print(len(d))', '{"options":[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"1"},{"id":"d","text":"4"}]}', '{"option_id":"a"}', 'Reasignar la clave a no agrega una entrada nueva: la reemplaza. Solo hay dos claves.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'conteo = {"pan": 3, "leche": 2, "queso": 5}
print(max(conteo, key=conteo.get))', '{"options":[{"id":"a","text":"queso"},{"id":"b","text":"pan"},{"id":"c","text":"5"},{"id":"d","text":"leche"}]}', '{"option_id":"a"}', 'Con key=conteo.get, max compara por el valor pero devuelve la clave. Sin el key compararía los nombres alfabéticamente.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa se cae cuando el producto no está. ¿En qué línea está el error?', NULL, '{"lines":["precios = {\"pan\": 5000}","print(precios[\"arroz\"])"]}', '{"line_number":2}', 'Leer con corchetes una clave inexistente da KeyError. Ahí va precios.get("arroz", 0).', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa debe imprimir los precios, no los nombres. ¿En qué línea está el error?', NULL, '{"lines":["precios = {\"pan\": 5000, \"leche\": 7000}","for x in precios:","    print(x)"]}', '{"line_number":2}', 'Recorrer un diccionario da las claves. Para los precios habría que usar precios.values().', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa que cuenta los productos vendidos', NULL, '{"lines":[{"id":"l1","text":"ventas = [\"pan\", \"leche\", \"pan\"]","indent":0},{"id":"l2","text":"conteo = {}","indent":0},{"id":"l3","text":"for producto in ventas:","indent":0},{"id":"l4","text":"conteo[producto] = conteo.get(producto, 0) + 1","indent":1},{"id":"l5","text":"for producto, veces in conteo.items():","indent":0},{"id":"l6","text":"print(f\"{producto}: {veces}\")","indent":1}]}', '{"order":["l1","l2","l3","l4","l5","l6"]}', 'Primero se cuenta en un ciclo y después se muestra en otro: mezclarlos imprimiría conteos parciales.', 1, 'seed'
    FROM chapters WHERE number = 12 AND track = 'basico';

-- ── Capítulo 13: Comprehensions (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 13, 'Comprehensions', '⚡', 'Crear listas, sets y diccionarios en una sola línea.', '<p class="jc-gancho">Filtrar las notas aprobadas te toma cuatro líneas: crear la lista, el <code>for</code>, el <code>if</code> y el <code>append</code>. Python tiene una forma de escribir eso mismo en una sola línea que se lee igual de bien. Se llama <em>comprehension</em>.</p>

<h2>De cuatro líneas a una</h2>

<p>El patrón del capítulo 10, tal como lo escribiste:</p>

<pre><code>aprobadas = []
for nota in notas:
    if nota &gt;= 3.0:
        aprobadas.append(nota)</code></pre>

<p>Lo mismo, en una línea:</p>

<pre><code>aprobadas = [nota for nota in notas if nota &gt;= 3.0]</code></pre>

<p>Se lee de izquierda a derecha en tres partes:</p>

<table>
  <thead>
    <tr><th>Parte</th><th>En el ejemplo</th><th>Qué dice</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>qué guardo</strong></td><td><code>nota</code></td><td>lo que va a quedar en la lista nueva</td></tr>
    <tr><td><strong>de dónde</strong></td><td><code>for nota in notas</code></td><td>qué colección recorro</td></tr>
    <tr><td><strong>con qué filtro</strong></td><td><code>if nota &gt;= 3.0</code></td><td>opcional: cuáles dejo pasar</td></tr>
  </tbody>
</table>

<p>El <code>if</code> es opcional. Sin él, se transforma todo:</p>

<pre><code>precios = [5000, 7000, 15000]

con_iva = [p * 1.19 for p in precios]        # transformar
caros = [p for p in precios if p &gt; 10000]    # filtrar
nombres = [n.upper() for n in ["ana", "juan"]]   # ambos mundos

# Las dos cosas a la vez
caros_con_iva = [p * 1.19 for p in precios if p &gt; 10000]</code></pre>

<h2>La película: cómo la lee Python</h2>

<p>Aunque se escriba en una línea, por dentro es el mismo ciclo. Con <code>notas = [4.0, 2.5, 3.8]</code>:</p>

<table>
  <thead>
    <tr><th>Vuelta</th><th><code>nota</code></th><th>¿pasa el <code>if</code>?</th><th>Lista que se va armando</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>4.0</td><td>Sí</td><td><code>[4.0]</code></td></tr>
    <tr><td>2</td><td>2.5</td><td>No</td><td><code>[4.0]</code></td></tr>
    <tr><td>3</td><td>3.8</td><td>Sí</td><td><code>[4.0, 3.8]</code></td></tr>
  </tbody>
</table>

<p>Truco para escribirlas: <strong>primero escribe el ciclo normal</strong> y después lo comprimes. Con la práctica sale directo, pero al principio es más seguro así.</p>

<h2>También hay de diccionario y de set</h2>

<pre><code>productos = ["pan", "leche"]
precios = [5000, 7000]

# Diccionario: usa llaves y una pareja clave: valor
inventario = {p: v for p, v in zip(productos, precios)}
print(inventario)     # {''pan'': 5000, ''leche'': 7000}

# Set: llaves, sin pareja
iniciales = {p[0] for p in productos}
print(iniciales)      # {''p'', ''l''}</code></pre>

<p><code>zip()</code> une dos listas en parejas: es la forma limpia de convertir dos listas paralelas en un diccionario.</p>

<pre><code>duplicar = {p: v * 2 for p, v in inventario.items()}
baratos = {p: v for p, v in inventario.items() if v &lt; 6000}</code></pre>

<h2>El if-else que va adelante</h2>

<p>Hay dos <code>if</code> distintos y confundirlos es normal:</p>

<pre><code># FILTRAR: el if va al final, sin else
aprobadas = [n for n in notas if n &gt;= 3.0]

# TRANSFORMAR: el if-else va ADELANTE, y es obligatorio el else
estados = ["aprobado" if n &gt;= 3.0 else "reprobado" for n in notas]</code></pre>

<p>La regla: si vas a <strong>dejar por fuera</strong> elementos, el <code>if</code> va al final. Si vas a <strong>escoger entre dos valores</strong> para cada elemento, el <code>if-else</code> va adelante.</p>

<h2>Cuándo NO usarlas</h2>

<p>Una comprehension es mejor cuando cabe cómoda en una línea y se lee de un vistazo. Cuando no, el ciclo normal gana:</p>

<pre><code># ❌ ilegible
r = [x*2 if x&gt;0 else -x for y in datos for x in y if x!=0 and x&lt;100]

# ✅ un ciclo normal, que cualquiera entiende
r = []
for fila in datos:
    for x in fila:
        if x == 0 or x &gt;= 100:
            continue
        r.append(x * 2 if x &gt; 0 else -x)</code></pre>

<p>Y si adentro necesitas varias líneas, <code>print()</code>, o llevar contadores aparte, no es trabajo para una comprehension.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Poner el <code>if-else</code> al final</h3>
<pre><code>[n for n in notas if n &gt;= 3.0 else 0]     # ❌ SyntaxError
["ok" if n &gt;= 3.0 else "no" for n in notas]  # ✅</code></pre>

<h3>2. Usarla solo para imprimir</h3>
<pre><code>[print(n) for n in notas]     # ❌ crea una lista de None que nadie usa

for n in notas:               # ✅
    print(n)</code></pre>

<h3>3. Olvidar que crea una lista NUEVA</h3>
<pre><code>[n * 2 for n in notas]     # ❌ el resultado se pierde
dobles = [n * 2 for n in notas]   # ✅</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Escribe primero el ciclo con <code>append</code>; después compríme si mejora.</li>
  <li>Filtrar → <code>if</code> al final. Escoger entre dos valores → <code>if-else</code> adelante.</li>
  <li>Guarda el resultado: la comprehension no modifica nada, crea algo nuevo.</li>
  <li>Si no cabe cómoda en una línea, déjala como ciclo.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>[x for x in lista]</code></td><td>Copia la lista</td></tr>
    <tr><td><code>[x * 2 for x in lista]</code></td><td>Transforma cada elemento</td></tr>
    <tr><td><code>[x for x in lista if x &gt; 0]</code></td><td>Filtra</td></tr>
    <tr><td><code>["a" if x else "b" for x in l]</code></td><td>Escoge entre dos valores</td></tr>
    <tr><td><code>{k: v for k, v in d.items()}</code></td><td>Comprehension de diccionario</td></tr>
    <tr><td><code>{x for x in lista}</code></td><td>Comprehension de set (sin repetidos)</td></tr>
    <tr><td><code>zip(a, b)</code></td><td>Une dos listas en parejas</td></tr>
  </tbody>
</table>

<blockquote>Una comprehension no hace nada que un ciclo no pueda. Se usa cuando hace el código <em>más</em> fácil de leer, nunca para presumir.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 3
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 13 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 13 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Precios con IVA', 'facil', '<p>Dada la lista <code>precios = [5000, 7000, 15000, 12000]</code>, crear con una comprehension una lista nueva con el precio más el 19% de IVA, redondeado a entero. Mostrar las dos listas:</p><pre><code>Sin IVA: [5000, 7000, 15000, 12000]
Con IVA: [5950, 8330, 17850, 14280]</code></pre>', '<p>La forma es <code>[round(p * 1.19) for p in precios]</code>. Como es una transformación y no un filtro, no lleva <code>if</code>.</p>', '<pre><code>''''''
Programa: Precios con IVA
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula el precio con IVA de una lista de productos usando
    una comprehension.
''''''

# Inicio
IVA = 1.19

precios = [5000, 7000, 15000, 12000]

# Transformar cada elemento: sin if, porque no se descarta ninguno
con_iva = [round(p * IVA) for p in precios]

print(f"Sin IVA: {precios}")
print(f"Con IVA: {con_iva}")
# Fin</code></pre><p>El ciclo equivalente serían tres líneas: crear la lista vacía, el <code>for</code> y el <code>append</code>. Aquí cabe cómodo en una y se lee igual de claro, que es justo cuando conviene usar una comprehension.</p>', '[{"stdin":"","expected_output":"Sin IVA: [5000, 7000, 15000, 12000]\nCon IVA: [5950, 8330, 17850, 14280]"}]', '''''''
Programa: Precios con IVA
Autor:
Fecha:
Descripcion:
''''''

# Inicio
IVA = 1.19
precios = [5000, 7000, 15000, 12000]

# Fin
', 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Filtrar y etiquetar notas', 'facil', '<p>Dada la lista <code>notas = [4.5, 2.8, 3.0, 1.9, 5.0]</code>, usar comprehensions para obtener:</p><ul><li>solo las aprobadas (mayor o igual a 3.0),</li><li>y una lista de etiquetas <code>APROBADO</code> / <code>REPROBADO</code> para todas.</li></ul><pre><code>Aprobadas: [4.5, 3.0, 5.0]
Estados: [''APROBADO'', ''REPROBADO'', ''APROBADO'', ''REPROBADO'', ''APROBADO'']</code></pre>', '<p>Filtrar → el <code>if</code> va al final y no lleva <code>else</code>. Escoger entre dos valores → el <code>if-else</code> va adelante y el <code>else</code> es obligatorio.</p>', '<pre><code>''''''
Programa: Filtrar y etiquetar notas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Muestra las notas aprobadas y la etiqueta de cada nota
    usando los dos tipos de comprehension.
''''''

# Inicio
MINIMA = 3.0

notas = [4.5, 2.8, 3.0, 1.9, 5.0]

# FILTRAR: el if va al final, sin else
aprobadas = [n for n in notas if n >= MINIMA]

# ESCOGER entre dos valores: el if-else va adelante
estados = ["APROBADO" if n >= MINIMA else "REPROBADO" for n in notas]

print(f"Aprobadas: {aprobadas}")
print(f"Estados: {estados}")
# Fin</code></pre><p>La diferencia entre las dos líneas es la que más confunde:</p><table><thead><tr><th>Quiero</th><th>Dónde va el if</th><th>¿Lleva else?</th><th>Tamaño del resultado</th></tr></thead><tbody><tr><td>Dejar por fuera algunos</td><td>al final</td><td>no</td><td>menor o igual</td></tr><tr><td>Escoger entre dos valores</td><td>adelante</td><td>sí, obligatorio</td><td>igual al original</td></tr></tbody></table>', '[{"stdin":"","expected_output":"Aprobadas: [4.5, 3.0, 5.0]\nEstados: [''APROBADO'', ''REPROBADO'', ''APROBADO'', ''REPROBADO'', ''APROBADO'']"}]', '''''''
Programa: Filtrar y etiquetar notas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
MINIMA = 3.0
notas = [4.5, 2.8, 3.0, 1.9, 5.0]

# Fin
', 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Inventario desde dos listas', 'medio', '<p>Se tienen dos listas paralelas:</p><pre><code>productos = ["pan", "leche", "queso", "cafe"]
precios = [5000, 7000, 15000, 12000]</code></pre><p>Con comprehensions, construir:</p><ul><li>el inventario como diccionario,</li><li>un diccionario solo con los que cuestan más de 10000,</li><li>y el set de las iniciales de todos los productos.</li></ul><pre><code>Inventario: {''pan'': 5000, ''leche'': 7000, ''queso'': 15000, ''cafe'': 12000}
Caros: {''queso'': 15000, ''cafe'': 12000}
Iniciales: [''c'', ''l'', ''p'', ''q'']</code></pre><p><em>Nota:</em> las iniciales se muestran ordenadas.</p>', '<p><code>zip(productos, precios)</code> entrega parejas. Una comprehension de diccionario se escribe con llaves y <code>clave: valor</code>.</p>', '<pre><code>''''''
Programa: Inventario desde dos listas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Convierte dos listas paralelas en un diccionario y arma
    subconjuntos con comprehensions.
''''''

# Inicio
CARO = 10000

productos = ["pan", "leche", "queso", "cafe"]
precios = [5000, 7000, 15000, 12000]

# zip une las dos listas en parejas (producto, precio)
inventario = {p: v for p, v in zip(productos, precios)}

# Comprehension de diccionario con filtro
caros = {p: v for p, v in inventario.items() if v > CARO}

# Comprehension de set: sin repetidos por definicion
iniciales = {p[0] for p in productos}

print(f"Inventario: {inventario}")
print(f"Caros: {caros}")
print(f"Iniciales: {sorted(iniciales)}")
# Fin</code></pre><p><code>zip()</code> es la forma limpia de pasar de dos listas paralelas a un diccionario, que es justo la estructura que el capítulo 12 recomienda para este caso.</p><p>El set de iniciales se imprime con <code>sorted()</code> porque un set no tiene orden: mostrarlo directo daría un resultado impredecible.</p>', '[{"stdin":"","expected_output":"Inventario: {''pan'': 5000, ''leche'': 7000, ''queso'': 15000, ''cafe'': 12000}\nCaros: {''queso'': 15000, ''cafe'': 12000}\nIniciales: [''c'', ''l'', ''p'', ''q'']"}]', '''''''
Programa: Inventario desde dos listas
Autor:
Fecha:
Descripcion:
''''''

# Inicio
CARO = 10000
productos = ["pan", "leche", "queso", "cafe"]
precios = [5000, 7000, 15000, 12000]

# Fin
', 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Reporte del curso en tres líneas', 'dificil', '<p>Dado el curso:</p><pre><code>curso = {
    "Ana": [4.5, 3.8, 5.0],
    "Juan": [2.5, 3.0, 2.8],
    "Sofia": [3.5, 4.0, 3.9],
}</code></pre><p>Usando comprehensions, obtener y mostrar:</p><pre><code>Promedios: {''Ana'': 4.43, ''Juan'': 2.77, ''Sofia'': 3.8}
Aprobados: [''Ana'', ''Sofia'']
En riesgo: [''Juan'']
Promedio del curso: 3.67</code></pre><p><em>Nota:</em> los promedios se redondean a dos decimales. Aprueba con 3.0 o más.</p>', '<p>Primero un diccionario de promedios con <code>{nombre: round(sum(n)/len(n), 2) for nombre, n in curso.items()}</code>. Sobre ese diccionario ya salen las dos listas con comprehensions filtradas.</p>', '<pre><code>''''''
Programa: Reporte del curso con comprehensions
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula el promedio de cada estudiante y separa aprobados
    de estudiantes en riesgo.
''''''

# Inicio
MINIMA = 3.0

curso = {
    "Ana": [4.5, 3.8, 5.0],
    "Juan": [2.5, 3.0, 2.8],
    "Sofia": [3.5, 4.0, 3.9],
}

# Un diccionario nuevo a partir de otro: nombre -> promedio
promedios = {
    nombre: round(sum(notas) / len(notas), 2)
    for nombre, notas in curso.items()
}

# Sobre los promedios ya calculados, dos filtros
aprobados = [n for n, p in promedios.items() if p >= MINIMA]
en_riesgo = [n for n, p in promedios.items() if p < MINIMA]

print(f"Promedios: {promedios}")
print(f"Aprobados: {aprobados}")
print(f"En riesgo: {en_riesgo}")
print(f"Promedio del curso: {round(sum(promedios.values()) / len(promedios), 2)}")
# Fin</code></pre><p>Compare con el mismo reporte del capítulo 12: allá eran unas quince líneas con un <code>for</code>, un <code>if / else</code> y un contador. Aquí son cuatro, y cada una dice exactamente qué produce.</p><p>Fíjese en que la comprehension del diccionario está partida en tres renglones. Cuando una comprehension se pone larga, <strong>partirla no es hacer trampa</strong>: se dejan la salida, el <code>for</code> y el <code>if</code> cada uno en su línea y se sigue leyendo perfecto.</p><p>La clave del ejercicio es el orden: <code>promedios</code> se calcula <strong>una vez</strong> y las tres líneas siguientes trabajan sobre él. Recalcular el promedio dentro de cada filtro sería hacer el mismo trabajo tres veces.</p>', '[{"stdin":"","expected_output":"Promedios: {''Ana'': 4.43, ''Juan'': 2.77, ''Sofia'': 3.8}\nAprobados: [''Ana'', ''Sofia'']\nEn riesgo: [''Juan'']\nPromedio del curso: 3.67"}]', '''''''
Programa: Reporte del curso con comprehensions
Autor:
Fecha:
Descripcion:
''''''

# Inicio
MINIMA = 3.0

curso = {
    "Ana": [4.5, 3.8, 5.0],
    "Juan": [2.5, 3.0, 2.8],
    "Sofia": [3.5, 4.0, 3.9],
}

# Fin
', 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 13 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace [n for n in notas if n >= 3.0]?', NULL, '{"options":[{"id":"a","text":"Crea una lista nueva solo con las notas mayores o iguales a 3.0"},{"id":"b","text":"Modifica la lista notas quitando las bajas"},{"id":"c","text":"Cuenta cuántas notas aprobaron"},{"id":"d","text":"Devuelve True o False"}]}', '{"option_id":"a"}', 'Una comprehension nunca modifica el original: siempre crea algo nuevo, y hay que guardarlo.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Dónde va el if cuando se quiere escoger entre dos valores para cada elemento?', NULL, '{"options":[{"id":"a","text":"Adelante, con else obligatorio"},{"id":"b","text":"Al final, sin else"},{"id":"c","text":"Da igual"},{"id":"d","text":"No se puede hacer en una comprehension"}]}', '{"option_id":"a"}', 'Filtrar → if al final sin else. Escoger entre dos valores → if-else adelante.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace zip(productos, precios)?', NULL, '{"options":[{"id":"a","text":"Une las dos listas en parejas, elemento con elemento"},{"id":"b","text":"Comprime las listas para ahorrar memoria"},{"id":"c","text":"Ordena las dos listas a la vez"},{"id":"d","text":"Suma las dos listas"}]}', '{"option_id":"a"}', 'Es la forma limpia de convertir dos listas paralelas en un diccionario.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Cuándo NO conviene usar una comprehension?', NULL, '{"options":[{"id":"a","text":"Cuando no cabe cómoda en una línea o se necesita imprimir y llevar contadores"},{"id":"b","text":"Cuando la lista tiene más de diez elementos"},{"id":"c","text":"Cuando hay que filtrar"},{"id":"d","text":"Nunca: siempre son mejores que un ciclo"}]}', '{"option_id":"a"}', 'Se usan cuando hacen el código más fácil de leer. Si no, el ciclo normal gana.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'precios = [1000, 2000]
print([p * 2 for p in precios])', '{"options":[{"id":"a","text":"[2000, 4000]"},{"id":"b","text":"[1000, 2000, 1000, 2000]"},{"id":"c","text":"3000"},{"id":"d","text":"[1000, 2000]"}]}', '{"option_id":"a"}', 'Sin if, la comprehension transforma cada elemento y devuelve una lista del mismo tamaño.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'notas = [4.0, 2.0, 3.5]
print([n for n in notas if n >= 3.0])', '{"options":[{"id":"a","text":"[4.0, 3.5]"},{"id":"b","text":"[4.0, 2.0, 3.5]"},{"id":"c","text":"[2.0]"},{"id":"d","text":"[True, False, True]"}]}', '{"option_id":"a"}', 'El if al final deja pasar solo las que cumplen: la lista resultante es más corta.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'notas = [4.0, 2.0]
print(["ok" if n >= 3.0 else "no" for n in notas])', '{"options":[{"id":"a","text":"[''ok'', ''no'']"},{"id":"b","text":"[''ok'']"},{"id":"c","text":"[''no'']"},{"id":"d","text":"SyntaxError"}]}', '{"option_id":"a"}', 'Con if-else adelante no se descarta nada: la lista tiene el mismo tamaño que la original.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'd = {"pan": 5000, "queso": 15000}
print({k: v for k, v in d.items() if v > 10000})', '{"options":[{"id":"a","text":"{''queso'': 15000}"},{"id":"b","text":"{''pan'': 5000}"},{"id":"c","text":"[''queso'']"},{"id":"d","text":"{15000}"}]}', '{"option_id":"a"}', 'Una comprehension de diccionario usa llaves y clave: valor; el if al final filtra las parejas.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["notas = [4.0, 2.0]","print([n for n in notas if n >= 3.0 else 0])"]}', '{"line_number":2}', 'El if del final no admite else. Si se quiere el 0, el if-else va adelante: [n if n >= 3.0 else 0 for n in notas].', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa debería mostrar la lista con IVA pero no muestra nada útil. ¿En qué línea está el error?', NULL, '{"lines":["precios = [1000, 2000]","[p * 1.19 for p in precios]","print(precios)"]}', '{"line_number":2}', 'La comprehension crea una lista nueva y nadie la guarda. Falta con_iva = [...] y luego imprimirla.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el reporte del curso con comprehensions', NULL, '{"lines":[{"id":"l1","text":"curso = {\"Ana\": [4.5, 5.0], \"Juan\": [2.0, 2.5]}","indent":0},{"id":"l2","text":"promedios = {n: sum(v) / len(v) for n, v in curso.items()}","indent":0},{"id":"l3","text":"aprobados = [n for n, p in promedios.items() if p >= 3.0]","indent":0},{"id":"l4","text":"print(f\"Aprobados: {aprobados}\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'Los promedios se calculan una sola vez y las líneas siguientes trabajan sobre ese diccionario.', 1, 'seed'
    FROM chapters WHERE number = 13 AND track = 'basico';

-- ── Capítulo 14: Funciones (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 14, 'Funciones', '🧰', 'Empaquetar lógica para reutilizarla.', '<p class="jc-gancho">Calculaste el IVA en el capítulo 13. Y en el 10. Y lo vas a calcular otra vez en el proyecto del capítulo 20. Cada vez copiaste la fórmula. El día que cambie el IVA, tienes que acordarte de los cinco sitios. Una función arregla eso para siempre.</p>

<h2>Una función es una receta con nombre</h2>

<pre><code>def calcular_iva(precio):
    return precio * 0.19

# Ahora se usa las veces que quieras
print(calcular_iva(10000))    # 1900.0
print(calcular_iva(50000))    # 9500.0</code></pre>

<p>Las partes:</p>

<table>
  <thead>
    <tr><th>Parte</th><th>En el ejemplo</th><th>Qué es</th></tr>
  </thead>
  <tbody>
    <tr><td><code>def</code></td><td><code>def</code></td><td>"voy a definir una función"</td></tr>
    <tr><td>nombre</td><td><code>calcular_iva</code></td><td>en <code>snake_case</code>, y que diga qué hace</td></tr>
    <tr><td>parámetros</td><td><code>(precio)</code></td><td>lo que la función necesita recibir</td></tr>
    <tr><td>cuerpo</td><td>lo indentado</td><td>lo que hace</td></tr>
    <tr><td><code>return</code></td><td><code>return precio * 0.19</code></td><td>lo que devuelve</td></tr>
  </tbody>
</table>

<p>Definir no es ejecutar. El <code>def</code> solo guarda la receta; el código corre cuando <strong>llamas</strong> a la función con paréntesis.</p>

<h2><code>return</code> vs <code>print</code>: la confusión clásica</h2>

<pre><code>def suma_mala(a, b):
    print(a + b)         # muestra, pero no entrega nada

def suma_buena(a, b):
    return a + b         # entrega el resultado

x = suma_mala(2, 3)      # imprime 5, pero x queda en None
y = suma_buena(2, 3)     # no imprime nada, pero y vale 5

print(y * 2)             # 10 — se puede seguir trabajando</code></pre>

<p><strong><code>print</code> le habla al usuario; <code>return</code> le habla al programa.</strong> Una función que calcula debe <em>devolver</em>; imprimir es trabajo de quien la llama. Así la misma función sirve para mostrar en pantalla, guardar en un archivo o sumar a un total.</p>

<p>Además, <code>return</code> termina la función de inmediato:</p>

<pre><code>def clasificar(nota):
    if nota &gt;= 4.5:
        return "Excelente"      # sale aquí mismo
    if nota &gt;= 3.0:
        return "Aprobado"
    return "Reprobado"</code></pre>

<p>Como cada <code>return</code> sale, no hacen falta <code>elif</code> ni <code>else</code>. Es un estilo muy usado y muy legible.</p>

<h2>Parámetros: obligatorios, por defecto y por nombre</h2>

<pre><code>def total_con_iva(precio, iva=0.19):
    return precio + precio * iva

print(total_con_iva(10000))          # 11900.0  usa el IVA por defecto
print(total_con_iva(10000, 0.05))    # 10500.0  IVA reducido
print(total_con_iva(iva=0.0, precio=10000))   # 10000.0  por nombre</code></pre>

<ul>
  <li><strong>Obligatorios</strong> primero, <strong>con valor por defecto</strong> después. Al revés es error de sintaxis.</li>
  <li>Pasarlos <strong>por nombre</strong> hace la llamada auto-explicativa: <code>total_con_iva(precio=10000, iva=0.05)</code>.</li>
</ul>

<h3>Devolver varias cosas</h3>

<pre><code>def analizar(notas):
    return min(notas), max(notas), sum(notas) / len(notas)

menor, mayor, promedio = analizar([4.0, 2.5, 5.0])</code></pre>

<p>En realidad devuelve una tupla, y el desempaquetado del capítulo 11 la reparte.</p>

<h2>Alcance: lo que pasa adentro se queda adentro</h2>

<pre><code>def cambiar():
    total = 100        # esta es OTRA variable, solo vive aquí
    return total

total = 5
cambiar()
print(total)           # 5 — no cambió</code></pre>

<p>Las variables creadas dentro de una función son <strong>locales</strong>: nacen al llamarla y mueren al terminar. Eso es una virtud, no un estorbo: garantiza que una función no rompa nada afuera.</p>

<p>Sí puede <em>leer</em> lo de afuera, pero depender de eso es mala idea: la función deja de funcionar sola. Lo que necesite, que llegue por parámetro.</p>

<pre><code># ❌ depende de una variable de afuera
def con_iva(precio):
    return precio * IVA

# ✅ todo lo que necesita, lo recibe
def con_iva(precio, iva=0.19):
    return precio * iva</code></pre>

<h2>Documentar una función</h2>

<p>El mismo <code>''''''</code> del encabezado del programa, pero dentro de la función:</p>

<pre><code>def cuota_mensual(monto, tasa, meses):
    ''''''
    Calcula la cuota fija de un credito.

    Parametros:
        monto (int)  : valor prestado
        tasa (float) : interes mensual como proporcion (0.02 = 2%)
        meses (int)  : plazo en meses

    Retorna:
        float: valor de la cuota mensual
    ''''''
    # Formula de anualidades
    return monto * tasa / (1 - (1 + tasa) ** -meses)</code></pre>

<p>Ese bloque se llama <em>docstring</em> y es lo que aparece cuando alguien escribe <code>help(cuota_mensual)</code>.</p>

<h2>La película de una llamada</h2>

<pre><code>def con_descuento(precio, porcentaje):
    ahorro = precio * (porcentaje / 100)      # línea A
    return precio - ahorro                     # línea B

total = con_descuento(100000, 15)
print(total)</code></pre>

<table>
  <thead>
    <tr><th>Paso</th><th>Qué pasa</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>Se llama con <code>100000</code> y <code>15</code></td></tr>
    <tr><td>2</td><td>Nacen <code>precio = 100000</code> y <code>porcentaje = 15</code>, solo dentro</td></tr>
    <tr><td>3</td><td>Línea A: <code>ahorro = 15000.0</code></td></tr>
    <tr><td>4</td><td>Línea B: devuelve <code>85000.0</code> y la función termina</td></tr>
    <tr><td>5</td><td><code>precio</code>, <code>porcentaje</code> y <code>ahorro</code> dejan de existir</td></tr>
    <tr><td>6</td><td>Afuera, <code>total</code> vale <code>85000.0</code></td></tr>
  </tbody>
</table>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. <code>print</code> donde iba <code>return</code></h3>
<pre><code>def doble(x):
    print(x * 2)

r = doble(5)
print(r + 1)     # TypeError: r es None</code></pre>

<h3>2. Olvidar los paréntesis al llamar</h3>
<pre><code>print(calcular_iva)      # &lt;function calcular_iva at 0x...&gt;
print(calcular_iva(100)) # 19.0 ✅</code></pre>

<h3>3. Usar una lista como valor por defecto</h3>
<pre><code>def agregar(x, lista=[]):    # ❌ la lista se comparte entre llamadas
    lista.append(x)
    return lista

def agregar(x, lista=None):  # ✅
    if lista is None:
        lista = []
    lista.append(x)
    return lista</code></pre>
<p>Es el error más famoso de Python: el valor por defecto se crea <strong>una sola vez</strong>, al definir la función.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿Escribiste lo mismo dos veces? Es una función.</li>
  <li>Nombre en verbo: <code>calcular_iva</code>, <code>validar_cedula</code>, <code>buscar_cliente</code>.</li>
  <li>Todo lo que necesite, por parámetro. Nada de variables de afuera.</li>
  <li>Que <strong>devuelva</strong>, no que imprima. El <code>print</code> lo pone quien la llama.</li>
  <li>Una función, una responsabilidad. Si necesita "y" para explicarse, son dos.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>def f(a, b):</code></td><td>Define una función de dos parámetros</td></tr>
    <tr><td><code>return x</code></td><td>Devuelve <code>x</code> y termina</td></tr>
    <tr><td><code>def f(a, b=10):</code></td><td><code>b</code> es opcional</td></tr>
    <tr><td><code>f(b=3, a=1)</code></td><td>Argumentos por nombre</td></tr>
    <tr><td><code>return a, b</code></td><td>Devuelve una tupla</td></tr>
    <tr><td><code>''''''docstring''''''</code></td><td>Documenta la función</td></tr>
  </tbody>
</table>

<blockquote><code>print</code> le habla al usuario; <code>return</code> le habla al programa. Una función que calcula devuelve; imprimir es trabajo de quien la llama.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 4
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 14 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 14 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Función de IVA', 'facil', '<p>Escribir una función <code>calcular_iva(precio)</code> que <strong>devuelva</strong> el valor del IVA (19%) de un precio. Luego usarla para mostrar:</p><pre><code>IVA de 10000: 1900.0
IVA de 50000: 9500.0
Total a pagar: 71400.0</code></pre><p><em>Nota:</em> la función debe devolver, no imprimir. El total es la suma de los dos precios más sus IVAs.</p>', '<p>Dentro de la función va <code>return precio * 0.19</code>. Los <code>print()</code> van afuera, en quien la llama.</p>', '<pre><code>''''''
Programa: Calculadora de IVA
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Define una funcion para calcular el IVA y la usa sobre
    dos precios.
''''''

IVA = 0.19


def calcular_iva(precio):
    ''''''
    Calcula el IVA de un precio.

    Parametros:
        precio (int|float): valor sin IVA

    Retorna:
        float: el valor del IVA
    ''''''
    return precio * IVA


# Inicio
precio1 = 10000
precio2 = 50000

iva1 = calcular_iva(precio1)
iva2 = calcular_iva(precio2)

print(f"IVA de {precio1}: {iva1}")
print(f"IVA de {precio2}: {iva2}")
print(f"Total a pagar: {precio1 + iva1 + precio2 + iva2}")
# Fin</code></pre><p>La función <strong>devuelve</strong> y no imprime. Por eso el mismo <code>calcular_iva()</code> sirve para mostrarlo en pantalla y también para sumarlo al total. Si hubiera hecho <code>print()</code> adentro, no se podría usar el resultado para nada más.</p><p>Fíjese en el orden del archivo: las funciones se definen arriba y la lógica del programa va abajo, entre <code>#Inicio</code> y <code>#Fin</code>.</p>', '[{"stdin":"","expected_output":"IVA de 10000: 1900.0\nIVA de 50000: 9500.0\nTotal a pagar: 71400.0"}]', '''''''
Programa: Calculadora de IVA
Autor:
Fecha:
Descripcion:
''''''

IVA = 0.19


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Clasificar notas', 'facil', '<p>Escribir una función <code>clasificar(nota)</code> que devuelva el concepto de una nota:</p><table><thead><tr><th>Nota</th><th>Concepto</th></tr></thead><tbody><tr><td>4.5 o más</td><td>Excelente</td></tr><tr><td>4.0 a 4.4</td><td>Muy bien</td></tr><tr><td>3.0 a 3.9</td><td>Aprobado</td></tr><tr><td>menor a 3.0</td><td>Reprobado</td></tr></tbody></table><p>Usarla para clasificar la lista <code>[4.8, 4.2, 3.5, 2.0]</code>:</p><pre><code>4.8: Excelente
4.2: Muy bien
3.5: Aprobado
2.0: Reprobado</code></pre>', '<p>Como cada <code>return</code> termina la función de inmediato, no hacen falta <code>elif</code> ni <code>else</code>: basta con <code>if</code> seguidos, del más exigente al menos exigente.</p>', '<pre><code>''''''
Programa: Clasificador de notas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Define una funcion que convierte una nota en su concepto
    cualitativo y la aplica a una lista.
''''''


def clasificar(nota):
    ''''''
    Convierte una nota de 0.0 a 5.0 en su concepto.

    Parametros:
        nota (float): la nota a clasificar

    Retorna:
        str: Excelente, Muy bien, Aprobado o Reprobado
    ''''''
    # Cada return sale de la funcion, asi que no hacen falta elif
    if nota >= 4.5:
        return "Excelente"
    if nota >= 4.0:
        return "Muy bien"
    if nota >= 3.0:
        return "Aprobado"
    return "Reprobado"


# Inicio
notas = [4.8, 4.2, 3.5, 2.0]

for nota in notas:
    print(f"{nota}: {clasificar(nota)}")
# Fin</code></pre><p>Este estilo de <em>varios <code>return</code> sin <code>else</code></em> se llama <em>early return</em> y es muy común: apenas se sabe la respuesta, se devuelve. El orden sigue importando igual que en el capítulo 6: de la condición más exigente a la menos exigente.</p><p>El último <code>return</code> no necesita <code>if</code>: si el programa llegó hasta ahí es porque ninguna condición anterior se cumplió.</p>', '[{"stdin":"","expected_output":"4.8: Excelente\n4.2: Muy bien\n3.5: Aprobado\n2.0: Reprobado"}]', '''''''
Programa: Clasificador de notas
Autor:
Fecha:
Descripcion:
''''''


# Inicio
notas = [4.8, 4.2, 3.5, 2.0]

# Fin
', 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Estadísticas en una función', 'medio', '<p>Escribir una función <code>analizar(notas)</code> que reciba una lista y devuelva <strong>tres valores</strong>: la menor, la mayor y el promedio.</p><p>Escribir también <code>formatear(nombre, notas)</code> que devuelva una línea lista para imprimir usando la función anterior.</p><pre><code>Ana      min 2.5  max 5.0  prom 4.00
Juan     min 2.0  max 3.0  prom 2.50</code></pre><p><em>Nota:</em> el nombre va alineado en 8 espacios y el promedio con dos decimales. Ninguna de las dos funciones debe imprimir.</p>', '<p><code>return min(notas), max(notas), suma / cantidad</code> devuelve una tupla, y quien llama la desempaqueta con <code>a, b, c = analizar(...)</code>.</p>', '<pre><code>''''''
Programa: Estadisticas de notas con funciones
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Separa el calculo de estadisticas y el formato de la salida
    en dos funciones independientes.
''''''


def analizar(notas):
    ''''''
    Calcula estadisticas basicas de una lista de notas.

    Parametros:
        notas (list): notas de un estudiante

    Retorna:
        tuple: (menor, mayor, promedio)
    ''''''
    return min(notas), max(notas), sum(notas) / len(notas)


def formatear(nombre, notas):
    ''''''
    Arma la linea de reporte de un estudiante.

    Parametros:
        nombre (str) : nombre del estudiante
        notas (list) : sus notas

    Retorna:
        str: la linea lista para imprimir
    ''''''
    menor, mayor, promedio = analizar(notas)
    return f"{nombre:<8} min {menor}  max {mayor}  prom {promedio:.2f}"


# Inicio
curso = {
    "Ana": [4.5, 2.5, 5.0],
    "Juan": [2.0, 3.0, 2.5],
}

for nombre, notas in curso.items():
    print(formatear(nombre, notas))
# Fin</code></pre><p>Dos ideas de diseño que se ven aquí:</p><ul><li><strong>Una función, una responsabilidad.</strong> <code>analizar()</code> hace cuentas y <code>formatear()</code> arma texto. Si mañana cambia el formato del reporte, <code>analizar()</code> ni se entera.</li><li><strong>Devolver varias cosas es devolver una tupla.</strong> <code>return a, b, c</code> arma una tupla y el desempaquetado del capítulo 11 la reparte en tres variables con nombre.</li></ul><p>Ninguna de las dos imprime: el único <code>print()</code> está en el programa principal. Así estas funciones servirían igual para escribir un archivo o mandar un correo.</p>', '[{"stdin":"","expected_output":"Ana      min 2.5  max 5.0  prom 4.00\nJuan     min 2.0  max 3.0  prom 2.50"}]', '''''''
Programa: Estadisticas de notas con funciones
Autor:
Fecha:
Descripcion:
''''''


# Inicio
curso = {
    "Ana": [4.5, 2.5, 5.0],
    "Juan": [2.0, 3.0, 2.5],
}

# Fin
', 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Módulo de crédito', 'dificil', '<p>Un banco necesita tres funciones reutilizables:</p><ul><li><code>cuota_mensual(monto, tasa, meses)</code> — devuelve la cuota fija, redondeada a entero.</li><li><code>total_pagado(cuota, meses)</code> — devuelve cuánto se paga en total.</li><li><code>aprobar(ingresos, cuota, tope=0.30)</code> — devuelve <code>True</code> si la cuota no supera el porcentaje tope de los ingresos.</li></ul><p>Solicitar monto, tasa mensual (en %), plazo e ingresos. Por ejemplo, con un préstamo de <strong>1000000</strong> al <strong>2%</strong> mensual a <strong>24</strong> meses e ingresos de <strong>300000</strong>:</p><pre><code>Cuota mensual: 52,871
Total pagado: 1,268,904
Intereses: 268,904
Estado: APROBADO</code></pre><p><em>Nota:</em> la fórmula de la cuota es <code>monto * tasa / (1 - (1 + tasa) ** -meses)</code>, con la tasa como proporción.</p>', '<p>Las tres funciones se definen arriba y solo devuelven. El programa principal pide los datos, las llama y arma la salida. El <code>tope</code> lleva valor por defecto, así que se puede llamar sin él.</p>', '<pre><code>''''''
Programa: Modulo de credito
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula la cuota fija de un credito, el total pagado y si el
    solicitante lo puede sostener con sus ingresos.
''''''


def cuota_mensual(monto, tasa, meses):
    ''''''
    Calcula la cuota fija de un credito de cuota constante.

    Parametros:
        monto (int)  : valor prestado
        tasa (float) : interes mensual como proporcion (0.02 = 2%)
        meses (int)  : plazo en meses

    Retorna:
        int: valor de la cuota, redondeado
    ''''''
    # Formula de anualidades
    return round(monto * tasa / (1 - (1 + tasa) ** -meses))


def total_pagado(cuota, meses):
    ''''''
    Cuanto se termina pagando en total.

    Parametros:
        cuota (int): cuota mensual
        meses (int): plazo en meses

    Retorna:
        int: suma de todas las cuotas
    ''''''
    return cuota * meses


def aprobar(ingresos, cuota, tope=0.30):
    ''''''
    Decide si la cuota es sostenible con los ingresos.

    Parametros:
        ingresos (int): ingresos mensuales
        cuota (int)   : cuota del credito
        tope (float)  : maximo porcentaje de los ingresos permitido

    Retorna:
        bool: True si la cuota no supera el tope
    ''''''
    return cuota <= ingresos * tope


# Inicio
monto = int(input("Monto: "))
tasa = float(input("Tasa mensual (%): ")) / 100
meses = int(input("Meses: "))
ingresos = int(input("Ingresos mensuales: "))

cuota = cuota_mensual(monto, tasa, meses)
total = total_pagado(cuota, meses)

print(f"Cuota mensual: {cuota:,}")
print(f"Total pagado: {total:,}")
print(f"Intereses: {total - monto:,}")
print(f"Estado: {''APROBADO'' if aprobar(ingresos, cuota) else ''NEGADO''}")
# Fin</code></pre><p>Por qué este código es mejor que el mismo cálculo escrito de corrido:</p><ul><li><strong>Cada función se puede probar sola.</strong> <code>cuota_mensual(1000000, 0.02, 24)</code> se puede verificar contra una calculadora financiera sin correr todo el programa.</li><li><strong><code>aprobar()</code> tiene el tope por defecto.</strong> El banco normalmente usa 30%, pero si mañana quiere evaluar al 40% se llama <code>aprobar(ingresos, cuota, 0.40)</code> sin tocar la función.</li><li><strong>La conversión de porcentaje a proporción se hace una sola vez</strong>, al pedir el dato. Adentro de las funciones la tasa ya llega lista, y eso evita el error clásico de dividir entre 100 dos veces.</li></ul><p>Estas tres funciones son exactamente el tipo de pieza que en el capítulo 16 se saca a su propio archivo para importarla desde otros programas.</p>', '[{"stdin":"1000000\n2\n24\n300000\n","expected_output":"Monto: Tasa mensual (%): Meses: Ingresos mensuales: Cuota mensual: 52,871\nTotal pagado: 1,268,904\nIntereses: 268,904\nEstado: APROBADO"}]', '''''''
Programa: Modulo de credito
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 14 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la diferencia entre return y print dentro de una función?', NULL, '{"options":[{"id":"a","text":"return entrega el resultado al programa; print solo lo muestra al usuario"},{"id":"b","text":"Son equivalentes"},{"id":"c","text":"print es más rápido"},{"id":"d","text":"return solo sirve con números"}]}', '{"option_id":"a"}', 'Una función que imprime en vez de devolver no sirve para seguir calculando: su resultado se pierde.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué pasa cuando Python ejecuta un return?', NULL, '{"options":[{"id":"a","text":"Devuelve el valor y termina la función de inmediato"},{"id":"b","text":"Devuelve el valor y sigue con las líneas siguientes"},{"id":"c","text":"Termina el programa entero"},{"id":"d","text":"Guarda el valor en una variable global"}]}', '{"option_id":"a"}', 'Por eso se puede escribir varios if con return seguidos, sin elif ni else.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué es una variable local?', NULL, '{"options":[{"id":"a","text":"Una que nace dentro de la función y muere cuando esta termina"},{"id":"b","text":"Una que se puede usar en todo el programa"},{"id":"c","text":"Una que solo guarda números"},{"id":"d","text":"Una que se define con la palabra local"}]}', '{"option_id":"a"}', 'Es una virtud: garantiza que una función no rompa nada de afuera por accidente.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué es mala idea que una función lea variables de afuera en vez de recibirlas por parámetro?', NULL, '{"options":[{"id":"a","text":"Porque deja de funcionar sola: depende de que exista algo fuera de ella"},{"id":"b","text":"Porque Python lo prohíbe"},{"id":"c","text":"Porque es más lento"},{"id":"d","text":"Porque no se puede documentar"}]}', '{"option_id":"a"}', 'Una función que recibe todo lo que necesita se puede probar y reutilizar en cualquier programa.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué def agregar(x, lista=[]) es peligroso?', NULL, '{"options":[{"id":"a","text":"Porque la lista se crea una sola vez y se comparte entre todas las llamadas"},{"id":"b","text":"Porque las listas no pueden ser parámetros"},{"id":"c","text":"Porque hay que ponerla de primera"},{"id":"d","text":"Porque consume mucha memoria"}]}', '{"option_id":"a"}', 'El valor por defecto se evalúa al definir la función. La solución es usar None y crear la lista adentro.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'def doble(x):
    return x * 2

print(doble(5) + 1)', '{"options":[{"id":"a","text":"11"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'doble(5) devuelve 10 y después se le suma 1. Con print en vez de return daría TypeError.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def doble(x):
    print(x * 2)

r = doble(5)
print(r)', '{"options":[{"id":"a","text":"10\nNone"},{"id":"b","text":"10\n10"},{"id":"c","text":"None"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'La función imprime 10 pero no devuelve nada, así que r queda en None.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def total(precio, iva=0.19):
    return precio + precio * iva

print(total(10000, 0))', '{"options":[{"id":"a","text":"10000.0"},{"id":"b","text":"11900.0"},{"id":"c","text":"10000"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'El argumento explícito 0 reemplaza el valor por defecto, y el resultado es float por la multiplicación.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'def cambiar():
    total = 100

total = 5
cambiar()
print(total)', '{"options":[{"id":"a","text":"5"},{"id":"b","text":"100"},{"id":"c","text":"None"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'El total de adentro es otra variable, local a la función. La de afuera ni se entera.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'def clasificar(n):
    if n >= 3.0:
        return "pasa"
    return "no pasa"

print(clasificar(4.0), clasificar(2.0))', '{"options":[{"id":"a","text":"pasa no pasa"},{"id":"b","text":"pasa pasa"},{"id":"c","text":"no pasa no pasa"},{"id":"d","text":"pasa"}]}', '{"option_id":"a"}', 'Cada llamada es independiente: la primera sale por el primer return y la segunda llega al último.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe mostrar 19.0 pero muestra otra cosa. ¿En qué línea está el error?', NULL, '{"lines":["def iva(p):","    return p * 0.19","","print(iva)"]}', '{"line_number":4}', 'Falta llamar la función con paréntesis: print(iva(100)). Sin ellos se imprime el objeto función.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El resultado no se puede usar después. ¿En qué línea está el error?', NULL, '{"lines":["def suma(a, b):","    print(a + b)","","r = suma(2, 3)","print(r * 2)"]}', '{"line_number":2}', 'Ahí va return, no print: como está, r queda en None y la última línea da TypeError.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme la función que calcula el IVA y la usa', NULL, '{"lines":[{"id":"l1","text":"def calcular_iva(precio):","indent":0},{"id":"l2","text":"return precio * 0.19","indent":1},{"id":"l3","text":"precio = 10000","indent":0},{"id":"l4","text":"print(f\"IVA: {calcular_iva(precio)}\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'La función se define antes de usarse, el return va indentado dentro de ella, y el print va afuera.', 1, 'seed'
    FROM chapters WHERE number = 14 AND track = 'basico';

-- ── Capítulo 15: Errores y excepciones (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 15, 'Errores y excepciones', '🛡️', 'try, except, finally y errores propios.', '<p class="jc-gancho">El cajero le pide el monto al cliente y el cliente escribe "cincuenta mil". El programa se cae, la pantalla queda en negro y el cajero se traba. Ningún programa serio se comporta así: los errores se esperan y se atienden.</p>

<h2>Los errores que ya conoces</h2>

<p>Llevas catorce capítulos rompiendo cosas. Estos son los sospechosos habituales:</p>

<table>
  <thead>
    <tr><th>Error</th><th>Significa</th><th>Ejemplo típico</th></tr>
  </thead>
  <tbody>
    <tr><td><code>SyntaxError</code></td><td>Está mal escrito</td><td>Falta un <code>:</code> o un paréntesis</td></tr>
    <tr><td><code>NameError</code></td><td>Ese nombre no existe</td><td>Usar una variable antes de crearla</td></tr>
    <tr><td><code>TypeError</code></td><td>Tipos incompatibles</td><td><code>"Edad: " + 17</code></td></tr>
    <tr><td><code>ValueError</code></td><td>El tipo está bien, el contenido no</td><td><code>int("veinte")</code></td></tr>
    <tr><td><code>IndexError</code></td><td>Posición fuera de rango</td><td><code>lista[5]</code> en una de 3</td></tr>
    <tr><td><code>KeyError</code></td><td>Esa clave no está</td><td><code>precios["arroz"]</code></td></tr>
    <tr><td><code>ZeroDivisionError</code></td><td>División entre cero</td><td><code>total / cantidad</code> con cantidad en 0</td></tr>
  </tbody>
</table>

<p><strong>El <code>SyntaxError</code> es distinto a todos los demás.</strong> Ocurre antes de que el programa arranque, así que no se puede atrapar: hay que arreglarlo. Los otros ocurren <em>durante</em> la ejecución, y esos sí se pueden manejar.</p>

<h2><code>try</code> / <code>except</code>: el paracaídas</h2>

<pre><code>try:
    edad = int(input("Edad: "))
    print("El año que viene tendrás", edad + 1)
except ValueError:
    print("Eso no es un número válido")</code></pre>

<p>Cómo lo lee Python:</p>

<ol>
  <li>Intenta ejecutar todo lo que está en <code>try</code>.</li>
  <li>Si sale bien, se salta el <code>except</code> por completo.</li>
  <li>Si algo revienta con ese error, <strong>abandona el resto del <code>try</code></strong> y salta al <code>except</code>.</li>
</ol>

<p>Ese "abandona el resto" importa: si el <code>int()</code> falla, el <code>print</code> de abajo nunca corre.</p>

<h3>Varios <code>except</code></h3>

<pre><code>try:
    total = int(input("Total: "))
    cuantos = int(input("Personas: "))
    print("Cada uno paga:", total / cuantos)
except ValueError:
    print("Escriba solo números")
except ZeroDivisionError:
    print("No se puede repartir entre cero personas")</code></pre>

<p>Python entra por el primero que coincida. Como los <code>elif</code>: el orden va de lo específico a lo general.</p>

<h3><code>else</code> y <code>finally</code></h3>

<pre><code>try:
    monto = int(input("Monto: "))
except ValueError:
    print("Monto inválido")
else:
    print("Retirando", monto)      # solo si NO hubo error
finally:
    print("Gracias por usar el cajero")   # SIEMPRE, pase lo que pase</code></pre>

<table>
  <thead>
    <tr><th>Bloque</th><th>Cuándo corre</th></tr>
  </thead>
  <tbody>
    <tr><td><code>try</code></td><td>Siempre, hasta que algo falle</td></tr>
    <tr><td><code>except</code></td><td>Solo si hubo ese error</td></tr>
    <tr><td><code>else</code></td><td>Solo si NO hubo error</td></tr>
    <tr><td><code>finally</code></td><td>Siempre, haya error o no</td></tr>
  </tbody>
</table>

<p><code>finally</code> es para lo que hay que hacer sí o sí: cerrar un archivo, cerrar la conexión a la base de datos, soltar el cajero.</p>

<h2>El patrón que arregla el capítulo 3</h2>

<p>Recuerda que <code>int(input())</code> se caía si el usuario escribía cualquier cosa. Ahora se puede insistir hasta que escriba bien:</p>

<pre><code>while True:
    try:
        edad = int(input("Edad: "))
        break                          # salió bien: se sale del ciclo
    except ValueError:
        print("Eso no es un número, intente otra vez")

print("Edad registrada:", edad)</code></pre>

<table>
  <thead>
    <tr><th>Vuelta</th><th>El usuario escribe</th><th>Qué pasa</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td><code>abc</code></td><td><code>int()</code> falla → <code>except</code> → vuelve a preguntar</td></tr>
    <tr><td>2</td><td>(Enter vacío)</td><td>falla otra vez → vuelve a preguntar</td></tr>
    <tr><td>3</td><td><code>25</code></td><td>funciona → <code>break</code> → sale del ciclo</td></tr>
  </tbody>
</table>

<p>El <code>while True</code> con <code>break</code> adentro es la forma normal de escribir "insiste hasta que salga bien". Y encapsulado en una función queda reutilizable:</p>

<pre><code>def pedir_entero(mensaje):
    while True:
        try:
            return int(input(mensaje))    # el return sale del ciclo Y de la función
        except ValueError:
            print("Eso no es un número, intente otra vez")

edad = pedir_entero("Edad: ")
monto = pedir_entero("Monto: ")</code></pre>

<h2>Lanzar tus propios errores: <code>raise</code></h2>

<p>A veces el error no lo comete Python: lo comete el negocio. Un retiro negativo no revienta nada, pero está mal.</p>

<pre><code>def retirar(saldo, monto):
    if monto &lt;= 0:
        raise ValueError("El monto debe ser positivo")
    if monto &gt; saldo:
        raise ValueError("Saldo insuficiente")
    return saldo - monto


try:
    nuevo = retirar(100000, -500)
except ValueError as e:
    print("No se pudo:", e)     # No se pudo: El monto debe ser positivo</code></pre>

<p>Ese <code>as e</code> guarda el error en una variable para poder leer su mensaje. La ventaja del <code>raise</code>: la función <strong>valida</strong> y quien la llama <strong>decide qué hacer</strong> —mostrar un mensaje, reintentar, escribir en un log—. La función no tiene que saber nada de eso.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Atrapar todo con un <code>except</code> pelado</h3>
<pre><code>try:
    ...
except:              # ❌ atrapa hasta un error de tipeo tuyo
    print("Error")

except ValueError:   # ✅ solo lo que esperabas
    print("Número inválido")</code></pre>
<p>Un <code>except</code> sin tipo esconde bugs. Si de verdad quieres atrapar cualquier cosa, usa <code>except Exception as e</code> y al menos imprime <code>e</code>.</p>

<h3>2. Meter medio programa en el <code>try</code></h3>
<pre><code>try:
    # 40 líneas
except ValueError:
    print("Algo falló")     # ¿qué falló? nadie sabe</code></pre>
<p>El <code>try</code> debe rodear solo la línea que puede fallar.</p>

<h3>3. Silenciar el error</h3>
<pre><code>except ValueError:
    pass          # ❌ el programa sigue con datos inválidos</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Rodea con <code>try</code> solo lo que puede fallar de verdad.</li>
  <li>Atrapa el error <strong>específico</strong> que esperas.</li>
  <li>Para insistir: <code>while True</code> + <code>try</code> + <code>break</code> (o <code>return</code> si es función).</li>
  <li>Para reglas del negocio: <code>raise ValueError("mensaje claro")</code>.</li>
  <li>Lo que hay que hacer pase lo que pase, en <code>finally</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>try: … except X: …</code></td><td>Intenta y atiende el error X</td></tr>
    <tr><td><code>except X as e:</code></td><td>Guarda el error para leer su mensaje</td></tr>
    <tr><td><code>else:</code></td><td>Corre solo si no hubo error</td></tr>
    <tr><td><code>finally:</code></td><td>Corre siempre</td></tr>
    <tr><td><code>raise ValueError("…")</code></td><td>Lanza un error propio</td></tr>
    <tr><td><code>while True: try: … break</code></td><td>Insiste hasta que salga bien</td></tr>
  </tbody>
</table>

<blockquote>Atrapa el error que esperas, no todos. Un <code>except</code> pelado convierte un bug ruidoso en un bug silencioso, que es mucho peor.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 4
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 15 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 15 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Edad a prueba de errores', 'facil', '<p>Solicitar la edad del usuario. Si escribe algo que no es un número, avisar y volver a preguntar hasta que escriba bien:</p><pre><code>Edad: Eso no es un numero, intente otra vez
Edad: Eso no es un numero, intente otra vez
Edad: Edad registrada: 25</code></pre>', '<p><code>while True</code> con un <code>try</code> adentro. Si el <code>int()</code> funciona, un <code>break</code> sale del ciclo; si falla, el <code>except ValueError</code> imprime el aviso y el ciclo vuelve a empezar.</p>', '<pre><code>''''''
Programa: Edad a prueba de errores
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Pide la edad e insiste hasta que el usuario escriba un
    numero valido.
''''''

# Inicio
while True:
    try:
        edad = int(input("Edad: "))
        break     # solo llega aqui si el int() no fallo
    except ValueError:
        print("Eso no es un numero, intente otra vez")

print(f"Edad registrada: {edad}")
# Fin</code></pre><p>La clave está en dónde va el <code>break</code>: <strong>después</strong> del <code>int()</code>. Si la conversión falla, Python abandona el resto del <code>try</code> —incluido el <code>break</code>— y salta al <code>except</code>. Por eso el ciclo vuelve a preguntar.</p><p>Este es el patrón que le faltaba al capítulo 3, donde <code>int(input())</code> tumbaba el programa con cualquier dato raro.</p>', '[{"stdin":"abc\n\n25\n","expected_output":"Edad: Eso no es un numero, intente otra vez\nEdad: Eso no es un numero, intente otra vez\nEdad: Edad registrada: 25"}]', '''''''
Programa: Edad a prueba de errores
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'División segura', 'facil', '<p>Solicitar el total de una cuenta y el número de personas, y mostrar cuánto paga cada una. Atender los dos errores posibles:</p><ul><li>si escriben algo que no es número: <code>Escriba solo numeros</code></li><li>si el número de personas es cero: <code>No se puede repartir entre cero personas</code></li></ul><pre><code>Total: Personas: Cada uno paga: 25000.0</code></pre>', '<p>Un solo <code>try</code> con dos <code>except</code>: uno para <code>ValueError</code> y otro para <code>ZeroDivisionError</code>. Python entra por el que coincida.</p>', '<pre><code>''''''
Programa: Division segura de una cuenta
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Reparte el total de una cuenta entre varias personas
    atendiendo los errores de dato invalido y division por cero.
''''''

# Inicio
try:
    total = int(input("Total: "))
    personas = int(input("Personas: "))
    print(f"Cada uno paga: {total / personas}")
except ValueError:
    print("Escriba solo numeros")
except ZeroDivisionError:
    print("No se puede repartir entre cero personas")
# Fin</code></pre><p>Los dos errores son distintos y merecen mensajes distintos:</p><ul><li><code>ValueError</code> lo lanza <code>int()</code> cuando el texto no representa un número.</li><li><code>ZeroDivisionError</code> lo lanza la división, y solo si los dos <code>int()</code> pasaron.</li></ul><p>Un <code>except</code> pelado atraparía los dos con el mismo mensaje, y el usuario no sabría qué corregir.</p>', '[{"stdin":"100000\n4\n","expected_output":"Total: Personas: Cada uno paga: 25000.0"},{"stdin":"100000\n0\n","expected_output":"Total: Personas: No se puede repartir entre cero personas"},{"stdin":"cien mil\n","expected_output":"Total: Escriba solo numeros"}]', '''''''
Programa: Division segura de una cuenta
Autor:
Fecha:
Descripcion:
''''''

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Función que pide números', 'medio', '<p>Escribir una función <code>pedir_entero(mensaje, minimo=0)</code> que:</p><ul><li>pregunte hasta que el usuario escriba un entero válido,</li><li>y que además sea mayor o igual a <code>minimo</code>.</li></ul><p>Usarla para pedir la edad (mínimo 0) y el monto de un retiro (mínimo 10000):</p><pre><code>Edad: Debe ser un numero entero
Edad: Monto a retirar: Debe ser al menos 10000
Monto a retirar: Edad 25, retiro 50000</code></pre>', '<p>Dentro de la función, un <code>while True</code> con <code>try</code>. Cuando el valor sea válido, use <code>return</code>: eso sale del ciclo y de la función a la vez.</p>', '<pre><code>''''''
Programa: Lector de enteros validados
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Define una funcion reutilizable que pide un entero e insiste
    hasta que sea valido y cumpla un minimo.
''''''


def pedir_entero(mensaje, minimo=0):
    ''''''
    Pide un numero entero por teclado hasta que sea valido.

    Parametros:
        mensaje (str): lo que se le muestra al usuario
        minimo (int) : valor minimo aceptado

    Retorna:
        int: el numero validado
    ''''''
    while True:
        try:
            valor = int(input(mensaje))
        except ValueError:
            print("Debe ser un numero entero")
            continue

        if valor < minimo:
            print(f"Debe ser al menos {minimo}")
            continue

        # return sale del ciclo y de la funcion al mismo tiempo
        return valor


# Inicio
edad = pedir_entero("Edad: ")
monto = pedir_entero("Monto a retirar: ", 10000)

print(f"Edad {edad}, retiro {monto}")
# Fin</code></pre><p>Dos validaciones distintas conviven sin enredarse:</p><ul><li>El <code>try / except</code> atiende el error <strong>técnico</strong>: el texto no es un número.</li><li>El <code>if valor &lt; minimo</code> atiende la regla del <strong>negocio</strong>: el número es válido pero no sirve.</li></ul><p>Los dos usan <code>continue</code> para volver a preguntar, y el <code>return</code> solo se alcanza cuando el dato pasó las dos pruebas.</p><p>Empaquetarlo en una función es lo que lo vuelve útil: las mismas cinco líneas sirven para la edad, el monto y cualquier otro número del programa.</p>', '[{"stdin":"abc\n25\n500\n50000\n","expected_output":"Edad: Debe ser un numero entero\nEdad: Monto a retirar: Debe ser al menos 10000\nMonto a retirar: Edad 25, retiro 50000"}]', '''''''
Programa: Lector de enteros validados
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Cajero con reglas propias', 'dificil', '<p>Escribir una función <code>retirar(saldo, monto)</code> que devuelva el nuevo saldo, pero que lance <code>ValueError</code> con un mensaje claro si:</p><ul><li>el monto no es positivo → <code>El monto debe ser positivo</code></li><li>no es múltiplo de 10000 → <code>El cajero solo entrega multiplos de 10000</code></li><li>supera el saldo → <code>Saldo insuficiente</code></li></ul><p>El programa principal procesa una lista de retiros sobre un saldo inicial de <strong>100000</strong> y reporta cada uno:</p><pre><code>Retiro de 50000: OK, saldo 50000
Retiro de -100: RECHAZADO, El monto debe ser positivo
Retiro de 35000: RECHAZADO, El cajero solo entrega multiplos de 10000
Retiro de 90000: RECHAZADO, Saldo insuficiente
Retiro de 20000: OK, saldo 30000
Saldo final: 30000</code></pre>', '<p>La función solo valida y lanza; no imprime nada. El programa principal la llama dentro de un <code>try</code> y usa <code>except ValueError as e</code> para leer el mensaje.</p>', '<pre><code>''''''
Programa: Cajero con reglas propias
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Procesa una lista de retiros validando las reglas del cajero
    con excepciones propias.
''''''

BILLETE = 10000


def retirar(saldo, monto):
    ''''''
    Aplica un retiro validando las reglas del cajero.

    Parametros:
        saldo (int): saldo disponible
        monto (int): valor a retirar

    Retorna:
        int: el nuevo saldo

    Lanza:
        ValueError: si el monto no cumple alguna regla
    ''''''
    if monto <= 0:
        raise ValueError("El monto debe ser positivo")
    if monto % BILLETE != 0:
        raise ValueError(f"El cajero solo entrega multiplos de {BILLETE}")
    if monto > saldo:
        raise ValueError("Saldo insuficiente")

    return saldo - monto


# Inicio
saldo = 100000
retiros = [50000, -100, 35000, 90000, 20000]

for monto in retiros:
    try:
        saldo = retirar(saldo, monto)
    except ValueError as e:
        # La funcion valida; aqui se decide que hacer con el error
        print(f"Retiro de {monto}: RECHAZADO, {e}")
    else:
        print(f"Retiro de {monto}: OK, saldo {saldo}")

print(f"Saldo final: {saldo}")
# Fin</code></pre><p>El reparto de responsabilidades es lo importante:</p><ul><li><strong><code>retirar()</code> no imprime ni decide nada.</strong> Solo sabe las reglas del cajero: si algo está mal, lanza el error y se acabó su trabajo.</li><li><strong>Quien la llama decide.</strong> Aquí imprime un mensaje, pero la misma función serviría igual si hubiera que guardar el rechazo en un archivo o reintentar.</li></ul><p>Fíjese en el <code>else</code> del <code>try</code>: solo corre cuando <strong>no</strong> hubo error. Poner ese <code>print</code> dentro del <code>try</code> también funcionaría, pero mezclaría en el mismo bloque lo que puede fallar con lo que no.</p><p>Y algo sutil pero importante: cuando el retiro se rechaza, <code>saldo</code> no se toca. La asignación <code>saldo = retirar(...)</code> nunca llega a ejecutarse porque la excepción interrumpe la línea completa.</p>', '[{"stdin":"","expected_output":"Retiro de 50000: OK, saldo 50000\nRetiro de -100: RECHAZADO, El monto debe ser positivo\nRetiro de 35000: RECHAZADO, El cajero solo entrega multiplos de 10000\nRetiro de 90000: RECHAZADO, Saldo insuficiente\nRetiro de 20000: OK, saldo 30000\nSaldo final: 30000"}]', '''''''
Programa: Cajero con reglas propias
Autor:
Fecha:
Descripcion:
''''''

BILLETE = 10000


# Inicio
saldo = 100000
retiros = [50000, -100, 35000, 90000, 20000]

# Fin
', 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 15 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál de estos errores NO se puede atrapar con try/except?', NULL, '{"options":[{"id":"a","text":"SyntaxError"},{"id":"b","text":"ValueError"},{"id":"c","text":"ZeroDivisionError"},{"id":"d","text":"KeyError"}]}', '{"option_id":"a"}', 'El SyntaxError ocurre antes de que el programa arranque: hay que arreglarlo, no atraparlo.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué error lanza int("veinte")?', NULL, '{"options":[{"id":"a","text":"ValueError"},{"id":"b","text":"TypeError"},{"id":"c","text":"NameError"},{"id":"d","text":"KeyError"}]}', '{"option_id":"a"}', 'El tipo está bien (es un texto) pero el contenido no representa un entero: eso es ValueError.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuándo se ejecuta el bloque finally?', NULL, '{"options":[{"id":"a","text":"Siempre, haya error o no"},{"id":"b","text":"Solo si hubo error"},{"id":"c","text":"Solo si no hubo error"},{"id":"d","text":"Solo si se usó raise"}]}', '{"option_id":"a"}', 'Es para lo que hay que hacer sí o sí: cerrar un archivo, soltar una conexión.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué es mala práctica escribir except: sin especificar el error?', NULL, '{"options":[{"id":"a","text":"Porque atrapa hasta los bugs propios y los vuelve invisibles"},{"id":"b","text":"Porque es más lento"},{"id":"c","text":"Porque Python lo prohíbe"},{"id":"d","text":"Porque solo funciona una vez"}]}', '{"option_id":"a"}', 'Convierte un bug ruidoso en uno silencioso, que es mucho más difícil de encontrar.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Para qué sirve raise ValueError("Saldo insuficiente") dentro de una función?', NULL, '{"options":[{"id":"a","text":"Para que la función valide y quien la llama decida qué hacer"},{"id":"b","text":"Para imprimir el mensaje en pantalla"},{"id":"c","text":"Para terminar el programa"},{"id":"d","text":"Para devolver el texto como resultado"}]}', '{"option_id":"a"}', 'La función sabe las reglas; el que llama decide si muestra un mensaje, reintenta o guarda un log.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', 'El usuario escribe abc. ¿Qué imprime este programa?', 'try:
    n = int(input("n: "))
    print("ok")
except ValueError:
    print("malo")', '{"options":[{"id":"a","text":"n: malo"},{"id":"b","text":"n: ok"},{"id":"c","text":"n: ok\nmalo"},{"id":"d","text":"El programa se cae"}]}', '{"option_id":"a"}', 'Al fallar el int(), Python abandona el resto del try: el print("ok") nunca corre.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'try:
    print(10 / 0)
except ValueError:
    print("valor")
except ZeroDivisionError:
    print("division")', '{"options":[{"id":"a","text":"division"},{"id":"b","text":"valor"},{"id":"c","text":"valor\ndivision"},{"id":"d","text":"El programa se cae"}]}', '{"option_id":"a"}', 'Python entra por el except que coincide con el error, no por el primero que encuentre.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'try:
    n = int("5")
except ValueError:
    print("error")
else:
    print("bien")
finally:
    print("fin")', '{"options":[{"id":"a","text":"bien\nfin"},{"id":"b","text":"fin"},{"id":"c","text":"error\nfin"},{"id":"d","text":"bien"}]}', '{"option_id":"a"}', 'No hubo error, así que corre el else; el finally corre siempre.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'def retirar(saldo, monto):
    if monto > saldo:
        raise ValueError("Saldo insuficiente")
    return saldo - monto

saldo = 1000
try:
    saldo = retirar(saldo, 5000)
except ValueError as e:
    print(e)
print(saldo)', '{"options":[{"id":"a","text":"Saldo insuficiente\n1000"},{"id":"b","text":"Saldo insuficiente\n-4000"},{"id":"c","text":"Saldo insuficiente\nNone"},{"id":"d","text":"1000"}]}', '{"option_id":"a"}', 'La excepción interrumpe la línea completa, así que la asignación nunca ocurre y el saldo queda intacto.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El ciclo nunca termina aunque el usuario escriba bien. ¿En qué línea está el error?', NULL, '{"lines":["while True:","    try:","        edad = int(input(\"Edad: \"))","    except ValueError:","        print(\"malo\")","        break"]}', '{"line_number":6}', 'El break está en el except: sale solo cuando FALLA. Debía ir dentro del try, después del int().', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa esconde los errores. ¿En qué línea está el problema?', NULL, '{"lines":["try:","    n = int(input())","except:","    pass"]}', '{"line_number":3}', 'Un except pelado atrapa cualquier cosa, y con pass ni siquiera avisa. Debía ser except ValueError con un mensaje.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el ciclo que insiste hasta recibir un número válido', NULL, '{"lines":[{"id":"l1","text":"while True:","indent":0},{"id":"l2","text":"try:","indent":1},{"id":"l3","text":"edad = int(input(\"Edad: \"))","indent":2},{"id":"l4","text":"break","indent":2},{"id":"l5","text":"except ValueError:","indent":1},{"id":"l6","text":"print(\"Eso no es un numero\")","indent":2},{"id":"l7","text":"print(f\"Edad: {edad}\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7"]}', 'El break va dentro del try y después del int(): si la conversión falla, Python salta al except y nunca lo alcanza.', 1, 'seed'
    FROM chapters WHERE number = 15 AND track = 'basico';

-- ── Capítulo 16: Módulos, pip y entornos virtuales (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 16, 'Módulos, pip y entornos virtuales', '📚', 'Organizar el proyecto y usar librerías externas.', '<p class="jc-gancho">Las tres funciones de crédito del capítulo 14 las vas a necesitar en el simulador, en el reporte y en el proyecto final. Copiarlas en cada archivo es garantizar que un día tengas tres versiones distintas. Un módulo se escribe una vez y se importa.</p>

<h2>Un módulo es un archivo .py</h2>

<p>Eso es todo. Cualquier archivo de Python es un módulo, y sus funciones se pueden usar desde otro archivo.</p>

<pre><code># archivo: credito.py

TASA_USURA = 0.025


def cuota_mensual(monto, tasa, meses):
    return round(monto * tasa / (1 - (1 + tasa) ** -meses))


def total_pagado(cuota, meses):
    return cuota * meses</code></pre>

<pre><code># archivo: main.py (en la misma carpeta)

import credito

cuota = credito.cuota_mensual(1000000, 0.02, 24)
print(cuota, credito.TASA_USURA)</code></pre>

<h3>Las tres formas de importar</h3>

<pre><code>import credito                        # todo, con prefijo
credito.cuota_mensual(...)

from credito import cuota_mensual     # solo lo que necesito, sin prefijo
cuota_mensual(...)

import credito as cr                  # con apodo
cr.cuota_mensual(...)</code></pre>

<p>La que hay que evitar es <code>from credito import *</code>: trae todo sin que se sepa qué, y si dos módulos tienen una función con el mismo nombre, uno pisa al otro en silencio.</p>

<h2>El guardián: <code>if __name__ == "__main__"</code></h2>

<p>Cuando importas un módulo, Python <strong>ejecuta todo lo que hay en él</strong>. Si <code>credito.py</code> tuviera un <code>print()</code> suelto, ese <code>print</code> saldría cada vez que alguien lo importe.</p>

<pre><code># credito.py

def cuota_mensual(monto, tasa, meses):
    return round(monto * tasa / (1 - (1 + tasa) ** -meses))


# Esto solo corre si se ejecuta ESTE archivo directamente
if __name__ == "__main__":
    print("Prueba rápida:", cuota_mensual(1000000, 0.02, 24))</code></pre>

<p>La variable <code>__name__</code> vale <code>"__main__"</code> cuando el archivo se ejecuta directo, y el nombre del módulo cuando se importa. Es el interruptor que separa <em>"soy una librería"</em> de <em>"soy el programa"</em>.</p>

<h2>La biblioteca estándar: lo que ya viene puesto</h2>

<p>Python trae cientos de módulos sin instalar nada. Estos son los que vas a usar:</p>

<pre><code>import math
print(math.sqrt(16))       # 4.0
print(math.ceil(4.2))      # 5   redondea hacia arriba
print(math.floor(4.8))     # 4   hacia abajo
print(math.pi)             # 3.141592653589793

import random
print(random.randint(1, 6))            # dado
print(random.choice(["a", "b", "c"]))  # uno al azar

import datetime
hoy = datetime.date.today()
print(hoy)                             # 2026-03-14
print(hoy.year, hoy.month)

import statistics
print(statistics.mean([4.0, 3.0, 5.0]))    # 4.0
print(statistics.median([4.0, 3.0, 5.0]))  # 4.0</code></pre>

<p>Antes de escribir una función, vale la pena preguntarse si ya existe. Casi siempre sí.</p>

<h2>pip: instalar lo que no viene</h2>

<p>Para lo demás está <strong>PyPI</strong>, el repositorio público de paquetes, y <code>pip</code>, el programa que los instala.</p>

<pre><code>pip install requests          # instalar
pip install requests==2.31.0  # una versión exacta
pip list                      # ver qué hay instalado
pip uninstall requests        # desinstalar</code></pre>

<p>Los que aparecen más adelante en este libro:</p>

<table>
  <thead>
    <tr><th>Paquete</th><th>Para qué</th><th>Capítulo</th></tr>
  </thead>
  <tbody>
    <tr><td><code>requests</code></td><td>Hablar con APIs por internet</td><td>23</td></tr>
    <tr><td><code>pandas</code></td><td>Analizar tablas de datos</td><td>22</td></tr>
    <tr><td><code>fastapi</code></td><td>Crear tu propia API</td><td>24</td></tr>
  </tbody>
</table>

<h2>Entornos virtuales: una caja por proyecto</h2>

<p>Aquí está el problema real. El proyecto del semestre pasado usa <code>pandas 1.5</code>; el nuevo necesita <code>pandas 2.1</code>. Si instalas todo en el computador, uno de los dos se rompe.</p>

<p>Un <strong>entorno virtual</strong> es una carpeta con su propio Python y sus propios paquetes. Cada proyecto en su caja, sin pisarse.</p>

<pre><code># 1. Crear el entorno (una sola vez por proyecto)
python -m venv venv

# 2. Activarlo (cada vez que se trabaja)
venv\Scripts\activate        # Windows
source venv/bin/activate     # Mac y Linux

# 3. Instalar lo que haga falta: ya queda dentro de la caja
pip install requests

# 4. Salir
deactivate</code></pre>

<p>Sabes que está activo porque el prompt de la terminal muestra <code>(venv)</code> adelante.</p>

<h3><code>requirements.txt</code>: la lista de ingredientes</h3>

<pre><code># Guardar lo que este proyecto necesita
pip freeze &gt; requirements.txt

# En otro computador, instalar todo de un tirón
pip install -r requirements.txt</code></pre>

<p>Ese archivo <strong>sí</strong> va al repositorio. La carpeta <code>venv/</code> <strong>no</strong>: se regenera en un minuto y pesa cientos de megas. Por eso todo proyecto de Python lleva un <code>.gitignore</code> con <code>venv/</code> adentro.</p>

<h2>Cómo se organiza un proyecto de verdad</h2>

<pre><code>banco/
├── venv/                 (no va al repositorio)
├── requirements.txt
├── main.py               el programa que se ejecuta
├── credito.py            funciones de crédito
├── clientes.py           funciones de clientes
└── utils/
    ├── __init__.py       marca la carpeta como paquete
    └── formato.py</code></pre>

<pre><code>from utils.formato import pesos</code></pre>

<p>Ese <code>__init__.py</code> (puede estar vacío) es lo que convierte una carpeta en un <strong>paquete</strong> importable.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Ponerle a tu archivo el nombre de un módulo conocido</h3>
<pre><code># tu archivo se llama random.py
import random
random.randint(1, 6)      # AttributeError: se importó TU archivo</code></pre>
<p>Nunca llames a un archivo <code>random.py</code>, <code>math.py</code>, <code>json.py</code> ni <code>test.py</code>.</p>

<h3>2. Olvidar activar el entorno</h3>
<pre><code>pip install pandas        # se instaló en el sistema, no en el proyecto</code></pre>
<p>Si no ves <code>(venv)</code> en la terminal, no está activo.</p>

<h3>3. Código suelto en un módulo</h3>
<pre><code># credito.py
print("Cargando...")      # ❌ sale cada vez que alguien lo importe</code></pre>
<p>Todo lo ejecutable va bajo el <code>if __name__ == "__main__"</code>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿Vas a usar una función en dos archivos? Sácala a su propio módulo.</li>
  <li>Un módulo define; el programa principal ejecuta. Separado con <code>if __name__ == "__main__"</code>.</li>
  <li>Proyecto nuevo: <code>python -m venv venv</code>, activarlo, instalar, y <code>pip freeze &gt; requirements.txt</code>.</li>
  <li>Antes de escribir algo, revisa si ya está en la biblioteca estándar.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>import modulo</code></td><td>Trae el módulo, se usa con prefijo</td></tr>
    <tr><td><code>from modulo import f</code></td><td>Trae solo <code>f</code>, sin prefijo</td></tr>
    <tr><td><code>import modulo as m</code></td><td>Con apodo</td></tr>
    <tr><td><code>if __name__ == "__main__":</code></td><td>Solo corre si se ejecuta este archivo</td></tr>
    <tr><td><code>python -m venv venv</code></td><td>Crea el entorno virtual</td></tr>
    <tr><td><code>pip install -r requirements.txt</code></td><td>Instala todo lo del proyecto</td></tr>
    <tr><td><code>pip freeze &gt; requirements.txt</code></td><td>Guarda la lista de dependencias</td></tr>
  </tbody>
</table>

<blockquote>Un módulo define y el programa ejecuta. Si al importar tu archivo pasa <em>algo</em>, le falta el <code>if __name__ == "__main__"</code>.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 4
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 16 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 16 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Usar la biblioteca estándar', 'facil', '<p>Usando los módulos <code>math</code> y <code>statistics</code>, mostrar para la lista <code>[4.5, 3.0, 2.8, 5.0]</code>:</p><pre><code>Promedio: 3.83
Mediana: 3.75
Raiz del promedio: 1.96
Redondeado arriba: 4</code></pre><p><em>Nota:</em> los tres primeros con dos decimales.</p>', '<p><code>statistics.mean()</code> y <code>statistics.median()</code> hacen el promedio y la mediana. De <code>math</code> necesita <code>sqrt()</code> y <code>ceil()</code>.</p>', '<pre><code>''''''
Programa: Estadisticas con la biblioteca estandar
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Usa los modulos math y statistics para calcular medidas
    basicas de una lista de notas.
''''''

import math
import statistics

# Inicio
notas = [4.5, 3.0, 2.8, 5.0]

promedio = statistics.mean(notas)

print(f"Promedio: {promedio:.2f}")
print(f"Mediana: {statistics.median(notas):.2f}")
print(f"Raiz del promedio: {math.sqrt(promedio):.2f}")
print(f"Redondeado arriba: {math.ceil(promedio)}")
# Fin</code></pre><p>Los <code>import</code> van siempre arriba del archivo, después del encabezado. Antes de escribir una función propia vale la pena revisar si ya existe: <code>statistics.mean()</code> ahorra el <code>sum() / len()</code> y además maneja mejor los casos raros.</p><p><code>math.ceil()</code> redondea siempre hacia arriba, a diferencia de <code>round()</code>, que redondea al más cercano.</p>', '[{"stdin":"","expected_output":"Promedio: 3.83\nMediana: 3.75\nRaiz del promedio: 1.96\nRedondeado arriba: 4"}]', '''''''
Programa: Estadisticas con la biblioteca estandar
Autor:
Fecha:
Descripcion:
''''''


# Inicio
notas = [4.5, 3.0, 2.8, 5.0]

# Fin
', 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Simulador de dado', 'facil', '<p>Usando <code>random</code> con semilla fija <code>random.seed(42)</code>, simular <strong>10</strong> lanzamientos de un dado y mostrar los resultados y cuántas veces salió cada cara:</p><pre><code>Lanzamientos: [6, 1, 1, 6, 3, 2, 2, 2, 6, 1]
1: 3
2: 3
3: 1
6: 3</code></pre><p><em>Nota:</em> las caras se muestran ordenadas y solo las que salieron.</p>', '<p><code>random.randint(1, 6)</code> da un número entre 1 y 6 (aquí el final SÍ entra). Para contar, el patrón del capítulo 12: <code>conteo.get(cara, 0) + 1</code>.</p>', '<pre><code>''''''
Programa: Simulador de dado
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Simula diez lanzamientos de un dado y cuenta cuantas veces
    salio cada cara.
''''''

import random

LANZAMIENTOS = 10

# Inicio
# La semilla fija hace que el resultado sea siempre el mismo:
# util para probar el programa
random.seed(42)

resultados = [random.randint(1, 6) for _ in range(LANZAMIENTOS)]

conteo = {}
for cara in resultados:
    conteo[cara] = conteo.get(cara, 0) + 1

print(f"Lanzamientos: {resultados}")

for cara in sorted(conteo):
    print(f"{cara}: {conteo[cara]}")
# Fin</code></pre><p>Dos detalles:</p><ul><li><strong><code>random.seed(42)</code></strong> fija la secuencia de números "aleatorios". Sin ella, cada corrida daría algo distinto y el programa sería imposible de probar. En producción se quita.</li><li><strong><code>randint(1, 6)</code> sí incluye el 6</strong>, a diferencia de <code>range(1, 6)</code>. Es de las pocas funciones de Python donde el final entra.</li></ul><p>El guion bajo en <code>for _ in range(...)</code> es la convención para decir "esta variable no me importa, solo quiero repetir".</p>', '[{"stdin":"","expected_output":"Lanzamientos: [6, 1, 1, 6, 3, 2, 2, 2, 6, 1]\n1: 3\n2: 3\n3: 1\n6: 3"}]', '''''''
Programa: Simulador de dado
Autor:
Fecha:
Descripcion:
''''''


LANZAMIENTOS = 10

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Módulo de formato', 'medio', '<p>Escribir un módulo de utilidades con tres funciones y probarlo con el guardián <code>if __name__ == "__main__"</code>:</p><ul><li><code>pesos(valor)</code> → <code>$ 1,250,000</code></li><li><code>porcentaje(parte, total)</code> → <code>25.0%</code></li><li><code>titulo(texto)</code> → el texto centrado en 30 caracteres entre líneas de <code>=</code></li></ul><pre><code>==============================
        REPORTE DIARIO
==============================
Ventas: $ 1,250,000
Meta cumplida: 62.5%</code></pre>', '<p><code>f"{valor:,}"</code> mete el separador de miles y <code>f"{texto:^30}"</code> centra en 30 caracteres. Las funciones devuelven el texto; el <code>print()</code> va en el bloque del guardián.</p>', '<pre><code>''''''
Modulo: formato
Autor:  Ana Gomez
Fecha:  2026-03-14
Descripcion:
    Utilidades de formato para los reportes del banco.
    Se puede importar desde otros archivos o ejecutar directo
    para probarlo.
''''''

ANCHO = 30


def pesos(valor):
    ''''''
    Formatea un valor como moneda colombiana.

    Parametros:
        valor (int): el monto

    Retorna:
        str: por ejemplo "$ 1,250,000"
    ''''''
    return f"$ {valor:,}"


def porcentaje(parte, total):
    ''''''
    Calcula que porcentaje representa parte sobre total.

    Parametros:
        parte (int|float): la cantidad
        total (int|float): el total de referencia

    Retorna:
        str: por ejemplo "25.0%"
    ''''''
    return f"{parte / total * 100}%"


def titulo(texto):
    ''''''
    Arma un titulo centrado entre lineas de igual.

    Parametros:
        texto (str): el titulo

    Retorna:
        str: el bloque de tres lineas
    ''''''
    linea = "=" * ANCHO
    return f"{linea}\n{texto:^{ANCHO}}\n{linea}"


# Este bloque solo corre si se ejecuta ESTE archivo directamente.
# Si alguien hace "import formato", no sale nada.
if __name__ == "__main__":
    # Inicio
    print(titulo("REPORTE DIARIO"))
    print(f"Ventas: {pesos(1250000)}")
    print(f"Meta cumplida: {porcentaje(1250000, 2000000)}")
    # Fin</code></pre><p>Así se escribe un módulo de verdad:</p><ul><li><strong>Las funciones solo devuelven.</strong> Ninguna imprime, así que sirven igual para pantalla, archivo o correo.</li><li><strong>El guardián separa los dos usos.</strong> Ejecutado directo, muestra la demostración; importado, solo aporta sus funciones y no ensucia la salida de nadie.</li></ul><p>El formato <code>{texto:^{ANCHO}}</code> tiene llaves anidadas: el ancho también sale de una variable. Así, cambiar <code>ANCHO</code> reacomoda todo el reporte.</p>', '[{"stdin":"","expected_output":"==============================\n        REPORTE DIARIO\n==============================\nVentas: $ 1,250,000\nMeta cumplida: 62.5%"}]', '''''''
Modulo: formato
Autor:
Fecha:
Descripcion:
''''''

ANCHO = 30


if __name__ == "__main__":
    # Inicio

    # Fin
    pass
', 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Reporte con fechas', 'dificil', '<p>Un banco necesita un reporte de vencimientos. Dada la lista de créditos con su fecha de desembolso y su plazo en días:</p><pre><code>creditos = [
    ("C-001", "2026-01-15", 30),
    ("C-002", "2026-02-01", 90),
    ("C-003", "2026-03-10", 15),
]</code></pre><p>Tomando como "hoy" el <strong>2026-03-14</strong>, mostrar para cada crédito su fecha de vencimiento y su estado:</p><pre><code>C-001  vence 2026-02-14  VENCIDO hace 28 dias
C-002  vence 2026-05-02  vigente, faltan 49 dias
C-003  vence 2026-03-25  vigente, faltan 11 dias
Vencidos: 1 de 3</code></pre>', '<p><code>datetime.date.fromisoformat("2026-01-15")</code> convierte el texto en fecha. Sumar días es <code>fecha + datetime.timedelta(days=30)</code>, y restar dos fechas da un <code>timedelta</code> del que se saca <code>.days</code>.</p>', '<pre><code>''''''
Programa: Reporte de vencimientos
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Calcula la fecha de vencimiento de cada credito y reporta
    cuales ya estan vencidos.
''''''

import datetime


def vencimiento(desembolso, plazo_dias):
    ''''''
    Calcula la fecha de vencimiento de un credito.

    Parametros:
        desembolso (str) : fecha en formato YYYY-MM-DD
        plazo_dias (int) : dias de plazo

    Retorna:
        datetime.date: la fecha de vencimiento
    ''''''
    inicio = datetime.date.fromisoformat(desembolso)
    return inicio + datetime.timedelta(days=plazo_dias)


# Inicio
# En un programa real seria datetime.date.today(); aqui se fija
# para que el reporte sea siempre el mismo
HOY = datetime.date(2026, 3, 14)

creditos = [
    ("C-001", "2026-01-15", 30),
    ("C-002", "2026-02-01", 90),
    ("C-003", "2026-03-10", 15),
]

vencidos = 0

for codigo, desembolso, plazo in creditos:
    vence = vencimiento(desembolso, plazo)

    # Restar dos fechas da un timedelta: .days son los dias
    dias = (vence - HOY).days

    if dias < 0:
        vencidos += 1
        estado = f"VENCIDO hace {abs(dias)} dias"
    else:
        estado = f"vigente, faltan {dias} dias"

    print(f"{codigo}  vence {vence}  {estado}")

print(f"Vencidos: {vencidos} de {len(creditos)}")
# Fin</code></pre><p>Trabajar con fechas a mano es una trampa: los meses tienen distinta cantidad de días y existen los años bisiestos. El módulo <code>datetime</code> resuelve todo eso.</p><table><thead><tr><th>Operación</th><th>Qué devuelve</th></tr></thead><tbody><tr><td><code>date.fromisoformat("2026-01-15")</code></td><td>un <code>date</code></td></tr><tr><td><code>fecha + timedelta(days=30)</code></td><td>otro <code>date</code></td></tr><tr><td><code>fecha_a - fecha_b</code></td><td>un <code>timedelta</code>: <code>.days</code> da el número</td></tr></tbody></table><p>Dos decisiones de diseño: <code>HOY</code> se fija como constante en vez de usar <code>today()</code> para que el reporte sea reproducible, y <code>vencimiento()</code> es una función aparte porque es justo la pieza que se reutilizaría en otros reportes.</p>', '[{"stdin":"","expected_output":"C-001  vence 2026-02-14  VENCIDO hace 28 dias\nC-002  vence 2026-05-02  vigente, faltan 49 dias\nC-003  vence 2026-03-25  vigente, faltan 11 dias\nVencidos: 1 de 3"}]', '''''''
Programa: Reporte de vencimientos
Autor:
Fecha:
Descripcion:
''''''


# Inicio
creditos = [
    ("C-001", "2026-01-15", 30),
    ("C-002", "2026-02-01", 90),
    ("C-003", "2026-03-10", 15),
]

# Fin
', 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 16 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué es un módulo en Python?', NULL, '{"options":[{"id":"a","text":"Un archivo .py cuyas funciones se pueden importar desde otro archivo"},{"id":"b","text":"Una carpeta con código"},{"id":"c","text":"Un paquete que se instala con pip"},{"id":"d","text":"Una función muy larga"}]}', '{"option_id":"a"}', 'Cualquier archivo de Python ya es un módulo. No hay que hacer nada especial.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Para qué sirve un entorno virtual?', NULL, '{"options":[{"id":"a","text":"Para que cada proyecto tenga sus propios paquetes sin pisar a los demás"},{"id":"b","text":"Para que el programa corra más rápido"},{"id":"c","text":"Para ejecutar Python sin instalarlo"},{"id":"d","text":"Para subir el proyecto a internet"}]}', '{"option_id":"a"}', 'Un proyecto puede necesitar pandas 1.5 y otro pandas 2.1: cada uno en su caja.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace if __name__ == "__main__":?', NULL, '{"options":[{"id":"a","text":"Ejecuta ese bloque solo si el archivo se corre directamente, no al importarlo"},{"id":"b","text":"Define la función principal del programa"},{"id":"c","text":"Importa todos los módulos necesarios"},{"id":"d","text":"Marca dónde empieza el programa para el intérprete"}]}', '{"option_id":"a"}', 'Es el interruptor entre "soy una librería" y "soy el programa".', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál de estos archivos NO debe subirse al repositorio?', NULL, '{"options":[{"id":"a","text":"La carpeta venv/"},{"id":"b","text":"requirements.txt"},{"id":"c","text":"main.py"},{"id":"d","text":".gitignore"}]}', '{"option_id":"a"}', 'venv/ pesa cientos de megas y se regenera en un minuto con requirements.txt.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué es mala idea from modulo import *?', NULL, '{"options":[{"id":"a","text":"Porque trae todo sin que se sepa qué, y una función puede pisar a otra en silencio"},{"id":"b","text":"Porque es más lento"},{"id":"c","text":"Porque Python lo prohíbe"},{"id":"d","text":"Porque no funciona con la biblioteca estándar"}]}', '{"option_id":"a"}', 'Si dos módulos tienen una función con el mismo nombre, el último importado gana y nadie se entera.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'import math
print(math.ceil(4.2), math.floor(4.8))', '{"options":[{"id":"a","text":"5 4"},{"id":"b","text":"4 5"},{"id":"c","text":"4 4"},{"id":"d","text":"5 5"}]}', '{"option_id":"a"}', 'ceil siempre redondea hacia arriba y floor siempre hacia abajo, sin importar los decimales.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'import statistics
print(statistics.mean([4.0, 3.0, 5.0]))', '{"options":[{"id":"a","text":"4.0"},{"id":"b","text":"12.0"},{"id":"c","text":"3.0"},{"id":"d","text":"4"}]}', '{"option_id":"a"}', 'mean() es el promedio: hace el mismo sum() / len() pero con nombre propio.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'Si este archivo se importa desde otro, ¿qué imprime?', 'def saludar():
    return "hola"

if __name__ == "__main__":
    print(saludar())', '{"options":[{"id":"a","text":"Nada"},{"id":"b","text":"hola"},{"id":"c","text":"__main__"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'Al importarlo, __name__ vale el nombre del módulo, así que el bloque no corre. Solo aporta la función.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'import datetime
d = datetime.date(2026, 3, 10)
print(d + datetime.timedelta(days=15))', '{"options":[{"id":"a","text":"2026-03-25"},{"id":"b","text":"2026-03-15"},{"id":"c","text":"2026-04-10"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'timedelta suma días respetando los meses y los años bisiestos, que es justo lo difícil de hacer a mano.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este archivo se llama random.py y no funciona. ¿En qué línea está el problema?', NULL, '{"lines":["import random","","print(random.randint(1, 6))"]}', '{"line_number":1}', 'Python importa el propio archivo en vez del módulo de la biblioteca. Nunca hay que ponerle a un archivo el nombre de un módulo conocido.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Este módulo ensucia la salida de quien lo importe. ¿En qué línea está el problema?', NULL, '{"lines":["def cuota(m, t, n):","    return m * t","","print(\"Modulo cargado\")"]}', '{"line_number":4}', 'Ese print corre cada vez que alguien importe el módulo. Debía ir dentro de if __name__ == "__main__".', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme un módulo con su bloque de prueba', NULL, '{"lines":[{"id":"l1","text":"import math","indent":0},{"id":"l2","text":"def area_circulo(radio):","indent":0},{"id":"l3","text":"return math.pi * radio ** 2","indent":1},{"id":"l4","text":"if __name__ == \"__main__\":","indent":0},{"id":"l5","text":"print(area_circulo(2))","indent":1}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Los imports arriba, después las funciones, y de último el bloque del guardián con la prueba.', 1, 'seed'
    FROM chapters WHERE number = 16 AND track = 'basico';

-- ── Capítulo 17: Archivos (txt, csv, json) (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 17, 'Archivos (txt, csv, json)', '📁', 'Leer y escribir datos en disco.', '<p class="jc-gancho">Todos los programas que has escrito olvidan todo al cerrarse. El inventario, las notas, los clientes: se pierden. Un archivo es la memoria que sobrevive al programa.</p>

<h2>Abrir, usar, cerrar</h2>

<p>Trabajar con un archivo son tres pasos, y el tercero se olvida siempre. Por eso Python tiene <code>with</code>, que cierra solo:</p>

<pre><code>with open("notas.txt", "w", encoding="utf-8") as f:
    f.write("Ana,4.5\n")
    f.write("Juan,3.0\n")

# aquí el archivo YA está cerrado, aunque algo hubiera fallado adentro</code></pre>

<p>Los tres argumentos de <code>open()</code>:</p>

<table>
  <thead>
    <tr><th>Modo</th><th>Qué hace</th><th>Ojo</th></tr>
  </thead>
  <tbody>
    <tr><td><code>"r"</code></td><td>Leer (por defecto)</td><td><code>FileNotFoundError</code> si no existe</td></tr>
    <tr><td><code>"w"</code></td><td>Escribir</td><td><strong>Borra todo</strong> lo que había</td></tr>
    <tr><td><code>"a"</code></td><td>Agregar al final</td><td>Lo crea si no existe</td></tr>
    <tr><td><code>"x"</code></td><td>Crear nuevo</td><td>Falla si ya existe</td></tr>
  </tbody>
</table>

<p><code>encoding="utf-8"</code> no es opcional en la práctica: sin él, las tildes y las eñes se dañan según el sistema operativo.</p>

<h2>Leer un archivo de texto</h2>

<pre><code># Todo de una (archivos pequeños)
with open("notas.txt", encoding="utf-8") as f:
    contenido = f.read()

# Línea por línea (la forma recomendada)
with open("notas.txt", encoding="utf-8") as f:
    for linea in f:
        print(linea.strip())      # strip() quita el salto de línea final</code></pre>

<p>Recorrer el archivo con <code>for</code> lee una línea a la vez, así que funciona igual con un archivo de 10 líneas que con uno de 10 millones. <code>f.read()</code> mete todo en memoria de un golpe.</p>

<p>Ese <code>.strip()</code> es obligatorio: cada línea trae su <code>\n</code> al final, y sin quitarlo <code>"Ana\n" == "Ana"</code> da <code>False</code>.</p>

<h2>CSV: la tabla de toda la vida</h2>

<p>Un CSV es texto plano con valores separados por comas. Es lo que exporta Excel y lo que come casi todo el mundo.</p>

<pre><code>nombre,nota1,nota2
Ana,4.5,3.8
Juan,2.5,3.0</code></pre>

<p>Se podría partir con <code>.split(",")</code>, pero el módulo <code>csv</code> maneja los casos raros (comas dentro de comillas, saltos de línea en un campo):</p>

<pre><code>import csv

# Leer con encabezado: cada fila llega como diccionario
with open("notas.csv", encoding="utf-8", newline="") as f:
    for fila in csv.DictReader(f):
        print(fila["nombre"], fila["nota1"])

# Escribir
with open("salida.csv", "w", encoding="utf-8", newline="") as f:
    escritor = csv.writer(f)
    escritor.writerow(["nombre", "promedio"])
    escritor.writerow(["Ana", 4.15])</code></pre>

<p><code>newline=""</code> evita que en Windows queden renglones en blanco entre filas. Es una de esas cosas que uno copia y ya.</p>

<p><strong>Ojo:</strong> todo lo que sale de un CSV es <strong>texto</strong>, igual que <code>input()</code>. Si vas a hacer cuentas, convierte: <code>float(fila["nota1"])</code>.</p>

<h2>JSON: guardar estructuras completas</h2>

<p>El CSV solo guarda tablas planas. Cuando el dato tiene estructura —un diccionario de diccionarios, listas adentro— se usa JSON.</p>

<pre><code>import json

clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000, "activa": True},
    "1045": {"nombre": "Juan", "saldo": 80000, "activa": False},
}

# Guardar
with open("clientes.json", "w", encoding="utf-8") as f:
    json.dump(clientes, f, indent=2, ensure_ascii=False)

# Leer: vuelve a ser un diccionario de Python, con sus tipos
with open("clientes.json", encoding="utf-8") as f:
    datos = json.load(f)

print(datos["1023"]["saldo"] + 1000)     # 251000 — es un int de verdad</code></pre>

<p>Esa es la ventaja grande sobre el CSV: JSON <strong>conserva los tipos</strong>. Un número vuelve como número y un <code>True</code> vuelve como <code>True</code>.</p>

<table>
  <thead>
    <tr><th>Función</th><th>Qué hace</th></tr>
  </thead>
  <tbody>
    <tr><td><code>json.dump(obj, f)</code></td><td>Escribe al archivo</td></tr>
    <tr><td><code>json.load(f)</code></td><td>Lee del archivo</td></tr>
    <tr><td><code>json.dumps(obj)</code></td><td>Convierte a texto (con "s" de string)</td></tr>
    <tr><td><code>json.loads(texto)</code></td><td>Convierte desde texto</td></tr>
  </tbody>
</table>

<p><code>indent=2</code> lo deja legible para humanos y <code>ensure_ascii=False</code> guarda las tildes como tildes y no como <code>á</code>.</p>

<h2>Cuando el archivo no está</h2>

<p>Los archivos fallan por cosas que no dependen de ti: alguien lo borró, cambió de carpeta, no hay permisos. Es el terreno natural del capítulo 15.</p>

<pre><code>import json

def cargar_clientes(ruta):
    ''''''Devuelve los clientes guardados, o un diccionario vacío si es la
    primera vez que corre el programa.''''''
    try:
        with open(ruta, encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        return {}                     # primera vez: arranca vacío
    except json.JSONDecodeError:
        print("El archivo está dañado, se empieza de cero")
        return {}</code></pre>

<p>Ese patrón —intentar cargar, y si no hay nada empezar vacío— es exactamente lo que hace cualquier aplicación la primera vez que la abres.</p>

<h2>La película de un programa que recuerda</h2>

<pre><code>datos = cargar_clientes("clientes.json")    # 1. cargar
datos["1088"] = {"nombre": "Sofia", "saldo": 500000}   # 2. modificar

with open("clientes.json", "w", encoding="utf-8") as f:  # 3. guardar
    json.dump(datos, f, indent=2, ensure_ascii=False)</code></pre>

<table>
  <thead>
    <tr><th>Paso</th><th>Qué pasa</th><th>Si el programa se cierra aquí…</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>El archivo se vuelve un diccionario en memoria</td><td>no pasa nada</td></tr>
    <tr><td>2</td><td>Se cambia el diccionario en memoria</td><td><strong>se pierde el cambio</strong></td></tr>
    <tr><td>3</td><td>El diccionario se escribe al archivo</td><td>queda guardado</td></tr>
  </tbody>
</table>

<p>Cargar → modificar → guardar. Si olvidas el paso 3, el programa funciona perfecto… hasta que lo cierras.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Abrir en <code>"w"</code> creyendo que agrega</h3>
<pre><code>with open("datos.txt", "w") as f:    # ❌ borró todo el historial
with open("datos.txt", "a") as f:    # ✅ agrega al final</code></pre>

<h3>2. Olvidar el <code>.strip()</code></h3>
<pre><code>for linea in f:
    if linea == "fin":     # ❌ nunca es igual: la línea es "fin\n"
    if linea.strip() == "fin":   # ✅</code></pre>

<h3>3. Hacer cuentas con lo que sale de un CSV</h3>
<pre><code>total += fila["nota1"]           # ❌ concatena textos
total += float(fila["nota1"])    # ✅</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Siempre <code>with open(...)</code>: cierra solo, incluso si algo falla.</li>
  <li>Siempre <code>encoding="utf-8"</code>.</li>
  <li>¿Tabla plana? CSV. ¿Estructura con tipos? JSON.</li>
  <li>Cargar → modificar → guardar. El paso 3 no se olvida.</li>
  <li>Envuelve la lectura en <code>try / except FileNotFoundError</code>.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>with open(r, "r", encoding="utf-8") as f:</code></td><td>Abre para leer y cierra solo</td></tr>
    <tr><td><code>for linea in f:</code></td><td>Recorre línea por línea</td></tr>
    <tr><td><code>f.write(texto)</code></td><td>Escribe (hay que poner el <code>\n</code>)</td></tr>
    <tr><td><code>csv.DictReader(f)</code></td><td>Cada fila como diccionario</td></tr>
    <tr><td><code>json.dump(obj, f, indent=2)</code></td><td>Guarda estructura legible</td></tr>
    <tr><td><code>json.load(f)</code></td><td>Recupera la estructura con sus tipos</td></tr>
    <tr><td><code>except FileNotFoundError:</code></td><td>El archivo no existe todavía</td></tr>
  </tbody>
</table>

<blockquote>Modo <code>"w"</code> borra el archivo entero antes de escribir. Si querías agregar, era <code>"a"</code>. Ese descuido ha borrado muchos datos de trabajos reales.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 4
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 17 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 17 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Bitácora de ventas', 'facil', '<p>Escribir un programa que registre tres ventas en un archivo <code>ventas.txt</code>, una por línea, y luego lo lea y muestre su contenido con el total:</p><pre><code>Contenido de ventas.txt:
50000
30000
20000
Total: 100000</code></pre><p><em>Nota:</em> use <code>with open(...)</code> y <code>encoding="utf-8"</code>.</p>', '<p>Primero abrir en modo <code>"w"</code> para escribir (recuerde poner el <code>\n</code> a mano) y después en modo lectura recorriendo con <code>for linea in f</code>. No olvide <code>.strip()</code>.</p>', '<pre><code>''''''
Programa: Bitacora de ventas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Guarda las ventas del dia en un archivo de texto y luego lo
    lee para mostrar el total.
''''''

ARCHIVO = "ventas.txt"

# Inicio
ventas = [50000, 30000, 20000]

# Modo "w": crea el archivo o borra lo que hubiera
with open(ARCHIVO, "w", encoding="utf-8") as f:
    for venta in ventas:
        # write() NO agrega el salto de linea: hay que ponerlo
        f.write(f"{venta}\n")

print(f"Contenido de {ARCHIVO}:")

total = 0
with open(ARCHIVO, encoding="utf-8") as f:
    for linea in f:
        limpia = linea.strip()      # quita el salto de linea final
        print(limpia)
        total += int(limpia)        # lo que sale de un archivo es TEXTO

print(f"Total: {total}")
# Fin</code></pre><p>Tres cosas que siempre se olvidan:</p><ul><li><code>f.write()</code> no baja de línea sola: el <code>\n</code> se pone a mano.</li><li>Cada línea leída trae su <code>\n</code> pegado, por eso el <code>.strip()</code>.</li><li>Todo lo que sale de un archivo es texto, igual que <code>input()</code>: hay que convertir para sumar.</li></ul>', '[{"stdin":"","expected_output":"Contenido de ventas.txt:\n50000\n30000\n20000\nTotal: 100000"}]', '''''''
Programa: Bitacora de ventas
Autor:
Fecha:
Descripcion:
''''''

ARCHIVO = "ventas.txt"

# Inicio
ventas = [50000, 30000, 20000]

# Fin
', 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Notas en CSV', 'facil', '<p>Crear un archivo <code>notas.csv</code> con este contenido y luego leerlo con el módulo <code>csv</code> para mostrar el promedio de cada estudiante:</p><pre><code>nombre,nota1,nota2
Ana,4.5,3.8
Juan,2.5,3.0</code></pre><p>La salida esperada es:</p><pre><code>Ana: 4.15
Juan: 2.75</code></pre>', '<p><code>csv.DictReader(f)</code> entrega cada fila como diccionario usando la primera línea como encabezado. Recuerde que los valores llegan como texto: hay que convertirlos con <code>float()</code>.</p>', '<pre><code>''''''
Programa: Promedios desde un CSV
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Crea un archivo CSV de notas y lo lee para calcular el
    promedio de cada estudiante.
''''''

import csv

ARCHIVO = "notas.csv"

# Inicio
# newline="" evita renglones en blanco entre filas en Windows
with open(ARCHIVO, "w", encoding="utf-8", newline="") as f:
    escritor = csv.writer(f)
    escritor.writerow(["nombre", "nota1", "nota2"])
    escritor.writerow(["Ana", 4.5, 3.8])
    escritor.writerow(["Juan", 2.5, 3.0])

with open(ARCHIVO, encoding="utf-8", newline="") as f:
    for fila in csv.DictReader(f):
        # Todo lo que sale del CSV es texto: hay que convertir
        promedio = (float(fila["nota1"]) + float(fila["nota2"])) / 2
        print(f"{fila[''nombre'']}: {promedio}")
# Fin</code></pre><p><code>DictReader</code> usa la primera línea como nombres de columna, así que se accede por <code>fila["nombre"]</code> en vez de <code>fila[0]</code>. Si mañana alguien agrega una columna al principio, el programa sigue funcionando.</p><p>Se podría partir cada línea con <code>.split(",")</code>, pero el módulo <code>csv</code> maneja los casos raros: comas dentro de comillas, campos con saltos de línea, comillas escapadas.</p>', '[{"stdin":"","expected_output":"Ana: 4.15\nJuan: 2.75"}]', '''''''
Programa: Promedios desde un CSV
Autor:
Fecha:
Descripcion:
''''''


ARCHIVO = "notas.csv"

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Clientes en JSON', 'medio', '<p>Guardar en <code>clientes.json</code> el siguiente diccionario, volverlo a leer y aplicar un retiro de <strong>50000</strong> a la cliente <code>1023</code>, guardando el resultado:</p><pre><code>clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000},
    "1045": {"nombre": "Juan", "saldo": 80000},
}</code></pre><p>Salida esperada:</p><pre><code>Saldo antes: 250000
Saldo despues: 200000
Guardado. Total de clientes: 2</code></pre><p><em>Nota:</em> demuestre que JSON conserva los tipos haciendo la resta directamente sobre el valor leído.</p>', '<p><code>json.dump(obj, f)</code> guarda y <code>json.load(f)</code> recupera. A diferencia del CSV, el saldo vuelve como <code>int</code>: se le puede restar sin convertir.</p>', '<pre><code>''''''
Programa: Clientes en JSON
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Guarda los clientes en un archivo JSON, los recupera y
    aplica un retiro sobre uno de ellos.
''''''

import json

ARCHIVO = "clientes.json"

# Inicio
clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000},
    "1045": {"nombre": "Juan", "saldo": 80000},
}

# indent=2 lo deja legible; ensure_ascii=False respeta las tildes
with open(ARCHIVO, "w", encoding="utf-8") as f:
    json.dump(clientes, f, indent=2, ensure_ascii=False)

# Al recuperarlo vuelve a ser un diccionario de Python, con sus tipos
with open(ARCHIVO, encoding="utf-8") as f:
    datos = json.load(f)

print(f"Saldo antes: {datos[''1023''][''saldo'']}")

# El saldo es un int de verdad: se le puede restar sin convertir
datos["1023"]["saldo"] -= 50000

print(f"Saldo despues: {datos[''1023''][''saldo'']}")

# Cargar -> modificar -> GUARDAR: sin este paso el cambio se pierde
with open(ARCHIVO, "w", encoding="utf-8") as f:
    json.dump(datos, f, indent=2, ensure_ascii=False)

print(f"Guardado. Total de clientes: {len(datos)}")
# Fin</code></pre><p>La diferencia grande con el CSV: <strong>JSON conserva los tipos</strong>. El saldo vuelve como <code>int</code> y el <code>-= 50000</code> funciona directo. Con un CSV habría que convertir cada valor a mano.</p><p>Y el ciclo completo es siempre el mismo: <strong>cargar → modificar → guardar</strong>. Si se olvida el último paso, el programa funciona perfecto hasta que se cierra y todo vuelve a como estaba.</p>', '[{"stdin":"","expected_output":"Saldo antes: 250000\nSaldo despues: 200000\nGuardado. Total de clientes: 2"}]', '''''''
Programa: Clientes en JSON
Autor:
Fecha:
Descripcion:
''''''


ARCHIVO = "clientes.json"

# Inicio
clientes = {
    "1023": {"nombre": "Ana", "saldo": 250000},
    "1045": {"nombre": "Juan", "saldo": 80000},
}

# Fin
', 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Registro que sobrevive', 'dificil', '<p>Escribir un programa que lleve el registro de gastos en <code>gastos.json</code> y que funcione tanto la primera vez (cuando el archivo no existe) como las siguientes.</p><p>Debe tener tres funciones: <code>cargar(ruta)</code>, <code>guardar(ruta, datos)</code> y <code>agregar(datos, categoria, monto)</code>.</p><p>El programa registra tres gastos y muestra el informe:</p><pre><code>Primera corrida: 0 categorias
mercado: 150000
transporte: 45000
Total: 195000
Segunda corrida: 2 categorias</code></pre><p><em>Nota:</em> <code>cargar()</code> debe devolver un diccionario vacío si el archivo no existe o está dañado, sin caerse.</p>', '<p><code>cargar()</code> envuelve la lectura en <code>try / except FileNotFoundError</code> y devuelve <code>{}</code>. Para acumular por categoría, el patrón del capítulo 12: <code>datos.get(categoria, 0) + monto</code>.</p>', '<pre><code>''''''
Programa: Registro de gastos persistente
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Lleva el acumulado de gastos por categoria en un archivo
    JSON que sobrevive entre ejecuciones.
''''''

import json

ARCHIVO = "gastos.json"


def cargar(ruta):
    ''''''
    Recupera los gastos guardados.

    Parametros:
        ruta (str): archivo JSON

    Retorna:
        dict: los gastos, o {} si es la primera vez o el
              archivo esta dañado
    ''''''
    try:
        with open(ruta, encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        # Primera corrida: todavia no hay nada que cargar
        return {}
    except json.JSONDecodeError:
        print("El archivo estaba dañado, se empieza de cero")
        return {}


def guardar(ruta, datos):
    ''''''
    Escribe los gastos al archivo.

    Parametros:
        ruta (str)  : archivo JSON
        datos (dict): categoria -> total acumulado
    ''''''
    with open(ruta, "w", encoding="utf-8") as f:
        json.dump(datos, f, indent=2, ensure_ascii=False)


def agregar(datos, categoria, monto):
    ''''''
    Suma un gasto a su categoria.

    Parametros:
        datos (dict)    : gastos acumulados
        categoria (str) : nombre de la categoria
        monto (int)     : valor del gasto

    Retorna:
        dict: los datos actualizados
    ''''''
    datos[categoria] = datos.get(categoria, 0) + monto
    return datos


# Inicio
gastos = cargar(ARCHIVO)
print(f"Primera corrida: {len(gastos)} categorias")

agregar(gastos, "mercado", 120000)
agregar(gastos, "transporte", 45000)
agregar(gastos, "mercado", 30000)   # se suma a lo que ya habia

guardar(ARCHIVO, gastos)

for categoria, total in gastos.items():
    print(f"{categoria}: {total}")

print(f"Total: {sum(gastos.values())}")

# Se vuelve a cargar para comprobar que quedo guardado
print(f"Segunda corrida: {len(cargar(ARCHIVO))} categorias")
# Fin</code></pre><p>Esto ya es un programa de verdad. Tres ideas:</p><ul><li><strong><code>cargar()</code> nunca se cae.</strong> La primera vez no hay archivo, y eso no es un error: es lo normal. Devolver <code>{}</code> deja que el programa arranque vacío, igual que cualquier aplicación recién instalada.</li><li><strong>Dos <code>except</code> distintos.</strong> Que el archivo no exista y que esté corrupto son problemas diferentes y merecen respuestas diferentes.</li><li><strong>Las funciones no imprimen.</strong> <code>cargar</code>, <code>guardar</code> y <code>agregar</code> solo manejan datos; los <code>print()</code> viven en el programa principal. Así estas tres funciones se podrían usar igual desde una interfaz gráfica o una API.</li></ul><p>Fíjese en que <code>mercado</code> aparece dos veces y termina en 150000: el <code>get(categoria, 0) + monto</code> acumula en vez de reemplazar.</p>', '[{"stdin":"","expected_output":"Primera corrida: 0 categorias\nmercado: 150000\ntransporte: 45000\nTotal: 195000\nSegunda corrida: 2 categorias"}]', '''''''
Programa: Registro de gastos persistente
Autor:
Fecha:
Descripcion:
''''''


ARCHIVO = "gastos.json"


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 17 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué ventaja tiene with open(...) sobre abrir el archivo a mano?', NULL, '{"options":[{"id":"a","text":"Cierra el archivo solo, incluso si algo falla adentro"},{"id":"b","text":"Es más rápido"},{"id":"c","text":"Permite leer y escribir a la vez"},{"id":"d","text":"No necesita la ruta del archivo"}]}', '{"option_id":"a"}', 'Olvidar el .close() es el error clásico; with lo hace imposible.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué le pasa a un archivo existente si se abre en modo "w"?', NULL, '{"options":[{"id":"a","text":"Se borra todo su contenido"},{"id":"b","text":"Se agrega al final"},{"id":"c","text":"Da un error porque ya existe"},{"id":"d","text":"Se abre solo para lectura"}]}', '{"option_id":"a"}', 'Para agregar sin borrar se usa el modo "a". Este descuido ha borrado datos de trabajos reales.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál es la diferencia clave entre guardar en CSV y guardar en JSON?', NULL, '{"options":[{"id":"a","text":"JSON conserva los tipos y la estructura; el CSV lo devuelve todo como texto plano"},{"id":"b","text":"El CSV ocupa menos espacio"},{"id":"c","text":"JSON solo sirve para internet"},{"id":"d","text":"El CSV no se puede leer con Python"}]}', '{"option_id":"a"}', 'Con JSON un int vuelve como int; con CSV hay que convertir cada valor a mano.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué se usa encoding="utf-8" al abrir un archivo?', NULL, '{"options":[{"id":"a","text":"Para que las tildes y las eñes no se dañen entre sistemas operativos"},{"id":"b","text":"Para que el archivo pese menos"},{"id":"c","text":"Para poder escribir números"},{"id":"d","text":"Es obligatorio en Python 3"}]}', '{"option_id":"a"}', 'Sin él, Python usa la codificación del sistema y el mismo archivo se lee distinto en cada máquina.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'Un programa carga un JSON, modifica el diccionario y se cierra. ¿Qué pasa?', NULL, '{"options":[{"id":"a","text":"El cambio se pierde: faltó volver a guardar"},{"id":"b","text":"El cambio queda guardado automáticamente"},{"id":"c","text":"El archivo se corrompe"},{"id":"d","text":"Python lanza un error al cerrar"}]}', '{"option_id":"a"}', 'El ciclo es cargar, modificar y GUARDAR. Modificar el diccionario solo cambia la memoria.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'El archivo tiene la línea "fin". ¿Qué imprime este programa?', 'with open("d.txt", encoding="utf-8") as f:
    for linea in f:
        if linea == "fin":
            print("encontrado")
print("listo")', '{"options":[{"id":"a","text":"listo"},{"id":"b","text":"encontrado\nlisto"},{"id":"c","text":"encontrado"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'La línea leída es "fin\n", que no es igual a "fin". Faltaba el .strip().', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'import json
d = {"saldo": 250000}
texto = json.dumps(d)
vuelto = json.loads(texto)
print(vuelto["saldo"] + 1000)', '{"options":[{"id":"a","text":"251000"},{"id":"b","text":"2500001000"},{"id":"c","text":"TypeError"},{"id":"d","text":"250000"}]}', '{"option_id":"a"}', 'JSON conserva los tipos: el saldo vuelve como int y la suma es aritmética.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'El CSV tiene la columna nota1 con el valor 4.5. ¿Qué imprime?', 'import csv
with open("n.csv", encoding="utf-8", newline="") as f:
    for fila in csv.DictReader(f):
        print(fila["nota1"] + fila["nota1"])', '{"options":[{"id":"a","text":"4.54.5"},{"id":"b","text":"9.0"},{"id":"c","text":"9"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'Todo lo que sale de un CSV es texto: el + concatena. Faltaba float().', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debía agregar al historial pero lo borró. ¿En qué línea está el error?', NULL, '{"lines":["with open(\"log.txt\", \"w\", encoding=\"utf-8\") as f:","    f.write(\"nuevo registro\\n\")"]}', '{"line_number":1}', 'El modo "w" borra el archivo entero. Para agregar al final va el modo "a".', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El programa se cae la primera vez que se ejecuta. ¿En qué línea está el problema?', NULL, '{"lines":["import json","","with open(\"datos.json\", encoding=\"utf-8\") as f:","    datos = json.load(f)","","print(len(datos))"]}', '{"line_number":3}', 'Si el archivo no existe todavía, open lanza FileNotFoundError. Hay que envolverlo en try/except y devolver {}.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la función que carga un JSON sin caerse la primera vez', NULL, '{"lines":[{"id":"l1","text":"def cargar(ruta):","indent":0},{"id":"l2","text":"try:","indent":1},{"id":"l3","text":"with open(ruta, encoding=\"utf-8\") as f:","indent":2},{"id":"l4","text":"return json.load(f)","indent":3},{"id":"l5","text":"except FileNotFoundError:","indent":1},{"id":"l6","text":"return {}","indent":2}]}', '{"order":["l1","l2","l3","l4","l5","l6"]}', 'El with va dentro del try, y el except devuelve un diccionario vacío para que el programa arranque de cero.', 1, 'seed'
    FROM chapters WHERE number = 17 AND track = 'basico';

-- ── Capítulo 18: Clases y objetos (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 18, 'Clases y objetos', '🏛️', 'Modelar el mundo con atributos y métodos.', '<p class="jc-gancho">Llevas todo el libro representando una cuenta bancaria con un diccionario suelto y funciones que la reciben por parámetro. Nada impide que alguien le meta un saldo negativo o le borre el nombre. Una clase junta los datos <em>y</em> las reglas que los protegen.</p>

<h2>El molde y las galletas</h2>

<p>Una <strong>clase</strong> es el molde. Un <strong>objeto</strong> es cada galleta que sale de él.</p>

<pre><code>class CuentaBancaria:
    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def consignar(self, monto):
        self.saldo += monto
        return self.saldo


# Dos objetos, del mismo molde, independientes
cuenta_ana = CuentaBancaria("Ana", 250000)
cuenta_juan = CuentaBancaria("Juan")

cuenta_ana.consignar(50000)

print(cuenta_ana.saldo)     # 300000
print(cuenta_juan.saldo)    # 0 — a Juan no le pasó nada</code></pre>

<p>Cada objeto tiene <strong>sus propios datos</strong>. Consignarle a Ana no toca a Juan, aunque salgan del mismo molde.</p>

<h3><code>__init__</code>: el constructor</h3>

<p>Es el método que corre automáticamente al crear el objeto. Su trabajo es dejar el objeto listo para usar.</p>

<pre><code>cuenta = CuentaBancaria("Ana", 250000)
#          ↓
#     __init__(self, "Ana", 250000)</code></pre>

<h3><code>self</code>: este objeto en particular</h3>

<p><code>self</code> es la palabra que más confunde, y en el fondo es sencilla: es <strong>el objeto sobre el que se está trabajando</strong>.</p>

<pre><code>cuenta_ana.consignar(50000)
#    ↓
# consignar(cuenta_ana, 50000)   ← self es cuenta_ana</code></pre>

<p>Python lo pasa solo. Por eso <code>self</code> va siempre de primer parámetro en la definición, pero nunca se escribe al llamar.</p>

<table>
  <thead>
    <tr><th>Escribes</th><th>Qué es</th></tr>
  </thead>
  <tbody>
    <tr><td><code>self.saldo</code></td><td>Un dato <strong>del objeto</strong>: sobrevive entre llamadas</td></tr>
    <tr><td><code>saldo</code> (sin self)</td><td>Una variable local: muere al terminar el método</td></tr>
  </tbody>
</table>

<h2>Atributos y métodos</h2>

<pre><code>class CuentaBancaria:
    # Atributo de CLASE: lo comparten todos los objetos
    tasa_interes = 0.02

    def __init__(self, titular, saldo=0):
        # Atributos de INSTANCIA: uno por objeto
        self.titular = titular
        self.saldo = saldo
        self.movimientos = []

    def consignar(self, monto):
        if monto &lt;= 0:
            raise ValueError("El monto debe ser positivo")
        self.saldo += monto
        self.movimientos.append(("consignacion", monto))
        return self.saldo

    def retirar(self, monto):
        if monto &gt; self.saldo:
            raise ValueError("Saldo insuficiente")
        self.saldo -= monto
        self.movimientos.append(("retiro", monto))
        return self.saldo

    def extracto(self):
        return f"{self.titular}: {self.saldo} ({len(self.movimientos)} movimientos)"</code></pre>

<p>Fíjate en lo que acaba de pasar: las validaciones del capítulo 15 ahora viven <strong>dentro</strong> del objeto. Ya no hay forma de retirar de más, porque la única puerta para tocar el saldo es <code>retirar()</code>.</p>

<pre><code>cuenta = CuentaBancaria("Ana", 250000)
cuenta.consignar(50000)
cuenta.retirar(100000)
print(cuenta.extracto())     # Ana: 200000 (2 movimientos)</code></pre>

<h2><code>__str__</code>: cómo se ve el objeto</h2>

<pre><code>cuenta = CuentaBancaria("Ana", 250000)
print(cuenta)     # &lt;__main__.CuentaBancaria object at 0x000001&gt;  😐</code></pre>

<p>Ese mensaje no le sirve a nadie. <code>__str__</code> lo arregla:</p>

<pre><code>    def __str__(self):
        return f"Cuenta de {self.titular}: {self.saldo:,}"


print(cuenta)     # Cuenta de Ana: 250,000  ✅</code></pre>

<p>Los métodos con doble guion bajo a lado y lado se llaman <strong>métodos especiales</strong> o <em>dunder</em>, y Python los llama solo en ciertos momentos. En el capítulo 19 verás varios más.</p>

<h2>Atributos privados: la convención del guion bajo</h2>

<p>Python no tiene atributos verdaderamente privados. Lo que hay es una convención que todo el mundo respeta:</p>

<pre><code>class CuentaBancaria:
    def __init__(self, titular, saldo=0):
        self.titular = titular
        self._saldo = saldo          # el _ dice "no me toques desde afuera"

    @property
    def saldo(self):
        ''''''Se lee como un atributo, pero es un método.''''''
        return self._saldo


cuenta = CuentaBancaria("Ana", 250000)
print(cuenta.saldo)        # 250000 — sin paréntesis
cuenta.saldo = 999999      # AttributeError: no tiene setter</code></pre>

<p>Con <code>@property</code>, el saldo se lee normal pero no se puede asignar de fuera. La única forma de cambiarlo es por <code>consignar()</code> o <code>retirar()</code>, que sí validan.</p>

<h2>La película de dos objetos</h2>

<pre><code>a = CuentaBancaria("Ana", 100000)      # línea 1
b = CuentaBancaria("Juan", 100000)     # línea 2
a.retirar(30000)                       # línea 3
b.consignar(50000)                     # línea 4</code></pre>

<table>
  <thead>
    <tr><th>Después de…</th><th><code>a.saldo</code></th><th><code>b.saldo</code></th></tr>
  </thead>
  <tbody>
    <tr><td>línea 1</td><td>100000</td><td>no existe</td></tr>
    <tr><td>línea 2</td><td>100000</td><td>100000</td></tr>
    <tr><td>línea 3</td><td><strong>70000</strong></td><td>100000</td></tr>
    <tr><td>línea 4</td><td>70000</td><td><strong>150000</strong></td></tr>
  </tbody>
</table>

<p>Dos objetos del mismo molde con vidas separadas. Eso es lo que un diccionario suelto no te garantiza.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Olvidar <code>self</code></h3>
<pre><code>def consignar(monto):        # ❌ TypeError al llamarlo
def consignar(self, monto):  # ✅</code></pre>

<h3>2. Olvidar <code>self.</code> adentro</h3>
<pre><code>def consignar(self, monto):
    saldo += monto        # ❌ variable local que muere aquí
    self.saldo += monto   # ✅ el dato del objeto</code></pre>

<h3>3. Lista mutable como atributo de clase</h3>
<pre><code>class Cuenta:
    movimientos = []      # ❌ ¡compartida por TODAS las cuentas!

class Cuenta:
    def __init__(self):
        self.movimientos = []   # ✅ una por objeto</code></pre>
<p>Es el mismo error del parámetro por defecto del capítulo 14, con otro disfraz.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>¿Tienes datos que siempre viajan juntos y reglas que los cuidan? Es una clase.</li>
  <li><code>__init__</code> deja el objeto listo; todo atributo se crea ahí.</li>
  <li><code>self.</code> para lo que debe sobrevivir; sin <code>self</code> para lo temporal.</li>
  <li>Las validaciones van en los métodos: que sea imposible dejar el objeto en mal estado.</li>
  <li><code>__str__</code> siempre, para poder imprimirlo y depurar.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>class Cuenta:</code></td><td>Define el molde</td></tr>
    <tr><td><code>def __init__(self, ...):</code></td><td>Constructor</td></tr>
    <tr><td><code>self.x = valor</code></td><td>Atributo del objeto</td></tr>
    <tr><td><code>def metodo(self):</code></td><td>Método de instancia</td></tr>
    <tr><td><code>obj = Cuenta("Ana")</code></td><td>Crea un objeto</td></tr>
    <tr><td><code>obj.metodo()</code></td><td>Lo llama (self va solo)</td></tr>
    <tr><td><code>def __str__(self):</code></td><td>Cómo se ve al imprimirlo</td></tr>
    <tr><td><code>@property</code></td><td>Método que se lee como atributo</td></tr>
  </tbody>
</table>

<blockquote>Una clase no es solo datos juntos: es datos <em>más</em> las reglas que impiden dejarlos en un estado imposible.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 5
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 18 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 18 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Clase Estudiante', 'facil', '<p>Crear una clase <code>Estudiante</code> con:</p><ul><li>atributos <code>nombre</code> y <code>notas</code> (lista, vacía por defecto),</li><li>método <code>agregar_nota(nota)</code>,</li><li>método <code>promedio()</code> que devuelva 0 si no tiene notas,</li><li>y <code>__str__</code> que muestre <code>Ana: 4.15</code>.</li></ul><pre><code>Ana: 4.15
Juan: 0</code></pre>', '<p>La lista de notas debe crearse <strong>dentro</strong> de <code>__init__</code> con <code>self.notas = []</code>. Si se pone como atributo de clase, todos los estudiantes compartirían la misma lista.</p>', '<pre><code>''''''
Programa: Clase Estudiante
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela un estudiante con sus notas y el calculo de su promedio.
''''''


class Estudiante:
    ''''''Un estudiante del curso, con su lista de notas.''''''

    def __init__(self, nombre):
        self.nombre = nombre
        # La lista se crea AQUI: si fuera atributo de clase,
        # todos los estudiantes compartirian la misma
        self.notas = []

    def agregar_nota(self, nota):
        ''''''Registra una nota nueva.''''''
        self.notas.append(nota)

    def promedio(self):
        ''''''Devuelve el promedio, o 0 si todavia no tiene notas.''''''
        if not self.notas:
            return 0
        return sum(self.notas) / len(self.notas)

    def __str__(self):
        return f"{self.nombre}: {self.promedio()}"


# Inicio
ana = Estudiante("Ana")
ana.agregar_nota(4.5)
ana.agregar_nota(3.8)

juan = Estudiante("Juan")

print(ana)
print(juan)
# Fin</code></pre><p>Tres cosas que hacen que esta clase esté bien hecha:</p><ul><li><strong>La lista nace en <code>__init__</code>.</strong> Cada estudiante tiene la suya. Ese es el error del atributo de clase mutable, primo del parámetro por defecto del capítulo 14.</li><li><strong><code>promedio()</code> maneja el caso vacío.</strong> Sin ese <code>if</code>, un estudiante sin notas rompería el programa con <code>ZeroDivisionError</code>.</li><li><strong><code>__str__</code> permite <code>print(ana)</code>.</strong> Sin él saldría algo como <code>&lt;__main__.Estudiante object at 0x...&gt;</code>.</li></ul><p><code>if not self.notas</code> es la forma idiomática de preguntar "¿está vacía?": una lista vacía es falsa en Python.</p>', '[{"stdin":"","expected_output":"Ana: 4.15\nJuan: 0"}]', '''''''
Programa: Clase Estudiante
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Cuenta bancaria', 'facil', '<p>Crear una clase <code>CuentaBancaria</code> con <code>titular</code> y <code>saldo</code> (0 por defecto), y los métodos <code>consignar(monto)</code> y <code>retirar(monto)</code>. Retirar más del saldo debe lanzar <code>ValueError("Saldo insuficiente")</code>.</p><p>Demostrar que dos cuentas son independientes:</p><pre><code>Ana: 300000
Juan: 0
Ana despues del retiro: 200000
Error: Saldo insuficiente
Ana sigue en: 200000</code></pre>', '<p>Las validaciones van dentro de los métodos con <code>raise</code>. Al probarlo, envuelva el retiro grande en <code>try / except ValueError as e</code>.</p>', '<pre><code>''''''
Programa: Cuenta bancaria
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela una cuenta bancaria que valida sus propias reglas.
''''''


class CuentaBancaria:
    ''''''Una cuenta de ahorros con validacion de saldo.''''''

    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def consignar(self, monto):
        ''''''Suma un monto al saldo. Lanza ValueError si no es positivo.''''''
        if monto <= 0:
            raise ValueError("El monto debe ser positivo")
        self.saldo += monto
        return self.saldo

    def retirar(self, monto):
        ''''''Descuenta un monto. Lanza ValueError si no alcanza.''''''
        if monto > self.saldo:
            raise ValueError("Saldo insuficiente")
        self.saldo -= monto
        return self.saldo

    def __str__(self):
        return f"{self.titular}: {self.saldo}"


# Inicio
ana = CuentaBancaria("Ana", 250000)
juan = CuentaBancaria("Juan")

ana.consignar(50000)

print(ana)
print(juan)     # a Juan no le paso nada

ana.retirar(100000)
print(f"Ana despues del retiro: {ana.saldo}")

try:
    ana.retirar(999999)
except ValueError as e:
    print(f"Error: {e}")

print(f"Ana sigue en: {ana.saldo}")
# Fin</code></pre><p>Lo importante es que <strong>el objeto se protege solo</strong>. Comparado con el diccionario del capítulo 12, aquí no hay forma de dejar el saldo en negativo desde afuera: la única puerta es <code>retirar()</code>, y esa valida.</p><p>Y cuando el retiro falla, el saldo no se toca: el <code>raise</code> interrumpe el método antes de llegar al <code>self.saldo -= monto</code>.</p>', '[{"stdin":"","expected_output":"Ana: 300000\nJuan: 0\nAna despues del retiro: 200000\nError: Saldo insuficiente\nAna sigue en: 200000"}]', '''''''
Programa: Cuenta bancaria
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Producto con propiedad', 'medio', '<p>Crear una clase <code>Producto</code> con <code>nombre</code>, <code>precio</code> y <code>cantidad</code>. Debe tener:</p><ul><li>una propiedad <code>total</code> (precio × cantidad) que se lea sin paréntesis,</li><li>un método <code>vender(unidades)</code> que descuente del inventario y lance <code>ValueError</code> si no hay suficientes,</li><li>y <code>__str__</code> con el formato de la salida.</li></ul><pre><code>Pan          x20 =    100,000
Quedan 15 unidades
Total en inventario: 75,000
Error: Solo quedan 15 unidades</code></pre>', '<p><code>@property</code> encima del método hace que se lea como atributo: <code>p.total</code> en vez de <code>p.total()</code>. El total no se guarda: se calcula cada vez que se pide.</p>', '<pre><code>''''''
Programa: Producto de inventario
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela un producto de la tienda con su inventario y el valor
    total calculado.
''''''


class Producto:
    ''''''Un producto del inventario de la tienda.''''''

    def __init__(self, nombre, precio, cantidad):
        self.nombre = nombre
        self.precio = precio
        self.cantidad = cantidad

    @property
    def total(self):
        ''''''
        Valor del inventario de este producto.

        No se guarda como atributo: se calcula al pedirlo, asi
        nunca queda desactualizado cuando cambia la cantidad.
        ''''''
        return self.precio * self.cantidad

    def vender(self, unidades):
        ''''''Descuenta unidades del inventario.''''''
        if unidades > self.cantidad:
            raise ValueError(f"Solo quedan {self.cantidad} unidades")
        self.cantidad -= unidades
        return self.cantidad

    def __str__(self):
        return f"{self.nombre:<12} x{self.cantidad} = {self.total:>10,}"


# Inicio
pan = Producto("Pan", 5000, 20)
print(pan)

pan.vender(5)
print(f"Quedan {pan.cantidad} unidades")

# El total se recalcula solo: ya no son 100,000
print(f"Total en inventario: {pan.total:,}")

try:
    pan.vender(100)
except ValueError as e:
    print(f"Error: {e}")
# Fin</code></pre><p>La clave del ejercicio es <strong>por qué <code>total</code> es una propiedad y no un atributo</strong>.</p><p>Si en <code>__init__</code> se hubiera escrito <code>self.total = precio * cantidad</code>, ese valor quedaría congelado: después de vender 5 unidades seguiría diciendo 100,000, que es mentira. Como propiedad, se calcula en el momento en que se pide y siempre está al día.</p><p>La regla: <strong>lo que se puede deducir de otros datos no se guarda, se calcula</strong>. Guardarlo es crear dos versiones de la verdad.</p>', '[{"stdin":"","expected_output":"Pan          x20 =    100,000\nQuedan 15 unidades\nTotal en inventario: 75,000\nError: Solo quedan 15 unidades"}]', '''''''
Programa: Producto de inventario
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Inventario completo', 'dificil', '<p>Sobre la clase <code>Producto</code> anterior, crear una clase <code>Inventario</code> que:</p><ul><li>guarde productos en un diccionario por nombre,</li><li><code>agregar(producto)</code> — si ya existe, suma la cantidad,</li><li><code>vender(nombre, unidades)</code> — lanza <code>KeyError</code> si el producto no existe,</li><li>propiedad <code>valor_total</code>,</li><li><code>bajo_stock(minimo)</code> — devuelve la lista de nombres con menos de <code>minimo</code> unidades.</li></ul><pre><code>Pan          x30 =    150,000
Leche        x 8 =     56,000
Valor total: 206,000
Bajo stock: [''Leche'']
Error: ''Cafe'' no esta en el inventario</code></pre>', '<p><code>Inventario</code> no hereda de <code>Producto</code>: lo <em>contiene</em>. Un inventario no "es un" producto, "tiene" productos. Guárdelos en <code>self.productos = {}</code> con el nombre como clave.</p>', '<pre><code>''''''
Programa: Inventario de la tienda
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela el inventario completo de una tienda como una
    coleccion de productos.
''''''


class Producto:
    ''''''Un producto del inventario.''''''

    def __init__(self, nombre, precio, cantidad):
        self.nombre = nombre
        self.precio = precio
        self.cantidad = cantidad

    @property
    def total(self):
        ''''''Valor del inventario de este producto.''''''
        return self.precio * self.cantidad

    def vender(self, unidades):
        ''''''Descuenta unidades disponibles.''''''
        if unidades > self.cantidad:
            raise ValueError(f"Solo quedan {self.cantidad} unidades")
        self.cantidad -= unidades
        return self.cantidad

    def __str__(self):
        return f"{self.nombre:<12} x{self.cantidad:>2} = {self.total:>10,}"


class Inventario:
    ''''''
    Coleccion de productos de una tienda.

    Un inventario TIENE productos; no ES un producto. Por eso
    los contiene en vez de heredar de Producto.
    ''''''

    def __init__(self):
        self.productos = {}

    def agregar(self, producto):
        ''''''Agrega un producto, o suma cantidad si ya existia.''''''
        if producto.nombre in self.productos:
            self.productos[producto.nombre].cantidad += producto.cantidad
        else:
            self.productos[producto.nombre] = producto

    def vender(self, nombre, unidades):
        ''''''Vende unidades de un producto del inventario.''''''
        if nombre not in self.productos:
            raise KeyError(f"''{nombre}'' no esta en el inventario")
        return self.productos[nombre].vender(unidades)

    @property
    def valor_total(self):
        ''''''Suma del valor de todos los productos.''''''
        return sum(p.total for p in self.productos.values())

    def bajo_stock(self, minimo):
        ''''''Nombres de los productos con menos de `minimo` unidades.''''''
        return [p.nombre for p in self.productos.values() if p.cantidad < minimo]


# Inicio
inventario = Inventario()

inventario.agregar(Producto("Pan", 5000, 20))
inventario.agregar(Producto("Leche", 7000, 10))
inventario.agregar(Producto("Pan", 5000, 10))   # se suma al que ya habia

inventario.vender("Leche", 2)

for producto in inventario.productos.values():
    print(producto)

print(f"Valor total: {inventario.valor_total:,}")
print(f"Bajo stock: {inventario.bajo_stock(10)}")

try:
    inventario.vender("Cafe", 1)
except KeyError as e:
    # KeyError agrega comillas al mensaje: e.args[0] da el texto limpio
    print(f"Error: {e.args[0]}")
# Fin</code></pre><p>Dos clases y una decisión de diseño que se repite en todos los proyectos:</p><ul><li><strong>Composición, no herencia.</strong> <code>Inventario</code> no hereda de <code>Producto</code> porque un inventario no <em>es</em> un producto: <em>tiene</em> productos. La prueba de la frase "es un" contra "tiene un" decide casi siempre bien, y en el capítulo 19 se ve el caso contrario.</li><li><strong>Cada clase valida lo suyo.</strong> <code>Producto.vender()</code> sabe de unidades disponibles; <code>Inventario.vender()</code> sabe de productos que existen o no. Cada una lanza el error de su propio dominio y delega el resto.</li></ul><p>Ese <code>sum(p.total for p in ...)</code> es una <em>expresión generadora</em>: como la comprehension del capítulo 13, pero sin construir la lista intermedia. Para sumar es lo ideal.</p>', '[{"stdin":"","expected_output":"Pan          x30 =    150,000\nLeche        x 8 =     56,000\nValor total: 206,000\nBajo stock: [''Leche'']\nError: ''Cafe'' no esta en el inventario"}]', '''''''
Programa: Inventario de la tienda
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 18 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la diferencia entre una clase y un objeto?', NULL, '{"options":[{"id":"a","text":"La clase es el molde; el objeto es cada cosa concreta creada con ese molde"},{"id":"b","text":"Son sinónimos"},{"id":"c","text":"El objeto es el molde y la clase la copia"},{"id":"d","text":"La clase guarda datos y el objeto guarda funciones"}]}', '{"option_id":"a"}', 'Del mismo molde salen muchas galletas, y cada una tiene sus propios datos.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué es self?', NULL, '{"options":[{"id":"a","text":"El objeto concreto sobre el que se está trabajando"},{"id":"b","text":"Una palabra reservada obligatoria de Python"},{"id":"c","text":"La clase en sí misma"},{"id":"d","text":"Una variable global del programa"}]}', '{"option_id":"a"}', 'cuenta.retirar(100) es en realidad retirar(cuenta, 100): Python pasa self solo.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuándo se ejecuta __init__?', NULL, '{"options":[{"id":"a","text":"Automáticamente al crear un objeto de la clase"},{"id":"b","text":"Cada vez que se llama un método"},{"id":"c","text":"Cuando se imprime el objeto"},{"id":"d","text":"Hay que llamarlo a mano"}]}', '{"option_id":"a"}', 'Su trabajo es dejar el objeto listo para usarse: ahí se crean todos los atributos.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Para qué sirve @property?', NULL, '{"options":[{"id":"a","text":"Para que un método se lea como atributo, sin paréntesis"},{"id":"b","text":"Para hacer el atributo privado"},{"id":"c","text":"Para declarar un atributo de clase"},{"id":"d","text":"Para documentar la clase"}]}', '{"option_id":"a"}', 'Sirve para valores que se calculan al pedirlos, como el total de un producto, en vez de guardarlos desactualizados.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué un valor calculable como total = precio * cantidad conviene como propiedad y no como atributo?', NULL, '{"options":[{"id":"a","text":"Porque como atributo queda congelado y miente cuando la cantidad cambia"},{"id":"b","text":"Porque ocupa menos memoria"},{"id":"c","text":"Porque los atributos no pueden ser números"},{"id":"d","text":"Porque las propiedades son más rápidas"}]}', '{"option_id":"a"}', 'Lo que se puede deducir de otros datos se calcula, no se guarda: guardarlo crea dos versiones de la verdad.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'class Cuenta:
    def __init__(self, saldo=0):
        self.saldo = saldo

a = Cuenta(100)
b = Cuenta()
a.saldo += 50
print(a.saldo, b.saldo)', '{"options":[{"id":"a","text":"150 0"},{"id":"b","text":"150 150"},{"id":"c","text":"100 0"},{"id":"d","text":"150 100"}]}', '{"option_id":"a"}', 'Cada objeto tiene sus propios atributos: cambiar el de a no toca a b.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'class Cuenta:
    def __init__(self, saldo):
        self.saldo = saldo

    def sumar(self, x):
        saldo = self.saldo + x

c = Cuenta(100)
c.sumar(50)
print(c.saldo)', '{"options":[{"id":"a","text":"100"},{"id":"b","text":"150"},{"id":"c","text":"50"},{"id":"d","text":"None"}]}', '{"option_id":"a"}', 'Falta el self.: esa saldo es una variable local que muere al terminar el método.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'class P:
    def __init__(self, precio, cant):
        self.precio = precio
        self.cant = cant

    @property
    def total(self):
        return self.precio * self.cant

p = P(1000, 5)
p.cant = 2
print(p.total)', '{"options":[{"id":"a","text":"2000"},{"id":"b","text":"5000"},{"id":"c","text":"1000"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'La propiedad se recalcula al pedirla, así que refleja la cantidad nueva.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'class Cuenta:
    movimientos = []

    def __init__(self, nombre):
        self.nombre = nombre

a = Cuenta("Ana")
b = Cuenta("Juan")
a.movimientos.append("retiro")
print(len(b.movimientos))', '{"options":[{"id":"a","text":"1"},{"id":"b","text":"0"},{"id":"c","text":"2"},{"id":"d","text":"AttributeError"}]}', '{"option_id":"a"}', 'La lista es atributo de CLASE: la comparten todos los objetos. Debía crearse dentro de __init__.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Al llamar c.consignar(100) da TypeError. ¿En qué línea está el error?', NULL, '{"lines":["class Cuenta:","    def __init__(self, saldo):","        self.saldo = saldo","","    def consignar(monto):","        self.saldo += monto"]}', '{"line_number":5}', 'Falta self como primer parámetro: debía ser def consignar(self, monto).', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Todos los estudiantes terminan con las mismas notas. ¿En qué línea está el error?', NULL, '{"lines":["class Estudiante:","    notas = []","","    def __init__(self, nombre):","        self.nombre = nombre"]}', '{"line_number":2}', 'Esa lista es de la clase y la comparten todos. Va dentro de __init__ como self.notas = [].', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la clase CuentaBancaria con validación', NULL, '{"lines":[{"id":"l1","text":"class CuentaBancaria:","indent":0},{"id":"l2","text":"def __init__(self, titular, saldo=0):","indent":1},{"id":"l3","text":"self.titular = titular","indent":2},{"id":"l4","text":"self.saldo = saldo","indent":2},{"id":"l5","text":"def retirar(self, monto):","indent":1},{"id":"l6","text":"if monto > self.saldo:","indent":2},{"id":"l7","text":"raise ValueError(\"Saldo insuficiente\")","indent":3},{"id":"l8","text":"self.saldo -= monto","indent":2}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7","l8"]}', 'Los métodos van indentados dentro de la clase, y la validación antes de tocar el saldo: si el raise se dispara, el descuento nunca ocurre.', 1, 'seed'
    FROM chapters WHERE number = 18 AND track = 'basico';

-- ── Capítulo 19: Herencia y métodos especiales (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 19, 'Herencia y métodos especiales', '🧬', 'Reutilizar clases y personalizar su comportamiento.', '<p class="jc-gancho">El banco tiene cuentas de ahorros y cuentas corrientes. Las dos tienen titular, saldo, consignar y retirar. Lo único distinto es que la corriente permite sobregiro. ¿Copias la clase entera y cambias tres líneas? No: heredas.</p>

<h2>Herencia: partir de algo que ya existe</h2>

<pre><code>class Cuenta:
    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def consignar(self, monto):
        self.saldo += monto
        return self.saldo

    def retirar(self, monto):
        if monto &gt; self.saldo:
            raise ValueError("Saldo insuficiente")
        self.saldo -= monto
        return self.saldo


class CuentaCorriente(Cuenta):      # ← hereda de Cuenta
    def __init__(self, titular, saldo=0, sobregiro=500000):
        super().__init__(titular, saldo)     # el padre hace su parte
        self.sobregiro = sobregiro           # y esta clase agrega la suya

    def retirar(self, monto):                # ← reemplaza el del padre
        if monto &gt; self.saldo + self.sobregiro:
            raise ValueError("Supera el cupo de sobregiro")
        self.saldo -= monto
        return self.saldo</code></pre>

<pre><code>corriente = CuentaCorriente("Ana", 100000)

corriente.consignar(50000)     # heredado tal cual del padre
corriente.retirar(400000)      # el suyo propio: permite sobregiro
print(corriente.saldo)         # -250000</code></pre>

<p>Lo que pasó:</p>

<table>
  <thead>
    <tr><th>Concepto</th><th>Qué significa</th></tr>
  </thead>
  <tbody>
    <tr><td><code>class Hija(Padre)</code></td><td>La hija recibe todo lo del padre</td></tr>
    <tr><td><code>super().__init__(...)</code></td><td>Llama al constructor del padre</td></tr>
    <tr><td><strong>Sobrescribir</strong></td><td>Definir un método con el mismo nombre lo reemplaza</td></tr>
  </tbody>
</table>

<p><code>consignar()</code> no se escribió en la hija y funciona igual: se heredó. <code>retirar()</code> sí se escribió, y esa versión gana.</p>

<h3>Extender en vez de reemplazar</h3>

<p>A veces no quieres cambiar el método del padre, sino agregarle algo:</p>

<pre><code>class CuentaAhorros(Cuenta):
    def retirar(self, monto):
        if monto &gt; 1000000:
            raise ValueError("Máximo un millón por retiro")
        return super().retirar(monto)     # y ahora sí, lo del padre</code></pre>

<p>Ese <code>super().retirar(monto)</code> reutiliza la validación de saldo que ya estaba escrita. No se copia: se llama.</p>

<h2>La prueba del "es un"</h2>

<p>La pregunta para saber si algo es herencia:</p>

<ul>
  <li>Una cuenta corriente <strong>es una</strong> cuenta → herencia ✅</li>
  <li>Un inventario <strong>tiene</strong> productos → composición, no herencia ✅</li>
  <li>Un cliente <strong>tiene</strong> cuentas → composición ✅</li>
</ul>

<p>Si tienes que decir "tiene", no es herencia. Es el error más común al empezar con objetos, y produce jerarquías absurdas como <code>class Motor(Carro)</code>.</p>

<h2>Polimorfismo: distintos objetos, la misma llamada</h2>

<p>Esta es la razón de fondo por la que existe la herencia:</p>

<pre><code>cuentas = [
    CuentaAhorros("Ana", 200000),
    CuentaCorriente("Juan", 100000),
    CuentaAhorros("Sofia", 500000),
]

for cuenta in cuentas:
    cuenta.retirar(50000)     # cada una usa SU versión</code></pre>

<p>El ciclo no sabe ni le importa de qué tipo es cada cuenta. Llama <code>retirar()</code> y cada objeto hace lo suyo. Mañana entra una <code>CuentaNomina</code> nueva y este ciclo <strong>no se toca</strong>.</p>

<h2>Métodos especiales (dunder)</h2>

<p>Ya conoces <code>__init__</code> y <code>__str__</code>. Hay varios más que le enseñan a tu objeto a comportarse como los de Python:</p>

<pre><code>class Dinero:
    def __init__(self, valor):
        self.valor = valor

    def __str__(self):
        return f"$ {self.valor:,}"

    def __repr__(self):
        return f"Dinero({self.valor})"        # para el programador

    def __eq__(self, otro):
        return self.valor == otro.valor      # ==

    def __lt__(self, otro):
        return self.valor &lt; otro.valor       # &lt;  (y habilita sorted)

    def __add__(self, otro):
        return Dinero(self.valor + otro.valor)   # +

    def __len__(self):
        return len(str(self.valor))          # len()</code></pre>

<pre><code>a = Dinero(50000)
b = Dinero(30000)

print(a + b)                       # $ 80,000
print(a &gt; b)                       # True
print(sorted([a, b]))              # [Dinero(30000), Dinero(50000)]
print(Dinero(100) == Dinero(100))  # True</code></pre>

<table>
  <thead>
    <tr><th>Método</th><th>Se dispara con</th></tr>
  </thead>
  <tbody>
    <tr><td><code>__str__</code></td><td><code>print(obj)</code>, <code>str(obj)</code></td></tr>
    <tr><td><code>__repr__</code></td><td>Ver el objeto en una lista o en la consola</td></tr>
    <tr><td><code>__eq__</code></td><td><code>==</code></td></tr>
    <tr><td><code>__lt__</code></td><td><code>&lt;</code>, y con eso <code>sorted()</code></td></tr>
    <tr><td><code>__add__</code></td><td><code>+</code></td></tr>
    <tr><td><code>__len__</code></td><td><code>len(obj)</code></td></tr>
  </tbody>
</table>

<p>Sin <code>__eq__</code>, dos objetos son iguales solo si son <em>el mismo</em> objeto en memoria, aunque tengan los mismos datos.</p>

<h2>La película de una llamada heredada</h2>

<pre><code>ahorros = CuentaAhorros("Ana", 200000)
ahorros.retirar(50000)</code></pre>

<table>
  <thead>
    <tr><th>Paso</th><th>Qué hace Python</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td>Busca <code>retirar</code> en <code>CuentaAhorros</code>. Lo encuentra.</td></tr>
    <tr><td>2</td><td>Valida el tope del millón. Pasa.</td></tr>
    <tr><td>3</td><td><code>super().retirar(50000)</code> sube a <code>Cuenta</code>.</td></tr>
    <tr><td>4</td><td>Allá valida el saldo y hace el descuento.</td></tr>
    <tr><td>5</td><td>El saldo queda en 150000.</td></tr>
  </tbody>
</table>

<p>Si <code>CuentaAhorros</code> no hubiera definido <code>retirar</code>, el paso 1 no lo habría encontrado y Python habría subido directo al padre. Eso es todo el mecanismo.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Olvidar <code>super().__init__()</code></h3>
<pre><code>class CuentaCorriente(Cuenta):
    def __init__(self, titular, sobregiro):
        self.sobregiro = sobregiro     # ❌ nunca se creó self.saldo

# después: AttributeError: ''CuentaCorriente'' object has no attribute ''saldo''</code></pre>

<h3>2. Heredar cuando era "tiene un"</h3>
<pre><code>class Inventario(Producto):    # ❌ un inventario no ES un producto
class Inventario:              # ✅ los contiene
    def __init__(self):
        self.productos = {}</code></pre>

<h3>3. Copiar el método en vez de llamar a <code>super()</code></h3>
<pre><code>def retirar(self, monto):
    if monto &gt; 1000000:
        raise ValueError("Tope excedido")
    if monto &gt; self.saldo:              # ❌ copiado del padre
        raise ValueError("Saldo insuficiente")
    self.saldo -= monto

    # ✅ return super().retirar(monto)</code></pre>
<p>Si se copia, el día que cambie la regla del padre habrá dos versiones y una quedará vieja.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Antes de heredar, di la frase: ¿"<strong>es un</strong>" o "<strong>tiene un</strong>"?</li>
  <li>En el <code>__init__</code> de la hija, <code>super().__init__(...)</code> primero.</li>
  <li>Para extender un método, valida lo tuyo y termina con <code>super().metodo(...)</code>.</li>
  <li>Escribe <code>__str__</code> siempre; <code>__eq__</code> y <code>__lt__</code> cuando vayas a comparar u ordenar.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>class Hija(Padre):</code></td><td>Hereda todo lo del padre</td></tr>
    <tr><td><code>super().__init__(...)</code></td><td>Llama al constructor del padre</td></tr>
    <tr><td><code>super().metodo(...)</code></td><td>Llama la versión del padre</td></tr>
    <tr><td><code>isinstance(obj, Cuenta)</code></td><td>¿Es de esa clase o de una hija?</td></tr>
    <tr><td><code>__eq__</code> · <code>__lt__</code></td><td>Habilitan <code>==</code> y <code>sorted()</code></td></tr>
    <tr><td><code>__add__</code> · <code>__len__</code></td><td>Habilitan <code>+</code> y <code>len()</code></td></tr>
  </tbody>
</table>

<blockquote>Herencia solo cuando la frase "<em>es un</em>" es cierta. Si dices "tiene un", lo que necesitas es guardar el objeto adentro, no heredarlo.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 5
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 19 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 19 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Empleado y Gerente', 'facil', '<p>Crear una clase <code>Empleado</code> con <code>nombre</code> y <code>salario</code>, y un método <code>pago_mensual()</code> que devuelva el salario.</p><p>Crear <code>Gerente(Empleado)</code> que además tenga <code>bono</code> y cuyo <code>pago_mensual()</code> sume el bono.</p><pre><code>Ana gana 2,000,000
Juan gana 5,500,000</code></pre>', '<p>En el <code>__init__</code> del gerente, primero <code>super().__init__(nombre, salario)</code> y después <code>self.bono = bono</code>.</p>', '<pre><code>''''''
Programa: Empleados y gerentes
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela empleados y gerentes usando herencia.
''''''


class Empleado:
    ''''''Un empleado con salario fijo.''''''

    def __init__(self, nombre, salario):
        self.nombre = nombre
        self.salario = salario

    def pago_mensual(self):
        ''''''Lo que se le paga este mes.''''''
        return self.salario

    def __str__(self):
        return f"{self.nombre} gana {self.pago_mensual():,}"


class Gerente(Empleado):
    ''''''Un gerente ES un empleado, con bono adicional.''''''

    def __init__(self, nombre, salario, bono):
        # El padre hace su parte primero
        super().__init__(nombre, salario)
        # y aqui se agrega lo propio
        self.bono = bono

    def pago_mensual(self):
        ''''''Salario mas el bono del cargo.''''''
        return self.salario + self.bono


# Inicio
ana = Empleado("Ana", 2000000)
juan = Gerente("Juan", 5000000, 500000)

print(ana)
print(juan)
# Fin</code></pre><p>Fíjese en algo elegante: <code>__str__</code> se escribió <strong>una sola vez</strong>, en el padre, y funciona para los dos. Como llama a <code>self.pago_mensual()</code>, cada objeto usa su propia versión: Ana la del empleado y Juan la del gerente.</p><p>Eso es polimorfismo: el mismo código sirve para tipos distintos porque cada uno responde a su manera.</p>', '[{"stdin":"","expected_output":"Ana gana 2,000,000\nJuan gana 5,500,000"}]', '''''''
Programa: Empleados y gerentes
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Cuenta corriente con sobregiro', 'facil', '<p>Sobre una clase <code>Cuenta</code> con <code>consignar()</code> y <code>retirar()</code> (que no permite quedar en negativo), crear <code>CuentaCorriente</code> con un cupo de sobregiro de <strong>500000</strong>.</p><pre><code>Ahorros de Ana: 150000
Error en ahorros: Saldo insuficiente
Corriente de Juan: -250000
Error en corriente: Supera el cupo de sobregiro</code></pre>', '<p>La hija sobrescribe <code>retirar()</code> completo, porque su regla es distinta: compara contra <code>self.saldo + self.sobregiro</code>.</p>', '<pre><code>''''''
Programa: Cuentas de ahorros y corriente
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela dos tipos de cuenta con reglas de retiro distintas
    usando herencia.
''''''


class Cuenta:
    ''''''Cuenta bancaria basica: no permite quedar en negativo.''''''

    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def consignar(self, monto):
        self.saldo += monto
        return self.saldo

    def retirar(self, monto):
        if monto > self.saldo:
            raise ValueError("Saldo insuficiente")
        self.saldo -= monto
        return self.saldo


class CuentaCorriente(Cuenta):
    ''''''Una cuenta corriente ES una cuenta, pero admite sobregiro.''''''

    def __init__(self, titular, saldo=0, sobregiro=500000):
        super().__init__(titular, saldo)
        self.sobregiro = sobregiro

    def retirar(self, monto):
        ''''''Sobrescribe la regla: puede bajar hasta -sobregiro.''''''
        if monto > self.saldo + self.sobregiro:
            raise ValueError("Supera el cupo de sobregiro")
        self.saldo -= monto
        return self.saldo


# Inicio
ahorros = Cuenta("Ana", 200000)
corriente = CuentaCorriente("Juan", 100000)

ahorros.retirar(50000)
print(f"Ahorros de {ahorros.titular}: {ahorros.saldo}")

try:
    ahorros.retirar(999999)
except ValueError as e:
    print(f"Error en ahorros: {e}")

# La corriente si puede quedar en negativo
corriente.retirar(350000)
print(f"Corriente de {corriente.titular}: {corriente.saldo}")

try:
    corriente.retirar(999999)
except ValueError as e:
    print(f"Error en corriente: {e}")
# Fin</code></pre><p><code>consignar()</code> no aparece en <code>CuentaCorriente</code> y funciona igual: se heredó tal cual. Solo se sobrescribió lo que de verdad cambia.</p><p>Aquí la hija <strong>reemplaza</strong> el método en vez de extenderlo con <code>super()</code>, porque su regla no es "lo del padre más algo", sino una condición distinta.</p>', '[{"stdin":"","expected_output":"Ahorros de Ana: 150000\nError en ahorros: Saldo insuficiente\nCorriente de Juan: -250000\nError en corriente: Supera el cupo de sobregiro"}]', '''''''
Programa: Cuentas de ahorros y corriente
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Clase Dinero con operadores', 'medio', '<p>Crear una clase <code>Dinero</code> que guarde un valor en pesos y sepa comportarse como un número:</p><ul><li><code>__str__</code> → <code>$ 50,000</code></li><li><code>__repr__</code> → <code>Dinero(50000)</code></li><li><code>__eq__</code>, <code>__lt__</code> y <code>__add__</code></li></ul><pre><code>$ 80,000
True
False
[Dinero(20000), Dinero(30000), Dinero(50000)]
El mayor es $ 50,000</code></pre>', '<p><code>__add__</code> debe devolver un <code>Dinero</code> nuevo, no un número suelto. Con <code>__lt__</code> definido, <code>sorted()</code> y <code>max()</code> funcionan solos.</p>', '<pre><code>''''''
Programa: Clase Dinero
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Modela un valor en pesos que se puede sumar, comparar y
    ordenar como si fuera un numero.
''''''


class Dinero:
    ''''''Un valor en pesos colombianos.''''''

    def __init__(self, valor):
        self.valor = valor

    def __str__(self):
        ''''''Como se ve para el usuario.''''''
        return f"$ {self.valor:,}"

    def __repr__(self):
        ''''''Como se ve para el programador, en listas y en la consola.''''''
        return f"Dinero({self.valor})"

    def __eq__(self, otro):
        return self.valor == otro.valor

    def __lt__(self, otro):
        ''''''Con esto ya funcionan sorted(), min() y max().''''''
        return self.valor < otro.valor

    def __add__(self, otro):
        ''''''Devuelve un Dinero nuevo, no un numero suelto.''''''
        return Dinero(self.valor + otro.valor)


# Inicio
a = Dinero(50000)
b = Dinero(30000)
c = Dinero(20000)

print(a + b)
print(a > b)
print(Dinero(100) == Dinero(200))
print(sorted([a, b, c]))
print(f"El mayor es {max([a, b, c])}")
# Fin</code></pre><p>Tres detalles que valen la pena:</p><ul><li><strong><code>__str__</code> y <code>__repr__</code> son distintos.</strong> El primero es para el usuario (<code>print</code>); el segundo para el programador, y es el que se ve dentro de una lista. Por eso <code>sorted()</code> muestra <code>Dinero(20000)</code> y no <code>$ 20,000</code>.</li><li><strong>Con solo <code>__lt__</code> alcanza.</strong> Python deduce <code>&gt;</code> invirtiendo la comparación, y <code>sorted()</code>, <code>min()</code> y <code>max()</code> quedan habilitados.</li><li><strong><code>__add__</code> devuelve un objeto nuevo.</strong> Si devolviera <code>self.valor + otro.valor</code>, el resultado sería un <code>int</code> pelado y se perdería el formato.</li></ul>', '[{"stdin":"","expected_output":"$ 80,000\nTrue\nFalse\n[Dinero(20000), Dinero(30000), Dinero(50000)]\nEl mayor es $ 50,000"}]', '''''''
Programa: Clase Dinero
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Nómina polimórfica', 'dificil', '<p>Una empresa paga de tres formas distintas:</p><ul><li><code>Asalariado</code>: salario fijo.</li><li><code>PorHoras</code>: valor hora × horas, y las horas sobre 160 se pagan con recargo del 25%.</li><li><code>Comisionista</code>: básico + porcentaje de sus ventas.</li></ul><p>Todos heredan de <code>Empleado</code>, que define <code>pago_mensual()</code> y el descuento de salud y pensión (8% del pago).</p><p>Procesar la nómina completa:</p><pre><code>Ana          asalariado    2,000,000   neto 1,840,000
Juan         por horas     1,850,000   neto 1,702,000
Sofia        comisionista  2,300,000   neto 2,116,000
Total nomina: 6,150,000
Total neto: 5,658,000</code></pre><p><em>Nota:</em> el ciclo que procesa la nómina no debe preguntar de qué tipo es cada empleado.</p>', '<p><code>Empleado.pago_mensual()</code> puede lanzar <code>NotImplementedError</code> para obligar a las hijas a definirlo. El método <code>neto()</code> se escribe una sola vez en el padre y sirve para todas.</p>', '<pre><code>''''''
Programa: Nomina polimorfica
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Procesa la nomina de empleados con tres esquemas de pago
    distintos usando herencia y polimorfismo.
''''''

DESCUENTOS = 0.08
HORAS_BASE = 160
RECARGO_EXTRA = 1.25


class Empleado:
    ''''''
    Base de todos los empleados.

    Define lo comun (nombre, descuentos, formato) y deja el
    calculo del pago a cada hija.
    ''''''

    tipo = "empleado"

    def __init__(self, nombre):
        self.nombre = nombre

    def pago_mensual(self):
        ''''''Cada tipo de empleado calcula el suyo.''''''
        raise NotImplementedError("Cada tipo de empleado define su pago")

    def neto(self):
        ''''''
        Pago menos salud y pension.

        Se escribe UNA vez y sirve para todos, porque llama a
        self.pago_mensual(), que cada hija resuelve a su manera.
        ''''''
        pago = self.pago_mensual()
        return round(pago - pago * DESCUENTOS)

    def __str__(self):
        return (
            f"{self.nombre:<12} {self.tipo:<13} "
            f"{self.pago_mensual():>9,}   neto {self.neto():>9,}"
        )


class Asalariado(Empleado):
    ''''''Salario fijo mensual.''''''

    tipo = "asalariado"

    def __init__(self, nombre, salario):
        super().__init__(nombre)
        self.salario = salario

    def pago_mensual(self):
        return self.salario


class PorHoras(Empleado):
    ''''''Pago por hora, con recargo sobre las horas extra.''''''

    tipo = "por horas"

    def __init__(self, nombre, valor_hora, horas):
        super().__init__(nombre)
        self.valor_hora = valor_hora
        self.horas = horas

    def pago_mensual(self):
        if self.horas <= HORAS_BASE:
            return self.valor_hora * self.horas

        # Las horas sobre la base se pagan con recargo
        extras = self.horas - HORAS_BASE
        normal = self.valor_hora * HORAS_BASE
        return round(normal + extras * self.valor_hora * RECARGO_EXTRA)


class Comisionista(Empleado):
    ''''''Basico mas un porcentaje de las ventas.''''''

    tipo = "comisionista"

    def __init__(self, nombre, basico, ventas, comision):
        super().__init__(nombre)
        self.basico = basico
        self.ventas = ventas
        self.comision = comision

    def pago_mensual(self):
        return round(self.basico + self.ventas * self.comision)


# Inicio
nomina = [
    Asalariado("Ana", 2000000),
    PorHoras("Juan", 10000, 180),
    Comisionista("Sofia", 1500000, 8000000, 0.10),
]

total = 0
total_neto = 0

# Este ciclo NO pregunta de que tipo es cada empleado:
# cada objeto sabe calcular lo suyo
for empleado in nomina:
    print(empleado)
    total += empleado.pago_mensual()
    total_neto += empleado.neto()

print(f"Total nomina: {total:,}")
print(f"Total neto: {total_neto:,}")
# Fin</code></pre><p>Este ejercicio muestra por qué existe la herencia. Tres ideas:</p><ul><li><strong><code>neto()</code> se escribió una sola vez.</strong> Aunque cada tipo calcule su pago distinto, el descuento del 8% es igual para todos. Como <code>neto()</code> llama a <code>self.pago_mensual()</code>, cada objeto aporta su propia cuenta.</li><li><strong><code>raise NotImplementedError</code> es un contrato.</strong> Le dice a quien cree una clase hija: "tienes que definir este método". Si alguien crea un tipo nuevo y lo olvida, el error se lo dice de una en vez de dar un resultado silenciosamente equivocado.</li><li><strong>El ciclo final no tiene ni un <code>if</code>.</strong> No pregunta el tipo de empleado, y ese es justo el punto: mañana entra <code>PorProyecto</code> y este ciclo <strong>no se toca</strong>.</li></ul><p>Compárelo con la alternativa sin objetos: un <code>if tipo == "asalariado" ... elif tipo == "por_horas" ...</code> que habría que ampliar cada vez que aparece un esquema de pago nuevo, en todos los sitios donde se calcule algo.</p>', '[{"stdin":"","expected_output":"Ana          asalariado    2,000,000   neto 1,840,000\nJuan         por horas     1,850,000   neto 1,702,000\nSofia        comisionista  2,300,000   neto 2,116,000\nTotal nomina: 6,150,000\nTotal neto: 5,658,000"}]', '''''''
Programa: Nomina polimorfica
Autor:
Fecha:
Descripcion:
''''''

DESCUENTOS = 0.08
HORAS_BASE = 160
RECARGO_EXTRA = 1.25


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 19 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuándo conviene usar herencia?', NULL, '{"options":[{"id":"a","text":"Cuando la frase \"la hija ES un padre\" es cierta"},{"id":"b","text":"Siempre que dos clases compartan código"},{"id":"c","text":"Cuando una clase necesita usar otra"},{"id":"d","text":"Cuando hay muchas clases"}]}', '{"option_id":"a"}', 'Si hay que decir "tiene un", eso es composición: guardar el objeto adentro, no heredarlo.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace super().__init__(...)?', NULL, '{"options":[{"id":"a","text":"Llama al constructor de la clase padre"},{"id":"b","text":"Crea un objeto nuevo del padre"},{"id":"c","text":"Copia los atributos del padre"},{"id":"d","text":"Convierte la hija en padre"}]}', '{"option_id":"a"}', 'Sin esa llamada, los atributos que crea el padre nunca existen y después salta AttributeError.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué es el polimorfismo?', NULL, '{"options":[{"id":"a","text":"Que la misma llamada funcione sobre objetos de tipos distintos, cada uno a su manera"},{"id":"b","text":"Que una clase tenga muchos atributos"},{"id":"c","text":"Que un objeto cambie de tipo en tiempo de ejecución"},{"id":"d","text":"Heredar de varias clases a la vez"}]}', '{"option_id":"a"}', 'Es lo que permite recorrer una lista de empleados llamando pago_mensual() sin un solo if.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué diferencia hay entre __str__ y __repr__?', NULL, '{"options":[{"id":"a","text":"__str__ es para el usuario y __repr__ para el programador (listas, consola)"},{"id":"b","text":"Son lo mismo con distinto nombre"},{"id":"c","text":"__repr__ solo sirve con números"},{"id":"d","text":"__str__ se usa al comparar objetos"}]}', '{"option_id":"a"}', 'Por eso al imprimir una lista de objetos se ve el __repr__ y no el __str__.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Para qué sirve raise NotImplementedError en un método de la clase base?', NULL, '{"options":[{"id":"a","text":"Para obligar a las clases hijas a definir ese método"},{"id":"b","text":"Para marcar código pendiente de escribir"},{"id":"c","text":"Para evitar que la clase se pueda instanciar"},{"id":"d","text":"Para documentar el método"}]}', '{"option_id":"a"}', 'Es un contrato: si alguien crea una hija y lo olvida, el error se lo dice en vez de dar un resultado equivocado.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'class A:
    def saludo(self):
        return "soy A"

class B(A):
    def saludo(self):
        return "soy B"

print(B().saludo())', '{"options":[{"id":"a","text":"soy B"},{"id":"b","text":"soy A"},{"id":"c","text":"soy A\nsoy B"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'Python busca el método primero en la clase del objeto. Como B lo define, esa versión gana.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'class A:
    def __init__(self, x):
        self.x = x

class B(A):
    def __init__(self, x, y):
        super().__init__(x)
        self.y = y

b = B(1, 2)
print(b.x + b.y)', '{"options":[{"id":"a","text":"3"},{"id":"b","text":"2"},{"id":"c","text":"AttributeError"},{"id":"d","text":"1"}]}', '{"option_id":"a"}', 'super() crea self.x y después la hija agrega self.y: el objeto termina con los dos.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'class D:
    def __init__(self, v):
        self.v = v

    def __lt__(self, o):
        return self.v < o.v

    def __repr__(self):
        return f"D({self.v})"

print(sorted([D(3), D(1), D(2)]))', '{"options":[{"id":"a","text":"[D(1), D(2), D(3)]"},{"id":"b","text":"[D(3), D(1), D(2)]"},{"id":"c","text":"TypeError"},{"id":"d","text":"[1, 2, 3]"}]}', '{"option_id":"a"}', 'Con __lt__ definido, sorted() sabe comparar los objetos; __repr__ es lo que se ve dentro de la lista.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'class Cuenta:
    def retirar(self, m):
        return f"retiro {m}"

class Ahorros(Cuenta):
    def retirar(self, m):
        if m > 100:
            return "tope excedido"
        return super().retirar(m)

print(Ahorros().retirar(50))', '{"options":[{"id":"a","text":"retiro 50"},{"id":"b","text":"tope excedido"},{"id":"c","text":"None"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', '50 no supera el tope, así que la hija valida lo suyo y delega en el padre con super().', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Al usar el objeto salta AttributeError: no existe ''saldo''. ¿En qué línea está el error?', NULL, '{"lines":["class Cuenta:","    def __init__(self, saldo):","        self.saldo = saldo","","class Corriente(Cuenta):","    def __init__(self, saldo, cupo):","        self.cupo = cupo"]}', '{"line_number":7}', 'Falta super().__init__(saldo) antes: sin esa llamada el atributo saldo nunca se crea.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'La jerarquía está mal planteada. ¿En qué línea está el error de diseño?', NULL, '{"lines":["class Producto:","    pass","","class Inventario(Producto):","    def __init__(self):","        self.productos = {}"]}', '{"line_number":4}', 'Un inventario no ES un producto: TIENE productos. Eso es composición, no herencia.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la cuenta de ahorros que extiende la del padre', NULL, '{"lines":[{"id":"l1","text":"class CuentaAhorros(Cuenta):","indent":0},{"id":"l2","text":"def retirar(self, monto):","indent":1},{"id":"l3","text":"if monto > 1000000:","indent":2},{"id":"l4","text":"raise ValueError(\"Maximo un millon por retiro\")","indent":3},{"id":"l5","text":"return super().retirar(monto)","indent":2}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'La hija valida lo suyo primero y termina delegando en el padre, en vez de copiar su validación de saldo.', 1, 'seed'
    FROM chapters WHERE number = 19 AND track = 'basico';

-- ── Capítulo 20: Proyecto integrador: Sistema Bancario (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 20, 'Proyecto integrador: Sistema Bancario', '🏗️', 'Todo lo aprendido en una sola aplicación.', '<p class="jc-gancho">Diecinueve capítulos, cada uno con su pieza. Este capítulo no enseña nada nuevo: las junta todas en un programa que un banco pequeño podría usar de verdad. Cuentas, retiros, historial, persistencia y menú.</p>

<h2>Qué vamos a construir</h2>

<p>Un sistema bancario de consola con:</p>

<ul>
  <li>Clientes con cuentas de ahorros y corriente (capítulos 18 y 19)</li>
  <li>Consignaciones, retiros y transferencias con sus validaciones (15)</li>
  <li>Historial de movimientos con fecha (16)</li>
  <li>Todo guardado en JSON, que sobrevive al cerrar (17)</li>
  <li>Menú por consola con validación de entradas (6, 7, 15)</li>
</ul>

<h2>Cómo se reparte el trabajo</h2>

<p>Un programa de este tamaño no va en un solo archivo. Se parte en módulos por <strong>responsabilidad</strong>:</p>

<pre><code>banco/
├── main.py            el menú: habla con el usuario
├── cuentas.py         las clases Cuenta, Ahorros y Corriente
├── banco.py           la clase Banco: administra clientes y cuentas
├── almacenamiento.py  cargar y guardar en JSON
└── datos.json         los datos (lo crea el programa)</code></pre>

<p>La regla que ordena todo: <strong>solo <code>main.py</code> habla con el usuario</strong>. Ninguna otra parte hace <code>print()</code> ni <code>input()</code>. Así el mismo <code>banco.py</code> serviría mañana para una app web o una API sin tocar una línea.</p>

<h2>Las cuentas</h2>

<pre><code># cuentas.py
import datetime


class Cuenta:
    ''''''Cuenta bancaria base. No permite quedar en negativo.''''''

    tipo = "ahorros"

    def __init__(self, numero, titular, saldo=0):
        self.numero = numero
        self.titular = titular
        self.saldo = saldo
        self.movimientos = []      # cada cuenta con su lista propia

    def _registrar(self, concepto, monto):
        ''''''Guarda el movimiento con su fecha. El _ dice: uso interno.''''''
        self.movimientos.append({
            "fecha": datetime.date.today().isoformat(),
            "concepto": concepto,
            "monto": monto,
            "saldo": self.saldo,
        })

    def consignar(self, monto):
        if monto &lt;= 0:
            raise ValueError("El monto debe ser positivo")
        self.saldo += monto
        self._registrar("consignacion", monto)
        return self.saldo

    def puede_retirar(self, monto):
        ''''''Cada tipo de cuenta define su propia regla.''''''
        return monto &lt;= self.saldo

    def retirar(self, monto):
        if monto &lt;= 0:
            raise ValueError("El monto debe ser positivo")
        if not self.puede_retirar(monto):
            raise ValueError("Fondos insuficientes")
        self.saldo -= monto
        self._registrar("retiro", -monto)
        return self.saldo

    def __str__(self):
        return f"{self.numero} ({self.tipo}) {self.titular}: {self.saldo:,}"


class CuentaCorriente(Cuenta):
    ''''''Una corriente ES una cuenta, pero admite sobregiro.''''''

    tipo = "corriente"

    def __init__(self, numero, titular, saldo=0, sobregiro=500000):
        super().__init__(numero, titular, saldo)
        self.sobregiro = sobregiro

    def puede_retirar(self, monto):
        return monto &lt;= self.saldo + self.sobregiro</code></pre>

<p>Fíjate en el detalle de diseño más importante del capítulo: <code>retirar()</code> se escribió <strong>una sola vez</strong>. Lo único que cambia entre los dos tipos de cuenta es <code>puede_retirar()</code>, así que eso es lo único que la hija sobrescribe. Ese método pequeño que las hijas redefinen se llama <em>gancho</em>, y es el patrón que evita duplicar código.</p>

<h2>El banco</h2>

<pre><code># banco.py
from cuentas import Cuenta, CuentaCorriente


class Banco:
    ''''''Administra las cuentas. No sabe nada de pantallas ni archivos.''''''

    def __init__(self):
        self.cuentas = {}          # numero -> Cuenta

    def abrir(self, numero, titular, tipo="ahorros", saldo=0):
        if numero in self.cuentas:
            raise ValueError(f"La cuenta {numero} ya existe")

        if tipo == "corriente":
            cuenta = CuentaCorriente(numero, titular, saldo)
        else:
            cuenta = Cuenta(numero, titular, saldo)

        self.cuentas[numero] = cuenta
        return cuenta

    def buscar(self, numero):
        if numero not in self.cuentas:
            raise KeyError(f"No existe la cuenta {numero}")
        return self.cuentas[numero]

    def transferir(self, origen, destino, monto):
        ''''''Mueve dinero entre dos cuentas. Si algo falla, no mueve nada.''''''
        cuenta_origen = self.buscar(origen)
        cuenta_destino = self.buscar(destino)

        # El retiro va PRIMERO: si no alcanza, lanza y no se consigna nada
        cuenta_origen.retirar(monto)
        cuenta_destino.consignar(monto)

    @property
    def total_depositado(self):
        return sum(c.saldo for c in self.cuentas.values())</code></pre>

<p>El orden dentro de <code>transferir()</code> no es casual. Si se consignara primero y el retiro fallara, el banco habría <em>creado</em> dinero. Retirar primero significa que la operación falla completa o no falla.</p>

<h2>La persistencia</h2>

<pre><code># almacenamiento.py
import json
from cuentas import Cuenta, CuentaCorriente


def guardar(banco, ruta="datos.json"):
    ''''''Convierte los objetos en diccionarios y los escribe.''''''
    datos = {}
    for numero, cuenta in banco.cuentas.items():
        datos[numero] = {
            "titular": cuenta.titular,
            "saldo": cuenta.saldo,
            "tipo": cuenta.tipo,
            "movimientos": cuenta.movimientos,
        }

    with open(ruta, "w", encoding="utf-8") as f:
        json.dump(datos, f, indent=2, ensure_ascii=False)


def cargar(banco, ruta="datos.json"):
    ''''''Reconstruye los objetos desde el archivo. Si no existe, no hace nada.''''''
    try:
        with open(ruta, encoding="utf-8") as f:
            datos = json.load(f)
    except FileNotFoundError:
        return banco          # primera vez: el banco arranca vacío

    for numero, d in datos.items():
        cuenta = banco.abrir(numero, d["titular"], d["tipo"], d["saldo"])
        cuenta.movimientos = d["movimientos"]

    return banco</code></pre>

<p>JSON no sabe guardar objetos de Python: guarda diccionarios, listas, números y textos. Por eso hay un paso de traducción en cada dirección. Se llama <strong>serializar</strong> (objeto → diccionario) y <strong>deserializar</strong> (diccionario → objeto), y es exactamente lo que hace cualquier programa que hable con una base de datos o con una API.</p>

<h2>El menú</h2>

<pre><code># main.py
import banco as modulo_banco
import almacenamiento


def pedir_entero(mensaje, minimo=1):
    ''''''Insiste hasta recibir un entero valido.''''''
    while True:
        try:
            valor = int(input(mensaje))
        except ValueError:
            print("Debe ser un numero")
            continue
        if valor &lt; minimo:
            print(f"Debe ser al menos {minimo}")
            continue
        return valor


def menu():
    print("\n1. Abrir cuenta   2. Consignar   3. Retirar")
    print("4. Transferir     5. Extracto    6. Salir")


def main():
    banco = almacenamiento.cargar(modulo_banco.Banco())

    while True:
        menu()
        opcion = input("Opcion: ").strip()

        try:
            if opcion == "1":
                numero = input("Numero de cuenta: ").strip()
                titular = input("Titular: ").strip()
                tipo = input("Tipo (ahorros/corriente): ").strip()
                banco.abrir(numero, titular, tipo)
                print("Cuenta abierta")

            elif opcion == "2":
                cuenta = banco.buscar(input("Cuenta: ").strip())
                cuenta.consignar(pedir_entero("Monto: "))
                print(f"Nuevo saldo: {cuenta.saldo:,}")

            elif opcion == "6":
                almacenamiento.guardar(banco)
                print("Datos guardados. Hasta luego")
                break

            else:
                print("Opcion invalida")

        except (ValueError, KeyError) as e:
            # Cualquier regla del negocio que falle se reporta aquí
            print(f"Error: {e}")


if __name__ == "__main__":
    main()</code></pre>

<p>Todo el <code>try/except</code> vive en el menú, en un solo sitio. Las clases lanzan errores con mensajes claros; el menú los muestra. Ninguna clase imprime nada.</p>

<h2>La película de una transferencia</h2>

<p>Ana tiene 200000, Juan tiene 50000, y Ana le transfiere 300000:</p>

<table>
  <thead>
    <tr><th>Paso</th><th>Qué pasa</th><th>Ana</th><th>Juan</th></tr>
  </thead>
  <tbody>
    <tr><td>1</td><td><code>buscar("001")</code> y <code>buscar("002")</code>: existen</td><td>200000</td><td>50000</td></tr>
    <tr><td>2</td><td><code>ana.retirar(300000)</code> → <code>puede_retirar</code> da False</td><td>200000</td><td>50000</td></tr>
    <tr><td>3</td><td><code>raise ValueError("Fondos insuficientes")</code></td><td>200000</td><td>50000</td></tr>
    <tr><td>4</td><td>El <code>consignar</code> de Juan <strong>nunca se ejecuta</strong></td><td>200000</td><td>50000</td></tr>
    <tr><td>5</td><td>El menú atrapa el error y lo muestra</td><td>200000</td><td>50000</td></tr>
  </tbody>
</table>

<p>Nadie perdió ni ganó dinero. Esa propiedad —o pasa todo, o no pasa nada— se llama <strong>atomicidad</strong>, y es la razón por la que el orden de esas dos líneas importa tanto.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Meterlo todo en un archivo</h3>
<p>Funciona con 100 líneas y es un infierno con 500. Un módulo por responsabilidad, desde el principio.</p>

<h3>2. Poner <code>print()</code> dentro de las clases</h3>
<pre><code>def retirar(self, monto):
    if monto &gt; self.saldo:
        print("Saldo insuficiente")     # ❌ la clase no sabe si hay pantalla
        raise ValueError(...)           # ✅ solo lanza</code></pre>

<h3>3. Olvidar guardar al salir</h3>
<p>Todo el trabajo de la sesión vive en memoria. Si el usuario cierra sin pasar por la opción 6, se perdió. Por eso <code>guardar()</code> va en el camino de salida.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Un módulo por responsabilidad: modelo, lógica, almacenamiento, interfaz.</li>
  <li>Solo la interfaz habla con el usuario. El resto lanza errores y devuelve datos.</li>
  <li>Las operaciones que tocan dos cosas se ordenan para que fallen antes de cambiar nada.</li>
  <li>Cargar al arrancar, guardar al salir.</li>
  <li>Lo que varía entre subclases va en un método pequeño; el grande se escribe una vez.</li>
</ol>

<h2>📋 Chuleta del proyecto</h2>

<table>
  <thead>
    <tr><th>Capítulo</th><th>Qué aporta aquí</th></tr>
  </thead>
  <tbody>
    <tr><td>6, 7</td><td>Menú con <code>while</code> y <code>if/elif</code></td></tr>
    <tr><td>12</td><td>Diccionario de cuentas por número</td></tr>
    <tr><td>14</td><td><code>pedir_entero()</code> reutilizable</td></tr>
    <tr><td>15</td><td><code>raise</code> en las clases, <code>try</code> en el menú</td></tr>
    <tr><td>16</td><td>Módulos y <code>if __name__ == "__main__"</code></td></tr>
    <tr><td>17</td><td>Serializar y deserializar en JSON</td></tr>
    <tr><td>18, 19</td><td>Clases, herencia y el gancho <code>puede_retirar()</code></td></tr>
  </tbody>
</table>

<blockquote>Un proyecto no es código más largo: es código <em>repartido</em>. Cuando cada archivo tiene un solo trabajo, agregar una función nueva deja de dar miedo.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 6
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 20 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 20 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'El gancho puede_retirar', 'facil', '<p>Implementar <code>Cuenta</code> y <code>CuentaCorriente</code> de forma que <code>retirar()</code> se escriba <strong>una sola vez</strong> en el padre y lo único que cambie entre las dos sea el método <code>puede_retirar(monto)</code>.</p><pre><code>Ahorros: 150000
Corriente: -250000
Error: Fondos insuficientes</code></pre>', '<p><code>retirar()</code> valida llamando a <code>self.puede_retirar(monto)</code>. Como Python busca el método en la clase del objeto, cada cuenta usa su propia versión sin que el padre lo sepa.</p>', '<pre><code>''''''
Programa: Cuentas con gancho de validacion
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Dos tipos de cuenta que comparten retirar() y solo cambian
    la regla de cuanto se puede sacar.
''''''


class Cuenta:
    ''''''Cuenta base: no permite quedar en negativo.''''''

    tipo = "ahorros"

    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def puede_retirar(self, monto):
        ''''''Gancho: cada tipo de cuenta redefine solo esto.''''''
        return monto <= self.saldo

    def retirar(self, monto):
        ''''''Se escribe UNA vez y sirve para todas las subclases.''''''
        if monto <= 0:
            raise ValueError("El monto debe ser positivo")
        if not self.puede_retirar(monto):
            raise ValueError("Fondos insuficientes")
        self.saldo -= monto
        return self.saldo


class CuentaCorriente(Cuenta):
    ''''''Admite sobregiro: solo cambia la regla, no el retiro.''''''

    tipo = "corriente"

    def __init__(self, titular, saldo=0, sobregiro=500000):
        super().__init__(titular, saldo)
        self.sobregiro = sobregiro

    def puede_retirar(self, monto):
        return monto <= self.saldo + self.sobregiro


# Inicio
ahorros = Cuenta("Ana", 200000)
corriente = CuentaCorriente("Juan", 100000)

ahorros.retirar(50000)
print(f"Ahorros: {ahorros.saldo}")

corriente.retirar(350000)
print(f"Corriente: {corriente.saldo}")

try:
    ahorros.retirar(999999)
except ValueError as e:
    print(f"Error: {e}")
# Fin</code></pre><p>Compare con el capítulo 19, donde la hija sobrescribía <code>retirar()</code> entero y repetía la validación del monto positivo y el descuento del saldo.</p><p>Aquí el método largo vive una sola vez y las hijas solo redefinen la regla que de verdad cambia. Si mañana hay que agregar una comisión a todos los retiros, se toca <strong>una</strong> línea.</p>', '[{"stdin":"","expected_output":"Ahorros: 150000\nCorriente: -250000\nError: Fondos insuficientes"}]', '''''''
Programa: Cuentas con gancho de validacion
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Transferencia atómica', 'facil', '<p>Sobre una clase <code>Banco</code> que guarda cuentas en un diccionario, implementar <code>transferir(origen, destino, monto)</code> de forma que, si el retiro falla, <strong>no se consigne nada</strong>.</p><pre><code>Antes  -> Ana: 200000  Juan: 50000
Despues-> Ana: 120000  Juan: 130000
Error: Fondos insuficientes
Final  -> Ana: 120000  Juan: 130000</code></pre>', '<p>El truco es el orden: <code>retirar()</code> va primero. Si lanza la excepción, la línea del <code>consignar()</code> nunca se ejecuta.</p>', '<pre><code>''''''
Programa: Transferencia entre cuentas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Mueve dinero entre dos cuentas garantizando que la operacion
    ocurra completa o no ocurra.
''''''


class Cuenta:
    ''''''Cuenta bancaria basica.''''''

    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def consignar(self, monto):
        self.saldo += monto
        return self.saldo

    def retirar(self, monto):
        if monto > self.saldo:
            raise ValueError("Fondos insuficientes")
        self.saldo -= monto
        return self.saldo


class Banco:
    ''''''Administra las cuentas del banco.''''''

    def __init__(self):
        self.cuentas = {}

    def abrir(self, numero, titular, saldo=0):
        self.cuentas[numero] = Cuenta(titular, saldo)
        return self.cuentas[numero]

    def buscar(self, numero):
        if numero not in self.cuentas:
            raise KeyError(f"No existe la cuenta {numero}")
        return self.cuentas[numero]

    def transferir(self, origen, destino, monto):
        ''''''
        Mueve dinero entre dos cuentas.

        El retiro va PRIMERO: si no alcanza, lanza la excepcion
        y la consignacion nunca ocurre. Asi el banco no crea ni
        pierde dinero.
        ''''''
        cuenta_origen = self.buscar(origen)
        cuenta_destino = self.buscar(destino)

        cuenta_origen.retirar(monto)
        cuenta_destino.consignar(monto)


# Inicio
banco = Banco()
ana = banco.abrir("001", "Ana", 200000)
juan = banco.abrir("002", "Juan", 50000)

print(f"Antes  -> Ana: {ana.saldo}  Juan: {juan.saldo}")

banco.transferir("001", "002", 80000)
print(f"Despues-> Ana: {ana.saldo}  Juan: {juan.saldo}")

try:
    banco.transferir("001", "002", 999999)
except ValueError as e:
    print(f"Error: {e}")

# Ninguno de los dos saldos cambio en la transferencia fallida
print(f"Final  -> Ana: {ana.saldo}  Juan: {juan.saldo}")
# Fin</code></pre><p>Esa propiedad de "o pasa todo o no pasa nada" se llama <strong>atomicidad</strong>, y es la primera cosa que se le exige a cualquier sistema que mueva plata.</p><p>Si las dos líneas estuvieran al revés, una transferencia fallida le habría regalado 999999 a Juan sin quitárselos a Ana. El orden no es estilo: es corrección.</p>', '[{"stdin":"","expected_output":"Antes  -> Ana: 200000  Juan: 50000\nDespues-> Ana: 120000  Juan: 130000\nError: Fondos insuficientes\nFinal  -> Ana: 120000  Juan: 130000"}]', '''''''
Programa: Transferencia entre cuentas
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Guardar y recuperar el banco', 'medio', '<p>Escribir <code>guardar(banco, ruta)</code> y <code>cargar(banco, ruta)</code> que conviertan las cuentas a JSON y las reconstruyan como objetos.</p><p>El programa debe abrir dos cuentas, hacer un movimiento, guardar, y volver a cargar en un banco nuevo para comprobar que todo sobrevivió:</p><pre><code>Guardadas 2 cuentas
Recuperadas 2 cuentas
001 Ana: 150000 (1 movimientos)
002 Juan: 50000 (0 movimientos)</code></pre>', '<p>JSON no guarda objetos: hay que traducirlos a diccionarios al guardar y volver a crear las clases al cargar. <code>cargar()</code> debe soportar que el archivo no exista.</p>', '<pre><code>''''''
Programa: Persistencia del banco
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Guarda las cuentas del banco en JSON y las reconstruye como
    objetos al volver a cargarlas.
''''''

import json

ARCHIVO = "banco.json"


class Cuenta:
    ''''''Cuenta bancaria con historial de movimientos.''''''

    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo
        self.movimientos = []

    def retirar(self, monto):
        if monto > self.saldo:
            raise ValueError("Fondos insuficientes")
        self.saldo -= monto
        self.movimientos.append({"concepto": "retiro", "monto": -monto})
        return self.saldo


class Banco:
    ''''''Administra las cuentas del banco.''''''

    def __init__(self):
        self.cuentas = {}

    def abrir(self, numero, titular, saldo=0):
        self.cuentas[numero] = Cuenta(titular, saldo)
        return self.cuentas[numero]


def guardar(banco, ruta):
    ''''''
    Serializa: convierte los objetos en diccionarios que JSON
    si sabe escribir.
    ''''''
    datos = {}
    for numero, cuenta in banco.cuentas.items():
        datos[numero] = {
            "titular": cuenta.titular,
            "saldo": cuenta.saldo,
            "movimientos": cuenta.movimientos,
        }

    with open(ruta, "w", encoding="utf-8") as f:
        json.dump(datos, f, indent=2, ensure_ascii=False)

    return len(datos)


def cargar(banco, ruta):
    ''''''
    Deserializa: vuelve a crear los objetos a partir del archivo.
    Si no existe todavia, devuelve el banco vacio.
    ''''''
    try:
        with open(ruta, encoding="utf-8") as f:
            datos = json.load(f)
    except FileNotFoundError:
        return banco

    for numero, d in datos.items():
        cuenta = banco.abrir(numero, d["titular"], d["saldo"])
        cuenta.movimientos = d["movimientos"]

    return banco


# Inicio
banco = Banco()
banco.abrir("001", "Ana", 200000)
banco.abrir("002", "Juan", 50000)

banco.cuentas["001"].retirar(50000)

print(f"Guardadas {guardar(banco, ARCHIVO)} cuentas")

# Un banco NUEVO, vacio, que se llena desde el archivo
otro = cargar(Banco(), ARCHIVO)
print(f"Recuperadas {len(otro.cuentas)} cuentas")

for numero, cuenta in otro.cuentas.items():
    print(f"{numero} {cuenta.titular}: {cuenta.saldo} ({len(cuenta.movimientos)} movimientos)")
# Fin</code></pre><p>Lo que hay que entender aquí es que <strong>JSON no sabe de objetos</strong>. Solo maneja diccionarios, listas, números, textos y booleanos. Por eso hay dos traducciones:</p><table><thead><tr><th>Dirección</th><th>Nombre</th><th>Qué hace</th></tr></thead><tbody><tr><td>objeto → diccionario</td><td>serializar</td><td><code>guardar()</code></td></tr><tr><td>diccionario → objeto</td><td>deserializar</td><td><code>cargar()</code></td></tr></tbody></table><p>Es exactamente lo que hace por dentro cualquier programa que hable con una base de datos o con una API. Al cargar hay que <strong>volver a crear las clases</strong>: si uno se quedara con los diccionarios, el objeto recuperado no tendría los métodos.</p>', '[{"stdin":"","expected_output":"Guardadas 2 cuentas\nRecuperadas 2 cuentas\n001 Ana: 150000 (1 movimientos)\n002 Juan: 50000 (0 movimientos)"}]', '''''''
Programa: Persistencia del banco
Autor:
Fecha:
Descripcion:
''''''


ARCHIVO = "banco.json"


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Sistema bancario completo', 'dificil', '<p>Armar el sistema completo con menú por consola. Debe soportar las opciones:</p><ol><li>Abrir cuenta (ahorros o corriente)</li><li>Consignar</li><li>Retirar</li><li>Transferir</li><li>Extracto (saldo e historial)</li><li>Salir</li></ol><p>Con esta secuencia de entradas:</p><pre><code>1 / 001 / Ana / ahorros
1 / 002 / Juan / corriente
2 / 001 / 200000
3 / 001 / 50000
4 / 001 / 002 / 100000
5 / 001
6</code></pre><p>La salida esperada es:</p><pre><code>Cuenta 001 abierta
Cuenta 002 abierta
Nuevo saldo: 200,000
Nuevo saldo: 150,000
Transferencia realizada
--- Extracto 001 (Ana) ---
consignacion  +200000
retiro        -50000
transferencia -100000
Saldo: 50,000
Total en el banco: 150,000
Hasta luego</code></pre>', '<p>Todo el <code>try/except</code> va en un solo sitio, alrededor del cuerpo del menú. Las clases solo lanzan errores; el menú los muestra. Use <code>input().strip()</code> para todas las entradas.</p>', '<pre><code>''''''
Programa: Sistema bancario
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Sistema bancario de consola con cuentas de ahorros y
    corriente, movimientos, transferencias y extracto.
''''''


class Cuenta:
    ''''''Cuenta de ahorros: no permite quedar en negativo.''''''

    tipo = "ahorros"

    def __init__(self, numero, titular, saldo=0):
        self.numero = numero
        self.titular = titular
        self.saldo = saldo
        self.movimientos = []

    def _registrar(self, concepto, monto):
        ''''''Uso interno: deja constancia del movimiento.''''''
        self.movimientos.append((concepto, monto))

    def puede_retirar(self, monto):
        ''''''Gancho que redefine cada tipo de cuenta.''''''
        return monto <= self.saldo

    def consignar(self, monto, concepto="consignacion"):
        if monto <= 0:
            raise ValueError("El monto debe ser positivo")
        self.saldo += monto
        self._registrar(concepto, monto)
        return self.saldo

    def retirar(self, monto, concepto="retiro"):
        if monto <= 0:
            raise ValueError("El monto debe ser positivo")
        if not self.puede_retirar(monto):
            raise ValueError("Fondos insuficientes")
        self.saldo -= monto
        self._registrar(concepto, -monto)
        return self.saldo


class CuentaCorriente(Cuenta):
    ''''''Cuenta corriente: admite sobregiro.''''''

    tipo = "corriente"

    def __init__(self, numero, titular, saldo=0, sobregiro=500000):
        super().__init__(numero, titular, saldo)
        self.sobregiro = sobregiro

    def puede_retirar(self, monto):
        return monto <= self.saldo + self.sobregiro


class Banco:
    ''''''Administra las cuentas. No habla con el usuario.''''''

    def __init__(self):
        self.cuentas = {}

    def abrir(self, numero, titular, tipo="ahorros"):
        if numero in self.cuentas:
            raise ValueError(f"La cuenta {numero} ya existe")

        if tipo == "corriente":
            cuenta = CuentaCorriente(numero, titular)
        else:
            cuenta = Cuenta(numero, titular)

        self.cuentas[numero] = cuenta
        return cuenta

    def buscar(self, numero):
        if numero not in self.cuentas:
            raise KeyError(f"No existe la cuenta {numero}")
        return self.cuentas[numero]

    def transferir(self, origen, destino, monto):
        ''''''El retiro va primero: si falla, no se consigna nada.''''''
        salida = self.buscar(origen)
        entrada = self.buscar(destino)
        salida.retirar(monto, "transferencia")
        entrada.consignar(monto, "transferencia")

    @property
    def total(self):
        return sum(c.saldo for c in self.cuentas.values())


def extracto(cuenta):
    ''''''Arma el texto del extracto. No imprime: devuelve.''''''
    lineas = [f"--- Extracto {cuenta.numero} ({cuenta.titular}) ---"]
    for concepto, monto in cuenta.movimientos:
        lineas.append(f"{concepto:<13} {monto:+d}")
    lineas.append(f"Saldo: {cuenta.saldo:,}")
    return "\n".join(lineas)


def main():
    ''''''El unico sitio que habla con el usuario.''''''
    banco = Banco()

    while True:
        opcion = input().strip()

        # Un solo try para todas las reglas del negocio
        try:
            if opcion == "1":
                numero = input().strip()
                titular = input().strip()
                tipo = input().strip()
                banco.abrir(numero, titular, tipo)
                print(f"Cuenta {numero} abierta")

            elif opcion == "2":
                cuenta = banco.buscar(input().strip())
                cuenta.consignar(int(input()))
                print(f"Nuevo saldo: {cuenta.saldo:,}")

            elif opcion == "3":
                cuenta = banco.buscar(input().strip())
                cuenta.retirar(int(input()))
                print(f"Nuevo saldo: {cuenta.saldo:,}")

            elif opcion == "4":
                origen = input().strip()
                destino = input().strip()
                banco.transferir(origen, destino, int(input()))
                print("Transferencia realizada")

            elif opcion == "5":
                print(extracto(banco.buscar(input().strip())))

            elif opcion == "6":
                print(f"Total en el banco: {banco.total:,}")
                print("Hasta luego")
                break

            else:
                print("Opcion invalida")

        except (ValueError, KeyError) as e:
            print(f"Error: {e}")


if __name__ == "__main__":
    main()</code></pre><p>Este es el programa más largo del libro y no tiene nada nuevo: son las piezas de los diecinueve capítulos anteriores puestas en su sitio.</p><p>Tres decisiones que lo sostienen:</p><ul><li><strong>Nadie imprime salvo <code>main()</code>.</strong> Ni las clases ni <code>extracto()</code>. Por eso el mismo <code>Banco</code> serviría tal cual para una API web: solo habría que cambiar quién llama a los métodos.</li><li><strong>Un solo <code>try</code>.</strong> Las clases lanzan <code>ValueError</code> y <code>KeyError</code> con mensajes claros; el menú los atrapa en un punto. Nada de <code>try</code> repartidos por todas partes.</li><li><strong><code>consignar()</code> y <code>retirar()</code> reciben el concepto.</strong> Así la transferencia queda registrada como transferencia y no como un retiro y una consignación sueltos. El historial cuenta la verdad de lo que pasó.</li></ul><p>Fíjese en <code>{monto:+d}</code>: el <code>+</code> obliga a mostrar el signo, así que las entradas salen con <code>+</code> y las salidas con <code>-</code>. Un detalle de tres caracteres que hace legible un extracto.</p>', '[{"stdin":"1\n001\nAna\nahorros\n1\n002\nJuan\ncorriente\n2\n001\n200000\n3\n001\n50000\n4\n001\n002\n100000\n5\n001\n6\n","expected_output":"Cuenta 001 abierta\nCuenta 002 abierta\nNuevo saldo: 200,000\nNuevo saldo: 150,000\nTransferencia realizada\n--- Extracto 001 (Ana) ---\nconsignacion  +200000\nretiro        -50000\ntransferencia -100000\nSaldo: 50,000\nTotal en el banco: 150,000\nHasta luego"}]', '''''''
Programa: Sistema bancario
Autor:
Fecha:
Descripcion:
''''''


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 20 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Por qué un proyecto se reparte en varios archivos en vez de uno solo?', NULL, '{"options":[{"id":"a","text":"Porque cada archivo con una sola responsabilidad es más fácil de cambiar y de probar"},{"id":"b","text":"Porque Python no admite archivos largos"},{"id":"c","text":"Porque así el programa corre más rápido"},{"id":"d","text":"Porque lo exige el sistema operativo"}]}', '{"option_id":"a"}', 'Con 100 líneas da igual; con 500 la diferencia entre un archivo ordenado y uno revuelto es enorme.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué parte del sistema bancario debe hacer print() e input()?', NULL, '{"options":[{"id":"a","text":"Solo el menú (main.py)"},{"id":"b","text":"Todas, cada una reporta lo suyo"},{"id":"c","text":"Las clases de cuenta"},{"id":"d","text":"El módulo de almacenamiento"}]}', '{"option_id":"a"}', 'Así el mismo Banco sirve tal cual para una API web: solo cambia quién llama a sus métodos.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En transferir(), ¿por qué el retiro va antes que la consignación?', NULL, '{"options":[{"id":"a","text":"Para que, si el retiro falla, la consignación nunca ocurra y el banco no cree dinero"},{"id":"b","text":"Porque retirar es más rápido"},{"id":"c","text":"Por convención de los bancos"},{"id":"d","text":"Da lo mismo el orden"}]}', '{"option_id":"a"}', 'Esa propiedad de "o pasa todo o no pasa nada" se llama atomicidad, y aquí sale gratis con solo ordenar bien.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué es serializar?', NULL, '{"options":[{"id":"a","text":"Convertir objetos en diccionarios y listas que JSON sí sabe guardar"},{"id":"b","text":"Ordenar los datos por fecha"},{"id":"c","text":"Numerar las cuentas en serie"},{"id":"d","text":"Comprimir el archivo"}]}', '{"option_id":"a"}', 'JSON solo maneja diccionarios, listas, números, textos y booleanos: los objetos hay que traducirlos en las dos direcciones.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Qué gana el diseño al poner la regla variable en puede_retirar() en vez de sobrescribir retirar() entero?', NULL, '{"options":[{"id":"a","text":"Que el método largo se escribe una sola vez y las hijas solo redefinen lo que de verdad cambia"},{"id":"b","text":"Que se ejecuta más rápido"},{"id":"c","text":"Que no hace falta usar super()"},{"id":"d","text":"Que se pueden tener más subclases"}]}', '{"option_id":"a"}', 'Ese método pequeño que las hijas redefinen se llama gancho, y es lo que evita duplicar validaciones.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'class C:
    def puede(self, m):
        return m <= self.saldo

    def __init__(self, s):
        self.saldo = s

    def retirar(self, m):
        if not self.puede(m):
            raise ValueError("no alcanza")
        self.saldo -= m

class Corriente(C):
    def puede(self, m):
        return m <= self.saldo + 100

c = Corriente(50)
c.retirar(120)
print(c.saldo)', '{"options":[{"id":"a","text":"-70"},{"id":"b","text":"50"},{"id":"c","text":"no alcanza"},{"id":"d","text":"ValueError"}]}', '{"option_id":"a"}', 'retirar() está en el padre pero llama a self.puede(), y self es una Corriente: usa la versión de la hija.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'Ana tiene 100 y Juan 50. ¿Cuánto queda en cada uno?', 'def transferir(a, b, monto):
    a.retirar(monto)
    b.consignar(monto)

try:
    transferir(ana, juan, 500)
except ValueError:
    pass

print(ana.saldo, juan.saldo)', '{"options":[{"id":"a","text":"100 50"},{"id":"b","text":"-400 550"},{"id":"c","text":"100 550"},{"id":"d","text":"0 50"}]}', '{"option_id":"a"}', 'El retiro lanza la excepción y la consignación nunca corre: ninguno de los dos saldos cambia.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Una transferencia fallida le regala dinero al destino. ¿En qué línea está el error?', NULL, '{"lines":["def transferir(self, origen, destino, monto):","    o = self.buscar(origen)","    d = self.buscar(destino)","    d.consignar(monto)","    o.retirar(monto)"]}', '{"line_number":4}', 'La consignación va después del retiro. Así, si el retiro falla, el destino ya recibió el dinero.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'La clase no debería hablar con el usuario. ¿En qué línea está el problema de diseño?', NULL, '{"lines":["def retirar(self, monto):","    if monto > self.saldo:","        print(\"Saldo insuficiente\")","        raise ValueError(\"Saldo insuficiente\")","    self.saldo -= monto"]}', '{"line_number":3}', 'La clase no sabe si hay pantalla: solo debe lanzar. Mostrar el mensaje es trabajo del menú.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la transferencia atómica del banco', NULL, '{"lines":[{"id":"l1","text":"def transferir(self, origen, destino, monto):","indent":0},{"id":"l2","text":"salida = self.buscar(origen)","indent":1},{"id":"l3","text":"entrada = self.buscar(destino)","indent":1},{"id":"l4","text":"salida.retirar(monto)","indent":1},{"id":"l5","text":"entrada.consignar(monto)","indent":1}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Primero se buscan las dos cuentas (si alguna no existe, falla antes de tocar nada) y después el retiro antes de la consignación.', 1, 'seed'
    FROM chapters WHERE number = 20 AND track = 'basico';

-- ── Capítulo 21: SQL desde cero (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 21, 'SQL desde cero', '🗄️', 'Bases de datos relacionales y consultas desde Python.', '<p class="jc-gancho">El banco del capítulo 20 guarda todo en un JSON. Con 50 cuentas va bien. Con 50 mil, cada consulta lee el archivo entero, dos personas no pueden escribir a la vez y buscar "los retiros de marzo" obliga a recorrerlo todo. Para eso se inventaron las bases de datos.</p>

<h2>SQLite: la base de datos que ya tienes</h2>

<p>Python trae <code>sqlite3</code> incluido. Una base SQLite es <strong>un solo archivo</strong>, sin servidor ni instalación. Es la misma que usan tu celular, tu navegador y miles de aplicaciones.</p>

<pre><code>import sqlite3

# El archivo se crea solo si no existe
conexion = sqlite3.connect("banco.db")
cursor = conexion.cursor()

cursor.execute("SELECT 1")
print(cursor.fetchone())     # (1,)

conexion.close()</code></pre>

<table>
  <thead>
    <tr><th>Pieza</th><th>Qué es</th></tr>
  </thead>
  <tbody>
    <tr><td><strong>conexión</strong></td><td>La puerta al archivo</td></tr>
    <tr><td><strong>cursor</strong></td><td>Quien ejecuta las órdenes y trae los resultados</td></tr>
    <tr><td><code>commit()</code></td><td>Confirma los cambios: sin esto, no se guardan</td></tr>
  </tbody>
</table>

<h2>Crear la tabla</h2>

<p>Una tabla es una hoja de cálculo con reglas: columnas con tipo, y restricciones que la base hace cumplir.</p>

<pre><code>cursor.execute(''''''
    CREATE TABLE IF NOT EXISTS cuentas (
        numero   TEXT PRIMARY KEY,
        titular  TEXT NOT NULL,
        tipo     TEXT NOT NULL DEFAULT ''ahorros'',
        saldo    INTEGER NOT NULL DEFAULT 0
    )
'''''')
conexion.commit()</code></pre>

<table>
  <thead>
    <tr><th>Palabra</th><th>Qué obliga</th></tr>
  </thead>
  <tbody>
    <tr><td><code>PRIMARY KEY</code></td><td>Único y no repetido: identifica la fila</td></tr>
    <tr><td><code>NOT NULL</code></td><td>Ese dato no puede faltar</td></tr>
    <tr><td><code>DEFAULT</code></td><td>Valor si no se especifica</td></tr>
    <tr><td><code>IF NOT EXISTS</code></td><td>No falla si la tabla ya estaba</td></tr>
  </tbody>
</table>

<p>Esto es distinto al JSON: allá nada impedía guardar una cuenta sin titular o dos con el mismo número. Aquí la base lo <strong>rechaza</strong>.</p>

<h2>Las cuatro operaciones</h2>

<pre><code># INSERT — crear
cursor.execute(
    "INSERT INTO cuentas (numero, titular, tipo, saldo) VALUES (?, ?, ?, ?)",
    ("001", "Ana", "ahorros", 200000),
)

# SELECT — leer
cursor.execute("SELECT numero, titular, saldo FROM cuentas WHERE saldo &gt; ?", (100000,))
print(cursor.fetchall())     # [(''001'', ''Ana'', 200000)]

# UPDATE — modificar
cursor.execute("UPDATE cuentas SET saldo = saldo - ? WHERE numero = ?", (50000, "001"))

# DELETE — borrar
cursor.execute("DELETE FROM cuentas WHERE numero = ?", ("001",))

conexion.commit()</code></pre>

<h3>Los signos de pregunta no son opcionales</h3>

<p>Esto es lo más importante del capítulo:</p>

<pre><code># ❌ NUNCA
cursor.execute(f"SELECT * FROM cuentas WHERE titular = ''{nombre}''")

# ✅ SIEMPRE
cursor.execute("SELECT * FROM cuentas WHERE titular = ?", (nombre,))</code></pre>

<p>Si el usuario escribe <code>''; DROP TABLE cuentas; --</code> como nombre, la primera versión <strong>borra la tabla</strong>. Se llama <strong>inyección SQL</strong> y sigue siendo una de las formas más comunes de robar bases de datos.</p>

<p>Con <code>?</code>, la base trata el valor como dato y nunca como instrucción, pase lo que pase. La coma de <code>(nombre,)</code> tampoco es opcional: sin ella no es una tupla.</p>

<h2>Leer resultados</h2>

<pre><code>cursor.execute("SELECT numero, titular, saldo FROM cuentas ORDER BY saldo DESC")

fila = cursor.fetchone()      # una tupla, o None si no hay más
filas = cursor.fetchall()     # lista de tuplas

for numero, titular, saldo in cursor.execute("SELECT numero, titular, saldo FROM cuentas"):
    print(f"{numero} {titular}: {saldo:,}")</code></pre>

<p>Por defecto cada fila es una tupla y hay que acordarse del orden de las columnas. Con una línea se puede pedir algo mucho más cómodo:</p>

<pre><code>conexion.row_factory = sqlite3.Row
cursor = conexion.cursor()

fila = cursor.execute("SELECT * FROM cuentas WHERE numero = ?", ("001",)).fetchone()
print(fila["titular"], fila["saldo"])     # por nombre, como un diccionario</code></pre>

<h2>Consultas que hacen el trabajo por ti</h2>

<p>Aquí está la ganancia real: cosas que en Python serían un ciclo, en SQL son una línea.</p>

<pre><code>-- ¿Cuánto hay en el banco?
SELECT SUM(saldo) FROM cuentas;

-- ¿Cuántas cuentas de cada tipo y cuánto suman?
SELECT tipo, COUNT(*), SUM(saldo)
FROM cuentas
GROUP BY tipo;

-- Los tres saldos más altos
SELECT titular, saldo FROM cuentas ORDER BY saldo DESC LIMIT 3;

-- Cuentas sin movimientos este mes
SELECT titular FROM cuentas WHERE saldo BETWEEN 0 AND 100000;</code></pre>

<p><code>GROUP BY</code> es el equivalente exacto del patrón de conteo del capítulo 12, pero lo resuelve la base y sin traer los datos a Python.</p>

<h2>Dos tablas y un JOIN</h2>

<p>Los movimientos no caben en la tabla de cuentas: son muchos por cuenta. Van en su propia tabla, apuntando a la cuenta con una <strong>clave foránea</strong>.</p>

<pre><code>CREATE TABLE IF NOT EXISTS movimientos (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    cuenta   TEXT NOT NULL,
    concepto TEXT NOT NULL,
    monto    INTEGER NOT NULL,
    fecha    TEXT NOT NULL,
    FOREIGN KEY (cuenta) REFERENCES cuentas(numero)
);</code></pre>

<pre><code>-- Cada movimiento con el nombre de su titular
SELECT c.titular, m.concepto, m.monto
FROM movimientos m
JOIN cuentas c ON c.numero = m.cuenta
ORDER BY m.fecha;</code></pre>

<p><code>JOIN</code> pega las dos tablas por la columna que tienen en común. Es lo que en Python sería buscar, por cada movimiento, la cuenta que le corresponde.</p>

<h2>Transacciones: el commit del capítulo 20</h2>

<p>La transferencia atómica que ordenamos a mano en el capítulo anterior, aquí la garantiza la base:</p>

<pre><code>try:
    cursor.execute("UPDATE cuentas SET saldo = saldo - ? WHERE numero = ?", (monto, origen))
    cursor.execute("UPDATE cuentas SET saldo = saldo + ? WHERE numero = ?", (monto, destino))
    conexion.commit()          # las dos, juntas
except Exception:
    conexion.rollback()        # ninguna
    raise</code></pre>

<p>Hasta el <code>commit()</code>, los cambios están en el aire. <code>rollback()</code> los deshace todos. O quedan las dos operaciones, o no queda ninguna: aunque se vaya la luz en la mitad.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Armar la consulta con f-strings</h3>
<pre><code>f"... WHERE titular = ''{nombre}''"    # ❌ inyección SQL
"... WHERE titular = ?", (nombre,)   # ✅</code></pre>

<h3>2. Olvidar el <code>commit()</code></h3>
<pre><code>cursor.execute("INSERT ...")
conexion.close()     # ❌ el INSERT se perdió</code></pre>

<h3>3. Olvidar la coma de la tupla</h3>
<pre><code>cursor.execute("... WHERE numero = ?", ("001"))    # ❌ eso es un texto
cursor.execute("... WHERE numero = ?", ("001",))   # ✅ tupla de uno</code></pre>

<h2>🎯 El patrón</h2>

<ol>
  <li>Conectar, crear tablas con <code>IF NOT EXISTS</code>, trabajar, <code>commit()</code>, cerrar.</li>
  <li>Los valores <strong>siempre</strong> con <code>?</code>. Sin excepciones.</li>
  <li>Deja que la base filtre, ordene y agrupe: es lo que sabe hacer.</li>
  <li>Un dato que se repite muchas veces por registro va en su propia tabla, unida por clave foránea.</li>
  <li>Operaciones que van juntas, dentro de una transacción.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>sqlite3.connect("x.db")</code></td><td>Abre (o crea) la base</td></tr>
    <tr><td><code>cursor.execute(sql, (a, b))</code></td><td>Ejecuta con parámetros seguros</td></tr>
    <tr><td><code>fetchone()</code> · <code>fetchall()</code></td><td>Una fila · todas</td></tr>
    <tr><td><code>conexion.commit()</code></td><td>Confirma los cambios</td></tr>
    <tr><td><code>SELECT … WHERE … ORDER BY … LIMIT</code></td><td>Filtrar, ordenar, recortar</td></tr>
    <tr><td><code>COUNT(*)</code> · <code>SUM(x)</code> · <code>AVG(x)</code></td><td>Contar, sumar, promediar</td></tr>
    <tr><td><code>GROUP BY tipo</code></td><td>Agrupar y resumir</td></tr>
    <tr><td><code>JOIN … ON …</code></td><td>Unir dos tablas</td></tr>
  </tbody>
</table>

<blockquote>Los valores nunca se pegan a la consulta: siempre van con <code>?</code>. Esa sola regla previene la vulnerabilidad más común y más costosa que existe.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 6
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 21 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 21 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Primera tabla', 'facil', '<p>Crear una base <code>tienda.db</code> con una tabla <code>productos</code> (<code>codigo</code> como clave primaria, <code>nombre</code>, <code>precio</code>), insertar tres productos y listarlos ordenados por precio:</p><pre><code>P3 Queso        15,000
P2 Leche         7,000
P1 Pan           5,000
Total: 27,000</code></pre>', '<p>Los valores del <code>INSERT</code> van con <code>?</code>, nunca pegados con f-string. No olvide el <code>commit()</code> antes de leer.</p>', '<pre><code>''''''
Programa: Primera tabla en SQLite
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Crea la tabla de productos de la tienda, inserta datos y los
    consulta ordenados por precio.
''''''

import sqlite3

BASE = "tienda.db"

# Inicio
conexion = sqlite3.connect(BASE)
cursor = conexion.cursor()

# IF NOT EXISTS: el programa se puede correr varias veces
cursor.execute(''''''
    CREATE TABLE IF NOT EXISTS productos (
        codigo TEXT PRIMARY KEY,
        nombre TEXT NOT NULL,
        precio INTEGER NOT NULL
    )
'''''')

productos = [
    ("P1", "Pan", 5000),
    ("P2", "Leche", 7000),
    ("P3", "Queso", 15000),
]

# Los valores SIEMPRE con ?, nunca pegados a la consulta
cursor.executemany(
    "INSERT OR REPLACE INTO productos (codigo, nombre, precio) VALUES (?, ?, ?)",
    productos,
)
conexion.commit()

for codigo, nombre, precio in cursor.execute(
    "SELECT codigo, nombre, precio FROM productos ORDER BY precio DESC"
):
    print(f"{codigo} {nombre:<12} {precio:>6,}")

total = cursor.execute("SELECT SUM(precio) FROM productos").fetchone()[0]
print(f"Total: {total:,}")

conexion.close()
# Fin</code></pre><p>Tres cosas del oficio:</p><ul><li><code>executemany()</code> inserta varias filas de un tirón con la misma consulta.</li><li><code>INSERT OR REPLACE</code> hace el programa repetible: si ya existía ese código, lo actualiza en vez de fallar por la clave primaria.</li><li><code>fetchone()</code> devuelve una <strong>tupla</strong>, por eso el <code>[0]</code> para sacar el único valor del <code>SUM</code>.</li></ul>', '[{"stdin":"","expected_output":"P3 Queso        15,000\nP2 Leche         7,000\nP1 Pan           5,000\nTotal: 27,000"}]', '''''''
Programa: Primera tabla en SQLite
Autor:
Fecha:
Descripcion:
''''''


BASE = "tienda.db"

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Consultas con filtro', 'facil', '<p>Sobre la tabla de productos, responder tres preguntas usando SQL (no ciclos de Python):</p><ul><li>los que cuestan más de 6000,</li><li>cuántos productos hay y cuál es el precio promedio,</li><li>y el más caro.</li></ul><pre><code>Caros: [''Leche'', ''Queso'']
3 productos, promedio 9000.0
El mas caro es Queso (15,000)</code></pre>', '<p><code>WHERE precio &gt; ?</code> filtra, <code>COUNT(*)</code> y <code>AVG(precio)</code> resumen, y <code>ORDER BY precio DESC LIMIT 1</code> da el mayor.</p>', '<pre><code>''''''
Programa: Consultas sobre la tienda
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Responde preguntas sobre el inventario dejando que la base
    haga el filtrado y los calculos.
''''''

import sqlite3

BASE = "tienda2.db"
CARO = 6000

# Inicio
conexion = sqlite3.connect(BASE)
cursor = conexion.cursor()

cursor.execute(''''''
    CREATE TABLE IF NOT EXISTS productos (
        codigo TEXT PRIMARY KEY,
        nombre TEXT NOT NULL,
        precio INTEGER NOT NULL
    )
'''''')
cursor.executemany(
    "INSERT OR REPLACE INTO productos VALUES (?, ?, ?)",
    [("P1", "Pan", 5000), ("P2", "Leche", 7000), ("P3", "Queso", 15000)],
)
conexion.commit()

# El parametro va con ?: nunca pegado a la consulta
filas = cursor.execute(
    "SELECT nombre FROM productos WHERE precio > ? ORDER BY precio", (CARO,)
).fetchall()
print(f"Caros: {[f[0] for f in filas]}")

cuantos, promedio = cursor.execute(
    "SELECT COUNT(*), AVG(precio) FROM productos"
).fetchone()
print(f"{cuantos} productos, promedio {promedio}")

nombre, precio = cursor.execute(
    "SELECT nombre, precio FROM productos ORDER BY precio DESC LIMIT 1"
).fetchone()
print(f"El mas caro es {nombre} ({precio:,})")

conexion.close()
# Fin</code></pre><p>Todo esto se podría hacer en Python trayendo las filas y recorriéndolas, pero sería traer datos para botarlos. La base está hecha justo para filtrar, contar y ordenar: con tres mil productos la diferencia se nota, y con tres millones es abismal.</p><p>Fíjese en <code>[f[0] for f in filas]</code>: cada fila es una tupla de un elemento, y la comprehension del capítulo 13 saca solo los nombres.</p>', '[{"stdin":"","expected_output":"Caros: [''Leche'', ''Queso'']\n3 productos, promedio 9000.0\nEl mas caro es Queso (15,000)"}]', '''''''
Programa: Consultas sobre la tienda
Autor:
Fecha:
Descripcion:
''''''


BASE = "tienda2.db"
CARO = 6000

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Dos tablas y un JOIN', 'medio', '<p>Crear las tablas <code>cuentas</code> y <code>movimientos</code> (con clave foránea a la cuenta) y mostrar cada movimiento con el nombre de su titular, más el resumen por cuenta:</p><pre><code>Ana   consignacion   200000
Ana   retiro         -50000
Juan  consignacion    80000
---
001 Ana: 2 movimientos, neto 150000
002 Juan: 1 movimientos, neto 80000</code></pre>', '<p>El <code>JOIN ... ON c.numero = m.cuenta</code> pega las dos tablas. Para el resumen, <code>GROUP BY</code> con <code>COUNT(*)</code> y <code>SUM(monto)</code>.</p>', '<pre><code>''''''
Programa: Movimientos con JOIN
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Relaciona cuentas y movimientos en dos tablas y consulta el
    historial y el resumen por cuenta.
''''''

import sqlite3

BASE = "banco_sql.db"

# Inicio
conexion = sqlite3.connect(BASE)
cursor = conexion.cursor()

cursor.execute(''''''
    CREATE TABLE IF NOT EXISTS cuentas (
        numero  TEXT PRIMARY KEY,
        titular TEXT NOT NULL
    )
'''''')

# Los movimientos son muchos por cuenta: van en su propia tabla,
# apuntando a la cuenta con una clave foranea
cursor.execute(''''''
    CREATE TABLE IF NOT EXISTS movimientos (
        id       INTEGER PRIMARY KEY AUTOINCREMENT,
        cuenta   TEXT NOT NULL,
        concepto TEXT NOT NULL,
        monto    INTEGER NOT NULL,
        FOREIGN KEY (cuenta) REFERENCES cuentas(numero)
    )
'''''')

cursor.execute("DELETE FROM movimientos")
cursor.executemany(
    "INSERT OR REPLACE INTO cuentas VALUES (?, ?)",
    [("001", "Ana"), ("002", "Juan")],
)
cursor.executemany(
    "INSERT INTO movimientos (cuenta, concepto, monto) VALUES (?, ?, ?)",
    [
        ("001", "consignacion", 200000),
        ("001", "retiro", -50000),
        ("002", "consignacion", 80000),
    ],
)
conexion.commit()

# JOIN: pega cada movimiento con la cuenta a la que pertenece
for titular, concepto, monto in cursor.execute(''''''
    SELECT c.titular, m.concepto, m.monto
    FROM movimientos m
    JOIN cuentas c ON c.numero = m.cuenta
    ORDER BY m.id
''''''):
    print(f"{titular:<5} {concepto:<14} {monto:>6}")

print("---")

# GROUP BY: la base agrupa y resume sin traer los datos a Python
for numero, titular, cuantos, neto in cursor.execute(''''''
    SELECT c.numero, c.titular, COUNT(*), SUM(m.monto)
    FROM movimientos m
    JOIN cuentas c ON c.numero = m.cuenta
    GROUP BY c.numero, c.titular
    ORDER BY c.numero
''''''):
    print(f"{numero} {titular}: {cuantos} movimientos, neto {neto}")

conexion.close()
# Fin</code></pre><p>Dos ideas centrales de las bases relacionales:</p><ul><li><strong>Un dato que se repite por registro va en su propia tabla.</strong> El nombre de Ana se escribe una vez en <code>cuentas</code>, no en cada uno de sus movimientos. Si se corrige el nombre, se corrige en un solo sitio.</li><li><strong><code>GROUP BY</code> es el patrón de conteo del capítulo 12</strong>, pero lo hace la base. En Python habría que traer todos los movimientos y recorrerlos.</li></ul><p>Las letras <code>m</code> y <code>c</code> después del nombre de la tabla son <em>alias</em>: ahorran escribir y dejan claro de qué tabla sale cada columna.</p>', '[{"stdin":"","expected_output":"Ana   consignacion   200000\nAna   retiro         -50000\nJuan  consignacion    80000\n---\n001 Ana: 2 movimientos, neto 150000\n002 Juan: 1 movimientos, neto 80000"}]', '''''''
Programa: Movimientos con JOIN
Autor:
Fecha:
Descripcion:
''''''


BASE = "banco_sql.db"

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'El banco sobre SQLite', 'dificil', '<p>Reescribir el banco del capítulo 20 guardando en SQLite en vez de JSON. La clase <code>BancoSQL</code> debe tener <code>abrir()</code>, <code>consignar()</code>, <code>retirar()</code>, <code>transferir()</code> y <code>extracto()</code>.</p><p>La transferencia debe usar una transacción: si el retiro falla, no se consigna nada.</p><pre><code>001 Ana: 200,000
002 Juan: 50,000
Transferencia OK
Error: Fondos insuficientes en 001
--- Extracto 001 ---
consignacion   +200000
transferencia  -80000
Saldo: 120,000
Total en el banco: 250,000</code></pre>', '<p>Cada operación es un <code>UPDATE</code> más un <code>INSERT</code> en movimientos. En <code>transferir()</code>, valide primero el saldo, haga los dos <code>UPDATE</code> y solo entonces <code>commit()</code>; si algo falla, <code>rollback()</code>.</p>', '<pre><code>''''''
Programa: Banco sobre SQLite
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    El sistema bancario del capitulo 20, pero guardando en una
    base de datos relacional en vez de un archivo JSON.
''''''

import sqlite3

BASE = "banco_final.db"


class BancoSQL:
    ''''''Banco cuyos datos viven en SQLite.''''''

    def __init__(self, ruta):
        self.conexion = sqlite3.connect(ruta)
        self.conexion.row_factory = sqlite3.Row   # filas por nombre
        self._crear_tablas()

    def _crear_tablas(self):
        ''''''Uso interno: prepara el esquema si es la primera vez.''''''
        cur = self.conexion.cursor()
        cur.execute(''''''
            CREATE TABLE IF NOT EXISTS cuentas (
                numero  TEXT PRIMARY KEY,
                titular TEXT NOT NULL,
                saldo   INTEGER NOT NULL DEFAULT 0
            )
        '''''')
        cur.execute(''''''
            CREATE TABLE IF NOT EXISTS movimientos (
                id       INTEGER PRIMARY KEY AUTOINCREMENT,
                cuenta   TEXT NOT NULL,
                concepto TEXT NOT NULL,
                monto    INTEGER NOT NULL,
                FOREIGN KEY (cuenta) REFERENCES cuentas(numero)
            )
        '''''')
        cur.execute("DELETE FROM movimientos")
        cur.execute("DELETE FROM cuentas")
        self.conexion.commit()

    def abrir(self, numero, titular, saldo=0):
        self.conexion.execute(
            "INSERT INTO cuentas (numero, titular, saldo) VALUES (?, ?, ?)",
            (numero, titular, saldo),
        )
        self.conexion.commit()

    def saldo(self, numero):
        fila = self.conexion.execute(
            "SELECT saldo FROM cuentas WHERE numero = ?", (numero,)
        ).fetchone()
        if fila is None:
            raise KeyError(f"No existe la cuenta {numero}")
        return fila["saldo"]

    def _mover(self, numero, monto, concepto):
        ''''''Uso interno: aplica el movimiento SIN hacer commit.''''''
        self.conexion.execute(
            "UPDATE cuentas SET saldo = saldo + ? WHERE numero = ?", (monto, numero)
        )
        self.conexion.execute(
            "INSERT INTO movimientos (cuenta, concepto, monto) VALUES (?, ?, ?)",
            (numero, concepto, monto),
        )

    def consignar(self, numero, monto, concepto="consignacion"):
        if monto <= 0:
            raise ValueError("El monto debe ser positivo")
        self.saldo(numero)          # valida que exista
        self._mover(numero, monto, concepto)
        self.conexion.commit()

    def retirar(self, numero, monto, concepto="retiro"):
        if monto > self.saldo(numero):
            raise ValueError(f"Fondos insuficientes en {numero}")
        self._mover(numero, -monto, concepto)
        self.conexion.commit()

    def transferir(self, origen, destino, monto):
        ''''''
        Las dos operaciones van en UNA transaccion: o quedan las
        dos, o no queda ninguna.
        ''''''
        try:
            if monto > self.saldo(origen):
                raise ValueError(f"Fondos insuficientes en {origen}")
            self.saldo(destino)     # valida que exista

            self._mover(origen, -monto, "transferencia")
            self._mover(destino, monto, "transferencia")
            self.conexion.commit()
        except Exception:
            self.conexion.rollback()
            raise

    def extracto(self, numero):
        lineas = [f"--- Extracto {numero} ---"]
        for fila in self.conexion.execute(
            "SELECT concepto, monto FROM movimientos WHERE cuenta = ? ORDER BY id",
            (numero,),
        ):
            lineas.append(f"{fila[''concepto'']:<14} {fila[''monto'']:+d}")
        lineas.append(f"Saldo: {self.saldo(numero):,}")
        return "\n".join(lineas)

    @property
    def total(self):
        return self.conexion.execute("SELECT SUM(saldo) FROM cuentas").fetchone()[0]


# Inicio
banco = BancoSQL(BASE)

banco.abrir("001", "Ana")
banco.abrir("002", "Juan")

banco.consignar("001", 200000)
banco.consignar("002", 50000)

print(f"001 Ana: {banco.saldo(''001''):,}")
print(f"002 Juan: {banco.saldo(''002''):,}")

banco.transferir("001", "002", 80000)
print("Transferencia OK")

try:
    banco.transferir("001", "002", 999999)
except ValueError as e:
    print(f"Error: {e}")

print(banco.extracto("001"))
print(f"Total en el banco: {banco.total:,}")
# Fin</code></pre><p>Comparado con la versión en JSON del capítulo 20, se ganan cuatro cosas:</p><ul><li><strong>No hay que cargar ni guardar todo.</strong> Cada operación toca solo las filas que necesita, aunque haya un millón de cuentas.</li><li><strong>La atomicidad la garantiza la base.</strong> En el capítulo 20 dependía de que ordenáramos bien dos líneas; aquí <code>commit()</code> y <code>rollback()</code> lo aseguran incluso si el programa muere en la mitad.</li><li><strong>Las reglas las hace cumplir el esquema.</strong> <code>PRIMARY KEY</code> impide dos cuentas con el mismo número; <code>NOT NULL</code> impide una cuenta sin titular.</li><li><strong>Consultar es una línea.</strong> <code>SUM(saldo)</code> reemplaza el ciclo del capítulo 20.</li></ul><p>Y algo de estilo que se repite en todo el capítulo: <code>_mover()</code> <strong>no hace <code>commit()</code></strong>. Es una pieza interna, y quien la llama decide cuándo confirmar. Por eso <code>transferir()</code> puede llamarla dos veces y confirmar una sola vez.</p>', '[{"stdin":"","expected_output":"001 Ana: 200,000\n002 Juan: 50,000\nTransferencia OK\nError: Fondos insuficientes en 001\n--- Extracto 001 ---\nconsignacion   +200000\ntransferencia  -80000\nSaldo: 120,000\nTotal en el banco: 250,000"}]', '''''''
Programa: Banco sobre SQLite
Autor:
Fecha:
Descripcion:
''''''


BASE = "banco_final.db"


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 21 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué tiene de especial SQLite frente a otras bases de datos?', NULL, '{"options":[{"id":"a","text":"Es un solo archivo, no necesita servidor y viene incluida en Python"},{"id":"b","text":"Solo funciona en Windows"},{"id":"c","text":"Guarda los datos en la nube"},{"id":"d","text":"Hay que instalarla con pip"}]}', '{"option_id":"a"}', 'Es la misma base que usan tu celular y tu navegador. Para aprender y para proyectos pequeños sobra.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué pasa si se olvida el commit() después de un INSERT?', NULL, '{"options":[{"id":"a","text":"El cambio no queda guardado"},{"id":"b","text":"Se guarda igual, el commit es opcional"},{"id":"c","text":"Se lanza un error"},{"id":"d","text":"Se guarda a medias"}]}', '{"option_id":"a"}', 'Hasta el commit los cambios están en el aire. Es el equivalente al paso de guardar del capítulo 17.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué los valores van con ? y no pegados con f-strings?', NULL, '{"options":[{"id":"a","text":"Para evitar inyección SQL: con ? el valor nunca se interpreta como instrucción"},{"id":"b","text":"Porque las f-strings no funcionan con sqlite3"},{"id":"c","text":"Porque es más rápido"},{"id":"d","text":"Por convención de estilo"}]}', '{"option_id":"a"}', 'Un nombre como ''; DROP TABLE cuentas; -- borraría la tabla si la consulta se arma pegando texto.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace GROUP BY tipo?', NULL, '{"options":[{"id":"a","text":"Agrupa las filas por ese valor para resumirlas con COUNT, SUM o AVG"},{"id":"b","text":"Ordena las filas por tipo"},{"id":"c","text":"Filtra las filas de ese tipo"},{"id":"d","text":"Crea una tabla nueva por cada tipo"}]}', '{"option_id":"a"}', 'Es el patrón de conteo del capítulo 12, pero resuelto por la base sin traer los datos a Python.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Para qué sirve rollback()?', NULL, '{"options":[{"id":"a","text":"Para deshacer todos los cambios pendientes desde el último commit"},{"id":"b","text":"Para volver a la versión anterior de la base"},{"id":"c","text":"Para cerrar la conexión"},{"id":"d","text":"Para borrar la última fila insertada"}]}', '{"option_id":"a"}', 'Con commit y rollback, una transferencia queda completa o no queda: la atomicidad la garantiza la base.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'import sqlite3
c = sqlite3.connect(":memory:")
c.execute("CREATE TABLE t (n INTEGER)")
c.executemany("INSERT INTO t VALUES (?)", [(1,), (2,), (3,)])
print(c.execute("SELECT SUM(n) FROM t").fetchone())', '{"options":[{"id":"a","text":"(6,)"},{"id":"b","text":"6"},{"id":"c","text":"[6]"},{"id":"d","text":"[(1,), (2,), (3,)]"}]}', '{"option_id":"a"}', 'fetchone() siempre devuelve una tupla, aunque la consulta traiga un solo valor: por eso el [0] al usarlo.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'import sqlite3
c = sqlite3.connect(":memory:")
c.execute("CREATE TABLE p (nombre TEXT, precio INTEGER)")
c.executemany("INSERT INTO p VALUES (?, ?)", [("pan", 5000), ("queso", 15000)])
filas = c.execute("SELECT nombre FROM p WHERE precio > ?", (6000,)).fetchall()
print(filas)', '{"options":[{"id":"a","text":"[(''queso'',)]"},{"id":"b","text":"[''queso'']"},{"id":"c","text":"[(''pan'',), (''queso'',)]"},{"id":"d","text":"queso"}]}', '{"option_id":"a"}', 'fetchall() devuelve una lista de tuplas, una por fila, aunque cada una tenga una sola columna.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'import sqlite3
c = sqlite3.connect(":memory:")
c.execute("CREATE TABLE t (tipo TEXT, monto INTEGER)")
c.executemany("INSERT INTO t VALUES (?, ?)", [("a", 10), ("b", 20), ("a", 30)])
print(c.execute("SELECT tipo, SUM(monto) FROM t GROUP BY tipo").fetchall())', '{"options":[{"id":"a","text":"[(''a'', 40), (''b'', 20)]"},{"id":"b","text":"[(''a'', 10), (''b'', 20), (''a'', 30)]"},{"id":"c","text":"[(''a'', 2), (''b'', 1)]"},{"id":"d","text":"[60]"}]}', '{"option_id":"a"}', 'GROUP BY junta las filas del mismo tipo y SUM las totaliza: la a suma 10 + 30.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Este programa es vulnerable. ¿En qué línea está el problema?', NULL, '{"lines":["nombre = input(\"Titular: \")","cursor.execute(f\"SELECT * FROM cuentas WHERE titular = ''{nombre}''\")","print(cursor.fetchall())"]}', '{"line_number":2}', 'Inyección SQL: el valor va pegado a la consulta. Debía ser execute("... = ?", (nombre,)).', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El parámetro no funciona. ¿En qué línea está el error?', NULL, '{"lines":["cursor.execute(","    \"SELECT * FROM cuentas WHERE numero = ?\",","    (\"001\")",")"]}', '{"line_number":3}', 'Falta la coma: ("001") es un texto entre paréntesis, no una tupla. Debía ser ("001",).', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la transferencia con transacción', NULL, '{"lines":[{"id":"l1","text":"try:","indent":0},{"id":"l2","text":"cur.execute(\"UPDATE cuentas SET saldo = saldo - ? WHERE numero = ?\", (monto, origen))","indent":1},{"id":"l3","text":"cur.execute(\"UPDATE cuentas SET saldo = saldo + ? WHERE numero = ?\", (monto, destino))","indent":1},{"id":"l4","text":"conexion.commit()","indent":1},{"id":"l5","text":"except Exception:","indent":0},{"id":"l6","text":"conexion.rollback()","indent":1},{"id":"l7","text":"raise","indent":1}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7"]}', 'Los dos UPDATE van antes del único commit: si algo falla, el rollback deshace los dos y el raise avisa a quien llamó.', 1, 'seed'
    FROM chapters WHERE number = 21 AND track = 'basico';

-- ── Capítulo 22: Pandas y datos (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 22, 'Pandas y datos', '🐼', 'Cargar, limpiar y analizar datos reales.', '<p class="jc-gancho">Te pasan el CSV de ventas del año: 80 mil filas. Con el módulo <code>csv</code> del capítulo 17 y un par de ciclos lo sacas… en cuarenta líneas. Con pandas, el mismo análisis son cuatro. Esta es la herramienta con la que trabaja todo el que vive de datos.</p>

<h2>Instalar y arrancar</h2>

<pre><code>pip install pandas</code></pre>

<pre><code>import pandas as pd     # el apodo "pd" es la convención universal</code></pre>

<h2>El DataFrame: una tabla con superpoderes</h2>

<p>Un <strong>DataFrame</strong> es una tabla: filas y columnas con nombre. Una <strong>Series</strong> es una sola columna.</p>

<pre><code>datos = {
    "producto": ["pan", "leche", "queso", "cafe"],
    "precio": [5000, 7000, 15000, 12000],
    "cantidad": [30, 20, 8, 15],
}

df = pd.DataFrame(datos)
print(df)</code></pre>

<pre><code>  producto  precio  cantidad
0      pan    5000        30
1    leche    7000        20
2    queso   15000         8
3     cafe   12000        15</code></pre>

<p>Lo normal es cargarlo de un archivo:</p>

<pre><code>df = pd.read_csv("ventas.csv")
df = pd.read_excel("ventas.xlsx")
df = pd.read_json("ventas.json")</code></pre>

<h3>Mirar antes de tocar</h3>

<pre><code>df.head()        # las primeras 5 filas
df.tail(3)       # las últimas 3
df.shape         # (4, 3) — filas y columnas
df.columns       # los nombres
df.info()        # tipos y cuántos nulos hay
df.describe()    # media, mínimo, máximo, cuartiles</code></pre>

<p>Ese <code>df.info()</code> es lo primero que se corre siempre: dice cuántos datos faltan y si los números llegaron como texto.</p>

<h2>Seleccionar y filtrar</h2>

<pre><code>df["precio"]                    # una columna (Series)
df[["producto", "precio"]]      # varias (DataFrame)

df.loc[0]                       # la fila con etiqueta 0
df.loc[0, "precio"]             # una celda
df.iloc[0]                      # la primera fila por posición</code></pre>

<p>El filtrado es lo que reemplaza los ciclos:</p>

<pre><code># Todos los productos que cuestan más de 10000
caros = df[df["precio"] &gt; 10000]

# Dos condiciones: & es "y", | es "o", y cada una va en paréntesis
df[(df["precio"] &gt; 6000) &amp; (df["cantidad"] &lt; 20)]</code></pre>

<p>Los paréntesis no son opcionales y se usa <code>&amp;</code> en vez de <code>and</code>: pandas compara columnas enteras a la vez, no valores sueltos.</p>

<h2>Columnas calculadas</h2>

<pre><code>df["total"] = df["precio"] * df["cantidad"]</code></pre>

<p>Esa línea multiplica <strong>las cuatro filas de una vez</strong>. Sin ciclo. Se llama <em>operación vectorizada</em>, y es de donde sale la velocidad de pandas.</p>

<pre><code>df["con_iva"] = (df["precio"] * 1.19).round()
df["categoria"] = df["precio"].apply(lambda p: "caro" if p &gt; 10000 else "barato")</code></pre>

<h2>Agrupar: el <code>GROUP BY</code> de pandas</h2>

<pre><code>ventas = pd.read_csv("ventas.csv")   # columnas: fecha, vendedor, producto, monto

ventas.groupby("vendedor")["monto"].sum()
ventas.groupby("vendedor")["monto"].mean()
ventas.groupby("producto")["monto"].agg(["count", "sum", "mean"])</code></pre>

<p>Es la misma idea del capítulo 12 (contar con diccionarios) y del 21 (<code>GROUP BY</code> en SQL), en una línea.</p>

<pre><code># Los tres vendedores que más vendieron
ventas.groupby("vendedor")["monto"].sum().sort_values(ascending=False).head(3)</code></pre>

<p>Se lee de izquierda a derecha como una cadena de pasos: agrupa, suma, ordena, toma tres.</p>

<h2>Datos sucios: lo que de verdad ocupa el tiempo</h2>

<p>Los datos reales llegan con celdas vacías, tipos equivocados y filas repetidas. Limpiar es el 80% del trabajo:</p>

<pre><code>df.isnull().sum()              # cuántos nulos por columna

df = df.dropna()               # borrar filas con nulos
df["monto"] = df["monto"].fillna(0)          # o rellenarlos
df["monto"] = df["monto"].fillna(df["monto"].mean())

df = df.drop_duplicates()      # quitar filas repetidas

# Los números que llegaron como texto
df["monto"] = pd.to_numeric(df["monto"], errors="coerce")
df["fecha"] = pd.to_datetime(df["fecha"])

# Espacios y mayúsculas en las columnas de texto
df["vendedor"] = df["vendedor"].str.strip().str.title()</code></pre>

<p><code>errors="coerce"</code> convierte lo que no sea número en <code>NaN</code> en vez de reventar. Es la versión pandas del <code>try/except</code> del capítulo 15.</p>

<h2>Un análisis completo, de principio a fin</h2>

<pre><code>import pandas as pd

# 1. Cargar
ventas = pd.read_csv("ventas.csv")

# 2. Limpiar
ventas["monto"] = pd.to_numeric(ventas["monto"], errors="coerce")
ventas = ventas.dropna(subset=["monto"])
ventas["vendedor"] = ventas["vendedor"].str.strip().str.title()

# 3. Enriquecer
ventas["fecha"] = pd.to_datetime(ventas["fecha"])
ventas["mes"] = ventas["fecha"].dt.month

# 4. Analizar
por_vendedor = ventas.groupby("vendedor")["monto"].agg(["count", "sum"])
por_mes = ventas.groupby("mes")["monto"].sum()

# 5. Guardar
por_vendedor.to_csv("reporte_vendedores.csv")</code></pre>

<p><strong>Cargar → limpiar → enriquecer → analizar → guardar.</strong> Ese es el orden de cualquier trabajo con datos, y no cambia con el tamaño del archivo.</p>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Usar <code>and</code> en vez de <code>&amp;</code></h3>
<pre><code>df[df["a"] &gt; 1 and df["b"] &lt; 2]        # ❌ ValueError
df[(df["a"] &gt; 1) &amp; (df["b"] &lt; 2)]      # ✅ con paréntesis</code></pre>

<h3>2. Creer que los métodos modifican el DataFrame</h3>
<pre><code>df.dropna()          # ❌ devuelve una copia y se pierde
df = df.dropna()     # ✅</code></pre>
<p>Es el mismo error de <code>texto.upper()</code> del capítulo 5, con otro disfraz.</p>

<h3>3. Recorrer el DataFrame con un ciclo</h3>
<pre><code>for i, fila in df.iterrows():          # ❌ lentísimo
    df.loc[i, "total"] = fila["precio"] * fila["cantidad"]

df["total"] = df["precio"] * df["cantidad"]   # ✅ vectorizado</code></pre>
<p>Si estás escribiendo un <code>for</code> sobre un DataFrame, casi siempre hay una forma sin ciclo que es cien veces más rápida.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Cargar, y de una <code>df.info()</code> y <code>df.head()</code> para ver qué llegó.</li>
  <li>Limpiar: nulos, tipos, duplicados, espacios.</li>
  <li>Enriquecer con columnas calculadas, sin ciclos.</li>
  <li>Analizar con <code>groupby</code> y <code>agg</code>.</li>
  <li>Guardar el resultado, no dejarlo en la consola.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>pd.read_csv("x.csv")</code></td><td>Carga la tabla</td></tr>
    <tr><td><code>df.head()</code> · <code>df.info()</code></td><td>Primeras filas · tipos y nulos</td></tr>
    <tr><td><code>df["col"]</code></td><td>Una columna</td></tr>
    <tr><td><code>df[df["col"] &gt; 10]</code></td><td>Filtrar filas</td></tr>
    <tr><td><code>df["nueva"] = df["a"] * df["b"]</code></td><td>Columna calculada, sin ciclo</td></tr>
    <tr><td><code>df.groupby("x")["y"].sum()</code></td><td>Agrupar y sumar</td></tr>
    <tr><td><code>df.dropna()</code> · <code>df.fillna(0)</code></td><td>Quitar o rellenar nulos</td></tr>
    <tr><td><code>df.sort_values("col")</code></td><td>Ordenar</td></tr>
    <tr><td><code>df.to_csv("out.csv", index=False)</code></td><td>Guardar</td></tr>
  </tbody>
</table>

<blockquote>Si estás escribiendo un ciclo sobre un DataFrame, probablemente hay una línea de pandas que hace lo mismo cien veces más rápido.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 6
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 22 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 22 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Primer DataFrame', 'facil', '<p>Crear un DataFrame con el inventario de la tienda (producto, precio, cantidad), agregar una columna <code>total</code> y mostrar la tabla, el valor del inventario y el producto más caro.</p><pre><code>  producto  precio  cantidad   total
0      pan    5000        30  150000
1    leche    7000        20  140000
2    queso   15000         8  120000
3     cafe   12000        15  180000
Valor del inventario: 590,000
El mas caro: queso</code></pre><p><em>Nota:</em> la columna <code>total</code> se calcula sin ciclos.</p>', '<p><code>df["total"] = df["precio"] * df["cantidad"]</code> multiplica todas las filas de una vez. Para el más caro, <code>df.loc[df["precio"].idxmax(), "producto"]</code>.</p>', '<pre><code>''''''
Programa: Inventario con pandas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Arma el inventario de la tienda como DataFrame y calcula el
    valor total y el producto mas caro.
''''''

import pandas as pd

# Inicio
datos = {
    "producto": ["pan", "leche", "queso", "cafe"],
    "precio": [5000, 7000, 15000, 12000],
    "cantidad": [30, 20, 8, 15],
}

df = pd.DataFrame(datos)

# Operacion vectorizada: multiplica las cuatro filas a la vez,
# sin escribir un solo ciclo
df["total"] = df["precio"] * df["cantidad"]

print(df)
print(f"Valor del inventario: {df[''total''].sum():,}")
print(f"El mas caro: {df.loc[df[''precio''].idxmax(), ''producto'']}")
# Fin</code></pre><p>La línea del <code>total</code> es la que muestra de qué se trata pandas: en el capítulo 10 esto habría sido un <code>for</code> recorriendo dos listas paralelas. Aquí es una operación sobre columnas enteras.</p><p><code>idxmax()</code> devuelve la <strong>etiqueta de la fila</strong> con el valor más alto, y <code>df.loc[etiqueta, columna]</code> saca la celda.</p>', NULL, '''''''
Programa: Inventario con pandas
Autor:
Fecha:
Descripcion:
''''''

import pandas as pd

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Filtrar ventas', 'facil', '<p>Con un DataFrame de ventas (vendedor, producto, monto), mostrar:</p><ul><li>las ventas mayores a 100000,</li><li>las ventas de "Ana" de más de 50000,</li><li>y cuántas ventas hubo en total.</li></ul><p><em>Nota:</em> use filtrado de pandas, no ciclos ni <code>if</code>.</p>', '<p>Un filtro es <code>df[df["monto"] > 100000]</code>. Para dos condiciones, cada una entre paréntesis y unidas con <code>&amp;</code>, nunca con <code>and</code>.</p>', '<pre><code>''''''
Programa: Filtros sobre las ventas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Consulta un DataFrame de ventas usando filtros booleanos.
''''''

import pandas as pd

# Inicio
ventas = pd.DataFrame({
    "vendedor": ["Ana", "Juan", "Ana", "Sofia", "Juan"],
    "producto": ["pan", "queso", "cafe", "leche", "pan"],
    "monto": [150000, 80000, 45000, 120000, 200000],
})

grandes = ventas[ventas["monto"] > 100000]
print("Ventas grandes:")
print(grandes)

# Dos condiciones: cada una en parentesis y unidas con &
# (con "and" pandas lanza ValueError)
de_ana = ventas[(ventas["vendedor"] == "Ana") & (ventas["monto"] > 50000)]
print("\nVentas de Ana sobre 50000:")
print(de_ana)

print(f"\nTotal de ventas registradas: {len(ventas)}")
# Fin</code></pre><p>La razón de usar <code>&amp;</code> y no <code>and</code>: pandas no compara dos valores, compara <strong>dos columnas enteras</strong> y devuelve una columna de <code>True</code>/<code>False</code>. El <code>and</code> de Python no sabe qué hacer con eso y lanza <code>ValueError</code>.</p><p>Los paréntesis tampoco son opcionales: <code>&amp;</code> tiene más prioridad que <code>&gt;</code>, así que sin ellos la comparación se agrupa al revés.</p>', NULL, '''''''
Programa: Filtros sobre las ventas
Autor:
Fecha:
Descripcion:
''''''

import pandas as pd

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Limpiar datos sucios', 'medio', '<p>Un CSV de ventas llegó con problemas: montos como texto, celdas vacías, nombres con espacios y mayúsculas inconsistentes, y filas duplicadas.</p><p>Escribir el proceso de limpieza y reportar cuántas filas se descartaron y el total limpio.</p><p><em>Nota:</em> los montos que no sean números deben descartarse, no romper el programa.</p>', '<p><code>pd.to_numeric(col, errors="coerce")</code> convierte y pone <code>NaN</code> en lo que no sirva. Después <code>dropna()</code>, <code>drop_duplicates()</code> y <code>.str.strip().str.title()</code> para los nombres.</p>', '<pre><code>''''''
Programa: Limpieza de datos de ventas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Toma un DataFrame de ventas con datos sucios y lo deja listo
    para analizar, reportando cuanto se descarto.
''''''

import pandas as pd

# Inicio
crudo = pd.DataFrame({
    "vendedor": [" ana ", "JUAN", "Ana", "sofia", "JUAN", "Ana"],
    "monto": ["150000", "80000", "sin dato", "120000", "80000", None],
})

filas_iniciales = len(crudo)
df = crudo.copy()

# 1. Los montos llegaron como texto. errors="coerce" pone NaN en
#    lo que no sea numero, en vez de reventar
df["monto"] = pd.to_numeric(df["monto"], errors="coerce")

# 2. Fuera las filas sin monto valido
df = df.dropna(subset=["monto"])

# 3. Normalizar los nombres antes de comparar o agrupar
df["vendedor"] = df["vendedor"].str.strip().str.title()

# 4. Quitar filas repetidas (ya con los nombres normalizados)
df = df.drop_duplicates()

print(df)
print(f"Filas iniciales: {filas_iniciales}")
print(f"Filas limpias: {len(df)}")
print(f"Descartadas: {filas_iniciales - len(df)}")
print(f"Total limpio: {df[''monto''].sum():,.0f}")
# Fin</code></pre><p>El orden de los pasos importa:</p><ul><li><strong>Convertir antes de descartar.</strong> Si se hiciera <code>dropna()</code> primero, el texto <code>"sin dato"</code> seguiría ahí porque no es nulo: es un texto.</li><li><strong>Normalizar antes de <code>drop_duplicates()</code>.</strong> <code>" ana "</code> y <code>"Ana"</code> son distintos para el computador hasta que se les quita el espacio y se unifican las mayúsculas. Es la misma lección del capítulo 5.</li></ul><p>Limpiar es lo que más tiempo toma en un trabajo real con datos. El análisis en sí suele ser la parte corta.</p>', NULL, '''''''
Programa: Limpieza de datos de ventas
Autor:
Fecha:
Descripcion:
''''''

import pandas as pd

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Reporte de ventas del año', 'dificil', '<p>Escribir el análisis completo de un archivo <code>ventas.csv</code> con columnas <code>fecha</code>, <code>vendedor</code>, <code>producto</code> y <code>monto</code>. El programa debe:</p><ol><li>cargar y limpiar los datos,</li><li>agregar una columna con el mes,</li><li>calcular el total y el número de ventas por vendedor,</li><li>el mejor mes,</li><li>el producto más vendido,</li><li>y guardar el reporte por vendedor en <code>reporte.csv</code>.</li></ol><p><em>Nota:</em> el programa debe funcionar aunque el CSV traiga montos inválidos o celdas vacías.</p>', '<p>Siga el orden cargar → limpiar → enriquecer → analizar → guardar. Para el mes, <code>df["fecha"].dt.month</code> después de convertir con <code>pd.to_datetime()</code>. Para varios cálculos a la vez, <code>.agg(["count", "sum"])</code>.</p>', '<pre><code>''''''
Programa: Reporte anual de ventas
Autor:    Ana Gomez
Fecha:    2026-03-14
Descripcion:
    Carga el historico de ventas, lo limpia y produce el reporte
    por vendedor, por mes y por producto.
''''''

import pandas as pd

ARCHIVO = "ventas.csv"
SALIDA = "reporte.csv"


def cargar_y_limpiar(ruta):
    ''''''
    Carga el CSV y lo deja listo para analizar.

    Parametros:
        ruta (str): archivo de ventas

    Retorna:
        DataFrame: solo las filas utilizables
    ''''''
    df = pd.read_csv(ruta)

    # Los montos pueden venir como texto o vacios
    df["monto"] = pd.to_numeric(df["monto"], errors="coerce")
    df = df.dropna(subset=["monto"])

    # Nombres normalizados antes de agrupar: " ana " y "Ana"
    # deben contar como la misma persona
    df["vendedor"] = df["vendedor"].str.strip().str.title()
    df["producto"] = df["producto"].str.strip().str.lower()

    df = df.drop_duplicates()

    return df


# Inicio
# Se crea un archivo de ejemplo para que el programa sea autocontenido
pd.DataFrame({
    "fecha": ["2026-01-15", "2026-01-20", "2026-02-03", "2026-02-14", "2026-03-01"],
    "vendedor": [" ana ", "JUAN", "Ana", "Sofia", "juan"],
    "producto": ["Pan", "queso", "pan", "cafe", "PAN"],
    "monto": ["150000", "80000", "sin dato", "120000", "200000"],
}).to_csv(ARCHIVO, index=False)

ventas = cargar_y_limpiar(ARCHIVO)

# Enriquecer: la fecha como fecha de verdad, y el mes aparte
ventas["fecha"] = pd.to_datetime(ventas["fecha"])
ventas["mes"] = ventas["fecha"].dt.month

# Analizar
por_vendedor = ventas.groupby("vendedor")["monto"].agg(["count", "sum"])
por_mes = ventas.groupby("mes")["monto"].sum()
por_producto = ventas.groupby("producto")["monto"].sum()

print("Por vendedor:")
print(por_vendedor)

print(f"\nMejor mes: {por_mes.idxmax()} con {por_mes.max():,.0f}")
print(f"Producto mas vendido: {por_producto.idxmax()}")
print(f"Total del periodo: {ventas[''monto''].sum():,.0f}")

# Guardar: un reporte que se queda en la consola no le sirve a nadie
por_vendedor.to_csv(SALIDA)
print(f"\nReporte guardado en {SALIDA}")
# Fin</code></pre><p>Este es el flujo completo de cualquier trabajo con datos, y no cambia con el tamaño del archivo: con cinco filas o con ochenta mil, el programa es el mismo.</p><ul><li><strong>La limpieza va en su propia función.</strong> Es la parte que más se retoca cuando aparecen datos nuevos, y tenerla aparte evita revolverla con el análisis.</li><li><strong>Normalizar antes de agrupar es obligatorio.</strong> Sin el <code>.str.title()</code>, " ana " y "Ana" saldrían como dos vendedoras distintas y el reporte estaría mal sin que nadie lo note.</li><li><strong><code>.agg(["count", "sum"])</code></strong> calcula varias cosas de un tirón, en vez de agrupar dos veces.</li><li><strong>El reporte se guarda.</strong> El análisis termina en un archivo que alguien pueda abrir, no en la pantalla.</li></ul>', NULL, '''''''
Programa: Reporte anual de ventas
Autor:
Fecha:
Descripcion:
''''''

import pandas as pd

ARCHIVO = "ventas.csv"
SALIDA = "reporte.csv"


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 22 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué es un DataFrame?', NULL, '{"options":[{"id":"a","text":"Una tabla con filas y columnas con nombre"},{"id":"b","text":"Una lista de listas"},{"id":"c","text":"Un archivo CSV abierto"},{"id":"d","text":"Una función de pandas"}]}', '{"option_id":"a"}', 'Es la estructura central de pandas. Una sola columna de un DataFrame es una Series.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué muestra df.info()?', NULL, '{"options":[{"id":"a","text":"Los tipos de cada columna y cuántos valores no nulos hay"},{"id":"b","text":"Las primeras cinco filas"},{"id":"c","text":"La media y los cuartiles"},{"id":"d","text":"El nombre del archivo cargado"}]}', '{"option_id":"a"}', 'Es lo primero que se corre siempre: dice si faltan datos y si los números llegaron como texto.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué se usa & y no and para combinar dos filtros?', NULL, '{"options":[{"id":"a","text":"Porque pandas compara columnas enteras y and no sabe qué hacer con eso"},{"id":"b","text":"Porque and no existe en pandas"},{"id":"c","text":"Porque & es más rápido"},{"id":"d","text":"Porque and solo sirve con números"}]}', '{"option_id":"a"}', 'Cada comparación devuelve una columna de True/False. Con and pandas lanza ValueError, y cada condición debe ir entre paréntesis.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace pd.to_numeric(col, errors="coerce")?', NULL, '{"options":[{"id":"a","text":"Convierte a número y pone NaN en lo que no se pueda convertir"},{"id":"b","text":"Lanza un error si algo no es número"},{"id":"c","text":"Borra las filas que no sean números"},{"id":"d","text":"Convierte los números a texto"}]}', '{"option_id":"a"}', 'Es la versión pandas del try/except del capítulo 15: en vez de reventar, marca lo inválido para descartarlo después con dropna().', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Cuál es el orden correcto de un trabajo con datos?', NULL, '{"options":[{"id":"a","text":"Cargar, limpiar, enriquecer, analizar, guardar"},{"id":"b","text":"Cargar, analizar, limpiar, guardar"},{"id":"c","text":"Limpiar, cargar, guardar, analizar"},{"id":"d","text":"Cargar, guardar, limpiar, analizar"}]}', '{"option_id":"a"}', 'Analizar antes de limpiar da resultados falsos: un mismo vendedor escrito de dos formas cuenta como dos personas.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'import pandas as pd
df = pd.DataFrame({"a": [1, 2, 3], "b": [10, 20, 30]})
df["c"] = df["a"] * df["b"]
print(df["c"].sum())', '{"options":[{"id":"a","text":"140"},{"id":"b","text":"60"},{"id":"c","text":"6"},{"id":"d","text":"[10, 40, 90]"}]}', '{"option_id":"a"}', 'La columna c es [10, 40, 90] calculada de una sola vez, sin ciclo, y su suma es 140.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'import pandas as pd
df = pd.DataFrame({"p": ["pan", "queso", "cafe"], "v": [5000, 15000, 12000]})
print(len(df[df["v"] > 10000]))', '{"options":[{"id":"a","text":"2"},{"id":"b","text":"1"},{"id":"c","text":"3"},{"id":"d","text":"27000"}]}', '{"option_id":"a"}', 'El filtro deja las filas de queso y cafe, y len() cuenta filas del DataFrame resultante.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'import pandas as pd
df = pd.DataFrame({"v": ["Ana", "Juan", "Ana"], "m": [100, 200, 300]})
print(df.groupby("v")["m"].sum().idxmax())', '{"options":[{"id":"a","text":"Ana"},{"id":"b","text":"Juan"},{"id":"c","text":"400"},{"id":"d","text":"0"}]}', '{"option_id":"a"}', 'Ana suma 400 y Juan 200. idxmax() devuelve la etiqueta del grupo más alto, no el valor.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El filtro lanza ValueError. ¿En qué línea está el error?', NULL, '{"lines":["import pandas as pd","df = pd.DataFrame({\"a\": [1, 2], \"b\": [3, 4]})","print(df[df[\"a\"] > 1 and df[\"b\"] < 4])"]}', '{"line_number":3}', 'Con dos condiciones va (df["a"] > 1) & (df["b"] < 4): paréntesis y & en vez de and.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Las filas nulas siguen ahí. ¿En qué línea está el error?', NULL, '{"lines":["df = pd.read_csv(\"ventas.csv\")","df.dropna()","print(df.isnull().sum())"]}', '{"line_number":2}', 'dropna() devuelve una copia; hay que reasignar con df = df.dropna(). Mismo error de texto.upper() del capítulo 5.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'El reporte cuenta a la misma vendedora dos veces. ¿En qué línea está el problema?', NULL, '{"lines":["df = pd.read_csv(\"ventas.csv\")","resumen = df.groupby(\"vendedor\")[\"monto\"].sum()","df[\"vendedor\"] = df[\"vendedor\"].str.strip().str.title()","print(resumen)"]}', '{"line_number":2}', 'Se agrupa antes de normalizar los nombres, así que '' ana '' y ''Ana'' quedan como dos grupos. La limpieza va primero.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el análisis de ventas en el orden correcto', NULL, '{"lines":[{"id":"l1","text":"ventas = pd.read_csv(\"ventas.csv\")","indent":0},{"id":"l2","text":"ventas[\"monto\"] = pd.to_numeric(ventas[\"monto\"], errors=\"coerce\")","indent":0},{"id":"l3","text":"ventas = ventas.dropna(subset=[\"monto\"])","indent":0},{"id":"l4","text":"ventas[\"vendedor\"] = ventas[\"vendedor\"].str.strip().str.title()","indent":0},{"id":"l5","text":"por_vendedor = ventas.groupby(\"vendedor\")[\"monto\"].sum()","indent":0},{"id":"l6","text":"por_vendedor.to_csv(\"reporte.csv\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6"]}', 'Cargar, convertir, descartar lo inválido, normalizar el texto, agrupar y guardar. Convertir va antes de dropna porque ''sin dato'' es texto, no nulo.', 1, 'seed'
    FROM chapters WHERE number = 22 AND track = 'basico';

-- ── Capítulo 23: IA aplicada con Python (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 23, 'IA aplicada con Python', '🤖', 'Consumir modelos y construir algo útil con ellos.', '<p class="jc-gancho">Llegan 400 PQRs al correo de la empresa cada semana y alguien tiene que leerlas una por una para saber cuáles son quejas urgentes. Ese trabajo hoy lo hace un programa de treinta líneas. No porque sepamos construir un modelo de IA: porque sabemos <em>usarlo</em>, que es una habilidad distinta y mucho más útil.</p>

<h2>Un modelo de IA es un servicio al que le hablas</h2>

<p>El modelo no corre en tu computador. Vive en un servidor de la empresa que lo entrenó, y se le habla por una <strong>API</strong>: le mandas un mensaje por internet y te devuelve una respuesta.</p>

<table>
  <thead>
    <tr><th>Tú pones</th><th>Ellos ponen</th></tr>
  </thead>
  <tbody>
    <tr><td>El texto de la pregunta (el <em>prompt</em>)</td><td>El modelo entrenado</td></tr>
    <tr><td>Una llave que identifica tu cuenta</td><td>Los computadores que lo ejecutan</td></tr>
    <tr><td>El código que usa la respuesta</td><td>El cobro por uso</td></tr>
  </tbody>
</table>

<p>Es exactamente el mismo mecanismo de cualquier API: una petición HTTP con datos en JSON. Lo que cambia es que la respuesta la escribe un modelo de lenguaje en vez de una base de datos.</p>

<h2>La llave nunca va en el código</h2>

<p>Para usar la API te dan una <strong>API key</strong>: un texto largo que identifica y le cobra a tu cuenta. Si la subes a GitHub, en horas hay bots usándola con tu tarjeta.</p>

<pre><code>pip install requests python-dotenv</code></pre>

<p>La llave va en un archivo <code>.env</code>, y ese archivo va en el <code>.gitignore</code>:</p>

<pre><code># .env  ← este archivo NO se sube nunca
API_KEY=sk-tu-llave-secreta-aqui</code></pre>

<pre><code>import os
from dotenv import load_dotenv

load_dotenv()                      # lee el .env y lo carga al entorno
API_KEY = os.environ["API_KEY"]    # si falta, revienta aquí y no a mitad del programa</code></pre>

<p>Usar <code>os.environ["API_KEY"]</code> y no <code>.get()</code> es a propósito: si la llave no está, quieres enterarte de una, no cincuenta líneas después con un error 401 confuso.</p>

<h2>Tu primera llamada</h2>

<pre><code>import requests

respuesta = requests.post(
    "https://api.anthropic.com/v1/messages",
    headers={
        "x-api-key": API_KEY,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
    },
    json={
        "model": "claude-sonnet-4-5",
        "max_tokens": 500,
        "messages": [
            {"role": "user", "content": "Explica que es una variable en una frase."}
        ],
    },
    timeout=30,
)

datos = respuesta.json()
print(datos["content"][0]["text"])</code></pre>

<p>Pieza por pieza:</p>

<table>
  <thead>
    <tr><th>Parte</th><th>Para qué</th></tr>
  </thead>
  <tbody>
    <tr><td><code>headers</code></td><td>Quién eres: la llave viaja aquí, no en la URL</td></tr>
    <tr><td><code>json=</code></td><td>Lo que preguntas, como diccionario de Python</td></tr>
    <tr><td><code>messages</code></td><td>La conversación: lista de turnos con <code>role</code> y <code>content</code></td></tr>
    <tr><td><code>max_tokens</code></td><td>Tope de largo de la respuesta: también es tope de costo</td></tr>
    <tr><td><code>timeout=30</code></td><td>Sin esto, el programa puede quedarse colgado para siempre</td></tr>
  </tbody>
</table>

<p><code>respuesta.json()</code> convierte la respuesta a un diccionario, igual que <code>json.loads()</code> del capítulo 17. Y como cualquier llamada por internet puede fallar, se revisa antes de usarla:</p>

<pre><code>if respuesta.status_code != 200:
    print(f"Error {respuesta.status_code}: {respuesta.text}")
else:
    print(respuesta.json()["content"][0]["text"])</code></pre>

<h2>El prompt es el programa</h2>

<p>Aquí está el cambio de mentalidad del capítulo: <strong>las instrucciones que le das al modelo son código</strong>. Un prompt vago da resultados vagos, y no hay forma de arreglarlo después.</p>

<pre><code># ❌ Vago
"Analiza este mensaje: " + mensaje

# ✅ Preciso: rol, tarea, opciones y formato de salida
''''''Eres un clasificador de PQRs de una empresa de servicios.
Clasifica el mensaje en exactamente una categoria: queja, peticion,
reclamo o felicitacion.
Responde UNICAMENTE con la palabra de la categoria, en minusculas,
sin explicaciones.

Mensaje: '''''' + mensaje</code></pre>

<p>Tres reglas que se cumplen siempre:</p>

<ol>
  <li><strong>Di qué rol tiene</strong> y qué tarea hace.</li>
  <li><strong>Da las opciones cerradas</strong> cuando el resultado deba ser uno de varios valores.</li>
  <li><strong>Exige el formato exacto</strong> de la salida, porque tu código la va a leer.</li>
</ol>

<p>Ese último punto es el que separa un juguete de un programa: si el modelo contesta <em>"¡Claro! Esta PQR parece una queja porque…"</em>, tu <code>if categoria == "queja"</code> nunca se cumple.</p>

<h2>Pedir la respuesta en JSON</h2>

<p>Cuando necesitas varios datos de una sola llamada, se pide JSON y se convierte con <code>json.loads()</code>:</p>

<pre><code>import json

PROMPT = ''''''Analiza la siguiente PQR y responde SOLO con un JSON valido,
sin texto antes ni despues, con esta forma exacta:
{"categoria": "queja|peticion|reclamo|felicitacion", "urgencia": 1-5, "resumen": "una frase"}

PQR: ''''''


def analizar(mensaje):
    ''''''
    Envia una PQR al modelo y devuelve su analisis.

    Parametros:
        mensaje (str): texto de la PQR

    Retorna:
        dict: categoria, urgencia y resumen, o None si algo fallo
    ''''''
    r = requests.post(URL, headers=CABECERAS, timeout=30, json={
        "model": MODELO,
        "max_tokens": 300,
        "messages": [{"role": "user", "content": PROMPT + mensaje}],
    })

    if r.status_code != 200:
        return None

    texto = r.json()["content"][0]["text"]

    # El modelo es texto: puede devolver algo que no sea JSON.
    # Nunca se confia, siempre se envuelve
    try:
        return json.loads(texto)
    except json.JSONDecodeError:
        return None</code></pre>

<p>Ese <code>try/except</code> no es paranoia. Un modelo de lenguaje <strong>no garantiza</strong> el formato: la mayoría de las veces obedece, y de vez en cuando agrega una frase de cortesía que rompe el <code>json.loads()</code>. El programa tiene que sobrevivir a eso.</p>

<h2>El clasificador completo</h2>

<p>Aquí se juntan los tres últimos capítulos: pandas para los datos, la API para el criterio, y un archivo de salida para el resultado.</p>

<pre><code>import pandas as pd

pqrs = pd.read_csv("pqrs.csv")           # columnas: fecha, cliente, mensaje

resultados = []
for mensaje in pqrs["mensaje"]:
    analisis = analizar(mensaje)
    if analisis is None:
        analisis = {"categoria": "sin_clasificar", "urgencia": 0, "resumen": ""}
    resultados.append(analisis)

pqrs["categoria"] = [a["categoria"] for a in resultados]
pqrs["urgencia"] = [a["urgencia"] for a in resultados]

urgentes = pqrs[(pqrs["categoria"] == "reclamo") &amp; (pqrs["urgencia"] &gt;= 4)]
print(f"Reclamos urgentes: {len(urgentes)}")
print(pqrs.groupby("categoria").size())

pqrs.to_csv("pqrs_clasificadas.csv", index=False)</code></pre>

<p>Fíjate en el detalle importante: cuando el modelo falla, la fila <strong>no se pierde</strong>, queda como <code>sin_clasificar</code>. Un proceso que corre sobre 400 filas no puede caerse porque una respuesta llegó mal.</p>

<p>Este es el único ciclo justificado sobre un DataFrame: cada llamada es una petición por internet, y de eso no hay versión vectorizada.</p>

<h2>Lo que el modelo no sabe</h2>

<p>Dos cosas que hay que tener claras antes de poner esto a trabajar en serio:</p>

<ul>
  <li><strong>El modelo inventa con total seguridad.</strong> Si le preguntas el saldo de una cuenta, se lo imagina. Sirve para clasificar, resumir, redactar y extraer; no es una fuente de datos.</li>
  <li><strong>Todo lo que le mandas sale de tu computador.</strong> Cédulas, números de cuenta y datos de clientes no se envían a un servicio externo sin autorización.</li>
</ul>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Dejar la API key en el código</h3>
<pre><code>API_KEY = "sk-ant-abc123..."          # ❌ y encima subido a GitHub
API_KEY = os.environ["API_KEY"]       # ✅ con el .env en .gitignore</code></pre>

<h3>2. Confiar en que la respuesta viene como se pidió</h3>
<pre><code>datos = json.loads(texto)             # ❌ un día trae "Claro, aqui tienes:" adelante

try:                                  # ✅
    datos = json.loads(texto)
except json.JSONDecodeError:
    datos = None</code></pre>

<h3>3. Llamar sin timeout ni control de errores dentro de un ciclo</h3>
<pre><code>for m in mensajes:                    # ❌ 400 llamadas, una falla, se cae todo
    r = requests.post(URL, json=...)
    resultados.append(r.json())</code></pre>
<p>Cada llamada cuesta plata y tarda. Con 400 filas eso son 400 cobros: prueba primero con <code>pqrs.head(5)</code>.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>La llave en el <code>.env</code>, cargada con <code>load_dotenv()</code>. El <code>.env</code> en el <code>.gitignore</code>.</li>
  <li>El prompt dice rol, tarea, opciones cerradas y formato exacto de salida.</li>
  <li>Toda llamada con <code>timeout</code> y revisando <code>status_code</code>.</li>
  <li>Todo <code>json.loads()</code> de una respuesta del modelo, dentro de <code>try/except</code>.</li>
  <li>Si una fila falla, se marca y el proceso sigue.</li>
  <li>Probar con cinco filas antes de correr las cuatrocientas.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>load_dotenv()</code></td><td>Carga el <code>.env</code> al entorno</td></tr>
    <tr><td><code>os.environ["API_KEY"]</code></td><td>Lee la llave (falla de una si no está)</td></tr>
    <tr><td><code>requests.post(url, headers=…, json=…)</code></td><td>Envía la petición</td></tr>
    <tr><td><code>r.status_code</code></td><td>200 éxito · 401 llave mala · 429 demasiadas llamadas</td></tr>
    <tr><td><code>r.json()</code></td><td>La respuesta como diccionario</td></tr>
    <tr><td><code>max_tokens</code></td><td>Tope de largo y de costo</td></tr>
    <tr><td><code>timeout=30</code></td><td>No esperar para siempre</td></tr>
    <tr><td><code>json.loads(texto)</code></td><td>Convierte la respuesta del modelo a diccionario</td></tr>
  </tbody>
</table>

<blockquote>El modelo pone el criterio; tu programa pone las reglas. Un prompt sin formato exigido y una respuesta sin <code>try/except</code> son las dos formas de que esto funcione en la demo y falle el primer día real.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 6
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 23 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 23 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'La llave segura', 'facil', '<p>Escribir el arranque de un programa que use una API: cargar el <code>.env</code>, leer <code>API_KEY</code> del entorno y avisar con un mensaje claro si no está configurada, en vez de fallar más adelante.</p><p>Cuando sí esté, mostrarla <strong>enmascarada</strong>: los primeros 6 caracteres, tres puntos y los últimos 4.</p><pre><code>Llave cargada: sk-ant...9f2c</code></pre><p><em>Nota:</em> la llave nunca se imprime completa ni se escribe en el código.</p>', '<p><code>load_dotenv()</code> primero, luego <code>os.environ.get("API_KEY")</code>. Para enmascarar, <em>slicing</em> del capítulo 5: <code>llave[:6]</code> y <code>llave[-4:]</code>.</p>', '<pre><code>''''''
Programa: Carga segura de la API key
Autor:    Ana Gomez
Fecha:    2026-03-21
Descripcion:
    Lee la llave de la API desde el entorno y valida que exista
    antes de que el programa siga.
''''''

import os
import sys

from dotenv import load_dotenv


def enmascarar(llave):
    ''''''
    Oculta el centro de una llave para poder mostrarla en pantalla.

    Parametros:
        llave (str): la llave completa

    Retorna:
        str: primeros 6 caracteres, puntos y ultimos 4
    ''''''
    return f"{llave[:6]}...{llave[-4:]}"


# Inicio
load_dotenv()                       # lee el archivo .env y lo pasa al entorno

llave = os.environ.get("API_KEY")

if not llave:
    print("Falta API_KEY. Cree un archivo .env con API_KEY=su-llave")
    sys.exit(1)                     # se corta aqui, no cincuenta lineas despues

print(f"Llave cargada: {enmascarar(llave)}")
# Fin</code></pre><p>Tres decisiones que valen para cualquier programa que use una API:</p><ul><li><strong>La llave se valida al arrancar.</strong> Un error 401 a mitad de un proceso de 400 filas es mucho más difícil de entender que un mensaje al principio.</li><li><strong><code>sys.exit(1)</code></strong> corta el programa con código de error. Si esto corre en un servidor, ese 1 le dice al sistema que algo falló.</li><li><strong>Enmascarar.</strong> Los logs y las capturas de pantalla se comparten. La llave completa no sale nunca a la consola.</li></ul>', NULL, '''''''
Programa: Carga segura de la API key
Autor:
Fecha:
Descripcion:
''''''

import os
import sys

from dotenv import load_dotenv


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Primera pregunta al modelo', 'facil', '<p>Escribir una función <code>preguntar(texto)</code> que envíe el texto al modelo y devuelva su respuesta.</p><p>Requisitos:</p><ul><li><code>timeout</code> en la petición,</li><li>revisar <code>status_code</code> antes de leer la respuesta,</li><li>devolver <code>None</code> si algo salió mal, sin tumbar el programa.</li></ul>', '<p><code>requests.post(url, headers=…, json=…, timeout=30)</code>. El texto de la respuesta está en <code>r.json()["content"][0]["text"]</code>.</p>', '<pre><code>''''''
Programa: Primera llamada a la API del modelo
Autor:    Ana Gomez
Fecha:    2026-03-21
Descripcion:
    Envia una pregunta al modelo y devuelve su respuesta, sin dejar
    que un fallo de red tumbe el programa.
''''''

import os

import requests
from dotenv import load_dotenv

load_dotenv()

URL = "https://api.anthropic.com/v1/messages"
MODELO = "claude-sonnet-4-5"
CABECERAS = {
    "x-api-key": os.environ["API_KEY"],
    "anthropic-version": "2023-06-01",
    "content-type": "application/json",
}


def preguntar(texto, max_tokens=500):
    ''''''
    Envia un texto al modelo y devuelve su respuesta.

    Parametros:
        texto (str): la pregunta
        max_tokens (int): tope de largo de la respuesta

    Retorna:
        str: la respuesta del modelo, o None si la llamada fallo
    ''''''
    try:
        r = requests.post(
            URL,
            headers=CABECERAS,
            timeout=30,             # sin esto el programa puede colgarse
            json={
                "model": MODELO,
                "max_tokens": max_tokens,
                "messages": [{"role": "user", "content": texto}],
            },
        )
    except requests.RequestException as e:
        print(f"Fallo de red: {e}")
        return None

    if r.status_code != 200:
        print(f"Error {r.status_code}: {r.text}")
        return None

    return r.json()["content"][0]["text"]


# Inicio
respuesta = preguntar("Explica que es una variable en una frase.")

if respuesta is None:
    print("No se pudo consultar el modelo")
else:
    print(respuesta)
# Fin</code></pre><p>Hay dos cosas distintas que pueden fallar y por eso se manejan por separado:</p><ul><li><strong>La red</strong> (no hay internet, el servidor no responde): eso lanza una excepción, y se atrapa con <code>except requests.RequestException</code>.</li><li><strong>El servidor respondió, pero con error</strong> (401 llave mala, 429 demasiadas llamadas): ahí no hay excepción, hay que mirar <code>status_code</code>.</li></ul><p>Un programa que solo revisa uno de los dos falla el día que ocurre el otro.</p>', NULL, '''''''
Programa: Primera llamada a la API del modelo
Autor:
Fecha:
Descripcion:
''''''

import os

import requests
from dotenv import load_dotenv

load_dotenv()

URL = "https://api.anthropic.com/v1/messages"
MODELO = "claude-sonnet-4-5"


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Clasificador de PQRs', 'medio', '<p>Escribir una función <code>clasificar(mensaje)</code> que devuelva una de cuatro categorías: <code>queja</code>, <code>peticion</code>, <code>reclamo</code> o <code>felicitacion</code>.</p><p>El prompt debe exigir el formato exacto, y la función debe <strong>validar</strong> la respuesta: si el modelo devuelve algo distinto a las cuatro categorías, retornar <code>"sin_clasificar"</code>.</p>', '<p>Al prompt: rol, opciones cerradas y "responde únicamente con la palabra". A la respuesta: <code>.strip().lower()</code> y luego comprobar que esté en la lista de categorías válidas.</p>', '<pre><code>''''''
Programa: Clasificador de PQRs
Autor:    Ana Gomez
Fecha:    2026-03-21
Descripcion:
    Clasifica el texto de una PQR en una de cuatro categorias usando
    un modelo de lenguaje, validando siempre lo que responde.
''''''

CATEGORIAS = ("queja", "peticion", "reclamo", "felicitacion")

PROMPT = ''''''Eres un clasificador de PQRs de una empresa de servicios
publicos en Colombia.
Clasifica el siguiente mensaje en exactamente una categoria:
queja, peticion, reclamo o felicitacion.
Responde UNICAMENTE con la palabra de la categoria, en minusculas,
sin explicaciones ni puntuacion.

Mensaje: ''''''


def clasificar(mensaje):
    ''''''
    Clasifica una PQR.

    Parametros:
        mensaje (str): texto de la PQR

    Retorna:
        str: una de CATEGORIAS, o "sin_clasificar" si no se pudo
    ''''''
    respuesta = preguntar(PROMPT + mensaje, max_tokens=10)

    if respuesta is None:
        return "sin_clasificar"

    # El modelo puede devolver "Queja." o " queja ": se normaliza
    # antes de comparar, igual que en el capitulo 5
    categoria = respuesta.strip().lower().strip(".")

    # Y aunque se le pidio, puede inventar una categoria nueva:
    # nunca se confia sin validar
    if categoria not in CATEGORIAS:
        return "sin_clasificar"

    return categoria


# Inicio
ejemplos = [
    "Llevo tres dias sin agua y nadie contesta el telefono",
    "Solicito copia de la factura de febrero",
    "Excelente atencion del tecnico que vino ayer",
]

for texto in ejemplos:
    print(f"{clasificar(texto):15} | {texto[:40]}")
# Fin</code></pre><p>La función hace dos cosas que el prompt por sí solo no garantiza:</p><ul><li><strong>Normaliza</strong> lo que llegue: <code>"Queja."</code> y <code>" queja "</code> deben contar como la misma categoría.</li><li><strong>Valida contra una lista cerrada.</strong> Si el modelo se inventa <code>"solicitud"</code>, el programa no la propaga a la base de datos: la marca como <code>sin_clasificar</code> y alguien la revisa.</li></ul><p>Pedir el formato en el prompt reduce los errores; validarlo en el código los elimina. Se hacen las dos cosas.</p>', NULL, '''''''
Programa: Clasificador de PQRs
Autor:
Fecha:
Descripcion:
''''''

CATEGORIAS = ("queja", "peticion", "reclamo", "felicitacion")


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'Reporte automático de PQRs', 'dificil', '<p>Escribir el proceso completo que la empresa correría cada lunes: leer <code>pqrs.csv</code> (columnas <code>fecha</code>, <code>cliente</code>, <code>mensaje</code>), pedirle al modelo categoría, urgencia (1 a 5) y un resumen de una frase por cada PQR, y producir:</p><ul><li>el conteo por categoría,</li><li>la lista de los casos urgentes (reclamo con urgencia ≥ 4),</li><li>y el archivo <code>pqrs_clasificadas.csv</code>.</li></ul><p><em>Nota:</em> una PQR que el modelo no logre analizar no puede tumbar el proceso ni desaparecer del reporte. Debe existir un modo de prueba que procese solo las primeras filas.</p>', '<p>Pida el resultado en JSON y conviértalo con <code>json.loads()</code> dentro de <code>try/except</code>. Para el modo de prueba, una constante <code>LIMITE</code> y <code>df.head(LIMITE)</code>.</p>', '<pre><code>''''''
Programa: Reporte semanal de PQRs
Autor:    Ana Gomez
Fecha:    2026-03-21
Descripcion:
    Clasifica las PQRs de la semana con un modelo de lenguaje y
    genera el reporte por categoria y la lista de casos urgentes.
''''''

import json

import pandas as pd

ENTRADA = "pqrs.csv"
SALIDA = "pqrs_clasificadas.csv"
LIMITE = 5          # None para procesar todo. Cada llamada cuesta

VACIO = {"categoria": "sin_clasificar", "urgencia": 0, "resumen": ""}

PROMPT = ''''''Analiza la siguiente PQR de una empresa de servicios publicos.
Responde SOLO con un JSON valido, sin texto antes ni despues,
con esta forma exacta:
{"categoria": "queja|peticion|reclamo|felicitacion",
 "urgencia": 1,
 "resumen": "una frase"}
La urgencia va de 1 (puede esperar) a 5 (atender hoy).

PQR: ''''''


def analizar(mensaje):
    ''''''
    Pide al modelo el analisis de una PQR.

    Parametros:
        mensaje (str): texto de la PQR

    Retorna:
        dict: categoria, urgencia y resumen. Nunca None: si algo
              falla devuelve el registro VACIO
    ''''''
    texto = preguntar(PROMPT + mensaje, max_tokens=300)

    if texto is None:
        return dict(VACIO)

    # El modelo es texto libre: puede colar una frase de cortesia
    # y romper el json.loads(). Se envuelve siempre
    try:
        datos = json.loads(texto)
    except json.JSONDecodeError:
        return dict(VACIO)

    # Y puede omitir una clave: se leen con .get() y valor por defecto
    return {
        "categoria": str(datos.get("categoria", "sin_clasificar")).lower(),
        "urgencia": int(datos.get("urgencia", 0)),
        "resumen": str(datos.get("resumen", "")),
    }


# Inicio
pqrs = pd.read_csv(ENTRADA)

if LIMITE:
    print(f"MODO PRUEBA: solo las primeras {LIMITE} filas")
    pqrs = pqrs.head(LIMITE).copy()

# Un ciclo sobre el DataFrame: aqui si va, porque cada fila es una
# llamada por internet y de eso no hay version vectorizada
analisis = [analizar(m) for m in pqrs["mensaje"]]

pqrs["categoria"] = [a["categoria"] for a in analisis]
pqrs["urgencia"] = [a["urgencia"] for a in analisis]
pqrs["resumen"] = [a["resumen"] for a in analisis]

print("\nPQRs por categoria:")
print(pqrs.groupby("categoria").size())

urgentes = pqrs[(pqrs["categoria"] == "reclamo") &amp; (pqrs["urgencia"] &gt;= 4)]
print(f"\nCasos urgentes: {len(urgentes)}")
for _, fila in urgentes.iterrows():
    print(f"  [{fila[''urgencia'']}] {fila[''cliente'']}: {fila[''resumen'']}")

sin_clasificar = (pqrs["categoria"] == "sin_clasificar").sum()
if sin_clasificar:
    print(f"\n{sin_clasificar} PQR(s) quedaron sin clasificar y hay que revisarlas")

pqrs.to_csv(SALIDA, index=False)
print(f"\nReporte guardado en {SALIDA}")
# Fin</code></pre><p>Este ejercicio junta todo el libro, y las decisiones que importan no son las de la IA:</p><ul><li><strong><code>analizar()</code> nunca devuelve <code>None</code>.</strong> Devuelve el registro <code>VACIO</code>. Quien la llama no tiene que preguntarse nada: siempre recibe un diccionario con las tres claves, y la fila conserva su lugar en el DataFrame.</li><li><strong><code>dict(VACIO)</code> y no <code>VACIO</code> a secas.</strong> Devolver el mismo diccionario a todas las filas las dejaría compartiendo un solo objeto, y modificar una modificaría todas. Es la trampa de las listas del capítulo 10.</li><li><strong><code>.get()</code> con valor por defecto</strong> para cada clave: el modelo puede olvidar una y no vale la pena tumbar el proceso por eso.</li><li><strong>El modo prueba primero.</strong> 400 filas son 400 cobros. Se corre con <code>LIMITE = 5</code>, se revisa que las categorías tengan sentido, y solo entonces se pone en <code>None</code>.</li><li><strong>Lo que no se pudo clasificar se reporta.</strong> Un proceso que esconde sus fallas es peor que uno que se cae: nadie se entera de que el reporte está incompleto.</li></ul>', NULL, '''''''
Programa: Reporte semanal de PQRs
Autor:
Fecha:
Descripcion:
''''''

import json

import pandas as pd

ENTRADA = "pqrs.csv"
SALIDA = "pqrs_clasificadas.csv"
LIMITE = 5          # None para procesar todo


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 23 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Dónde corre el modelo de IA cuando lo usas desde Python?', NULL, '{"options":[{"id":"a","text":"En un servidor de la empresa que lo entrenó; tu programa le habla por una API"},{"id":"b","text":"En tu computador, después de instalarlo con pip"},{"id":"c","text":"Dentro del intérprete de Python"},{"id":"d","text":"En la memoria RAM, mientras dure el programa"}]}', '{"option_id":"a"}', 'Tú pones el prompt, la llave y el código que usa la respuesta. Ellos ponen el modelo y los computadores.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Dónde debe guardarse la API key?', NULL, '{"options":[{"id":"a","text":"En un archivo .env que está en el .gitignore, leído con os.environ"},{"id":"b","text":"En una constante al inicio del programa"},{"id":"c","text":"En un comentario, para no confundirla con el código"},{"id":"d","text":"En la URL de la petición"}]}', '{"option_id":"a"}', 'Una llave subida a GitHub la encuentran bots en horas y el consumo se cobra a tu cuenta.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Por qué el prompt debe exigir el formato exacto de la respuesta?', NULL, '{"options":[{"id":"a","text":"Porque tu código va a leer esa respuesta y una frase de cortesía la rompe"},{"id":"b","text":"Porque el modelo responde más rápido"},{"id":"c","text":"Porque así cuesta menos"},{"id":"d","text":"Porque si no, la API devuelve error 400"}]}', '{"option_id":"a"}', 'Si el modelo contesta "¡Claro! Esto parece una queja porque…", el if categoria == "queja" nunca se cumple.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Para qué sirve timeout=30 en requests.post?', NULL, '{"options":[{"id":"a","text":"Para que el programa no quede colgado esperando para siempre"},{"id":"b","text":"Para limitar el largo de la respuesta"},{"id":"c","text":"Para reintentar la llamada 30 veces"},{"id":"d","text":"Para que el modelo piense 30 segundos"}]}', '{"option_id":"a"}', 'El tope de largo (y de costo) es max_tokens. El timeout es cuánto se espera la respuesta antes de rendirse.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Para cuál de estas tareas NO sirve un modelo de lenguaje?', NULL, '{"options":[{"id":"a","text":"Consultar el saldo real de una cuenta bancaria"},{"id":"b","text":"Clasificar mensajes en categorías"},{"id":"c","text":"Resumir un texto largo en una frase"},{"id":"d","text":"Extraer la ciudad y la fecha de un texto libre"}]}', '{"option_id":"a"}', 'El modelo inventa con total seguridad. Los datos salen de la base de datos; el modelo pone el criterio, no los hechos.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', 'La variable de entorno API_KEY no está definida. ¿Qué imprime?', 'import os

llave = os.environ.get("API_KEY")
if not llave:
    print("Falta API_KEY")
else:
    print(f"{llave[:6]}...{llave[-4:]}")', '{"options":[{"id":"a","text":"Falta API_KEY"},{"id":"b","text":"None"},{"id":"c","text":"Lanza KeyError"},{"id":"d","text":"...  (sin nada alrededor)"}]}', '{"option_id":"a"}', '.get() devuelve None si no existe, y None es falso. Con os.environ["API_KEY"] sí habría KeyError.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'El modelo respondió el texto ''  Queja. ''. ¿Qué imprime?', 'CATEGORIAS = ("queja", "peticion", "reclamo", "felicitacion")
respuesta = "  Queja. "

categoria = respuesta.strip().lower().strip(".")
print(categoria if categoria in CATEGORIAS else "sin_clasificar")', '{"options":[{"id":"a","text":"queja"},{"id":"b","text":"sin_clasificar"},{"id":"c","text":"Queja."},{"id":"d","text":"  queja. "}]}', '{"option_id":"a"}', 'strip() quita los espacios, lower() unifica mayúsculas y el segundo strip(".") quita el punto final.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'El modelo devolvió ''Claro, aqui tienes: {"a": 1}''. ¿Qué imprime?', 'import json

texto = ''Claro, aqui tienes: {"a": 1}''

try:
    datos = json.loads(texto)
except json.JSONDecodeError:
    datos = None

print(datos)', '{"options":[{"id":"a","text":"None"},{"id":"b","text":"{''a'': 1}"},{"id":"c","text":"Claro, aqui tienes: {\"a\": 1}"},{"id":"d","text":"Lanza JSONDecodeError"}]}', '{"option_id":"a"}', 'El texto de cortesía adelante invalida el JSON completo. Por eso todo json.loads() de una respuesta del modelo va dentro de try/except.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Este programa expone un secreto. ¿En qué línea está el problema?', NULL, '{"lines":["import requests","API_KEY = \"sk-ant-api03-abc123xyz\"","r = requests.post(URL, headers={\"x-api-key\": API_KEY}, json=cuerpo, timeout=30)","print(r.json())"]}', '{"line_number":2}', 'La llave está escrita en el código y viaja al repositorio. Va en el .env y se lee con os.environ.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'Cuando la API responde 401, el programa falla con un error confuso. ¿En qué línea está el problema?', NULL, '{"lines":["r = requests.post(URL, headers=CABECERAS, json=cuerpo, timeout=30)","texto = r.json()[\"content\"][0][\"text\"]","print(texto)"]}', '{"line_number":2}', 'Se lee la respuesta sin revisar r.status_code: con un error la respuesta no tiene ''content'' y salta un KeyError que no explica nada.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'Todas las filas terminan con el mismo análisis. ¿En qué línea está el problema?', NULL, '{"lines":["VACIO = {\"categoria\": \"sin_clasificar\", \"urgencia\": 0}","def analizar(mensaje):","    texto = preguntar(PROMPT + mensaje)","    if texto is None:","        return VACIO"]}', '{"line_number":5}', 'Devuelve siempre el mismo objeto: todas las filas comparten un diccionario y modificar una las modifica todas. Va return dict(VACIO).', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la función que consulta el modelo y devuelve JSON validado', NULL, '{"lines":[{"id":"l1","text":"def analizar(mensaje):","indent":0},{"id":"l2","text":"r = requests.post(URL, headers=CABECERAS, timeout=30, json=cuerpo(mensaje))","indent":1},{"id":"l3","text":"if r.status_code != 200:","indent":1},{"id":"l4","text":"return None","indent":2},{"id":"l5","text":"texto = r.json()[\"content\"][0][\"text\"]","indent":1},{"id":"l6","text":"try:","indent":1},{"id":"l7","text":"return json.loads(texto)","indent":2},{"id":"l8","text":"except json.JSONDecodeError:","indent":1},{"id":"l9","text":"return None","indent":2}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7","l8","l9"]}', 'Primero se revisa el status_code y se sale; solo entonces se lee el texto, y su conversión a JSON va envuelta en try/except.', 1, 'seed'
    FROM chapters WHERE number = 23 AND track = 'basico';

-- ── Capítulo 24: APIs con FastAPI y despliegue (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 24, 'APIs con FastAPI y despliegue', '🚀', 'Publicar tu propio backend en internet.', '<p class="jc-gancho">Todo lo que has escrito hasta aquí corre en tu computador y lo usas tú. En este capítulo eso cambia: el sistema bancario del capítulo 20 va a quedar en internet, con una dirección que cualquiera puede abrir, y una app de celular podría consumirlo. Ese salto es lo que separa un ejercicio de un producto.</p>

<h2>De script a servicio</h2>

<p>Un script arranca, hace algo y termina. Una <strong>API</strong> queda encendida esperando peticiones, y responde a cada una.</p>

<table>
  <thead>
    <tr><th>Verbo</th><th>Significa</th><th>Ejemplo</th></tr>
  </thead>
  <tbody>
    <tr><td><code>GET</code></td><td>Dame información</td><td>Consultar un saldo</td></tr>
    <tr><td><code>POST</code></td><td>Crea algo</td><td>Abrir una cuenta</td></tr>
    <tr><td><code>PUT</code></td><td>Modifica algo</td><td>Cambiar el titular</td></tr>
    <tr><td><code>DELETE</code></td><td>Bórralo</td><td>Cerrar la cuenta</td></tr>
  </tbody>
</table>

<p>Y la respuesta trae un <strong>código de estado</strong> que dice cómo salió:</p>

<table>
  <thead>
    <tr><th>Código</th><th>Quiere decir</th></tr>
  </thead>
  <tbody>
    <tr><td><code>200</code> · <code>201</code></td><td>Salió bien · se creó algo</td></tr>
    <tr><td><code>400</code> · <code>422</code></td><td>El cliente mandó algo mal</td></tr>
    <tr><td><code>401</code> · <code>403</code></td><td>No se identificó · no tiene permiso</td></tr>
    <tr><td><code>404</code></td><td>Eso no existe</td></tr>
    <tr><td><code>500</code></td><td>Se rompió el servidor: la culpa es tuya</td></tr>
  </tbody>
</table>

<h2>Tu primera API</h2>

<pre><code>pip install fastapi uvicorn</code></pre>

<pre><code># main.py
from fastapi import FastAPI

app = FastAPI(title="Banco JuanCode")


@app.get("/")
def inicio():
    return {"mensaje": "API del banco funcionando"}</code></pre>

<pre><code>uvicorn main:app --reload</code></pre>

<p><code>main:app</code> significa "en el archivo <code>main.py</code>, la variable <code>app</code>". Con <code>--reload</code> el servidor se reinicia solo cada vez que guardas.</p>

<p>Abre <code>http://127.0.0.1:8000</code> y ahí está el JSON. Ahora abre <code>http://127.0.0.1:8000/docs</code>: FastAPI generó una <strong>documentación interactiva</strong> donde puedes probar cada ruta sin escribir una línea de código extra. No hay que configurar nada para tenerla.</p>

<p>Fíjate en que la función devuelve un diccionario de Python y llega como JSON. FastAPI lo convierte solo.</p>

<h2>Parámetros: en la ruta y en la consulta</h2>

<pre><code>@app.get("/cuentas/{numero}")
def ver_cuenta(numero: str):
    return {"numero": numero}


@app.get("/cuentas")
def listar(tipo: str = "todos", limite: int = 10):
    return {"tipo": tipo, "limite": limite}</code></pre>

<ul>
  <li><code>/cuentas/001</code> → el valor va <strong>en la ruta</strong>, para identificar un recurso.</li>
  <li><code>/cuentas?tipo=ahorros&amp;limite=5</code> → va <strong>en la consulta</strong>, para filtrar u ordenar.</li>
</ul>

<p>Esas anotaciones de tipo (<code>numero: str</code>, <code>limite: int</code>) no son decoración: FastAPI <strong>convierte y valida</strong> con ellas. Si alguien pide <code>?limite=hola</code>, la respuesta es un 422 con el detalle del error, y tu función nunca llega a ejecutarse.</p>

<h2>Recibir datos: los modelos de Pydantic</h2>

<p>Para un <code>POST</code> hay que describir qué se espera recibir:</p>

<pre><code>from pydantic import BaseModel, Field


class CuentaNueva(BaseModel):
    numero: str = Field(min_length=3, max_length=10)
    titular: str = Field(min_length=3)
    tipo: str = "ahorros"
    saldo: int = Field(default=0, ge=0)          # ge = mayor o igual


@app.post("/cuentas", status_code=201)
def crear_cuenta(cuenta: CuentaNueva):
    return {"creada": cuenta.numero, "saldo": cuenta.saldo}</code></pre>

<p>Esa clase reemplaza todas las validaciones a mano que escribíamos en el capítulo 15. Si llega un saldo negativo, o falta el titular, o el número viene como número en vez de texto, FastAPI responde 422 con el campo exacto que está mal, <strong>antes</strong> de entrar a tu función.</p>

<p>Es la misma idea del <code>NOT NULL</code> del capítulo 21, pero en la puerta de entrada del programa: la regla se declara una vez y se aplica sola.</p>

<h2>La API del banco</h2>

<p>Ahora sí, con la base de datos del capítulo 21 detrás:</p>

<pre><code>import sqlite3

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

app = FastAPI(title="Banco JuanCode")
BASE = "banco.db"


class Movimiento(BaseModel):
    monto: int = Field(gt=0)          # gt = mayor que: no hay retiros de 0


def conectar():
    ''''''
    Abre una conexión a la base con filas accesibles por nombre.
    ''''''
    conexion = sqlite3.connect(BASE)
    conexion.row_factory = sqlite3.Row
    return conexion


@app.get("/cuentas/{numero}")
def ver_cuenta(numero: str):
    conexion = conectar()
    try:
        fila = conexion.execute(
            "SELECT numero, titular, tipo, saldo FROM cuentas WHERE numero = ?",
            (numero,),
        ).fetchone()
    finally:
        conexion.close()          # se cierra pase lo que pase

    if fila is None:
        raise HTTPException(status_code=404, detail="La cuenta no existe")

    return dict(fila)


@app.post("/cuentas/{numero}/retiros", status_code=201)
def retirar(numero: str, movimiento: Movimiento):
    conexion = conectar()
    try:
        fila = conexion.execute(
            "SELECT saldo FROM cuentas WHERE numero = ?", (numero,)
        ).fetchone()

        if fila is None:
            raise HTTPException(status_code=404, detail="La cuenta no existe")

        if fila["saldo"] &lt; movimiento.monto:
            raise HTTPException(status_code=400, detail="Saldo insuficiente")

        conexion.execute(
            "UPDATE cuentas SET saldo = saldo - ? WHERE numero = ?",
            (movimiento.monto, numero),
        )
        conexion.commit()
        nuevo = fila["saldo"] - movimiento.monto
    finally:
        conexion.close()

    return {"numero": numero, "retirado": movimiento.monto, "saldo": nuevo}</code></pre>

<p>Dos cosas que hay que ver aquí:</p>

<ul>
  <li><strong><code>raise HTTPException</code>, no <code>return</code>.</strong> Devolver <code>{"error": "no existe"}</code> con código 200 es mentir: el cliente cree que salió bien. El código de estado <em>es</em> parte de la respuesta.</li>
  <li><strong>La conexión se cierra en un <code>finally</code>.</strong> Un servidor no termina nunca; una conexión que se queda abierta en cada petición tumba el proceso a las pocas horas.</li>
</ul>

<h2>Antes de publicar</h2>

<h3>Las dependencias, por escrito</h3>

<pre><code>pip freeze &gt; requirements.txt</code></pre>

<p>El servidor no tiene tu entorno virtual. Ese archivo es la lista con la que se reconstruye, tal como se vio en el capítulo 16.</p>

<h3>La configuración, en el entorno</h3>

<pre><code>import os

BASE = os.environ.get("DATABASE_PATH", "banco.db")
PUERTO = int(os.environ.get("PORT", 8000))</code></pre>

<p>Nada de rutas ni llaves escritas en el código: lo que cambia entre tu computador y el servidor viaja por variables de entorno. Y el puerto <strong>lo asigna el servicio</strong>, por eso se lee de <code>PORT</code> en vez de fijarlo.</p>

<h3>Levantar en producción</h3>

<pre><code>uvicorn main:app --host 0.0.0.0 --port $PORT</code></pre>

<p><code>--host 0.0.0.0</code> significa "acepta conexiones de afuera". El <code>127.0.0.1</code> de desarrollo solo escucha a tu propia máquina, y en un servidor eso equivale a no estar publicado. Y <strong>sin <code>--reload</code></strong>: eso es una herramienta de desarrollo.</p>

<h3>Permitir que un navegador la consuma</h3>

<pre><code>from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://mi-frontend.com"],   # no "*" en producción
    allow_methods=["*"],
    allow_headers=["*"],
)</code></pre>

<p>Sin esto, una página web en otro dominio no puede llamar a tu API: el navegador lo bloquea. El error clásico de "funciona con curl pero no desde la web" es casi siempre CORS.</p>

<h3>Publicarla</h3>

<p>Servicios como Render, Railway o Fly.io despliegan desde un repositorio de GitHub: conectas el repo, ellos leen el <code>requirements.txt</code>, corren el comando de arranque y te dan una dirección pública. La lista de pasos es siempre la misma:</p>

<ol>
  <li>El código en GitHub, con <code>.env</code> en el <code>.gitignore</code>.</li>
  <li><code>requirements.txt</code> actualizado.</li>
  <li>Comando de arranque: <code>uvicorn main:app --host 0.0.0.0 --port $PORT</code>.</li>
  <li>Las variables de entorno cargadas en el panel del servicio.</li>
  <li>Probar la dirección pública y su <code>/docs</code>.</li>
</ol>

<h2>⚠️ Errores que todos cometen</h2>

<h3>1. Devolver el error con código 200</h3>
<pre><code>return {"error": "no existe"}                          # ❌ el cliente cree que salió bien
raise HTTPException(status_code=404, detail="...")     # ✅</code></pre>

<h3>2. Dejar el puerto y el host de desarrollo</h3>
<pre><code>uvicorn main:app --reload                              # ❌ en producción
uvicorn main:app --host 0.0.0.0 --port $PORT           # ✅</code></pre>

<h3>3. Subir el <code>.env</code> o la base de datos al repositorio</h3>
<pre><code># .gitignore
.env
*.db
__pycache__/
venv/</code></pre>
<p>Una llave publicada hay que rotarla, no borrarla: en el historial de git sigue ahí.</p>

<h2>🎯 El patrón</h2>

<ol>
  <li>Una función por ruta, con el verbo que corresponde a lo que hace.</li>
  <li>Los tipos y los modelos de Pydantic validan la entrada; no se valida a mano.</li>
  <li>Los errores se lanzan con <code>HTTPException</code> y su código real.</li>
  <li>Los recursos (conexiones, archivos) se cierran en <code>finally</code>.</li>
  <li>Lo que cambia entre máquinas va en variables de entorno.</li>
  <li>Probar en <code>/docs</code> antes de publicar, y volver a probarlo en la dirección pública.</li>
</ol>

<h2>📋 Chuleta</h2>

<table>
  <thead>
    <tr><th>Escribes</th><th>Pasa esto</th></tr>
  </thead>
  <tbody>
    <tr><td><code>app = FastAPI()</code></td><td>Crea la aplicación</td></tr>
    <tr><td><code>@app.get("/ruta")</code></td><td>Responde a un GET en esa ruta</td></tr>
    <tr><td><code>@app.post("/ruta", status_code=201)</code></td><td>Crea algo y responde 201</td></tr>
    <tr><td><code>{numero}</code> en la ruta</td><td>Parámetro que identifica un recurso</td></tr>
    <tr><td><code>limite: int = 10</code></td><td>Parámetro de consulta con valor por defecto</td></tr>
    <tr><td><code>class X(BaseModel)</code></td><td>Describe y valida el cuerpo de la petición</td></tr>
    <tr><td><code>raise HTTPException(404, "…")</code></td><td>Responde con un error de verdad</td></tr>
    <tr><td><code>uvicorn main:app --reload</code></td><td>Levanta el servidor en desarrollo</td></tr>
    <tr><td><code>/docs</code></td><td>Documentación interactiva, gratis</td></tr>
  </tbody>
</table>

<blockquote>Hace veinticuatro capítulos, un <code>print</code> era todo lo que sabías hacer. Ahora tienes un servicio con base de datos, validaciones y una dirección pública. Lo que sigue no es otro capítulo: es tu propio proyecto.</blockquote>', 1, 'basico'
    FROM parts p WHERE p.number = 6
  ON CONFLICT(track, number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 24 AND track = 'basico'
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 24 AND track = 'basico');
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Hola API', 'facil', '<p>Crear una API con FastAPI que tenga dos rutas:</p><ul><li><code>GET /</code> → <code>{"mensaje": "API del banco funcionando"}</code></li><li><code>GET /saludo/{nombre}</code> → <code>{"saludo": "Hola, Ana"}</code></li></ul><p>Levantarla con uvicorn y probarla en <code>/docs</code>.</p>', '<p><code>app = FastAPI()</code>, y cada ruta es una función con el decorador <code>@app.get("...")</code>. La función devuelve un diccionario y FastAPI lo convierte a JSON.</p>', '<pre><code>''''''
Programa: API del banco - primeras rutas
Autor:    Ana Gomez
Fecha:    2026-03-28
Descripcion:
    API minima con FastAPI para verificar que el servicio responde.

Uso:
    uvicorn main:app --reload
    Documentacion interactiva en http://127.0.0.1:8000/docs
''''''

from fastapi import FastAPI

# Inicio
app = FastAPI(title="Banco JuanCode")


@app.get("/")
def inicio():
    ''''''
    Ruta de verificacion: confirma que el servicio esta arriba.

    Retorna:
        dict: mensaje de estado
    ''''''
    return {"mensaje": "API del banco funcionando"}


@app.get("/saludo/{nombre}")
def saludar(nombre: str):
    ''''''
    Saluda a quien se identifique en la ruta.

    Parametros:
        nombre (str): viene de la URL, por ejemplo /saludo/Ana

    Retorna:
        dict: el saludo armado
    ''''''
    return {"saludo": f"Hola, {nombre.title()}"}
# Fin</code></pre><p>Tres detalles que ya son distintos a todo lo anterior:</p><ul><li><strong>No hay <code>print</code>.</strong> La función <code>return</code>-a un diccionario y FastAPI lo convierte a JSON y lo manda por la red.</li><li><strong>Nadie llama a las funciones.</strong> Las llama el servidor cuando entra una petición a esa ruta.</li><li><strong><code>nombre: str</code></strong> no es un comentario: es lo que FastAPI usa para convertir y validar el valor de la URL.</li></ul><p>Y sin escribir nada más, <code>/docs</code> ya tiene la documentación de las dos rutas y un botón para probarlas.</p>', NULL, '''''''
Programa: API del banco - primeras rutas
Autor:
Fecha:
Descripcion:

Uso:
    uvicorn main:app --reload
''''''

from fastapi import FastAPI

# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Consultar una cuenta', 'facil', '<p>Agregar la ruta <code>GET /cuentas/{numero}</code> que devuelva los datos de la cuenta desde un diccionario en memoria.</p><p>Si el número no existe, la respuesta debe ser un <strong>404 real</strong>, no un 200 con un mensaje de error.</p><p>Agregar también <code>GET /cuentas</code> que liste todas, con un parámetro opcional <code>tipo</code> para filtrar.</p>', '<p><code>raise HTTPException(status_code=404, detail="...")</code>. El filtro opcional es un parámetro con valor por defecto: <code>tipo: str = "todos"</code>.</p>', '<pre><code>''''''
Programa: API del banco - consulta de cuentas
Autor:    Ana Gomez
Fecha:    2026-03-28
Descripcion:
    Expone la consulta de una cuenta y el listado filtrado por tipo.
''''''

from fastapi import FastAPI, HTTPException

app = FastAPI(title="Banco JuanCode")

CUENTAS = {
    "001": {"numero": "001", "titular": "Ana", "tipo": "ahorros", "saldo": 200000},
    "002": {"numero": "002", "titular": "Juan", "tipo": "corriente", "saldo": 850000},
    "003": {"numero": "003", "titular": "Sofia", "tipo": "ahorros", "saldo": 45000},
}


# Inicio
@app.get("/cuentas")
def listar_cuentas(tipo: str = "todos"):
    ''''''
    Lista las cuentas, opcionalmente filtradas por tipo.

    Parametros:
        tipo (str): "ahorros", "corriente" o "todos"

    Retorna:
        dict: total y lista de cuentas
    ''''''
    if tipo == "todos":
        cuentas = list(CUENTAS.values())
    else:
        cuentas = [c for c in CUENTAS.values() if c["tipo"] == tipo]

    return {"total": len(cuentas), "cuentas": cuentas}


@app.get("/cuentas/{numero}")
def ver_cuenta(numero: str):
    ''''''
    Devuelve una cuenta por su numero.

    Parametros:
        numero (str): identificador de la cuenta

    Retorna:
        dict: los datos de la cuenta

    Lanza:
        HTTPException 404: si la cuenta no existe
    ''''''
    if numero not in CUENTAS:
        # No se devuelve {"error": ...} con codigo 200: el codigo
        # de estado ES parte de la respuesta
        raise HTTPException(status_code=404, detail="La cuenta no existe")

    return CUENTAS[numero]
# Fin</code></pre><p>La diferencia entre <code>return {"error": "no existe"}</code> y <code>raise HTTPException(404)</code> parece cosmética y no lo es. Quien consume la API —una app de celular, otro programa, un tablero— revisa el código de estado antes que el contenido. Un 200 le dice "salió bien", así el cuerpo diga lo contrario, y termina guardando el mensaje de error como si fuera una cuenta.</p><p>El orden de las dos rutas tampoco es casual: <code>/cuentas</code> y <code>/cuentas/{numero}</code> son direcciones distintas, y conviene declarar la fija antes que la variable para que quede claro cuál atiende qué.</p>', NULL, '''''''
Programa: API del banco - consulta de cuentas
Autor:
Fecha:
Descripcion:
''''''

from fastapi import FastAPI, HTTPException

app = FastAPI(title="Banco JuanCode")

CUENTAS = {
    "001": {"numero": "001", "titular": "Ana", "tipo": "ahorros", "saldo": 200000},
    "002": {"numero": "002", "titular": "Juan", "tipo": "corriente", "saldo": 850000},
}


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Abrir cuenta y retirar', 'medio', '<p>Agregar dos rutas que <em>modifican</em> datos:</p><ul><li><code>POST /cuentas</code> → crea una cuenta. Responde <strong>201</strong>. Si el número ya existe, <strong>409</strong>.</li><li><code>POST /cuentas/{numero}/retiros</code> → retira un monto. <strong>404</strong> si la cuenta no existe y <strong>400</strong> si el saldo no alcanza.</li></ul><p><em>Nota:</em> la validación de los datos que llegan (saldo no negativo, monto mayor que cero, titular no vacío) no se escribe a mano: se declara con Pydantic.</p>', '<p>Una clase que herede de <code>BaseModel</code> por cada cuerpo que reciba. <code>Field(ge=0)</code> es "mayor o igual a 0" y <code>Field(gt=0)</code> es "mayor que 0".</p>', '<pre><code>''''''
Programa: API del banco - operaciones
Autor:    Ana Gomez
Fecha:    2026-03-28
Descripcion:
    Rutas que crean cuentas y registran retiros, con validacion
    declarada en modelos de Pydantic.
''''''

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

app = FastAPI(title="Banco JuanCode")

CUENTAS = {}


class CuentaNueva(BaseModel):
    ''''''Datos necesarios para abrir una cuenta.''''''
    numero: str = Field(min_length=3, max_length=10)
    titular: str = Field(min_length=3)
    tipo: str = "ahorros"
    saldo: int = Field(default=0, ge=0)        # ge: mayor o igual que 0


class Movimiento(BaseModel):
    ''''''Monto de un retiro o consignacion.''''''
    monto: int = Field(gt=0)                   # gt: mayor que 0


# Inicio
@app.post("/cuentas", status_code=201)
def crear_cuenta(cuenta: CuentaNueva):
    ''''''
    Abre una cuenta nueva.

    Parametros:
        cuenta (CuentaNueva): datos ya validados por Pydantic

    Retorna:
        dict: la cuenta creada

    Lanza:
        HTTPException 409: si el numero ya esta ocupado
    ''''''
    if cuenta.numero in CUENTAS:
        raise HTTPException(status_code=409, detail="Ese numero ya existe")

    CUENTAS[cuenta.numero] = cuenta.model_dump()

    return CUENTAS[cuenta.numero]


@app.post("/cuentas/{numero}/retiros", status_code=201)
def retirar(numero: str, movimiento: Movimiento):
    ''''''
    Retira un monto de una cuenta.

    Parametros:
        numero (str): cuenta de la que se retira
        movimiento (Movimiento): monto solicitado

    Retorna:
        dict: lo retirado y el saldo que queda

    Lanza:
        HTTPException 404: la cuenta no existe
        HTTPException 400: el saldo no alcanza
    ''''''
    cuenta = CUENTAS.get(numero)

    if cuenta is None:
        raise HTTPException(status_code=404, detail="La cuenta no existe")

    if cuenta["saldo"] &lt; movimiento.monto:
        raise HTTPException(status_code=400, detail="Saldo insuficiente")

    cuenta["saldo"] -= movimiento.monto

    return {
        "numero": numero,
        "retirado": movimiento.monto,
        "saldo": cuenta["saldo"],
    }
# Fin</code></pre><p>Compare esta versión con el sistema bancario del capítulo 20: allá cada operación empezaba con veinte líneas de <code>if</code> comprobando que el monto fuera un número, que fuera positivo, que el titular no estuviera vacío. Aquí eso son dos clases, y las reglas se aplican <strong>antes</strong> de que la función arranque. Un monto de <code>-5000</code> nunca llega al cuerpo de <code>retirar()</code>: FastAPI ya respondió 422 con el campo exacto que está mal.</p><p>Los códigos también dicen cosas distintas y por eso se usan distintos:</p><ul><li><strong>409</strong> (conflicto): los datos son válidos, pero chocan con lo que ya existe.</li><li><strong>400</strong>: la petición es válida, pero la operación no se puede hacer con el estado actual.</li><li><strong>404</strong>: lo que se pide no existe.</li></ul><p>Quien consume la API puede reaccionar distinto a cada uno sin leer el mensaje.</p>', NULL, '''''''
Programa: API del banco - operaciones
Autor:
Fecha:
Descripcion:
''''''

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

app = FastAPI(title="Banco JuanCode")

CUENTAS = {}


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 4, 'La API lista para publicar', 'dificil', '<p>Escribir la versión final de la API del banco, la que sí se puede subir a un servidor:</p><ol><li>los datos en SQLite (capítulo 21), no en memoria;</li><li>la ruta de la base y el puerto leídos de variables de entorno;</li><li>una transferencia entre dos cuentas que quede completa o no quede (transacción);</li><li>CORS habilitado para el dominio del frontend;</li><li>y un <code>GET /salud</code> que el servicio de despliegue pueda consultar para saber si la API está viva.</li></ol><p>Incluir en el comentario de encabezado los pasos para desplegarla.</p>', '<p><code>os.environ.get("DATABASE_PATH", "banco.db")</code> para la ruta. La transferencia va con <code>try/except</code>, dos <code>UPDATE</code>, un solo <code>commit()</code> y <code>rollback()</code> si algo falla.</p>', '<pre><code>''''''
Programa: API del banco - version desplegable
Autor:    Ana Gomez
Fecha:    2026-03-28
Descripcion:
    API del sistema bancario sobre SQLite, configurada por variables
    de entorno y lista para publicarse en un servidor.

Despliegue:
    1. pip freeze > requirements.txt
    2. Subir el repo a GitHub con .env y *.db en el .gitignore
    3. Variables de entorno en el panel del servicio:
       DATABASE_PATH y ORIGEN_PERMITIDO
    4. Comando de arranque:
       uvicorn main:app --host 0.0.0.0 --port $PORT
    5. Verificar la direccion publica y su /docs
''''''

import os
import sqlite3

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

# Todo lo que cambia entre el portatil y el servidor, en el entorno
BASE = os.environ.get("DATABASE_PATH", "banco.db")
ORIGEN = os.environ.get("ORIGEN_PERMITIDO", "http://localhost:5173")

app = FastAPI(title="Banco JuanCode", version="1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[ORIGEN],        # nunca "*" en produccion
    allow_methods=["*"],
    allow_headers=["*"],
)


class Transferencia(BaseModel):
    ''''''Datos de una transferencia entre dos cuentas.''''''
    destino: str = Field(min_length=3)
    monto: int = Field(gt=0)


def conectar():
    ''''''
    Abre una conexion a la base con filas accesibles por nombre.

    Retorna:
        Connection: conexion lista para usar
    ''''''
    conexion = sqlite3.connect(BASE)
    conexion.row_factory = sqlite3.Row
    return conexion


def buscar_saldo(conexion, numero):
    ''''''
    Devuelve el saldo de una cuenta.

    Parametros:
        conexion (Connection): conexion abierta
        numero (str): cuenta consultada

    Retorna:
        int: el saldo

    Lanza:
        HTTPException 404: si la cuenta no existe
    ''''''
    fila = conexion.execute(
        "SELECT saldo FROM cuentas WHERE numero = ?", (numero,)
    ).fetchone()

    if fila is None:
        raise HTTPException(status_code=404, detail=f"La cuenta {numero} no existe")

    return fila["saldo"]


# Inicio
@app.get("/salud")
def salud():
    ''''''
    Ruta que consulta el servicio de despliegue para saber si la API
    responde y si la base esta accesible.

    Retorna:
        dict: estado del servicio
    ''''''
    try:
        conexion = conectar()
        conexion.execute("SELECT 1").fetchone()
        conexion.close()
    except sqlite3.Error:
        raise HTTPException(status_code=500, detail="Base de datos no disponible")

    return {"estado": "ok"}


@app.get("/cuentas/{numero}")
def ver_cuenta(numero: str):
    ''''''
    Devuelve los datos de una cuenta.

    Parametros:
        numero (str): identificador de la cuenta

    Retorna:
        dict: numero, titular, tipo y saldo
    ''''''
    conexion = conectar()
    try:
        fila = conexion.execute(
            "SELECT numero, titular, tipo, saldo FROM cuentas WHERE numero = ?",
            (numero,),                    # siempre con ?, nunca con f-string
        ).fetchone()
    finally:
        conexion.close()                  # el servidor no termina nunca:
                                          # una conexion perdida por peticion
                                          # lo tumba en unas horas

    if fila is None:
        raise HTTPException(status_code=404, detail="La cuenta no existe")

    return dict(fila)


@app.post("/cuentas/{numero}/transferencias", status_code=201)
def transferir(numero: str, datos: Transferencia):
    ''''''
    Transfiere un monto de una cuenta a otra.

    Parametros:
        numero (str): cuenta origen
        datos (Transferencia): destino y monto

    Retorna:
        dict: resultado de la operacion y saldo del origen

    Lanza:
        HTTPException 400: mismo origen y destino, o saldo insuficiente
        HTTPException 404: alguna de las dos cuentas no existe
    ''''''
    if numero == datos.destino:
        raise HTTPException(status_code=400, detail="Origen y destino son la misma cuenta")

    conexion = conectar()
    try:
        saldo_origen = buscar_saldo(conexion, numero)
        buscar_saldo(conexion, datos.destino)      # valida que exista

        if saldo_origen &lt; datos.monto:
            raise HTTPException(status_code=400, detail="Saldo insuficiente")

        try:
            conexion.execute(
                "UPDATE cuentas SET saldo = saldo - ? WHERE numero = ?",
                (datos.monto, numero),
            )
            conexion.execute(
                "UPDATE cuentas SET saldo = saldo + ? WHERE numero = ?",
                (datos.monto, datos.destino),
            )
            conexion.commit()              # las dos operaciones, juntas
        except sqlite3.Error:
            conexion.rollback()            # o ninguna
            raise HTTPException(status_code=500, detail="No se pudo completar la transferencia")
    finally:
        conexion.close()

    return {
        "origen": numero,
        "destino": datos.destino,
        "monto": datos.monto,
        "saldo_origen": saldo_origen - datos.monto,
    }
# Fin</code></pre><p>Este es el cierre del libro y vale la pena mirar de dónde salió cada pieza:</p><ul><li><strong>Los <code>?</code> de las consultas</strong> (capítulo 21): en una API la inyección SQL deja de ser teórica, porque cualquiera en internet puede mandar lo que quiera en la URL.</li><li><strong>La transacción</strong> (capítulos 20 y 21): dos <code>UPDATE</code> y un solo <code>commit()</code>. Si el segundo falla, el <code>rollback()</code> deshace el primero y nadie pierde plata.</li><li><strong>El <code>finally</code></strong> (capítulo 15): la conexión se cierra aunque se haya lanzado una <code>HTTPException</code> en la mitad.</li><li><strong>Las funciones auxiliares</strong> (capítulo 14): <code>buscar_saldo()</code> valida y lanza el 404 en un solo lugar, en vez de repetir la comprobación en cada ruta.</li><li><strong>La configuración en el entorno</strong> (capítulo 16): el mismo archivo corre en tu portátil y en el servidor sin tocar una línea.</li><li><strong><code>/salud</code></strong>: el servicio de despliegue la consulta cada minuto; si deja de responder 200, reinicia la aplicación sola.</li></ul><p>Nada de esto es "código de FastAPI". Es todo lo del libro, expuesto por una dirección pública.</p>', NULL, '''''''
Programa: API del banco - version desplegable
Autor:
Fecha:
Descripcion:

Despliegue:
    1.
    2.
''''''

import os
import sqlite3

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

BASE = os.environ.get("DATABASE_PATH", "banco.db")

app = FastAPI(title="Banco JuanCode", version="1.0")


# Inicio

# Fin
', 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 24 AND track = 'basico');
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué diferencia hay entre un script y una API?', NULL, '{"options":[{"id":"a","text":"El script arranca, hace algo y termina; la API queda encendida esperando peticiones"},{"id":"b","text":"Ninguna, es el mismo programa con otro nombre"},{"id":"c","text":"La API no puede usar base de datos"},{"id":"d","text":"El script necesita internet y la API no"}]}', '{"option_id":"a"}', 'Por eso en una API los recursos se cierran siempre: el proceso no termina nunca y lo que se queda abierto se acumula.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hay en /docs de una aplicación FastAPI?', NULL, '{"options":[{"id":"a","text":"Documentación interactiva generada sola, con un botón para probar cada ruta"},{"id":"b","text":"El código fuente del proyecto"},{"id":"c","text":"Los registros de errores"},{"id":"d","text":"Nada, hay que escribirla a mano"}]}', '{"option_id":"a"}', 'Sale de las anotaciones de tipo y los modelos de Pydantic, sin configurar nada.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'Se pide una cuenta que no existe. ¿Qué debe responder la API?', NULL, '{"options":[{"id":"a","text":"404 con raise HTTPException"},{"id":"b","text":"200 con {\"error\": \"no existe\"}"},{"id":"c","text":"500, porque algo salió mal"},{"id":"d","text":"Nada, para no dar información"}]}', '{"option_id":"a"}', 'Quien consume la API mira el código de estado antes que el cuerpo: un 200 le dice que salió bien aunque el texto diga lo contrario.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Para qué sirve un modelo de Pydantic (BaseModel) en una ruta POST?', NULL, '{"options":[{"id":"a","text":"Describe y valida el cuerpo de la petición antes de que la función se ejecute"},{"id":"b","text":"Crea la tabla en la base de datos"},{"id":"c","text":"Convierte la respuesta a JSON"},{"id":"d","text":"Documenta la ruta, sin efecto real"}]}', '{"option_id":"a"}', 'Reemplaza las validaciones a mano: un saldo negativo se responde con 422 y el campo exacto, sin llegar al cuerpo de la función.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', 'La API funciona con curl, pero la página web no puede llamarla. ¿Qué falta?', NULL, '{"options":[{"id":"a","text":"Habilitar CORS con el dominio del frontend"},{"id":"b","text":"Cambiar los GET por POST"},{"id":"c","text":"Agregar más rutas"},{"id":"d","text":"Levantar el servidor con --reload"}]}', '{"option_id":"a"}', 'El bloqueo lo hace el navegador, no el servidor. Por eso curl pasa y la página no.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué en producción se usa --host 0.0.0.0 y el puerto de la variable PORT?', NULL, '{"options":[{"id":"a","text":"0.0.0.0 acepta conexiones de afuera y el puerto lo asigna el servicio de despliegue"},{"id":"b","text":"Porque es más rápido que 127.0.0.1"},{"id":"c","text":"Porque 127.0.0.1 solo funciona en Windows"},{"id":"d","text":"Porque así se activa HTTPS"}]}', '{"option_id":"a"}', 'Con 127.0.0.1 la API solo se escucha a sí misma, y con un puerto fijo el servicio no la encuentra.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', 'Se pide GET /cuentas?limite=3 . ¿Qué devuelve la API?', '@app.get("/cuentas")
def listar(tipo: str = "todos", limite: int = 10):
    return {"tipo": tipo, "limite": limite}', '{"options":[{"id":"a","text":"{\"tipo\": \"todos\", \"limite\": 3}"},{"id":"b","text":"{\"tipo\": \"todos\", \"limite\": 10}"},{"id":"c","text":"{\"tipo\": null, \"limite\": \"3\"}"},{"id":"d","text":"Un error 422 porque falta tipo"}]}', '{"option_id":"a"}', 'tipo conserva su valor por defecto y limite llega como texto "3" pero la anotación int lo convierte.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'Llega un POST /cuentas con {"numero": "001", "titular": "Ana", "saldo": -5000}. ¿Qué pasa?', 'class CuentaNueva(BaseModel):
    numero: str
    titular: str
    saldo: int = Field(default=0, ge=0)

@app.post("/cuentas", status_code=201)
def crear(cuenta: CuentaNueva):
    return {"creada": cuenta.numero}', '{"options":[{"id":"a","text":"Responde 422 y la función crear() nunca se ejecuta"},{"id":"b","text":"Responde 201 con {\"creada\": \"001\"}"},{"id":"c","text":"Responde 201 y guarda el saldo como 0"},{"id":"d","text":"Responde 500"}]}', '{"option_id":"a"}', 'ge=0 rechaza el saldo negativo. La validación ocurre antes del cuerpo de la función, con el campo exacto en el detalle.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El cliente cree que todo salió bien aunque la cuenta no exista. ¿En qué línea está el problema?', NULL, '{"lines":["@app.get(\"/cuentas/{numero}\")","def ver_cuenta(numero: str):","    if numero not in CUENTAS:","        return {\"error\": \"La cuenta no existe\"}","    return CUENTAS[numero]"]}', '{"line_number":4}', 'Ese return sale con código 200. Va raise HTTPException(status_code=404, detail="La cuenta no existe").', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'A las pocas horas el servidor deja de responder. ¿En qué línea está el problema?', NULL, '{"lines":["def ver_cuenta(numero: str):","    conexion = sqlite3.connect(BASE)","    fila = conexion.execute(\"SELECT * FROM cuentas WHERE numero = ?\", (numero,)).fetchone()","    return dict(fila)"]}', '{"line_number":4}', 'Se retorna sin cerrar la conexión: cada petición deja una abierta. El close() va en un finally.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'dificil', 'Esta API queda expuesta a inyección SQL. ¿En qué línea está el problema?', NULL, '{"lines":["@app.get(\"/cuentas/{numero}\")","def ver_cuenta(numero: str):","    sql = f\"SELECT * FROM cuentas WHERE numero = ''{numero}''\"","    fila = conexion.execute(sql).fetchone()","    return dict(fila)"]}', '{"line_number":3}', 'El valor viene de la URL y cualquiera en internet puede escribir lo que quiera ahí. Va execute("... = ?", (numero,)).', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme la ruta que consulta una cuenta en la base de datos', NULL, '{"lines":[{"id":"l1","text":"@app.get(\"/cuentas/{numero}\")","indent":0},{"id":"l2","text":"def ver_cuenta(numero: str):","indent":0},{"id":"l3","text":"conexion = conectar()","indent":1},{"id":"l4","text":"try:","indent":1},{"id":"l5","text":"fila = conexion.execute(SQL, (numero,)).fetchone()","indent":2},{"id":"l6","text":"finally:","indent":1},{"id":"l7","text":"conexion.close()","indent":2},{"id":"l8","text":"if fila is None:","indent":1},{"id":"l9","text":"raise HTTPException(status_code=404, detail=\"La cuenta no existe\")","indent":2},{"id":"l10","text":"return dict(fila)","indent":1}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7","l8","l9","l10"]}', 'La conexión se cierra en el finally antes de decidir la respuesta; solo entonces se revisa si hubo fila y se lanza el 404.', 1, 'seed'
    FROM chapters WHERE number = 24 AND track = 'basico';

