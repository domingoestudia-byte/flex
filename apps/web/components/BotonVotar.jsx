'use client'

import { Heart, ThumbsUp } from 'lucide-react'
import { useState } from 'react'

export default function BotonVotar({ cancionId, votosIniciales = 0 }) {
  const [votado, setVotado] = useState(false)
  const [votos, setVotos] = useState(votosIniciales)

  function handleVotar() {
    if (votado) {
      setVotos((v) => v - 1)
      setVotado(false)
    } else {
      setVotos((v) => v + 1)
      setVotado(true)
    }
  }

  return (
    <button
      onClick={handleVotar}
      className={`rounded-xl border px-4 py-2 text-sm font-medium transition-colors ${
        votado
          ? 'border-gold-500 bg-gold-500/20 text-gold-400'
          : 'border-gold-500/30 text-gold-400 hover:bg-gold-500/10'
      }`}
    >
      <span className="flex items-center gap-2">
        <ThumbsUp size={15} className={votado ? 'fill-gold-400' : ''} />
        {votado ? 'Votado' : 'Votar'} ({votos})
      </span>
    </button>
  )
}