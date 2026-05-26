export default function PanelTurno({ numero, espera }) {
  return (
    <aside className="flex min-h-64 flex-col rounded-2xl border border-zinc-800 bg-zinc-900 p-6">
      <h3 className="mb-auto text-sm font-medium text-zinc-400">Mi turno</h3>

      <div className="flex flex-1 flex-col items-center justify-center py-4">
        <p className="mb-2 text-xs text-zinc-500">Tu posicion en fila</p>
        <p className="text-7xl font-bold leading-none text-gold-400">
          #{numero}
        </p>
        <p className="mt-3 text-sm text-zinc-500">{espera}</p>
      </div>

      <button className="mt-4 w-full rounded-lg border border-zinc-700 py-2 text-sm text-zinc-400 transition-colors hover:bg-zinc-800">
        Ver fila de espera
      </button>
    </aside>
  );
}
