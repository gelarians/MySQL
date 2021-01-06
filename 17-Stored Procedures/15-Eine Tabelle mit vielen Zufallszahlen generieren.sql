use seminar;

drop table if exists zufall;
create table zufall
(
	zahl int not null 
);

-- mysql rand()
-- floor() rundet ab

delimiter $$
drop procedure if exists zufallsgen $$
create procedure zufallsgen(in anzahl int unsigned)
begin
	-- delete from zufall;
	while anzahl > 0 do
	insert into zufall (zahl)  values (floor(rand()*100 + 1)); -- zufällige zahl zwischen 1 und 100
    set anzahl := anzahl -1;
    end while;
end $$
delimiter ;

set sql_safe_updates=0;
call zufallsgen(100);

select * from zufall;