import Link from "next/link";

export default function TarjetaEvento({ titulo, fecha, genero, precio }) {
  return (
    <article className="group overflow-hidden rounded-xl border border-zinc-800 bg-zinc-900 transition-colors hover:border-zinc-700">
      <div className="h-36 bg-zinc-800 transition-colors group-hover:bg-zinc-700" />

      <div className="p-4">
        <p className="mb-1 text-xs font-medium text-gold-400">{fecha}</p>
        <h3 className="font-semibold text-zinc-100">{titulo}</h3>
        <p className="mt-0.5 text-sm text-zinc-500">{genero}</p>
        <div className="mt-3 flex items-center justify-between gap-3">
          <span className="text-sm text-zinc-400">{precio}</span>
          <Link
            href="/entradas"
            className="rounded-lg border border-gold-500/40 px-3 py-1 text-xs text-gold-400 transition-colors hover:bg-gold-500/10"
          >
            Entradas
          </Link>
        </div>
      </div>
    </article>
  );
}
