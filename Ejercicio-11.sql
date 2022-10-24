CREATE TABLE Genero
(
	id int,
	nombreGenero varchar(50),
	CONSTRAINT pkGenero PRIMARY KEY(id)
)

CREATE TABLE Director
(
	id int,
	NyA varchar(50),
	CONSTRAINT pkDirector PRIMARY KEY(id)
)

CREATE TABLE Cliente 
(
	codCliente int,
	nya varchar(60),
	direccion varchar(60),
	tel int,
	mail varchar(50),
	borrado int,

	CONSTRAINT pkCliente PRIMARY KEY (codCliente)
)

CREATE TABLE Pelicula
(
	codPel int,
	titulo varchar(50),
	duracion int,
	codGenero int,
	idDirector int,
	CONSTRAINT pkPelicula PRIMARY KEY (codPel),
	CONSTRAINT fkGenerPel FOREIGN KEY(codGenero) REFERENCES GENERO(ID) ON UPDATE CASCADE,
	CONSTRAINT fkDirPel FOREIGN KEY(idDirector) REFERENCES Director(ID)ON UPDATE CASCADE,
)


CREATE TABLE Ejemplar
(
	nroEj int,
	codPel int,
	estado int,
	CONSTRAINT pkEjemplar PRIMARY KEY(nroEj, codPel),
	CONSTRAINT fkEkemplar FOREIGN KEY(codPel) REFERENCES PELICULA(codPel)ON UPDATE CASCADE
)


CREATE TABLE Alquiler
(
	id int,
	nroEj int,
	codPel int,
	codCli int,
	fechaAlq date,
	fechaDev date,

	CONSTRAINT pkAlquiler PRIMARY KEY (id),
	CONSTRAINT fkEjemAlq FOREIGN KEY(nroEj, codPel) REFERENCES EJEMPLAR(nroEj, codPel) ON UPDATE CASCADE,
	CONSTRAINT fkClieAlq FOREIGN KEY(codCli) REFERENCES Cliente(codCliente)ON UPDATE CASCADE
)


insert into cliente values(1,'Maria Pia','Calle 1',123,'mapi@gmail.com',1)
insert into cliente values(2,'Lucas Rullo','Calle 1',123,'lr@gmail.com',1)
insert into cliente values(3,'Emma Gomez','Calle 2',456,'emg@gmail.com',2)
insert into cliente values(4,'Mika Pia','Calle 3',465,'mirp@gmail.com',2)
insert into cliente values(5,'Berpi stark','Calle 4',782,'bsk@gmail.com',1)

insert into genero values(01,'Accion')
insert into genero values(02,'Aventura')
insert into genero values(03,'Baile')
insert into genero values(04,'Romantico')
insert into genero values(05,'Infantil')


insert into director values(01,'Juan Perez')
insert into director values(02,'Juan Lucas')
insert into director values(03,'Juan Gomez')
insert into director values(04,'Enri Hugo')
insert into director values(05,'J Martin')
insert into director values(06,'Mia Gomez')

insert into pelicula values(001,'Rey Leon',2,05,01)
insert into pelicula values(002,'El niño',3,01,01)
insert into pelicula values(003,'Pocajontas',1,02,02)
insert into pelicula values(004,'Charlie',5,03,03)
insert into pelicula values(005,'La Muerte',2,02,04)
insert into pelicula values(006,'La Vida',7,01,06)
insert into pelicula values(007,'Los Gatos',3,01,06)
insert into pelicula values(008,'Enemigos',6,04,05)
insert into pelicula values(009,'Moana',2,04,01)
insert into pelicula values(010,'Cars',1,02,06)


insert into ejemplar values(1,001,1)
insert into ejemplar values(2,002,1)
insert into ejemplar values(3,003,1)
insert into ejemplar values(4,004,0)
insert into ejemplar values(5,005,1)
insert into ejemplar values(6,006,1)
insert into ejemplar values(7,007,0)
insert into ejemplar values(8,008,1)
insert into ejemplar values(9,009,1)
insert into ejemplar values(10,010,1)
insert into ejemplar values(11,001,0)
insert into ejemplar values(12,009,0)

