/* ============================================================
   CLASE: SUBCONSULTAS EN SQL
   ============================================================ */

DROP DATABASE IF EXISTS empresa_subconsultas;
CREATE DATABASE empresa_subconsultas;
USE empresa_subconsultas;


/* ============================================================
   1️⃣ CREACIÓN DE TABLAS
   ============================================================ */

CREATE TABLE oficinas (
    id_oficina INT PRIMARY KEY,
    ciudad VARCHAR(50),
    pais VARCHAR(50)
);

CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    id_oficina INT,
    FOREIGN KEY (id_oficina) REFERENCES oficinas(id_oficina)
);


CREATE TABLE departamentos (
    id_dep INT PRIMARY KEY,
    nombre_dep VARCHAR(50)
);

CREATE TABLE proyectos (
    id_proyecto INT PRIMARY KEY,
    nombre VARCHAR(50),
    presupuesto INT,
    id_dep INT,
    FOREIGN KEY (id_dep) REFERENCES departamentos(id_dep)
);


CREATE TABLE empleados_proyectos (
    id_empleado INT,
    id_proyecto INT,
    PRIMARY KEY (id_empleado, id_proyecto),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto)
);


/* ============================================================
   2️⃣ INSERTAMOS DATOS
   ============================================================ */

INSERT INTO oficinas VALUES
(1, 'Madrid', 'España'),
(2, 'Barcelona', 'España'),
(3, 'Boston', 'USA'),
(4, 'Chicago', 'USA');

INSERT INTO empleados VALUES
(10, 'Ana', 'Sosa', 1),
(11, 'Luis', 'Martín', 1),
(12, 'Clara', 'Ruiz', 2),
(13, 'John', 'Smith', 3),
(14, 'Emma', 'Brown', 3),
(15, 'Carlos', 'Alonso', 4);

INSERT INTO departamentos VALUES
(1, 'Marketing'),
(2, 'Ventas'),
(3, 'Tecnología');

INSERT INTO proyectos VALUES
(101, 'Web Nueva', 15000, 3),
(102, 'Campaña 2025', 8000, 1),
(103, 'CRM Ventas', 20000, 2),
(104, 'Migración Cloud', 30000, 3);

INSERT INTO empleados_proyectos VALUES
(10, 101),
(11, 101),
(12, 102),
(13, 103),
(14, 104),
(15, 104),
(10, 104);


/* ============================================================
   3️⃣ SUBCONSULTAS EN WHERE
   ============================================================ */

-- Empleados cuya oficina está en Boston
SELECT id_oficina
FROM oficinas
WHERE ciudad = 'Boston';

SELECT nombre, apellido
FROM empleados
WHERE id_oficina = (
    SELECT id_oficina
    FROM oficinas
    WHERE ciudad = 'Boston'
);

-- Empleados cuya oficina está en USA (devuelve varias oficinas → usamos IN)
SELECT nombre, apellido
FROM empleados
WHERE id_oficina IN (
    SELECT id_oficina
    FROM oficinas
    WHERE pais = 'USA'
);


/* ============================================================
   4️⃣ SUBCONSULTAS EN SELECT
   ============================================================ */

-- Empleado + número de proyectos en los que participa
SELECT 
    e.nombre,
    e.apellido,
    (SELECT COUNT(*)
     FROM empleados_proyectos ep
     WHERE ep.id_empleado = e.id_empleado) AS total_proyectos
FROM empleados e;


/* ====================================================================
   5️⃣ ANY y ALL
   ============================================================ */
-- COMPARACIÓN ( ANY/ALL)

-- El operador ANY se utiliza cuando deseas verificar si una condición es verdadera 
-- para al menos uno de los valores devueltos por la subquery. 
-- Es equivalente a usar "alguno" o "cualquiera" en lenguaje natural.
-- Se utiliza con =, >, <, >=, <=, !=
-- Se suele utilizar para comparar valores numéricos, por ejemplo, "muestrame los valores que sean mayor a cualquiera de las duraciones de las películas de 2020" >ANY(SELECT)
-- Películas equivalentes → ahora usamos presupuestos de proyectos



-- Proyectos cuyo presupuesto sea mayor que CUALQUIER (ANY) presupuesto del departamento de Marketing
SELECT nombre, presupuesto
FROM proyectos
WHERE presupuesto > ANY (
    SELECT presupuesto
    FROM proyectos
    WHERE id_dep = 1  -- departamento Marketing
);

