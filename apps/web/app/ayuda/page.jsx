import Link from "next/link";
import {
  BadgeHelp,
  ChevronRight,
  CreditCard,
  Headphones,
  Lock,
  MessageCircle,
  ShieldCheck,
  Sparkles,
  Ticket,
  Wine,
} from "lucide-react";

const FAQS = [
  {
    id: 1,
    titulo: "Reservas VIP",
    descripcion:
      "Información sobre salas VIP, disponibilidad y upgrades.",
    icono: Wine,
  },
  {
    id: 2,
    titulo: "Entradas y acceso",
    descripcion:
      "Problemas con tickets, QR y acceso al evento.",
    icono: Ticket,
  },
  {
    id: 3,
    titulo: "Pagos y facturación",
    descripcion:
      "Métodos de pago, devoluciones y errores de cobro.",
    icono: CreditCard,
  },
  {
    id: 4,
    titulo: "Privacidad y seguridad",
    descripcion:
      "Protección de datos y seguridad de la cuenta.",
    icono: Lock,
  },
];

const PREGUNTAS = [
  {
    id: 1,
    pregunta: "¿Cómo puedo reservar una sala VIP?",
  },
  {
    id: 2,
    pregunta: "¿Puedo cancelar una reserva?",
  },
  {
    id: 3,
    pregunta: "¿Cómo funciona la cola de pedidos?",
  },
  {
    id: 4,
    pregunta: "¿Puedo pedir canciones al DJ?",
  },
];

export default function PaginaAyuda() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      {/* Hero */}
      <section className="relative overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.18),transparent_35%)]" />

        <div className="relative p-8">
          <div className="mb-3 flex items-center gap-2 text-gold-400">
            <BadgeHelp size={18} />
            <span className="text-sm font-medium uppercase tracking-[0.2em]">
              Support Center
            </span>
          </div>

          <h1 className="max-w-2xl text-4xl font-black tracking-tight text-white">
            ¿Cómo podemos ayudarte?
          </h1>

          <p className="mt-4 max-w-xl text-zinc-400">
            Encuentra respuestas rápidas sobre reservas, pedidos,
            entradas y experiencias VIP.
          </p>

          {/* Search */}
          <div className="mt-8 max-w-2xl">
            <div className="relative">
              <MessageCircle
                className="absolute left-4 top-1/2 -translate-y-1/2 text-zinc-500"
                size={18}
              />

              <input
                type="text"
                placeholder="Buscar ayuda..."
                className="h-14 w-full rounded-2xl border border-zinc-800 bg-zinc-950 pl-12 pr-4 text-sm text-zinc-100 outline-none transition-colors placeholder:text-zinc-500 focus:border-gold-500"
              />
            </div>
          </div>
        </div>
      </section>

      {/* FAQ categories */}
      <section>
        <div className="mb-6">
          <div className="mb-2 flex items-center gap-2 text-gold-400">
            <Sparkles size={18} />
            <span className="text-xs font-semibold uppercase tracking-widest">
              Categorías
            </span>
          </div>

          <h2 className="text-2xl font-bold text-white">
            Temas más consultados
          </h2>
        </div>

        <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
          {FAQS.map((faq) => {
            const Icono = faq.icono;

            return (
              <article
                key={faq.id}
                className="group rounded-3xl border border-zinc-800 bg-zinc-900 p-6 transition-all duration-300 hover:-translate-y-1 hover:border-gold-500/30 hover:shadow-[0_0_40px_rgba(212,168,67,0.08)]"
              >
                <div className="inline-flex rounded-2xl bg-gold-500/10 p-4 text-gold-400">
                  <Icono size={24} />
                </div>

                <div className="mt-6">
                  <h3 className="text-lg font-semibold text-white">
                    {faq.titulo}
                  </h3>

                  <p className="mt-3 text-sm leading-relaxed text-zinc-500">
                    {faq.descripcion}
                  </p>
                </div>

                <Link
                  href="/configuracion"
                  className="mt-6 flex items-center gap-2 text-sm font-medium text-gold-400 transition-colors hover:text-gold-300"
                >
                  Ver información
                  <ChevronRight size={16} />
                </Link>
              </article>
            );
          })}
        </div>
      </section>

      {/* Questions + Contact */}
      <div className="grid gap-6 xl:grid-cols-[1fr_380px]">
        {/* Questions */}
        <section className="rounded-3xl border border-zinc-800 bg-zinc-900 p-6">
          <div className="mb-6">
            <div className="mb-2 flex items-center gap-2 text-gold-400">
              <ShieldCheck size={18} />
              <span className="text-xs font-semibold uppercase tracking-widest">
                FAQ
              </span>
            </div>

            <h2 className="text-2xl font-bold text-white">
              Preguntas frecuentes
            </h2>
          </div>

          <div className="space-y-4">
            {PREGUNTAS.map((item) => (
              <article
                key={item.id}
                className="rounded-2xl border border-zinc-800 bg-zinc-950 transition-colors hover:border-zinc-700"
              >
                <button className="flex w-full items-center justify-between gap-4 p-5 text-left">
                  <span className="font-medium text-white">
                    {item.pregunta}
                  </span>

                  <ChevronRight
                    size={18}
                    className="text-zinc-500"
                  />
                </button>
              </article>
            ))}
          </div>
        </section>

        {/* Support card */}
        <section className="overflow-hidden rounded-3xl border border-zinc-800 bg-zinc-900">
          <div className="relative h-full">
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,rgba(212,168,67,0.16),transparent_35%)]" />

            <div className="relative flex h-full flex-col p-6">
              <div className="inline-flex w-fit rounded-2xl bg-gold-500/10 p-4 text-gold-400">
                <Headphones size={26} />
              </div>

              <div className="mt-6">
                <div className="mb-2 flex items-center gap-2 text-gold-400">
                  <span className="text-xs font-semibold uppercase tracking-widest">
                    Soporte Premium
                  </span>
                </div>

                <h2 className="text-2xl font-bold text-white">
                  ¿Necesitas ayuda inmediata?
                </h2>

                <p className="mt-4 text-sm leading-relaxed text-zinc-500">
                  Nuestro equipo está disponible durante toda la noche para
                  ayudarte con reservas, incidencias y soporte VIP.
                </p>
              </div>

              <div className="mt-8 space-y-4 rounded-2xl border border-zinc-800 bg-zinc-950 p-5">
                <div>
                  <p className="text-sm text-zinc-500">
                    Tiempo medio de respuesta
                  </p>

                  <p className="mt-1 font-semibold text-white">
                    Menos de 3 minutos
                  </p>
                </div>

                <div className="h-px bg-zinc-800" />

                <div>
                  <p className="text-sm text-zinc-500">
                    Disponibilidad
                  </p>

                  <p className="mt-1 font-semibold text-white">
                    24/7 durante eventos
                  </p>
                </div>
              </div>

              <button className="mt-8 rounded-2xl bg-gold-500 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600">
                Hablar con soporte
              </button>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}