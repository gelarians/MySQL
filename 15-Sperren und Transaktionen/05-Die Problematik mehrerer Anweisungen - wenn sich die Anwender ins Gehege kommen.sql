use seminar;

drop table if exists verkauf;
create table verkauf (
  id        int unsigned not null auto_increment primary key,
  produkt   varchar(30) not null,
  zeitpunkt timestamp not null default current_timestamp,
  wert      numeric(6,2) not null default 0.00
);

drop table if exists verkaufshistorie;
create table verkaufshistorie
(
  id          int unsigned not null auto_increment primary key,
  zeitpunkt   timestamp not null default current_timestamp,
  umsatz      numeric(10,2) not null default 0.0
);

insert into verkauf (produkt, wert) values ('Produkt A', 100.00);
select @umsatz := sum(wert) from verkauf;
insert into verkaufshistorie (umsatz) values (@umsatz);

select * from verkauf;
select * from verkaufshistorie;

insert into verkauf (produkt, wert) values ('Produkt B', 200.00);
select @umsatz := sum(wert) from verkauf;
insert into verkaufshistorie (umsatz) values (@umsatz);


insert into verkauf (produkt, wert) values ('Produkt A', 100.00);