use seminar;

drop procedure if exists collatz;
delimiter $$
create procedure collatz(in startzahl int unsigned)
begin
	declare i int unsigned default 0;
    -- solange startzahl <> 1 tue irgendwas
    repeat   -- start with repeat einmal läuft es mindestens durch
		if startzahl mod 2 = 0 then
			set startzahl := startzahl div 2;
		else
			set startzahl := 3 * startzahl + 1; 
        end if;
	set i := i + 1;
    until startzahl = 1 end repeat;
    select i;  -- das letzte select statement wird ausgegeben beim aufruf der procedure 
end $$
delimiter ;

call collatz(1);