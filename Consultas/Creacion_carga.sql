--Crear tablas de Datamart final
CREATE DATABASE DataMart_jardineria;
	USE DataMart_jardineria;

CREATE TABLE dm_oficina (
    ID_oficina INT PRIMARY KEY,
    ciudad VARCHAR(30),
    pais VARCHAR(50),
    telefono VARCHAR(20)
);

CREATE TABLE dm_empleado (
    ID_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    ID_oficina INT,
    puesto VARCHAR(50),
    FOREIGN KEY (ID_oficina) REFERENCES dm_oficina(ID_oficina)
);

CREATE TABLE dm_categoria_producto (
    Id_Categoria INT PRIMARY KEY,
    Desc_Categoria VARCHAR(50)
);

CREATE TABLE dm_cliente (
    ID_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    telefono VARCHAR(15),
    ciudad VARCHAR(50),
    pais VARCHAR(50)
);

CREATE TABLE dm_pedido (
    ID_pedido INT PRIMARY KEY,
    fecha_pedido DATE,
    fecha_entrega DATE,
	duracion_entrega INT,
    estado VARCHAR(15),
    ID_cliente INT,
    FOREIGN KEY (ID_cliente) REFERENCES dm_cliente(ID_cliente)
);

CREATE TABLE dm_producto (
    ID_producto INT PRIMARY KEY,
    CodigoProducto VARCHAR(15),
    nombre VARCHAR(70),
    Categoria INT,
    cantidad_en_stock SMALLINT,
    precio_venta NUMERIC(15, 2),
    FOREIGN KEY (Categoria) REFERENCES dm_categoria_producto(Id_Categoria)
);

CREATE TABLE dm_detalle_pedido (
    ID_detalle_pedido INT PRIMARY KEY,
    ID_pedido INT,
    ID_producto INT,
    cantidad INT,
    precio_unidad NUMERIC(15, 2),
	total_pedido NUMERIC,
    FOREIGN KEY (ID_pedido) REFERENCES dm_pedido(ID_pedido),
    FOREIGN KEY (ID_producto) REFERENCES dm_producto(ID_producto)
);

CREATE TABLE dm_pago (
    ID_pago INT PRIMARY KEY,
    ID_cliente INT,
    forma_pago VARCHAR(40),
    fecha_pago DATE,
    total NUMERIC(15, 2),
    FOREIGN KEY (ID_cliente) REFERENCES dm_cliente(ID_cliente)
);

--Cargar datos en Datamart final
INSERT INTO DataMart_jardineria.dbo.dm_oficina (ID_oficina, ciudad, pais, telefono)
SELECT ID_oficina, ciudad, pais, telefono
FROM Staging_jardineria.dbo.staging_oficina;

INSERT INTO DataMart_jardineria.dbo.dm_empleado (ID_empleado, nombre, apellido1, ID_oficina, puesto)
SELECT ID_empleado, nombre, apellido1, ID_oficina, puesto
FROM Staging_jardineria.dbo.staging_empleado;

INSERT INTO DataMart_jardineria.dbo.dm_categoria_producto (Id_Categoria, Desc_Categoria)
SELECT Id_Categoria, Desc_Categoria
FROM Staging_jardineria.dbo.staging_Categoria_producto;

INSERT INTO DataMart_jardineria.dbo.dm_cliente (ID_cliente, nombre_cliente, telefono, ciudad, pais)
SELECT ID_cliente, nombre_cliente, telefono, ciudad, pais
FROM Staging_jardineria.dbo.staging_cliente;

INSERT INTO DataMart_jardineria.dbo.dm_pedido (ID_pedido, fecha_pedido, fecha_entrega, duracion_entrega, estado, ID_cliente)
SELECT ID_pedido, fecha_pedido, fecha_entrega, estado, ID_cliente
FROM Staging_jardineria.dbo.staging_pedido;

INSERT INTO DataMart_jardineria.dbo.dm_producto (ID_producto, CodigoProducto, nombre, Categoria, cantidad_en_stock, precio_venta)
SELECT ID_producto, CodigoProducto, nombre, Categoria, cantidad_en_stock, precio_venta
FROM Staging_jardineria.dbo.staging_producto;

INSERT INTO DataMart_jardineria.dbo.dm_detalle_pedido (ID_detalle_pedido, ID_pedido, ID_producto, cantidad, precio_unidad, total_pedido)
SELECT ID_detalle_pedido, ID_pedido, ID_producto, cantidad, precio_unidad
FROM Staging_jardineria.dbo.staging_detalle_pedido;

INSERT INTO DataMart_jardineria.dbo.dm_pago (ID_pago, ID_cliente, forma_pago, fecha_pago, total)
SELECT ID_pago, ID_cliente, forma_pago, fecha_pago, total
FROM Staging_jardineria.dbo.staging_pago;

--Verificación
	-- Comparar clientes
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_cliente) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_cliente) AS Total_DataMart;

	-- Comparar productos
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_producto) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_producto) AS Total_DataMart;

	-- Comparar categoria_producto
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_categoria_producto) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_categoria_producto) AS Total_DataMart;

	-- Comparar detalle_pedido
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_detalle_pedido) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_detalle_pedido) AS Total_DataMart;

	-- Comparar empleado
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_empleado) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_empleado) AS Total_DataMart;

	-- Comparar oficina
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_oficina) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_oficina) AS Total_DataMart;

	-- Comparar pago
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_pago) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_pago) AS Total_DataMart;

	-- Comparar pedido
SELECT 
    (SELECT COUNT(*) FROM Staging_jardineria.dbo.staging_pedido) AS Total_Staging,
    (SELECT COUNT(*) FROM DataMart_jardineria.dbo.dm_pedido) AS Total_DataMart;