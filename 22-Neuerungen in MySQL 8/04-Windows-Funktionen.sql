use neuerungen;

select * from umsaetze;

# Umsatzvergleich klassisch
select 
	u1.jahr as jahr, 
	u1.kum_umsatz as umsatz, 
    u2.jahr as vorjahr, 
    u2.kum_umsatz as vorumsatz,
    u1.kum_umsatz - u2.kum_umsatz as diff
from (
	select jahr, sum(umsatz) as kum_umsatz from umsaetze group by jahr
) as u1,
(
	select jahr, sum(umsatz) as kum_umsatz from umsaetze group by jahr
) as u2 
where u1.jahr = u2.jahr+1;


# Umsatzvergleich mit Hilfe con CTE
with cte as (
	select jahr, sum(umsatz) as kum_umsatz from umsaetze group by jahr
) 
select 
	u1.jahr as jahr, 
	u1.kum_umsatz as umsatz, 
    u2.jahr as vorjahr, 
    u2.kum_umsatz as vorumsatz,
    u1.kum_umsatz - u2.kum_umsatz as diff
from cte u1, cte u2
where u1.jahr = u2.jahr+1;


# Umsatzvergleich mit Hilfe von Window-Funktion
select 
	jahr,
    sum(umsatz) as umsatz,
    lag(jahr) over (order by jahr) as vorjahr, 
    -- lag bezieht sich auf den wert der davorliegenden spalte wichtig ein order by sollte verwendet werden
    -- um sicherzustellen das auch das vorjahr genommen wird
    lag(sum(umsatz)) over (order by jahr) as vorumsatz,
    sum(umsatz) - lag(sum(umsatz)) over (order by jahr) as diff
from umsaetze
group by 1;

select 
	jahr,
    sum(umsatz) as umsatz,
    lag(jahr) over w as vorjahr,
    lag(sum(umsatz)) over w as vorumsatz,
    sum(umsatz) - lag(sum(umsatz)) over w as diff
from umsaetze
group by 1
window w as (order by jahr); -- kurzschreibweise für oben




select jahr, umsatz, vorjahr, vorumsatz, diff, 100*(umsatz-vorumsatz)/umsatz as prozent
from
(
	select 
	jahr,
    sum(umsatz) as umsatz,
    lag(jahr) over (order by jahr) as vorjahr,
    lag(sum(umsatz)) over (order by jahr) as vorumsatz,
    sum(umsatz) - lag(sum(umsatz)) over (order by jahr) as diff
from umsaetze
group by 1
) as u
where vorjahr is not null;


######## patritionen ##########

drop table if exists praemien;
create table praemien
(
	jahr		int unsigned,
	mitarbeiter varchar(20),
    praemie     decimal(8,2)
);
insert into praemien
values
	#2010
	(2010, 'Karsten', 1000.00),
    (2010, 'Ines',    1200.00),
    (2010, 'Claudia', 1000.00),
    #2011
    (2011, 'Karsten', 1200.00),
    (2011, 'Ines',     900.00),
    (2011, 'Claudia', 1000.00),
    (2011, 'Klaus',   1100.00),
    #2012
    (2012, 'Karsten', 1200.00),
    (2012, 'Klaus',   1200.00),
    (2012, 'Claudia',  900.00),
    (2012, 'Jörg',     900.00);
    
select
    jahr, 
    mitarbeiter,
    praemie,
    sum(praemie) over (partition by jahr order by jahr) total_praemie,
    dense_rank() over (partition by jahr order by praemie desc) rang
from
    praemien
;