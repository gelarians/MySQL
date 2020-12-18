use seminar;

drop table if exists anwender ;

create table anwender
(
	id 			int unsigned auto_increment primary key,
    vorname		varchar(30),
    ort			varchar(30)
);


insert into anwender (vorname, ort)
values
	('Karsten', 'Laer'), -- Laer -> Bad Laer
    ('Jutta', 'Laer'), 	-- Laer
    ('Inis', 'Laer'), -- dieses Lear ist ein anderes wie die obrigen
    ('Wolfgang', 'Berlin');
    
select * from anwender;