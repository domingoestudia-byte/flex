'use server'

import { createServerSupabase } from '@/lib/supabase-server'

export async function confirmarPedido({ items, mesaId }) {
  const supabase = await createServerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) throw new Error('No autenticado')

  const total = items.reduce((acc, i) => acc + i.precio * i.cantidad, 0)

  const { data: pedido, error: errorPedido } = await supabase
    .from('pedidos')
    .insert({ mesa_id: mesaId, cliente_id: user.id, total })
    .select()
    .single()

  if (errorPedido) throw new Error(errorPedido.message)

  const lineas = items.map((item) => ({
    pedido_id:   pedido.id,
    producto_id: item.id,
    cantidad:    item.cantidad,
    precio_unit: item.precio,
  }))

  const { error: errorItems } = await supabase
    .from('pedido_items')
    .insert(lineas)

  if (errorItems) throw new Error(errorItems.message)

  return pedido
}
