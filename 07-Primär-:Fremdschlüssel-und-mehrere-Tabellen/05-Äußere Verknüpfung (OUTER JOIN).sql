use seminar;

drop table if exists personen;

create table personen
(
	persid		int unsigned not null auto_increment primary key,
    vorname		varchar(30) not null,
    wohnort		int unsigned
);

drop table if exists wohnorte;

create table wohnorte(
	wohnortid		int unsigned not null auto_increment primary key,
    ortsname		varchar(30)
);

insert into personen (vorname, wohnort)
	values 	('Karsten', 1),
			('Ines', 1),
            ('Wolfgang', 2),
            ('Anette', null);
            
insert into wohnorte (ortsname)
values ('Osnabrück'), ('Berlin'), ('Hamburg');

            
# alle personen anzeigen auch die die keinen wohnort haben
select * from personen
left outer join wohnorte on wohnort = wohnortid;

#alle orte anzeigen die auch die die keine person drin leben haben
select vorname, ortsname from personen
right outer join wohnorte on wohnort = wohnortid;