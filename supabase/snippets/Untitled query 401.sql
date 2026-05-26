-- =========================================================
-- TABLA USUARIOS
-- =========================================================

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  email VARCHAR(150) UNIQUE,
  telefono VARCHAR(30),
  avatar TEXT,
  vip BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW()
);

-- =========================================================
-- TABLA ENTRADAS
-- =========================================================

CREATE TABLE entradas (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  tipo VARCHAR(50),
  precio DECIMAL(10,2),
  qr_code TEXT,
  estado VARCHAR(50),
  fecha_evento DATE
);

-- =========================================================
-- TABLA CANCIONES
-- =========================================================

CREATE TABLE canciones (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(150),
  artista VARCHAR(150),
  votos INTEGER DEFAULT 0,
  portada TEXT,
  estado VARCHAR(50)
);

-- =========================================================
-- TABLA PRODUCTOS
-- =========================================================

CREATE TABLE productos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(150),
  descripcion TEXT,
  precio DECIMAL(10,2),
  imagen TEXT,
  categoria VARCHAR(100),
  disponible BOOLEAN DEFAULT true
);

-- =========================================================
-- TABLA PEDIDOS
-- =========================================================

CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  total DECIMAL(10,2),
  estado VARCHAR(50),
  tiempo_estimado INTEGER,
  created_at TIMESTAMP DEFAULT NOW()
);

-- =========================================================
-- TABLA ACTIVIDADES
-- =========================================================

CREATE TABLE actividades (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(150),
  descripcion TEXT,
  hora_inicio TIME,
  participantes INTEGER,
  estado VARCHAR(50)
);

-- =========================================================
-- TABLA NOTIFICACIONES
-- =========================================================

CREATE TABLE notificaciones (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  titulo VARCHAR(150),
  mensaje TEXT,
  leida BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW()
);

-- =========================================================
-- TABLA SALAS VIP
-- =========================================================

CREATE TABLE salas_vip (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(150),
  capacidad INTEGER,
  precio DECIMAL(10,2),
  estado VARCHAR(50),
  imagen TEXT
);

-- =========================================================
-- TABLA RESERVAS VIP
-- =========================================================

CREATE TABLE reservas_vip (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  sala_id INTEGER REFERENCES salas_vip(id),
  fecha DATE,
  invitados INTEGER,
  estado VARCHAR(50)
);

-- =========================================================
-- TABLA CARRITO
-- =========================================================

CREATE TABLE carrito (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  producto_id INTEGER REFERENCES productos(id),
  cantidad INTEGER DEFAULT 1
);

-- =========================================================
-- TABLA CONFIGURACION USUARIO
-- =========================================================

CREATE TABLE configuracion_usuario (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  notificaciones_push BOOLEAN DEFAULT true,
  modo_vip BOOLEAN DEFAULT false,
  dark_mode BOOLEAN DEFAULT true,
  marketing BOOLEAN DEFAULT false
);