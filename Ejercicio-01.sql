CREATE TABLE Almacen
(
	Nro int NOT NULL PRIMARY KEY,
	Responsable varchar(100)  
)


CREATE TABLE Articulo
(
	CodArticulo int NOT NULL PRIMARY KEY,
	Descripcion varchar(20),
	Precio float
)


CREATE TABLE Material
(
	CodMaterial int NOT NULL PRIMARY KEY,
	Descripcion varchar(20),
)


CREATE TABLE Proveedor
(
	CodProveedor int NOT NULL PRIMARY KEY,
	Nombre varchar(20),
	Domicilio varchar(20),
	Ciudad varchar(20),

)

CREATE TABLE Tiene
(
	NroAlm int NOT NULL,
	CodArt int NOT NULL,
	CONSTRAINT PKTIENE PRIMARY KEY(NroAlm, CodArt),
	CONSTRAINT FKALMACEN FOREIGN KEY(NroAlm) REFERENCES ALMACEN(Nro) ON UPDATE CASCADE,
	CONSTRAINT FKARTICULO FOREIGN KEY(CodArt) REFERENCES ARTICULO(CodArticulo) ON UPDATE CASCADE
)


CREATE TABLE CompuestoPor
(
	CodArt int NOT NULL,
	CodMat int NOT NULL,
	CONSTRAINT PKCOMPUESTOPOR PRIMARY KEY(CodArt, CodMat),
	CONSTRAINT FKART FOREIGN KEY(CodArt) REFERENCES ARTICULO(CodArticulo) ON UPDATE CASCADE,
	CONSTRAINT FKMAT FOREIGN KEY(CodMat) REFERENCES MATERIAL(CodMaterial) ON UPDATE CASCADE
)


CREATE TABLE ProvistoPor
(
	CodMat int NOT NULL,
	CodProv int NOT NULL,
	CONSTRAINT FKPROVISTOPOR PRIMARY KEY(CodMat, CodProv),
	CONSTRAINT FKMARTERIAL FOREIGN KEY(CodMat) REFERENCES Material(CodMaterial) ON UPDATE CASCADE,
	CONSTRAINT FKPROVEEDOR FOREIGN KEY(CodProv) REFERENCES Proveedor(CodProveedor) ON UPDATE CASCADE
)


/**
	1- Listar los nombres de los proveedores de la ciudad de La Plata.
**/
INSERT INTO Proveedor VALUES(10,'Juan Perez', 'Av. Libertador 1993', 'La Plata')
INSERT INTO Proveedor VALUES(15,'Raul Abduzcan', 'Av. Libertador 2001', 'La Plata')
INSERT INTO Proveedor VALUES(20,'Marcelo Casio', 'Rio do Janeiro 911', 'Caballito')
INSERT INTO Proveedor VALUES(30,'Maria Pia', 'Av. La Plata 2005 ', 'Caballito')
INSERT INTO Proveedor VALUES(40,'Marcos Medina', 'Av. Rivadavia 4005 ', 'Caballito')
INSERT INTO Proveedor VALUES(50,'Antonio Lopez', 'Av. Libertador 1995', 'La Plata')
INSERT INTO Proveedor VALUES(55,'Lucas Perez', 'Cordoba 55', 'Pergamino')
INSERT INTO Proveedor VALUES(60,'Marcela Paz', 'Cordoba 44', 'Pergamino')
INSERT INTO Proveedor VALUES(65,'Luis Perez', 'Cordoba 55', 'Pergamino')
INSERT INTO Proveedor VALUES(70,'Micaela Ramos', 'San justo 1', 'Rosario')


DELETE FROM Proveedor
SELECT * FROM Proveedor;

SELECT prov.Nombre FROM Proveedor prov WHERE prov.Ciudad like 'La Plata'
/**---------------------------------------------------------------------------------------**/

