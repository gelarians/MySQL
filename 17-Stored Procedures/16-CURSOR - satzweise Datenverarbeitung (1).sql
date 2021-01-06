use seminar;
drop table if exists mitglieder;
create table mitglieder
(
  id        int unsigned not null auto_increment primary key,
  vorname   varchar(30),
  eintritt  date not null,
  austritt  date default null
);
insert into mitglieder (vorname, eintritt, austritt)
values
  ('Karsten', '2010-01-01', null),
  ('Ines' , '2010-06-13', '2020-07-07'),
  ('Thomas', '2011-03-01', null);
  
drop table if exists verteiler;
create table verteiler
(
  id        int unsigned not null primary key,
  vorname   varchar(30)
);

select * from mitglieder;
select * from verteiler;

drop procedure if exists erstelle_verteiler;
delimiter $$
create procedure erstelle_verteiler()
begin
  declare vid  int unsigned;
  declare vvorname varchar(30);
  declare ende boolean default false;
  
  declare cur cursor for
  select id, vorname from mitglieder where austritt is null;
  
  declare continue handler for not found
  set ende := true;
  
  delete from verteiler;
  
  open cur;
  
  schleife: loop
    fetch cur into vid, vvorname;
    if ende then
      leave schleife;
    end if;
    insert into verteiler (id, vorname) values (vid, vvorname);
  end loop schleife;
  
  close cur;
  
end $$
delimiter ;

set sql_safe_updates := 0;
call erstelle_verteiler();
set sql_safe_updates := 1;