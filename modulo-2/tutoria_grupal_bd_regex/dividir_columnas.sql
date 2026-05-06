/**
¿Hay alguna forma de modificar los datos de una columna entera a la vez, o hay que ir celda por celda? 
Por ejemplo, si has juntado en una misma celda Nombre y Apellido, 
y quieres separar nombre en una columna y apellido en otra
**/

-- Columna direccion en dos columnas: tipo y nombre_calle
alter table adalaber
add column tipo varchar(100) after direccion,
add column nombre_calle varchar(100) after tipo; 

-- substring_index(columna, delimitador, conqueme quedo)
select substring_index(direccion, " ", -1) as tipo
from adalaber; 

-- update 
update adalaber
set tipo = substring_index(direccion, " ", 1), nombre_calle= substring_index(direccion, " ", -1); 











 

