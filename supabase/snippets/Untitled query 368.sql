create policy "portero: ver reservas"
  on public.reservas for select
  using ( public.mi_rol() = 'portero' );