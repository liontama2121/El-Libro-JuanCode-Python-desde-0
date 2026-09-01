-- ============================================================================
--  Migración de las preguntas viejas (questions + options) al BANCO
--
--  El quiz del capítulo ahora saca 5 preguntas aleatorias de question_bank,
--  así que las preguntas que ya existían tienen que vivir ahí. Se pueden
--  volver a ejecutar sin duplicar: el WHERE NOT EXISTS compara capítulo +
--  enunciado.
--
--  Es una migración de UNA SOLA VEZ para instalaciones que venían del formato
--  viejo. En una base nueva no encuentra nada que migrar y no hace nada.
--    npm run db:seed:local     (lo ejecuta antes del contenido)
-- ============================================================================

INSERT INTO question_bank (
  chapter_id, type, difficulty, prompt, code_snippet,
  data_json, correct_json, explanation, active
)
SELECT
  qz.chapter_id,
  'mcq',
  'facil',
  q.prompt,
  q.code_snippet,
  json_object(
    'options',
    (SELECT json_group_array(json_object('id', o.label, 'text', o.text))
       FROM (SELECT label, text FROM options
              WHERE question_id = q.id
              ORDER BY label) o)
  ),
  json_object(
    'option_id',
    (SELECT label FROM options WHERE question_id = q.id AND is_correct = 1 LIMIT 1)
  ),
  '',
  1
FROM questions q
JOIN quizzes qz ON qz.id = q.quiz_id
WHERE EXISTS (SELECT 1 FROM options o WHERE o.question_id = q.id AND o.is_correct = 1)
  AND NOT EXISTS (
    SELECT 1 FROM question_bank b
     WHERE b.chapter_id = qz.chapter_id
       AND b.prompt = q.prompt
  );
