-- 1. Leer notas públicas
CREATE POLICY "autenticado: ver notas públicas"
  ON public.notas FOR SELECT
  USING (
    auth.role() = 'authenticated'
    AND publica = true
  );

-- 2. El autor lee y borra sus propias notas (incluso privadas)
CREATE POLICY "autor: acceso total a sus notas"
  ON public.notas FOR SELECT
  USING ( autor_id = auth.uid() );

CREATE POLICY "autor: borrar sus notas"
  ON public.notas FOR DELETE
  USING ( autor_id = auth.uid() );

-- 3. El autor puede editar su nota, pero no cambiar quién es el autor
CREATE POLICY "autor: editar sus notas"
  ON public.notas FOR UPDATE
  USING ( autor_id = auth.uid() )
  WITH CHECK ( autor_id = auth.uid() );  -- el autor_id debe seguir siendo el suyo