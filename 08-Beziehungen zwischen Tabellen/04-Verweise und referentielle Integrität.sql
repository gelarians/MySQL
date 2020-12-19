-- Foreign Keys (Fremdschluessel)
--
-- Referentielle Integritaet

use seminar;

-- m:n-Beziehung, z.B. Mitarbeiter - Projekte, jeder Mitarbeiter arbeitet an mehreren Projekten
--                                   und in jedem Projekt können mehrere Mitarbeiter involviert sein
--
-- m:n-Beziehungeung muessen immer in zwei 1:n-Beziehungen aufgeloest werden

drop table if exists mitarbeiter;
create table mitarbeiter
(
  pers_id         int unsigned not null auto_increment primary key,
  vorname         varchar(30) not null
  -- weitere Spalten
);

drop table if exists mitarbeiter2projekte;
create table mitarbeiter2projekte
(
  pers_id         int unsigned not null,
  proj_id         int unsigned not null,
  -- weitere Spalten
  primary key (pers_id, proj_id)
);

drop table if exists projekte;        -- Mitarbeiter und Projekte zusammenfuehren
create table projekte
(
  proj_id         int unsigned not null auto_increment primary key,
  Projekt         varchar(30) not null
  -- weitere Spalten
);

insert into mitarbeiter (vorname) values ('Karsten'), ('Ines'), ('Thomas');
insert into projekte (projekt) values ('Projekt A'), ('Projekt B'), ('Projekt C');
insert into mitarbeiter2projekte (pers_id, proj_id) values (1, 1), (1, 2), (2, 1), (3, 1), (3,3);

-- Verletzung der referentiellen Integritaet (Fremdschluessel verweisen auf nicht vorhandene Daten)
insert into mitarbeiter2projekte (pers_id, proj_id) values (4, 4);
delete from mitarbeiter2projekte where pers_id = 4;   -- Korrektur, fehlerhafter Datensatz geloescht

-- bessere Tabellendefinitionen mit Foreign Keys
drop table if exists mitarbeiter2projekte;
create table mitarbeiter2projekte
(
  pers_id         int unsigned not null,
  proj_id         int unsigned not null,
  -- weitere Spalten
  primary key (pers_id, proj_id),
  foreign key (pers_id) references mitarbeiter (pers_id),
  foreign key (proj_id) references projekte (proj_id)
);

-- Daten wieder einfuegen
insert into mitarbeiter2projekte (pers_id, proj_id) values (1, 1), (1, 2), (2, 1), (3, 1), (3,3);
-- Falsche Daten werden nicht mehr angenommen
insert into mitarbeiter2projekte (pers_id, proj_id) values (4, 4);



select *
from mitarbeiter m
join mitarbeiter2projekte m2p on m.pers_id = m2p.pers_id
join projekte p on p.proj_id = m2p.proj_id;