/* ===========================================================
   CLASE COMPLETA: Operadores especiales + Joins
   ===========================================================
   Este archivo crea bases de datos, tablas y datos necesarios
   para practicar:
   - UNION / UNION ALL
   - IN / NOT IN
   - LIKE / NOT LIKE
   - REGEXP
   - JOINS (INNER, LEFT, SELF)
=========================================================== */


/* ===========================================================
   1️⃣ BASE DE DATOS PARA OPERADORES
=========================================================== */

CREATE DATABASE IF NOT EXISTS operadores_sql;
USE operadores_sql;


/* ===========================================================
   2️⃣ TABLAS PARA UNION / UNION ALL
=========================================================== */

DROP TABLE IF EXISTS ventas_2023;
DROP TABLE IF EXISTS ventas_2024;

CREATE TABLE ventas_2023 (
    id_venta INT,
    fecha DATE,
    cantidad INT
);

CREATE TABLE ventas_2024 (
    id INT,
    fecha DATE,
    cantidad INT
);

INSERT INTO ventas_2023 VALUES
(1, '2023-01-15', 2000),
(2, '2023-05-15', 5000),
(3, '2023-09-30', 4000),
(11, '2024-01-15', 1000);

INSERT INTO ventas_2024 VALUES
(11, '2024-01-15', 1000),
(12, '2024-05-15', 8000),
(13, '2024-10-01', 5000);


/* ------------------ UNION ------------------ */
-- IMPORTANTE para usar el UNION:
		-- Las columnas deben ser del mismo tipo de dato
        -- Debemos pedir el mismo número de columnas de cada tabla
        -- El orden depende de la tabla que seleccionemos antes
        -- El nombre que le pone a las columnas en el resultado es el del nombre de las 
        --columnas de la 1ª tabla que le pasamos
		-- Elimina los duplicados
        -- Esta unión no se guarda, solo se muestra, luego veremos como guardarla
SELECT 
    id_venta, 
    fecha, 
    cantidad
FROM ventas_2023
UNION
SELECT 
    id, 
    fecha, 
    cantidad
FROM ventas_2024;


/* ------------------ UNION ALL ------------------ */

SELECT 
    id_venta, 
    fecha, 
    cantidad
FROM ventas_2023
UNION ALL
SELECT 
    id, 
    fecha, 
    cantidad
FROM ventas_2024;


/* ===========================================================
   3️⃣ TABLA PARA IN / NOT IN
=========================================================== */

DROP TABLE IF EXISTS clientas;

CREATE TABLE clientas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    ciudad VARCHAR(30)
);

INSERT INTO clientas (nombre, apellido, ciudad) VALUES
('Ana', 'López', 'Madrid'),
('John', 'Smith', 'Barcelona'),
('Mary', 'Johnson', 'Madrid'),
('Linda', 'Brown', 'Sevilla'),
('Nick', 'Rivera', 'Bilbao'),
('Scarlett', 'Jones', 'Valencia');


/* ------------------ IN ------------------ */

SELECT *
FROM clientas
WHERE nombre IN ('Ana', 'Mary', 'Linda');


/* ------------------ NOT IN ------------------ */

SELECT *
FROM clientas
WHERE nombre NOT IN ('Nick', 'Scarlett', 'Emma');


/* ===========================================================
   4️⃣ LIKE / NOT LIKE
=========================================================== */

SELECT *
FROM clientas
WHERE nombre LIKE 'A%';

SELECT *
FROM clientas
WHERE apellido LIKE '%son';

SELECT *
FROM clientas
WHERE ciudad NOT LIKE '%id%';


/* ===========================================================
   5️⃣ REGEXP
=========================================================== */
-- REGEX
-- Nos permite buscar patrones más complejos de manera simple
-- Podemos definir reglas específicas para buscar dentro de nuestras columnas
-- Ignora mayúsculas y minúsculas
-- Operadores especiales

-- ^: indica que el patrón debe estar al principio de la cadena
-- $: indica que el patrón debe estar al final de la cadena
-- [a-z]: indica que el patrón debe estar entre los caracteres a y z
-- [0-9]: indica que el patrón debe estar entre los números 0 y 9
-- |: indica que el patrón puede ser uno u otro
-- .: indica que el patrón puede ser cualquier caracter
-- {}: indica que el patrón puede ser un rango de caracteres
-- (): indica que el patrón puede ser un grupo de caracteres
-- +: indica que el patrón puede ser uno o más caracteres
-- *: indica que el patrón puede ser cero o más caracteres

-- ❓ Buscar clientas cuyo apellido termina en “son”
-- Explicación del patrón:
-- 'son$'
--   son → busca literalmente esas letras
--   $   → indica que deben aparecer al FINAL del texto
SELECT *
FROM clientas
WHERE apellido REGEXP 'son$';


-- ❓ Buscar clientas cuyo nombre EMPIEZA por A o por M
-- Explicación del patrón:
-- '^[A|M]'
--   ^      → indica que debe aparecer al INICIO del texto
--   [A|M]  → cualquiera de estos caracteres: A, | o M
-- ⚠ NOTA: la barra vertical dentro de [] se trata como un carácter literal.
-- ✔ Versión correcta sería '^[AM]' (sin |)
SELECT *
FROM clientas
WHERE nombre REGEXP '^[A|M]';
-- where nombre regexp "^A|M"; 



-- ❓ Buscar clientas cuyos apellidos contienen algún número
-- Explicación del patrón:
-- '[0-9]'
--   [0-9] → cualquier dígito entre 0 y 9
-- Esto detecta apellidos con números (algo tipo "García2")
SELECT *
FROM clientas
WHERE apellido REGEXP '[0-9]';


