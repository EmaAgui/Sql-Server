create table rubro
(
    codRubro int primary key,
    nomRubro varchar(50),
)

create table pelicula 
(
    codPel int primary key,
    titulo varchar(100),
    duracion int,
    año int,
    codRubro int,
    constraint fkRub foreign key(codRubro) references rubro(codRubro) on update cascade 
)

create table ejemplar
(
    codEjemplar int,
    codPel int,
    estado varchar(50),
    ubicacion varchar(50),
    constraint pkeje primary key(codEjemplar, codPel),
    constraint fkpel foreign key(codPel) references pelicula(codpel) on update cascade,
)

create table cliente
(
    codCliente int primary key,
    nombre varchar(50),
    apellido varchar(50),
    direccion varchar(50),
    tel int,
    mail varchar(30),
)

create table prestamo
(
    codPrestamo int,
    codEjemplar int,
    codPel int,
    codCliente int,
    fPrest date,
    fDev date,
    constraint pkPrest primary key(codPrestamo),
    constraint fkEjem foreign key(codEjemplar, codPel) references ejemplar(codEjemplar, codPel) on update cascade,
    constraint fkclien foreign key(codCliente) references cliente(codCliente) on update cascade,
)

select * from prestamo



insert into rubro values (1,'Policial')
insert into rubro values (2,'Drama')
insert into rubro values (3,'Romance')
insert into rubro values (4,'Comedia')
insert into rubro values (5,'Familiar')
insert into rubro values (6,'Accion')

insert into pelicula values(1,'Rey Leon',2,2008,5)
insert into pelicula values(2,'Terminator',3,2005,6)
insert into pelicula values(3,'Harry potter',2,2004,4)
insert into pelicula values(4,'jurassic park 3',3,2001,2)
insert into pelicula values(5,'Policias',3,2022,1)

insert into ejemplar values(1,1,'Libre','a')
insert into ejemplar values(2,1,'ocupado','a')
insert into ejemplar values(3,2,'ocupado','b')
insert into ejemplar values(4,2,'libre','b')
insert into ejemplar values(5,5,'libre','c')
insert into ejemplar values(6,3,'libre','d')
insert into ejemplar values(7,4,'ocupado','e')

insert into cliente values(1,'Maria','Pia','Calle 1',123,'mapi@gmail.com')
insert into cliente values(2,'Lucas','Rullo','Calle 1',123,'lr@gmail.com')
insert into cliente values(3,'Emma','Gomez','Calle 2',456,'emg@gmail.com')
insert into cliente values(4,'Mika','Pia','Calle 3',465,'mirp@gmail.com')
insert into cliente values(5,'Berpi','stark','Calle 4',782,'bsk@gmail.com')

insert into prestamo values(1,1,1,2,'2022-10-17',NULL)
insert into prestamo values(2,2,1,3,'2022-09-10','2022-09-15')
insert into prestamo values(3,5,5,5,'2022-05-08','2022-05-20')
insert into prestamo values(4,5,5,1,'2022-10-16','2022-10-17')
insert into prestamo values(5,7,4,4,'2021-10-17',NULL)
insert into prestamo values(6,2,1,3,'2022-09-17','2022-09-25')
insert into prestamo values(7,3,2,2,'2022-10-01','2022-10-05')
insert into prestamo values(8,6,3,2,'2022-10-01','2022-10-05')
insert into prestamo values(9,7,4,2,'2022-10-01','2022-10-05')
insert into prestamo values(10,5,5,2,'2022-10-01','2022-10-05')

/**
	1- Listar los clientes que no hayan reportado préstamos del rubro “Policial”.
**/

select codCliente from cliente
except
select pres.codCliente from prestamo pres where pres.codPel in 
(
	select pel.codPel from pelicula pel where pel.codRubro in
	(
		select rub.codRubro from rubro rub where nomRubro like 'Policial'
	)
)
/**
	2- Listar las películas de mayor duración que alguna vez fueron prestadas.
**/

select max(duracion) from pelicula

select * from prestamo pres where pres.codPel in 
(
	select codPel from pelicula where duracion = all(select max(duracion) from pelicula) 
)

/**
	3- Listar los clientes que tienen más de un préstamo sobre la misma película (listar
	Cliente, Película y cantidad de préstamos).
**/

select pre.codCliente, pre.codPel, count(pre.codPrestamo)cantPrestamos from prestamo pre, prestamo pre2 
where  pre.codCliente = pre2.codCliente and pre.codPrestamo <> pre2.codPrestamo and pre.codPel = pre2.codPel
group by pre.codCliente, pre.codPel

/**
	4- Listar los clientes que han realizado préstamos del título “Rey León” y “Terminador
	3” (Ambos).
**/

	select codCliente from prestamo where codPel in 
	(
		select pel.codPel from pelicula pel where pel.titulo like 'rey leon' 
	)
	intersect
		select codCliente from prestamo where codPel in 
	(
		select pel.codPel from pelicula pel where pel.titulo like 'terminator' 
	)


/**
	5- Listar las películas más vistas en cada mes (Mes, Película, Cantidad de
	Alquileres).
**/


/**
	6- Listar los clientes que hayan alquilado todas las películas del video.
**/select clie.codCliente from cliente clie where  not exists  (	select 1 from pelicula pel where  not exists	(		select 1 from prestamo pres where pres.codPel = pel.codPel and pres.codCliente = clie.codCliente	))select * from prestamo/**
	7- Listar las películas que no han registrado ningún préstamo a la fecha.
**/select pres.codCliente from prestamo pres where pres.fPrest < '2022-10-17' and not exists(	select * from pelicula pres)/**
	8- Listar los clientes que no han efectuado la devolución de ejemplares.
**/
	
	select codCliente from prestamo where fDev is null

/**
	9- Listar los títulos de las películas que tienen la mayor cantidad de préstamos.
**/
create view PelCant(codPel, CantPrestamo) asselect codPel, count(codpel)cantPrestamo from prestamo group by codPelselect codPel from PelCant where CantPrestamo = all(select MAX(CantPrestamo) from PelCant)/**
	10-  Listar las películas que tienen todos los ejemplares prestados.
**/select * from pelicula pel where not exists(	select 1 from ejemplar ejemp where not exists	(		select 1 from prestamo pre where pre.codEjemplar = ejemp.codEjemplar and pre.codPel = ejemp.codPel	))