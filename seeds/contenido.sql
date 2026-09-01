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

-- ── Capítulo 2: Variables y tipos de datos (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
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

<blockquote>Regla de oro: si vas a mostrarlo, es texto. Si vas a hacer cuentas con eso, es número. Convierte cuando cruces de un lado al otro.</blockquote>', 1
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
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 1, 'Ficha del estudiante', 'facil', '<p>Cree tres variables: <code>nombre</code> (texto), <code>edad</code> (entero) y <code>estatura</code> (decimal). Luego muestre una sola línea con el formato:</p><pre><code>Ana tiene 17 anios y mide 1.62 metros</code></pre><p><em>Nota:</em> use las comas de <code>print()</code>, no concatenación con <code>+</code>.</p>', '<p>Las comas de <code>print()</code> aceptan textos y números mezclados y ponen un espacio entre cada argumento. Por eso no necesitas <code>str()</code>.</p>', '<pre><code># Ficha basica del estudiante
nombre = "Ana"
edad = 17
estatura = 1.62

print(nombre, "tiene", edad, "anios y mide", estatura, "metros")</code></pre><p>Las tres primeras líneas crean las cajas. La última las usa: <code>print()</code> recibe seis argumentos y los pega con un espacio entre cada uno. Si hubieras usado <code>+</code> tendrías que convertir <code>edad</code> y <code>estatura</code> con <code>str()</code>.</p>', '[{"stdin":"","expected_output":"Ana tiene 17 anios y mide 1.62 metros"}]', '# Ficha basica del estudiante
', 'seed'
    FROM chapters WHERE number = 2;
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
    FROM chapters WHERE number = 2;
INSERT INTO exercises (chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html, tests_json, starter_code, source)
  SELECT id, 3, 'La calculadora que se rompió', 'medio', '<p>Este programa debería sumar dos números pero imprime <code>1020</code> en vez de <code>30</code>:</p><pre><code>a = "10"
b = "20"
print(a + b)</code></pre><p>Explique por qué pasa y entregue el programa corregido, que debe imprimir:</p><pre><code>30</code></pre>', '<p>Mire las comillas. Con dos <code>str</code>, el operador <code>+</code> no suma: pega. Hay dos formas de arreglarlo y ambas son válidas.</p>', '<p><code>a</code> y <code>b</code> son <code>str</code>, no <code>int</code>. Con textos, <code>+</code> concatena: <code>"10" + "20"</code> da <code>"1020"</code>.</p><pre><code># Opcion 1: que sean numeros desde el principio
a = 10
b = 20
print(a + b)          # 30

# Opcion 2: convertirlos al usarlos
a = "10"
b = "20"
print(int(a) + int(b))  # 30</code></pre><p>La opción 1 es mejor cuando el dato siempre es número. La opción 2 es la que vas a usar en el capítulo 3, cuando el dato venga de <code>input()</code>, que siempre entrega texto.</p>', '[{"stdin":"","expected_output":"30"}]', 'a = "10"
b = "20"
print(a + b)
', 'seed'
    FROM chapters WHERE number = 2;
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
    FROM chapters WHERE number = 2;
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2);
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué significa el signo = en Python?', NULL, '{"options":[{"id":"a","text":"Guarda en la variable de la izquierda el valor de la derecha"},{"id":"b","text":"Compara si los dos lados son iguales"},{"id":"c","text":"Suma los dos lados"},{"id":"d","text":"Declara una constante que no se puede cambiar"}]}', '{"option_id":"a"}', 'El = es asignación. Comparar es == , que verás en el capítulo 4.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿De qué tipo es la variable precio en precio = "1990"?', NULL, '{"options":[{"id":"a","text":"str, porque está entre comillas"},{"id":"b","text":"int, porque solo tiene dígitos"},{"id":"c","text":"float, porque representa dinero"},{"id":"d","text":"bool"}]}', '{"option_id":"a"}', 'Las comillas mandan: todo lo que va entre comillas es texto, aunque parezca número.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál de estos nombres de variable es válido?', NULL, '{"options":[{"id":"a","text":"nota_final"},{"id":"b","text":"2do_intento"},{"id":"c","text":"nota final"},{"id":"d","text":"nota-final"}]}', '{"option_id":"a"}', 'Solo letras, números y guion bajo, y sin empezar por número. El guion medio Python lo lee como una resta.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'En Python, ¿qué representa el literal 1.500?', NULL, '{"options":[{"id":"a","text":"Uno coma cinco: el punto es el separador decimal"},{"id":"b","text":"Mil quinientos"},{"id":"c","text":"Un error de sintaxis"},{"id":"d","text":"El texto \"1.500\""}]}', '{"option_id":"a"}', 'Mil quinientos se escribe 1500 o 1_500. El punto siempre es decimal.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué tipo devuelve la operación 7000 * 0.04?', NULL, '{"options":[{"id":"a","text":"float"},{"id":"b","text":"int"},{"id":"c","text":"str"},{"id":"d","text":"bool"}]}', '{"option_id":"a"}', 'Si uno de los dos es float, el resultado es float. Por eso los descuentos salen con .0', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'x = 5
x = x + 3
print(x)', '{"options":[{"id":"a","text":"8"},{"id":"b","text":"5"},{"id":"c","text":"53"},{"id":"d","text":"Error: no se puede usar x en su propia asignación"}]}', '{"option_id":"a"}', 'Python resuelve primero el lado derecho (5 + 3) y después guarda el 8 en la misma caja.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print("2" + "3")', '{"options":[{"id":"a","text":"23"},{"id":"b","text":"5"},{"id":"c","text":"2 3"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'Con textos el + pega en vez de sumar. Para sumar habría que convertir con int().', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'saldo = 250000
saldo - 80000
print(saldo)', '{"options":[{"id":"a","text":"250000"},{"id":"b","text":"170000"},{"id":"c","text":"0"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'La línea 2 calcula 170000 y lo bota: sin una asignación, el resultado se pierde.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'edad = 17
print("Edad:", edad)', '{"options":[{"id":"a","text":"Edad: 17"},{"id":"b","text":"TypeError"},{"id":"c","text":"Edad:17"},{"id":"d","text":"Edad: edad"}]}', '{"option_id":"a"}', 'Las comas de print() aceptan tipos mezclados: no hace falta str(). Con + sí daría TypeError.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'a = 10
b = a
a = 99
print(b)', '{"options":[{"id":"a","text":"10"},{"id":"b","text":"99"},{"id":"c","text":"1099"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'b se llevó una copia del valor que a tenía en ese momento. Cambiar a después no afecta a b.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'print(type(4.5))', '{"options":[{"id":"a","text":"class ''float''"},{"id":"b","text":"class ''int''"},{"id":"c","text":"class ''str''"},{"id":"d","text":"4.5"}]}', '{"option_id":"a"}', 'type() dice de qué tipo es el dato. Con decimales, siempre float.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', '¿En qué línea está el error?', NULL, '{"lines":["edad = 17","print(\"Edad: \" + edad)","print(\"fin\")"]}', '{"line_number":2}', 'No se puede pegar texto con número usando +. Faltaba str(edad), o usar las comas de print().', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["print(total)","total = 100","print(total)"]}', '{"line_number":1}', 'Python lee de arriba hacia abajo: cuando llegó al primer print, la variable total todavía no existía.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que calcula el neto de la quincena', NULL, '{"lines":[{"id":"l1","text":"valor_hora = 7000","indent":0},{"id":"l2","text":"horas = 96","indent":0},{"id":"l3","text":"total = valor_hora * horas","indent":0},{"id":"l4","text":"descuentos = total * 0.08","indent":0},{"id":"l5","text":"print(\"Neto:\", total - descuentos)","indent":0}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Una variable no se puede usar antes de crearse: primero los datos de entrada, luego los cálculos que dependen de ellos y al final la salida.', 1, 'seed'
    FROM chapters WHERE number = 2;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa que muestra el saldo tras dos movimientos', NULL, '{"lines":[{"id":"l1","text":"saldo = 250000","indent":0},{"id":"l2","text":"saldo = saldo - 80000","indent":0},{"id":"l3","text":"saldo = saldo + 30000","indent":0},{"id":"l4","text":"print(\"Saldo final:\", saldo)","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'El orden de los movimientos cambia el resultado intermedio, y el print va de último para ver el saldo ya actualizado.', 1, 'seed'
    FROM chapters WHERE number = 2;

-- ── Capítulo 3: input() y conversiones (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
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

<blockquote>Todo lo que entra por el teclado es texto. Si vas a hacer cuentas con eso, conviértelo en la misma línea en que lo pides.</blockquote>', 1
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
    FROM chapters WHERE number = 3;
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
    FROM chapters WHERE number = 3;
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
    FROM chapters WHERE number = 3;
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
    FROM chapters WHERE number = 3;
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3);
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué tipo devuelve siempre input()?', NULL, '{"options":[{"id":"a","text":"str, sin importar lo que escriba el usuario"},{"id":"b","text":"int si el usuario escribe dígitos"},{"id":"c","text":"El tipo que Python adivine del contenido"},{"id":"d","text":"float, para poder hacer cuentas"}]}', '{"option_id":"a"}', 'input() siempre entrega texto. Por eso hay que convertir con int() o float() cuando el dato es numérico.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Dónde va el mensaje que ve el usuario al pedir un dato?', NULL, '{"options":[{"id":"a","text":"Dentro del paréntesis del input()"},{"id":"b","text":"En un print() de la línea anterior"},{"id":"c","text":"En un comentario"},{"id":"d","text":"En el encabezado del programa"}]}', '{"option_id":"a"}', 'input("Edad: ") muestra el mensaje y deja el cursor a continuación. Con print() aparte el cursor baja de línea.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', 'El usuario debe escribir un precio que puede llevar centavos. ¿Cómo se pide?', NULL, '{"options":[{"id":"a","text":"float(input(\"Precio: \"))"},{"id":"b","text":"int(input(\"Precio: \"))"},{"id":"c","text":"input(float(\"Precio: \"))"},{"id":"d","text":"str(input(\"Precio: \"))"}]}', '{"option_id":"a"}', 'int() revienta con "12500.50". Para decimales se usa float(), y la conversión envuelve al input().', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué error lanza int("veinte")?', NULL, '{"options":[{"id":"a","text":"ValueError"},{"id":"b","text":"TypeError"},{"id":"c","text":"NameError"},{"id":"d","text":"SyntaxError"}]}', '{"option_id":"a"}', 'El tipo es correcto (un texto), pero el contenido no representa un entero: eso es ValueError.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué debe llevar el encabezado documentado de un programa?', NULL, '{"options":[{"id":"a","text":"Nombre del programa, autor, fecha y descripción, entre comillas triples"},{"id":"b","text":"Solo el nombre del archivo"},{"id":"c","text":"La lista completa de variables usadas"},{"id":"d","text":"El resultado esperado del programa"}]}', '{"option_id":"a"}', 'El bloque entre '''''' documenta qué es el programa y quién lo hizo. Adentro van las secciones #Inicio y #Fin.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'El usuario escribe 3. ¿Qué imprime este programa?', 'cantidad = input("Cantidad: ")
print(cantidad * 2)', '{"options":[{"id":"a","text":"33"},{"id":"b","text":"6"},{"id":"c","text":"3 3"},{"id":"d","text":"TypeError"}]}', '{"option_id":"a"}', 'Falta el int(): multiplicar un texto por 2 lo repite. Corre sin error y entrega basura, que es lo peligroso.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', 'El usuario escribe 25. ¿Qué imprime este programa?', 'edad = int(input("Edad: "))
print(edad + 1)', '{"options":[{"id":"a","text":"26"},{"id":"b","text":"251"},{"id":"c","text":"TypeError"},{"id":"d","text":"ValueError"}]}', '{"option_id":"a"}', 'Con el int() la suma es aritmética. Sin él, sería TypeError al mezclar texto y número.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print(int(" 25 "))', '{"options":[{"id":"a","text":"25"},{"id":"b","text":"ValueError"},{"id":"c","text":"\" 25 \""},{"id":"d","text":"2 5"}]}', '{"option_id":"a"}', 'int() ignora los espacios de sobra a lado y lado. Lo que no acepta son letras ni decimales.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'print(int(float("25.7")))', '{"options":[{"id":"a","text":"25"},{"id":"b","text":"26"},{"id":"c","text":"25.7"},{"id":"d","text":"ValueError"}]}', '{"option_id":"a"}', 'float() acepta el decimal y int() recorta la parte decimal: no redondea, la corta.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', 'El usuario escribe 12000 y luego 3. ¿Qué imprime?', 'precio = input("Precio: ")
cantidad = int(input("Cantidad: "))
print(precio * cantidad)', '{"options":[{"id":"a","text":"120001200012000"},{"id":"b","text":"36000"},{"id":"c","text":"TypeError"},{"id":"d","text":"12000 3"}]}', '{"option_id":"a"}', 'precio quedó como texto: texto por entero repite el texto tres veces. El error está en la línea 1, no en la 3.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe sumar 1 a la edad. ¿En qué línea está el error?', NULL, '{"lines":["edad = input(\"Edad: \")","print(edad + 1)"]}', '{"line_number":1}', 'Falta convertir: debía ser int(input("Edad: ")). El síntoma sale en la línea 2, pero el error se cometió en la 1.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', 'El precio puede tener centavos. ¿En qué línea está el error?', NULL, '{"lines":["''''''","Programa: Compra","''''''","# Inicio","precio = int(input(\"Precio: \"))","print(\"Precio:\", precio)","# Fin"]}', '{"line_number":5}', 'Con centavos, int() lanza ValueError. Ahí va float().', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["nombre = input(\"Nombre: \")","edad = int(input(\"Edad: \")","print(nombre, edad)"]}', '{"line_number":2}', 'Falta un paréntesis de cierre: se abrieron int( e input( y solo se cerró uno.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que calcula el total de una compra', NULL, '{"lines":[{"id":"l1","text":"precio = int(input(\"Precio unitario: \"))","indent":0},{"id":"l2","text":"cantidad = int(input(\"Cantidad: \"))","indent":0},{"id":"l3","text":"total = precio * cantidad","indent":0},{"id":"l4","text":"print(\"Total a pagar:\", total)","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', 'Primero se piden los dos datos, después se calcula con ellos y de último se muestra. No se puede calcular con algo que aún no se pidió.', 1, 'seed'
    FROM chapters WHERE number = 3;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'dificil', 'Arme el programa documentado que calcula el descuento', NULL, '{"lines":[{"id":"l1","text":"''''''","indent":0},{"id":"l2","text":"Programa: Descuento del almacen","indent":0},{"id":"l3","text":"''''''","indent":0},{"id":"l4","text":"# Inicio","indent":0},{"id":"l5","text":"precio = float(input(\"Precio: \"))","indent":0},{"id":"l6","text":"descuento = float(input(\"Descuento (%): \"))","indent":0},{"id":"l7","text":"total = precio - precio * (descuento / 100)","indent":0},{"id":"l8","text":"print(\"Total a pagar:\", total)","indent":0},{"id":"l9","text":"# Fin","indent":0}]}', '{"order":["l1","l2","l3","l4","l5","l6","l7","l8","l9"]}', 'El encabezado abre y cierra con '''''', y toda la lógica queda encerrada entre #Inicio y #Fin.', 1, 'seed'
    FROM chapters WHERE number = 3;

-- ── Capítulo 4: Operadores (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
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

<blockquote>Un signo igual guarda. Dos signos igual preguntan. Esa sola frase te ahorra la mitad de los errores del próximo capítulo.</blockquote>', 1
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
    FROM chapters WHERE number = 4;
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
    FROM chapters WHERE number = 4;
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
    FROM chapters WHERE number = 4;
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
    FROM chapters WHERE number = 4;
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 4);
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la diferencia entre / y // ?', NULL, '{"options":[{"id":"a","text":"/ siempre da decimal; // da solo la parte entera"},{"id":"b","text":"Son lo mismo, // es más rápido"},{"id":"c","text":"// divide y / saca el resto"},{"id":"d","text":"// solo sirve con números negativos"}]}', '{"option_id":"a"}', '10 / 2 da 5.0 (float) y 10 // 3 da 3. Para el resto está el %.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cómo se pregunta si un número es par?', NULL, '{"options":[{"id":"a","text":"numero % 2 == 0"},{"id":"b","text":"numero / 2 == 0"},{"id":"c","text":"numero // 2 == 0"},{"id":"d","text":"numero == par"}]}', '{"option_id":"a"}', 'Un número es par cuando al dividirlo entre 2 no sobra nada, o sea cuando el resto es 0.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Qué diferencia hay entre = y == ?', NULL, '{"options":[{"id":"a","text":"= guarda un valor; == pregunta si dos cosas son iguales"},{"id":"b","text":"Son equivalentes"},{"id":"c","text":"= compara y == asigna"},{"id":"d","text":"== solo sirve con textos"}]}', '{"option_id":"a"}', 'Un signo igual guarda, dos preguntan. Usar = dentro de un if da SyntaxError.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Cuándo es verdadero A and B?', NULL, '{"options":[{"id":"a","text":"Solo cuando A y B son verdaderos los dos"},{"id":"b","text":"Cuando al menos uno es verdadero"},{"id":"c","text":"Cuando los dos son falsos"},{"id":"d","text":"Siempre que A sea verdadero"}]}', '{"option_id":"a"}', 'and es exigente: si una parte falla, todo falla. El conforme es or.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué if nota == 3 or 4: está mal?', NULL, '{"options":[{"id":"a","text":"Porque el 4 solo se evalúa como \"distinto de cero\", así que la condición siempre es verdadera"},{"id":"b","text":"Porque or no se puede usar con números"},{"id":"c","text":"Porque falta un paréntesis"},{"id":"d","text":"Porque nota debería ir después del or"}]}', '{"option_id":"a"}', 'Cada lado de un or tiene que ser una comparación completa: nota == 3 or nota == 4.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print(7 // 2, 7 % 2, 7 / 2)', '{"options":[{"id":"a","text":"3 1 3.5"},{"id":"b","text":"3.5 1 3"},{"id":"c","text":"3 3 3"},{"id":"d","text":"3.5 3.5 3.5"}]}', '{"option_id":"a"}', '// da cuántas veces cabe (3), % lo que sobra (1) y / el resultado exacto (3.5).', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'print(2 + 3 * 4)', '{"options":[{"id":"a","text":"14"},{"id":"b","text":"20"},{"id":"c","text":"24"},{"id":"d","text":"9"}]}', '{"option_id":"a"}', 'La multiplicación va antes que la suma: 3*4 = 12, y 2 + 12 = 14.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'nota1 = 4.0
nota2 = 3.0
print(nota1 + nota2 / 2)', '{"options":[{"id":"a","text":"5.5"},{"id":"b","text":"3.5"},{"id":"c","text":"7.0"},{"id":"d","text":"3.0"}]}', '{"option_id":"a"}', 'Sin paréntesis solo se divide nota2: 4.0 + 1.5 = 5.5. El promedio correcto sería (nota1 + nota2) / 2.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print(10 / 2)', '{"options":[{"id":"a","text":"5.0"},{"id":"b","text":"5"},{"id":"c","text":"5.5"},{"id":"d","text":"2"}]}', '{"option_id":"a"}', 'El operador / siempre entrega float, aunque la división sea exacta.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'edad = 20
tiene_cedula = False
print(edad >= 18 and tiene_cedula)', '{"options":[{"id":"a","text":"False"},{"id":"b","text":"True"},{"id":"c","text":"20"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'La primera parte es True pero la segunda es False, y con and basta con que una falle.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'minutos = 260
print((minutos + 59) // 60)', '{"options":[{"id":"a","text":"5"},{"id":"b","text":"4"},{"id":"c","text":"4.33"},{"id":"d","text":"319"}]}', '{"option_id":"a"}', 'Sumar 59 antes de la división entera redondea hacia arriba: es el truco de la hora empezada.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'nota = 3.8
print(3.0 <= nota <= 5.0)', '{"options":[{"id":"a","text":"True"},{"id":"b","text":"False"},{"id":"c","text":"3.8"},{"id":"d","text":"SyntaxError"}]}', '{"option_id":"a"}', 'Python permite encadenar comparaciones igual que en matemáticas: pregunta si nota está dentro del rango.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe mostrar el promedio de dos notas. ¿En qué línea está el error?', NULL, '{"lines":["nota1 = 4.0","nota2 = 3.0","promedio = nota1 + nota2 / 2","print(promedio)"]}', '{"line_number":3}', 'Faltan los paréntesis: debía ser (nota1 + nota2) / 2. Corre sin error pero da un resultado equivocado.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["edad = int(input(\"Edad: \"))","es_mayor = edad => 18","print(es_mayor)"]}', '{"line_number":2}', 'El operador se escribe >=, no =>. El signo de comparación va primero.', 1, 'seed'
    FROM chapters WHERE number = 4;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que convierte minutos a horas y minutos', NULL, '{"lines":[{"id":"l1","text":"total_minutos = int(input(\"Minutos: \"))","indent":0},{"id":"l2","text":"horas = total_minutos // 60","indent":0},{"id":"l3","text":"minutos = total_minutos % 60","indent":0},{"id":"l4","text":"print(horas, \"horas y\", minutos, \"minutos\")","indent":0}]}', '{"order":["l1","l2","l3","l4"]}', '// y % trabajan sobre el mismo dato de entrada, así que ambos van después de pedirlo y antes de mostrar.', 1, 'seed'
    FROM chapters WHERE number = 4;

-- ── Capítulo 5: Strings a fondo (publicado)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published)
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

<blockquote>Los métodos de texto no cambian la variable: devuelven una copia arreglada. Si no la guardas, se pierde.</blockquote>', 1
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
    FROM chapters WHERE number = 5;
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
    FROM chapters WHERE number = 5;
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
    FROM chapters WHERE number = 5;
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
    FROM chapters WHERE number = 5;
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 5);
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Desde qué número se cuentan las posiciones de un string?', NULL, '{"options":[{"id":"a","text":"Desde 0"},{"id":"b","text":"Desde 1"},{"id":"c","text":"Desde -1"},{"id":"d","text":"Depende del largo del texto"}]}', '{"option_id":"a"}', 'La primera casilla es la 0, así que en un texto de 9 letras la última es la 8.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'facil', '¿Cuál es la forma más segura de obtener el último carácter de un texto?', NULL, '{"options":[{"id":"a","text":"texto[-1]"},{"id":"b","text":"texto[len(texto)]"},{"id":"c","text":"texto[1]"},{"id":"d","text":"texto.last()"}]}', '{"option_id":"a"}', 'texto[len(texto)] se pasa por uno y da IndexError. Con [-1] no hay que calcular nada.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Qué hace nombre.upper() si no se guarda el resultado?', NULL, '{"options":[{"id":"a","text":"Nada visible: devuelve un texto nuevo y se pierde"},{"id":"b","text":"Cambia la variable nombre"},{"id":"c","text":"Lanza un error"},{"id":"d","text":"Imprime el texto en mayúsculas"}]}', '{"option_id":"a"}', 'Los métodos de texto no modifican el original: devuelven una copia. Hay que hacer nombre = nombre.upper().', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'medio', '¿Para qué sirve la f antes de las comillas en f"Hola {nombre}"?', NULL, '{"options":[{"id":"a","text":"Para que Python reemplace lo que está entre llaves por su valor"},{"id":"b","text":"Para indicar que el texto está en formato UTF-8"},{"id":"c","text":"Para que el texto salga en negrilla"},{"id":"d","text":"Para convertir el texto en float"}]}', '{"option_id":"a"}', 'Sin la f, las llaves se imprimen tal cual. Con la f, adentro cabe cualquier expresión.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'mcq', 'dificil', '¿Por qué una cédula se guarda como texto y no como número?', NULL, '{"options":[{"id":"a","text":"Porque no se hacen cuentas con ella y un cero inicial se perdería"},{"id":"b","text":"Porque los números enteros no aceptan más de 8 dígitos"},{"id":"c","text":"Porque input() no puede convertirla"},{"id":"d","text":"Porque ocupa menos memoria"}]}', '{"option_id":"a"}', 'Cédulas, teléfonos y códigos son identificadores, no cantidades: se manejan como texto.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'facil', '¿Qué imprime este programa?', 'ciudad = "Cartagena"
print(ciudad[0], ciudad[-1])', '{"options":[{"id":"a","text":"C a"},{"id":"b","text":"C n"},{"id":"c","text":"Ca"},{"id":"d","text":"IndexError"}]}', '{"option_id":"a"}', '[0] es la primera letra y [-1] la última, que en Cartagena es otra a.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'ciudad = "Cartagena"
print(ciudad[0:5])', '{"options":[{"id":"a","text":"Carta"},{"id":"b","text":"Cartag"},{"id":"c","text":"artag"},{"id":"d","text":"Carta g"}]}', '{"option_id":"a"}', 'En una rebanada el inicio entra y el final no: se toman las posiciones 0, 1, 2, 3 y 4.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'nombre = "  ana  "
nombre.strip()
print(f"[{nombre}]")', '{"options":[{"id":"a","text":"[  ana  ]"},{"id":"b","text":"[ana]"},{"id":"c","text":"[]"},{"id":"d","text":"Error"}]}', '{"option_id":"a"}', 'El strip() calculó el texto limpio y lo botó porque nadie lo guardó. La variable sigue igual.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'print(f"{4.5678:.2f}")', '{"options":[{"id":"a","text":"4.57"},{"id":"b","text":"4.56"},{"id":"c","text":"4.5678"},{"id":"d","text":"4.6"}]}', '{"option_id":"a"}', '.2f deja dos decimales y redondea: 4.5678 pasa a 4.57.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'medio', '¿Qué imprime este programa?', 'saldo = 1250000
print(f"{saldo:,}")', '{"options":[{"id":"a","text":"1,250,000"},{"id":"b","text":"1.250.000"},{"id":"c","text":"1250000"},{"id":"d","text":"1250,000"}]}', '{"option_id":"a"}', 'La coma como especificador mete el separador de miles al estilo inglés.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'fecha = "14/03/2026"
partes = fecha.split("/")
print(partes[2])', '{"options":[{"id":"a","text":"2026"},{"id":"b","text":"03"},{"id":"c","text":"14"},{"id":"d","text":"/"}]}', '{"option_id":"a"}', 'split() parte el texto donde encuentra el separador y devuelve una lista: ["14", "03", "2026"].', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'predict_output', 'dificil', '¿Qué imprime este programa?', 'print("  ANA gomez  ".strip().lower().title())', '{"options":[{"id":"a","text":"Ana Gomez"},{"id":"b","text":"  Ana Gomez  "},{"id":"c","text":"ANA GOMEZ"},{"id":"d","text":"ana gomez"}]}', '{"option_id":"a"}', 'Los métodos se encadenan de izquierda a derecha: primero se quitan espacios, luego se baja todo a minúsculas y al final se ponen las iniciales.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'facil', 'El programa debe mostrar el nombre en mayúsculas. ¿En qué línea está el error?', NULL, '{"lines":["nombre = input(\"Nombre: \")","nombre.upper()","print(nombre)"]}', '{"line_number":2}', 'Falta guardar: nombre = nombre.upper(). Así como está, el resultado se calcula y se bota.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'find_bug', 'medio', '¿En qué línea está el error?', NULL, '{"lines":["nombre = \"Ana\"","saldo = 1250000","print(\"{nombre} tiene {saldo}\")"]}', '{"line_number":3}', 'Falta la f antes de las comillas: sin ella las llaves se imprimen tal cual.', 1, 'seed'
    FROM chapters WHERE number = 5;
INSERT INTO question_bank (chapter_id, type, difficulty, prompt, code_snippet, data_json, correct_json, explanation, active, source)
  SELECT id, 'parsons', 'medio', 'Arme el programa que separa un correo en usuario y dominio', NULL, '{"lines":[{"id":"l1","text":"crudo = input(\"Correo: \")","indent":0},{"id":"l2","text":"correo = crudo.strip().lower()","indent":0},{"id":"l3","text":"partes = correo.split(\"@\")","indent":0},{"id":"l4","text":"print(f\"Usuario: {partes[0]}\")","indent":0},{"id":"l5","text":"print(f\"Dominio: {partes[-1]}\")","indent":0}]}', '{"order":["l1","l2","l3","l4","l5"]}', 'Primero se pide, después se normaliza, luego se parte y al final se muestran los pedazos.', 1, 'seed'
    FROM chapters WHERE number = 5;

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

