-- Ejemplo AFTER: registrar en un log después de borrar
CREATE OR REPLACE FUNCTION registrar_total()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO log_borrados (tabla, fila_id, borrado_en)
  VALUES ('empleados', OLD.id, now());
  RETURN OLD;
END;
$$;

CREATE TRIGGER trigger_log_borrado
  AFTER DELETE ON empleados
  FOR EACH ROW
  EXECUTE FUNCTION registrar_borrado();

  enes una tabla pedidos con una columna total numeric. Quieres que el total se calcule automáticamente al insertar el pedido, multiplicando precio_unitario * cantidad.

¿Deberías usar un trigger BEFORE INSERT o AFTER INSERT? Escribe la función trigger.