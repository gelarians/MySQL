use seminar;

drop procedure if exists collatz;
delimiter $$
create procedure collatz(in startzahl int unsigned)
begin
	declare i int unsigned default 0;
    -- solange startzahl <> 1 tue irgendwas
    while startzahl <> 1 do
		if startzahl mod 2 = 0 then
			set startzahl := startzahl div 2;
		else
			set startzahl := 3 * startzahl + 1; 
        end if;
	set i := i + 1;
    end while;
    select i;
end $$
delimiter ;

call collatz(5);