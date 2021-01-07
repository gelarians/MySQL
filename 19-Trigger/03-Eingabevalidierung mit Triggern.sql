use leihbib;

select * from verleih;
select * from buch;
select * from leser;


drop trigger if exists verleih_before_insert;
delimiter $$
create trigger verleih_before_insert before insert on verleih for each row -- trigger erstellen 
begin
	
    declare leihbar int unsigned default 0;
    select leihdauer into leihbar from buch where buchnr = new.buchnr;
    
    if leihbar > 0 then
		update buch set ausleihanzahl = ausleihanzahl+1 where buchnr = new.buchnr; -- new.SPALTENAME 
		update leser set ausleihanzahl = ausleihanzahl+1 where lesernr = new.lesernr;
	else
		signal sqlstate '45000';  -- wirft einen fehler wenn leihbar = 0
    end if;
end $$
delimiter ;


insert into verleih (buchnr, lesernr) values (6, 2);