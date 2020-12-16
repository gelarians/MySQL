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
