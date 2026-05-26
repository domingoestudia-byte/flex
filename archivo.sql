-- =====================================================
-- PLATAFORMA DE CURSOS ONLINE
-- ESQUEMA + RLS COMPLETO
-- =====================================================

-- =====================================================
-- TABLA PERFILES
-- =====================================================

CREATE TABLE public.perfiles (
    id uuid PRIMARY KEY
        REFERENCES auth.users(id)
        ON DELETE CASCADE,

    nombre text,

    rol text NOT NULL
        CHECK (rol IN ('alumno', 'instructor', 'admin'))
);

-- =====================================================
-- TABLA CURSOS
-- =====================================================

CREATE TABLE public.cursos (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    instructor_id uuid NOT NULL
        REFERENCES public.perfiles(id)
        ON DELETE CASCADE,

    titulo text NOT NULL,

    publicado boolean NOT NULL DEFAULT false,

    created_at timestamptz DEFAULT now()
);

-- =====================================================
-- TABLA MATRICULAS
-- =====================================================

CREATE TABLE public.matriculas (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    alumno_id uuid NOT NULL
        REFERENCES public.perfiles(id)
        ON DELETE CASCADE,

    curso_id bigint NOT NULL
        REFERENCES public.cursos(id)
        ON DELETE CASCADE,

    completado boolean NOT NULL DEFAULT false,

    created_at timestamptz DEFAULT now(),

    UNIQUE (alumno_id, curso_id)
);

-- =====================================================
-- TABLA LECCIONES
-- =====================================================

CREATE TABLE public.lecciones (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    curso_id bigint NOT NULL
        REFERENCES public.cursos(id)
        ON DELETE CASCADE,

    titulo text NOT NULL,

    contenido text NOT NULL,

    created_at timestamptz DEFAULT now()
);

-- =====================================================
-- ACTIVAR RLS
-- =====================================================

ALTER TABLE public.perfiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cursos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matriculas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lecciones ENABLE ROW LEVEL SECURITY;

-- =====================================================
-- POLICIES: PERFILES
-- =====================================================

-- Cada usuario puede ver su perfil
CREATE POLICY "Ver perfil propio"
ON public.perfiles
FOR SELECT
USING (
    id = auth.uid()
);

-- Cada usuario puede actualizar su perfil
CREATE POLICY "Actualizar perfil propio"
ON public.perfiles
FOR UPDATE
USING (
    id = auth.uid()
)
WITH CHECK (
    id = auth.uid()
);

-- =====================================================
-- POLICIES: CURSOS
-- =====================================================

-- Ver cursos publicados, propios o admin
CREATE POLICY "Ver cursos"
ON public.cursos
FOR SELECT
USING (
    publicado = true

    OR instructor_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Crear cursos: instructor o admin
CREATE POLICY "Crear cursos"
ON public.cursos
FOR INSERT
WITH CHECK (
    EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol IN ('instructor', 'admin')
    )
);

-- Actualizar cursos
CREATE POLICY "Actualizar cursos"
ON public.cursos
FOR UPDATE
USING (
    instructor_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
)
WITH CHECK (
    instructor_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Eliminar cursos
CREATE POLICY "Eliminar cursos"
ON public.cursos
FOR DELETE
USING (
    instructor_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- =====================================================
-- POLICIES: MATRICULAS
-- =====================================================

-- Ver matrículas propias, del instructor o admin
CREATE POLICY "Ver matriculas"
ON public.matriculas
FOR SELECT
USING (

    alumno_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.cursos c
        WHERE c.id = matriculas.curso_id
        AND c.instructor_id = auth.uid()
    )

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Crear matrícula
CREATE POLICY "Crear matricula"
ON public.matriculas
FOR INSERT
WITH CHECK (
    alumno_id = auth.uid()
);

-- Actualizar matrícula propia
CREATE POLICY "Actualizar matricula"
ON public.matriculas
FOR UPDATE
USING (
    alumno_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
)
WITH CHECK (
    alumno_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Eliminar matrícula
CREATE POLICY "Eliminar matricula"
ON public.matriculas
FOR DELETE
USING (
    alumno_id = auth.uid()

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- =====================================================
-- POLICIES: LECCIONES
-- =====================================================

-- Ver lecciones
CREATE POLICY "Ver lecciones"
ON public.lecciones
FOR SELECT
USING (

    -- Instructor del curso
    EXISTS (
        SELECT 1
        FROM public.cursos c
        WHERE c.id = lecciones.curso_id
        AND c.instructor_id = auth.uid()
    )

    OR

    -- Alumno matriculado
    EXISTS (
        SELECT 1
        FROM public.matriculas m
        WHERE m.curso_id = lecciones.curso_id
        AND m.alumno_id = auth.uid()
    )

    OR

    -- Admin
    EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Crear lecciones
CREATE POLICY "Crear lecciones"
ON public.lecciones
FOR INSERT
WITH CHECK (

    EXISTS (
        SELECT 1
        FROM public.cursos c
        WHERE c.id = lecciones.curso_id
        AND c.instructor_id = auth.uid()
    )

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Actualizar lecciones
CREATE POLICY "Actualizar lecciones"
ON public.lecciones
FOR UPDATE
USING (

    EXISTS (
        SELECT 1
        FROM public.cursos c
        WHERE c.id = lecciones.curso_id
        AND c.instructor_id = auth.uid()
    )

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
)
WITH CHECK (

    EXISTS (
        SELECT 1
        FROM public.cursos c
        WHERE c.id = lecciones.curso_id
        AND c.instructor_id = auth.uid()
    )

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);

-- Eliminar lecciones
CREATE POLICY "Eliminar lecciones"
ON public.lecciones
FOR DELETE
USING (

    EXISTS (
        SELECT 1
        FROM public.cursos c
        WHERE c.id = lecciones.curso_id
        AND c.instructor_id = auth.uid()
    )

    OR EXISTS (
        SELECT 1
        FROM public.perfiles p
        WHERE p.id = auth.uid()
        AND p.rol = 'admin'
    )
);