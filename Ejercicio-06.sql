CREATE TABLE Vuelo
(
	nroVuelo int,
	desde varchar(50),
	hasta varchar(50),
	fecha date,
	constraint pkVuelo PRIMARY KEY (nroVuelo, desde)
)

CREATE TABLE AvionUtilizado
(
	nroVuelo int,
	tipoAvion varchar(60),
	nroAvion int,
	constraint pkAvionUtilizado PRIMARY KEY (nroVuelo),
)

CREATE TABLE InfoPasajero
(
	nroVuelo int,
	documento int,
	nombre varchar(60),
	origen varchar(50),
	destino varchar(50),

	CONSTRAINT pkInfoPasajero PRIMARY KEY (nroVuelo, documento),
	CONSTRAINT fkInfoPasajero FOREIGN KEY(nroVuelo) REFERENCES AvionUtilizado(nroVuelo)  
)

SELECT * FROM Vuelo
INSERT INTO Vuelo VALUES (1, 'A', 'F', '2022-10-20')
INSERT INTO Vuelo VALUES (2, 'B', 'D', '2022-10-21')
INSERT INTO Vuelo VALUES (3, 'B', 'F', '2022-10-22')
INSERT INTO Vuelo VALUES (4, 'C', 'F', '2022-10-23')
INSERT INTO Vuelo VALUES (5, 'D', 'F', '2022-10-24')
INSERT INTO Vuelo VALUES (6, 'E', 'F', '2022-09-25')
INSERT INTO Vuelo VALUES (7, 'A', 'F', '2022-09-26')
INSERT INTO Vuelo VALUES (8, 'B', 'H', '2022-09-26')
INSERT INTO Vuelo VALUES (9, 'F', 'A', '2022-09-26')

/**
	1- Hallar los números de vuelo desde el origen A hasta el destino F.
**/

	SELECT vue.nroVuelo FROM Vuelo vue WHERE vue.desde LIKE 'A' AND vue.hasta LIKE 'F' 

INSERT INTO AvionUtilizado VALUES(1, 'B-777', 1)
INSERT INTO AvionUtilizado VALUES(8, 'B-777', 1)
INSERT INTO AvionUtilizado VALUES(9, 'B-777', 1)
INSERT INTO AvionUtilizado VALUES(2, 'B-666', 2)
INSERT INTO AvionUtilizado VALUES(3, 'B-555', 3)
INSERT INTO AvionUtilizado VALUES(4, 'B-444', 4)
INSERT INTO AvionUtilizado VALUES(5, 'B-222', 5)
INSERT INTO AvionUtilizado VALUES(6, 'B-696', 6)
INSERT INTO AvionUtilizado VALUES(7, 'B-555', 7)
SELECT * FROM AvionUtilizado

/**
	2- Hallar los tipos de avión que no son utilizados en ningún vuelo que pase por B.
**/
SELECT avi.tipoAvion FROM Vuelo vue, AvionUtilizado avi 
WHERE vue.nroVuelo = avi.nroVuelo AND vue.hasta NOT LIKE 'B' AND vue.desde NOT LIKE 'B'


SELECT * FROM InfoPasajero
INSERT INTO InfoPasajero VALUES(1, 1234, 'Freddie Mercury', 'A', 'D')
INSERT INTO InfoPasajero VALUES(2, 1234, 'Freddie Mercury', 'A', 'H')
INSERT INTO InfoPasajero VALUES(1, 1122, 'Roger Taylor', 'A', 'B')

INSERT INTO InfoPasajero VALUES(2, 1235, 'Adam Levine', 'A', 'B')
INSERT INTO InfoPasajero VALUES(8, 1235, 'Adam Levine', 'A', 'C')
INSERT INTO InfoPasajero VALUES(9, 1235, 'Adam Levine', 'A', 'H')
INSERT INTO InfoPasajero VALUES(3, 1278, 'Bruno Mars', 'B', 'D')
INSERT INTO InfoPasajero VALUES(4, 1478, 'Lionel Messi', 'C', 'D')
INSERT INTO InfoPasajero VALUES(5, 4562, 'Marc Martel', 'C', 'F')
INSERT INTO InfoPasajero VALUES(6, 4564, 'Adam Lambert', 'E', 'F')
INSERT INTO InfoPasajero VALUES(7, 4887, 'Brian May', 'A', 'E')
INSERT INTO InfoPasajero VALUES(2, 4857, 'Msria Pia', 'A', 'D')
INSERT INTO InfoPasajero VALUES(5, 4854, 'Maria Pia', 'A', 'H')


