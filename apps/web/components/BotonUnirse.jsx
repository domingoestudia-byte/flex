'use client'

import { ChevronRight, Check } from 'lucide-react'
import { useState } from 'react'

export default function BotonUnirse({ actividadId }) {
  const [unido, setUnido] = useState(false)

  return (
    <button
      onClick={() => setUnido(!unido)}
      className={`flex w-full items-center justify-center gap-2 rounded-2xl py-3 text-sm font-semibold transition-colors ${
        unido
          ? 'bg-emerald-500 text-white hover:bg-emerald-600'
          : 'bg-gold-500 text-zinc-950 hover:bg-gold-600'
      }`}
    >
      {unido ? (
        <>
          <Check size={16} />
          Te has unido
        </>
      ) : (
        <>
          Unirme ahora
          <ChevronRight size={16} />
        </>
      )}
    </button>
  )
}