'use client'

import { ShoppingBag, X, Plus, Minus, Trash2 } from 'lucide-react'
import { useState } from 'react'
import { useCarritoStore } from '@/store/carritoStore'
import { confirmarPedido } from '@/app/actions/pedidos'

export default function CarritoFlotante() {
  const [abierto, setAbierto] = useState(false)
  const store = useCarritoStore()
  const { items, agregarItem, quitarItem, eliminarItem, vaciarCarrito, mesaId } = store
  const totalUnidades = store.totalUnidades()
  const totalPrecio = store.totalPrecio()

  async function handleConfirmar() {
    if (!mesaId) {
      alert('No hay mesa seleccionada. Escanea el QR de tu mesa.')
      return
    }
    try {
      await confirmarPedido({ items, mesaId })
      vaciarCarrito()
      setAbierto(false)
      alert('Pedido confirmado con éxito')
    } catch (err) {
      alert('Error al confirmar pedido: ' + err.message)
    }
  }

  return (
    <>
      {/* Botón flotante */}
      <button
        onClick={() => setAbierto(true)}
        className="fixed bottom-6 right-6 z-50 flex items-center gap-2 rounded-full bg-gold-500 px-5 py-3 text-sm font-semibold text-zinc-950 shadow-lg shadow-gold-500/30 transition-all hover:bg-gold-600 active:scale-95 md:bottom-8 md:right-8"
      >
        <ShoppingBag size={20} />
        <span>Carrito</span>
        {totalUnidades > 0 && (
          <span className="flex h-6 w-6 items-center justify-center rounded-full bg-zinc-950 text-xs font-bold text-gold-400">
            {totalUnidades}
          </span>
        )}
      </button>

      {/* Panel lateral */}
      {abierto && (
        <>
          <div className="fixed inset-0 z-50 bg-black/60 backdrop-blur-sm" onClick={() => setAbierto(false)} />
          <div className="fixed bottom-0 left-0 right-0 z-50 flex max-h-[85vh] flex-col rounded-t-3xl border-t border-zinc-700 bg-zinc-900 p-6 shadow-2xl md:bottom-auto md:right-0 md:left-auto md:top-0 md:w-96 md:rounded-none md:border-l md:border-t-0">
            {/* Header */}
            <div className="mb-6 flex items-center justify-between">
              <div>
                <h2 className="text-xl font-bold text-white">Tu pedido</h2>
                <p className="text-sm text-zinc-500">{totalUnidades} producto{totalUnidades !== 1 ? 's' : ''}</p>
              </div>
              <button onClick={() => setAbierto(false)} className="rounded-xl bg-zinc-800 p-2 text-zinc-400 hover:bg-zinc-700 hover:text-white">
                <X size={20} />
              </button>
            </div>

            {/* Items */}
            <div className="flex-1 space-y-3 overflow-y-auto">
              {items.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-16 text-zinc-500">
                  <ShoppingBag size={48} className="mb-4 text-zinc-700" />
                  <p className="text-sm">El carrito está vacío</p>
                  <p className="mt-1 text-xs">Explora el menú y añade productos</p>
                </div>
              ) : (
                items.map((item) => (
                  <div key={item.id} className="flex items-center gap-3 rounded-2xl border border-zinc-800 bg-zinc-950 p-4">
                    <div className="flex-1 min-w-0">
                      <p className="font-medium text-white truncate">{item.nombre}</p>
                      <p className="text-sm text-gold-400">{Number(item.precio * item.cantidad).toFixed(2)} EUR</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <button
                        onClick={() => quitarItem(item.id)}
                        className="flex h-8 w-8 items-center justify-center rounded-lg bg-zinc-800 text-zinc-400 transition-colors hover:bg-zinc-700 hover:text-white"
                      >
                        <Minus size={14} />
                      </button>
                      <span className="w-6 text-center text-sm font-semibold text-white">{item.cantidad}</span>
                      <button
                        onClick={() => agregarItem(item)}
                        className="flex h-8 w-8 items-center justify-center rounded-lg bg-zinc-800 text-zinc-400 transition-colors hover:bg-zinc-700 hover:text-white"
                      >
                        <Plus size={14} />
                      </button>
                      <button
                        onClick={() => eliminarItem(item.id)}
                        className="flex h-8 w-8 items-center justify-center rounded-lg bg-red-500/10 text-red-400 transition-colors hover:bg-red-500/20"
                      >
                        <Trash2 size={14} />
                      </button>
                    </div>
                  </div>
                ))
              )}
            </div>

            {/* Footer */}
            {items.length > 0 && (
              <div className="mt-6 space-y-4 border-t border-zinc-800 pt-4">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-zinc-400">Total</span>
                  <span className="text-2xl font-bold text-gold-400">{Number(totalPrecio).toFixed(2)} EUR</span>
                </div>
                <div className="flex gap-3">
                  <button
                    onClick={vaciarCarrito}
                    className="flex-1 rounded-2xl border border-zinc-700 py-3 text-sm font-medium text-zinc-300 transition-colors hover:bg-zinc-800"
                  >
                    Vaciar
                  </button>
                  <button
                    onClick={handleConfirmar}
                    className="flex-[2] rounded-2xl bg-gold-500 py-3 text-sm font-semibold text-zinc-950 transition-colors hover:bg-gold-600"
                  >
                    Confirmar pedido
                  </button>
                </div>
              </div>
            )}
          </div>
        </>
      )}
    </>
  )
}