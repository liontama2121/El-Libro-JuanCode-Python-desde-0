-- Generado por scripts/build-peliculas.mjs — NO editar a mano.
-- Fuente: content/peliculas.json
-- Verificado contra Python real con scripts/verify-traces.py

-- Capítulo 7 · 1. El contador — la película del while
INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)
SELECT id, 1, 'El contador — la película del while', 'Mira cómo contador nace afuera, se evalúa arriba y se actualiza adentro.', 'contador = 1
while contador <= 5:
    print(contador)
    contador = contador + 1
print("Termine")', '["Vuelta","contador","¿contador ≤ 5?","imprime"]', '[{"cells":["antes","1 (nace)","—","—"],"out":"","hl":null},{"cells":["1","1","✅ SÍ entra","1"],"out":"1\n","hl":3},{"cells":["2","2","✅ SÍ entra","2"],"out":"2\n","hl":3},{"cells":["3","3","✅ SÍ entra","3"],"out":"3\n","hl":3},{"cells":["4","4","✅ SÍ entra","4"],"out":"4\n","hl":3},{"cells":["5","5","✅ SÍ entra","5"],"out":"5\n","hl":3},{"cells":["—","6","❌ NO entra","Termine"],"out":"Termine\n","hl":3}]', 1
FROM chapters WHERE number = 7 AND track = 'basico'
ON CONFLICT(chapter_id, orden) DO UPDATE SET
  title = excluded.title,
  description = excluded.description,
  code = excluded.code,
  columns_json = excluded.columns_json,
  steps_json = excluded.steps_json,
  active = excluded.active;

-- Capítulo 7 · 2. La sumatoria con while
INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)
SELECT id, 2, 'La sumatoria con while', 's guarda el total y i cuenta las vueltas: dos variables distintas, cada una con su trabajo.', 'n = 5
s = 0
i = 1
while i <= n:
    s = s + i
    i = i + 1
print(s)', '["Vuelta","i","¿i ≤ 5?","s queda","i queda"]', '[{"cells":["antes","1","—","0","1"],"out":"","hl":null},{"cells":["1","1","✅ SÍ","0 + 1 = 1","2"],"out":"","hl":3},{"cells":["2","2","✅ SÍ","1 + 2 = 3","3"],"out":"","hl":3},{"cells":["3","3","✅ SÍ","3 + 3 = 6","4"],"out":"","hl":3},{"cells":["4","4","✅ SÍ","6 + 4 = 10","5"],"out":"","hl":3},{"cells":["5","5","✅ SÍ","10 + 5 = 15","6"],"out":"","hl":3},{"cells":["—","6","❌ NO","15","6"],"out":"15\n","hl":3}]', 1
FROM chapters WHERE number = 7 AND track = 'basico'
ON CONFLICT(chapter_id, orden) DO UPDATE SET
  title = excluded.title,
  description = excluded.description,
  code = excluded.code,
  columns_json = excluded.columns_json,
  steps_json = excluded.steps_json,
  active = excluded.active;

-- Capítulo 7 · 3. El PIN — la actualización con input
INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)
SELECT id, 3, 'El PIN — la actualización con input', 'Si el while no cambia lo que evalúa, no para nunca: aquí lo que cambia es lo que escribe el usuario.', 'pin = ""
while pin != "1234":
    pin = input("PIN: ")
print("Bienvenido")', '["Evaluación","pin vale","¿pin != \"1234\"?","qué pasa"]', '[{"cells":["1ª","\"\" (vacío)","✅ True","pregunta el PIN → el usuario escribe 0000"],"out":"PIN: ","hl":3},{"cells":["2ª","\"0000\"","✅ True","vuelve a preguntar → el usuario escribe 1234"],"out":"PIN: ","hl":3},{"cells":["3ª","\"1234\"","❌ False","sale del while e imprime"],"out":"Bienvenido\n","hl":3}]', 1
FROM chapters WHERE number = 7 AND track = 'basico'
ON CONFLICT(chapter_id, orden) DO UPDATE SET
  title = excluded.title,
  description = excluded.description,
  code = excluded.code,
  columns_json = excluded.columns_json,
  steps_json = excluded.steps_json,
  active = excluded.active;

