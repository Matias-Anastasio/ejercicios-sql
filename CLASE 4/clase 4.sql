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

ALTER TABLE empleados MODIFY COLUMN fecha_contratacion DATE DEFAULT (CURRENT_DATE);

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

DELIMITER //
CREATE PROCEDURE insertar_empleado(
	IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_salario DECIMAL(10,2)
)
BEGIN
	INSERT INTO empleados (nombre,apellido,salario)
    VALUES (p_nombre,p_apellido,p_salario);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE aumentar_salario(
	IN p_id_empleado INT,
	IN p_porcentaje DECIMAL
)
BEGIN
	UPDATE empleados SET salario=salario*(1 + p_porcentaje/100) WHERE id_empleado=p_id_empleado;
END //
DELIMITER ;

SELECT * FROM empleados WHERE id_empleado=1;
CALL aumentar_salario(1,50);

DELIMITER //
CREATE PROCEDURE eliminar_empleado(
	IN p_id_empleado INT
)
BEGIN
	DELETE FROM empleados WHERE id_empleado=p_id_empleado;
END //
DELIMITER ;

CALL eliminar_empleado(4);

DELIMITER //
CREATE PROCEDURE total_empleados_por_departamento(
	IN p_id_departamento INT
)
BEGIN
	SELECT d.nombre_departamento, count(*) FROM empleados e INNER JOIN departamentos d USING(id_departamento) WHERE id_departamento=p_id_departamento GROUP BY id_departamento;
END //
DELIMITER ;

DROP PROCEDURE total_empleados_por_departamento;

CALL total_empleados_por_departamento(2);

DELIMITER //
CREATE PROCEDURE mostrar_salario_promedio()
BEGIN
	SELECT avg(salario) as salario_promedio FROM empleados;
END //
DELIMITER ;

CALL mostrar_salario_promedio();

