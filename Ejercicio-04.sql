CREATE TABLE Persona
(
	dni int PRIMARY KEY,
	nomPerso varchar(30),
	tel int
)

CREATE TABLE Empresa
(
	nomEmp varchar(100) PRIMARY KEY,
	tel int
)

CREATE TABLE Vive
(
	dni int,
	calle varchar(100),
	ciudad varchar(100),
	CONSTRAINT PKVIVE PRIMARY KEY(dni),
	CONSTRAINT FKVIV FOREIGN KEY(dni) REFERENCES Persona(dni) ON UPDATE CASCADE
)

CREATE TABLE Trabaja
(
	dni int,
	nomEmp varchar(100),
	salario float,
	feIngreso date,
	feEgreso date, 
	CONSTRAINT PKTRAB PRIMARY KEY(dni),
	CONSTRAINT FKTRAB FOREIGN KEY(dni) REFERENCES Persona(dni) ON UPDATE CASCADE,
	CONSTRAINT FKTRABA FOREIGN KEY(nomEmp) REFERENCES Empresa(nomEmp) ON UPDATE CASCADE
)

CREATE TABLE SituadaEn
(
	dniPer int,
	dniSup int,


	CONSTRAINT PKSIT PRIMARY KEY(nomEmp),
	CONSTRAINT FKSIT FOREIGN KEY(nomEmp) REFERENCES Empresa(nomEmp) ON UPDATE CASCADE
)

CREATE TABLE Supervisa
(
	dniPer int,
	dniSup int,

	CONSTRAINT PKSup PRIMARY KEY(dniPer, dniSup),
	CONSTRAINT FKSup FOREIGN KEY(dniSup) REFERENCES Persona(dni),
	CONSTRAINT FKSupe FOREIGN KEY(dniPer) REFERENCES Persona(dni)
)

SELECT *FROM Persona

insert into Persona values(43666521,'Maria Pia',22365)
insert into Persona values(48555213,'Mika Gonzales',3349)
insert into Persona values(14556982,'Ema Gomez',485123)
insert into Persona values(77592131,'Lucas Rullo',145236)
insert into Persona values(75222965,'Tony Stark',147592)
insert into Persona values(42333651,'Claudia Manda',751236)
insert into Persona values(12336547,'Salma Lujan',745123)

SELECT *FROM Empresa

insert into Empresa values('Bancelco', 123)
insert into Empresa values('Telecom', 456)
insert into Empresa values('Paulinas', 789)
insert into Empresa values('Clarin', 134)
insert into Empresa values('Sony', 781)


SELECT *FROM Vive

insert into Vive values(43666521,'Calle 1','Caballito')
insert into Vive  values(48555213,'Calle 1','Caballito')
insert into Vive  values(14556982,'Calle 5','San Justo')
insert into Vive  values(7759213,'Calle 25','La Plata')
insert into Vive  values(75222965,'Calle 7','La Plata')
insert into Vive  values(42333651,'Calle 5','Lomas')
insert into Vive  values(12336547,'Calle 5','Huergo')

SELECT * FROM Trabaja

insert into Trabaja values(43666521,'Bancelco',4000,'2022-10-15', NULL)
insert into Trabaja  values(48555213,'Telecom',1000,'2000-10-15',NULL)
insert into Trabaja  values(14556982,'Paulinas',200,'2000-01-10','2000-01-13')
insert into Trabaja  values(7759213,'Bancelco',50,'2015-02-05','2018-10-15')
insert into Trabaja  values(75222965,'Clarin',4201,'2021-09-11','2002-02-15')
insert into Trabaja  values(42333651,'Clarin',15720,'2022-09-07','2022-10-05')
insert into Trabaja  values(12336547,'Telecom',112541,'2004-02-02','2005-10-15')


insert into SituadaEn values('Bancelco', 'Caballito')
insert into SituadaEn values('Telecom','San Justo')
insert into SituadaEn values('Paulinas', 'Hornos')
insert into SituadaEn values('Clarin', 'La Plata')
insert into SituadaEn values('Sony', 'Caballito')