/**
	3- Hallar los pasajeros y números de vuelo para aquellos pasajeros que viajan desde
	A a D pasando por B. 
**/
	
SELECT pas.nroVuelo, pas.documento, pas.nombre FROM InfoPasajero pas WHERE pas.origen LIKE 'A' AND pas.destino LIKE 'D' AND pas.nroVuelo IN
	(
		SELECT vue.nroVuelo FROM Vuelo vue WHERE vue.desde LIKE 'B' OR vue.hasta LIKE 'B'
	)

/**
	4- Hallar los tipos de avión que pasan por C.
**/
	SELECT avi.tipoAvion FROM Vuelo vue, AvionUtilizado avi 
	WHERE vue.nroVuelo = avi.nroVuelo AND vue.desde LIKE 'C' OR vue.hasta LIKE 'C'

/**
	5- Hallar por cada Avión la cantidad de vuelos distintos en que se encuentra
	registrado.
**/
	SELECT avi.tipoAvion, COUNT(avi.tipoAvion)cantVuelosReg FROM Vuelo vue, AvionUtilizado avi 
	WHERE avi.nroVuelo = vue.nroVuelo
	GROUP BY avi.tipoAvion

/**
	6- Listar los distintos tipo y nro. de avión que tienen a H como destino.
**/
	SELECT avi.tipoAvion, avi.nroAvion FROM  AvionUtilizado avi WHERE avi.nroVuelo IN
	(
		SELECT pas.nroVuelo FROM InfoPasajero pas WHERE pas.destino LIKE 'H'
	)

/**
	7- Hallar los pasajeros que han volado más frecuentemente en el último año.
**/
	CREATE VIEW frecueUltAn(documento, nombre, cantViajes) as
	SELECT pas.documento, pas.nombre, (COUNT(pas.documento))cantViajes FROM Vuelo vue, InfoPasajero pas 
	WHERE year(vue.fecha) = 2022 AND pas.nroVuelo = vue.nroVuelo
	GROUP BY pas.documento, pas.nombre

	SELECT * FROM  frecueUltAn WHERE cantViajes = ALL (SELECT MAX(cantViajes) FROM frecueUltAn)

/**
	8- Hallar los pasajeros que han volado la mayor cantidad de veces posible en un
	B-777.
**/
	CREATE VIEW cantB777(nombre, cantVeces) AS
	SELECT pas.nombre, COUNT(avi.tipoAvion)cantVeces FROM InfoPasajero pas, AvionUtilizado avi 
	WHERE pas.nroVuelo = avi.nroVuelo AND avi.tipoAvion LIKE 'B-777' 
	GROUP BY pas.nombre

	SELECT * FROM cantB777 WHERE cantVeces = ALL (SELECT MAX(cantVeces) FROM cantB777)

/**
	9- Hallar los aviones que han transportado más veces al pasajero más antiguo.
**/


/**
	10- Listar la cantidad promedio de pasajeros transportados por los aviones de la
	compañía, por tipo de avión.
**/
CREATE VIEW cantViajXTipoAvi(tipoAvion, cantViajes) as
SELECT avi.tipoAvion, COUNT(pas.documento)cantViajes 
FROM AvionUtilizado avi, InfoPasajero pas WHERE avi.nroVuelo = pas.nroVuelo
GROUP BY avi.tipoAvion

SELECT tipoAvion, AVG(cantViajes)prom FROM cantViajXTipoAvi 
GROUP BY tipoAvion

/**
	11- Hallar los pasajeros que han realizado una cantidad de vuelos dentro del 10% en
	más o en menos del promedio de vuelos de todos los pasajeros de la compañía. VER
**/SELECT pas.* FROM InfoPasajero pas WHERE NOT EXISTS(	SELECT avi.nroVuelo FROM AvionUtilizado avi WHERE NOT EXISTS 	(		SELECT * FROM Vuelo vue WHERE vue.nroVuelo = avi.nroVuelo AND vue.nroVuelo = pas.nroVuelo	))














