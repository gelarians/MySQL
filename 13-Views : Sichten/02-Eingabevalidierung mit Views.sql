-- Eingabevalidierung mit Views
use seminar;

show tables;

drop table if exists werte;
create table werte(			-- UNZULÄSSIG: -99.99 .. 99.99
	id		int unsigned not null auto_increment primary key,
    wert	numeric(6,2) not null
);

create or replace view vwerte (id, wert)
as
select id, wert
from werte
where wert < -99.99 or wert > 99.99
with check option;

insert into werte (wert) values (50.00);  -- so nicht da hier nicht gepprüft wird nutz dafür die view!

insert into vwerte (wert) values (120.00);
update vwerte set wert = 101 where id = 2;
delete from vwerte where id = 1;

select * from werte;
select * from vwerte;