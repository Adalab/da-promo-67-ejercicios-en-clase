-- Consultas de join 
use empresa; 

--  empleados y hobbies : todas las posibles combinaciones -- cross join
select * from empleados; 
select * from hobbies; 

select nombre, hobbie
from empleados 
cross join hobbies; 

-- natural join: cuando hay una columna que coincide
-- clientes que ha reliazdos pagos y cuanto ha sido el pago
select * from clientes; 
select * from pagos; 

select *
from clientes
natural join pagos; 


-- inner join: cuales son los clientes que ya han realizado algun pago y cual es el importe de pago 
select c.nombre, p.total
from clientes c
inner join pagos p ON  c.id_cliente = p.id_cliente;

-- que empleados pertencen a que departamento
select * from empleados; 
select * from departamentos;

 select e.nombre, d.nombre
 from empleados e
 inner join departamentos d ON e.id_dep = d.id_dep;
 
-- left join  
-- todos los empleados con sus hobbies y mostra al emplada aunq 
select *
from empleados e
left join empleados_hobbies eh on e.id_emp = eh.id_emp
left join hobbies h on eh.id_hobbie = h.id_hobbie; 

-- empleados que existen y su oficina cual es 
select e.nombre, o.ciudad
from oficinas o 
right join empleados_oficina eo on o.id_oficina = eo.id_oficina
right join empleados e on eo.id_emp = e.id_emp; 


-- oficinas que existen y los empleados que trabajan en ellas 
SELECT o.ciudad, e.nombre
FROM empleados_oficina eo
RIGHT JOIN oficinas o ON eo.id_oficina = o.id_oficina
LEFT JOIN empleados e ON e.id_emp = eo.id_emp;


-- combinacion de tablas con where == inner join pero con un where 
 select e.nombre, d.nombre
 from empleados e 
 inner join departamentos d ON e.id_dep = d.id_dep;
 
 select e.nombre, d.nombre
 from empleados e, departamentos d
 where e.id_dep = d.id_dep ; 
 
 
 -- union 
 -- empleados con oficinas, incluyendo empleados sin oficina y oficnas sin empleados
select * 
from empleados e
left join empleados_oficina eo on e.id_emp = eo.id_emp
left join oficinas o on o.id_oficina = eo.id_oficina
UNION 
select * 
from empleados e
left join empleados_oficina eo on e.id_emp = eo.id_emp
right join oficinas o on o.id_oficina = eo.id_oficina
where o.ciudad = "Madrid"; /**vistas*/
 
 -- no es lo mismo
select *
from empleados
cross join empleados_oficina
cross join oficinas
; 













