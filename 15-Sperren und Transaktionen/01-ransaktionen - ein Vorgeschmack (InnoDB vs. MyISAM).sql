-- Transaktionen - ein Vorgeschmack

--    Zustand A -----> ( Aktion(en) ) -----> Zustand B
--                      Transaktion 
use seminar;

show engines;


set @oldmode := @@session.sql_mode;
set session sql_mode = 'TRADITIONAL';

drop table if exists demo_innodb;
create table demo_innodb (
  id     int not null auto_increment primary key,
  wert   enum('w', 'm') not null
) engine = innodb;

drop table if exists demo_myisam;
create table demo_myisam (
  id     int not null auto_increment primary key,
  wert   enum('w', 'm') not null
) engine = myisam;

insert into demo_innodb (wert)
values ('m'), ('w'), ('Q'), ('m');

insert into demo_myisam (wert)
values ('m'), ('w'), ('Q'), ('m');

select * from demo_innodb;
select * from demo_myisam;

set session sql_mode = @oldmode;