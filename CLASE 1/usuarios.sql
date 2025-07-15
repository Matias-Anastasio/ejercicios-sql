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
SELECT nombre, telefono, marca FROM usuarios WHERE marca NOT IN ('LG','SAMSUNG');

-- 2.	Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL
SELECT usuario, telefono FROM usuarios WHERE compañia = 'IUSACELL';

-- 3.	Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL
SELECT usuario, telefono, compañia FROM usuarios WHERE compañia <> 'TELCEL';

-- 4.	Calcular el saldo promedio de los usuarios que tienen teléfono marca NOKIA
SELECT AVG(saldo) as SaldoPromedio FROM usuarios WHERE marca = 'NOKIA';

-- 5.	Listar el login y teléfono de los usuarios con compañia telefónica IUSACELL o AXEL
SELECT usuario, telefono FROM usuarios WHERE compañia IN ('IUSACELL','AXEL');

-- 6.	Mostrar el email de los usuarios que no usan yahoo
SELECT email FROM usuarios WHERE email NOT LIKE '%yahoo%';

-- 7.	Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL o IUSACELL
SELECT usuario, telefono FROM usuarios WHERE compañia NOT IN ('TELCEL','IUSACELL');

-- 8.	Listar el login y teléfono de los usuarios con compañia telefónica UNEFON
SELECT usuario, telefono FROM usuarios WHERE compañia = 'UNEFON';

-- 9.	Listar las diferentes marcas de celular en orden alfabético descendentemente
SELECT DISTINCT marca FROM usuarios ORDER BY marca DESC;

-- 10.	Listar las diferentes compañias en orden alfabético aleatorio
SELECT DISTINCT compañia FROM usuarios ORDER BY RAND();

-- 11.	Listar el login de los usuarios con nivel 0 o 2
SELECT usuario FROM usuarios WHERE nivel IN (0,2);

-- 12.	Calcular el saldo promedio de los usuarios que tienen teléfono marca LG
SELECT AVG(saldo) as SaldoPromedioLG FROM usuarios WHERE marca = 'LG';

