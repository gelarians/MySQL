use seminar;

-- MySQL-Standard-Isolationslevel
set session transaction isolation level repeatable read;
select @@session.transaction_isolation;


drop table if exists person;
create table person
(
  id        int unsigned not null auto_increment primary key,
  vorname   varchar(30) not null
);
insert into person (vorname) values ('Karsten'), ('Ines'), ('Thomas');

start transaction;   
select * from person;
-- 1. Datensatzänderung
update person set vorname = 'Kerstin' where id = 2;
savepoint sicher1;
-- 2. Datensatzänderung
update person set vorname = 'Kerstin' where id = 1;
select * from person;
rollback to sicher1;
select * from person;
rollback;                 
select * from person;

commit;

