use leihbib;

-- Welches ist das meist gelesene Buchexemplar und wie heißt dessen Autor?
-- (Hinweis: es können mehrere Buchexemplare sein)

select * from buch;  -- --> Goethe, Faust, 12
delete from buch
where buchnr = 12;

select autor, titel , max(ausleihanzahl) as aa 
from buch
group by autor, titel
order by aa desc;

select autor, titel, ausleihanzahl
from buch
where ausleihanzahl = (
    select max(ausleihanzahl)
    from buch
  );

