use seminar;

show tables;

desc anwender;

drop table if exists anwender;
create table anwender
(
	id			int unsigned,
    vorname		varchar(30)
);

insert into anwender (id, vorname) values (1,"Karsten");
insert into anwender (vorname, id) values ("David", 2);

select * from anwender;