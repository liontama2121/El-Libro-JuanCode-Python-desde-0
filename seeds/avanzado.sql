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

-- ── Capítulo 1: Setup DOMjudge (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 1, 'Setup DOMjudge', '⚙️', 'Leer hasta EOF y responder casos múltiples como los pide el juez.', '', 0, 'avanzado'
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 1 AND track = 'avanzado');

-- ── Capítulo 2: Strings avanzados (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 2, 'Strings avanzados', '🔤', 'split, join e indexado por posición sobre varias líneas.', '', 0, 'avanzado'
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 2 AND track = 'avanzado');

-- ── Capítulo 3: Matrices y vecinos (borrador)
INSERT INTO chapters (part_id, number, title, emoji, description, content_html, published, track)
  SELECT p.id, 3, 'Matrices y vecinos', '🗺️', 'Listas de listas y el recorrido de las 8 direcciones.', '', 0, 'avanzado'
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
DELETE FROM question_bank WHERE source = 'seed' AND chapter_id = (SELECT id FROM chapters WHERE number = 3 AND track = 'avanzado');

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

