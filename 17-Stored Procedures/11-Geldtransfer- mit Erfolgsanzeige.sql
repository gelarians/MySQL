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
create procedure ueberweise(in von int unsigned, in nach int unsigned, in betrag numeric(10,2),
                            out erfolg boolean) -- als variable in die procedure aufnehmen
begin
  declare ktosaldo numeric(10,2) default 0.00;
  declare vkto      int unsigned default 0;
  declare nkto      int unsigned default 0;
  
  declare exit handler for sqlexception, not found
  begin
    show warnings;
    set erfolg := false; -- set bool to false, wenn irgendwas falsch läuft und der handler ausgelöst wird
    rollback;
  end;
  
  select konto into vkto from konten where konto = von;
  select konto into nkto from konten where konto = nach;
  
  start transaction;
    select saldo into ktosaldo from konten where konto = von for update;
  
    if ktosaldo >= abs(betrag) then
      update konten set saldo = saldo - abs(betrag) where konto = von;
      update konten set saldo = saldo + abs(betrag) where konto = nach;
      set erfolg := true; -- set bool
    else
      set erfolg := false; -- set bool
    end if;
  commit;

end $$
delimiter ;
set @erfolg := false; -- die variable muss erst einmal auserhalb erzeugt werden !!
call ueberweise(1, 2, 400.00, @erfolg);

select @erfolg;
