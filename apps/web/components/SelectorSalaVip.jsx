'use client'

import Image from 'next/image'
import { useReservaStore } from '@/store/reservaStore'

export default function SelectorSalaVip({ salas = [] }) {
  const { paso, salaSeleccionada, seleccionarSala, seleccionarHorario, retroceder } =
    useReservaStore()

  if (!Array.isArray(salas) || salas.length === 0) {
    return <p className="text-sm text-zinc-500">No hay salas VIP disponibles.</p>
  }

  if (paso === 1) {
    return (
      <div>
        <h2>Elige tu sala VIP</h2>
        {salas.map((sala) => (
          <div key={sala.id} onClick={() => seleccionarSala(sala)}>
            {sala.imagen_url && (
              <Image src={sala.imagen_url} alt={sala.nombre} width={320} height={180} className="rounded-lg object-cover" />
            )}
            <h3>{sala.nombre}</h3>
            <p>{sala.precio_hora} €/hora</p>
          </div>
        ))}
      </div>
    )
  }

  if (paso === 2) {
    function handleHorario(e) {
      e.preventDefault()
      const inicio = new Date(e.target.inicio.value)
      const fin    = new Date(e.target.fin.value)
      if (fin <= inicio) {
        alert('La hora de fin debe ser posterior a la de inicio.')
        return
      }
      seleccionarHorario(inicio, fin)
    }

    return (
      <div>
        <button onClick={retroceder}>← Volver</button>
        <h2>Horario para {salaSeleccionada.nombre}</h2>
        <form onSubmit={handleHorario}>
          <label>Inicio: <input type="datetime-local" name="inicio" required /></label>
          <label>Fin:    <input type="datetime-local" name="fin"    required /></label>
          <button type="submit">Continuar al pago</button>
        </form>
      </div>
    )
  }

  if (paso === 3) {
    const horas = (useReservaStore.getState().fechaFin - useReservaStore.getState().fechaInicio) / 3600000
    const total = (horas * salaSeleccionada.precio_hora).toFixed(2)

    return (
      <div>
        <button onClick={retroceder}>← Volver</button>
        <h2>Confirmar reserva</h2>
        <p>Sala: {salaSeleccionada.nombre}</p>
        <p>Horas: {horas}h · Total: {total} €</p>
        {/* El botón de pago irá aquí — ver apunte 05 */}
      </div>
    )
  }
}