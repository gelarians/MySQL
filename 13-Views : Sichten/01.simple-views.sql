use leihbib;

create or replace view ausleihbar (buchnr, autor, titel, leihfrist)
as
select b.buchnr, b.autor, b.titel, b.leihdauer 
from buch b
left join verleih v on v.buchnr= b.buchnr
where v.buchnr is null
	and b.leihdauer > 0;
    
    
select * from ausleihbar;

drop view ausleihbar;