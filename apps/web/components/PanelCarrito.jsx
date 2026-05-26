'use client'

import { useCarritoStore } from '@/store/carritoStore'
import { confirmarPedido } from '@/app/actions/pedidos'

export default function PanelCarrito() {
  const { items, mesaId, agregarItem, quitarItem, eliminarItem, vaciarCarrito } = useCarritoStore()
  const total = items.reduce((acc, i) => acc + i.precio * i.cantidad, 0)

  async function handleConfirmar() {
    if (!mesaId) {
      alert('No hay mesa seleccionada. Escanea el QR de tu mesa.')
      return
    }
    await confirmarPedido({ items, mesaId })
    vaciarCarrito()
  }

  if (items.length === 0) return <p>El carrito está vacío</p>

  return (
    <div className="panel-carrito">
      {items.map((item) => (
        <div key={item.id} className="carrito-item">
          <span>{item.nombre}</span>
          <button onClick={() => quitarItem(item.id)}>–</button>
          <span>{item.cantidad}</span>
          <button onClick={() => agregarItem(item)}>+</button>
          <span>{(item.precio * item.cantidad).toFixed(2)} €</span>
          <button onClick={() => eliminarItem(item.id)}>🗑</button>
        </div>
      ))}
      <p className="total">Total: {total.toFixed(2)} €</p>
      <button onClick={handleConfirmar}>Confirmar pedido</button>
    </div>
  )
}