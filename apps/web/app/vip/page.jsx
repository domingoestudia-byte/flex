import SeccionVIP from "@/components/SeccionVIP";

export const dynamic = "force-dynamic";

export default function PaginaVIP() {
  return (
    <div className="space-y-8 p-6 md:p-8">
      <div>
        <h1 className="text-2xl font-bold text-zinc-100">Salas VIP</h1>
        <p className="mt-1 text-zinc-500">
          Reserva una sala privada para tu grupo
        </p>
      </div>
      <SeccionVIP />
    </div>
  );
}
