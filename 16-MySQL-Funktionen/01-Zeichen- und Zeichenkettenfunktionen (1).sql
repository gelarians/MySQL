-- function and operator 
-- reference


use seminar;

drop table if exists personen;
create table personen
(
  id        int unsigned not null auto_increment primary key,
  nachname  varchar(30) not null,
  vorname   varchar(30)
);
insert into personen(nachname, vorname)
values ('Brodmann', 'Karsten'),
       ('Rekers', 'Thomas'),
       ('Engels', null);
       
select vorname, nachname from personen;

-- Brodmann, Karsten

select concat(nachname, if(vorname is null,'', concat(', ', left(vorname,1), '.'))) person from personen;

select upper(nachname) from personen;


