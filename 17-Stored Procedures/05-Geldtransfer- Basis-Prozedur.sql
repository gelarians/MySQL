use seminar;

drop table if exists konten;
create table konten
(
  konto   int unsigned not null primary key,
  saldo   numeric(10,2) not null default 0.00
);
insert into konten(konto, saldo) values (1, 1000.00), (2, 1000.00);
select * from konten;

drop procedure ueberweise;
delimiter $$
create procedure ueberweise(in von int unsigned, in nach int unsigned, in betrag numeric(10,2))
begin
  update konten set saldo = saldo - abs(betrag) where konto = von;  -- abs = absolut -> ändert eine negative zahl in eine positive
  update konten set saldo = saldo + abs(betrag) where konto = nach;	-- 0 und positive zahlen bleiben unberührt
end $$
delimiter ;

call ueberweise(1, 2, 500.00);

select * from konten;