-- ============================================================
-- Sistema de reservas de pistas de pádel
-- ============================================================

-- Necesitamos esta extensión porque vamos a usar una restricción EXCLUDE
-- con un campo normal, pista_id, y un rango de fechas.
--
-- btree_gist permite usar operadores como "=" dentro de índices GiST.
CREATE EXTENSION IF NOT EXISTS btree_gist;


-- ============================================================
-- 1. Tabla de pistas
-- ============================================================
-- Guarda las pistas disponibles para reservar.
--
-- Reglas:
-- - Cada pista tiene un número.
-- - El número no puede repetirse.
-- - El tipo solo puede ser 'cubierta' o 'exterior'.

CREATE TABLE pistas (
  id serial PRIMARY KEY,

  -- Número visible de la pista: 1, 2, 3...
  -- UNIQUE impide que existan dos pistas con el mismo número.
  numero int NOT NULL UNIQUE,

  -- Tipo de pista.
  -- CHECK limita los valores posibles.
  tipo text NOT NULL CHECK (tipo IN ('cubierta', 'exterior'))
);


-- ============================================================
-- 2. Tabla de usuarios
-- ============================================================
-- Guarda los usuarios que pueden reservar pistas.
--
-- Reglas:
-- - El email debe ser único.
-- - El nivel solo puede tener ciertos valores.

CREATE TABLE usuarios (
  id serial PRIMARY KEY,

  -- Nombre obligatorio del usuario.
  nombre text NOT NULL,

  -- Email obligatorio y único.
  -- UNIQUE evita usuarios duplicados con el mismo email.
  email text NOT NULL UNIQUE,

  -- Nivel del jugador.
  -- DEFAULT pone 'principiante' si no se indica otro valor.
  nivel text NOT NULL DEFAULT 'principiante'
    CHECK (nivel IN ('principiante', 'intermedio', 'avanzado'))
);


-- ============================================================
-- 3. Tabla de reservas
-- ============================================================
-- Guarda cada reserva de una pista por parte de un usuario.
--
-- Reglas:
-- - Cada reserva pertenece a un usuario.
-- - Cada reserva pertenece a una pista.
-- - Tiene hora de inicio y hora de fin.
-- - Puede estar 'confirmada' o 'cancelada'.
-- - Si se elimina el usuario, sus reservas se eliminan también.
-- - No puede haber dos reservas confirmadas solapadas para la misma pista.

CREATE TABLE reservas (
  id serial PRIMARY KEY,

  -- Usuario que hace la reserva.
  -- REFERENCES usuarios(id) crea una clave foránea.
  -- ON DELETE CASCADE significa:
  -- si se borra el usuario, se borran también sus reservas.
  usuario_id int NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,

  -- Pista reservada.
  -- Debe existir previamente en la tabla pistas.
  pista_id int NOT NULL REFERENCES pistas(id),

  -- Hora de inicio de la reserva.
  inicio timestamptz NOT NULL,

  -- Hora de finalización de la reserva.
  fin timestamptz NOT NULL,

  -- Estado de la reserva.
  -- Por defecto, una nueva reserva queda confirmada.
  estado text NOT NULL DEFAULT 'confirmada'
    CHECK (estado IN ('confirmada', 'cancelada')),

  -- Esta regla evita reservas sin sentido,
  -- por ejemplo una reserva que termina antes de empezar.
  CHECK (fin > inicio),

  -- Restricción avanzada:
  -- Evita que dos reservas de la misma pista se solapen en el tiempo.
  --
  -- pista_id WITH =
  -- significa: compara reservas de la misma pista.
  --
  -- tstzrange(inicio, fin) WITH &&
  -- significa: compara si los rangos de tiempo se solapan.
  --
  -- WHERE (estado != 'cancelada')
  -- significa: las reservas canceladas no bloquean la pista.
  CONSTRAINT sin_solapamiento_pista EXCLUDE USING gist (
    pista_id WITH =,
    tstzrange(inicio, fin) WITH &&
  )
  WHERE (estado != 'cancelada')
);


-- ============================================================
-- 4. Tabla de notificaciones
-- ============================================================
-- Guarda avisos generados automáticamente por la base de datos.
--
-- En este caso, cuando se crea una reserva confirmada,
-- insertaremos una notificación.

CREATE TABLE notificaciones (
  id serial PRIMARY KEY,

  -- Usuario al que pertenece la notificación.
  -- Si el usuario se borra, también borramos sus notificaciones.
  usuario_id int REFERENCES usuarios(id) ON DELETE CASCADE,

  -- Texto de la notificación.
  mensaje text NOT NULL,

  -- Fecha de creación automática.
  creado_en timestamptz NOT NULL DEFAULT now()
);


-- ============================================================
-- 5. Función trigger
-- ============================================================
-- Esta función se ejecutará automáticamente cuando se inserte
-- una nueva reserva.
--
-- Si la reserva está confirmada, crea una notificación.

CREATE OR REPLACE FUNCTION notificar_reserva_confirmada()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  -- NEW representa la nueva fila insertada en la tabla reservas.
  --
  -- Solo queremos notificar si la reserva está confirmada.
  -- Si está cancelada, no hacemos nada.
  IF NEW.estado = 'confirmada' THEN
    INSERT INTO notificaciones (usuario_id, mensaje)
    VALUES (NEW.usuario_id, 'Nueva reserva confirmada');
  END IF;

  -- En un trigger AFTER INSERT devolvemos NEW
  -- para indicar que todo ha ido correctamente.
  RETURN NEW;
END;
$$;


-- ============================================================
-- 6. Trigger
-- ============================================================
-- Este trigger conecta la tabla reservas con la función anterior.
--
-- Significa:
-- después de insertar una fila en reservas,
-- ejecuta la función notificar_reserva_confirmada().

CREATE TRIGGER trigger_notificar_reserva_confirmada
AFTER INSERT ON reservas
FOR EACH ROW
EXECUTE FUNCTION notificar_reserva_confirmada();