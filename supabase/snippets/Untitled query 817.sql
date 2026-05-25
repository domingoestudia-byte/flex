CREATE OR REPLACE FUNCTION public.mi_rol()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
AS $$
  SELECT rol FROM public.perfiles WHERE id = auth.uid()
$$;

-- Política: solo publicadores pueden borrar artículos
CREATE POLICY "publicador: borrar artículos"
  ON public.articulos FOR DELETE
  USING ( public.mi_rol() = 'publicador' );