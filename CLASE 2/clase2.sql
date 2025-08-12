-- 0) Por si acaso, borramos antes si ya existían:
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS alumnos;

-- 1) Creamos la tabla alumnos
CREATE TABLE alumnos (
  id_alumno    INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(50)  NOT NULL,
  apellido     VARCHAR(50)  NOT NULL,
  email        VARCHAR(100),
  dni          INT          NOT NULL,
  telefono     VARCHAR(20),
  nacionalidad VARCHAR(50)  NOT NULL
);

-- 2) Creamos la tabla pedidos (para JOIN)
CREATE TABLE pedidos (
  id_pedido  INT AUTO_INCREMENT PRIMARY KEY,
  id_alumno  INT NOT NULL,
  producto   VARCHAR(100) NOT NULL,
  FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno)
);

-- 3) Creamos la tabla profesores (para UNION / INTERSECT)
CREATE TABLE profesores (
  id_profesor INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(50)  NOT NULL,
  apellido    VARCHAR(50)  NOT NULL,
  email       VARCHAR(100),
  dni         INT          NOT NULL
);

-- 4) Poblar alumnos con datos “aleatorios”
INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad) VALUES
  ('Juan',    'Pérez',      'juan.perez@example.com',       25432123, '2212345678', 'Argentina'),
  ('María',   'Gómez',      'maria.gomez@example.com',      34567890, '2211122233', 'Uruguay'),
  ('Pedro',   'Fernández',  NULL,                           29876543, '2287654321', 'Argentina'),
  ('Lucía',   'Martínez',   'lucia.martinez@example.com',   31234567, NULL,          'Chile'),
  ('Jorge',   'Rodríguez',  'jorge.rodriguez@example.com',  27894561, '2233344455', 'Argentina'),
  ('Ana',     'Díaz',       'ana.diaz@example.com',         23654789, '2299988776', 'Perú'),
  ('Diego',   'Sosa',       NULL,                           30456789, NULL,          'Uruguay'),
  ('Sofía',   'Luna',       'sofia.luna@example.com',       25678901, '2233155512','Argentina'),
  ('Martín',  'Suárez',     'martin.suarez@example.com',    28901234, '2212341234','España'),
  ('Laura',   'Vargas',     NULL,                           26789012, '2211445566','Colombia');

-- 5) Poblar pedidos
INSERT INTO pedidos (id_alumno, producto) VALUES
  (1, 'Libro SQL Básico'),
  (1, 'Cuaderno'),
  (2, 'Mochila'),
  (5, 'Calculadora'),
  (8, 'Bolígrafo'),
  (10,'Agenda');

-- 6) Poblar profesores
INSERT INTO profesores (nombre, apellido, email, dni) VALUES
  ('Carlos',   'López',     'carlos.lopez@example.com',     26543210),
  ('María',    'Gómez',     'maria.gomez@example.com',      34567890),  -- coincide con alumno
  ('José',     'Ramírez',   'jose.ramirez@example.com',     27894561),
  ('Ana',      'Díaz',      NULL,                           23654789),  -- coincide con alumno
  ('Patricia', 'Ramón',     'patricia.ramon@example.com',   30000001);

-- 1) Agrego la columna fecha_nacimiento
ALTER TABLE alumnos
  ADD COLUMN fecha_nacimiento DATE;

-- 2) Poblo fecha_nacimiento con valores “aleatorios” entre 1950 y 2005
UPDATE alumnos
   SET fecha_nacimiento = DATE_SUB(
     CURDATE(),
     INTERVAL FLOOR(RAND()*55 + 15) YEAR
   )
   LIMIT 100;


-- ------------------------------------------------------------------------------------

SELECT * FROM alumnos;

SELECT * FROM alumnos WHERE nacionalidad='Argentina';

SELECT * FROM alumnos WHERE email IS NOT NULL;

-- CON FUNCIONES PARA CALCULAR SI ES MAYOR DE 18
SELECT * FROM alumnos WHERE timestampdiff(YEAR, fecha_nacimiento, CURDATE())>18;

-- SIN FUNCIONES EN EL WHERE PERO SOLO FUNCIONA HOY
SELECT * FROM alumnos WHERE fecha_nacimiento<'2007-07-31';

SELECT * FROM alumnos WHERE nombre LIKE 'J%';

SELECT * FROM alumnos WHERE dni>30000000;

SELECT * FROM alumnos WHERE telefono IS NULL;

SELECT * FROM alumnos WHERE nacionalidad IN ('Argentina','Uruguay');

