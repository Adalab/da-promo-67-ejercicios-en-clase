/*FUNCIONES AGREGADAS: COLUMNAS NUMERICAS, COLUMNAS FECHA(MIN, MAX)
- SUM
- AVG
- COUNT
- MIN
- MAX
**/
use adalabers; 


SELECT COUNT(*) AS total_alumnas
from adalaber; 

select count(distinct ciudad) as total_ciudades
from adalaber; 

select min(fecha_registro) as primera_fecha, max(fecha_registro) as ultima_fecha
from adalaber;  

-- alumnas mas joven 
select min(edad) as edad_mas_joven
from adalaber; 

-- la edad media de las alumnas
select avg(edad) as promedio_edad
from adalaber; 

/* group by + where**/

-- cantidad alumnas por ciudad, pero no tengas en cuenta si no está especificada la ciudad
select ciudad, count(*) as cant_alumnas 
from adalaber  
where ciudad not like "Sin Datos"
group by ciudad;


-- cantidad de alumnas por ciudad que tienen conocimientos "MUCHO"alter
select ciudad, count(*) as cantidad
from adalaber
where conocimientos_previos in ("Mucho")
group by ciudad; 


/* group by + having**/
-- ciudades que tienen mas de una alumna
select ciudad, count(*) as total
from adalaber
group by ciudad
having total > 1; 

-- cantidad de alumnas por ciudad que sus conocimentos sean muchos
select ciudad, count(id_adalaber) as total 
from adalaber
where conocimientos_previos like "Mucho"
group by ciudad 
having total >0
order by total desc
limit 1; 

/**cases**/
-- categorizar alumnas por su nivel de conocimientos
select nombre, conocimientos_previos,
		CASE 
			WHEN conocimientos_previos = "Mucho" THEN "Nivel Alto"
			WHEN conocimientos_previos = "POCO" THEN "Nivel Medio"
            ELSE "Nivel bajo"
        END as nivel
from adalaber; 

-- queremos saber la popularidad de los cursos por ciudad
select count(*) as total, ciudad, 
		case 
			when count(*) = 1 then "popularidad media"
            when count(*) >= 2 then "popularidad alta"
            else "popularidad baja"
		end as popular
from adalaber
group by ciudad
order by total desc; 



















 







-- == != >= where 