
CREATE POLICY "cliente: ver reserva pendiente"
ON public.reservas
FOR SELECT
USING (
   cliente_id = auth.uid() 
);



CREATE POLICY "cancelar reserva pendiente"
ON public.reservas
FOR UPDATE
USING (
    cliente_id = auth.uid() AND reservas.estado = "pendiente"
)
WITH CHECK (
    cliente_id = auth.uid()
);