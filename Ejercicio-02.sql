CREATE TABLE Proveedor
(
	NroProv varchar(50) NOT NULL PRIMARY KEY,
	NombreProv varchar(50),
	Categoria int,
	CiudadProv varchar(50),
)

CREATE TABLE Articulo
(
	NumArt varchar(50) NOT NULL PRIMARY KEY,
	Descripcion varchar(50),
	CiudadArt varchar(50),
	Precio float,
)


CREATE TABLE Cliente
(
	NumClie varchar(50) NOT NULL PRIMARY KEY,
	NombreClie varchar(50),
	CiudadClie varchar(50),
)


CREATE TABLE Pedido
(
	NroPedido int NOT NULL PRIMARY KEY,
	NumArt varchar(50) NOT NULL,
	NumClie varchar(50) NOT NULL,
	NroProv varchar(50) NOT NULL,
	FechaPedido date,
	CONSTRAINT FKART FOREIGN KEY(NumArt) REFERENCES ARTICULO(NumArt) ON UPDATE CASCADE,
	CONSTRAINT FKCLI FOREIGN KEY(NumClie) REFERENCES CLIENTE(NumClie) ON UPDATE CASCADE,
	CONSTRAINT FKPRO FOREIGN KEY(NroProv) REFERENCES PROVEEDOR(NroProv) ON UPDATE CASCADE,
)


CREATE TABLE Stock
(
	NumArt varchar(50) NOT NULL,
	Fecha date NOT NULL,
	Cantidad int
	CONSTRAINT PKSTOCK PRIMARY KEY(NumArt, Fecha)
	CONSTRAINT FKARTI FOREIGN KEY(NumArt) REFERENCES ARTICULO(NumArt) ON UPDATE CASCADE,
)

SELECT * FROM Stock 
SELECT * FROM Pedido 
SELECT * FROM Cliente 




SELECT * FROM Proveedor
INSERT INTO Proveedor VALUES('P001', 'Juan Perez', 1, 'La Plata')
INSERT INTO Proveedor VALUES('P002', 'Raul Abduzcan', 1, 'La Plata')
INSERT INTO Proveedor VALUES('P003', 'Maria Pia', 2, 'Capital Federal')
INSERT INTO Proveedor VALUES('P004', 'Marcos Medina', 2, 'Rosario')
INSERT INTO Proveedor VALUES('P005', 'Marcela Paz', 3, 'Buenos Aires')
INSERT INTO Proveedor VALUES('P015', 'Luis Perez', 3, 'Rosario')
INSERT INTO Proveedor VALUES('P016', 'Jorge Diaz', 4, 'Rosario')
INSERT INTO Proveedor VALUES('P017', 'Roberto Diaz', 6, 'Buenos Aires')
INSERT INTO Proveedor VALUES('P018', 'Antonio Mitre', 8, 'Capital Federal')

SELECT * FROM Articulo 
INSERT INTO Articulo VALUES('A001', 'GALLETITAS', 'Rosario', 50)
INSERT INTO Articulo VALUES('A002', 'GASEOSA', 'Rosario', 5)
INSERT INTO Articulo VALUES('A003', 'LAVANDINA', 'La Plata', 4)
INSERT INTO Articulo VALUES('A004', 'JABON', 'La Plata', 1)
INSERT INTO Articulo VALUES('A005', 'BANANA', 'La Plata', 2)
INSERT INTO Articulo VALUES('A100', 'UVAS', 'Buenos Aires', 150)
INSERT INTO Articulo VALUES('A146', 'ESCOBA', 'Buenos Aires', 101)
INSERT INTO Articulo VALUES('A200', 'PERA', 'Buenos Aires', 30)
INSERT INTO Articulo VALUES('A201', 'ZANAHORIA', 'Mendoza', 300)
INSERT INTO Articulo VALUES('A006', 'NARANJAS', 'Mendoza', 200)

SELECT * FROM Cliente 
INSERT INTO Cliente VALUES('C01', 'Freddie Mercury', 'Buenos Aires')
INSERT INTO Cliente VALUES('C12', 'Adam Lambert', 'Rosario')
INSERT INTO Cliente VALUES('C23', 'Adam Levine', 'Buenos Aires')
INSERT INTO Cliente VALUES('C30', 'Bruno Mars', 'La Plata')



