 use seminar;

drop table if exists anwender ;

create table anwender
(
	id 			int unsigned auto_increment primary key,
    vorname		varchar(30),
    ort			int unsigned not null
);

create table wohnorte (
	ortid		int unsigned auto_increment primary key,
    ortsname	varchar(30)
);

insert into wohnorte (ortsname) values ('Laer'), ('Laer'), ('Berlin');
update wohnorte set ortsname = 'Bad Laer' where ortid = 1;


insert into anwender (vorname, ort)
values
	('Karsten', 1), -- Laer -> Bad Laer
    ('Jutta', 1), 	-- Laer
    ('Inis', 2), -- dieses Lear ist ein anderes wie die obrigen
    ('Wolfgang', 3);

#alte schreibweise
select * from anwender, wohnorte
where ort = ortid;

#neue schreibweiße
select * from anwender
join wohnorte on ort = ortid;

select * from wohnorte;