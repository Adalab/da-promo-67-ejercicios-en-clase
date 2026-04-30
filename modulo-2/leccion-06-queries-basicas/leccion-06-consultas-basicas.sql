
/* ========================================
   1️⃣ CREACIÓN DE LA BASE DE DATOS
   ======================================== */

CREATE DATABASE IF NOT EXISTS tienda_prueba;
USE tienda_prueba;


/* ========================================
   2️⃣ CREACIÓN DE TABLAS Y DATOS DE EJEMPLO
   ======================================== */

-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50),
    pais VARCHAR(30),
    correo VARCHAR(100) UNIQUE,
    fecha_registro DATE
);

-- Insertamos algunos datos
INSERT INTO clientes (nombre, apellido, pais, correo, fecha_registro)
VALUES
('Ana', 'Martínez', 'España', 'ana.martinez@email.com', '2024-03-01'),
('Luis', 'Pérez', 'México', 'luis.perez@email.com', '2024-04-10'),
('Carla', 'Gómez', 'Chile', 'carla.gomez@email.com', '2024-02-20'),
('Pedro', 'López', 'Argentina', 'pedro.lopez@email.com', '2024-01-15'),
('Sara', 'Jiménez', 'España', 'sara.jimenez@email.com', '2024-04-25'),
('Lucía', 'Torres', NULL, 'lucia.torres@email.com', '2024-05-02');


-- Tabla de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria ENUM('Electrónica', 'Ropa', 'Hogar', 'Juguetes'),
    precio DECIMAL(6,2),
    stock INT
);

INSERT INTO productos (nombre, categoria, precio, stock)
VALUES
('Auriculares', 'Electrónica', 25.99, 100),
('Televisor', 'Electrónica', 350.00, 20),
('Camiseta', 'Ropa', 15.50, 200),
('Sartén', 'Hogar', 22.00, 80),
('Robot aspirador', 'Hogar', 180.00, 15),
('Muñeca', 'Juguetes', 12.99, 50),
('Coche teledirigido', 'Juguetes', 35.00, 30),
('Sudadera', 'Ropa', 29.99, 120);


-- Tabla de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    fecha_pedido DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO pedidos (id_cliente, id_producto, cantidad, fecha_pedido)
VALUES
(1, 1, 2, '2024-05-10'),
(1, 4, 1, '2024-05-15'),
(2, 2, 1, '2024-05-20'),
(3, 3, 3, '2024-05-18'),
(4, 5, 1, '2024-06-02'),
(5, 6, 2, '2024-06-03'),
(6, 7, 1, '2024-06-05');


-- consultas sobre la bases de datos

-- obtener todos los clientes que hay que la bases de datos
select * from clientes; 
select nombre, pais from clientes; 
-- solo los tres primeros
select nombre, pais from clientes limit 3; 

-- filtrar: where
-- clientes que son de españa
select * from clientes where pais = "España";

-- clientes que se ha resgitrado despues del 1 de abril del 2024
select * from clientes where fecha_registro > '2024-04-01'; 

-- clientes con apellido martinez y de españa
select * from clientes where apellido = "martinez" and pais = "España"; -- MYSQL no es case sentitive

-- clientes sin pais, que no tengan pais registrado 
select * from clientes where pais is null; 


-- COMPARAR Y ORDENAR
select * from productos; 
-- productos con precio mayor o igual a 30
select * from productos where precio >= 30  ORDER BY precio desc; -- por defecto ordena de manera asc

-- productos ordenados por categoria y por precio
select * from productos order by categoria asc, precio desc; 

-- FILTRAR POR VARIOS VALORES (IN/NOT IN)
-- productos sean de Ropa o Hogar
select * from productos where categoria = "Ropa" or categoria= "Hogar";
select * from productos where categoria in ("Ropa", "Hogar");
select * from productos where categoria not in ("Ropa", "Hogar"); 

--  BETWEEN , LIMIT/OFFSET
-- productos que su precio esté entre 20 y 100
select * from productos where precio >20 and precio <100; 
select * from productos where precio BETWEEN 20 AND 100 ORDER BY precio desc LIMIT 3;  
select * from productos where precio >20 and precio <100 limit 2 offset 2;

-- distinct y alias
select * from clientes; 
-- saber de que paises son mis clientes
select distinct pais from clientes; 
select distinct pais, apellido from clientes; 
-- usar alias : as
select nombre as cliente, pais as pais_de_residencia from clientes; 

-- like, parecido al igual
-- clientes cuyo nombre empiece con A  (expresiones regulares)--> "A%"
select * from clientes where nombre LIKE "A%" or apellido LIKE "L%";

























