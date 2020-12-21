use leihbib;

select * from buch;
select * from leser;

-- Verleihvorgang
set @buchid := 1;
set @leserid := 1;
select @buchid;


insert into verleih(buchnr, lesernr) values (@buchid, @leserid);
update buch set ausleihanzahl = ausleihanzahl+1 where buchnr = @buchid;
update leser set ausleihanzahl = ausleihanzahl+1 where lesernr = @leserid;

set @buchid := 2;   -- variablen erstellen
set @leserid := 2;  -- wichtig := !! 
select @buchid;
insert into verleih(buchnr, lesernr) values (@buchid, @leserid);
update buch set ausleihanzahl = ausleihanzahl+1 where buchnr = @buchid;
update leser set ausleihanzahl = ausleihanzahl+1 where lesernr = @leserid;

select * from leser;
select * from buch;