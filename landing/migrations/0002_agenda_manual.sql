-- La agenda deja de ser autoservicio: ahora Juan marca a mano qué horas
-- están ocupadas, y la página muestra el resto como libres.

CREATE TABLE IF NOT EXISTS ocupados (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    fecha       TEXT NOT NULL,            -- YYYY-MM-DD (hora Colombia)
    hora_inicio INTEGER,                  -- NULL = el día completo
    motivo      TEXT NOT NULL DEFAULT '',
    created_at  INTEGER NOT NULL DEFAULT 0
);

-- Lo que ya estaba bloqueado sigue estándolo
INSERT INTO ocupados (fecha, hora_inicio, motivo)
SELECT fecha, hora_inicio, motivo FROM blocked_slots;

DROP TABLE blocked_slots;

-- Se van las reservas con pago: ya no hay formulario que las cree
DROP TABLE bookings;

CREATE INDEX IF NOT EXISTS ocupados_fecha_idx ON ocupados (fecha);

-- Una misma hora no se marca dos veces (NULL cuenta como valor propio)
CREATE UNIQUE INDEX IF NOT EXISTS ocupados_unico
    ON ocupados (fecha, IFNULL(hora_inicio, -1));
