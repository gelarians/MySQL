use leihbib;

-- Welche Bücher sind aktuell ausgeliehen?
-- Bekannte Lösung:
select * from verleih;

select b.buchnr, b.titel
from buch b
join verleih v on v.buchnr = b.buchnr;

-- neue lösung 

select b.buchnr, b.titel
from buch b 
where b.buchnr in (
	select buchnr
    from verleih
);

select b.buchnr, b.titel
from buch b 
where b.buchnr = any (
	select buchnr
    from verleih
);

