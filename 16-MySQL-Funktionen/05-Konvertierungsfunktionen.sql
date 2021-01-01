use seminar;

drop table if exists zahlen; 

create table zahlen
(
  zahl  int
);

insert into zahlen (zahl) values (1), (2), (3);

select * from zahlen;

-- Anzahl: xx
select count(*), sum(zahl) from zahlen;

select concat('Anzahl: ', cast(count(*) as char)) from zahlen;