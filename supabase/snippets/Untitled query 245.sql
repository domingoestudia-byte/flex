CREATE TABLE productos (
  id          serial PRIMARY KEY,
  nombre      text NOT NULL,
  stock       int NOT NULL DEFAULT 0,
  actualizado timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE movimientos_stock (
  id          serial PRIMARY KEY,
  producto_id int REFERENCES productos(id),
  cambio      int NOT NULL,        -- positivo = entrada, negativo = salida
  motivo      text,
  creado_en   timestamptz NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION aplicar_movimiento_stock()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE productos
  SET
    stock       = stock + NEW.cambio,
    actualizado = now()
  WHERE id = NEW.producto_id;

  RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_movimiento_stock
  AFTER INSERT ON movimientos_stock
  FOR EACH ROW
  EXECUTE FUNCTION aplicar_movimiento_stock();

-- Probar:
INSERT INTO productos (nombre, stock) VALUES ('Cerveza', 100);
INSERT INTO movimientos_stock (producto_id, cambio, motivo) VALUES (1, -5, 'venta');