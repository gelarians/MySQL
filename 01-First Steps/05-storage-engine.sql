use seminar;

desc anwender;

drop table if exists anwender;
create table anwender
(
	id			int unsigned not null,
    vorname		varchar(30) not null
);

create table anwender2
(
	id			int unsigned not null,
    vorname		varchar(30) not null
) engine=myisam;


insert into anwender (id, vorname) values (1,"Karsten");
insert into anwender (vorname, id) values ("David", 2);

select * from anwender;

show table status;

show engines;

set default_storage_engine=innodb;
