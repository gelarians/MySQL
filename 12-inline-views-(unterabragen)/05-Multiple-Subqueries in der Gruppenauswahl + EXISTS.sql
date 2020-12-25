use leihbib;

-- Welches ist der am häufigsten gelesene Titel und wie lautet der autor?
-- Hinweis: Titel NICHT Buchexemplar 

select * from buch;

select autor, titel, sum(ausleihanzahl) summe
from buch
group by autor, titel
having sum(ausleihanzahl) >= all(
	select sum(ausleihanzahl)
    from buch
    group by autor, titel
);


-- Wenn die Bibliothek von Lessing besitzt, dann wollen
-- wir alle Klassiker ausgeben, sonst nichts

select *
from buch
where kategorie = 'K'
	and exists (
		select * from buch where autor = 'Lessing'
);