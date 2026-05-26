'use client'

import { useCarritoStore } from '@/store/carritoStore'

export default function IconoCarrito() {
  const items = useCarritoStore((estado) => estado.items)
  const totalUnidades = items.reduce((acc, i) => acc + i.cantidad, 0)

  return (
    <div className="icono-carrito">
      🛒
      {totalUnidades > 0 && (
        <span className="badge">{totalUnidades}</span>
      )}
    </div>
  )
}
