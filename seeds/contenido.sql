-- ============================================================================
--  CONTENIDO DEL LIBRO — generado por scripts/build-contenido.mjs
--  No editar a mano: se regenera con `npm run content:build`.
--  Solo toca las filas con source = 'seed'.
-- ============================================================================

INSERT INTO parts (number, title, emoji) VALUES (1, 'Fundamentos', '🌱')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji) VALUES (2, 'Control de flujo', '🔀')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji) VALUES (3, 'Estructuras de datos', '📚')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji) VALUES (4, 'Código organizado', '🧰')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji) VALUES (5, 'Programación orientada a objetos', '🏛️')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;
INSERT INTO parts (number, title, emoji) VALUES (6, 'Mundo real', '🚀')
  ON CONFLICT(number) DO UPDATE SET title = excluded.title, emoji = excluded.emoji;

-- ── Capítulo 1: ¿Qué es programar? (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
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

<blockquote>Programar no es memorizar comandos. Es aprender a partir un problema grande en pasos tan pequeños que hasta una máquina los pueda seguir.</blockquote>', 1
    FROM parts p WHERE p.number = 1
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 1
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1);
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Ficha de presentación', 'facil', '<p>Escriba un programa que muestre en pantalla, en <strong>tres líneas separadas</strong>:</p><ul><li>Su nombre completo.</li><li>Su ciudad.</li><li>Una razón por la que quiere aprender a programar.</li></ul><p><em>Nota:</em> el contenido de los textos es libre, pero deben salir exactamente tres renglones.</p>', '<p>Necesitas tres llamadas a <code>print()</code>, una debajo de la otra. Cada <code>print()</code> baja el cursor a la línea siguiente, así que no hay que hacer nada extra.</p>', '<pre><code># Ficha de presentación del estudiante
print("Ana Gómez")
print("Bogotá")
print("Quiero automatizar el inventario de la tienda de mi mamá")</code></pre><p>Línea por línea:</p><ol><li>Un comentario para que se sepa de qué es el programa. Python lo ignora.</li><li><code>print("Ana Gómez")</code> escribe el nombre y baja de línea.</li><li>Lo mismo con la ciudad.</li><li>Lo mismo con la razón. Tres <code>print()</code>, tres renglones.</li></ol>', NULL, NULL, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 2, 'Recibo de la tienda', 'facil', '<p>Una tienda vendió hoy <strong>340</strong> unidades. Escriba un programa que muestre exactamente:</p><pre><code>TIENDA LA ESQUINA
Ventas del dia: 340 unidades
Gracias por su compra</code></pre><p><em>Nota:</em> el número debe ir como número, no dentro del texto.</p>', '<p>Para la línea del medio usa <code>print()</code> con tres argumentos separados por comas: el texto de la izquierda, el número y el texto de la derecha. Recuerda que las comas ponen un espacio automático.</p>', '<pre><code># Recibo simple de cierre del día
print("TIENDA LA ESQUINA")
print("Ventas del dia:", 340, "unidades")
print("Gracias por su compra")</code></pre><p>La línea 3 es la interesante: <code>print()</code> recibe <strong>tres argumentos</strong> y los une con un espacio entre cada uno. Por eso no hay que escribir el espacio a mano dentro de las comillas. El <code>340</code> va sin comillas porque es un número.</p>', '[{"stdin":"","expected_output":"TIENDA LA ESQUINA\nVentas del dia: 340 unidades\nGracias por su compra"}]', '# Recibo simple de cierre del día
', 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'Caza el error', 'medio', '<p>El siguiente programa no ejecuta. Encuentre los <strong>tres</strong> errores, corríjalos y entregue el programa funcionando.</p><pre><code>Print("Inicio")
print("Mitad"
print(Fin)</code></pre><p><em>Nota:</em> la salida esperada son tres líneas: <code>Inicio</code>, <code>Mitad</code> y <code>Fin</code>.</p>', '<p>Revise tres cosas distintas: cómo se escribe el nombre de la función, si todos los paréntesis se cierran, y si todo texto está entre comillas.</p>', '<pre><code>print("Inicio")
print("Mitad")
print("Fin")</code></pre><p>Los tres errores eran:</p><ol><li><code>Print</code> con mayúscula: la función se llama <code>print</code>. Da <code>NameError</code>.</li><li>Falta cerrar el paréntesis en la línea 2. Da <code>SyntaxError</code>.</li><li><code>Fin</code> sin comillas: Python cree que es el nombre de un dato guardado y no lo encuentra. Da <code>NameError</code>.</li></ol>', '[{"stdin":"","expected_output":"Inicio\nMitad\nFin"}]', 'Print("Inicio")
print("Mitad"
print(Fin)
', 'seed'
    FROM chapters WHERE number = 1;
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
    FROM chapters WHERE number = 1;
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1);
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué es programar, en una frase?', NULL, '{"options":[{"id":"a","text":"Escribir instrucciones exactas para que una máquina las ejecute en orden"},{"id":"b","text":"Memorizar todos los comandos de un lenguaje"},{"id":"c","text":"Reparar computadores que fallan"},{"id":"d","text":"Diseñar la parte visual de una página web"}]}', '{"option_id":"a"}', 'La máquina no adivina: hace exactamente lo que le pides, en el orden en que se lo pides.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Para qué sirven las comillas en print("Hola")?', NULL, '{"options":[{"id":"a","text":"Le indican a Python dónde empieza y termina el texto"},{"id":"b","text":"Hacen que el texto salga en negrilla"},{"id":"c","text":"Son decorativas, se pueden quitar"},{"id":"d","text":"Convierten el texto en número"}]}', '{"option_id":"a"}', 'Sin comillas Python cree que Hola es el nombre de un dato guardado y lanza NameError.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué hace Python con una línea que empieza por #?', NULL, '{"options":[{"id":"a","text":"La ignora por completo: es un comentario"},{"id":"b","text":"La imprime en pantalla"},{"id":"c","text":"La ejecuta más rápido"},{"id":"d","text":"Lanza un error de sintaxis"}]}', '{"option_id":"a"}', 'Los comentarios son notas para humanos. Python los salta.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál de estas líneas está escrita correctamente?', NULL, '{"options":[{"id":"a","text":"print(\"Hola\")"},{"id":"b","text":"Print(\"Hola\")"},{"id":"c","text":"print \"Hola\""},{"id":"d","text":"print(Hola)"}]}', '{"option_id":"a"}', 'print en minúscula, con paréntesis y con el texto entre comillas. Las otras tres fallan en una de esas tres cosas.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuál de estos comentarios es realmente útil?', NULL, '{"options":[{"id":"a","text":"# el conteo del día lo entrega la caja registradora"},{"id":"b","text":"# imprime el total"},{"id":"c","text":"# print"},{"id":"d","text":"# línea 3"}]}', '{"option_id":"a"}', 'Un buen comentario explica el porqué, no repite lo que el código ya dice.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'El computador ejecuta las instrucciones…', NULL, '{"options":[{"id":"a","text":"En el orden en que están escritas, de arriba hacia abajo"},{"id":"b","text":"En el orden que él considere más rápido"},{"id":"c","text":"Todas al mismo tiempo"},{"id":"d","text":"Empezando por la última línea"}]}', '{"option_id":"a"}', 'El orden importa: por eso hay que romper el huevo antes de echarlo.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print("Hola")
print("JuanCode")', '{"options":[{"id":"a","text":"Hola\nJuanCode"},{"id":"b","text":"HolaJuanCode"},{"id":"c","text":"Hola JuanCode"},{"id":"d","text":"Solo Hola"}]}', '{"option_id":"a"}', 'Cada print() escribe y baja de línea, así que salen dos renglones.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print("Total:", 340, "unidades")', '{"options":[{"id":"a","text":"Total: 340 unidades"},{"id":"b","text":"Total:340unidades"},{"id":"c","text":"Total: , 340 , unidades"},{"id":"d","text":"Error: no se puede mezclar texto y número"}]}', '{"option_id":"a"}', 'Las comas de print() separan argumentos y meten un espacio entre cada uno.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', '# print("Uno")
print("Dos")', '{"options":[{"id":"a","text":"Dos"},{"id":"b","text":"Uno\nDos"},{"id":"c","text":"Uno"},{"id":"d","text":"No imprime nada"}]}', '{"option_id":"a"}', 'La primera línea es un comentario: Python la ignora por completo.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print("A")
print()
print("B")', '{"options":[{"id":"a","text":"A, un renglón en blanco, y B"},{"id":"b","text":"A y B pegados"},{"id":"c","text":"A B"},{"id":"d","text":"Error: print() necesita argumentos"}]}', '{"option_id":"a"}', 'print() sin argumentos solo baja de línea: sirve para separar bloques de salida.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print("-" * 5)', '{"options":[{"id":"a","text":"-----"},{"id":"b","text":"- * 5"},{"id":"c","text":"-5"},{"id":"d","text":"Error: no se puede multiplicar texto"}]}', '{"option_id":"a"}', 'Multiplicar un texto por un número lo repite. Sirve para dibujar separadores.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'Este programa no corre. ¿En qué línea está el error?', NULL, '{"lines":["print(\"Inicio\")","Print(\"Mitad\")","print(\"Fin\")"]}', '{"line_number":2}', 'Python distingue mayúsculas: la función es print, no Print. Da NameError.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["print(\"Menu del dia\")","print(\"Sopa\")","print(Jugo)","print(\"Postre\")"]}', '{"line_number":3}', 'Jugo va sin comillas, así que Python lo busca como un dato guardado y no existe.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["print(\"Cierre de caja\")","print(\"Total:\", 340","print(\"Gracias\")"]}', '{"line_number":2}', 'Falta cerrar el paréntesis. Python sigue leyendo esperando el cierre y termina en SyntaxError.', 1, 'seed'
    FROM chapters WHERE number = 1;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que imprime el recibo de la tienda', NULL, '{"lines":[{"id":"l1","text":"# Recibo de cierre del día","indent":0},{"id":"l2","text":"print(\"TIENDA LA ESQUINA\")","indent":0},{"id":"l3","text":"print(\"Ventas del dia:\", 340, \"unidades\")","indent":0},{"id":"l4","text":"print(\"Gracias por su compra\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'Primero el comentario que explica el programa, y después las tres líneas del recibo en el orden en que deben salir.', 1, 'seed'
    FROM chapters WHERE number = 1;

-- ── Capítulo 2: Variables y tipos de datos (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 2, 'Variables y tipos de datos', '📦', 'Cajas con nombre para guardar información, y los cuatro tipos básicos.', '', 0
    FROM parts p WHERE p.number = 1
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 2
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2);

-- ── Capítulo 3: input() y conversiones (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 3, 'input() y conversiones', '⌨️', 'Pedirle datos al usuario y convertirlos al tipo correcto.', '', 0
    FROM parts p WHERE p.number = 1
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 3
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3);

-- ── Capítulo 4: Operadores (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 4, 'Operadores', '🧮', 'Aritméticos, de comparación y lógicos, con su orden de precedencia.', '', 0
    FROM parts p WHERE p.number = 1
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 4
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4);

-- ── Capítulo 5: Strings a fondo (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 5, 'Strings a fondo', '📝', 'Indexación, slicing, métodos y f-strings.', '', 0
    FROM parts p WHERE p.number = 1
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 5
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5);

-- ── Capítulo 6: Condicionales (if / elif / else) (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 6, 'Condicionales (if / elif / else)', '🔀', 'Que el programa tome decisiones.', '', 0
    FROM parts p WHERE p.number = 2
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 6
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 6);

-- ── Capítulo 7: Ciclo while (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 7, 'Ciclo while', '⏳', 'Repetir mientras se cumpla una condición, con contadores, sumatorias y banderas.', '', 0
    FROM parts p WHERE p.number = 2
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 7
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 7);

-- ── Capítulo 8: Ciclo for y range() (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 8, 'Ciclo for y range()', '🔢', 'Recorrer secuencias y contar de forma elegante.', '', 0
    FROM parts p WHERE p.number = 2
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 8
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 8);

-- ── Capítulo 9: break, continue y ciclos anidados (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 9, 'break, continue y ciclos anidados', '🎛️', 'Controlar el flujo dentro de los ciclos.', '', 0
    FROM parts p WHERE p.number = 2
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 9
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 9);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 9);

-- ── Capítulo 10: Listas (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 10, 'Listas', '📋', 'La estructura de datos que más vas a usar.', '', 0
    FROM parts p WHERE p.number = 3
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 10
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 10);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 10);

-- ── Capítulo 11: Tuplas y sets (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 11, 'Tuplas y sets', '🎯', 'Datos inmutables y colecciones sin repetidos.', '', 0
    FROM parts p WHERE p.number = 3
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 11
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 11);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 11);

-- ── Capítulo 12: Diccionarios (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 12, 'Diccionarios', '🗂️', 'Guardar información con clave y valor.', '', 0
    FROM parts p WHERE p.number = 3
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 12
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 12);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 12);

