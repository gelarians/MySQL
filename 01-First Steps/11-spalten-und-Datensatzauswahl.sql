use seminar;

drop table if exists anwender;

create table anwender(
	id			int unsigned not null auto_increment primary key,
    vorname		varchar(30),
    nachname	varchar(30) not null,
    geschlecht 	char(1) not null
);

insert into anwender (vorname, nachname, geschlecht) value ("David", "Mustermann", "m");
insert into anwender (vorname, nachname, geschlecht) value ("Jenny", "Mustermann", "w");
insert into anwender (vorname, nachname, geschlecht) value ("wicki", "TheDog", "w");

select geschlecht, nachname, vorname from anwender
where nachname = "Mustermann";