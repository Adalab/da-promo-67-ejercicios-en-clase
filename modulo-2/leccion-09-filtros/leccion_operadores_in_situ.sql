-- uniones

-- dame las ventas totales
select * 
from ventas_2023, ventas_2024; 
-- union
select id_venta, fecha, cantidad
from ventas_2023 
union
select id, fecha, cantidad
from ventas_2024; 

-- union all: no quita duplicados
select id_venta, fecha, cantidad
from ventas_2023 
union all
select id, fecha, cantidad
from ventas_2024; 

-- in - not in 
-- informacion de todas la clientas que se llamen, Mary, Linda o ana

select * 
from clientas
where nombre in ("Mary", "Linda", "Ana"); 

select * 
from clientas
where nombre not in  ("Mary", "Linda", "Ana"); 

-- condicines de filtro usando like 
-- % o _
select *
from clientas 
where nombre like "A__"; 

select *
from clientas 
where apellido like "%son"; 


select *
from clientas 
where ciudad like "%a%"; 



-- clienes cuyo apellido termine en son
select *
from clientas
where apellido REGEXP "son$"; 

-- clientes que su nombre empieza por A o por M
select *
from clientas
where nombre regexp "^A|M"; 

-- clieneas cuto nombre tiene exactamente 4 caracteres
select *
from clientas
where nombre regexp ".{4}$";

select *
from clientas
where nombre regexp  "^.{1,4}$";

select *
from clientas
where nombre like "____"; 

-- cliente cuyo apellido tiene numeros
select *
from clientas
where nombre regexp "[0-9]"; 


-- regex
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


-- Caracteres especiales \n _ %
use EjemploCaracteresEspeciales; 

-- buscar descripciones que tengan algun % 
-- oara buscar simbolo de % usar barra invertida \
select *
from productos 
where descripcion like "%\%%"; 

-- buscar usuarios con guion bajo
select *
from usuarios 
where nombre_usuario like "%\_%"; 

-- buscar los comenatrios qeu tienen "" '' 
select *
from comentarios
where texto like '%''%'; -- "%''%"


-- buscar rutas con barra invertida \ tengo que usar \\ 
select *
from rutas
where directorio like '%\\\%'; 

-- \n salto de linea, \b
select *
from mensajes 
where contenido like '%\n%'; 

-- Insertar datos en la tabla mensajes
INSERT INTO mensajes (contenido) VALUES
('Hola,\n¿Cómo estás?'),
('Este es un mensaje\nde varias líneas.'),
('Primera línea.\nSegunda línea.\nTercera línea.');

























