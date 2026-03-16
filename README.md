
-- Sistema: Gestión de Ventas
-- Empresa: Comercio Ya
-- Propósito: Registrar clientes, productos y ventas
-- Base de datos relacional para análisis de transacciones comerciales


| campo      | tipo    |
| ---------- | ------- |
| id_cliente | INTEGER |
| nombre     | TEXT    |
| email      | TEXT    |
| ciudad     | TEXT    |
| telefono   | INTEGER |


| campo           | tipo    |
| --------------- | ------- |
| id_producto     | INTEGER |
| nombre_producto | TEXT    |
| precio          | INTEGER |
| categoria       | TEXT    |


| campo       | tipo    |
| ----------- | ------- |
| id_venta    | INTEGER |
| id_cliente  | INTEGER |
| id_producto | INTEGER |
| fecha       | DATE    |
| cantidad    | INTEGER |
