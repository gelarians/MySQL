-- ORDER BY - Datensaetze sortieren
--
-- DESC sortiert absteigend 
-- ASC  sortiert aufsteigend (Vorgabe)
--
-- beachte: NULL wird aufsteigend als erstes ausgegeben, absteigend als letzter Wert

use seminar;                          -- benutze die Datenbank "seminar"

select * from anwender;

select * from anwender
order by vorname;                     -- alphabetische Sortierung nach Vorname

select * from anwender
order by lebensalter;                 -- nach Alter sortiert

select * from anwender
order by 3;                           -- Sortierung nach der 3. Ausgabespalte (hier Alter)

select id, lebensalter, vorname
from anwender
order by 3;                           -- jetzt wieder nach Vorname sortiert

select id, lebensalter, vorname
from anwender
order by lebensalter;                 -- Spaltenbezeichner sortiert unabhängig von dessen Position in Ausgabe

select id, lebensalter, vorname
from anwender
order by lebensalter, vorname;        -- mehrere Sortierspalten moeglich

select vorname, lebensalter 
from anwender
order by vorname asc, lebensalter desc; -- Vorname aufsteigend, Lebensalter absteigend