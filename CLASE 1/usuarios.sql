SELECT * FROM usuarios;

-- CONSULTAS BLOQUE 1
-- 1.	Listar los nombres de los usuarios
SELECT nombre FROM usuarios;

-- 2.	Calcular el saldo maximo de los usuarios de sexo 'mujer'
SELECT MAX(saldo) AS SaldoMaximo FROM usuarios WHERE sexo = 'M';

-- 3.	Listar nombre y telefono de los usuarios con telefono NOKIA, BLACKBERRY o SONY
SELECT nombre, telefono FROM usuarios WHERE marca IN ('NOKIA','BLACKBERRY','SONY');

-- 4.	Contar los usuarios sin saldo o inactivos
SELECT COUNT(*) FROM usuarios WHERE saldo = 0 OR activo = 0;

-- 5.	Listar el login de los usuarios con nivel 1,2 o 3
SELECT usuario FROM usuarios WHERE nivel IN (1 , 2, 3);
    
-- 6.	Listar los numeros de telefono con saldo menor o igual 300
SELECT telefono FROM usuarios WHERE saldo<=300;

-- 7.	Calcular la suma de saldos de los usuarios de la compañia telefonica NEXTEL
SELECT SUM(saldo) FROM usuarios WHERE compañia = 'NEXTEL';

-- 8.	Contar el numero de usuarios por compañia telefonica
SELECT compañia, COUNT(*) FROM usuarios GROUP BY compañia;

-- 9.	Contar el numero de usuarios por nivel
SELECT nivel, COUNT(*) FROM usuarios GROUP BY nivel ORDER BY nivel ASC;

-- 10.	Listar el login de los usuarios con nivel 2
SELECT usuario FROM usuarios WHERE nivel=2;

-- 11.	Mostrar el email de los usuarios que usan gmail
SELECT email FROM usuarios WHERE email LIKE '%gmail%';

-- 12.	Listar nombre y telefono de los usuarios con telefono LG, SAMSUNG o MOTOROLA
SELECT nombre, telefono FROM usuarios WHERE marca IN ('LG','SAMSUNG','MOTOROLA');

-- CONSULTAS BLOQUE 2
-- 1.	Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca LG o SAMSUNG


-- 2.	Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL


-- 3.	Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL


-- 4.	Calcular el saldo promedio de los usuarios que tienen teléfono marca NOKIA


-- 5.	Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o AXEL


-- 6.	Mostrar el email de los usuarios que no usan yahoo


-- 7.	Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL o IUSACELL


-- 8.	Listar el login y teléfono de los usuarios con compañia telefónica UNEFON


-- 9.	Listar las diferentes marcas de celular en orden alfabético descendentemente


-- 10.	Listar las diferentes compañias en orden alfabético aleatorio


-- 11.	Listar el login de los usuarios con nivel 0 o 2


-- 12.	Calcular el saldo promedio de los usuarios que tienen teléfono marca LG


