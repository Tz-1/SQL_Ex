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

--1 Listar los clientes sin ventas por medio de una subconsulta
SELECT rut, nombre
FROM cliente
WHERE rut NOT IN (SELECT DISTINCT cliente_rut FROM venta);

--2 Listar todas ventas con las siguientes columnas: Folio, Fecha, Monto, NombreCliente, RutCliente. 
SELECT v.folio, v.fecha, v.monto, c.nombre AS NombreCliente, c.rut AS RutCliente
FROM venta v
JOIN cliente c ON v.cliente_rut = c.rut;

--3 Clasificar los clientes según la siguiente tabla:
SELECT c.rut, c.nombre, SUM(v.monto) AS total_ventas_anuales, 
       CASE 
           WHEN SUM(v.monto) <= 1000000 THEN 'Standard'
           WHEN SUM(v.monto) > 1000000 AND SUM(v.monto) <= 3000000 THEN 'Gold'
           WHEN SUM(v.monto) > 3000000 THEN 'Premium'
           ELSE 'N/A'
       END AS Clasificacion
FROM cliente c
LEFT JOIN venta v ON c.rut = v.cliente_rut
GROUP BY c.rut, c.nombre;

--4 Por medio de una subconsulta, listar las ventas con la marca del vehículo más vendido.
SELECT v.folio, v.fecha, v.monto, c.nombre AS NombreCliente, c.rut AS RutCliente, m.nombre AS MarcaVehiculo
FROM venta v
JOIN cliente c ON v.cliente_rut = c.rut
JOIN vehiculo ve ON v.vehiculo_idvehiculo = ve.idvehiculo
JOIN marca m ON ve.marca_idmarca = m.idmarca
WHERE ve.marca_idmarca = (SELECT marca_idmarca FROM vehiculo GROUP BY marca_idmarca ORDER BY COUNT(*) DESC LIMIT 1);
