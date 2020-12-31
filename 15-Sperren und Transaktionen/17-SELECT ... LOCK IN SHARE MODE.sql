use seminar;

drop table if exists buecher;
drop table if exists bibliotheken;

create table bibliotheken
(
  id    int unsigned not null auto_increment primary key,
  stadt varchar(30) not null unique
);

create table buecher
(
  id    int unsigned not null auto_increment primary key,
  titel varchar(30),
  bib   int unsigned,
  foreign key (bib) references bibliotheken (id)
);

insert into bibliotheken (stadt) values ('Hamburg'), ('Berlin'), ('Bremen');

select * from bibliotheken;

start transaction;

select @bib := id from bibliotheken where stadt = 'Berlin' lock in share mode; -- lock in share mode = lässt berilin nicht löschen wären der transaktion

insert into buecher (titel, bib) values ('Faust', @bib);

commit;

select * from buecher;