-- ── Capítulo 13: Comprehensions (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 13, 'Comprehensions', '⚡', 'Crear listas, sets y diccionarios en una sola línea.', '', 0
    FROM parts p WHERE p.number = 3
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 13
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 13);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 13);

-- ── Capítulo 14: Funciones (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 14, 'Funciones', '🧰', 'Empaquetar lógica para reutilizarla.', '', 0
    FROM parts p WHERE p.number = 4
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 14
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 14);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 14);

-- ── Capítulo 15: Errores y excepciones (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 15, 'Errores y excepciones', '🛡️', 'try, except, finally y errores propios.', '', 0
    FROM parts p WHERE p.number = 4
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 15
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 15);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 15);

-- ── Capítulo 16: Módulos, pip y entornos virtuales (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 16, 'Módulos, pip y entornos virtuales', '📚', 'Organizar el proyecto y usar librerías externas.', '', 0
    FROM parts p WHERE p.number = 4
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 16
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 16);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 16);

-- ── Capítulo 17: Archivos (txt, csv, json) (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 17, 'Archivos (txt, csv, json)', '📁', 'Leer y escribir datos en disco.', '', 0
    FROM parts p WHERE p.number = 4
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 17
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 17);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 17);

-- ── Capítulo 18: Clases y objetos (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 18, 'Clases y objetos', '🏛️', 'Modelar el mundo con atributos y métodos.', '', 0
    FROM parts p WHERE p.number = 5
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 18
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 18);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 18);

