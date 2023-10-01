CREATE TABLE articulo (
  codigo INT PRIMARY KEY,
  nombre_articulo VARCHAR(100),
  precio MONEY
);

CREATE TABLE cliente (
  id integer PRIMARY KEY,
  cliente VARCHAR(50),
  ciudad VARCHAR(50)
);

CREATE TABLE orden (
  id INT PRIMARY KEY,
  fecha DATE,
  id_cliente INT REFERENCES cliente(id)
);

CREATE TABLE cantidadordenes (
  cantidad INT,
  id_orden INT REFERENCES orden(Id)
);

CREATE TABLE detallesordenes (
  codigo_articulo INT REFERENCES articulo(codigo),
  id_orden INT REFERENCES orden(id)
);

insert into articulo values 
(3786, 'Red', 35.00),
(4011, 'Raqueta', 65.00),
(9132, 'Paq-3', 4.75),
(5794, 'Paq-6', 5.00),
(3141, 'Funda', 10.00);

insert into cliente values
(101, 'Martin', 'Santiago'),
(107, 'Herman', 'Valparaiso'),
(110, 'Pedro', 'Concepcion');

insert into orden values
(2301, '23-02-2020', 101),
(2302, '25-02-2020', 107),
(2303, '27-02-2020', 110);

insert into cantidadordenes values
(3, 2301),
(8, 2301),
(4, 2302),
(2, 2303),
(2, 2303);