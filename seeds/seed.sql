-- ============================================================================
--  EL LIBRO JUANCODE — seed del contenido
--  Se puede ejecutar varias veces: todo usa INSERT OR IGNORE con ids fijos.
--
--    npm run db:seed:local      (D1 local)
--    npm run db:seed:remote     (D1 en Cloudflare)
--
--  Los usuarios NO se siembran aquí: el profe (desde .dev.vars) y el
--  estudiante demo se crean solos al abrir /login (app/lib/bootstrap.server.ts),
--  porque el hash de la contraseña lo tiene que generar Better Auth.
-- ============================================================================

-- ---------------------------------------------------------------------------
--  PARTES
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO parts (id, number, title, emoji) VALUES
  (1, 1, 'Fundamentos',        '🌱'),
  (2, 2, 'Control de flujo',   '🔀'),
  (3, 3, 'Estructuras de datos','📚'),
  (4, 4, 'Código organizado',  '🧰'),
  (5, 5, 'Programación orientada a objetos', '🏛️'),
  (6, 6, 'Mundo real',         '🚀');

-- ---------------------------------------------------------------------------
--  CAPÍTULOS 3..24 — placeholders (published = 0)
--  (los capítulos 1 y 2 van más abajo, con contenido real)
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO chapters (id, part_id, number, title, emoji, description, content_html, published) VALUES
  (3,  1, 3,  'input() y conversiones', '⌨️', 'Pedirle datos al usuario y convertirlos al tipo correcto.', '', 0),
  (4,  1, 4,  'Operadores', '🧮', 'Aritméticos, de comparación y lógicos, con su orden de precedencia.', '', 0),
  (5,  1, 5,  'Strings a fondo', '📝', 'Indexación, slicing, métodos y f-strings.', '', 0),

  (6,  2, 6,  'Condicionales (if / elif / else)', '🔀', 'Que el programa tome decisiones.', '', 0),
  (7,  2, 7,  'Ciclo while', '⏳', 'Repetir mientras se cumpla una condición.', '', 0),
  (8,  2, 8,  'Ciclo for y range()', '🔢', 'Recorrer secuencias y contar de forma elegante.', '', 0),
  (9,  2, 9,  'break, continue y ciclos anidados', '🎛️', 'Controlar el flujo dentro de los ciclos.', '', 0),

  (10, 3, 10, 'Listas', '📋', 'La estructura de datos que más vas a usar.', '', 0),
  (11, 3, 11, 'Tuplas y sets', '🎯', 'Datos inmutables y colecciones sin repetidos.', '', 0),
  (12, 3, 12, 'Diccionarios', '🗂️', 'Guardar información con clave y valor.', '', 0),
  (13, 3, 13, 'Comprehensions', '⚡', 'Crear listas, sets y diccionarios en una sola línea.', '', 0),

  (14, 4, 14, 'Funciones', '🧰', 'Empaquetar lógica para reutilizarla.', '', 0),
  (15, 4, 15, 'Errores y excepciones', '🛡️', 'try, except, finally y errores propios.', '', 0),
  (16, 4, 16, 'Módulos, pip y entornos virtuales', '📚', 'Organizar el proyecto y usar librerías externas.', '', 0),
  (17, 4, 17, 'Archivos (txt, csv, json)', '📁', 'Leer y escribir datos en disco.', '', 0),

  (18, 5, 18, 'Clases y objetos', '🏛️', 'Modelar el mundo con atributos y métodos.', '', 0),
  (19, 5, 19, 'Herencia y métodos especiales', '🧬', 'Reutilizar clases y personalizar su comportamiento.', '', 0),

  (20, 6, 20, 'Proyecto integrador: Sistema Bancario', '🏗️', 'Todo lo aprendido en una sola aplicación.', '', 0),
  (21, 6, 21, 'SQL desde cero', '🗄️', 'Bases de datos relacionales y consultas desde Python.', '', 0),
  (22, 6, 22, 'Pandas y datos', '🐼', 'Cargar, limpiar y analizar datos reales.', '', 0),
  (23, 6, 23, 'IA aplicada con Python', '🤖', 'Consumir modelos y construir algo útil con ellos.', '', 0),
  (24, 6, 24, 'APIs con FastAPI y despliegue', '🚀', 'Publicar tu propio backend en internet.', '', 0);

