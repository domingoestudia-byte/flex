'use client'

import { ShoppingCart } from 'lucide-react'
import { useCarritoStore } from '@/store/carritoStore'

export default function TarjetaProducto({ producto }) {
  const { agregarItem, items } = useCarritoStore()
  const enCarrito = items.find((i) => i.id === producto.id)
  const cantidad = enCarrito?.cantidad || 0

  return (
    <button
      onClick={() => agregarItem(producto)}
      className="flex items-center gap-2 rounded-xl bg-gold-500 px-4 py-2 text-sm font-semibold text-zinc-950 transition-all hover:bg-gold-600 active:scale-95"
    >
      <ShoppingCart size={16} />
      {cantidad > 0 ? `Añadido (${cantidad})` : 'Añadir'}
    </button>
  )
}
