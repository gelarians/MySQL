use leihbib;

select * from verleih;

select * from buch;
select * from leser;

insert into verleih (buchnr, lesernr) values (7, 2);
update buch set ausleihanzahl = ausleihanzahl+1 where buchnr = 5;
update leser set ausleihanzahl = ausleihanzahl+1 where lesernr = 2;


drop trigger if exists verleih_before_insert;
delimiter $$
create trigger verleih_before_insert before insert on verleih for each row -- trigger erstellen 
begin
	update buch set ausleihanzahl = ausleihanzahl+1 where buchnr = new.buchnr; -- new.SPALTENAME 
	update leser set ausleihanzahl = ausleihanzahl+1 where lesernr = new.lesernr;
end $$
delimiter ;