-- ── Capítulo 19: Herencia y métodos especiales (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 19, 'Herencia y métodos especiales', '🧬', 'Reutilizar clases y personalizar su comportamiento.', '', 0
    FROM parts p WHERE p.number = 5
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 19
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 19);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 19);

-- ── Capítulo 20: Proyecto integrador: Sistema Bancario (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 20, 'Proyecto integrador: Sistema Bancario', '🏗️', 'Todo lo aprendido en una sola aplicación.', '', 0
    FROM parts p WHERE p.number = 6
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 20
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 20);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 20);

-- ── Capítulo 21: SQL desde cero (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 21, 'SQL desde cero', '🗄️', 'Bases de datos relacionales y consultas desde Python.', '', 0
    FROM parts p WHERE p.number = 6
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 21
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 21);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 21);

-- ── Capítulo 22: Pandas y datos (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 22, 'Pandas y datos', '🐼', 'Cargar, limpiar y analizar datos reales.', '', 0
    FROM parts p WHERE p.number = 6
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 22
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 22);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 22);

-- ── Capítulo 23: IA aplicada con Python (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 23, 'IA aplicada con Python', '🤖', 'Consumir modelos y construir algo útil con ellos.', '', 0
    FROM parts p WHERE p.number = 6
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 23
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 23);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 23);

-- ── Capítulo 24: APIs con FastAPI y despliegue (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
  SELECT p.id, 24, 'APIs con FastAPI y despliegue', '🚀', 'Publicar tu propio backend en internet.', '', 0
    FROM parts p WHERE p.number = 6
  ON CONFLICT(number) DO UPDATE SET
    part_id      = excluded.part_id,
    title        = excluded.title,
    emoji        = excluded.emoji,
    description  = excluded.description,
    content_html = excluded.content_html,
    published    = excluded.published;
INSERT INTO quizzes (chapter_id, passing_score) SELECT id, 80 FROM chapters WHERE number = 24
  ON CONFLICT(chapter_id) DO UPDATE SET passing_score = excluded.passing_score;
DELETE FROM exercises WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 24);
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 24);

