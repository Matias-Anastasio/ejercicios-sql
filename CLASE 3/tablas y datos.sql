CREATE SCHEMA IF NOT EXISTS instituto;
USE instituto;

CREATE TABLE IF NOT EXISTS alumnos(
	id_alumno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    dni CHAR(8) NOT NULL UNIQUE,
    telefono VARCHAR(15),
    edad TINYINT UNSIGNED CHECK(edad>=0),
    nacionalidad VARCHAR(20) DEFAULT 'Argentina',
    promedio_final DECIMAL(4,2) CHECK(promedio_final BETWEEN 0 AND 10)
);

CREATE TABLE IF NOT EXISTS cursos(
	id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS inscripciones(
	id_inscripcion INT PRIMARY KEY AUTO_INCREMENT,
    id_alumno INT NOT NULL,
    id_curso INT NOT NULL,
    UNIQUE (id_alumno,id_curso),
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE IF NOT EXISTS profesores(
	id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);


INSERT INTO alumnos (nombre, apellido, email, dni, telefono, edad, nacionalidad, promedio_final)
VALUES
('María', 'Gómez', 'maria.gomez@gmail.com', '12345678', '1123456789', 20, 'Argentina', 8.75),
('Martín', 'Pérez', 'martin.perez@yahoo.com', '23456789', '1145678901', 25, 'Argentina', 7.50),
('Lucas', 'Fernández', 'lucas.fernandez@hotmail.com', '34567890', '1167890123', 18, 'Uruguay', 6.40),
('Ana', 'Martínez', 'ana.martinez@gmail.com', '45678901', '1189012345', 22, 'Chile', 9.10),
('Miguel', 'Suárez', 'miguel.suarez@outlook.com', '56789012', '1109876543', 30, 'Argentina', 5.80),
('Sofía', 'Díaz', 'sofia.diaz@gmail.com', '67890123', '1198765432', 19, 'Paraguay', 9.50),
('Pedro', 'Torres', 'pedro.torres@live.com', '78901234', '1112345678', 28, 'Argentina', 7.20),
('Lucía', 'Morales', 'lucia.morales@gmail.com', '89012345', '1122334455', 21, 'Argentina', 8.20),
('Mauro', 'Ramírez', 'mauro.ramirez@hotmail.com', '90123456', '1133445566', 27, 'Chile', 6.95),
('Camila', 'Rojas', 'camila.rojas@gmail.com', '01234567', '1144556677', 23, 'Uruguay', 8.00),
('Matías', 'López', 'matias.lopez@gmail.com', '11223344', '1155667788', 20, 'Paraguay', 9.80),
('Valentina', 'Castro', 'valentina.castro@gmail.com', '22334455', '1166778899', 24, 'Argentina', 7.75),
('Pablo', 'Hernández', 'pablo.hernandez@outlook.com', '33445566', '1177889900', 26, 'Chile', 6.50),
('Melina', 'Vega', 'melina.vega@gmail.com', '44556677', '1188990011', 22, 'Argentina', 8.65),
('Marcos', 'Sosa', 'marcos.sosa@gmail.com', '55667788', '1199001122', 29, 'Uruguay', 7.90);
    
INSERT INTO cursos (nombre_curso)
VALUES
('Matemática Básica'),
('Programación en Python'),
('Bases de Datos SQL'),
('Historia Universal'),
('Diseño Web'),
('Inglés Intermedio'),
('Estadística Aplicada'),
('Redes Informáticas');

INSERT INTO inscripciones (id_alumno, id_curso)
VALUES
-- María Gómez: Matemática, SQL
(1, 1),
(1, 3),

-- Martín Pérez: Python, Redes
(2, 2),
(2, 8),

-- Lucas Fernández: SQL
(3, 3),

-- Ana Martínez: Historia, Inglés
(4, 4),
(4, 6),

-- Miguel Suárez: Matemática, Estadística
(5, 1),
(5, 7),

-- Sofía Díaz: Diseño Web, Inglés
(6, 5),
(6, 6),

-- Pedro Torres: Redes
(7, 8),

-- Lucía Morales: Matemática, SQL, Inglés
(8, 1),
(8, 3),
(8, 6),

-- Mauro Ramírez: Python
(9, 2),

-- Camila Rojas: Estadística
(10, 7),

-- Matías López: Diseño Web
(11, 5),

-- Valentina Castro: Historia
(12, 4),

-- Pablo Hernández: Redes
(13, 8),

-- Melina Vega: Ningún curso (queda fuera a propósito)

-- Marcos Sosa: Matemática, Python, Redes
(15, 1),
(15, 2),
(15, 8);



