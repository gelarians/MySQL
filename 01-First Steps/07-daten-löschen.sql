use seminar;

drop table if exists anwender;

create table anwender(
	id			int unsigned not null,
    vorname		varchar(30)
);

insert into anwender (id, vorname) value (1, "David");
insert into anwender (id, vorname) value (2, "Jenny");

#lösche alles aus der datenbank "anwender"
delete from anwender;

#nun kannst du über die workbench auch mehrere einträge löschen
# oder auf workbench -> settings -> sql editor -> unten save updates austellen
set sql_safe_updates=0;
set sql_safe_updates=1;


select * from anwender;