SELECT * FROM alumnos WHERE nacionalidad NOT IN ('Argentina','Uruguay');

SELECT apellido FROM alumnos ORDER BY apellido ASC;

SELECT dni FROM alumnos ORDER BY dni DESC;

SELECT * FROM alumnos LIMIT 5;

SELECT * FROM alumnos WHERE dni=(SELECT MAX(dni) FROM alumnos);
-- OTRA FORMA DE LO MISMO
SELECT * FROM alumnos ORDER BY dni DESC LIMIT 1;

SELECT * FROM alumnos ORDER BY id_alumno DESC LIMIT 3;

INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad, fecha_nacimiento)
VALUES ('Carlos', 'López', 'carlos.lopez@gmail.com', 37845612, '1122334455', 'Chile','1990-03-31');

INSERT INTO alumnos (nombre,apellido,email,dni,telefono,nacionalidad, fecha_nacimiento) 
VALUES ('Matias','Anastasio','matiasanastasio00@gmail.com',42460197,'1131972281','Argentina','2000-05-26'),
('Pedro','Duarte','pedroduarte@gmail.com',54123532,'1184920534','Paraguay','1980-07-23');

INSERT INTO alumnos (nombre,apellido,email,dni,nacionalidad) VALUES ('Valentina', 'García',  'valentina.garcia@example.com', 36543210, 'Argentina');

INSERT INTO alumnos (nombre,apellido,dni,telefono,nacionalidad) VALUES ('Bruno',     'Rojas',   35432109, '2215566443', 'Argentina');

INSERT INTO alumnos (nombre,apellido,email,dni,telefono,nacionalidad) VALUES ('Camila',    'Ortiz',   'camila.ortiz@example.com',    34321098, '2213344556', 'España');

UPDATE alumnos SET email='email@cambiado.test' WHERE id_alumno=2;

UPDATE alumnos SET nacionalidad='Perú' WHERE nacionalidad='Chile' LIMIT 100;

UPDATE alumnos SET apellido='González' WHERE nombre='María' LIMIT 1;

UPDATE alumnos SET dni=dni+1 WHERE nacionalidad='Argentina' LIMIT 100;

DELETE FROM alumnos WHERE id_alumno=4;

DELETE FROM alumnos WHERE nacionalidad='Uruguay' LIMIT 100;

DELETE FROM alumnos WHERE email IS NULL LIMIT 100;

DELETE FROM alumnos WHERE telefono IS NULL LIMIT 100;

DELETE FROM alumnos WHERE dni<30000000 LIMIT 1;

SELECT COUNT(*) FROM alumnos;

SELECT COUNT(*) FROM alumnos WHERE telefono IS NOT NULL;

SELECT MIN(dni) FROM alumnos;

SELECT MAX(dni) FROM alumnos;

SELECT nacionalidad, COUNT(*) FROM alumnos GROUP BY nacionalidad;

SELECT apellido, COUNT(*) FROM alumnos GROUP BY apellido;

SELECT nacionalidad, COUNT(*) FROM alumnos WHERE email IS NOT NULL GROUP BY nacionalidad;

SELECT nacionalidad, COUNT(*) AS cantidad_alumnos FROM alumnos GROUP BY nacionalidad HAVING COUNT(*)>=2;

SELECT nacionalidad, AVG(dni) AS promedio_dni FROM alumnos GROUP BY nacionalidad;

SELECT alumnos.nombre, pedidos.producto 
FROM alumnos 
INNER JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno;

SELECT a.nombre, p.producto FROM alumnos a LEFT JOIN pedidos p ON a.id_alumno = p.id_alumno;

SELECT a.nombre, p.producto FROM alumnos a RIGHT JOIN pedidos p ON a.id_alumno = p.id_alumno;

SELECT a.nombre, p.producto FROM alumnos a LEFT JOIN pedidos p ON a.id_alumno = p.id_alumno WHERE p.id_alumno IS NULL;

SELECT a.nombre,a.apellido, count(*) FROM alumnos a INNER JOIN pedidos p ON a.id_alumno = p.id_alumno GROUP BY a.nombre,a.apellido,a.id_alumno;

SELECT * FROM profesores;

SELECT nombre, apellido FROM alumnos UNION SELECT nombre,apellido FROM profesores;

SELECT DISTINCT a.email
  FROM alumnos AS a
  JOIN profesores AS p 
    ON a.email = p.email
 WHERE a.email IS NOT NULL;
 
