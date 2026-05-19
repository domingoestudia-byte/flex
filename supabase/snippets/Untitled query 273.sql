CREATE OR REPLACE FUNCTION clasificar_reserva(horas numeric)
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
  resultado text;
BEGIN
  IF horas < 2 THEN
    resultado := 'corta';
  ELSIF horas <= 4 THEN
    resultado := 'normal';
  ELSE
    resultado := 'larga';
  END IF;

  RETURN resultado;
END;
$$;

-- Probar:
SELECT clasificar_reserva(1);    -- 'corta'
SELECT clasificar_reserva(2);    -- 'normal'
SELECT clasificar_reserva(4);    -- 'normal'
SELECT clasificar_reserva(5.5);  -- 'larga'