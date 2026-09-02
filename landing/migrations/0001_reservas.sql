-- Sistema de reservas de JuanCode

CREATE TABLE IF NOT EXISTS bookings (
    id                  TEXT PRIMARY KEY,
    created_at          INTEGER NOT NULL,
    fecha               TEXT NOT NULL,          -- YYYY-MM-DD (hora Colombia)
    hora_inicio         INTEGER NOT NULL,       -- 18 | 19 | 20 | 21 | 22
    nombre              TEXT NOT NULL,
    email               TEXT NOT NULL,
    whatsapp            TEXT NOT NULL,
    carrera_universidad TEXT NOT NULL,
    tema                TEXT NOT NULL DEFAULT '',
    referencia_pago     TEXT NOT NULL,
    comprobante_key     TEXT NOT NULL,          -- key del objeto en R2
    estado              TEXT NOT NULL DEFAULT 'pendiente',  -- pendiente | confirmada | rechazada
    notas_admin         TEXT NOT NULL DEFAULT ''
);

CREATE INDEX IF NOT EXISTS bookings_fecha_idx ON bookings (fecha, hora_inicio);
CREATE INDEX IF NOT EXISTS bookings_estado_idx ON bookings (estado, fecha);

-- Dos personas no pueden tener el mismo cupo. Es un índice parcial: una
-- reserva rechazada libera el slot, y la base lo hace cumplir aunque dos
-- envíos lleguen en el mismo milisegundo.
CREATE UNIQUE INDEX IF NOT EXISTS bookings_slot_unico
    ON bookings (fecha, hora_inicio)
    WHERE estado IN ('pendiente', 'confirmada');

CREATE TABLE IF NOT EXISTS blocked_slots (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    fecha       TEXT NOT NULL,
    hora_inicio INTEGER,                        -- NULL = el día completo
    motivo      TEXT NOT NULL DEFAULT ''
);

CREATE INDEX IF NOT EXISTS blocked_fecha_idx ON blocked_slots (fecha);

-- Un mismo bloqueo no se repite (hora_inicio NULL cuenta como valor propio)
CREATE UNIQUE INDEX IF NOT EXISTS blocked_unico
    ON blocked_slots (fecha, IFNULL(hora_inicio, -1));

-- Freno anti-abuso: 5 envíos por hora por IP
CREATE TABLE IF NOT EXISTS rate_limit (
    ip         TEXT NOT NULL,
    created_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS rate_limit_idx ON rate_limit (ip, created_at);
