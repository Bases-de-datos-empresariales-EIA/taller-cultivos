-- 1. Encuentra el nombre de todos los lotes (Lot) que están asociados 
-- a recogidas (Collection) con más de 100 racimos. 
-- Muestra el nombre del lote y la cantidad total de racimos en las recogidas asociadas.

select 
l.name,
c.bunches
from cultivo."Lot" l
  join cultivo."Collection" c
    on c."lotId" = l.id
where c.bunches > 100;

-- 2. Muestra el número total de envíos (Shipment) realizados para cada lote (Lot) en el último mes. Incluye el identificador del lote y el número total de envíos.

select 
l.name,
count(s.id)
from cultivo."Lot" l
join cultivo."Collection" c
  on c."lotId" = l.id
join cultivo."Shipment" s
  on c."shipmentId" = s.id
where s."shipmentDate" between '2024-07-01' and '2024-07-31'
group by l.name;


-- 3. Encuentra los lotes (Lot) que tienen más recogidas (Collection) asociadas. Muestra el identificador y el nombre del lote.
select
l.name,
count(c.id)
from cultivo."Lot" l
  join cultivo."Collection" c
    on c."lotId" = l.id
group by l.name
order by count(c.id) desc;

-- 4. Muestra la fecha de la recogida (Collection), el identificador del lote (Lot), y el número total de racimos recolectados, para las recogidas realizadas en el último trimestre. Ordena los resultados por fecha de recogida.
select 
l.name,
c."collectionDate"
from cultivo."Collection" c
  join cultivo."Lot" l
    on c."lotId" = l.id
where c."collectionDate" between '2024-04-01' and '2024-06-30'
order by c."collectionDate" desc;

-- 5. Calcula el peso promedio de los racimos en los envíos (Shipment) para cada lote (Lot). Muestra el identificador del lote y el peso promedio.
select 
l.name,
avg(s."bunchWeight")
from cultivo."Shipment" s
  join cultivo."Collection" c
    on c."shipmentId" = s.id
  join cultivo."Lot" l
    on c."lotId" = l.id
group by l.name;

-- 6. Encuentra la recogida (Collection) con la mayor cantidad de racimos para cada lote (Lot). Muestra el identificador de la recogida, el identificador del lote, y la cantidad de racimos.

with subquery_maximo as (
  select 
  l.id,
  l.name,
  max(c.bunches)
  from cultivo."Lot" l
    join cultivo."Collection" c
      on c."lotId" = l.id
  group by l.name, l.id
)
select 
sm.id,
sm.name,
sm.max,
c.id as "collectionId",
c."collectionDate"
from subquery_maximo sm
  join cultivo."Collection" c
    on c."lotId" = sm.id and c.bunches = sm.max

-- 7. Muestra la cantidad total de racimos recolectados (`Collection`) en cada lote (`Lot`) para el año en curso. Incluye el identificador del lote y la cantidad total de racimos.
select 
  l.id as "lotId",
  l.name,
  count(c.id) as "totalBunches"
from cultivo."Lot" l
  join cultivo."Collection" c
    on c."lotId" = l.id
where extract(year from c."collectionDate") = 2024
group by l.id, l.name
order by "totalBunches" desc;

-- 8.    Encuentra los envíos (`Shipment`) que se realizaron para lotes (`Lot`) que han tenido más de 5 recogidas (`Collection`). Muestra el identificador del envío, el identificador del lote y la fecha del envío.
select 
  s.id as "shipmentId",
  l.id as "lotId",
  s."shipmentDate"
from cultivo."Shipment" s
  join cultivo."Collection" c
    on c."shipmentId" = s.id
  join cultivo."Lot" l
    on c."lotId" = l.id
group by s.id, l.id, s."shipmentDate"
having count(c.id) > 5;

-- 9.   Muestra el número total de recogidas (`Collection`) realizadas para cada lote (`Lot`) en el último año. Incluye el identificador del lote y el número total de recogidas.

select 
  l.id as "lotId",
  count(c.id) as "totalCollections"
from cultivo."Lot" l
  join cultivo."Collection" c
    on c."lotId" = l.id
where extract(year from c."collectionDate") = 2023
group by l.id
order by "totalCollections" desc;

-- 10. Encuentra los lotes (`Lot`) y los envíos (`Shipment`) que se realizaron en el mismo rango de fechas. Muestra el identificador del lote, el identificador del envío, y las fechas correspondientes.
select 
  l.id as "lotId",
  s.id as "shipmentId",
  s."shipmentDate",
  c."collectionDate"
from cultivo."Lot" l
  join cultivo."Collection" c
    on c."lotId" = l.id
  join cultivo."Shipment" s
    on s."shipmentDate" = c."collectionDate"
order by l.id, s.id;

-- 11. Muestra el promedio de racimos recolectados por recogida (`Collection`) para cada lote (`Lot`). Incluye el identificador del lote y el promedio de racimos.
select 
  l.name as "lotId",
  avg(bunches) as "averageBunches"
from cultivo."Collection" c
join cultivo."Lot" l
  on c."lotId" = l.id
group by l.name
order by avg(bunches) desc;

-- 12. Encuentra la recogida (`Collection`) más reciente para cada lote (`Lot`). Muestra el identificador del lote, el identificador de la recogida y la fecha de la recogida.


  -- 13. Muestra el mes del año 2024 que más kilogramos recibidos en planta tiene.
select 
  extract(month from s."shipmentDate"),
  sum(s."deliveredWeight") as "totalWeight"
from cultivo."Shipment" s
where extract(year from s."shipmentDate") = 2024
group by extract(month from s."shipmentDate")
order by sum(s."deliveredWeight") desc
limit 1;

-- 14. Muestra el lote que tiene más racimos recogidos en la historia.
select 
  l.id as "lotId",
  l.name as "lotName",
  sum(c.bunches) as "totalBunches"
from cultivo."Lot" l
  join cultivo."Collection" c
    on c."lotId" = l.id
group by l.id, l.name
order by sum(c.bunches) desc
limit 1;

-- 15. Muestra el mes con más facturación en la historia. (`Invoice`)
select 
extract(year from i."date"),
extract(month from i.date) as "invoiceMonth",
sum(i."grossTotal") as "totalAmount"
from cultivo."Invoice" i
where i."grossTotal" is not null
group by extract(year from i."date"), extract(month from i."date")
order by sum(i."grossTotal") desc
limit 1






