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