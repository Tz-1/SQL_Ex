create table empresa (
	rut varchar(10) not null primary key,
	nombre varchar(120) not null,
	direccion varchar (120) not null,
	telefono varchar(15) not null,
	correo varchar(80) not null,
	web varchar(50) not null
);

create table cliente(
	rut varchar(10) not null primary key,
	nombre varchar(120) not null,
	correo varchar(80) not null,
	direccion varchar (120) not null,
	celular varchar(15) not null
);

create table herramienta(
	idherramienta integer not null primary key,
	nombre varchar(120) not null,
	preciodia numeric(12) not null
);

create table arriendo(
	folio integer not null primary key,
	fecha date not null,
	dias numeric(5) not null,
	valordia numeric(12) not null,
	garantia varchar(30) not null,
	herramienta_idherramienta integer not null references herramienta(idherramienta),
	cliente_rut varchar(10) not null references cliente(rut)
);

--Inserte los datos de una empresa.
insert into empresa values
('10794384-4', 'Devil May Cry', 'Av. Demon 7864','+56913473546','woohoopizzaman@dmc.com', 'www.devilmaycry.com');

--Inserte 5 herramientas.
insert into herramienta values
(567, 'Taladro atornillador', 28000),
(248, 'Soldadora', 39000),
(421, 'Set de destornilladores', 19000),
(893, 'Lijadora', 48000),
(124, 'Esmeril', 38000);

--Inserte 3 clientes.
INSERT INTO cliente VALUES 
('13478647-4', 'Marco Arriagada', 'marcoarriagada@mail.com', 'San antonio 7646', '+56947521647'),
('20674218-1', 'Antonio Godoy', 'antogodoy@mail.com', 'San bernando 4624', '+56964513456'),
('18468926-4', 'Harry Perez', 'hperez@mail.com', 'Trinidad 5465', '+56945689721');

--Elimina el último cliente.
delete from cliente where rut = '18468926-4';

--Elimina la primera herramienta.
delete from herramienta where idherramienta = 567;

--Inserte 2 arriendos para cada cliente.
--Primer cliente
insert into arriendo values
(7023, '22-12-2021', 7, 8000, 'Pagaré', 248, '13478647-4'),
(7024, '22-12-2021', 7, 10000, 'Pagaré', 893, '13478647-4');
--Segundo cliente
insert into arriendo values
(8059, '06-08-2022', 3, 6000, 'Sin Garantia', 124, '20674218-1'),
(8060, '06-08-2022', 3, 2000, 'Sin Garantia', 421, '20674218-1');

--Modifique el correo electrónico del primer cliente.
update cliente set correo = 'antonygodo@askmail.com' where rut = '20674218-1';

--Liste todas las herramientas.
select * from herramienta;

--Liste los clientes cuyo nombre contenga una a.
select * from cliente where nombre like '%a%';

--Modifique los primeros 2 arriendos insertados con fecha 15/01/2020.
update arriendo set fecha = '15-01-2020' where folio in (7023, 7024);

--Liste Folio, Fecha y ValorDia de los arriendos de enero del 2020.
select folio, fecha, valordia from arriendo where extract(year from fecha) = 2020;
