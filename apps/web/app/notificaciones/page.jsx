import Link from "next/link";
import {
  Bell,
  CheckCheck,
  Clock3,
  Music2,
  Sparkles,
  Ticket,
  Wine,
} from "lucide-react";

const NOTIFICACIONES = [
  {
    id: 1,
    titulo: "Tu bebida está lista",
    descripcion:
      "Puedes recoger tu pedido en la barra principal.",
    tiempo: "Hace 2 min",
    icono: Wine,
    unread: true,
  },
  {
    id: 2,
    titulo: "Nueva actividad disponible",
    descripcion:
      "Karaoke Night acaba de abrir nuevas plazas.",
    tiempo: "Hace 8 min",
    icono: Sparkles,
    unread: true,
  },
  {
    id: 3,
    titulo: "Tu canción fue añadida",
    descripcion:
      "El DJ agregó tu canción a la cola de reproducción.",
    tiempo: "Hace 15 min",
    icono: Music2,
    unread: false,
  },
  {
    id: 4,
    titulo: "Reserva VIP confirmada",
    descripcion:
      "Tu sala VIP estará disponible a las 23:00.",
    tiempo: "Hace 30 min",
    icono: Ticket,
    unread: false,
  },
];

export default function PaginaNotificaciones() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* Hero */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_35%)]" />

        <div className="relative flex flex-col gap-6 p-8 lg:flex-row lg:items-center lg:justify-between">
          <div>
            <div className="mb-3 flex items-center gap-2 text-gold-400">
              <Bell size={18} />
              <span className="text-sm font-medium uppercase tracking-[0.2em]">
                Notifications Center
              </span>
            </div>

            <h1 className="text-4xl font-black tracking-tight text-white">
              Tus notificaciones
            </h1>

            <p className="mt-3 max-w-xl text-zinc-400">
              Mantente al día con tus pedidos, actividades, canciones y reservas VIP.
            </p>
          </div>

          <button className="flex items-center justify-center gap-2 rounded-2xl bg-gold-500 px-6 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600">
            <CheckCheck size={18} />
            Marcar todas como leídas
          </button>
        </div>
      </section>

      {/* Stats */}
      <section className="grid gap-4 md:grid-cols-3">
        <article className="rounded-2xl border border-zinc-800 bg-zinc-900 p-5">
          <p className="text-sm text-zinc-500">Sin leer</p>

          <div className="mt-3 flex items-end gap-2">
            <h2 className="text-4xl font-black text-gold-400">2</h2>
            <span className="pb-1 text-sm text-zinc-500">
              pendientes
            </span>
          </div>
        </article>

        <article className="rounded-2xl border border-zinc-800 bg-zinc-900 p-5">
          <p className="text-sm text-zinc-500">Hoy</p>

          <div className="mt-3 flex items-end gap-2">
            <h2 className="text-4xl font-black text-white">12</h2>
            <span className="pb-1 text-sm text-zinc-500">
              notificaciones
            </span>
          </div>
        </article>

        <article className="rounded-2xl border border-zinc-800 bg-zinc-900 p-5">
          <p className="text-sm text-zinc-500">Última actividad</p>

          <div className="mt-3 flex items-center gap-2 text-white">
            <Clock3 size={18} className="text-gold-400" />

            <span className="font-medium">
              Hace 2 minutos
            </span>
          </div>
        </article>
      </section>

      {/* Notifications */}
      <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
        <div className="mb-6 flex items-center justify-between">
          <div>
            <div className="mb-2 flex items-center gap-2 text-gold-400">
              <Bell size={18} />
              <span className="text-xs font-semibold uppercase tracking-widest">
                Activity Feed
              </span>
            </div>

            <h2 className="text-2xl font-bold text-white">
              Actividad reciente
            </h2>
          </div>

          <button className="hidden rounded-xl border border-zinc-700 px-4 py-2 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-800 md:block">
            Filtrar
          </button>
        </div>

        <div className="space-y-4">
          {NOTIFICACIONES.map((notificacion) => {
            const Icono = notificacion.icono;

            return (
              <article
                key={notificacion.id}
                className={`group relative overflow-hidden rounded-2xl border transition-all duration-300 hover:border-zinc-700 ${
                  notificacion.unread
                    ? "border-gold-500/20 bg-gold-500/5"
                    : "border-zinc-800 bg-zinc-950"
                }`}
              >
                {notificacion.unread && (
                  <div className="absolute left-0 top-0 h-full w-1 bg-gold-500" />
                )}

                <div className="flex gap-4 p-5">
                  {/* Icon */}
                  <div
                    className={`flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl ${
                      notificacion.unread
                        ? "bg-gold-500/10 text-gold-400"
                        : "bg-zinc-800 text-zinc-400"
                    }`}
                  >
                    <Icono size={24} />
                  </div>

                  {/* Content */}
                  <div className="flex-1">
                    <div className="flex flex-col gap-3 lg:flex-row lg:items-start lg:justify-between">
                      <div>
                        <div className="flex items-center gap-3">
                          <h3 className="font-semibold text-white">
                            {notificacion.titulo}
                          </h3>

                          {notificacion.unread && (
                            <div className="h-2.5 w-2.5 rounded-full bg-gold-400" />
                          )}
                        </div>

                        <p className="mt-2 max-w-2xl text-sm leading-relaxed text-zinc-500">
                          {notificacion.descripcion}
                        </p>
                      </div>

                      <span className="shrink-0 text-sm text-zinc-500">
                        {notificacion.tiempo}
                      </span>
                    </div>

                    {/* Actions */}
                    <div className="mt-5 flex flex-wrap gap-3">
                      <button className="rounded-xl bg-zinc-800 px-4 py-2 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-700">
                        Ver detalles
                      </button>

                      {notificacion.unread && (
                        <button className="rounded-xl border border-gold-500/30 px-4 py-2 text-sm font-medium text-gold-400 transition-colors hover:bg-gold-500/10">
                          Marcar leída
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              </article>
            );
          })}
        </div>
      </section>

      {/* Footer CTA */}
      <section className="overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="relative">
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.14),transparent_35%)]" />

          <div className="relative flex flex-col gap-6 p-8 lg:flex-row lg:items-center lg:justify-between">
            <div>
              <div className="mb-2 flex items-center gap-2 text-gold-400">
                <Sparkles size={18} />
                <span className="text-xs font-semibold uppercase tracking-widest">
                  Smart Alerts
                </span>
              </div>

              <h2 className="text-2xl font-bold text-white">
                Personaliza tus notificaciones
              </h2>

              <p className="mt-3 max-w-xl text-zinc-500">
                Elige qué actividades, promociones y eventos quieres recibir
                durante la noche.
              </p>
            </div>

            <Link
              href="/configuracion"
              className="rounded-2xl bg-gold-500 px-6 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600 inline-block text-center"
            >
              Configurar preferencias
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}