/**
	2 -Listar los números de artículos cuyo precio sea inferior a $10.
**/
INSERT INTO Articulo VALUES(1, 'GALLETITAS', 50)
INSERT INTO Articulo VALUES(2, 'GASEOSA', 5)
INSERT INTO Articulo VALUES(3, 'LAVANDINA', 4)
INSERT INTO Articulo VALUES(4, 'JABON', 1)
INSERT INTO Articulo VALUES(5, 'BANANA', 2)
INSERT INTO Articulo VALUES(6, 'PERA', 30)
INSERT INTO Articulo VALUES(7, 'UVAS', 150)
INSERT INTO Articulo VALUES(8, 'ESCOBA', 101)

DELETE FROM Articulo
SELECT * FROM Articulo;

SELECT art.CodArticulo FROM Articulo art WHERE art.Precio < 10
/**---------------------------------------------------------------------------------------**/

/**
	3-  Listar los responsables de los almacenes.
**/
INSERT INTO Almacen VALUES(1, 'FREDDIE MERCURY')
INSERT INTO Almacen VALUES(2, 'ADAM LEVINE')
INSERT INTO Almacen VALUES(3, 'BRUNO MARS')
INSERT INTO Almacen VALUES(4, 'ADAM LAMBERT')
INSERT INTO Almacen VALUES(5, 'Martin Gomez')

SELECT *FROM Almacen

SELECT alm.Responsable FROM Almacen alm

/**---------------------------------------------------------------------------------------**/
/**
	4- Listar los códigos de los materiales que provea el proveedor 10 y no los provea el
	proveedor 15.
**/

INSERT INTO Material VALUES(1,'DESC01')
INSERT INTO Material VALUES(2,'DESC02')
INSERT INTO Material VALUES(3,'DESC03')
INSERT INTO Material VALUES(4,'DESC04')
INSERT INTO Material VALUES(5,'DESC05')
INSERT INTO Material VALUES(6,'DESC06')

SELECT *FROM Material

SELECT * FROM ProvistoPor
INSERT INTO ProvistoPor VALUES(1, 10)
INSERT INTO ProvistoPor VALUES(1, 15)
INSERT INTO ProvistoPor VALUES(1, 20)
INSERT INTO ProvistoPor VALUES(1, 30)
INSERT INTO ProvistoPor VALUES(2, 20)
INSERT INTO ProvistoPor VALUES(2, 10)
INSERT INTO ProvistoPor VALUES(3, 10)
INSERT INTO ProvistoPor VALUES(4, 10)
INSERT INTO ProvistoPor VALUES(5, 30)
INSERT INTO ProvistoPor VALUES(6, 70)
INSERT INTO ProvistoPor VALUES(1, 75)
INSERT INTO ProvistoPor VALUES(2, 50)

INSERT INTO ProvistoPor VALUES(1, 50)
INSERT INTO ProvistoPor VALUES(3, 50)
INSERT INTO ProvistoPor VALUES(4, 50)
INSERT INTO ProvistoPor VALUES(5, 50)
INSERT INTO ProvistoPor VALUES(6, 50)


SELECT prov.CodMat FROM ProvistoPor prov WHERE prov.CodProv = 10  
EXCEPT
SELECT prov.CodMat FROM ProvistoPor prov WHERE prov.CodProv = 15

/**---------------------------------------------------------------------------------------**/
/**
	5- Listar los números de almacenes que almacenan el artículo A(1).
**/
INSERT INTO Tiene VALUES(1, 1)
INSERT INTO Tiene VALUES(1, 2)
INSERT INTO Tiene VALUES(1, 5)
INSERT INTO Tiene VALUES(1, 4)
INSERT INTO Tiene VALUES(2, 1)
INSERT INTO Tiene VALUES(2, 2)
INSERT INTO Tiene VALUES(3, 5)
INSERT INTO Tiene VALUES(4, 4)
INSERT INTO Tiene VALUES(4, 5)
INSERT INTO Tiene VALUES(4, 6)
INSERT INTO Tiene VALUES(5, 3)

