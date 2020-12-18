use seminar;

drop table if exists mitarbeiter;
create table mitarbeiter(
	pers_id			int unsigned not null auto_increment primary key,
    nachname		varchar(30),
    vorgesetzter	int unsigned not null 
);

insert into mitarbeiter (nachname, vorgesetzter) 
	values 	('Karsten', 1),
			('Maja', 1),
            ('Thomas', 2),
            ('Meike', 1),
            ('Anette', 2);
            
select * from mitarbeiter;

select a.nachname as vorgesetzter, b.nachname as mitarbeiter
from mitarbeiter a
join mitarbeiter b on a.pers_id = b.vorgesetzter
order by vorgesetzter;
