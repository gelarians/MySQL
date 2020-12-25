use leihbib;


-- Welche Buchexemplare wurden bislang überdurchschnittlich oft ausgeliehen?
    
select b.buchnr, b.titel, b.ausleihanzahl
from buch b
where ausleihanzahl > (
	select avg(ausleihanzahl)
    from buch
);

-- Welches ist der leser mit den höchsten Strafgebühren?
select * from leser;
select * from strafe;

select l.lesernr, l.nachname, l.vorname, s.gebuehr, s.sperre
from leser l
join strafe s on l.lesernr = s.lesernr
where s.gebuehr = (
	select max(gebuehr)
    from strafe
);


