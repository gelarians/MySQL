-- Logische Verknuepfungen und Klammern
--
-- Logische Verknupfungen haben unterschiedliche Bindungskraft/Priorietaet.
-- AND bindet beispielsweise stärker als OR. Um dies ggf. zu uebersteuern
-- oder einen logischen Ausdruck besser lesbar zu machen, koennen wir
-- Klammern verwenden. Klammerausdruecke haben bei der Auswertung oberste
-- Priorietaet. Geschachtelte Klammerausdruecke werden von innen nach
-- aussen ausgewertet, so wie aus der Mathematik bekannt.

use seminar;                          -- benutze die Datenbank "seminar"
  
select * from anwender;

select * from anwender
where vorname = 'Wolfgang' or lebensalter >= 42 and lebensalter <= 52;    -- (1)

select * from anwender
where vorname = 'Wolfgang' or (lebensalter >= 42 and lebensalter <= 52);  -- (2) = Pendant zu (1)

select * from anwender
where (vorname = 'Wolfgang' or lebensalter >= 42) and lebensalter <= 52;  -- (3) dies ist was anderes

