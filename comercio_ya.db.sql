-- Sistema: Gestión de Ventas
-- Empresa: Comercio Ya
-- Propósito: Registrar clientes, productos y ventas en una base de datos relacional
-- Plataforma utilizada: SQLiteOnline

-- Limpia las tablas en caso que ya existan

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

-- Crea tabla clientes
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT,
    ciudad TEXT,
    telefono INTEGER
);

-- Inserta datos en tabla clientes
INSERT INTO clientes (id_cliente, nombre, email, ciudad, telefono)
VALUES
(1, 'Ana Torres', 'ana@email.com', 'Santiago', '912345678'),
(2, 'Pedro Silva', 'pedro@email.com', 'Valparaiso', '987654321'),
(3, 'Camila Rojas', 'camila@email.com', 'Santiago', '934567890');

-- Muestra toda la tabla clientes
SELECT * FROM clientes;

-- Crea tabla productos
CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto TEXT NOT NULL,
    precio INTEGER NOT NULL,
    categoria TEXT
);

-- Inserta datos en la tabla productos
INSERT INTO productos (id_producto, nombre_producto, precio, categoria)
VALUES
(1, 'Notebook', 750000, 'Tecnologia'),
(2, 'Mouse', 15000, 'Tecnologia'),
(3, 'Silla Oficina', 120000, 'Muebles');

SELECT * FROM productos;

--Crea la tabla ventas
CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_producto INTEGER,
    fecha DATE,
    cantidad INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Inserta datos en la tabla ventas 
INSERT INTO ventas (id_venta, id_cliente, id_producto, fecha, cantidad)
VALUES
(1, 1, 2, '2026-03-01', 2),
(2, 2, 1, '2026-03-02', 1),
(3, 1, 3, '2026-03-03', 1);

SELECT * FROM ventas;

-- Filtra la tabla clientes por ciudad Santiago
SELECT * 
FROM clientes
WHERE ciudad = 'Santiago';

-- Muestra nombre y ciudad con filtro de nombre
SELECT nombre, ciudad
FROM clientes
WHERE nombre = 'Pedro Silva';

-- Muestra la venta de cada cliente y la fecha
SELECT clientes.nombre, productos.nombre_producto, ventas.fecha
FROM ventas
JOIN clientes ON ventas.id_cliente = clientes.id_cliente
JOIN productos ON ventas.id_producto = productos.id_producto;

-- Muestra el numero total de ventas registradas con el alias total_ventas
SELECT COUNT(*) AS total_ventas
FROM ventas;

--  Muestra el numero total de productos vendidos con el alias total_productos_vendidos
SELECT SUM(cantidad) AS total_productos_vendidos
FROM ventas;

-- Muestra el promedio de productos vendidos por compra con el alias promedio_productos
SELECT AVG(cantidad) AS promedio_productos
FROM ventas;

-- Muestra el numero de compras por cliente con el alias numero_compras
SELECT id_cliente, COUNT(*) AS numero_compras
FROM ventas
GROUP BY id_cliente;

-- Muestra el total de ventas por cliente
SELECT clientes.nombre, SUM(ventas.cantidad) AS total_comprado
FROM ventas
JOIN clientes ON ventas.id_cliente = clientes.id_cliente
GROUP BY clientes.nombre;

-- Muestra el total vendido por producto
SELECT productos.nombre_producto, SUM(ventas.cantidad) AS total_vendido
FROM ventas
JOIN productos ON ventas.id_producto = productos.id_producto
GROUP BY productos.nombre_producto;

-- Muestra los clientes que realizaron mas de una venta
SELECT nombre
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM ventas
    GROUP BY id_cliente
    HAVING COUNT(*) > 1
);
                     
-- Muestra el producto mas vendido
SELECT nombre_producto
FROM productos
WHERE id_producto = (
    SELECT id_producto
    FROM ventas
    GROUP BY id_producto
    ORDER BY SUM(cantidad) DESC
    LIMIT 1
);

-- Muestra el cliente que mas gasto
SELECT nombre
FROM clientes
WHERE id_cliente = (
    SELECT ventas.id_cliente
    FROM ventas
    JOIN productos ON ventas.id_producto = productos.id_producto
    GROUP BY ventas.id_cliente
    ORDER BY SUM(productos.precio * ventas.cantidad) DESC
    LIMIT 1
);

-- Muestra el cliente que menos gasto
SELECT nombre
FROM clientes
WHERE id_cliente = (
    SELECT ventas.id_cliente
    FROM ventas
    JOIN productos ON ventas.id_producto = productos.id_producto
    GROUP BY ventas.id_cliente
    ORDER BY SUM(productos.precio * ventas.cantidad) ASC
    LIMIT 1
);

-- Agrega la columna stock en la tabla productos
ALTER TABLE productos
ADD COLUMN stock INTEGER;

-- Actualiza stock al producto 1
UPDATE productos
SET stock = 10
WHERE id_producto = 1;

-- Actualiza stock al producto 2
UPDATE productos
SET stock = 25
WHERE id_producto = 2;

-- Actualiza stock al producto 3
UPDATE productos
SET stock = 15
WHERE id_producto = 3;

-- Muestra toda la tabla productos (ahora con stock modificado)
SELECT * FROM productos;

-- Simula la venta de 2 productos con id 2 reduciendo el stock
UPDATE productos
SET stock = stock - 2
WHERE id_producto = 2;

-- Elimina de la tabla producto el dato con id 3
DELETE FROM productos
WHERE id_producto = 3;



