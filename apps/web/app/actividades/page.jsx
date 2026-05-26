import Link from "next/link";
import {
  CalendarDays,
  Gamepad2,
  Mic2,
  Trophy,
  Users,
} from "lucide-react";
import BotonUnirse from "@/components/BotonUnirse";

const ACTIVIDADES = [
  {
    id: 1,
    titulo: "Karaoke Night",
    descripcion:
      "Sube al escenario y canta tus canciones favoritas frente al club.",
    hora: "22:30",
    participantes: 18,
    estado: "EN VIVO",
    icono: Mic2,
  },
  {
    id: 2,
    titulo: "Beer Pong Tournament",
    descripcion:
      "Compite en el torneo semanal y gana consumiciones VIP.",
    hora: "23:15",
    participantes: 24,
    estado: "ÚLTIMAS PLAZAS",
    icono: Trophy,
  },
  {
    id: 3,
    titulo: "Retro Arcade",
    descripcion:
      "Zona arcade abierta toda la noche con ranking en vivo.",
    hora: "21:00",
    participantes: 12,
    estado: "ACTIVO",
    icono: Gamepad2,
  },
];

const EVENTOS = [
  {
    id: 1,
    titulo: "Trivia Music Battle",
    fecha: "Viernes · 00:00",
  },
  {
    id: 2,
    titulo: "Ruleta VIP",
    fecha: "Sábado · 01:00",
  },
  {
    id: 3,
    titulo: "Dance Contest",
    fecha: "Sábado · 02:30",
  },
];

