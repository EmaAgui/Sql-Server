CREATE TABLE Autoo 
(
	matricula varchar(7),
	modelo varchar(30),
	año date,
	constraint pfAuto PRIMARY KEY(matricula)
)

CREATE TABLE Chofer
(
	nroLicencia int,
	nombre varchar(50),
	apellido varchar(50),
	fechaIngreso date,
	telefono int,
	CONSTRAINT pkChofer PRIMARY KEY(nroLicencia)
)

CREATE TABLE Viaje
(
	fechaHoraInicio datetime,
	fechaHoraFin datetime,
	chofer int,
	cliente int,
	autoo varchar(7),
	kmTotales float,
	esperaTotal float,
	costoEspera float,
	costoKms float,
	
	CONSTRAINT pkViaje PRIMARY KEY(fechaHoraInicio, chofer),
	CONSTRAINT fkViaje FOREIGN KEY(chofer) REFERENCES CHOFER(nroLicencia) ON UPDATE CASCADE
)

CREATE TABLE Cliente
(
	nroCliente int,
	calle varchar(50),
	nro int,
	localidad varchar(50),
	
	CONSTRAINT pkCliente PRIMARY KEY(nroCliente)
)

SELECT * FROM Cliente

SELECT * FROM Autoo
INSERT INTO Autoo VALUES('1', 'Modelo 1', '2022')
INSERT INTO Autoo VALUES('2', 'Modelo 2', '2020')
INSERT INTO Autoo VALUES('3', 'Modelo 3', '2015')
INSERT INTO Autoo VALUES('4', 'Modelo 4', '2016')
INSERT INTO Autoo VALUES('5', 'Modelo 1', '2004')

SELECT * FROM Chofer
INSERT INTO Chofer VALUES(1, 'Adam', 'Levine', '2000-10-20', 12345678)
INSERT INTO Chofer VALUES(2, 'Zac', 'Efron', '2001-10-20', 12344178)
INSERT INTO Chofer VALUES(3, 'Brian', 'May', '1990-10-20', 12345578)
INSERT INTO Chofer VALUES(4, 'Roger', 'Taylor', '2010-10-20', 15245678)
INSERT INTO Chofer VALUES(5, 'Freddie', 'Mercury', '2022-10-20', 12645678)

SELECT * FROM Viaje

INSERT INTO Viaje VALUES('2022-10-20 13:03:00', '2022-10-20 14:04:00', 1, 1, 1, 15, 1, 50, 500)
INSERT INTO Viaje VALUES('2022-10-20 15:03:00', '2022-10-20 16:04:00', 2, 2, 2, 25, 1, 50, 1600)
INSERT INTO Viaje VALUES('2022-10-20 15:03:00', '2022-10-20 20:04:00', 1, 1, 2, 25, 1, 50, 1600)
INSERT INTO Viaje VALUES('2022-10-20 12:03:00', '2022-10-20 14:04:00', 3, 3, 3, 15, 1, 50, 600)
INSERT INTO Viaje VALUES('2022-10-20 9:03:00', '2022-10-20 14:04:00', 4, 4, 4, 15, 1, 100, 400)
INSERT INTO Viaje VALUES('2022-10-20 10:03:00', '2022-10-20 14:04:00', 1, 1, 5, 15, 1, 220, 600)

/**
	1-Indique cuales son los autos con mayor cantidad de kilómetros realizados en el
	último mes.
**/
ALTER VIEW sumKm(matricula, KM) as
SELECT aut.matricula, SUM(via.kmTotales)KM FROM Viaje via, Autoo aut
WHERE aut.matricula = via.autoo AND MONTH(via.fechaHoraInicio) = '10'
GROUP BY aut.matricula


SELECT * FROM sumKm WHERE KM = ALL(SELECT MAX(KM) FROM sumKm)

SELECT * FROM Cliente
INSERT INTO Cliente VALUES(1, 'Calle 1', 123, 'Localidad 1')
INSERT INTO Cliente VALUES(2, 'Calle 2', 143, 'Localidad 5')
INSERT INTO Cliente VALUES(3, 'Calle 3', 153, 'Localidad 8')
INSERT INTO Cliente VALUES(4, 'Calle 4', 777, 'Localidad 7')
INSERT INTO Cliente VALUES(5, 'Calle 5', 666, 'Localidad 2')
/**
	2-  Indique los clientes que más viajes hayan realizado con el mismo chofer.
**/

SELECT  clie.nroCliente, COUNT(via.chofer)cantVia FROM Cliente clie, Viaje via
WHERE clie.nroCliente = via.cliente
GROUP BY clie.nroCliente









