-- insertar 
-- INSERT INTO nombre_tabla(colum1, colum2,...) VALUES (valor1, valor2,...)
-- primary key es autoincremental => no es necesario insertralo, se genera 
use adalabers; 
INSERT INTO adalaber(dni, edad, nombre, apellido, ciudad) values ("12344566", 45, "Paquita", "Salas", "Madrid"); 

-- insertar varios valores 
INSERT INTO adalaber(dni, edad, nombre, apellido, ciudad) values
("12345", 45, "Maricarmen", "Mart", "Barcelona"),
("45568", 76, "Amparo", "Mart", "Valencia"); 

INSERT INTO adalaber(dni, edad, nombre, apellido) values ("57576656", 45, "Paquita 2", "Salas"); 

-- modificar
-- UPDATE nombre_tabla SET columna1 = nuevo_valor1, columna2 = nuevo_valor_2 WHERE condicion
 update adalaber set correo = "paquita@gmail.com" WHERE id_adalaber = 1;
 
 -- lo quqe no hay que hacer nunca
  update adalaber set correo = "paquita@gmail.com"; 
  
update adalaber 
set correo = "maricarmen@gmail.com"  
where nombre = "Maricarmen" AND apellido = "Mart";

update adalaber 
set correo = "amparo@gmail.com" , edad = 24
where nombre = "Amparo"; 

-- IN 
update adalaber
set direccion = "Calle desconocida"
where id_adalaber IN (1, 2);

-- is null 
update adalaber
set direccion = "Calle desconocida"
where direccion IS NULL; 
  

-- delete 
-- DELETE FROM nombre_tabla where condicion
-- sin where se eliminan todos los registros de la tabla
delete from adalaber where  id_adalaber = 5; 


-- alter table 
-- ELIMINAFR UNA TABLA ENTERA:
DROP TABLE IF EXISTS adalaber; 

-- READ (Obtener valores de la bases de datos)
-- select columna from nombre_tabla 

SELECT * from adalaber; 

-- ver columnas especifivas
select nombre, apellido, correo from adalaber; 

-- mostrar solo dos filas
select nombre, apellido, correo from adalaber LIMIT 2; 

-- FILTRAR POR EDAD
select nombre, edad from adalaber where edad>25; 
select nombre, edad from adalaber where fecha_registro is null;
select * from adalaber where conocimientos_previos is not null; --   conocimientos_previos != null









