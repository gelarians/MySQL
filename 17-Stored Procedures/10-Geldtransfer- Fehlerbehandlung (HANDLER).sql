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
  declare ktosaldo numeric(10,2) default 0.00;
  declare vkto      int unsigned default 0;
  declare nkto      int unsigned default 0;
  
  declare exit handler for sqlexception, not found -- handler -sollte es das konto nicht geben wird dies nun abgefangen 
  begin
    show warnings;
    rollback;
  end;
  
  select konto into vkto from konten where konto = von;
  select konto into nkto from konten where konto = nach;
  
  start transaction;
    select saldo into ktosaldo from konten where konto = von for update;
  
    if ktosaldo >= abs(betrag) then
      update konten set saldo = saldo - abs(betrag) where konto = von;
      update konten set saldo = saldo + abs(betrag) where konto = nach;
    else
		select 'Ablehnung';
    end if;
  commit;

end $$
delimiter ;

call ueberweise(1, 3, 400.00 );

select * from konten;

