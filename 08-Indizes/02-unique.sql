-- Indizes (Teil 2)
--
-- Primary Key - sorgen fuer Eindeutigkeit, keine NULL-Werte, nue einmal pro Tabelle
-- Foreign Key - sorgen fuer referentielle Integrietaet (NUR InnoDB)
--
-- im Hintergrund werden Indizes angelegt (Indexierung der Daten)
--
-- Unique    - ebenfalls ein eindeutiger Index, jedoch NULL-Werte zulaessig, mehrfach pro Tabelle moeglich
-- Key/Index  - einfache Abfrage-/Suchbeschleunigung


use seminar;

drop table if exists kategorien;
create table kategorien
(
  id          int unsigned not null auto_increment primary key,
  kategorie   varchar(30) unique                         -- auch eindeutig
);

insert into kategorien (kategorie) values ('Kategorie A');
insert into kategorien (kategorie) values ('Kategorie A');        -- nicht moeglich, weil doppelt
insert into kategorien (id, kategorie) values (2, 'Kategorie A'); -- hilft (zum Glueck) auch nicht
-- ABER: mehrfache NULL-Werte sind möglich
insert into kategorien (kategorie) values (null);   -- NOT NULL war nicht gefordert
insert into kategorien (kategorie) values (null);

select * from kategorien;


