CREATE DATABASE Ejercicio13
use Ejercicio13


/**
	1- p_CrearEntidades(): Realizar un procedimiento que permita crear las tablas
	de nuestro modelo relacional.**/-- 1 p_CrearEntidades(): Realizar un procedimiento que permita crear las tablas de nuestro modelo relacional.
create or alter procedure p_crearEntidades
as
begin
      
create table nivel
(
    codigo int primary key,
    descripcion varchar(50),
)

create table medicion
(
    fecha date,
    hora time,
    metrica varchar(5),
    temp float,
    presion float,
    humedad float,
    nivel int,
    primary key(fecha,hora,metrica),
    constraint fkNivel foreign key(nivel) references nivel(codigo) on update cascade,
    
)
end

exec p_crearEntidades

insert into nivel values(1,'desc 1')
insert into nivel values(2,'desc 2')
insert into nivel values(3,'desc 3')
insert into nivel values(4,'desc 4')
insert into nivel values(5,'desc 5')


insert into medicion values('2022-10-31',GETDATE(),'M1',5.1,6.4,4.1,1)
insert into medicion values('2022-11-5',GETDATE(),'M1',5.1,7.1,5,1)
insert into medicion values('2022-10-31','13:13','M2',5.5,7.4,2.1,2)
insert into medicion values('2022-10-10','11:13','M3',5.2,7.8,1.1,3)
insert into medicion values('2022-10-8','11:13','M3',4.1,8.1,3.6,3)
insert into medicion values('2022-9-5','9:13','M4',6.1,1.2,7.5,4)
insert into medicion values('2022-8-1','10:17','M5',5.5,7.4,2.1,5)

/**
	2- f_ultimamedicion(Métrica): Realizar una función que devuelva la fecha y hora
	de la última medición realizada en una métrica específica, la cual será enviada
	por parámetro. La sintaxis de la función deberá respetar lo siguiente:
	Fecha/hora = f_ultimamedicion(vMetrica char(5))
	Ejemplificar el uso de la función.
**/

CREATE OR ALTER FUNCTION f_ultimamedicion(@metrica varchar(5))
returns DATETIME
AS
BEGIN
	DECLARE @FECHAHOR DATETIME
	DECLARE @FECMIN DATE
	DECLARE @HORAMIN TIME

	SET @FECMIN = (SELECT MIN(FECHA) FROM medicion  WHERE  metrica LIKE @metrica)

	SET @HORAMIN = (SELECT MIN(HORA) FROM medicion  WHERE  metrica LIKE @metrica)


	DECLARE @MET VARCHAR(5)
	SET @MET = (SELECT med.metrica FROM medicion med WHERE med.metrica LIKE @metrica AND @FECMIN = med.fecha AND @HORAMIN = med.hora)
	
	SET @FECHAHOR = CONVERT(DATETIME, @FECMIN) + CONVERT(DATETIME, @HORAMIN)

	RETURN @FECHAHOR
END


select DBO.f_ultimamedicion('M1') AS 'FECHA + HORA'

/**
	3- v_Listado: Realizar una vista que permita listar las métricas en las cuales se
		hayan realizado, en la última semana, mediciones para todos los niveles
		existentes. El resultado del listado deberá mostrar, el nombre de la métrica que
		respete la condición enunciada, el máximo nivel de temperatura de la última
		semana y la cantidad de mediciones realizadas también en la última semana.
**/

create view v_Listado(metrica,medRealiz,maxTemp) as
select metrica,count(metrica),max(temp)from medicion
where fecha between '2022-10-24' and '2022-10-31' 
and temp = all(select max(temp) from medicion where fecha between '2022-10-24' and '2022-10-31') group by( metrica)

select *from v_Listado