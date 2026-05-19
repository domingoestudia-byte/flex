-- CREATE TABLE productos (
--   id     serial PRIMARY KEY,
--   nombre text NOT NULL,
--   stock  int NOT NULL DEFAULT 0
-- );

-- CREATE OR REPLACE FUNCTION validar_stock()
-- RETURNS trigger
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   -- NEW contiene los nuevos valores que se van a guardar
--   IF NEW.stock < 0 THEN
--     RAISE EXCEPTION 'El stock no puede ser negativo. Valor intentado: %', NEW.stock;
--   END IF;

--   RETURN NEW;  -- si pasa la validación, dejamos que el UPDATE continúe
-- END;
-- $$;

-- CREATE TRIGGER trigger_validar_stock
--   BEFORE UPDATE ON productos
--   FOR EACH ROW
--   EXECUTE FUNCTION validar_stock();

-- -- Probar:
-- INSERT INTO productos (nombre, stock) VALUES ('Cerveza', 10);
-- UPDATE productos SET stock = 5 WHERE id = 1;   -- OK: 5 >= 0
UPDATE productos SET stock = -3 WHERE id = 1;  -- ERROR: El stock no puede ser negativo