insert into Supervisa values(43666521, 48555213)
insert into Supervisa values(14556982, 7759213)
insert into Supervisa values(75222965,42333651)
insert into Supervisa values(12336547, 43666521)
insert into Supervisa values(7759213,43666521)

/**
	1- Encontrar el nombre de todas las personas que trabajan en la empresa “Banelco”
**/

select nomPerso from Persona where dni in
(
select dni from Trabaja WHERE nomEmp Like 'Bancelco'
)

/**
	2- Localizar el nombre y la ciudad de todas las personas que trabajan para la
	empresa “Telecom”.
**/

select viv.ciudad, per.nomPerso from Vive viv, Persona per where viv.dni like per.dni and per.dni in
(
	select dni from Trabaja WHERE nomEmp Like 'Telecom'
)

/**
	3- Buscar el nombre, calle y ciudad de todas las personas que trabajan para la
	empresa “Paulinas” y ganan más de $1500. >150
**/
select viv.ciudad, per.nomPerso, viv.calle from Vive viv, Persona per where viv.dni like per.dni and per.dni in
(
	select dni from Trabaja WHERE nomEmp Like 'Paulinas' and salario > 150
)

/**
	4- Encontrar las personas que viven en la misma ciudad en la que se halla la
	empresa en donde trabajan.
**/
	select viv.dni from Vive viv, SituadaEn sit where viv.ciudad like sit.ciudad and viv.dni in
	(
		select trab.dni from Trabaja trab where trab.nomEmp like sit.nomEmp
	)

/**
	5- Hallar todas las personas que viven en la misma ciudad y en la misma calle que
	su supervisor.
**/

create view perso(dni,calle,ciudad) as
select *from Vive where dni in
(
    select dniPer from Supervisa 
)

create view sup(dni,calle,ciudad) as
select *from Vive where dni in
(
    select dniSup from Supervisa 
)

select per.dni,su.dni from perso per cross join sup su where per.dni <> su.dni and per.calle = su.calle and per.ciudad = su.ciudad

/**
	6- Encontrar todas las personas que ganan más que cualquier empleado de la
	empresa “Clarín”.
**/
SELECT DNI FROM TRABAJA WHERE salario >
(
	SELECT MAX(trab.salario) FROM Trabaja trab WHERE trab.nomEmp LIKE 'CLARIN'
)

/**
	7- Localizar las ciudades en las que todos los trabajadores que vienen en ellas
	ganan más de $1000.	
	HUERGO - LOMAS -  
**/

SELECT	* FROM	Alumno a WHERE   NOT EXISTS
(
	SELECT * FROM   Materia m WHERE  anio_carrera = 3 AND  NOT EXISTS
	(
		SELECT * FROM   Cursa c WHERE  c.legajo = a.legajo AND c.cod_mat = m.cod_mat
	)
)

SELECT viv.ciudad FROM VIVE viv WHERE NOT EXISTS
(
	SELECT * FROM Trabaja trab WHERE trab.salario > 1000 AND NOT EXISTS
	(
		SELECT * FROM Persona per WHERE per.dni = trab.dni
	)
)

SELECT viv.ciudad FROM VIVE viv WHERE NOT EXISTS
(
	SELECT * FROM Persona per WHERE per.dni =  viv.dni AND NOT EXISTS
	(
		SELECT * FROM Trabaja trab WHERE trab.salario > 1000 AND per.dni = trab.dni
	)
)





SELECT viv.ciudad FROM Vive viv WHERE  NOT EXISTS 
(
	SELECT 1 FROM Trabaja trab WHERE salario > 1000 AND NOT EXISTS
	(
		SELECT 1 FROM Trabaja trab1 WHERE trab1.dni = viv.dni
	)
)


/**
	8- Listar los primeros empleados que la compañía “Sony” contrató.
**/

SELECT DNI FROM Trabaja WHERE feIngreso = 
(
	SELECT MIN(FEINGRESO) FROM TRABAJA WHERE nomEmp LIKE 'CLARIN'
)
/**
	8- Listar los primeros empleados que la compañía “Sony” contrató.
**/