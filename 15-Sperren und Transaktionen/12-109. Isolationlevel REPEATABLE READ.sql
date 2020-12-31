use seminar;

drop table if exists person;
create table person
(
  id        int unsigned not null auto_increment primary key,
  vorname   varchar(30) not null
);
insert into person (vorname) values ('Karsten'), ('Ines'), ('Thomas');

show index in person;

set session transaction isolation level repeatable read;
select @@session.transaction_isolation;

start transaction;                    -- ganze Tabelle gesperrt
select * from person
where vorname = 'Karsten';
commit;

start transaction;                    -- Datensatzsperre
select * from person where id = 1;
commit;

create unique index idx_person_vorname on person (vorname); -- unique index ist wichtig das nciht die ganze tabelle gespoert ist

start transaction;                    -- Datensatzsperre
select * from person
where vorname = 'Karsten';
commit;

select * from person;