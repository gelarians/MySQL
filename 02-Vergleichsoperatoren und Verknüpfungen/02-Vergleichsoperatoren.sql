-- Vergleichsoperatoren


use seminar;                          -- benutze die Datenbank "seminar"


drop table if exists anwender;        
create table anwender                 
(
  id            int unsigned not null auto_increment primary key,  
  vorname       varchar(30) not null,
  lebensalter   int unsigned
);

show tables;
desc anwender;

insert into anwender (vorname, lebensalter)
values
  ('Karsten', 52),
  ('Ines', 50),
  ('Dierk', 66),
  ('Katharina', 24),
  ('Wolfgang', 66),
  ('Wolfgang', 42),
  ('Stefanie', 42),
  ('Markus', 52),
  ('Annette', null),
  ('Andrea', null);
  
select * from anwender;

select * from anwender where lebensalter = 42;
select * from anwender where lebensalter < 42;
select * from anwender where lebensalter > 42;
select * from anwender where lebensalter <= 42;
select * from anwender where lebensalter >= 42;
select * from anwender where lebensalter <> 42;
select * from anwender where lebensalter != 42;

select * from anwender where vorname < 'Katharina';
select * from anwender where vorname = 'Katharina';
-- LIKE : _ entspricht EINEM beliebigen Zeichen, % entspricht beliebigen Zeichen
select * from anwender where vorname like 'A%';       -- Vornamen, die mit 'A' beginnen
select * from anwender where vorname like '%n%';      -- Vornamen, die ein 'n' enthalten
select * from anwender where vorname like '_a%';      -- Vornamen, die an zweiter Stelle ein 'a' enthalten

select * from anwender where lebensalter between 40 and 49;

select * from anwender where lebensalter is null;     -- alle Datensaetze ohne Altersangabe
select * from anwender where lebensalter is not null; -- alle Datensaetze mit Lebensalter

select * from anwender where vorname in ('Karsten', 'Ines', 'Peter');
