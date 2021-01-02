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
  declare ktosaldo numeric(10,2) default 0.00; -- declare erstellt eine variable innerhalb einer procedure
  select saldo into ktosaldo from konten where konto = von;
  
  if ktosaldo > betrag then   -- if bedingung innerhalb einer procedure = IF bedingung THEN do somthing  ELSE .... END IF; 
	select 'überweise';
  else
	select 'Ablehnung';
  end if;

end $$
delimiter ;

call ueberweise(1, 2, 2500.00);

select * from konten;