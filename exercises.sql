-- Creación de la tabla "autores"
CREATE TABLE autores (
 id SERIAL PRIMARY KEY,
 nombre VARCHAR(100),
 nacionalidad VARCHAR(100)
);
-- Creación de la tabla "libros"
CREATE TABLE libros (
 id SERIAL PRIMARY KEY,
 titulo VARCHAR(100),
 autor_id INTEGER REFERENCES autores(id),
 precio NUMERIC(10, 2)
);
-- Creación de la tabla "comentarios"
CREATE TABLE comentarios (
 id SERIAL PRIMARY KEY,
 libro_id INTEGER REFERENCES libros(id),
 comentario TEXT
);
-- Inserción de datos de ejemplo en la tabla "autores"
INSERT INTO autores (nombre, nacionalidad) VALUES
 ('Gabriel García Márquez', 'Colombia'),
 ('J.K. Rowling', 'Reino Unido'),
 ('Haruki Murakami', 'Japón'),
 ('Isabel Allende', 'Chile'),
 ('Jorge Luis Borges', 'Argentina'),
 ('Mario Vargas Llosa', 'Perú'),
 ('Laura Esquivel', 'México');
-- Inserción de datos de ejemplo en la tabla "libros"
INSERT INTO libros (titulo, autor_id, precio) VALUES
 ('Cien años de soledad', 1, 19.99),
 ('Harry Potter y la piedra filosofal', 2, 14.99),
 ('Tokio blues', 3, 12.99),
 ('La casa de los espíritus', 4, 14.99),
 ('Ficciones', 5, 9.99),
 ('La ciudad y los perros', 6, 12.99),
 ('Como agua para chocolate', 7, 11.99),
 ('Crónica de una muerte anunciada', 1, 10.99),
 ('El amor en los tiempos del cólera', 1, 12.99),
 ('Paula', 4, 11.99),
 ('Conversación en La Catedral', 6, 13.99);

-- Inserción de datos de ejemplo en la tabla "comentarios"
INSERT INTO comentarios (libro_id, comentario) VALUES
 (1, 'Excelente libro'),
 (1, 'Me encantó la narrativa'),
 (2, 'Una historia mágica'),
 (3, 'Me transportó a Japón'),
 (4, 'Una novela fascinante'),
 (4, 'Personajes inolvidables'),
 (5, 'Cuentos magistrales'),
 (5, 'Una mente brillante. ¡Excelente!'),
 (6, 'Una historia impactante'),
 (7, 'Una mezcla perfecta de amor y cocina'),
 (9, 'Una obra maestra de la literatura'),
 (11, 'Personajes inolvidables');

ALTER TABLE comentarios ADD COLUMN fecha_creacion TIMESTAMP;


--1) Obtener todos los libros con sus respectivos autores.
select l.titulo, a.nombre
from libros l
inner join autores a on l.autor_id = a.id;

--2) Obtener todos los comentarios de un libro específico (ej. Libro con id = 1) con el nombre del libro y el autor.
select l.titulo, a.nombre, c.comentario
from libros l 
join autores a on l.autor_id = a.id 
join comentarios c on l.id = c.libro_id 
where l.id = 1;

--3) Obtener todos los libros escritos por Gabriel García Márquez.
select l.titulo 
from libros l 
join autores a on l.autor_id = a.id 
where a.nombre = 'Gabriel García Márquez';

--4) Obtener el número total de comentarios por libro.
select l.titulo, count(c.id) as total_comentarios
from libros l 
left join comentarios c on l.id = c.libro_id
group by l.titulo ;

--5) Obtener los libros y sus respectivos autores que tienen un precio mayora $15.
select l.titulo, a.nombre, l.precio 
from libros l 
join autores a on l.autor_id = a.id 
where l.precio >= 15.00;

--6) Obtener los autores y la cantidad de libros que han escrito.
select a.nombre, count(l.id) as total_libros
from autores a 
join libros l ON a.id = l.autor_id
group by a.nombre order by total_libros asc;

--7) Obtener los libros y sus comentarios que contienen la palabra "Excelente".
select l.titulo, c.comentario
from libros l 
join comentarios c on l.id = c.libro_id 
where c.comentario ilike '%Excelente%'

--8) Obtener el autor con la mayor cantidad de libros.
select a.nombre, count(l.id)
from autores a 
join libros l on a.id = l.autor_id
group by a.id
limit 1;

--9) Obtener el precio promedio de los libros.
select avg(precio) as promedio
from libros;

--10) Obtener los libros que tienen comentarios asociados.
select distinct  l.titulo
from libros l
join comentarios c on c.libro_id = l.id;

--11) Obtener los libros que NO tienen comentarios asociados.
select l.titulo
from libros l
left join comentarios c on c.libro_id = l.id
where c.id is null;

--12) Obtener los libros y la cantidad de comentarios que tienen.
select l.titulo, count(c.id) as total_comentarios
from libros l
join comentarios c on l.id = c.libro_id 
group by l.id order by total_comentarios asc;

--13) Obtener los autores y sus libros ordenados alfabéticamente por el título del libro.
select a.nombre, l.titulo
from autores a 
join libros l on a.id = l.autor_id
order by l.titulo;

--14) Obtener los libros que tienen un precio superior al promedio de todos los libros.
select l.titulo, l.precio
from libros l 
where l.precio > (select avg(precio) from libros);

--15) Obtener el autor con el libro más caro.
select a.nombre, l.titulo, l.precio as libro_mas_caro
from autores a 
join libros l on a.id = l.autor_id
where l.precio = (select max(precio) from libros);

--16) Obtener los libros y sus comentarios ordenados por la fecha de creación del comentario de forma descendente.
select l.titulo, c.comentario
from libros l
join comentarios c on c.libro_id = l.id
order by comentarios.id desc;

--17) Obtener los autores y la cantidad de comentarios que tienen en total en sus libros.
select a.nombre, count(c.id) as total_comentarios
from autores a 
join comentarios c on a.id = c.libro_id 
group by a.id order by total_comentarios asc;