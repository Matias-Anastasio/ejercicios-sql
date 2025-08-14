SELECT a.nombre,a.apellido,c.nombre_curso FROM alumnos a INNER JOIN inscripciones i USING (id_alumno) INNER JOIN cursos c USING (id_curso);

SELECT a.nombre,a.apellido FROM alumnos a LEFT JOIN inscripciones i USING (id_alumno) WHERE i.id_inscripcion IS NULL;

SELECT c.nombre_curso, count(*) AS cantidad_alumnos FROM alumnos INNER JOIN inscripciones i USING (id_alumno) INNER JOIN cursos c USING(id_curso) GROUP BY c.nombre_curso;

ALTER TABLE alumnos ADD COLUMN promedio_final DECIMAL(5,2);

ALTER TABLE alumnos MODIFY COLUMN telefono BIGINT(15);

INSERT INTO alumnos (nombre, apellido, email, dni, telefono, edad)
VALUES ('Lucas', 'González', 'lucas@mail.com', 22334456, 1133344556, 22);

SELECT * FROM alumnos;

SELECT nombre, apellido FROM alumnos WHERE nombre LIKE 'm%';

SELECT email FROM alumnos WHERE email LIKE '%gmail%';

SELECT nombre, apellido FROM alumnos WHERE apellido LIKE '%z';

SELECT telefono FROM alumnos WHERE telefono LIKE '11%';

SELECT * FROM alumnos WHERE email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(com|net)$';

SELECT * FROM alumnos WHERE nombre REGEXP '^[A-Z]+$';

SELECT * FROM alumnos WHERE dni REGEXP '^[0-9]{8}$';

SELECT * FROM alumnos WHERE edad = (SELECT MIN(edad) FROM alumnos);	

SELECT * FROM alumnos WHERE edad >= 18 AND id_alumno IN (SELECT id_alumno FROM inscripciones);

SELECT COUNT(*) FROM alumnos WHERE edad > 25;

SELECT AVG(edad) FROM alumnos WHERE id_alumno IN (SELECT id_alumno FROM inscripciones);

SELECT COUNT(*) FROM alumnos WHERE nacionalidad = 'Argentina';

SELECT nacionalidad, MIN(edad) AS menor_edad, MAX(edad) AS mayor_edad
FROM alumnos GROUP BY nacionalidad;

CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS profesores;

TRUNCATE TABLE alumnos;

DELETE FROM alumnos WHERE edad < 18;

SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM alumnos;

SELECT UCASE(nombre) FROM alumnos;

SELECT NOW();

SELECT SUM(edad) FROM alumnos;

SELECT ROUND(AVG(edad), 2) FROM alumnos;