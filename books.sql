create table editoriales (
	codigo integer not null primary key,
	nombre varchar(30) not null
);

create table libros (
	codigo integer not null primary key,
	titulo varchar (80) not null,
	codigo_editorial integer not null references editoriales(codigo)
);

insert into editoriales values 
(1, 'Anaya'), 
(2, 'Andina'), 
(3, 'S.M.');

insert into libros values
(1, 'Don Quijote de La Mancha I', 1),
(2, 'El principito', 2), 
(3, 'El príncipe', 3), 
(4, 'Diplomacia', 3), 
(5, 'Don Quijote de La Mancha II', 1);

alter table libros add autor varchar;
alter table libros add precio numeric;

update libros set autor = 'Miguel de Cervantes', precio = 150 where codigo = 1;

update libros set autor = 'Antoine SaintExupery', precio = 120 where codigo = 2;

update libros set autor = 'Maquiavelo', precio = 180 where codigo = 3;

update libros set autor = 'Henry Kissinger', precio = 170 where codigo = 4;

update libros set autor = 'Miguel de Cervantes', precio = 140 where codigo = 5;

insert into libros values
(6, 'Metamorfosis', 2, 'Franz Kefka', 120),
(7, 'Critica a la razon pura', 1, 'Albert Camus', 160);

begin;
delete from libros where codigo_editorial = '1';
rollback;

SAVEPOINT before_update;

UPDATE editoriales SET nombre = 'Iberlibro' WHERE nombre = 'Andina';
UPDATE editoriales SET nombre = 'Mountain' WHERE nombre = 'S.M.';

ROLLBACK TO SAVEPOINT before_update;

drop table editoriales;
drop table libros;