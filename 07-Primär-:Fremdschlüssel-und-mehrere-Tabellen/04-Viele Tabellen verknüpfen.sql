 use seminar;

drop table if exists anwender ;

create table anwender
(
	id 			int unsigned auto_increment primary key,
    vorname		varchar(30),
    ort			int unsigned not null
);

drop table if exists wohnorte;

create table wohnorte (
	ortid		int unsigned auto_increment primary key,
    ortsname	varchar(30),
    bundesland	int unsigned
);

insert into wohnorte (ortsname, bundesland) values ('Laer', 1), ('Laer', 2), ('Berlin', 3);
update wohnorte set ortsname = 'Bad Laer' where ortid = 1;

create table bundeslaender (
	landid		int unsigned auto_increment primary key,
    land		varchar(20)
);

insert into bundeslaender (land) 
	values 
		('Niedersachsen'), ('Nordrhein-Westfalen'), ('Berlin'), ('Hessen');
 
 
 
select * from wohnorte
join bundeslaender on bundesland = landid;

select id, vorname, ortsname, land from anwender
join  wohnorte on ort = ortid
join bundeslaender on bundesland = landid;