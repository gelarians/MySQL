use seminar;

drop table if exists verkauf;
create table verkauf (
  id        int unsigned not null auto_increment primary key,
  produkt   varchar(30) not null,
  zeitpunkt timestamp not null default current_timestamp,
  wert      numeric(6,2) not null default 0.00
);

start transaction;

insert into verkauf (produkt, wert) values ('Produkt A', 100.00);

select * from verkauf;
-- andere Anwender koennen die Einfuegeoperation erst nach COMMIT sehen
commit;

set autocommit:=1;