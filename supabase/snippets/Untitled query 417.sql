-- =========================================================
-- USUARIOS
-- =========================================================

INSERT INTO usuarios (
  id,
  nombre,
  apellido,
  email,
  telefono,
  avatar,
  vip,
  created_at
) VALUES
(1, 'Alex', 'Martinez', 'alex@email.com', '+34 600111222', 'avatar1.jpg', true, NOW()),
(2, 'Lucia', 'Fernandez', 'lucia@email.com', '+34 600333444', 'avatar2.jpg', false, NOW()),
(3, 'Carlos', 'Ruiz', 'carlos@email.com', '+34 600555666', 'avatar3.jpg', true, NOW()),
(4, 'Marta', 'Lopez', 'marta@email.com', '+34 600777888', 'avatar4.jpg', false, NOW());


-- =========================================================
-- ENTRADAS
-- =========================================================

INSERT INTO entradas (
  id,
  usuario_id,
  tipo,
  precio,
  qr_code,
  estado,
  fecha_evento
) VALUES
(1, 1, 'VIP', 80.00, 'QR123VIP', 'activa', '2026-06-20'),
(2, 2, 'General', 25.00, 'QR456GEN', 'activa', '2026-06-20'),
(3, 3, 'Backstage', 120.00, 'QR789BACK', 'usada', '2026-06-20'),
(4, 4, 'General', 25.00, 'QR111GEN', 'pendiente', '2026-06-20');


-- =========================================================
-- CANCIONES
-- =========================================================

INSERT INTO canciones (
  id,
  titulo,
  artista,
  votos,
  portada,
  estado
) VALUES
(1, 'Midnight Groove', 'Soul District', 128, 'cover1.jpg', 'sonando'),
(2, 'Deep Velvet', 'Nova Jazz', 96, 'cover2.jpg', 'cola'),
(3, 'Electric Nights', 'Lounge Avenue', 74, 'cover3.jpg', 'cola'),
(4, 'Golden Lights', 'The Midnight Club', 52, 'cover4.jpg', 'cola');


-- =========================================================
-- PEDIDOS
-- =========================================================

INSERT INTO pedidos (
  id,
  usuario_id,
  total,
  estado,
  tiempo_estimado,
  created_at
) VALUES
(1, 1, 42.50, 'preparando', 20, NOW()),
(2, 2, 18.00, 'listo', 0, NOW()),
(3, 3, 95.00, 'en cola', 35, NOW()),
(4, 4, 27.50, 'entregado', 0, NOW());


-- =========================================================
-- PRODUCTOS
-- =========================================================

INSERT INTO productos (
  id,
  nombre,
  descripcion,
  precio,
  imagen,
  categoria,
  disponible
) VALUES
(1, 'Mojito Premium', 'Ron blanco, lima y menta fresca', 14.00, 'mojito.jpg', 'cocktails', true),
(2, 'Whisky Gold', 'Whisky reserva especial', 18.50, 'whisky.jpg', 'licores', true),
(3, 'Vodka Energy', 'Vodka premium con energy drink', 16.00, 'vodka.jpg', 'cocktails', true),
(4, 'Champagne VIP', 'Botella exclusiva para reservados', 120.00, 'champagne.jpg', 'vip', true);


-- =========================================================
-- ACTIVIDADES
-- =========================================================

INSERT INTO actividades (
  id,
  titulo,
  descripcion,
  hora_inicio,
  participantes,
  estado
) VALUES
(1, 'Karaoke Night', 'Concurso de karaoke en vivo', '22:30:00', 18, 'activo'),
(2, 'Beer Pong Tournament', 'Torneo semanal beer pong', '23:15:00', 24, 'activo'),
(3, 'Retro Arcade', 'Zona arcade retro libre', '21:00:00', 12, 'activo'),
(4, 'Dance Contest', 'Competición de baile freestyle', '01:30:00', 30, 'proximo');


-- =========================================================
-- NOTIFICACIONES
-- =========================================================

INSERT INTO notificaciones (
  id,
  usuario_id,
  titulo,
  mensaje,
  leida,
  created_at
) VALUES
(1, 1, 'Tu bebida está lista', 'Puedes recoger tu pedido en barra principal.', false, NOW()),
(2, 1, 'Nueva actividad disponible', 'Karaoke Night abrió nuevas plazas.', false, NOW()),
(3, 2, 'Reserva VIP confirmada', 'Tu sala VIP estará lista a las 23:00.', true, NOW()),
(4, 3, 'Tu canción fue añadida', 'El DJ añadió tu canción a la cola.', true, NOW());


-- =========================================================
-- SALAS VIP
-- =========================================================

INSERT INTO salas_vip (
  id,
  nombre,
  capacidad,
  precio,
  estado,
  imagen
) VALUES
(1, 'VIP Gold', 8, 300.00, 'disponible', 'vip1.jpg'),
(2, 'Black Room', 12, 500.00, 'ocupada', 'vip2.jpg'),
(3, 'Sky Lounge', 6, 250.00, 'disponible', 'vip3.jpg'),
(4, 'Diamond Area', 15, 800.00, 'reservada', 'vip4.jpg');


-- =========================================================
-- RESERVAS VIP
-- =========================================================

INSERT INTO reservas_vip (
  id,
  usuario_id,
  sala_id,
  fecha,
  invitados,
  estado
) VALUES
(1, 1, 1, '2026-06-20', 6, 'confirmada'),
(2, 3, 2, '2026-06-20', 10, 'confirmada'),
(3, 2, 3, '2026-06-21', 4, 'pendiente'),
(4, 4, 4, '2026-06-22', 12, 'cancelada');


-- =========================================================
-- CARRITO
-- =========================================================

INSERT INTO carrito (
  id,
  usuario_id,
  producto_id,
  cantidad
) VALUES
(1, 1, 1, 2),
(2, 1, 4, 1),
(3, 2, 2, 1),
(4, 3, 3, 3);


-- =========================================================
-- CONFIGURACION USUARIO
-- =========================================================

INSERT INTO configuracion_usuario (
  id,
  usuario_id,
  notificaciones_push,
  modo_vip,
  dark_mode,
  marketing
) VALUES
(1, 1, true, true, true, false),
(2, 2, true, false, true, true),
(3, 3, false, true, true, false),
(4, 4, true, false, false, true);