SELECT * FROM Tiene;
SELECT * FROM Proveedor;
SELECT * FROM Articulo;

SELECT alm.NroAlm FROM Tiene alm WHERE alm.CodArt = 1
/**---------------------------------------------------------------------------------------**/
/**
	6- Listar los proveedores de Pergamino que se llamen Pérez.
**/
SELECT prov.CodProveedor FROM Proveedor prov WHERE prov.Ciudad LIKE 'Pergamino' AND prov.Nombre LIKE '%Perez'

/**
	7- Listar los almacenes que contienen los artículos A y los artículos B (ambos)
**/

SELECT * FROM Tiene;

SELECT alm.NroAlm FROM Tiene alm WHERE alm.CodArt = 1
UNION
SELECT alm.NroAlm FROM Tiene alm WHERE alm.CodArt = 2 


/**
	8- Listar los artículos que cuesten más de $100 o que estén compuestos por el
	material M1(1).
**/
INSERT INTO CompuestoPor VALUES(7, 4)
INSERT INTO CompuestoPor VALUES(7, 1)
INSERT INTO CompuestoPor VALUES(8, 1)
INSERT INTO CompuestoPor VALUES(1, 3)
INSERT INTO CompuestoPor VALUES(6, 2)
INSERT INTO CompuestoPor VALUES(6, 1)
INSERT INTO CompuestoPor VALUES (2, 1)
INSERT INTO CompuestoPor VALUES (2, 4)
INSERT INTO CompuestoPor VALUES (2, 3)
INSERT INTO CompuestoPor VALUES (3, 1)

INSERT INTO CompuestoPor VALUES (4, 1)
INSERT INTO CompuestoPor VALUES (4, 2)
INSERT INTO CompuestoPor VALUES (4, 3)
INSERT INTO CompuestoPor VALUES (4, 4)
INSERT INTO CompuestoPor VALUES (4, 5)
INSERT INTO CompuestoPor VALUES (4, 6)


SELECT * FROM CompuestoPor
SELECT * FROM Material
SELECT * FROM Articulo

SELECT artc.CodArticulo FROM Articulo artc WHERE artc.Precio > 100
UNION
SELECT art1.CodArt FROM CompuestoPor art1 WHERE ART1.CodMat = 1

SELECT p.CodArticulo FROM Articulo p LEFT JOIN CompuestoPor cp ON p.CodArticulo = cp.CodArt
WHERE p.Precio > 100 OR cp.CodMat = 1

/**
	9- Listar los materiales, código y descripción, provistos por proveedores de la ciudad
	de Rosario.
**/
SELECT * FROM Material
SELECT * FROM Proveedor
SELECT * FROM ProvistoPor

SELECT  prov.CodMat, prov.CodProv, mat.Descripcion 
FROM Material mat, ProvistoPor prov INNER JOIN
Proveedor provRos ON prov.CodProv = provRos.CodProveedor and provRos.Ciudad LIKE 'Rosario'

SELECT  prov.CodMat, prov.CodProv, mat.Descripcion
FROM Material mat, Proveedor provR INNER JOIN ProvistoPor prov
ON prov.CodProv = prov.CodProv 

SELECT * FROM Material
WHERE CodMaterial in
(
	SELECT CodMat
	FROM ProvistoPor
	WHERE CodProv in
	(
		SELECT CodProveedor
		FROM Proveedor
		WHERE Ciudad = 'Rosario'
	)
)

/**
	10- Listar el código, descripción y precio de los artículos que se almacenan en A1(1).
**/
SELECT * FROM Tiene
SELECT * FROM Articulo

SELECT * FROM Articulo 
WHERE CodArticulo in
(
	SELECT codArt
	FROM Tiene
	WHERE CodArt = 1
)

/**
	11- Listar la descripción de los materiales que componen el artículo B(2).
**/


SELECT * FROM CompuestoPor

CREATE VIEW matB
AS 
SELECT Comp.CodMat FROM CompuestoPor Comp WHERE Comp.CodArt = 2; 

