CREATE DATABASE IF NOT EXISTS tienda CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS tienda.fabricante (
                            codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                            nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS tienda.producto (
                          codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(100) NOT NULL,
                          precio DOUBLE NOT NULL,
                          id_fabricante INT UNSIGNED NOT NULL,
                          FOREIGN KEY (id_fabricante) REFERENCES fabricante(codigo)
);

INSERT IGNORE INTO tienda.fabricante VALUES(1, 'Asus');
INSERT IGNORE INTO tienda.fabricante VALUES(2, 'Lenovo');
INSERT IGNORE INTO tienda.fabricante VALUES(3, 'Hewlett-Packard');
INSERT IGNORE INTO tienda.fabricante VALUES(4, 'Samsung');
INSERT IGNORE INTO tienda.fabricante VALUES(5, 'Seagate');
INSERT IGNORE INTO tienda.fabricante VALUES(6, 'Crucial');
INSERT IGNORE INTO tienda.fabricante VALUES(7, 'Gigabyte');
INSERT IGNORE INTO tienda.fabricante VALUES(8, 'Huawei');
INSERT IGNORE INTO tienda.fabricante VALUES(9, 'Xiaomi');

INSERT IGNORE INTO tienda.producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT IGNORE INTO tienda.producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT IGNORE INTO tienda.producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT IGNORE INTO tienda.producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT IGNORE INTO tienda.producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT IGNORE INTO tienda.producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT IGNORE INTO tienda.producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT IGNORE INTO tienda.producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT IGNORE INTO tienda.producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT IGNORE INTO tienda.producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT IGNORE INTO tienda.producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

CREATE DATABASE IF NOT EXISTS ventas CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS ventas.cliente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    ciudad VARCHAR(100) NOT NULL,
    categoria INT UNSIGNED
);

CREATE TABLE IF NOT EXISTS ventas.comercial (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    comision DECIMAL(5, 2) NOT NULL
);

SET @has_comision = (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = 'ventas'
      AND TABLE_NAME = 'comercial'
      AND COLUMN_NAME = 'comision'
);
SET @add_comision_sql = IF(
    @has_comision = 0,
    'ALTER TABLE ventas.comercial ADD COLUMN comision DECIMAL(5, 2) NOT NULL DEFAULT 0',
    'SELECT 1'
);
PREPARE add_comision_stmt FROM @add_comision_sql;
EXECUTE add_comision_stmt;
DEALLOCATE PREPARE add_comision_stmt;

CREATE TABLE IF NOT EXISTS ventas.pedido (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    total DECIMAL(10, 2) NOT NULL,
    fecha DATE NOT NULL,
    id_cliente INT UNSIGNED NOT NULL,
    id_comercial INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    CONSTRAINT fk_pedido_comercial
        FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);