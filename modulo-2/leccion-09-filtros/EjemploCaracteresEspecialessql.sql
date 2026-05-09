-- Crear la base de datos
CREATE DATABASE EjemploCaracteresEspeciales;

-- Usar la base de datos
USE EjemploCaracteresEspeciales;

-- Crear la tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(255)
);

-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50)
);

-- Crear la tabla de comentarios
CREATE TABLE comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    texto VARCHAR(255)
);

-- Crear la tabla de rutas
CREATE TABLE rutas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    directorio VARCHAR(255)
);

-- Crear la tabla de mensajes
CREATE TABLE mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contenido TEXT
);

-- Insertar datos en la tabla productos
INSERT INTO productos (nombre, descripcion) VALUES
('Laptop', 'Laptop 15% de descuento'),
('Teléfono', 'Pantalla de 6 pulgadas y batería al 80%'),
('Tablet', 'Capacidad de almacenamiento 128GB'),
('Cámara', 'Resolución 12MP y precio 25% descuento');

-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (nombre_usuario) VALUES
('juan_perez'),
('maria_123'),
('ana_gomez'),
('pedro.lopez');

-- Insertar datos en la tabla comentarios
INSERT INTO comentarios (texto) VALUES
('It''s a great product!'),
('She''s an excellent seller.'),
('I can''t wait to buy another one.');

-- Insertar datos en la tabla rutas
INSERT INTO rutas (directorio) VALUES
('C:\\users\\juan\\documents'),
('C:\\program files\\app'),
('D:\\backup\\2023'),
('E:\\media\\movies');

-- Insertar datos en la tabla mensajes
INSERT INTO mensajes (contenido) VALUES
('Hola,\n¿Cómo estás?'),
('Este es un mensaje\nde varias líneas.'),
('Primera línea.\nSegunda línea.\nTercera línea.');

--- Ahora, vamos a realizar consultas para buscar caracteres especiales en las tablas.


-- Buscar descripciones con % (porcentaje): 
-- En MySQL, para buscar el símbolo %, usa una barra invertida (\) directamente en el patrón:
SELECT * 
FROM productos
WHERE descripcion LIKE '%\%%';
-- % representa cualquier caracter
-- luego escapeamos con la \ 
-- luego decimos que buscamos

-- Buscar usuarios con _ (guion bajo):
SELECT * 
FROM usuarios
WHERE nombre_usuario LIKE '%\_%';
-- % representa cualquier caracter
-- luego escapeamos con la \ 
-- luego decimos que buscamos un guin bajo con escape para que no lo interprete como un _

-- Buscar comentarios con comillas simples (')
-- las comillas simples dentro de cadenas deben escaparse usando una comilla adicional (''):
SELECT * 
FROM comentarios
WHERE texto LIKE '%''%';


-- Buscar rutas con barra invertida (\):
-- Para buscar una barra invertida, usa una doble barra invertida (\\):
-- la barra invertida (\) es un carácter de escape predeterminado dentro de cadenas. Para que funcione correctamente, debes duplicarla (\\).
SELECT * 
FROM rutas
WHERE directorio LIKE '%\\\%';

-- Buscar mensajes con salto de línea (\n):
SELECT * 
FROM mensajes
WHERE contenido LIKE '%\n%';
