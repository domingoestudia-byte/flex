'use client'

import Link from 'next/link'

export default function BotonReservarVIP({ salaId }) {
  return (
    <Link
      href={`/vip?sala=${salaId}`}
      className="rounded-lg bg-gold-500 px-4 py-1.5 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600 disabled:cursor-not-allowed disabled:opacity-40 inline-block text-center"
    >
      Reservar
    </Link>
  )
}