SELECT * FROM matB

SELECT mat.Descripcion FROM Material mat, matB mat1 WHERE mat.CodMaterial = mat1.CodMat;


select * From Material mat LEFT JOIN CompuestoPor comp  ON mat.CodMaterial = comp.CodMat 

/**
	12- Listar los nombres de los proveedores que proveen los materiales al almacén que
	Martín Gómez tiene a su cargo.
**/
SELECT PROV.Nombre FROM Proveedor PROV WHERE PROV.CodProveedor IN
(
	SELECT prov.CodProv FROM ProvistoPor prov WHERE prov.CodMat IN
	(
		SELECT comp.CodMat FROM CompuestoPor comp WHERE comp.CodArt IN
		(
			SELECT tie.CodArt FROM Tiene tie WHERE tie.NroAlm IN 
			(
				SELECT ALM.Nro  From Almacen ALM WHERE ALM.Responsable = 'Martin Gomez'
			)
		)
	)
)


/**
	13- Listar códigos y descripciones de los artículos compuestos por al menos un material provisto por el 
	proveedor López.
**/


SELECT art.CodArticulo, art.Descripcion  FROM Articulo art WHERE art.CodArticulo IN
(
    SELECT comp.CodArt FROM CompuestoPor comp WHERE comp.CodMat IN
    (
        SELECT provpor.CodMat FROM ProvistoPor provpor WHERE provpor.CodProv IN
        (
            SELECT prov.CodProveedor FROM  Proveedor prov WHERE prov.Nombre  LIKE '%Lopez'
        )
    )
)

/**
	14- Hallar los códigos y nombres de los proveedores que proveen al menos un
	material que se usa en algún artículo cuyo precio es mayor a $100.
**/

SELECT CodProveedor, Nombre FROM Proveedor WHERE CodProveedor IN 
(
	SELECT CodProv FROM ProvistoPor WHERE CodMat IN
	(
		SELECT CodMat FROM CompuestoPor WHERE CodArt IN 
		(
			SELECT CodArticulo FROM Articulo WHERE Precio > 100 
		)
	)
)


/**
	15- Listar los números de almacenes que tienen todos los artículos que incluyen el
	material con código 123(1)
**/

SELECT * FROM CompuestoPor
SELECT * FROM Tiene

/**
	supTodosExis <- (venta x vendedor)
	noExisten <- supTodosExis - venta
	rta <- venta - noExiste	
**/

SELECT * FROM Almacen alm WHERE NOT EXISTS
(
    SELECT 1 FROM Articulo art WHERE CodArticulo IN
    (
        SELECT CodArticulo FROM CompuestoPor WHERE CodMat=1
    )
    AND NOT EXISTS
    (
        SELECT 1 FROM Tiene t where t.CodArt = art.CodArticulo AND t.NroAlm = alm.Nro
    )
)

/**
	16- Listar los proveedores de Capital Federal(Caballito) que sean únicos proveedores de algún
	material.
**/

/**
	Primero creo la vista ProvistoPorXProvistoPor
**/
	CREATE VIEW ProvistoPorXProvistoPor(cod1, codP1, cod2, codP2) AS 
	SELECT * FROM ProvistoPor prov1 CROSS JOIN ProvistoPor p

/**
	Sacamos el unicoProveedor
**/
	CREATE VIEW unicoProveedor(codMat, codProv) AS
	SELECT * FROM ProvistoPor
	EXCEPT
	SELECT prov.cod1, prov.codP1 FROM ProvistoPorXProvistoPor prov WHERE prov.codp1 <> prov.codP2 and prov.cod1 = prov.cod2
	/**
	10 10 30 70
	**/
