use seminar;

drop table if exists anwender;        
create table anwender                 
(
  id            int unsigned not null auto_increment primary key,  
  vorname       varchar(30) not null,
  lebensalter   int unsigned,
  geschlecht	enum('w','m')
);

show tables;
desc anwender;

insert into anwender (vorname, lebensalter, geschlecht)
values
  ('Karsten', 52, 'm'),
  ('Ines', 50, 'w'),
  ('Dierk', 66, 'm'),
  ('Katharina', 24, 'w'),
  ('Wolfgang', 66, 'm'),
  ('Wolfgang', 42, 'm'),
  ('Stefanie', 42, 'w'),
  ('Markus', 52, 'm'),
  ('Annette', null, 'w'),
  ('Andrea', 36, 'w');
  
select * from anwender;

select max(lebensalter), vorname
from anwender
group by vorname
order by max(lebensalter) desc;

select geschlecht, count(geschlecht)
from anwender
group by geschlecht;

select vorname, max(lebensalter), geschlecht
from anwender
group by vorname, geschlecht
order by max(lebensalter);

