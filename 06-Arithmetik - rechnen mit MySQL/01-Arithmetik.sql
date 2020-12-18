use seminar;

drop table projekte;

create table projekte(
	projekt 	varchar(30) not null primary key,
    umsatz		numeric(10,2) not null default 0.00,
    kosten		numeric(10,2) not null default 0.00
);

insert into projekte (projekt, umsatz, kosten) values 
('Projekt 1', 10000.00, 8000.00),
('Projekt B', 5000.50, 4595.20);

select * from projekte;

select sum(umsatz), sum(kosten) from projekte;

-- +, -, *, /, DIV, MOD, %
select 5+3, 5-3, 5*3, 5 / 3, 5 div 3, 5 mod 3;

select projekt, umsatz, kosten, umsatz-kosten, (umsatz-kosten) / umsatz * 100
from projekte;


# zufällige anwender auswählen
select * from anwender
order by rand()
limit 0 , 3;
