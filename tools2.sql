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

insert into empresa values
('10794384-4', 'Devil May Cry', 'Av. Demon 7864','+56913473546','woohoopizzaman@dmc.com', 'www.devilmaycry.com');

insert into herramienta values
(567, 'Taladro atornillador', 28000),
(248, 'Soldadora', 39000),
(421, 'Set de destornilladores', 19000),
(893, 'Lijadora', 48000),
(124, 'Esmeril', 38000);

INSERT INTO cliente VALUES 
('13478647-4', 'Marco Arriagada', 'marcoarriagada@mail.com', 'San antonio 7646', '+56947521647'),
('20674218-1', 'Antonio Godoy', 'antogodoy@mail.com', 'San bernando 4624', '+56964513456'),
('18468926-4', 'Harry Perez', 'hperez@mail.com', 'Trinidad 5465', '+56945689721');

delete from cliente where rut = '18468926-4';

delete from herramienta where idherramienta = 567;

insert into arriendo values
(7023, '15-01-2020', 7, 8000, 'Pagaré', 248, '13478647-4'),
(7024, '15-01-2020', 7, 10000, 'Pagaré', 893, '13478647-4');

insert into arriendo values
(8059, '06-08-2022', 3, 6000, 'Sin Garantia', 124, '20674218-1'),
(8060, '06-08-2022', 3, 2000, 'Sin Garantia', 421, '20674218-1');

update cliente set correo = 'antonygodo@askmail.com' where rut = '20674218-1';

--1. Listar todos los arriendos con las siguientes columnas: Folio, Fecha, Días, ValorDia, NombreCliente, RutCliente.
SELECT a.folio, a.fecha, a.dias, a.valordia, c.nombre AS nombre_cliente, c.rut AS rut_cliente
FROM arriendo a
JOIN cliente c ON a.cliente_rut = c.rut;

--2. Listar los clientes sin arriendos.
select * from cliente where rut not in(select cliente_rut from arriendo);

--3. Liste RUT y Nombre de las tablas empresa y cliente.
select nombre, rut from cliente
union
select nombre, rut from empresa;

--4. Liste la cantidad de arriendos por mes.
SELECT EXTRACT(MONTH FROM fecha) AS mes, COUNT(*) AS cantidad_arriendos FROM arriendo GROUP BY mes order by mes;