DELIMITER //
CREATE PROCEDURE empleados_recientes(
	IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
	SELECT nombre,apellido,fecha_contratacion FROM 	empleados WHERE fecha_contratacion BETWEEN p_fecha_inicio AND p_fecha_fin;
END //
DELIMITER ;

CALL empleados_recientes('2020-01-01','2021-12-31');

DROP PROCEDURE insertar_empleado;

DELIMITER //
CREATE PROCEDURE insertar_empleado(
	IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_salario DECIMAL(10,2),
    IN p_id_departamento INT
)
BEGIN
	IF p_salario <= 1000.00 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'salario debe ser > 1000.00';
	END IF;

	INSERT INTO empleados (nombre,apellido,salario,email,fecha_contratacion,id_departamento)
    VALUES (p_nombre,p_apellido,p_salario,concat(p_nombre,p_apellido,'@empresa.com'),curdate(),p_id_departamento);
END//
DELIMITER ;

CALL insertar_empleado('matias','anastasio',400000,3);

DROP PROCEDURE eliminar_empleado;

-- ---------------------------------------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION calcular_impuesto(salario DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN salario * 0.21;
END; //
DELIMITER ;

SELECT calcular_impuesto(200000) AS impuesto;

DELIMITER //
CREATE FUNCTION obtener_nombre_completo(f_id_empleado INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	DECLARE nombre_completo VARCHAR(100);
	SELECT concat(nombre,' ',apellido) INTO nombre_completo FROM empleados WHERE id_empleado= f_id_empleado;
    RETURN nombre_completo;
END;//
DELIMITER ;

SELECT obtener_nombre_completo(5) AS nombre_completo;

DELIMITER //
CREATE FUNCTION empleado_mas_antiguo() RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE empleado_antiguo INT;
    SELECT id_empleado INTO empleado_antiguo FROM empleados WHERE fecha_contratacion=(SELECT MIN(fecha_contratacion) FROM empleados);
    RETURN empleado_antiguo;
END;//
DELIMITER ;

DROP FUNCTION contar_empleados_por_departamento;

SELECT * FROM empleados WHERE id_empleado=empleado_mas_antiguo();

DELIMITER //
CREATE FUNCTION contar_empleados_por_departamento(f_id_departamento INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cant_empleados INT;
    SELECT count(*) INTO cant_empleados FROM empleados WHERE id_departamento=f_id_departamento;
    RETURN cant_empleados;
END;//
DELIMITER ;

SELECT contar_empleados_por_departamento(3) AS empleados_por_departamento;

DELIMITER //
CREATE FUNCTION bono_anual(salario DECIMAL) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN salario*0.1;
END; //
DELIMITER ;

SELECT bono_anual(5000) AS bono_anual; 

DELIMITER //
CREATE FUNCTION salario_total(f_id_empleado INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE salario_base DECIMAL(10,2);
    SELECT salario INTO salario_base FROM empleados WHERE id_empleado= f_id_empleado;
    RETURN salario_base + bono_anual(salario_base) + calcular_impuesto(salario_base);
END;//
DELIMITER ;

DROP FUNCTION salario_total;

SELECT salario_total(1);

DELIMITER //
CREATE FUNCTION aumentar_salario(f_id_empleado INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	DECLARE salario_actualizado DECIMAL(10,2);
	UPDATE empleados SET salario=salario*1.1 WHERE id_empleado=f_id_empleado;
    SELECT salario INTO salario_actualizado FROM empleados WHERE id_empleado=f_id_empleado;
    RETURN salario_actualizado;
END;//
DELIMITER ;

SELECT aumentar_salario(12) as salario_actualizado;

-- ---------------------------------------------------------------------------------------------------------------------------

DELIMITER //
CREATE TRIGGER before_insert_empleado
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
	IF NEW.salario < 1000 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El sueldo debe ser mayor a 1000';
	END IF;
END;//
DELIMITER ;

INSERT INTO empleados(nombre,apellido,email,salario,id_departamento) VALUE ('matias','anastasio','emaildeprueba@empresa.com',500,2);

CREATE TABLE auditoria_empleados (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_contratacion DATE,
    salario DECIMAL(10,2) NOT NULL,
    id_departamento INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_insert_empleado
AFTER INSERT ON empleados
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_empleados(id_empleado,nombre,apellido,email,fecha_contratacion,salario,id_departamento)
    VALUES (NEW.id_empleado,NEW.nombre,NEW.apellido,NEW.email,NEW.fecha_contratacion,NEW.salario,NEW.id_departamento);
END;//
DELIMITER ;

INSERT INTO empleados(nombre,apellido,email,salario,id_departamento) VALUE ('matias','anastasio','emaildeprueba2@empresa.com',5000,2);
SELECT * FROM auditoria_empleados;

DELIMITER //
CREATE TRIGGER before_update_salario
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
	DECLARE salario_anterior DECIMAL(10,2);
    SELECT salario INTO salario_anterior FROM empleados WHERE id_empleado=OLD.id_empleado;
    IF salario_anterior>NEW.salario THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permiten reducciones salariales';
	END IF;
END; //
DELIMITER ;

UPDATE empleados SET salario=5000 WHERE id_empleado=16;

CREATE TABLE empleados_eliminados (
    id_empleado INT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_contratacion DATE,
    salario DECIMAL(10,2) NOT NULL,
    id_departamento INT NOT NULL,
    fecha_eliminacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_delete_empleado
AFTER DELETE ON empleados
FOR EACH ROW
BEGIN
	INSERT INTO empleados_eliminados(id_empleado,nombre,apellido,email,fecha_contratacion,salario,id_departamento)
    VALUE(OLD.id_empleado,OLD.nombre,OLD.apellido,OLD.email,OLD.fecha_contratacion,OLD.salario,OLD.id_departamento);
END; //
DELIMITER ;

DELETE FROM empleados WHERE id_empleado=16;
SELECT * FROM empleados_eliminados;

DELIMITER //
CREATE TRIGGER before_insert_departamento
BEFORE INSERT ON departamentos
FOR EACH ROW
BEGIN
	DECLARE existe_nombre TINYINT;
	SELECT EXISTS(SELECT 1 FROM departamentos WHERE nombre_departamento = NEW.nombre_departamento) INTO existe_nombre;
    IF existe_nombre = 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El departamento ingresado ya existe';
	END IF;
END; //
DELIMITER ;

SELECT * FROM departamentos;
INSERT INTO departamentos(nombre_departamento) VALUE ('RRHH');

CREATE TABLE auditoria_departamentos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_departamento INT NOT NULL,
    cambio VARCHAR(255) NOT NULL
);

DELIMITER //
CREATE TRIGGER after_update_departamento
AFTER UPDATE ON departamentos
FOR EACH ROW
BEGIN
	INSERT INTO auditoria_departamentos(id_departamento,cambio)
    VALUE(OLD.id_departamento, concat('Cambio de: "',OLD.nombre_departamento,'" a: "',NEW.nombre_departamento,'"'));
END;//
DELIMITER ;

UPDATE departamentos SET nombre_departamento='RRHH' WHERE id_departamento=1;
SELECT * FROM auditoria_departamentos;

-- ---------------------------------------------------------------------------------------------------------------------------

SELECT nombre, apellido, salario FROM empleados WHERE salario=(SELECT max(salario) FROM empleados);

SELECT e.nombre,e.apellido,e.salario,d.nombre_departamento FROM empleados e INNER JOIN departamentos d USING(id_departamento);

SELECT e.nombre,e.apellido FROM empleados e LEFT JOIN departamentos d USING(id_departamento) WHERE id_departamento IS NULL;

SELECT nombre, apellido, salario FROM empleados WHERE salario>(SELECT avg(salario) FROM empleados);

SELECT nombre, apellido, salario FROM empleados WHERE salario>(SELECT avg(e.salario) FROM empleados e WHERE id_departamento=e.id_departamento);

SELECT avg(salario) FROM empleados GROUP BY id_departamento;

SELECT d.nombre_departamento,count(*) AS cantidad_empleados FROM empleados e INNER JOIN departamentos d USING(id_departamento) GROUP BY d.nombre_departamento ORDER BY cantidad_empleados DESC LIMIT 3;

SELECT e.nombre,e.apellido FROM empleados e JOIN (SELECT apellido from empleados GROUP BY apellido HAVING count(*)>1) repetidos ON e.apellido = repetidos.apellido ORDER BY e.apellido, e.nombre;