/**
	Interseccion solo con los de Caballito(Cap. fed)
**/

	SELECT CodProveedor FROM Proveedor WHERE Ciudad LIKE 'Caballito'  
	intersect
	SELECT codProv FROM unicoProveedor 

	SELECT * FROM ProvistoPorXProvistoPor
	SELECT * FROM ProvistoPor
	/**
		17- Listar el/los artículo/s de mayor precio
	**/
	Select art.CodArticulo, art.Precio From Articulo art WHERE art.Precio = (SELECT MAX(Precio) FROM Articulo)
	
	/**
		18- Listar el/los artículo/s de menor precio.
	**/
		Select art.CodArticulo, art.Precio From Articulo art WHERE art.Precio = (SELECT MIN(Precio) FROM Articulo)

	/**
		19- Listar el promedio de precios de los artículos en cada almacén.
	**/
	
	Select  * From Articulo 
	Select  * From Almacen 
	Select  * From Tiene 

	CREATE VIEW articuloTiene(codArt, precio, nroAlm) AS
	SELECT alm.CodArticulo, alm.Precio, tie.NroAlm FROM Articulo alm, Tiene tie WHERE alm.CodArticulo = tie.CodArt
	
	SELECT arT1.nroAlm, AVG(art2.precio) FROM articuloTiene arT1 CROSS JOIN articuloTiene art2 WHERE arT1.nroAlm = art2.nroAlm GROUP BY(arT1.nroAlm)
	
	/**
		20 -Listar los almacenes que almacenan la mayor cantidad de artículos.
	**/

	Select  * From Tiene 

	SELECT tie1.NroAlm, count(tie1.CodArt) FROM Tiene tie1 GROUP BY tie1.NroAlm


	/**
		21- Listar los artículos compuestos por al menos 2 materiales.
	**/
	SELECT comp1.CodArt FROM CompuestoPor comp1 CROSS JOIN CompuestoPor  comp2 WHERE comp1.CodArt = comp2.CodArt AND comp1.CodMat <> comp2.CodMat
	
	/**
		22- Listar los artículos compuestos por exactamente 2 materiales.
	**/

	CREATE VIEW almenosDos(CodArt, CodMat) AS
	SELECT comp1.CodArt, comp1.CodMat FROM CompuestoPor comp1 CROSS JOIN CompuestoPor  comp2 WHERE comp1.CodArt = comp2.CodArt AND comp1.CodMat <> comp2.CodMat

	CREATE VIEW almenosTres(CodArt, CodMat) AS
	SELECT comp1.CodArt, comp1.CodMat FROM CompuestoPor comp1, CompuestoPor comp2 , CompuestoPor comp3
	WHERE comp1.CodArt = comp2.CodArt  AND comp2.CodArt = comp3.CodArt  AND
	comp1.CodMat <> comp2.CodMat AND comp2.CodMat <> comp3.CodMat AND comp1.CodMat <> comp3.CodMat

	SELECT *FROM almenosDos 
	EXCEPT 
	SELECT *FROM almenosTres

	/**
		23- Listar los artículos que estén compuestos con hasta 2 materiales.
	**/
	SELECT *FROM CompuestoPor
	SELECT comp.CodArt, COUNT(comp.CodArt) FROM CompuestoPor comp  GROUP BY comp.CodArt HAVING COUNT(comp.CodArt) <=2

	/**
		24-  Listar los artículos compuestos por todos los materiales.
	**/

	SELECT * FROM Articulo art WHERE NOT EXISTS
	(
		SELECT 1 FROM Material mat WHERE NOT EXISTS
		(
			SELECT 1 FROM CompuestoPor comp WHERE comp.CodMat = mat.CodMaterial AND comp.CodArt = art.CodArticulo
		)
	)

	/**
		25- Listar las ciudades donde existan proveedores que provean todos los materiales.
	**/
	SELECT prov.Ciudad FROM Proveedor prov WHERE NOT EXISTS
	(
		SELECT 1 FROM Material mat WHERE NOT EXISTS 
		(
			SELECT 1 FROM ProvistoPor prove WHERE prove.CodProv = prov.CodProveedor AND prove.CodMat = mat.CodMaterial
		)
	)
