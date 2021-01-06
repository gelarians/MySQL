use seminar;

drop procedure if exists casedemo;
delimiter $$
create procedure casedemo (in zahl int unsigned)
begin
	case zahl
		when 1 then select 'EINS';
		when 2 then select 'ZWEI';
		when 3 then select 'DREI';
        else
			select 'VIELE';
		end case;
end $$
delimiter ;

drop procedure if exists casealternative;
delimiter $$
	create procedure casealternative(in zahl int unsigned)
    begin
		if zahl = 1 then
			select 'EINS';
		else
			if zahl = 2 then
				select 'Zwei';
			else
				if zahl = 3 then
					select 'DREI';
				else 
					select 'VIELE';
                end if;
            end if;
        end if;
    end $$
delimiter ;

call casedemo(2);
call casealternative(2);