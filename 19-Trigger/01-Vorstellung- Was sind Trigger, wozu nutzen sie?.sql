use leihbib;

select * from verleih;

select * from buch;
select * from leser;

insert into verleih (buchnr, lesernr) values (5, 2);
update buch set ausleihanzahl = ausleihanzahl+1 where buchnr = 5;
update leser set ausleihanzahl = ausleihanzahl+1 where lesernr = 2;