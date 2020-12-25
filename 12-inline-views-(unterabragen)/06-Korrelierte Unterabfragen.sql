use leihbib;

-- Korrelierte Unterabfragen

-- Liste der verliehenen Bücher
select *
from buch
where buchnr = (
    select buchnr
    from verleih 
    where buchnr = buch.buchnr
  );


-- Datenbestand "aufhübschen"
set sql_safe_updates = 0;
update leser set wohnort = 'Osnabrück' where lesernr <= 3;
update leser set wohnort = 'Rheine' where lesernr >= 4;
set sql_safe_updates = 1;

-- Leser mit den höchsten Gebühren je Stadt
select nachname, vorname, wohnort, gebuehr
from leser l
join strafe s on l.lesernr = s.lesernr
where gebuehr = (
  select max(gebuehr)
  from leser ll
  join strafe ss on ll.lesernr = ss.lesernr
  where ll.wohnort = l.wohnort
);