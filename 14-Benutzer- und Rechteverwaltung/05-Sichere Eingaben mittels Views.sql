use seminar;

drop table if exists wertetab;
create table wertetab ( -- UNZULAESSIG: -99.99 .. 99.99
  id        int unsigned not null auto_increment primary key,
  wert      numeric(6,2) not null
);


create or replace 
sql security definer
view werte2 (id, wert)
as
select id, wert
from wertetab
where wert < -99.99 or wert > 99.99
with check option;

drop user 'test'@'localhost';
create user 'test'@'localhost' identified by '1234';
grant select, insert, update, delete on seminar.werte2 to 'test'@'localhost';

select * from wertetab;

show full tables;