# Reporte de Análisis - apps/web

## ✅ Build: COMPILACIÓN EXITOSA
El build de Next.js 16.2.6 se completó sin errores. TypeScript check pasó correctamente.

---

## 🔴 ERRORES DE LINT (1 error, 2 warnings)

### ERROR - `app/entradas/page.jsx:20:11`
```jsx
<a href="/" className="...">Ver proximos eventos</a>
```
**Problema:** Usa `<a>` en lugar de `<Link />` de `next/link`. Causa navegación completa de página (recarga) en lugar de navegación client-side.

### WARNING - `components/SelectorSalaVip.jsx:15:13`
Usa `<img>` sin el componente `<Image />` de Next.js.

### WARNING - `components/TarjetaProducto.jsx:10:7`
Usa `<img>` sin el componente `<Image />` de Next.js.

---

## 🔴 BUG FUNCIONAL CRÍTICO

### PanelCarrito.jsx - Botón "+" incorrecto (línea 28)
```jsx
<button onClick={() => quitarItem(item.id)}>+</button>
```
El botón `+` llama a `quitarItem()` en lugar de llamar a `agregarItem()`. **Ambos botones (`+` y `-`) restan cantidad.** El botón `+` debería ser:
```jsx
<button onClick={() => agregarItem(item)}>+</button>
```
*Nota: `agregarItem` no está desestructurado de `useCarritoStore()` (línea 7), también habría que agregarlo.*

---

## 🔴 BUG POTENCIAL EN SERVER ACTION (autenticación)

### `app/actions/pedidos.js`
```js
import { supabase } from '@/lib/supabase'
// ...
const { data: { user } } = await supabase.auth.getUser()
```
**Problema:** Usa `createClient()` en lugar de `createServerClient()`. En Server Actions (`'use server'`), `createClient()` no tiene acceso a las cookies de la solicitud del usuario, por lo que `getUser()` siempre devolverá `null`. **El pedido siempre fallará con "No autenticado"**.

---

## 🟡 PROBLEMAS DE DISEÑO / DUPLICACIÓN

### Rutas duplicadas: `/configuracion` y `/configuraciones`
Existen **dos páginas** de configuración casi idénticas:
- `app/configuracion/page.jsx`
- `app/configuraciones/page.jsx`

La Sidebar apunta solo a `/configuracion`, por lo que `/configuraciones` queda huérfana. Causa confusión.

---

## 🟡 ADVERTENCIAS ADICIONALES

### SelectorSalaVip.jsx
- No valida que `salas` sea un array antes de mapearlo (línea 13)
- `sala.imagen_url` no tiene manejo de error si la URL es inválida

### SeccionVIP.jsx
- Usa `supabase` directo del servidor. Si Supabase local no está corriendo, esta sección fallará silenciosamente (console.error + array vacío). Podría beneficiarse de un try/catch y mejor feedback visual.

---

## ✅ COSAS QUE FUNCIONAN BIEN

- **Build exitoso** - Sin errores de compilación ni TypeScript
- **Tailwind CSS v4** - Configurado correctamente con `@tailwindcss/postcss`
- **Temas gold** - Colores personalizados funcionando (`--color-gold-300/400/500/600`)
- **Zustand stores** - Bien estructurados con persistencia en `carritoStore`
- **Layout responsive** - Sidebar oculta en mobile, grid adaptable
- **Navegación completa** - 10 rutas funcionando
- **UI consistente** - Estilo dark premium uniforme en todas las páginas
- **Estructura de proyecto** - Bien organizada (components, store, lib, app/)

---

## 📋 RESUMEN DE ACCIONES RECOMENDADAS

| Prioridad | Archivo | Problema |
|-----------|---------|----------|
| 🔴 Alta | `components/PanelCarrito.jsx` | Botón `+` usa función incorrecta (`quitarItem` en vez de `agregarItem`) |
| 🔴 Alta | `app/actions/pedidos.js` | Usar `createServerClient()` en Server Actions para auth funcione |
| 🟡 Media | `app/entradas/page.jsx` | Cambiar `<a>` por `<Link />` de Next.js |
| 🟡 Media | `app/configuraciones/` | Eliminar página duplicada o redirigir a `/configuracion` |
| 🟡 Baja | `components/SelectorSalaVip.jsx` | Validar array y usar `<Image />` |
| 🟡 Baja | `components/TarjetaProducto.jsx` | Usar `<Image />` de Next.js |