-- ---------------------------------------------------------------------------
--  CAPÍTULO 1 — ¿Qué es programar?
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO chapters (id, part_id, number, title, emoji, description, content_html, published) VALUES
(1, 1, 1, '¿Qué es programar?', '🐍',
 'La idea más importante del libro: darle instrucciones exactas a una máquina.',
'<h2>Programar es dar instrucciones</h2>
<p>Un computador no adivina. Hace <strong>exactamente</strong> lo que le pides, en el orden en que se lo pides. Programar es escribir esa lista de instrucciones en un idioma que la máquina entienda. En este libro ese idioma es <strong>Python</strong>.</p>
<p>Piensa en una receta de cocina. Si escribes <em>"echar el huevo"</em> sin decir antes <em>"romper el huevo"</em>, terminas con cáscara en la sartén. El computador es igual de literal, pero mucho más rápido y nunca se cansa.</p>
<h3>¿Por qué Python?</h3>
<ul>
  <li>Se lee casi como inglés, así que estorba poco mientras aprendes a pensar.</li>
  <li>Sirve para web, datos, automatización, inteligencia artificial y videojuegos.</li>
  <li>Tiene la comunidad más grande del mundo: casi cualquier duda ya la respondió alguien.</li>
</ul>

<h2>Tu primer programa</h2>
<p>La instrucción <code>print()</code> muestra algo en pantalla. Lo que va entre paréntesis es el <strong>argumento</strong>: el dato con el que trabaja la instrucción.</p>
<pre><code>print("Hola, mundo")
print("Estoy aprendiendo Python con JuanCode")</code></pre>
<p>Si ejecutas eso, verás dos líneas de texto. El texto entre comillas se llama <strong>string</strong> (cadena de caracteres). Las comillas no se imprimen: solo le indican a Python dónde empieza y dónde termina el texto.</p>
<h3>Un detalle que cuesta caro</h3>
<p>Python distingue mayúsculas de minúsculas y le importan los paréntesis. Todo esto está mal:</p>
<pre><code>Print("Hola")     # mal: Print con P mayúscula no existe
print "Hola"      # mal: faltan los paréntesis
print("Hola"      # mal: falta cerrar el paréntesis</code></pre>
<p>No te asustes con los errores: son mensajes, no regaños. Leerlos es parte del oficio.</p>

<h2>Comentarios: notas para humanos</h2>
<p>Todo lo que va después de <code>#</code> lo ignora Python. Sirve para explicarle a tu yo del futuro qué estabas pensando.</p>
<pre><code># Este programa saluda al estudiante
print("Bienvenido al Libro JuanCode")  # esto también es comentario</code></pre>
<table>
  <thead>
    <tr><th>Elemento</th><th>Para qué sirve</th></tr>
  </thead>
  <tbody>
    <tr><td><code>print()</code></td><td>Mostrar información en pantalla</td></tr>
    <tr><td><code>"texto"</code></td><td>Un string: texto entre comillas</td></tr>
    <tr><td><code>#</code></td><td>Comentario: Python lo ignora</td></tr>
  </tbody>
</table>
<blockquote>Programar no es memorizar comandos. Es aprender a partir un problema grande en pasos tan pequeños que hasta una máquina los pueda seguir.</blockquote>',
 1);

INSERT OR IGNORE INTO exercises (id, chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html) VALUES
(1, 1, 1, 'Preséntate en pantalla', 'facil',
 '<p>Escribe un programa que imprima <strong>tres líneas</strong>: tu nombre, tu ciudad y una razón por la que quieres aprender a programar.</p>',
 '<p>Necesitas tres llamadas a <code>print()</code>, una debajo de la otra. Cada una imprime su propia línea.</p>',
 '<pre><code>print("Me llamo Ana")
print("Vivo en Bogotá")
print("Quiero aprender a programar para automatizar mi trabajo")</code></pre>'),

(2, 1, 2, 'Caza el error', 'medio',
 '<p>Este programa no corre. Encuentra los <strong>tres</strong> errores y escríbelo bien.</p><pre><code>Print("Inicio")
print("Mitad"
print Fin)</code></pre>',
 '<p>Revisa: mayúsculas en el nombre de la instrucción, paréntesis que no cierran y texto sin comillas.</p>',
 '<pre><code>print("Inicio")
print("Mitad")
print("Fin")</code></pre><p>Errores: <code>Print</code> con mayúscula, el paréntesis sin cerrar en la segunda línea, y <code>Fin</code> sin comillas ni paréntesis correctos.</p>');

INSERT OR IGNORE INTO quizzes (id, chapter_id, passing_score) VALUES (1, 1, 80);

INSERT OR IGNORE INTO questions (id, quiz_id, orden, prompt, code_snippet) VALUES
(1, 1, 1, '¿Qué es programar, en una frase?', NULL),
(2, 1, 2, '¿Qué imprime este programa?', 'print("Hola")
print("JuanCode")'),
(3, 1, 3, '¿Cuál de estas líneas está escrita correctamente?', NULL),
(4, 1, 4, '¿Qué hace Python con esta línea?', '# print("Hola")'),
(5, 1, 5, '¿Por qué el texto va entre comillas en print("Hola")?', NULL);

INSERT OR IGNORE INTO options (id, question_id, label, text, is_correct) VALUES
(1,  1, 'a', 'Escribir instrucciones exactas para que una máquina las ejecute en orden', 1),
(2,  1, 'b', 'Memorizar todos los comandos de un lenguaje', 0),
(3,  1, 'c', 'Reparar computadores que fallan', 0),
(4,  1, 'd', 'Diseñar la parte visual de una página web', 0),

(5,  2, 'a', 'Una sola línea: HolaJuanCode', 0),
(6,  2, 'b', 'Dos líneas: Hola y luego JuanCode', 1),
(7,  2, 'c', 'Nada, porque falta un punto y coma', 0),
(8,  2, 'd', 'Un error, porque hay dos print seguidos', 0),

(9,  3, 'a', 'Print("Hola")', 0),
(10, 3, 'b', 'print "Hola"', 0),
(11, 3, 'c', 'print("Hola")', 1),
(12, 3, 'd', 'print(Hola)', 0),

(13, 4, 'a', 'La ejecuta e imprime Hola', 0),
(14, 4, 'b', 'La ignora por completo, es un comentario', 1),
(15, 4, 'c', 'Lanza un error de sintaxis', 0),
(16, 4, 'd', 'La ejecuta pero sin mostrar nada', 0),

(17, 5, 'a', 'Porque las comillas hacen el texto más legible', 0),
(18, 5, 'b', 'Porque le indican a Python dónde empieza y termina el texto', 1),
(19, 5, 'c', 'Porque sin comillas el texto se imprime en mayúsculas', 0),
(20, 5, 'd', 'Porque print solo acepta comillas dobles por decoración', 0);

-- ---------------------------------------------------------------------------
--  CAPÍTULO 2 — Variables y tipos de datos
-- ---------------------------------------------------------------------------
INSERT OR IGNORE INTO chapters (id, part_id, number, title, emoji, description, content_html, published) VALUES
(2, 1, 2, 'Variables y tipos de datos', '📦',
 'Cajas con nombre para guardar información, y los tipos básicos de Python.',
'<h2>Una variable es una caja con nombre</h2>
<p>Una <strong>variable</strong> guarda un dato para usarlo después. Se crea con el signo <code>=</code>: a la izquierda el nombre, a la derecha el valor.</p>
<pre><code>nombre = "Ana"
edad = 17
promedio = 4.5

print(nombre)
print(edad)</code></pre>
<p>El <code>=</code> aquí <strong>no</strong> significa "es igual a" como en matemáticas. Significa "guarda esto acá". Por eso esta línea tiene todo el sentido del mundo:</p>
<pre><code>contador = 0
contador = contador + 1   # ahora contador vale 1</code></pre>
<h3>Reglas para los nombres</h3>
<ul>
  <li>Solo letras, números y guion bajo. No pueden empezar por número.</li>
  <li>Sin espacios: se usa <code>snake_case</code>, como <code>nota_final</code>.</li>
  <li>Que digan qué guardan: <code>edad</code> le gana a <code>x</code> siempre.</li>
</ul>

<h2>Los cuatro tipos básicos</h2>
<p>Python decide el tipo solo, mirando el valor que le diste.</p>
<table>
  <thead>
    <tr><th>Tipo</th><th>Qué guarda</th><th>Ejemplo</th></tr>
  </thead>
  <tbody>
    <tr><td><code>str</code></td><td>Texto</td><td><code>"Bogotá"</code></td></tr>
    <tr><td><code>int</code></td><td>Números enteros</td><td><code>17</code></td></tr>
    <tr><td><code>float</code></td><td>Números con decimales</td><td><code>4.5</code></td></tr>
    <tr><td><code>bool</code></td><td>Verdadero o falso</td><td><code>True</code></td></tr>
  </tbody>
</table>
<p>Ojo: <code>True</code> y <code>False</code> van con mayúscula inicial. Y <code>"17"</code> con comillas es texto, no número.</p>
<pre><code>print(type("Bogotá"))   # str
print(type(17))          # int
print(type(4.5))         # float
print(type(True))        # bool</code></pre>

<h2>El tipo importa</h2>
<p>El mismo símbolo <code>+</code> hace cosas distintas según el tipo:</p>
<pre><code>print(2 + 3)          # 5     -> suma
print("2" + "3")      # 23    -> pega los textos
print("Hola " + "Ana")  # Hola Ana</code></pre>
<p>Y mezclar tipos incompatibles revienta:</p>
<pre><code>print("Edad: " + 17)   # TypeError</code></pre>
<p>La solución es convertir. <code>str()</code>, <code>int()</code> y <code>float()</code> transforman de un tipo a otro:</p>
<pre><code>edad = 17
print("Edad: " + str(edad))   # Edad: 17

texto = "25"
print(int(texto) + 5)         # 30</code></pre>
<h3>El atajo: f-strings</h3>
<p>Poniendo una <code>f</code> antes de las comillas puedes meter variables dentro del texto con llaves. Es la forma moderna y la que vas a usar el resto del libro.</p>
<pre><code>nombre = "Ana"
edad = 17
print(f"{nombre} tiene {edad} años")   # Ana tiene 17 años</code></pre>
<blockquote>Regla de oro: si vas a mostrarlo, es texto. Si vas a hacer cuentas con eso, es número. Convierte cuando cruces de un lado al otro.</blockquote>',
 1);

INSERT OR IGNORE INTO exercises (id, chapter_id, orden, title, difficulty, statement_html, hint_html, solution_html) VALUES
(3, 2, 1, 'Tu ficha personal', 'facil',
 '<p>Crea tres variables: <code>nombre</code> (texto), <code>edad</code> (entero) y <code>estatura</code> (decimal). Luego imprime una sola línea que diga: <em>Ana tiene 17 años y mide 1.62 metros</em>, usando una f-string.</p>',
 '<p>La f-string va así: <code>f"{variable} texto {otra}"</code>. No necesitas <code>str()</code> dentro de una f-string.</p>',
 '<pre><code>nombre = "Ana"
edad = 17
estatura = 1.62

print(f"{nombre} tiene {edad} años y mide {estatura} metros")</code></pre>'),

(4, 2, 2, 'La calculadora que se rompió', 'medio',
 '<p>Este programa quiere sumar dos números, pero imprime <code>1020</code> en vez de <code>30</code>. Explica por qué y arréglalo.</p><pre><code>a = "10"
b = "20"
print(a + b)</code></pre>',
 '<p>Fíjate en las comillas: <code>a</code> y <code>b</code> no son números, son texto. Con strings el <code>+</code> pega en vez de sumar.</p>',
 '<p>Como <code>a</code> y <code>b</code> son <code>str</code>, el <code>+</code> los concatena. Hay dos arreglos válidos:</p><pre><code># 1) quitar las comillas
a = 10
b = 20
print(a + b)        # 30

# 2) convertir a entero al usarlos
a = "10"
b = "20"
print(int(a) + int(b))   # 30</code></pre>');

INSERT OR IGNORE INTO quizzes (id, chapter_id, passing_score) VALUES (2, 2, 80);

INSERT OR IGNORE INTO questions (id, quiz_id, orden, prompt, code_snippet) VALUES
(6,  2, 1, '¿Qué imprime este programa?', 'x = 5
x = x + 3
print(x)'),
(7,  2, 2, '¿De qué tipo es la variable precio?', 'precio = "1990"'),
(8,  2, 3, '¿Cuál de estos nombres de variable es válido en Python?', NULL),
(9,  2, 4, '¿Qué pasa al ejecutar esta línea?', 'edad = 17
print("Edad: " + edad)'),
(10, 2, 5, '¿Cuál es la forma moderna de armar el mensaje "Ana tiene 17 años"?', NULL);

INSERT OR IGNORE INTO options (id, question_id, label, text, is_correct) VALUES
(21, 6, 'a', '5', 0),
(22, 6, 'b', '8', 1),
(23, 6, 'c', '53', 0),
(24, 6, 'd', 'Error, no se puede usar x en su propia asignación', 0),

(25, 7, 'a', 'int, porque solo tiene dígitos', 0),
(26, 7, 'b', 'float, porque representa dinero', 0),
(27, 7, 'c', 'str, porque está entre comillas', 1),
(28, 7, 'd', 'bool, porque tiene un valor definido', 0),

(29, 8, 'a', '2do_intento', 0),
(30, 8, 'b', 'nota final', 0),
(31, 8, 'c', 'nota_final', 1),
(32, 8, 'd', 'nota-final', 0),

(33, 9, 'a', 'Imprime "Edad: 17"', 0),
(34, 9, 'b', 'Lanza un TypeError: no se puede sumar str con int', 1),
(35, 9, 'c', 'Imprime "Edad: " y luego 17 en otra línea', 0),
(36, 9, 'd', 'Convierte edad a texto automáticamente', 0),

(37, 10, 'a', 'print(f"{nombre} tiene {edad} años")', 1),
(38, 10, 'b', 'print(nombre + " tiene " + edad + " años")', 0),
(39, 10, 'c', 'print("{nombre} tiene {edad} años")', 0),
(40, 10, 'd', 'print(nombre, "tiene", edad, "años", f)', 0);
