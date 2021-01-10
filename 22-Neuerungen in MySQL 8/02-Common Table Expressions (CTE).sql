use neuerungen;

drop table if exists umsaetze;
create table umsaetze
(
	jahr		int unsigned not null,
    monat		int unsigned not null,
    umsatz		decimal(10,2) default 0.00,
    primary key (jahr, monat)
);
create index jahr_idx on umsaetze(jahr);

insert into umsaetze
values 
	#2010
	(2010,  1, 10000),
    (2010,  2, 11000),
    (2010,  3, 11000),
    (2010,  4, 12000),
    (2010,  5, 10000),
    (2010,  6,  9000),
    (2010,  7, 10000),
    (2010,  8, 11000),
    (2010,  9, 12000),
    (2010, 10, 11000),
    (2010, 11, 12000),
    (2010, 12, 13000),
    # 2011
	(2011,  1, 11000),
    (2011,  2, 12000),
    (2011,  3,  9000),
    (2011,  4, 12000),
    (2011,  5, 11000),
    (2011,  6, 10000),
    (2011,  7, 10000),
    (2011,  8, 11000),
    (2011,  9, 12000),
    (2011, 10, 11000),
    (2011, 11, 12500),
    (2011, 12, 13500),
    # 2012
	(2012,  1, 10000),
    (2012,  2, 11000),
    (2012,  3,  9000),
    (2012,  4, 10000),
    (2012,  5, 10000),
    (2012,  6, 10000),
    (2012,  7, 11000),
    (2012,  8, 10000),
    (2012,  9, 11000),
    (2012, 10, 10000),
    (2012, 11, 11500),
    (2012, 12, 11500),
    # 2013
	(2013,  1,  9000),
    (2013,  2, 11000),
    (2013,  3, 10000),
    (2013,  4, 11000),
    (2013,  5, 11000),
    (2013,  6, 11000),
    (2013,  7, 10000),
    (2013,  8, 10000),
    (2013,  9, 11000),
    (2013, 10, 10000),
    (2013, 11, 12500),
    (2013, 12, 12500);

# Umsatzvergleich mit Sub-Select
select 
	u1.jahr as jahr, 
	u2.jahr as vorjahr, 
    u1.summe as umsatz, 
    u2.summe as vorumsatz,
    100*(u1.summe-u2.summe)/u1.summe as prozent
from (
	select jahr, sum(umsatz) as summe from umsaetze group by jahr
) as u1, (
	select jahr, sum(umsatz) as summe from umsaetze group by jahr
) as u2
where
	u1.jahr = u2.jahr+1;
    
# Umsatzvergleich mittels CTE
with cte as (
	select jahr, sum(umsatz) as summe from umsaetze group by jahr
)
select
	u1.jahr as jahr, 
	u2.jahr as vorjahr, 
    u1.summe as umsatz, 
    u2.summe as vorumsatz,
    100*(u1.summe-u2.summe)/u1.summe as prozent
from
	cte as u1, cte as u2
where
	u1.jahr = u2.jahr+1;
    