-- Proyectos cuyo presupuesto sea mayor que TODOS (ALL) los del departamento de Marketing
SELECT nombre, presupuesto
FROM proyectos
WHERE presupuesto > ALL (
    SELECT presupuesto
    FROM proyectos
    WHERE id_dep = 1
);


/* ============================================================
   6️⃣ EXISTS y NOT EXISTS
   ============================================================ */

-- Departamentos que tienen al menos un proyecto
SELECT nombre_dep
FROM departamentos d
WHERE EXISTS (
    SELECT *
    FROM proyectos p
    WHERE p.id_dep = d.id_dep
);

-- Departamentos sin proyectos
SELECT nombre_dep
FROM departamentos d
WHERE NOT EXISTS (
    SELECT *
    FROM proyectos p
    WHERE p.id_dep = d.id_dep
);


/* ============================================================
   7️⃣ SUBCONSULTAS CORRELACIONADAS
   ============================================================ */

-- Empleados que participen en más de 1 proyecto
SELECT nombre, apellido
FROM empleados e
WHERE (
    SELECT COUNT(*)
    FROM empleados_proyectos ep
    WHERE ep.id_empleado = e.id_empleado
) > 1;

-- Proyectos cuyo presupuesto sea mayor que la media de su propio departamento
SELECT nombre
FROM proyectos p
WHERE presupuesto > (
    SELECT AVG(p2.presupuesto)
    FROM proyectos p2
    WHERE p2.id_dep = p.id_dep
);

/* ============================================================
   8️⃣ EJERCICIOS PROPUESTOS PARA CLASE con SOLUCIONES
   ============================================================ */

---------------------------------------------------------------
-- 1. Selecciona empleados que trabajen en oficinas en España
--    (usa subconsulta con IN)
---------------------------------------------------------------
-- Oficinas españolas → España tiene id_oficina: 1 (Madrid), 2 (Barcelona)
SELECT nombre, apellido
FROM empleados
WHERE id_oficina IN (
    SELECT id_oficina
    FROM oficinas
    WHERE pais = 'España'
);


---------------------------------------------------------------
-- 2. Selecciona proyectos cuyo presupuesto sea mayor que
--    cualquiera del departamento de Ventas (ANY)
---------------------------------------------------------------
-- Ventas = id_dep = 2
SELECT nombre, presupuesto
FROM proyectos
WHERE presupuesto > ANY (
    SELECT presupuesto
    FROM proyectos
    WHERE id_dep = 2
);


---------------------------------------------------------------
-- 3. Selecciona departamentos sin proyectos (NOT EXISTS)
---------------------------------------------------------------
SELECT nombre_dep
FROM departamentos d
WHERE NOT EXISTS (
    SELECT *
    FROM proyectos p
    WHERE p.id_dep = d.id_dep
);


---------------------------------------------------------------
-- 4. Selecciona empleados con el mismo número de proyectos
--    que Luis Martín (id_empleado = 11)
---------------------------------------------------------------
-- Primero: cuántos proyectos tiene Luis
-- Luis Martín tiene 2 proyectos → 101 y 101 (compartidos)
-- Solución completa:
SELECT nombre, apellido
FROM empleados e
WHERE (
    SELECT COUNT(*)
    FROM empleados_proyectos ep
    WHERE ep.id_empleado = e.id_empleado
) = (
    SELECT COUNT(*)
    FROM empleados_proyectos ep2
    WHERE ep2.id_empleado = 11
);


---------------------------------------------------------------
-- 5. Selecciona proyectos cuyo presupuesto sea mayor
--    que TODOS los proyectos del departamento de Tecnología (ALL)
---------------------------------------------------------------
-- Tecnología = id_dep = 3
SELECT nombre, presupuesto
FROM proyectos
WHERE presupuesto > ALL (
    SELECT presupuesto
    FROM proyectos
    WHERE id_dep = 3
);


---------------------------------------------------------------
-- 6. Crear una tabla nueva con empleados que trabajen en USA
---------------------------------------------------------------
-- Oficinas en USA → Boston (3) y Chicago (4)
CREATE TABLE empleados_usa AS
SELECT *
FROM empleados
WHERE id_oficina IN (
    SELECT id_oficina
    FROM oficinas
    WHERE pais = 'USA'
);


---------------------------------------------------------------
-- 7. Selecciona proyectos cuyo nombre contenga la palabra "Cloud"
--    usando subconsulta con IN
---------------------------------------------------------------
SELECT *
FROM proyectos
WHERE id_proyecto IN (
    SELECT id_proyecto
    FROM proyectos
    WHERE nombre LIKE '%Cloud%'
);


