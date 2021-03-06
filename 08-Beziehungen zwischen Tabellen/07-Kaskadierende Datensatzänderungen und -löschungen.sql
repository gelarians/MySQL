-- Foreign Keys (Fremdschluessel)
--
-- Referentielle Integritaet (ON UPDATE/DELETE CASCADE)

use seminar;

drop table if exists mitarbeiter2projekte;
drop table if exists mitarbeiter;
drop table if exists projekte;

drop table if exists projekte;        
create table projekte
(
  proj_id         int unsigned not null auto_increment primary key,
  Projekt         varchar(30) not null
  -- weitere Spalten
);

create table mitarbeiter
(
  pers_id         int unsigned not null auto_increment primary key,
  vorname         varchar(30) not null
  -- weitere Spalten
);

create table mitarbeiter2projekte -- ACHTUNG: Aendern und LOESCHEN wird jetzt durchgereicht !!!
(
  pers_id         int unsigned not null,
  proj_id         int unsigned not null,
  -- weitere Spalten
  primary key (pers_id, proj_id),
  foreign key (pers_id) references mitarbeiter (pers_id)
    on update cascade on delete cascade,
  foreign key (proj_id) references projekte (proj_id)
    on update cascade on delete cascade
);



insert into mitarbeiter (vorname) values ('Karsten'), ('Ines'), ('Thomas');
insert into projekte (projekt) values ('Projekt A'), ('Projekt B'), ('Projekt C');
insert into mitarbeiter2projekte (pers_id, proj_id) values (1, 1), (1, 2), (2, 1), (3, 1), (3,3);

-- Verletzung der referentiellen Integritaet (Fremdschluessel verweisen auf nicht vorhandene Daten)
insert into mitarbeiter2projekte (pers_id, proj_id) values (4, 4);

delete from mitarbeiter where pers_id = 1;            -- geht jetzt: Projektzuordnung wird geloescht
update mitarbeiter set pers_id = 4 where pers_id = 2; -- geht auch: Referenz wird automatisch angepasst

select *
from mitarbeiter m
join mitarbeiter2projekte m2p on m.pers_id = m2p.pers_id
join projekte p on p.proj_id = m2p.proj_id;