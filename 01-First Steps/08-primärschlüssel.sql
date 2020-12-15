use seminar;

drop table if exists anwender;

create table anwender(
	id			int unsigned not null ,
    vorname		varchar(30),
    primary key (id)
);


insert into anwender (id, vorname) value (1, "David");
insert into anwender (id, vorname) value (2, "Jenny");

set sql_safe_updates=1;
delete from anwender where id=1;

select * from anwender;