-- ❓ Buscar clientas cuyo nombre tiene EXACTAMENTE 4 caracteres
-- Explicación del patrón:
-- '^.{4}$'
--   ^      → inicio del texto
--   .      → cualquier carácter
--   {4}    → exactamente 4 veces
--   $      → final del texto
-- Por tanto: solo nombres de 4 letras
SELECT *
FROM clientas
WHERE nombre REGEXP '^.{4}$';



/* ===========================================================
   6️⃣ BASE DE DATOS PARA JOINS (videojuegos)
=========================================================== */

CREATE DATABASE IF NOT EXISTS videojuegos_db;
USE videojuegos_db;

DROP TABLE IF EXISTS jugadores;
DROP TABLE IF EXISTS videojuegos;
DROP TABLE IF EXISTS plataformas;

/* ------------------ CREAR TABLAS ------------------ */

CREATE TABLE plataformas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE videojuegos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  genero VARCHAR(50),
  plataforma_id INT,
  FOREIGN KEY (plataforma_id) REFERENCES plataformas(id)
);

CREATE TABLE jugadores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  videojuego_id INT,
  amigo_id INT NULL,
  FOREIGN KEY (videojuego_id) REFERENCES videojuegos(id),
  FOREIGN KEY (amigo_id) REFERENCES jugadores(id)
);


/* ------------------ INSERTAR DATOS ------------------ */

INSERT INTO plataformas (nombre) VALUES
('PC'), ('PlayStation'), ('Nintendo Switch');

INSERT INTO videojuegos (titulo, genero, plataforma_id) VALUES
('The Legend of Zelda: Breath of the Wild', 'Aventura', 3),
('God of War', 'Acción', 2),
('Minecraft', 'Sandbox', 1),
('Super Mario Odyssey', 'Plataformas', 3),
('Final Fantasy VII Remake', 'RPG', 2);


INSERT INTO jugadores (nombre, videojuego_id, amigo_id) VALUES
('Ana',    1, NULL);
INSERT INTO jugadores (nombre, videojuego_id, amigo_id) VALUES('Bea', 2, 1);
INSERT INTO jugadores (nombre, videojuego_id, amigo_id) VALUES
('Carlos',    3, 2);
INSERT INTO jugadores (nombre, videojuego_id, amigo_id) VALUES
('Diana',    4, 3);
INSERT INTO jugadores (nombre, videojuego_id, amigo_id) VALUES
('Elena',    5, 4);


/* ===========================================================
   7️⃣ CONSULTAS JOIN
=========================================================== */

/* ------- INNER JOIN: jugadores + videojuegos que juegan ------- */

SELECT 
    j.nombre AS jugador,
    v.titulo AS videojuego
FROM jugadores j
INNER JOIN videojuegos v
    ON j.videojuego_id = v.id;


/* ------- LEFT JOIN: videojuegos con sus plataformas ------- */

SELECT 
    v.titulo,
    p.nombre AS plataforma
FROM videojuegos v
LEFT JOIN plataformas p
    ON v.plataforma_id = p.id;


/* ------- SELF JOIN: jugador + su amigo ------- */

SELECT 
    j.nombre AS jugador,
    a.nombre AS amigo
FROM jugadores j
LEFT JOIN jugadores a
    ON j.amigo_id = a.id;


/* ------- Jugadores por videojuego ------- */

SELECT 
    v.titulo,
    COUNT(j.id) AS total_jugadores
FROM videojuegos v
LEFT JOIN jugadores j
    ON v.id = j.videojuego_id
GROUP BY v.id;


/* ------- Videojuegos por plataforma ------- */

SELECT 
    p.nombre AS plataforma,
    COUNT(v.id) AS total_juegos
FROM plataformas p
LEFT JOIN videojuegos v
    ON p.id = v.plataforma_id
GROUP BY p.id;


/* ===========================================================
   8️⃣ EJERCICIOS PROPUESTOS (para clase)
=========================================================== */

-- 1. Ver videojuegos que empiecen por "Mine"
SELECT * FROM videojuegos
WHERE titulo LIKE 'Mine%';

-- 2. Jugadores cuyo nombre empieza por A y tiene 3 letras más
SELECT * FROM jugadores
WHERE nombre LIKE 'A___';

-- 3. IDs de PC y PlayStation
SELECT id FROM plataformas
WHERE nombre IN ('PC', 'PlayStation');

-- 4. Jugadores + videojuegos que juegan
SELECT 
    j.nombre, 
    v.titulo
FROM jugadores j
INNER JOIN videojuegos v
    ON j.videojuego_id = v.id;

-- 5. Videojuegos + plataforma (aunque no tengan)
SELECT 
    v.titulo, 
    p.nombre
FROM videojuegos v
LEFT JOIN plataformas p
    ON v.plataforma_id = p.id;

-- 6. Jugador + amigo
SELECT 
    j.nombre AS jugador,
    a.nombre AS amigo
FROM jugadores j
LEFT JOIN jugadores a
    ON j.amigo_id = a.id;

-- 7. Cuántos jugadores por videojuego
SELECT 
    v.titulo,
    COUNT(j.id)
FROM videojuegos v
LEFT JOIN jugadores j
    ON v.id = j.videojuego_id
GROUP BY v.id;

-- 8. Cuántos videojuegos por plataforma
SELECT 
    p.nombre,
    COUNT(v.id)
FROM plataformas p
LEFT JOIN videojuegos v
    ON p.id = v.plataforma_id
GROUP BY p.id;