SELECT * FROM Pedido 
INSERT INTO Pedido VALUES(1, 'A001', 'C23', 'P001', '12/1/2022')
INSERT INTO Pedido VALUES(2, 'A002', 'C30', 'P002', '12/30/2022')
INSERT INTO Pedido VALUES(3, 'A004', 'C12', 'P001', '12/29/2022')
INSERT INTO Pedido VALUES(4, 'A146', 'C23', 'P001', '12/28/2022')
INSERT INTO Pedido VALUES(5, 'A200', 'C01', 'P001', '12/27/2022')
INSERT INTO Pedido VALUES(6, 'A100', 'C12', 'P001', '11/1/2022')
INSERT INTO Pedido VALUES(7, 'A100', 'C12', 'P015', '11/2/2022')
INSERT INTO Pedido VALUES(8, 'A100', 'C12', 'P016', '11/3/2022')
INSERT INTO Pedido VALUES(9, 'A100', 'C12', 'P017', '11/4/2022')
INSERT INTO Pedido VALUES(10, 'A100', 'C12', 'P017', '11/4/2022')
INSERT INTO Pedido VALUES(11, 'A100', 'C23', 'P017', '11/4/2022')
INSERT INTO Pedido VALUES(12, 'A004', 'C12', 'P001', '12/29/2022')
INSERT INTO Pedido VALUES(13, 'A006', 'C12', 'P001', '12/29/2022')
INSERT INTO Pedido VALUES(14, 'A146', 'C30', 'P002', '12/30/2022')



/**
	1- Hallar el código (nroProv) de los proveedores que proveen el artículo a146.
**/
	SELECT NroProv FROM Pedido  WHERE NumArt like 'A146'

/**
	2- Hallar los clientes (nomCli) que solicitan artículos provistos por p015.
**/
	SELECT NombreClie FROM Cliente WHERE NumClie IN 
	(
		SELECT NumClie FROM Pedido WHERE NroProv LIKE 'P015' 
	)

/**
	3- Hallar los clientes que solicitan algún item provisto por proveedores con categoría
	mayor que 4.
**/
	SELECT NumClie FROM Pedido WHERE NroProv IN
	(
		SELECT NroProv FROM Proveedor WHERE Categoria > 4 
	)

/**
	4- Hallar los pedidos en los que un cliente de Rosario solicita artículos producidos en
	la ciudad de Mendoza.
**/
	SELECT * FROM Articulo WHERE CiudadArt LIKE 'Mendoza' AND NumArt IN 
	(
		SELECT NumArt FROM Pedido WHERE NumClie IN
		(
			SELECT NumClie FROM Cliente WHERE CiudadClie LIKE 'Rosario'
		)
	)

/**
	5- Hallar los pedidos en los que el cliente c23 solicita artículos solicitados por el
	cliente c30.
**/
	SELECT * FROM Pedido WHERE NumClie LIKE 'C23' AND NumArt IN 
	(
		SELECT NumArt FROM Pedido WHERE NumClie LIKE 'C30'
	)

/**
	6-  Hallar los proveedores que suministran todos los artículos cuyo precio es superior
	al precio promedio de los artículos que se producen en La Plata.
	LISTAR LOS PROVEEDORES TALES QUE NO EXISTA
	UN ARTICULO QUE NO SUMINISTREN
**/
	SELECT avg(precio)PROM FROM Articulo WHERE CiudadArt LIKE 'La Plata' 
	SELECT * FROM Articulo WHERE CiudadArt LIKE 'La Plata'

	SELECT * FROM Proveedor prov WHERE NOT EXISTS
	(
		SELECT * FROM Articulo art WHERE art.Precio > (SELECT avg(precio)PROM FROM Articulo WHERE CiudadArt LIKE 'La Plata' ) AND NOT EXISTS
		(
			SELECT * FROM Pedido ped2 WHERE ped2.NroProv LIKE prov.NroProv
		)
	)

/**
	7- Hallar la cantidad de artículos diferentes provistos por cada proveedor que provee
	a todos los clientes de Junín. (Buenos Aires)- CORREGIR
**/

	SELECT NroProv, COUNT(NroProv)CantArti FROM Pedido WHERE NumClie IN 
	(
		SELECT NumClie FROM Cliente WHERE CiudadClie LIKE 'Buenos Aires'
	) GROUP BY NroProv

