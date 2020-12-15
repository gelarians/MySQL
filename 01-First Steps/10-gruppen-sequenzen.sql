use seminar;

create table gruppennummerierung
(
	gruppe		varchar(3) not null,
    lfdnr		int unsigned not null auto_increment,
    bezeichner 	varchar(30) not null,
    primary key	(gruppe, lfdnr)
)engine=myisam;


insert into gruppennummerierung (gruppe, bezeichner) values ("ab", "Produkt Nr 1");
insert into gruppennummerierung (gruppe, bezeichner) values ("ac", "Produkt Nr 5");
insert into gruppennummerierung (gruppe, bezeichner) values ("ab", "Produkt Nr 3");

select * from gruppennummerierung;