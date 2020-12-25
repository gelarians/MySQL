use leihbib;

-- Welches ist das am wenigsten häufig ausgeliehende Buch, der ausleihbaren und bereits ausgeliehenden Bücher?

select * from buch;

select *
from buch
where ausleihanzahl > 0 and
leihdauer > 0 and 
ausleihanzahl <= all (
	select ausleihanzahl
    from buch
    where leihdauer > 0 and ausleihanzahl > 0
);