/**
	8- Hallar los nombres de los proveedores cuya categoría sea mayor que la de todos
	los proveedores que proveen el artículo “cuaderno”.  'GASEOSA'
**/

SELECT *FROM Pedido
SELECT *FROM Proveedor
SELECT *FROM Articulo


SELECT Categoria FROM Proveedor WHERE Categoria > 
(
	SELECT MAX(Categoria)MaxCat FROM Proveedor WHERE NroProv IN 
	(
		SELECT NroProv FROM Pedido WHERE NumArt IN
		(
			SELECT ped.NumArt FROM Pedido ped, Articulo art WHERE ped.NumArt LIKE art.NumArt AND art.Descripcion LIKE 'UVAS'
		)
	)
)

/**
	9- Hallar los proveedores que han provisto más de 1000 unidades entre los artículos
	A001y A100   5 PEDIDOS
**/
SELECT *FROM Proveedor
SELECT *FROM Articulo
SELECT *FROM Pedido ORDER BY FechaPedido

SELECT NroProv,COUNT(NroProv)CantPedidos FROM Pedido WHERE NumArt BETWEEN  'A001' AND  'A100'
	GROUP BY NroProv, NumArt
	HAVING COUNT(NroProv) > 2

/**
	10- Listar la cantidad y el precio total de cada artículo que han pedido los Clientes a
	sus proveedores entre las fechas 01-01-2004 y 31-03-2004 (se requiere visualizar
	Cliente, Articulo, Proveedor, Cantidad y Precio).
**/
	SELECT ped.NumClie, ped.NumArt, ped.NroProv,  COUNT(ped.NumArt)CantArti, arti.Precio FROM Pedido ped, Articulo arti
	WHERE arti.NumArt LIKE ped.NumArt AND  ped.FechaPedido BETWEEN '2022-11-01' AND '2022-12-01' 
	GROUP BY ped.NumClie, ped.NumArt, ped.NroProv, arti.Precio 

	
/**
	11-  Idem anterior y que además la Cantidad sea mayor o igual a 1000 o el Precio sea
	mayor a $ 1000.
**/
	SELECT ped.NumClie, ped.NumArt, ped.NroProv,  COUNT(ped.NumArt)CantArti, arti.Precio FROM Pedido ped, Articulo arti
	WHERE arti.NumArt LIKE ped.NumArt AND  ped.FechaPedido BETWEEN '2022-11-01' AND '2022-12-01' 
	GROUP BY ped.NumClie, ped.NumArt, ped.NroProv, arti.Precio 
	HAVING COUNT(ped.NumArt) >= 100 OR arti.Precio < 50
/**
	12-  Listar la descripción de los artículos en donde se hayan pedido en el día más del
	stock existente para ese mismo día.
**/

SELECT * FROM Stock
SELECT * FROM Articulo
INSERT INTO Stock VALUES('a146', '2022-2-3', 300)
INSERT INTO Stock VALUES('a100', '2022-4-6', 3000)
INSERT INTO Stock VALUES('a002', '2022-4-6', 100)
INSERT INTO Stock VALUES('a201', '2021-2-2', 50)
INSERT INTO Stock VALUES('a200', '2022-12-12', 500)
INSERT INTO Stock VALUES('a003', '2004-5-2', 3000)

SELECT * FROM Stock stoc, Pedido ped WHERE stoc.NumArt LIKE ped.NumArt AND stoc.cantidad < ped.cantidad and stoc.Fecha like ped.FechaPedido

/**
	13- Listar los datos de los proveedores que hayan pedido de todos los artículos en un
	mismo día. Verificar sólo en el último mes de pedidos.
**/
SELECT *FROM Pedido ORDER BY FechaPedido


SELECT * FROM Proveedor WHERE NOT EXISTS
(
	SELECT 1 FROM Articulo art WHERE NOT EXISTS
	(
		SELECT 1 FROM Pedido ped WHERE ped.NroProv = art.NumArt AND ped.FechaPedido < '2022-11-01'
	)
)

/**
	14- Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el
	último mes, pero sí se les haya pedido en el mismo mes del año anterior.
**/
	SELECT * FROM Pedido
	EXCEPT
	SELECT * FROM Pedido WHERE FechaPedido < '2022-09-30' AND FechaPedido BETWEEN '2022-09-30' AND '2021-09-30'
