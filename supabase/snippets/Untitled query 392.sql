create policy "portero: completar reservas"
  on public.reservas for update
  using (
    public.mi_rol() = 'portero'
    and estado = 'pagada'
  )
  with check (
    public.mi_rol() = 'portero'
    and estado = 'completada'
  );