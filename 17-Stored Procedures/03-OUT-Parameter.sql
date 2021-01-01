use seminar;

drop table if exists anwender;
create table anwender
(
  id      int unsigned not null auto_increment primary key,
  vorname varchar(30)
);
insert into anwender (vorname) values ('Karsten'), ('Ines'), ('Thomas');

select * from anwender;

drop procedure if exists paramdemo2;
delimiter //
create procedure paramdemo2(in ds int unsigned, out anw varchar(30))
begin
  select vorname into anw from anwender where id = ds;
end //
delimiter ;

set @nummer := 2;

call paramdemo2(@nummer, @anwender);
select @anwender;