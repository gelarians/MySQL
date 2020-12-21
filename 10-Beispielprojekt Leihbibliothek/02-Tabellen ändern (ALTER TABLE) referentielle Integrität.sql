-- leihbib-create-db.sql
--
-- Erstellt eine Datenbank fuer eine Leihbibliothek
--

-- Datenbank erstellen, vorhandene DB ggf. loeschen
drop database if exists leihbib;
create database leihbib
  character set latin1
  collate latin1_german2_ci;
  
use leihbib;                                                -- zu verwendende Datenbank

-- evtl. vorhandene Tabellen loeschen (beachte Reihenfolge Fremdschluesselbeziehungen
drop table if exists strafe;
drop table if exists vormerkung;
drop table if exists verleih;
drop table if exists leser;
drop table if exists buch;

-- Tabellen erzeugen

create table buch
(
  buchnr          int unsigned not null auto_increment primary key,
  autor           varchar(45),
  titel           varchar(100) not null,
  kategorie       enum('U', 'K', 'W') not null default 'U', -- U = Unterhaltung, K = Klassik, W = Wissen
  ausleihanzahl   int unsigned not null default 0,
  leihdauer       int unsigned not null default 30          -- 0 = Präsenzexemplar
) engine = innodb;

create table leser
(
  lesernr         int unsigned not null auto_increment primary key,
  vorname         varchar(30) not null,
  nachname        varchar(30) not null,
  wohnort         varchar(45) not null,                     -- nicht normalisiert!!!
  ausleihanzahl   int unsigned not null default 0,
  eintrittsdatum  date not null,
  austrittsdatum  date default null
) engine = innodb;

create table verleih
(
  buchnr          int unsigned not null primary key,
  lesernr         int unsigned not null,
  ausleihdatum    timestamp not null default current_timestamp,
  leihdauer       int unsigned not null default 30
  -- foreign key (buchnr) references buch (buchnr),
  -- foreign key (lesernr) references leser (lesernr)
) engine = innodb;

create table vormerkung
(
  buchnr          int unsigned not null,
  lesernr         int unsigned not null,
  datum           timestamp not null default current_timestamp,
  primary key (buchnr, lesernr)
) engine = innodb;

create table strafe
(
  lesernr         int unsigned not null primary key,
  gebuehr         decimal(6,2) not null default 0.00,
  sperre          boolean not null default false
) engine = innodb;

-- foreign key für VERLEIH
alter table verleih add constraint fk_verleih_buch
	foreign key (buchnr) references buch(buchnr);
alter table verleih add constraint fk_verleih_leser
	foreign key (lesernr) references leser (lesernr);
-- foreign key für VORMERKUNG
alter table vormerkung add constraint fk_vormerkung_buch
	foreign key (buchnr) references buch(buchnr);
alter table vormerkung add constraint fk_vormerkung_leser
	foreign key (lesernr) references leser (lesernr);
-- foreign key für STRAFE
alter table strafe add constraint fk_strafe_leser
	foreign key (lesernr) references leser (lesernr);
    
