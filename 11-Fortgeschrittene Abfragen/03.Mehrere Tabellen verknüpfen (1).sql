use leihbib;

set sql_safe_updates = 0;

-- vorhandene Verleihvorgaenge loeschen
delete from verleih;
-- Verleihvorgaenge einfuegen, OHNE Ruecksicht auf Statistik!!!
insert into verleih(lesernr, buchnr) values (1,1);
insert into verleih(lesernr, buchnr) values (1,2);
insert into verleih(lesernr, buchnr) values (2,3);
insert into verleih(lesernr, buchnr) values (3,4);

-- ein paar Strafen
delete from strafe;
insert into strafe (lesernr, gebuehr, sperre)
values 
  (1, 2.00, false),
  (2, 1.00, false),
  (4, 10.0, true),
  (5, 12.00, true);
  
-- die Ausleihdauer eines verliehenen Buchs ist ueberschritten
update verleih
set ausleihdatum = current_timestamp()
where buchnr < 2;
update verleih
set ausleihdatum = date_sub(now(), interval 60 day)
where buchnr >= 2;

set sql_safe_updates=1;



-- Welcher Leser hat aktuell welchen Buchtitel ausgeliehen?
select l.lesernr id, l.nachname nachname, b.titel titel
from leser l
join verleih v on l.lesernr = v.lesernr
join buch b on v.buchnr = b.buchnr;

-- Erstellen Sie eine Leserliste mit der Anzahl der von Ihnen 
-- geliehenen Bücher.
select l.lesernr id, l.nachname nachname, count(v.lesernr) anzahl
from leser l 
left join verleih v on l.lesernr = v.lesernr
group by id, nachname;
