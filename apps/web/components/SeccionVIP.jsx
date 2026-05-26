import Link from "next/link";
import { supabase } from "@/lib/supabase";
import BotonReservarVIP from "@/components/BotonReservarVIP";

async function cargarSalasVIP() {
  const { data, error } = await supabase
    .from("salas_vip")
    .select("id,nombre,descripcion,capacidad,precio_hora,activa")
    .eq("activa", true)
    .order("precio_hora", { ascending: true });

  if (error) {
    console.error("Error cargando salas VIP:", error.message);
    return [];
  }

  return data;
}

export default async function SeccionVIP() {
  const salas = await cargarSalasVIP();

  return (
    <section>
      <div className="mb-4 flex items-center justify-between gap-4">
        <h2 className="text-lg font-semibold text-zinc-100">Salas VIP</h2>
        <Link href="/vip" className="text-sm text-gold-400 hover:text-gold-300">
          Ver todas
        </Link>
      </div>

      {salas.length === 0 ? (
        <div className="rounded-xl border border-zinc-800 bg-zinc-900 p-5 text-sm text-zinc-500">
          No hay salas VIP disponibles ahora mismo.
        </div>
      ) : (
        <div className="grid gap-4 lg:grid-cols-3">
          {salas.map((sala) => (
          <article
            key={sala.id}
            className="rounded-xl border border-zinc-800 bg-zinc-900 p-5 transition-colors hover:border-zinc-700"
          >
            <div className="mb-4 h-28 rounded-lg bg-zinc-800" />

            <div className="flex items-start justify-between gap-4">
              <div>
                <h3 className="font-semibold text-zinc-100">{sala.nombre}</h3>
                <p className="text-sm text-zinc-500">
                  Hasta {sala.capacidad} personas
                </p>
              </div>
              <span
                className="rounded-full bg-emerald-500/20 px-2 py-1 text-xs text-emerald-400"
              >
                Disponible
              </span>
            </div>

            <div className="mt-4 flex items-center justify-between gap-4">
              <span className="font-semibold text-gold-400">
                {sala.precio_hora} EUR/h
              </span>
              <BotonReservarVIP salaId={sala.id} />
            </div>
          </article>
          ))}
        </div>
      )}
    </section>
  );
}
