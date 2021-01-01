-- IN-Parameter

use seminar;

drop table if exists anwender;
create table anwender
(
  id      int unsigned not null auto_increment primary key,
  vorname varchar(30)
);
insert into anwender (vorname) values ('Karsten'), ('Ines'), ('Thomas');

delimiter $$
drop procedure if exists paramdemo1 $$
create procedure paramdemo1(in ds int unsigned)
begin
  select * from anwender where id = ds;
end $$
delimiter ;


set @satznummer := 3;
select @satznummer;
call paramdemo1(@satznummer);

select * from anwender;