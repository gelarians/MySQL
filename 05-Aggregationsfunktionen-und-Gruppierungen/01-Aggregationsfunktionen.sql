-- Aggregationsfunktionen
-- Datensätze in einer geeigneten form zusammensetzen
-- alle Aggregationsfunktionen ignorieren null!!

use seminar;

select count(*) from anwender;

select max(lebensalter), min(lebensalter), avg(lebensalter), sum(lebensalter), count(lebensalter)
		from anwender;

select * from anwender;

