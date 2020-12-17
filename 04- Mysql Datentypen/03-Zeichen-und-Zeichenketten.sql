use seminar;

drop table if exists zeichenkette;

create table zeichenkette(
	c	char(4),
    v	varchar(4)
);


insert into zeichenkette (c,v) values ('ab', 'ab');
insert into zeichenkette (c,v) values ('cd  ', 'cd  ');

select concat(c,'|'), concat(v,'|') from zeichenkette;


desc zeichenkette;
select * from zeichenkette;