create table empresa(
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
	celular varchar(15) not null,
	alta char(1) not null
);

create table marca(
	idmarca integer not null primary key,
	nombre varchar(120) not null
);

create table tipovehiculo(
	idtipovehiculo integer not null primary key,
	nombre varchar(120) not null
);

create table vehiculo(
	idvehiculo integer not null primary key,
	patente varchar(10) not null,
	marca varchar(20) not null,
	modelo varchar(20) not null,
	color varchar(15) not null,
	precio numeric(12) not null,
	frecuenciamantencion numeric(5) not null,
	marca_idmarca integer not null references marca(idmarca),
	tipovehiculo_idtipovehiculo integer not null references tipovehiculo(idtipovehiculo)
);

create table venta(
	folio integer not null primary key,
	fecha date not null,
	monto numeric(12) not null,
	vehiculo_idvehiculo integer not null unique references vehiculo(idvehiculo),
	cliente_rut varchar(10) not null references cliente(rut)
);

create table mantencion(
	idmantencion integer not null primary key,
	fecha date not null,
	trabajosrealizados varchar(1000) not null,
	venta_folio integer not null references venta(folio)
);

insert into empresa values
('10794384-4', 'Devil May Cry', 'Av. Demon 7864','+56913473546','woohoopizzaman@dmc.com', 'www.devilmaycry.com');

insert into tipovehiculo values
(1, 'Auto'),
(2, 'Camioneta');


INSERT INTO cliente VALUES 
('13478647-4', 'Marco Arriagada', 'marcoarriagada@mail.com', 'San antonio 7646', '+56947521647', 'S'),
('20674218-1', 'Antonio Godoy', 'antogodoy@mail.com', 'San bernando 4624', '+56964513456', 'S'),
('18468926-4', 'Harry Perez', 'hperez@mail.com', 'Trinidad 5465', '+56945689721', 'S');

INSERT INTO marca VALUES 
(1, 'Ford'), 
(2, 'Chevrolet');


INSERT INTO vehiculo VALUES 
(1, 'AB1234', 'Toyota', 'Corolla', 'Blanco', 6990000, 8000, 1, 1), 
(2, 'CD5678', 'Nissan', 'Frontier', 'Negro', 19500000, 10000, 2, 2), 
(3, 'EF9012', 'Toyota', 'Yaris', 'Azul', 8540000, 8000, 1, 1), 
(4, 'GH3456', 'Nissan', 'X-Trail', 'Gris', 12290000, 8000, 2, 2), 
(5, 'IJ7890', 'Toyota', 'Hilux', 'Rojo', 16780000, 10000, 1, 2);

DELETE FROM cliente WHERE rut = '18468926-4';

INSERT INTO venta VALUES 
(1, '2021-10-01', 19500000, 2, '13478647-4'),
(2, '2021-10-02', 8540000, 3, '20674218-1');


UPDATE cliente SET nombre = 'Alex Urrutia' WHERE rut = '20674218-1';

--1. Listar todos los vehículos que no han sido vendidos.
select * from vehiculo where idvehiculo not in(select vehiculo_idvehiculo from venta);

--2. Listar todas las ventas de enero del 2020 con las columnas: Folio, FechaVenta, MontoVenta, NombreCliente, RutCliente, Patente, NombreMarca, y Modelo.
SELECT v.folio, v.fecha, v.monto, c.nombre AS nombre_cliente, c.rut AS rut_cliente, ve.patente, m.nombre AS nombre_marca, ve.modelo
FROM venta v
JOIN cliente c ON v.cliente_rut = c.rut
JOIN vehiculo ve ON v.vehiculo_idvehiculo = ve.idvehiculo
JOIN marca m ON ve.marca_idmarca = m.idmarca
WHERE v.fecha >= '2021-01-01' AND v.fecha < '2021-12-01';


--3. Sumar las ventas por mes y marca del año 2021.
SELECT EXTRACT(MONTH FROM v.fecha) AS mes, m.nombre AS nombre_marca, count(*) AS total_ventas
FROM venta v
JOIN vehiculo ve ON v.vehiculo_idvehiculo = ve.idvehiculo
JOIN marca m ON ve.marca_idmarca = m.idmarca
WHERE v.fecha >= '2021-01-01' AND v.fecha < '2022-01-01'
GROUP BY mes, m.nombre;

--4. Listar Rut y Nombre de las tablas cliente y empresa.
select nombre, rut from cliente
union
select nombre, rut from empresa;