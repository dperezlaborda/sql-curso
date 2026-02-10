DROP DATABASE IF EXISTS grace_deco_db;
CREATE DATABASE grace_deco_db;
USE grace_deco_db;

-- =========================
-- TABLA: usuario
-- =========================
CREATE TABLE usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) NOT NULL UNIQUE,
    nombre VARCHAR(80) NOT NULL,
    telefono VARCHAR(30) NULL
);

-- =========================
-- TABLA: categoria
-- =========================
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(60) NOT NULL UNIQUE
);

-- =========================
-- TABLA: direccion
-- =========================
CREATE TABLE direccion (
  id_direccion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  calle VARCHAR(120) NOT NULL,
  ciudad VARCHAR(80) NOT NULL,
  codigo_postal VARCHAR(15) NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE INDEX idx_direccion_id_usuario ON direccion (id_usuario);

-- =========================
-- TABLA: producto
-- =========================
CREATE TABLE producto (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  FOREIGN KEY(id_categoria) REFERENCES categoria (id_categoria)
);

CREATE INDEX idx_producto_id_categoria ON producto (id_categoria);

-- =========================
-- TABLA: pedido
-- =========================
CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  id_direccion INT NOT NULL,
  fecha DATE NOT NULL,
  estado VARCHAR(20) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
  FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion)
);

CREATE INDEX idx_pedido_id_usuario ON pedido (id_usuario);
CREATE INDEX idx_pedido_estado ON pedido (estado);

-- =========================
-- TABLA: pedido_detalle
-- =========================
CREATE TABLE pedido_detalle (
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
  FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE INDEX idx_detalle_id_producto ON pedido_detalle (id_producto);


