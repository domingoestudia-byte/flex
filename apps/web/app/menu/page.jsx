import { supabase } from "@/lib/supabase";
import { Wine, Utensils, Gift, Search } from "lucide-react";
import TarjetaProducto from "@/components/TarjetaProducto";

export const dynamic = "force-dynamic";

async function cargarProductos() {
  const { data, error } = await supabase
    .from("productos")
    .select("id,nombre,descripcion,precio,categoria,imagen_url,disponible")
    .eq("disponible", true)
    .order("categoria", { ascending: true })
    .order("nombre", { ascending: true });

  if (error) {
    console.error("Error cargando productos:", error.message);
    return [];
  }

  return data;
}

const CATEGORIAS = [
  { key: "bebida", label: "Bebidas", icono: Wine, gradient: "from-amber-900/30 to-zinc-900" },
  { key: "comida", label: "Comida", icono: Utensils, gradient: "from-emerald-900/30 to-zinc-900" },
  { key: "pack", label: "Packs", icono: Gift, gradient: "from-gold-500/20 to-zinc-900" },
];

export default async function PaginaMenu() {
  const productos = await cargarProductos();

  const productosPorCategoria = {};
  for (const cat of CATEGORIAS) {
    productosPorCategoria[cat.key] = productos.filter((p) => p.categoria === cat.key);
  }

  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* Hero */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_35%)]" />
        <div className="relative space-y-6 p-8">
          <div>
            <div className="mb-3 flex items-center gap-2 text-gold-400">
              <Wine size={18} />
              <span className="text-sm font-medium uppercase tracking-[0.2em]">
                Menu & Drinks
              </span>
            </div>
            <h1 className="text-4xl font-black tracking-tight text-white">
              ¿Qué te apetece pedir?
            </h1>
            <p className="mt-3 max-w-xl text-zinc-400">
              Explora nuestra carta, añade productos al carrito y haz tu pedido
              sin moverte de tu mesa.
            </p>
          </div>

          {/* Search */}
          <div className="relative max-w-2xl">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-zinc-500" size={18} />
            <input
              type="text"
              placeholder="Buscar en el menú..."
              className="h-14 w-full rounded-2xl border border-zinc-800 bg-zinc-950 pl-12 pr-4 text-sm text-zinc-100 outline-none transition-colors placeholder:text-zinc-500 focus:border-gold-500"
            />
          </div>
        </div>
      </section>

      {/* Categories */}
      {CATEGORIAS.map(({ key, label, icono: Icono, gradient }) => {
        const items = productosPorCategoria[key] || [];

        return (
          <section key={key}>
            <div className="mb-5 flex items-center justify-between">
              <div className="flex items-center gap-3">
                <div className="rounded-xl bg-gold-500/10 p-2.5 text-gold-400">
                  <Icono size={20} />
                </div>
                <h2 className="text-2xl font-bold text-white">{label}</h2>
                <span className="rounded-full bg-zinc-800 px-3 py-0.5 text-xs text-zinc-400">
                  {items.length}
                </span>
              </div>
            </div>

            {items.length === 0 ? (
              <div className="rounded-xl border border-zinc-800 bg-zinc-900 p-6 text-center text-sm text-zinc-500">
                No hay {label.toLowerCase()} disponibles ahora mismo.
              </div>
            ) : (
              <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                {items.map((producto) => (
                  <article
                    key={producto.id}
                    className="group overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-900 transition-all duration-300 hover:-translate-y-1 hover:border-gold-500/30 hover:shadow-[0_0_40px_rgba(212,168,67,0.08)]"
                  >
                    {/* Image */}
                    <div className={`relative h-40 overflow-hidden bg-gradient-to-br ${gradient}`}>
                      <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.2),transparent_35%)]" />
                      {producto.imagen_url && (
                        <img
                          src={producto.imagen_url}
                          alt={producto.nombre}
                          className="h-full w-full object-cover opacity-70 transition-opacity group-hover:opacity-100"
                        />
                      )}
                      <div className="absolute bottom-3 left-3 rounded-full bg-black/50 px-3 py-1 text-xs font-medium capitalize text-zinc-200 backdrop-blur">
                        {key === "bebida" ? "🍸" : key === "comida" ? "🌮" : "🎁"} {key}
                      </div>
                    </div>

                    {/* Content */}
                    <div className="space-y-3 p-4">
                      <div>
                        <h3 className="font-semibold text-white">{producto.nombre}</h3>
                        {producto.descripcion && (
                          <p className="mt-1 text-sm leading-relaxed text-zinc-500 line-clamp-2">
                            {producto.descripcion}
                          </p>
                        )}
                      </div>

                      <div className="flex items-center justify-between gap-3">
                        <span className="text-lg font-bold text-gold-400">
                          {Number(producto.precio).toFixed(2)} EUR
                        </span>
                        <TarjetaProducto producto={producto} />
                      </div>
                    </div>
                  </article>
                ))}
              </div>
            )}
          </section>
        );
      })}
    </div>
  );
}