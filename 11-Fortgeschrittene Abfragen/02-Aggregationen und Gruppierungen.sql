use leihbib;

insert into buch(autor, titel,  kategorie)
values ('Brix', 'Bootsbau', 'W');

update buch set ausleihanzahl = 10 where buchnr = 1;
update buch set ausleihanzahl = 12 where buchnr = 2;
update buch set ausleihanzahl =  3 where buchnr = 3;
update buch set ausleihanzahl =  8 where buchnr = 4;
update buch set ausleihanzahl =  5 where buchnr = 6;
update buch set ausleihanzahl =  8 where buchnr = 5;
update buch set ausleihanzahl =  6 where buchnr = 7;
update buch set ausleihanzahl =  3 where buchnr = 8;

update leser set ausleihanzahl = 25 where lesernr = 1;
update leser set ausleihanzahl = 10 where lesernr = 3;
update leser set ausleihanzahl =  8 where lesernr = 4;
update leser set ausleihanzahl =  7 where lesernr = 12;


-- Welche Autoren sind in unserer Bibliothek vertreten?
select distinct autor
from buch
where autor is not null
order by autor;

-- Wieviele unterschiedliche Autoren sind das?
select count(distinct autor)
from buch;

-- Bilden Sie ein Autoren-Ranking auf Basis des am häufigsten  (VORHER Datenbestand UPDATEN)
-- gelesenen Buchexemplars
select autor, max(ausleihanzahl) anzahl
from buch
group by autor
order by anzahl desc;

-- Bilden Sie ein Autoren-Ranking auf Basis des am häufigsten
-- gelesenen Buchtitels
select autor, titel, sum(ausleihanzahl) anzahl
from buch
group by autor, titel
order by anzahl desc;

-- Von welchen Autoren wurden mehr als 8 Ausleihvorgänge
-- in Bezug auf einen Buchtitel registriert?
select autor, titel, sum(ausleihanzahl) anzahl
from buch
group by autor, titel
having sum(ausleihanzahl) > 8
order by anzahl desc;

-- Wie vor, berücksichtigen Sie jedoch nur Buchexemplare,
-- die häufiger als 5 Ausleihungen haben.
select autor, titel, sum(ausleihanzahl) anzahl
from buch
where ausleihanzahl > 5
group by autor, titel
having sum(ausleihanzahl) > 8
order by anzahl desc;

select * from buch;

