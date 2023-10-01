create table peliculas(
	id integer primary key,
	pelicula varchar(100),
	estreno numeric(10),
	director varchar(100)
);

create table reparto(
	id_pelicula integer references peliculas(id),
	actor varchar(100)
);

--7. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto.
SELECT p.pelicula, p.estreno, p.director, r.actor 
FROM peliculas p
JOIN reparto r ON p.id = r.id_pelicula
WHERE p.pelicula = 'Titanic';

--8. Listar los 10 directores más populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT p.director, COUNT(*) AS peliculas_top100
FROM peliculas p
WHERE p.id IN (
    SELECT id
    FROM peliculas
    ORDER BY estreno DESC
)
GROUP BY p.director
ORDER BY peliculas_top100 DESC
LIMIT 10;

--9. Indicar cuántos actores distintos hay.
SELECT COUNT(DISTINCT actor) AS total_actores
FROM reparto;

--10. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos), ordenadas por título de manera ascendente.
select pelicula, estreno from peliculas where estreno >= 1990 and estreno <= 1999 order by estreno asc;

--11. Listar los actores de la película más nueva.
SELECT p.pelicula, r.actor
FROM peliculas p
JOIN reparto r ON p.id = r.id_pelicula
WHERE p.estreno = (
    SELECT MAX(estreno)
    FROM peliculas
);

--12. Inserte los datos de una nueva película solo en memoria, y otra película en el disco duro.
begin;
insert into peliculas values
(101, 'The Princess Bride', 1987, 'Rob Reiner');

savepoint memory;
insert into peliculas values
(102, 'El color del dinero', 1986, 'Martin Scorsese');
rollback to memory;

commit;

--13. Actualice 5 directores utilizando ROLLBACK.
begin;
update peliculas set director = 'Georgy' where director = 'George Lucas';
update peliculas set director = 'Alfredito' where director = 'Alfred Hitchcock';
update peliculas set director = 'Twister' where director = 'M. Night Shyamalan';
update peliculas set director = 'Explosive' where director = 'Michael Bay';
update peliculas set director = 'Feet guy' where director = 'Quentin Tarantino';
rollback;

--14. Inserte 3 actores a la película “Rambo” utilizando SAVEPOINT
begin;
savepoint update_cast;
INSERT INTO reparto (id_pelicula, actor) VALUES
((SELECT id FROM peliculas WHERE pelicula = 'Rambo'), 'Harrison Ford'),
((SELECT id FROM peliculas WHERE pelicula = 'Rambo'), 'Julia Roberts'),
((SELECT id FROM peliculas WHERE pelicula = 'Rambo'), 'George Clooney');
rollback to update_cast;  

--15. Elimina las películas estrenadas el año 2008 solo en memoria.
begin;
DELETE FROM reparto WHERE id_pelicula = (SELECT id FROM peliculas WHERE estreno = 2008);
delete from peliculas where estreno = 2008;
rollback;

--16. Inserte 2 actores para cada película estrenada el 2001.
select id from peliculas where estreno = 2001;

insert into reparto values
(13, 'Michael J. Fox'),
(13, 'Ryan Gosling'),
(16, 'Michael J. Fox'),
(16, 'Ryan Gosling'),
(55, 'Michael J. Fox'),
(55, 'Ryan Gosling'),
(78, 'Michael J. Fox'),
(78, 'Ryan Gosling'),
(94, 'Michael J. Fox'),
(94, 'Ryan Gosling'),
(99, 'Michael J. Fox'),
(99, 'Ryan Gosling');

--17. Actualice la película “King Kong” por el nombre de “Donkey Kong”, sin efectuar cambios en disco duro.
begin;
update peliculas set pelicula = 'Donkey Kong' where pelicula = 'King Kong';
rollback;
