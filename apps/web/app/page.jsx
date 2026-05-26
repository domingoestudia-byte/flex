import Link from "next/link";
import PanelTurno from "@/components/PanelTurno";
import SeccionVIP from "@/components/SeccionVIP";
import TarjetaEvento from "@/components/TarjetaEvento";

export const dynamic = "force-dynamic";

const EVENTO_DESTACADO = {
  titulo: "Jazz Nights",
  fecha: "Sabado, 25 de mayo",
  hora: "22:00 - 04:00h",
  lugar: "Flex Principal",
};

const PROXIMOS_EVENTOS = [
  {
    id: 1,
    titulo: "Jazz Nights",
    fecha: "25 mayo",
    genero: "Jazz / Blues",
    precio: "Desde 15 EUR",
  },
  {
    id: 2,
    titulo: "Soul & Blues",
    fecha: "31 mayo",
    genero: "Soul / R&B",
    precio: "Desde 12 EUR",
  },
  {
    id: 3,
    titulo: "Latin Jazz",
    fecha: "07 jun",
    genero: "Latin / Fusion",
    precio: "Desde 10 EUR",
  },
];

export default function Inicio() {
  return (
    <div className="space-y-10 p-6 md:p-8">
      <div>
        <p className="text-sm text-zinc-500">Bienvenido, Alex</p>
        <h1 className="text-2xl font-bold text-zinc-100">
          Que te vas a tomar esta noche?
        </h1>
      </div>

      <div className="grid gap-6 xl:grid-cols-3">
        <div className="xl:col-span-2">
          <BannerEvento evento={EVENTO_DESTACADO} />
        </div>
        <PanelTurno numero={4} espera="25 - 30 min" />
      </div>

      <section>
        <h2 className="mb-4 text-lg font-semibold text-zinc-100">
          Proximos eventos
        </h2>
        <div className="grid gap-4 lg:grid-cols-3">
          {PROXIMOS_EVENTOS.map((evento) => (
            <TarjetaEvento key={evento.id} {...evento} />
          ))}
        </div>
      </section>

      <SeccionVIP />
    </div>
  );
}

function BannerEvento({ evento }) {
  return (
    <section className="relative h-64 overflow-hidden rounded-2xl bg-zinc-800">
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_75%_20%,rgba(212,168,67,0.28),transparent_32%),linear-gradient(90deg,#09090b,rgba(24,24,27,0.84),rgba(24,24,27,0.28))]" />

      <div className="absolute inset-0 flex flex-col justify-end p-6">
        <p className="mb-1 text-xs font-semibold uppercase tracking-wider text-gold-400">
          Evento destacado
        </p>
        <h2 className="mb-2 text-3xl font-bold text-white">{evento.titulo}</h2>
        <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-sm text-zinc-400">
          <span>{evento.fecha}</span>
          <span>{evento.hora}</span>
          <span>{evento.lugar}</span>
        </div>
        <Link
          href="/entradas"
          className="mt-4 w-fit rounded-lg bg-gold-500 px-5 py-2 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600 inline-block"
        >
          Ver entradas
        </Link>
      </div>
    </section>
  );
}
