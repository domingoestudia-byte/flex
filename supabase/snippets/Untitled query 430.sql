-- TABLA ALUMNOS
CREATE TABLE public.alumnos (
  id uuid PRIMARY KEY
    REFERENCES auth.users(id)
    ON DELETE CASCADE,

  nombre text NOT NULL,

  rol text DEFAULT 'alumno'
);

-- TABLA TAREAS
CREATE TABLE public.tareas (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

  titulo text NOT NULL,

  descripcion text NOT NULL,

  estado text DEFAULT 'pendiente',

  alumno_id uuid NOT NULL
    REFERENCES public.alumnos(id)
    ON DELETE CASCADE
);

-- ACTIVAR RLS
ALTER TABLE public.tareas ENABLE ROW LEVEL SECURITY;

ALTER TABLE public.tareas FORCE ROW LEVEL SECURITY;

---------------------------------------------------
-- POLICIES PARA ALUMNOS
---------------------------------------------------

-- VER SUS TAREAS
CREATE POLICY "Alumno: ver sus tareas"
ON public.tareas
FOR SELECT
USING (
  alumno_id = auth.uid()
);

-- CREAR SUS TAREAS
CREATE POLICY "Alumno: crear sus tareas"
ON public.tareas
FOR INSERT
WITH CHECK (
  alumno_id = auth.uid()
);

-- BORRAR SUS TAREAS
CREATE POLICY "Alumno: borrar sus tareas"
ON public.tareas
FOR DELETE
USING (
  alumno_id = auth.uid()
);

-- ACTUALIZAR SUS TAREAS
CREATE POLICY "Alumno: actualizar sus tareas"
ON public.tareas
FOR UPDATE
USING (
  alumno_id = auth.uid()
)
WITH CHECK (
  alumno_id = auth.uid()
);

---------------------------------------------------
-- POLICY PARA ADMINISTRADOR
---------------------------------------------------

CREATE POLICY "Administrador: acceso total"
ON public.tareas
FOR ALL
USING (
  EXISTS (
    SELECT 1
    FROM public.alumnos a
    WHERE a.id = auth.uid()
      AND a.rol = 'administrador'
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1
    FROM public.alumnos a
    WHERE a.id = auth.uid()
      AND a.rol = 'administrador'
  )
);