insert into alquiler values(1,1,001,1,'2022-10-19','2022-10-20')
insert into alquiler values(2,2,002,1,'2022-10-2','2022-10-3')
insert into alquiler values(3,3,003,2,'2022-10-1','2022-10-2')
insert into alquiler values(4,4,004,2,'2022-10-10','2022-10-11')
insert into alquiler values(5,5,005,3,'2022-10-12','2022-10-13')
insert into alquiler values(6,6,006,3,'2022-10-19','2022-10-20')
insert into alquiler values(7,7,007,4,'2022-10-5','2022-10-6')
insert into alquiler values(8,8,008,5,'2022-10-2','2022-10-20')
insert into alquiler values(9,9,009,5,'2022-10-19','2022-10-22')
insert into alquiler values(10,10,010,2,'2022-10-17','2022-10-20')
insert into alquiler values(11,11,001,2,'2022-10-2','2022-10-5')
insert into alquiler values(12,12,009,3,'2022-9-19','2022-10-1')
insert into alquiler values(13,1,001,4,'2022-9-11','2022-10-2')
insert into alquiler values(14,2,002,5,'2022-9-12','2022-10-3')
insert into alquiler values(15,8,008,5,'2022-8-5','2022-10-1')


/**
	3- Agregue el atributo “año” en la tabla Película.
**/
ALTER TABLE PELICULA ADD anio DATE

SELECT * FROM Pelicula


/**
	4- Actualice la tabla película para que incluya el año de lanzamiento de las películas
	en stock.
**/

UPDATE Pelicula SET anio = '2001' where codPel = 1
UPDATE Pelicula SET anio = '2005' where codPel = 2
UPDATE Pelicula SET anio = '2015' where codPel = 3
UPDATE Pelicula SET anio = '2010' where codPel = 4
UPDATE Pelicula SET anio = '2004' where codPel = 5
UPDATE Pelicula SET anio = '1997' where codPel = 6
UPDATE Pelicula SET anio = '1993' where codPel = 7
UPDATE Pelicula SET anio = '2022' where codPel = 8
UPDATE Pelicula SET anio = '2013' where codPel = 9
UPDATE Pelicula SET anio = '2012' where codPel = 10

SELECT * FROM Pelicula
SELECT * FROM Ejemplar
SELECT * FROM Alquiler

/**
	5- Queremos que al momento de eliminar una película se eliminen todos los
	ejemplares de la misma. Realice una CONSTRAINT para esta tarea..
**/
ALTER TABLE EJEMPLAR
DROP CONSTRAINT fkEkemplar

ALTER TABLE EJEMPLAR ADD
CONSTRAINT fkEkemplar FOREIGN KEY(codPel) REFERENCES PELICULA(codPel)ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE ALQUILER
DROP CONSTRAINT fkEjemAlq

ALTER TABLE ALQUILER ADD
CONSTRAINT fkEjemAlq FOREIGN KEY(nroEj, codPel) REFERENCES EJEMPLAR(nroEj, codPel) ON DELETE CASCADE ON UPDATE CASCADE

DELETE FROM Pelicula  WHERE titulo LIKE 'Rey Leon'

/**
	6- Queremos que exista un borrado de lógico y no físico de clientes, realice un
	TRIGGER que usando el atributo “Borrado” haga esta tarea.
**/

CREATE TRIGGER tgBorrarClientes 
ON Cliente INSTEAD OF DELETE 
AS
IF NOT EXISTS (SELECT 1 FROM Alquiler alq WHERE alq.codCli in (SELECT codCliente FROM deleted)) 
			delete from Cliente
			WHERE codCliente IN (SELECT codCliente FROM deleted)

/**
	7- Elimine las películas de las que no se hayan alquilado ninguna copia.
**/

DELETE FROM Pelicula  WHERE codPel !=  
(
	SELECT codPel FROM Alquiler
)


SELECT * FROM Alquiler
SELECT * FROM Pelicula
SELECT * FROM Cliente









