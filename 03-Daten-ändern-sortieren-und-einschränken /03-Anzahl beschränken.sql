use seminar;

select * from anwender
order by lebensalter desc
limit 3;

select id, lebensalter, vorname from anwender
where lebensalter >= (
	select distinct lebensalter from anwender order by lebensalter desc limit 2,1
)
order by lebensalter desc;