import Link from "next/link";

const MIS_ENTRADAS = [
  {
    id: 1,
    evento: "Jazz Nights",
    fecha: "Sab, 25 mayo - 22:00h",
    tipo: "Pista Principal",
    precio: 15,
    codigo: "FLEX-2C7B",
  },
];

export default function PaginaEntradas() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      <h1 className="text-2xl font-bold text-zinc-100">Mis entradas</h1>

      {MIS_ENTRADAS.length === 0 ? (
        <div className="py-20 text-center text-zinc-500">
          <p>No tienes entradas todavia</p>
          <Link
            href="/"
            className="mt-2 inline-block text-sm text-gold-400 hover:text-gold-300"
          >
            Ver proximos eventos
          </Link>
        </div>
      ) : (
        <div className="space-y-4">
          {MIS_ENTRADAS.map((entrada) => (
            <article
              key={entrada.id}
              className="flex flex-col gap-6 rounded-2xl border border-zinc-800 bg-zinc-900 p-6 sm:flex-row sm:items-center"
            >
              <div className="h-24 w-24 shrink-0 rounded-xl bg-white" />

              <div className="flex-1">
                <h3 className="text-lg font-bold text-zinc-100">
                  {entrada.evento}
                </h3>
                <p className="mt-0.5 text-sm text-zinc-400">{entrada.fecha}</p>
                <p className="text-sm text-zinc-500">{entrada.tipo}</p>
              </div>

              <div className="shrink-0 sm:text-right">
                <p className="text-xl font-bold text-gold-400">
                  {entrada.precio} EUR
                </p>
                <p className="mt-1 font-mono text-xs text-zinc-600">
                  {entrada.codigo}
                </p>
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
