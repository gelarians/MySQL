use seminar;

drop procedure if exists collatz;
delimiter $$
create procedure collatz(in startzahl bigint unsigned)
begin
	declare i int unsigned default 0;
    -- solange startzahl <> 1 tue irgendwas
    schleife: loop -- schlüsselwort: LOOP 
		
        if startzahl = 1 then -- bedingung zum beenden der loop schleife 
			leave schleife;
        end if;
        
		if startzahl mod 2 = 0 then
			set startzahl := startzahl div 2;
		else
			set startzahl := 3 * startzahl + 1; 
        end if;
	set i := i + 1;
    end loop schleife;
    select i;  -- das letzte select statement wird ausgegeben beim aufruf der procedure 
end $$
delimiter ;

call collatz(987653729112212129);