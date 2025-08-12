CREATE SCHEMA IF NOT EXISTS empresa;

USE empresa;

CREATE TABLE IF NOT EXISTS empleados(
	id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_contratacion DATE,
    salario DECIMAL(10,2) NOT NULL,
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

CREATE TABLE IF NOT EXISTS departamentos(
	id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_departamento VARCHAR(50) NOT NULL
);

INSERT INTO departamentos(nombre_departamento) VALUES ('RRHH'),('Ventas'),('Marketing'),('Operaciones'),('Contabilidad');

SELECT * from departamentos;

INSERT INTO empleados(nombre,apellido,email,fecha_contratacion,salario,id_departamento) VALUES 
('Mateo','Alvarez','mateo.alvarez@empresa.com','2021-03-15',185000.00,3),
('Sofia','Romero','sofiaromero@empresa.com','2022-07-01',210000.00,2),
('Lucas','Pereira','lucas.pereira@empresa.com','2020-11-20',240000.00,5),
('Valentina','Torres','valentina.torres@empresa.com','2019-05-06',320000.00,1),
('Martina','Diaz','martina.diaz@empresa.com','2023-01-10',175000.00,4),
('Juan','Lopez','juan.lopez@empresa.com','2018-09-17',380000.00,2),
('Camila','Herrera','camila.herrera@empresa.com','2024-02-26',195000.00,5),
('Tomas','Navarro','tomas.navarro@empresa.com','2020-01-13',265000.00,1),
('Agustina','Molina','agustina.molina@empresa.com','2022-03-28',225000.00,3),
('Nicolas','Sosa','nicolas.sosa@empresa.com','2021-12-09',205000.00,4);

SELECT * FROM empleados;

UPDATE empleados SET salario=salario*1.1 LIMIT 50;

DELETE FROM empleados WHERE id_empleado = 5;

DROP TABLE empleados;

-- --------------------------------------------------------------------------------------------

CREATE INDEX idx_email ON empleados (email);

SELECT e.nombre,e.apellido,e.email,d.nombre_departamento as departamento FROM empleados e INNER JOIN departamentos d ON e.id_departamento=d.id_departamento WHERE e.id_departamento=2;

SELECT d.nombre_departamento,count(*) FROM empleados e INNER JOIN departamentos d ON d.id_departamento=e.id_departamento GROUP BY e.id_departamento;

SELECT nombre, apellido, salario FROM empleados WHERE salario>5000;

SELECT avg(salario) as salario_promedio FROM empleados;

SELECT apellido FROM empleados WHERE apellido LIKE 'd%';

SELECT d.nombre_departamento,count(*) as empleados FROM empleados e INNER JOIN departamentos d ON e.id_departamento=d.id_departamento GROUP BY e.id_departamento ORDER BY empleados DESC LIMIT 1;

SELECT nombre,apellido,salario FROM empleados ORDER BY salario DESC LIMIT 3;

-- -------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW vista_empleados AS
SELECT nombre, apellido, salario FROM empleados;

SELECT * FROM vista_empleados;

CREATE VIEW vista_departamentos AS
SELECT d.nombre_departamento,count(*) FROM empleados e INNER JOIN departamentos d USING (id_departamento) GROUP BY e.id_departamento;

ALTER VIEW vista_empleados AS
SELECT nombre,apellido,salario,fecha_contratacion FROM empleados;

SELECT * FROM vista_empleados WHERE salario>220000;

CREATE VIEW vista_altos_salarios AS
SELECT nombre,apellido,salario FROM empleados WHERE salario>(SELECT avg(salario)FROM empleados);

DROP VIEW vista_altos_salarios;

CREATE VIEW vista_activos AS
SELECT nombre,apellido,fecha_contratacion FROM empleados WHERE fecha_contratacion > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT * FROM vista_activos;

CREATE VIEW vista_empleados_departamentos AS
SELECT e.nombre,e.apellido,e.email,e.salario,d.nombre_departamento as departamento FROM empleados e INNER JOIN departamentos d USING (id_departamento);

SELECT * FROM vista_empleados_departamentos;

UPDATE vista_empleados_departamentos SET salario=salario*1.1;

-- ------------------------------------------------------------------------------------------------
