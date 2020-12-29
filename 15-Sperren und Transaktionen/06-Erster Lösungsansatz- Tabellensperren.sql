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

lock tables verkauf write, verkaufshistorie write;   -- nicht der beste lösungsansatz weil dann alles gesperrt ist
insert into verkauf (produkt, wert) values ('Produkt A', 100.00);
select @umsatz := sum(wert) from verkauf;
insert into verkaufshistorie (umsatz) values (@umsatz);
unlock tables;

select * from verkauf;
select * from verkaufshistorie;
