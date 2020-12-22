-- Schwieriger: Berechnen Sie, wieviel Prozent des Buchbestandes aktuell ausgeliehen ist.

--             Anzahl verliehener Bücher * 100
-- prozent = ----------------------------------
--             Gesamtanzahl unserer Bücher

select count(*) from verleih;
select count(*) from buch;

select 4*100/11;

select count(v.buchnr)*100 / count(b.buchnr) as prozent
from verleih v
right join buch b on b.buchnr = v.buchnr;
