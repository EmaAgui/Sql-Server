--1. Indique la cantidad de productos que tiene la empresa. 
SELECT count(*) as 'cant_productos'
	FROM producto p

--2. Indique la cantidad de productos en estado 'stock' que tiene la empresa. 

SELECT count(*) as 'cant unidades'
	FROM producto p
	WHERE estado='stock'

--3. Indique los productos que nunca fueron vendidos. 
	SELECT p.Id_producto FROM producto p WHERE NOT EXISTS 
	(
		SELECT 1 FROM detalle_venta dv where dv.Id_producto = p.Id_producto
	)

	SELECT p.Id_producto--, count(dv.tiro_detalle)
	FROM producto p LEFT JOIN Detalle_venta dv on p.Id_producto = dv.Id_producto
	GROUP BY p.id_producto
	HAVING COUNT(dv.Nro_detalle) = 0

--4. Indique la cantidad de unidades que fueron vendidas de cada producto. 

SELECT p.Id_producto, ISNULL(SUM(cantidad),0) 'cantidad'
	FROM producto p LEFT JOIN detalle_venta dv ON p.Id_producto=dv.Id_producto
	GROUP BY p.Id_producto
	 
--5. Indique cual es la cantidad promedio de unidades vendidas de cada producto. 

	SELECT p.Id_producto, ISNULL(AVG(cantidad),0)
	FROM producto p LEFT JOIN detalle_venta dv ON p.Id_producto=dv.Id_producto
	GROUP BY p.Id_producto

--6. Indique quien es el vendedor con mas ventas realizadas. 

select v.Id_vendedor, count(*) as cantidad
 from venta v
 group by v.Id_vendedor

CREATE VIEW ventas_x_vendedor
AS 
SELECT vta.Id_vendedor, count(*) as 'CantVentas'
	FROM venta vta
	GROUP BY vta.Id_vendedor

--Obtengo el mayor
Select vxv.Id_vendedor
	From ventas_x_vendedor vxv
		WHERE vxv.CantVentas=(SELECT MAX(cantVentas) FROM ventas_x_vendedor)

--7. Indique todos los productos de lo que se hayan vendido más de 20 unidades. 

select Id_producto
 from Detalle_venta
  group by Id_producto
   having sum(Cantidad) > 20

   select *
 from Detalle_venta dv, Producto p where dv.Id_producto = p.Id_producto
  

SELECT dv.Id_producto, SUM(dv.Cantidad)
	FROM detalle_venta dv 
	GROUP BY dv.Id_producto
	HAVING SUM(dv.Cantidad)>20

--8. Indique los clientes que le han comprado a todos los vendedores.

SELECT c.id_cliente FROM cliente c WHERE NOT EXISTS
(
		SELECT 1 FROM vendedor v WHERE NOT EXISTS
		(
			SELECT 1 FROM Venta vta WHERE vta.id_Vendedor = v.id_Vendedor AND vta.id_Cliente=c.id_Cliente
		)
)

	SELECT * FROM Venta vta ORDER BY vta.Id_cliente



--9.Genere un SP que permita crear un nuevo vendedor pasando los parametros.

CREATE PROCEDURE sp_cargarVendedor 
	@id_vendedor integer, 
	@nombre varchar(30), 
	@apellido varchar(30), 
	@dni integer
AS
BEGIN
INSERT INTO vendedor (id_vendedor, nombre,apellido, dni) 
	VALUES (@id_vendedor, @nombre, @apellido, @dni);
END

--Probar
EXEC sp_cargarVendedor 24,'Walter', 'White',9000006;

select * from Vendedor

--10. Obtenga los productos que fueron vendidos a 3 clientes
SELECT * 
	FROM PRODUCTO
	WHERE ID_PRODUCTO IN 
	(SELECT DV.ID_PRODUCTO
		FROM detalle_venta dv 
		INNER JOIN venta v
		ON v.nro_factura=dv.nro_factura
	GROUP BY DV.ID_PRODUCTO
	HAVING COUNT(DISTINCT v.id_cliente) = 3)

--10. Genere una funci—n que al tener un nro de factura nos diga el monto total de venta.


CREATE FUNCTION montoFactura( @nroFac INT)

RETURNS DEC(10,2)
AS
BEGIN
	DECLARE @resultado DEC(10,2)
	SELECT @resultado= SUM (cantidad*precio_unitario) FROM detalle_venta dv WHERE dv.nro_factura=@nroFac;
	RETURN @resultado
END;

--SELECT *	FROM detalle_venta dv WHERE dv.nro_factura=1
--TEST

SELECT dbo.montoFactura(1)
--TEST

SELECT vta.nro_factura, dbo.montoFactura(nro_factura) 'Monto total'
	FROM venta vta 




/*11. La tabla de ventas y detalle se vuelven muy pesadas asi que periodicamente borramos registros.
Pero no queremos perder la información, asi que lo necesitamos mandar a un historico de Ventas. 
Genere las 2 tablas y automatice el proceso.  */


--CREATE TABLE historico_Venta
--CREATE TABLE historico_DetalleVenta

/*SELECT * FROM venta vta INNER JOIN detalle_venta dv ON vta.nro_factura=dv.nro_factura WHERE vta.nro_factura=10
*/
CREATE TRIGGER vta_eliminada ON venta INSTEAD OF delete AS 
INSERT INTO Historico_Venta SELECT * FROM deleted; 
INSERT INTO Historico_Detalle_venta SELECT dv.* FROM Detalle_venta dv , deleted WHERE deleted.nro_factura =dv.nro_factura
DELETE vta FROM venta vta,deleted WHERE vta.nro_factura=deleted.nro_factura 

--TEST

DELETE FROM venta WHERE nro_factura=7


