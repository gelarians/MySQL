use seminar;

drop table sitzplan;
create table sitzplan(
	reihe		char(26) not null,
    sitznr		int unsigned not null auto_increment,
    frei		bool not null default true,
    primary key	(reihe, sitznr)
)engine = myisam; -- das geht nur mit myisam!!!!

insert into sitzplan (reihe, frei) 
values
  ('A',  true), ('A', false), ('A', false), ('A',  true), ('A',  true), ('A', false), 
  ('B', false), ('B',  true), ('B',  true), ('B', false), ('B', false), ('B', false), 
  ('C', false), ('C', false), ('C', false), ('C',  true), ('C',  true), ('C', false); 
  
select * from sitzplan;

# fine 2 nebeneinander liegende plätze die frei sind
select * from sitzplan a
join sitzplan b on a.reihe = b.reihe and a.sitznr = b.sitznr -1
where a.frei = true and b.frei = true;

		