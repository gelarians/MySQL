-- benutze datenbank seminar
use seminar;

#ertstelle eine tabelle
create table anwender
(
	vorname	varchar(30)
);

show tables;

insert into anwender (vorname) values("Karsten");
insert into anwender (vorname) values("David");

select * from anwender;