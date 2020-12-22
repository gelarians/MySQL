-- Erstellen Sie eine alphabetisch sortierte Liste der Autoren 
-- und der zugehörigen Buchtitel (ebenfalls alphabetisch)
use leihbib;

select autor, titel
from buch
order by autor, titel;

select autor, titel
from buch
order by 1, 2;


-- Welche ausleihbaren Bücher wurden bislang nicht ausgeliehen?
select * from buch;
select buchnr, titel, autor
from buch
where 
    leihdauer > 0
and ausleihanzahl = 0;

-- Welche Bücher in den Kategorien Klassik und Wissen können ausgeliehen werden?
select * from buch;
select *
from buch
where (kategorie = 'K' or kategorie = 'W')
  and leihdauer <> 0;
  
select * from buch;
select *
from buch
where kategorie in ('K', 'W')
  and not leihdauer = 0;
  
update buch set leihdauer = 0 where buchnr = 6;

-- Welche Bücher haben keinen Autor?
  -- Vorbereitung:
insert into buch (autor, titel, kategorie, leihdauer)
  values (null, 'Guinessbuch der Weltrekorde', 'W', 14);
  
select *
from buch
where autor is null;