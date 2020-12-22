use leihbib;


-- welche Leser duerfen die Bibliothek nicht mehr betreten?
select l.lesernr id, nachname, vorname
from leser l
join strafe s on l.lesernr = s.lesernr
where sperre = true;


-- Erstellen Sie eine Leserliste mit den evtl. schuldigen Gebühren.
select l.lesernr id, l.nachname, ifnull(s.gebuehr, 0.00) gebuehr
from leser l
left join strafe s on l.lesernr = s.lesernr;

-- Schwieriger: Berechnen Sie, wieviel Prozent des Buchbestandes aktuell ausgeliehen ist.

-- --> Antwort in der nächsten datei