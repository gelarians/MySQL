use seminar;

drop table if exists anwender;
create table anwender
(
  id      int unsigned not null auto_increment primary key,
  vorname varchar(30)
);
insert into anwender (vorname) values ('Karsten'), ('Ines'), ('Thomas');

select * from anwender;

drop procedure if exists paramdemo3;
delimiter $$
create procedure paramdemo3(inout anw varchar(40))
begin
  select concat(vorname, ' (', id, ')') into anw from anwender where vorname = anw;
end $$
delimiter ;

-- Karsten --> Karsten (1)
select concat(vorname, ' (', id, ')') from anwender;

set @anwender := 'Thomas';
select @anwender;
call paramdemo3(@anwender);
select @anwender;
