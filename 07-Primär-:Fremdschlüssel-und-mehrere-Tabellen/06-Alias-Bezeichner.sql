-- Aliases 
-- 
-- Tabellen- und Spalten mit Aliasbezeichnern verwenden

use seminar;

drop table if exists personen;
create table personen
(
  id        int unsigned not null auto_increment primary key,
  vorname   varchar(30) not null,
  ort       int unsigned 
);

drop table if exists wohnorte;
create table wohnorte
(
  id         int unsigned not null auto_increment primary key,
  ort        varchar(30) not null
);

insert into wohnorte (ort) values ('Osnabrück'), ('Hamburg'), ('Berlin');

insert into personen (vorname, ort)  
values ('Karsten', 1),              
       ('Ines', 1),            
       ('Wolfgang', 2),             
       ('Annette', null);
       
select * from personen;
select * from wohnorte;

select vorname, wohnorte.ort
from personen
join wohnorte on personen.ort = wohnorte.id;

select vorname, p.id as persid, w.id as ortid, w.ort    -- Aliasbezeichner fuer Spalten
from personen p                                         -- Aliasbezeichner fuer Tabellen
join wohnorte w on p.ort = w.id
order by persid desc;									-- hier kannst du den alias verwenden!