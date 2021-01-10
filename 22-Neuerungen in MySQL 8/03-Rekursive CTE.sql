use lernfabrik;

with recursive cte(zaehler)
as (
      select 16
      union all -- union keine dollpelten datensätze 
      select zaehler + 1 
      from cte
      where zaehler < 30
    )
select zaehler 
from cte;

select 1 as zaehler;

select * from gesamtbedarf;

# ohne View - effizienter
with recursive ges(oartnr, uartnr, menge, vorlauffrist) as
  (select init.artnr, init.artnr, 1.00, cast(0 as decimal(8,2))
   from artikel as init
   union
   select o.oartnr, u.uartnr, o.menge*u.menge, (o.vorlauffrist + u.vorlauffrist)
   from ges as o join direktbedarf as u
     on o.uartnr = u.oartnr
)
select oartnr, uartnr, menge, vorlauffrist
from ges
order by oartnr, uartnr;


create or replace view gesbedarf as
with recursive ges(oartnr, uartnr, menge, vorlauffrist) as
  (select init.artnr, init.artnr, 1.00, cast(0 as decimal(8,2))
   from artikel as init
   union
   select o.oartnr, u.uartnr, o.menge*u.menge, (o.vorlauffrist + u.vorlauffrist)
   from ges as o join direktbedarf as u
     on o.uartnr = u.oartnr
)
select oartnr, uartnr, menge, vorlauffrist
from ges
order by oartnr;

select * from gesbedarf;
