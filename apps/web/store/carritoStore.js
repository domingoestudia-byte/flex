import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export const useCarritoStore = create(
  persist(
    (set, get) => ({
      items: [],
      mesaId: null,

      setMesa(mesaId) {
        set({ mesaId })
      },

      agregarItem(producto) {
        set((estado) => {
          const existente = estado.items.find((i) => i.id === producto.id)
          if (existente) {
            return {
              items: estado.items.map((i) =>
                i.id === producto.id ? { ...i, cantidad: i.cantidad + 1 } : i
              ),
            }
          }
          return { items: [...estado.items, { ...producto, cantidad: 1 }] }
        })
      },

      quitarItem(productoId) {
        set((estado) => ({
          items: estado.items
            .map((i) => i.id === productoId ? { ...i, cantidad: i.cantidad - 1 } : i)
            .filter((i) => i.cantidad > 0),
        }))
      },

      eliminarItem(productoId) {
        set((estado) => ({
          items: estado.items.filter((i) => i.id !== productoId),
        }))
      },

      vaciarCarrito() {
        set({ items: [], mesaId: null })
      },

      totalUnidades: () => get().items.reduce((acc, i) => acc + i.cantidad, 0),

      totalPrecio: () => get().items.reduce((acc, i) => acc + i.precio * i.cantidad, 0),
    }),
    {
      name: 'flex-carrito',
      partialize: (estado) => ({ items: estado.items, mesaId: estado.mesaId }),
    }
  )
)