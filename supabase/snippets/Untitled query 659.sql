-- Función helper
CREATE OR REPLACE FUNCTION public.mi_rol()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
AS $$
  SELECT rol FROM public.perfiles WHERE id = auth.uid()
$$;

-- Activar RLS
ALTER TABLE public.cursos      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matriculas  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lecciones   ENABLE ROW LEVEL SECURITY;

-- ─── CURSOS ───────────────────────────────────────────────

-- 1. Cualquier autenticado ve cursos publicados
CREATE POLICY "autenticado: ver cursos publicados"
  ON public.cursos FOR SELECT
  USING (
    auth.role() = 'authenticated'
    AND publicado = true
  );

-- 2a. Un instructor ve todos sus cursos (publicados o no)
CREATE POLICY "instructor: ver sus cursos"
  ON public.cursos FOR SELECT
  USING (
    instructor_id = auth.uid()
    AND public.mi_rol() = 'instructor'
  );

-- 2b. Un instructor edita solo sus cursos
CREATE POLICY "instructor: editar sus cursos"
  ON public.cursos FOR UPDATE
  USING (
    instructor_id = auth.uid()
    AND public.mi_rol() = 'instructor'
  )
  WITH CHECK (
    instructor_id = auth.uid()
    AND public.mi_rol() = 'instructor'
  );

-- 6. Admin tiene acceso total a cursos
CREATE POLICY "admin: gestionar cursos"
  ON public.cursos FOR ALL
  USING ( public.mi_rol() = 'admin' )
  WITH CHECK ( public.mi_rol() = 'admin' );

-- ─── LECCIONES ────────────────────────────────────────────

-- 3. Un alumno ve las lecciones de cursos en los que está matriculado
CREATE POLICY "alumno: ver lecciones de sus cursos"
  ON public.lecciones FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.matriculas
      WHERE matriculas.curso_id = lecciones.curso_id
        AND matriculas.alumno_id = auth.uid()
    )
  );

-- El instructor ve las lecciones de sus propios cursos
CREATE POLICY "instructor: ver lecciones de sus cursos"
  ON public.lecciones FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.cursos
      WHERE cursos.id = lecciones.curso_id
        AND cursos.instructor_id = auth.uid()
    )
  );

-- Admin: acceso total
CREATE POLICY "admin: gestionar lecciones"
  ON public.lecciones FOR ALL
  USING ( public.mi_rol() = 'admin' )
  WITH CHECK ( public.mi_rol() = 'admin' );

-- ─── MATRÍCULAS ───────────────────────────────────────────

-- 4. Un alumno puede matricularse (solo con su propio alumno_id)
CREATE POLICY "alumno: crear matricula"
  ON public.matriculas FOR INSERT
  WITH CHECK (
    alumno_id = auth.uid()
    AND public.mi_rol() = 'alumno'
  );

-- Un alumno ve sus propias matrículas
CREATE POLICY "alumno: ver sus matriculas"
  ON public.matriculas FOR SELECT
  USING ( alumno_id = auth.uid() );

-- 5. Un alumno puede marcar su matrícula como completada
--    pero no puede cambiar alumno_id ni curso_id
CREATE POLICY "alumno: completar su matricula"
  ON public.matriculas FOR UPDATE
  USING ( alumno_id = auth.uid() )
  WITH CHECK (
    alumno_id = auth.uid()            -- no puede cambiar de quién es
    AND curso_id = (                  -- no puede cambiar el curso
      SELECT curso_id FROM public.matriculas WHERE id = matriculas.id
    )
  );

-- Admin: acceso total
CREATE POLICY "admin: gestionar matriculas"
  ON public.matriculas FOR ALL
  USING ( public.mi_rol() = 'admin' )
  WITH CHECK ( public.mi_rol() = 'admin' );
  