use seminar;

show character set;

drop table if exists zeichenketten;
create table zeichenketten
(
  str1    varchar(100) character set latin1,
  str2    varchar(100) character set utf8
);
insert into zeichenketten (str1, str2)
values ('hässlich', 'hässlich');



select * from zeichenketten;

select length(str1) lstr1, length(str2) lstr2 from zeichenketten;

select char_length(str1) lstr1, char_length(str2) lstr2 from zeichenketten;

select left(str1, 2), left(str2, 2) from zeichenketten;