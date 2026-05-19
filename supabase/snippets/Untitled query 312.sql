CREATE OR REPLACE FUNCTION public.mi_rol()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT rol
  FROM public.perfiles
  WHERE id = auth.uid()
$$;

---------------------------------------------------
-- ADMIN Y STAFF VEN TODOS LOS PEDIDOS
---------------------------------------------------

CREATE POLICY "pedidos: admin y staff ven todos"
ON public.pedidos
FOR SELECT
USING (
    public.mi_rol() IN ('admin', 'staff')
);

---------------------------------------------------
-- CLIENTES VEN SOLO SUS PEDIDOS
---------------------------------------------------

-- CREATE POLICY "pedidos: cliente ve sus pedidos"
-- ON public.pedidos
-- FOR SELECT
-- USING (
--     public.mi_rol() = 'client'
-- );

-- veria todos los pedidos del rol client 

CREATE POLICY "pedidos: cliente ve sus pedidos"
ON public.pedidos
FOR SELECT
USING (
    cliente_id = auth.uid()
);

---------------------------------------------------
-- ADMIN PUEDE EDITAR PEDIDOS
---------------------------------------------------

CREATE POLICY "pedidos: admin editar pedido"
ON public.pedidos
FOR UPDATE
USING (
    public.mi_rol() = 'admin'
)
WITH CHECK (
    public.mi_rol() = 'admin'
);