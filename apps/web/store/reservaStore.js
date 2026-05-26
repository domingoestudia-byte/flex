import { create } from 'zustand'

export const useReservaStore = create((set, get) => ({
  salaSeleccionada: null,
  fechaInicio: null,
  fechaFin: null,
  paso: 1,

  seleccionarSala(sala) {
    set({ salaSeleccionada: sala, paso: 2 })
  },

  seleccionarHorario(inicio, fin) {
    set({ fechaInicio: inicio, fechaFin: fin, paso: 3 })
  },

  retroceder() {
    set((estado) => ({ paso: Math.max(1, estado.paso - 1) }))
  },

  resetReserva() {
    set({ salaSeleccionada: null, fechaInicio: null, fechaFin: null, paso: 1 })
  },

  totalReserva: () => {
    const { salaSeleccionada, fechaInicio, fechaFin } = get()
    if (!salaSeleccionada || !fechaInicio || !fechaFin) return 0
    const horas = (fechaFin - fechaInicio) / (1000 * 60 * 60)
    return Math.max(0, horas * salaSeleccionada.precio_hora)
  },
}))
