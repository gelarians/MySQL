-- Enum types

use seminar;
create table aufzählung
(
	kategorie		enum('unterhaltung', 'Klassik', 'Wissen')
);

insert into aufzählung (kategorie) values ('Klassik');
insert into aufzählung (kategorie) values ('Sport');
insert into aufzählung (kategorie) values ('unterhaltung');

select * from aufzählung;
desc aufzählung;