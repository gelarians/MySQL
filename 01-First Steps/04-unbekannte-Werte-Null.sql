use seminar;

show tables;

desc anwender;

drop table if exists anwender;

create table anwender
(
	id			int unsigned not null,
    vorname		varchar(30) not null
);

insert into anwender (id, vorname) values (1,"Karsten");
insert into anwender (vorname, id) values ("David", 2);

insert into anwender (vorname, id) values (null, null);

select * from anwender;

insert into anwender (vorname) values ("Jenny");

insert into anwender (id) values (3);