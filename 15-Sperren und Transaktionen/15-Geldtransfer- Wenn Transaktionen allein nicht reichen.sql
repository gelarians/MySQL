use seminar;

drop table if exists konten;
create table konten
(
  konto       int unsigned not null auto_increment primary key,
  saldo       numeric(10,2) not null default 0.00
);
-- aktuelle Kontenstaende
insert into konten (saldo) values (1000.00), (800.00);

select * from konten;

set @betrag := 500.00;
set @vonKonto := 1;
set @nachKonto := 2;


start transaction;
select * from konten where konto = @vonKonto;
-- PRUEFE
update konten set saldo = saldo - @betrag where konto = @vonKonto;
update konten set saldo = saldo + @betrag where konto = @nachKonto;
commit;