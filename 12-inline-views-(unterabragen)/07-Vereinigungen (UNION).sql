use seminar;

drop table if exists person;
drop table if exists stadt;

create table stadt (
  id            int unsigned not null auto_increment primary key,
  ortsname      varchar(40) not null
);
insert into stadt (ortsname) 
values 
  ('Osnabrück'), ('Berlin'), ('Hannover'), ('Hamburg');

create table person
(
  id            int unsigned not null auto_increment primary key,
  vorname       varchar(30) not null,
  wohnort       int unsigned,
  foreign key (wohnort) references stadt (id)
);
insert into person (vorname, wohnort)
  values
  ('Karsten', 1), ('Ines', 1), ('Wolfgang', 3), ('Martin', 4), ('Erik', null);
        
select vorname, ortsname
from person p
join stadt s on p.wohnort = s.id;

select * from stadt;

select vorname, ortsname
from person p
left join stadt s on p.wohnort = s.id;

select vorname, ortsname
from person p
right join stadt s on p.wohnort = s.id;

select vorname, ortsname
from person p
left join stadt s on p.wohnort = s.id
union
select vorname, ortsname
from person p
right join stadt s on p.wohnort = s.id;