export default function PaginaActividades() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* Hero */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_35%)]" />

        <div className="relative grid gap-8 p-8 lg:grid-cols-[1fr_320px]">
          {/* Left */}
          <div>
            <div className="mb-3 flex items-center gap-2 text-gold-400">
              <CalendarDays size={18} />
              <span className="text-sm font-medium uppercase tracking-[0.2em]">
                Club Activities
              </span>
            </div>

            <h1 className="max-w-2xl text-4xl font-black tracking-tight text-white">
              Vive la experiencia más allá de la música
            </h1>

            <p className="mt-4 max-w-xl text-zinc-400">
              Participa en juegos, karaoke, torneos y actividades especiales
              durante toda la noche.
            </p>

            <div className="mt-8 flex flex-wrap gap-3">
              <Link
                href="#actividades"
                className="rounded-2xl bg-gold-500 px-6 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600"
              >
                Explorar actividades
              </Link>

              <button className="rounded-2xl border border-zinc-700 px-6 py-3 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-800">
                Ver calendario
              </button>
            </div>
          </div>

          {/* Right card */}
          <div className="rounded-3xl border border-gold-500/20 bg-gradient-to-br from-zinc-950 to-zinc-900 p-6 shadow-[0_0_50px_rgba(212,168,67,0.08)]">
            <div className="flex items-center justify-between">
              <span className="text-sm uppercase tracking-[0.2em] text-zinc-500">
                Actividad destacada
              </span>

              <span className="rounded-full bg-red-500/20 px-3 py-1 text-xs font-semibold text-red-400">
                EN VIVO
              </span>
            </div>

            <div className="mt-8">
              <div className="mb-4 inline-flex rounded-2xl bg-gold-500/10 p-4 text-gold-400">
                <Mic2 size={30} />
              </div>

              <h2 className="text-2xl font-bold text-white">
                Karaoke Night
              </h2>

              <p className="mt-3 text-sm leading-relaxed text-zinc-500">
                El escenario está abierto. Participa y gana premios especiales
                esta noche.
              </p>

              <div className="mt-6 flex items-center justify-between rounded-2xl border border-zinc-800 bg-zinc-950 p-4">
                <div>
                  <p className="text-sm text-zinc-500">Empieza</p>
                  <p className="mt-1 font-semibold text-white">22:30 PM</p>
                </div>

                <div className="h-10 w-px bg-zinc-800" />

                <div>
                  <p className="text-sm text-zinc-500">Participantes</p>
                  <p className="mt-1 font-semibold text-white">18 personas</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Activities */}
      <section id="actividades">
        <div className="mb-6 flex items-center justify-between">
          <div>
            <div className="mb-2 flex items-center gap-2 text-gold-400">
              <Users size={18} />
              <span className="text-xs font-semibold uppercase tracking-widest">
                Experiencias
              </span>
            </div>

            <h2 className="text-2xl font-bold text-white">
              Actividades disponibles
            </h2>
          </div>

          <button className="hidden rounded-xl border border-zinc-700 px-4 py-2 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-800 md:block">
            Ver todas
          </button>
        </div>

        <div className="grid gap-6 lg:grid-cols-3">
          {ACTIVIDADES.map((actividad) => {
            const Icono = actividad.icono;

            return (
              <article
                key={actividad.id}
                className="group overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900 transition-all duration-300 hover:-translate-y-1 hover:border-gold-500/30 hover:shadow-[0_0_50px_rgba(212,168,67,0.08)]"
              >
                {/* Fake image */}
                <div className="relative h-52 overflow-hidden bg-gradient-to-br from-zinc-800 via-zinc-900 to-black">
                  <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.22),transparent_35%)]" />

                  <div className="absolute left-5 top-5 rounded-full bg-black/40 px-3 py-1 text-xs font-semibold text-white backdrop-blur">
                    {actividad.estado}
                  </div>

                  <div className="absolute bottom-5 left-5 rounded-2xl bg-gold-500/10 p-4 text-gold-400 backdrop-blur">
                    <Icono size={28} />
                  </div>
                </div>

                {/* Content */}
                <div className="space-y-5 p-6">
                  <div>
                    <h3 className="text-xl font-bold text-white">
                      {actividad.titulo}
                    </h3>

                    <p className="mt-3 text-sm leading-relaxed text-zinc-500">
                      {actividad.descripcion}
                    </p>
                  </div>

                  <div className="flex items-center justify-between rounded-2xl border border-zinc-800 bg-zinc-950 p-4">
                    <div>
                      <p className="text-xs uppercase tracking-wider text-zinc-500">
                        Hora
                      </p>

                      <p className="mt-1 font-semibold text-white">
                        {actividad.hora}
                      </p>
                    </div>

                    <div className="h-10 w-px bg-zinc-800" />

                    <div>
                      <p className="text-xs uppercase tracking-wider text-zinc-500">
                        Participantes
                      </p>

                      <p className="mt-1 font-semibold text-white">
                        {actividad.participantes}
                      </p>
                    </div>
                  </div>

                  <BotonUnirse actividadId={actividad.id} />
                </div>
              </article>
            );
          })}
        </div>
      </section>

      {/* Upcoming */}
      <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
        <div className="mb-6">
          <div className="mb-2 flex items-center gap-2 text-gold-400">
            <CalendarDays size={18} />
            <span className="text-xs font-semibold uppercase tracking-widest">
              Próximamente
            </span>
          </div>

          <h2 className="text-2xl font-bold text-white">
            Eventos de esta semana
          </h2>
        </div>

        <div className="grid gap-4 md:grid-cols-3">
          {EVENTOS.map((evento) => (
            <article
              key={evento.id}
              className="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 transition-colors hover:border-zinc-700"
            >
              <div className="flex items-start justify-between gap-4">
                <div>
                  <h3 className="font-semibold text-white">
                    {evento.titulo}
                  </h3>

                  <p className="mt-2 text-sm text-zinc-500">
                    {evento.fecha}
                  </p>
                </div>

                <div className="rounded-xl bg-gold-500/10 p-2 text-gold-400">
                  <CalendarDays size={18} />
                </div>
              </div>

              <Link
                href="/vip"
                className="mt-5 inline-block text-sm font-medium text-gold-400 transition-colors hover:text-gold-300"
              >
                Reservar plaza →
              </Link>
            </article>
          ))}
        </div>
      </section>
    </div>
  );
}