-- Capítulo 8 · 1. ¿Quién es i?
INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)
SELECT id, 1, '¿Quién es i?', 'range fabrica los números y el for te los va entregando uno por uno.', 'for i in range(3):
    print("Vuelta", i)', '["Paso","range entrega","i vale","imprime"]', '[{"cells":["preparación","0, 1, 2","— todavía nada","—"],"out":"","hl":null},{"cells":["1","0","0","Vuelta 0"],"out":"Vuelta 0\n","hl":3},{"cells":["2","1","1","Vuelta 1"],"out":"Vuelta 1\n","hl":3},{"cells":["3","2","2","Vuelta 2"],"out":"Vuelta 2\n","hl":3},{"cells":["fin","ya no queda nada","2 (el último)","—"],"out":"","hl":null}]', 1
FROM chapters WHERE number = 8 AND track = 'basico'
ON CONFLICT(chapter_id, orden) DO UPDATE SET
  title = excluded.title,
  description = excluded.description,
  code = excluded.code,
  columns_json = excluded.columns_json,
  steps_json = excluded.steps_json,
  active = excluded.active;

-- Capítulo 8 · 2. El acumulador — la película de Gauss
INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)
SELECT id, 2, 'El acumulador — la película de Gauss', 'suma nace afuera en 0 y adentro solo se actualiza: por eso al final vale 15.', 'suma = 0
for numero in range(1, 6):
    suma = suma + numero
print(suma)', '["Vuelta","numero","suma antes","suma después"]', '[{"cells":["antes","—","—","0"],"out":"","hl":null},{"cells":["1","1","0","1"],"out":"","hl":3},{"cells":["2","2","1","3"],"out":"","hl":3},{"cells":["3","3","3","6"],"out":"","hl":3},{"cells":["4","4","6","10"],"out":"","hl":3},{"cells":["5","5","10","15"],"out":"","hl":3},{"cells":["fin","se acabó el range","15","15"],"out":"15\n","hl":3}]', 1
FROM chapters WHERE number = 8 AND track = 'basico'
ON CONFLICT(chapter_id, orden) DO UPDATE SET
  title = excluded.title,
  description = excluded.description,
  code = excluded.code,
  columns_json = excluded.columns_json,
  steps_json = excluded.steps_json,
  active = excluded.active;

-- Capítulo 8 · 3. El contador con filtro
INSERT INTO trace_demos (chapter_id, orden, title, description, code, columns_json, steps_json, active)
SELECT id, 3, 'El contador con filtro', 'El for pasa por todos, pero solo suma cuando el if dice que sí.', 'pares = 0
for numero in range(1, 7):
    if numero % 2 == 0:
        pares = pares + 1
print("Pares:", pares)', '["numero","¿par?","pares queda"]', '[{"cells":["antes del for","—","0"],"out":"","hl":null},{"cells":["1","❌ no","0"],"out":"","hl":null},{"cells":["2","✅ sí","1"],"out":"","hl":2},{"cells":["3","❌ no","1"],"out":"","hl":null},{"cells":["4","✅ sí","2"],"out":"","hl":2},{"cells":["5","❌ no","2"],"out":"","hl":null},{"cells":["6","✅ sí","3"],"out":"","hl":2},{"cells":["fin","—","3"],"out":"Pares: 3\n","hl":2}]', 1
FROM chapters WHERE number = 8 AND track = 'basico'
ON CONFLICT(chapter_id, orden) DO UPDATE SET
  title = excluded.title,
  description = excluded.description,
  code = excluded.code,
  columns_json = excluded.columns_json,
  steps_json = excluded.steps_json,
  active = excluded.active;
