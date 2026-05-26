import Link from "next/link";
import {
  CheckCircle2,
  Clock3,
  CupSoda,
  Music2,
  TimerReset,
} from "lucide-react";

const ESTADOS = [
  {
    id: 1,
    titulo: "Pedido confirmado",
    descripcion: "Tu pedido fue recibido correctamente",
    completado: true,
  },
  {
    id: 2,
    titulo: "Preparando bebidas",
    descripcion: "Nuestro equipo está preparando tu orden",
    completado: true,
  },
  {
    id: 3,
    titulo: "Llamando tu turno",
    descripcion: "Tu pedido está casi listo",
    completado: false,
  },
  {
    id: 4,
    titulo: "Entrega",
    descripcion: "Recoge tu pedido en barra principal",
    completado: false,
  },
];

const PERSONAS_COLA = [
  {
    id: 1,
    nombre: "Mesa 12",
    estado: "En preparación",
  },
  {
    id: 2,
    nombre: "VIP Roja",
    estado: "Listo",
  },
  {
    id: 3,
    nombre: "Mesa 7",
    estado: "Esperando",
  },
  {
    id: 4,
    nombre: "Tu pedido",
    estado: "En cola",
    usuario: true,
  },
];

export default function PaginaTurno() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* Hero */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_35%)]" />

        <div className="relative grid gap-8 p-8 lg:grid-cols-[1fr_320px]">
          {/* Left */}
          <div>
            <div className="mb-3 flex items-center gap-2 text-gold-400">
              <Clock3 size={18} />
              <span className="text-sm font-medium uppercase tracking-[0.2em]">
                Live Queue
              </span>
            </div>

            <h1 className="text-4xl font-black tracking-tight text-white">
              Tu turno está en camino
            </h1>

            <p className="mt-3 max-w-xl text-zinc-400">
              Sigue el estado de tu pedido en tiempo real y evita esperar en la
              barra.
            </p>

            {/* Progress */}
            <div className="mt-8">
              <div className="mb-3 flex items-center justify-between text-sm">
                <span className="text-zinc-400">Progreso del pedido</span>
                <span className="font-medium text-gold-400">50%</span>
              </div>

              <div className="h-3 overflow-hidden rounded-full bg-zinc-800">
                <div className="h-full w-1/2 rounded-full bg-gold-500" />
              </div>
            </div>
          </div>

          {/* Turno Card */}
          <div className="flex flex-col items-center justify-center rounded-3xl border border-gold-500/20 bg-gradient-to-br from-zinc-950 to-zinc-900 p-8 shadow-[0_0_50px_rgba(212,168,67,0.08)]">
            <p className="text-sm uppercase tracking-[0.25em] text-zinc-500">
              Tu posición
            </p>

            <div className="mt-4 text-center">
              <h2 className="text-8xl font-black leading-none text-gold-400">
                #4
              </h2>

              <p className="mt-4 text-lg font-medium text-white">
                25 - 30 min
              </p>

              <p className="mt-2 text-sm text-zinc-500">
                Tiempo estimado de espera
              </p>
            </div>

            <button className="mt-8 w-full rounded-2xl border border-zinc-700 py-3 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-800">
              Actualizar estado
            </button>
          </div>
        </div>
      </section>

      {/* Grid */}
      <div className="grid gap-6 xl:grid-cols-[0.9fr_1.1fr]">
        {/* Timeline */}
        <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
          <div className="mb-8">
            <div className="mb-2 flex items-center gap-2 text-gold-400">
              <TimerReset size={18} />
              <span className="text-xs font-semibold uppercase tracking-widest">
                Estado
              </span>
            </div>

            <h2 className="text-2xl font-bold text-white">
              Estado de tu pedido
            </h2>
          </div>

          <div className="space-y-6">
            {ESTADOS.map((estado, index) => (
              <div key={estado.id} className="flex gap-4">
                {/* Line */}
                <div className="flex flex-col items-center">
                  <div
                    className={`flex h-10 w-10 items-center justify-center rounded-full border ${
                      estado.completado
                        ? "border-gold-500 bg-gold-500 text-zinc-950"
                        : "border-zinc-700 bg-zinc-900 text-zinc-500"
                    }`}
                  >
                    {estado.completado ? (
                      <CheckCircle2 size={18} />
                    ) : (
                      <div className="h-2.5 w-2.5 rounded-full bg-zinc-600" />
                    )}
                  </div>

                  {index !== ESTADOS.length - 1 && (
                    <div
                      className={`mt-2 h-14 w-px ${
                        estado.completado
                          ? "bg-gold-500/40"
                          : "bg-zinc-800"
                      }`}
                    />
                  )}
                </div>

                {/* Content */}
                <div className="pb-8">
                  <h3
                    className={`font-semibold ${
                      estado.completado
                        ? "text-white"
                        : "text-zinc-400"
                    }`}
                  >
                    {estado.titulo}
                  </h3>

                  <p className="mt-1 text-sm leading-relaxed text-zinc-500">
                    {estado.descripcion}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* Queue */}
        <section className="space-y-6">
          {/* Queue list */}
          <div className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
            <div className="mb-6">
              <div className="mb-2 flex items-center gap-2 text-gold-400">
                <CupSoda size={18} />
                <span className="text-xs font-semibold uppercase tracking-widest">
                  Cola en vivo
                </span>
              </div>

              <h2 className="text-2xl font-bold text-white">
                Pedidos recientes
              </h2>
            </div>

            <div className="space-y-4">
              {PERSONAS_COLA.map((pedido, index) => (
                <article
                  key={pedido.id}
                  className={`rounded-2xl border p-4 transition-colors ${
                    pedido.usuario
                      ? "border-gold-500/30 bg-gold-500/5"
                      : "border-zinc-800 bg-zinc-950 hover:border-zinc-700"
                  }`}
                >
                  <div className="flex items-center gap-4">
                    <div
                      className={`flex h-12 w-12 items-center justify-center rounded-xl text-sm font-bold ${
                        pedido.usuario
                          ? "bg-gold-500 text-zinc-950"
                          : "bg-zinc-800 text-zinc-400"
                      }`}
                    >
                      #{index + 1}
                    </div>

                    <div className="flex-1">
                      <div className="flex items-center justify-between gap-3">
                        <div>
                          <h3
                            className={`font-semibold ${
                              pedido.usuario
                                ? "text-gold-400"
                                : "text-white"
                            }`}
                          >
                            {pedido.nombre}
                          </h3>

                          <p className="mt-1 text-sm text-zinc-500">
                            {pedido.estado}
                          </p>
                        </div>

                        {pedido.usuario && (
                          <span className="rounded-full bg-gold-500/20 px-3 py-1 text-xs font-medium text-gold-400">
                            Tú
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                </article>
              ))}
            </div>
          </div>

          {/* Music Card */}
          <div className="overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
            <div className="relative">
              <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.15),transparent_35%)]" />

              <div className="relative p-6">
                <div className="flex items-start gap-4">
                  <div className="rounded-2xl bg-gold-500/10 p-3 text-gold-400">
                    <Music2 size={24} />
                  </div>

                  <div>
                    <h3 className="text-lg font-semibold text-white">
                      Mientras esperas...
                    </h3>

                    <p className="mt-2 max-w-md text-sm leading-relaxed text-zinc-500">
                      Puedes seguir votando canciones, explorar actividades o
                      reservar una sala VIP para esta noche.
                    </p>

                    <div className="mt-5 flex flex-wrap gap-3">
                      <Link
                        href="/actividades"
                        className="rounded-xl bg-gold-500 px-5 py-2 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600"
                      >
                        Explorar actividades
                      </Link>

                      <Link
                        href="/canciones"
                        className="rounded-xl border border-zinc-700 px-5 py-2 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-800"
                      >
                        Ver canciones
                      </Link>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}