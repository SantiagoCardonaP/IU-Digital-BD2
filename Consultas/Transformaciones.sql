USE Staging_jardineria;

-- Transformación de datos

--Eliminar espacios, guiones y paréntesis en la columna telefono de cliente
UPDATE Staging_jardineria.dbo.staging_cliente
SET telefono = REPLACE(REPLACE(REPLACE(REPLACE(telefono, ' ', ''), '-', ''), '(', ''), ')', '');

--Agregar columna calculada en de duración de entrega
ALTER TABLE Staging_jardineria.dbo.staging_pedido
ADD duracion_entrega INT;

UPDATE Staging_jardineria.dbo.staging_pedido
SET duracion_entrega = DATEDIFF(DAY, fecha_pedido, fecha_entrega);

--Calcular el valor total de los pedidos
ALTER TABLE Staging_jardineria.dbo.staging_detalle_pedido
ADD total_pedido DECIMAL(10, 2);

UPDATE Staging_jardineria.dbo.staging_detalle_pedido
SET total_pedido = cantidad * precio_unidad;





