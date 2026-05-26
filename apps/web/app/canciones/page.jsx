import Link from "next/link";
import {
  Flame,
  Heart,
  Music2,
  PlayCircle,
  Search,
  TrendingUp,
} from "lucide-react";
import BotonVotar from "@/components/BotonVotar";

const CANCIONES_TENDENCIA = [
  {
    id: 1,
    titulo: "Midnight Groove",
    artista: "Soul District",
    votos: 128,
  },
  {
    id: 2,
    titulo: "Deep Velvet",
    artista: "Nova Jazz",
    votos: 96,
  },
  {
    id: 3,
    titulo: "Electric Nights",
    artista: "Lounge Avenue",
    votos: 74,
  },
  {
    id: 4,
    titulo: "Golden Lights",
    artista: "The Midnight Club",
    votos: 52,
  },
];

const COLA_DJ = [
  {
    id: 1,
    titulo: "Jazz Lounge",
    artista: "Miles Carter",
    estado: "Sonando ahora",
  },
  {
    id: 2,
    titulo: "After Midnight",
    artista: "Soul Avenue",
    estado: "En cola",
  },
  {
    id: 3,
    titulo: "Night Drive",
    artista: "Velvet Noise",
    estado: "En cola",
  },
  {
    id: 4,
    titulo: "City Lights",
    artista: "Nova",
    estado: "En cola",
  },
];

export default function PaginaCanciones() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* Header */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_30%)]" />

        <div className="relative space-y-6 p-8">
          <div>
            <div className="mb-3 flex items-center gap-2 text-gold-400">
              <Music2 size={18} />
              <span className="text-sm font-medium uppercase tracking-[0.2em]">
                Music Experience
              </span>
            </div>

            <h1 className="max-w-2xl text-4xl font-black tracking-tight text-white">
              ¿Qué quieres escuchar esta noche?
            </h1>

            <p className="mt-3 max-w-xl text-zinc-400">
              Busca canciones, vota tendencias y envía temas directamente a la
              cabina del DJ.
            </p>
          </div>

          {/* Search */}
          <div className="flex flex-col gap-3 lg:flex-row">
            <div className="relative flex-1">
              <Search
                className="absolute left-4 top-1/2 -translate-y-1/2 text-zinc-500"
                size={18}
              />

              <input
                type="text"
                placeholder="Buscar canción o artista..."
                className="h-14 w-full rounded-2xl border border-zinc-800 bg-zinc-950 pl-12 pr-4 text-sm text-zinc-100 outline-none transition-colors placeholder:text-zinc-500 focus:border-gold-500"
              />
            </div>

            <Link
              href="/turno"
              className="flex h-14 items-center justify-center rounded-2xl bg-gold-500 px-6 text-sm font-semibold text-zinc-950 transition-all hover:bg-gold-600"
            >
              Pedir canción
            </Link>
          </div>
        </div>
      </section>

      {/* Content */}
      <div className="grid gap-6 xl:grid-cols-[1.2fr_0.8fr]">
        {/* Trending */}
        <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
          <div className="mb-6 flex items-center justify-between">
            <div>
              <div className="mb-2 flex items-center gap-2 text-gold-400">
                <TrendingUp size={18} />
                <span className="text-xs font-semibold uppercase tracking-widest">
                  Tendencias
                </span>
              </div>

              <h2 className="text-2xl font-bold text-white">
                Más votadas esta noche
              </h2>
            </div>

            <div className="hidden rounded-full border border-zinc-800 bg-zinc-950 px-3 py-1 text-xs text-zinc-500 md:block">
              Actualizado hace 2 min
            </div>
          </div>

          <div className="grid gap-4 md:grid-cols-2">
            {CANCIONES_TENDENCIA.map((cancion) => (
              <article
                key={cancion.id}
                className="group overflow-hidden rounded-2xl border border-zinc-800 bg-zinc-950 transition-all duration-300 hover:-translate-y-1 hover:border-gold-500/30 hover:shadow-[0_0_40px_rgba(212,168,67,0.08)]"
              >
                {/* Fake cover */}
                <div className="relative h-40 overflow-hidden bg-gradient-to-br from-zinc-800 via-zinc-900 to-black">
                  <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.25),transparent_35%)]" />

                  <div className="absolute bottom-4 left-4 flex items-center gap-2 rounded-full border border-white/10 bg-black/40 px-3 py-1 backdrop-blur">
                    <Flame size={14} className="text-gold-400" />
                    <span className="text-xs text-zinc-200">Trending</span>
                  </div>
                </div>

                <div className="space-y-4 p-5">
                  <div>
                    <h3 className="text-lg font-semibold text-white">
                      {cancion.titulo}
                    </h3>

                    <p className="mt-1 text-sm text-zinc-500">
                      {cancion.artista}
                    </p>
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2 text-sm text-zinc-400">
                      <Heart size={15} className="text-gold-400" />
                      {cancion.votos} votos
                    </div>

                    <BotonVotar cancionId={cancion.id} votosIniciales={cancion.votos} />
                  </div>
                </div>
              </article>
            ))}
          </div>
        </section>

        {/* Queue */}
        <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
          <div className="mb-6">
            <div className="mb-2 flex items-center gap-2 text-gold-400">
              <PlayCircle size={18} />
              <span className="text-xs font-semibold uppercase tracking-widest">
                DJ Queue
              </span>
            </div>

            <h2 className="text-2xl font-bold text-white">
              Cola actual del DJ
            </h2>
          </div>

          <div className="space-y-4">
            {COLA_DJ.map((track, index) => (
              <article
                key={track.id}
                className={`rounded-2xl border p-4 transition-colors ${
                  index === 0
                    ? "border-gold-500/30 bg-gold-500/5"
                    : "border-zinc-800 bg-zinc-950 hover:border-zinc-700"
                }`}
              >
                <div className="flex items-start gap-4">
                  <div
                    className={`flex h-12 w-12 shrink-0 items-center justify-center rounded-xl text-sm font-bold ${
                      index === 0
                        ? "bg-gold-500 text-zinc-950"
                        : "bg-zinc-800 text-zinc-400"
                    }`}
                  >
                    #{index + 1}
                  </div>

                  <div className="flex-1">
                    <div className="flex items-center justify-between gap-3">
                      <div>
                        <h3 className="font-semibold text-white">
                          {track.titulo}
                        </h3>

                        <p className="mt-1 text-sm text-zinc-500">
                          {track.artista}
                        </p>
                      </div>

                      <span
                        className={`rounded-full px-3 py-1 text-xs font-medium ${
                          index === 0
                            ? "bg-gold-500/20 text-gold-400"
                            : "bg-zinc-800 text-zinc-400"
                        }`}
                      >
                        {track.estado}
                      </span>
                    </div>
                  </div>
                </div>
              </article>
            ))}
          </div>

          {/* Footer Card */}
          <div className="mt-6 rounded-2xl border border-zinc-800 bg-zinc-950 p-5">
            <div className="flex items-start gap-4">
              <div className="rounded-2xl bg-gold-500/10 p-3 text-gold-400">
                <Music2 size={22} />
              </div>

              <div>
                <h3 className="font-semibold text-white">
                  ¿No encuentras tu canción?
                </h3>

                <p className="mt-1 text-sm leading-relaxed text-zinc-500">
                  Puedes enviar una petición personalizada al DJ y votar temas
                  enviados por otros clientes.
                </p>

                <Link
                  href="/turno"
                  className="mt-4 inline-block text-sm font-medium text-gold-400 transition-colors hover:text-gold-300"
                >
                  Enviar petición →
                </Link>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}