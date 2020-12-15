use seminar;

drop table if exists anwender;

create table anwender(
	id			int unsigned not null auto_increment , -- auto_increment addiert immer 1 drauf, wenn ein neuer datensatz eingefügt wird
    vorname		varchar(30),
    primary key (id)
);

insert into anwender (vorname) value ("David");
insert into anwender (vorname) value ("jenny"); 
insert into anwender (id, vorname) values (null, "Wicki");
insert into anwender (id, vorname) values (8, "Wicki");

select * from anwender;