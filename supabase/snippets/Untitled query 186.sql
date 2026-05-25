-- Activar RLS
ALTER TABLE public.documentos ENABLE ROW LEVEL SECURITY;

-- El autor puede ver TODOS sus documentos
CREATE POLICY "Autor puede ver sus documentos"
ON public.documentos
FOR SELECT
USING (
  autor_id = auth.uid()
);

-- Cualquier usuario autenticado puede ver documentos publicados
-- (es decir, que NO son borrador)
CREATE POLICY "Usuarios pueden ver publicados"
ON public.documentos
FOR SELECT
USING (
  borrador = false
);

-- Solo el autor puede editar sus documentos
CREATE POLICY "Autor puede editar sus documentos"
ON public.documentos
FOR UPDATE
USING (
  autor_id = auth.uid()
)
WITH CHECK (
  autor_id = auth.uid()
);