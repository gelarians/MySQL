/* Trigger-Beispiel */
use seminar;

drop table if exists sales;
create table sales (
    id int unsigned not null auto_increment primary key,
    cust_id int unsigned not null,
    sale_val numeric(10 , 2 ) not null default 0.00,
    discount numeric(10 , 2 ) not null default 0.00,
    free_shipping boolean not null default false
);

drop trigger if exists sales_ins_before;
delimiter $$
create trigger sales_ins_before before insert on sales
  for each row
begin
  if new.sale_val >= 50 then
    set new.free_shipping = true;             -- ab 50 Euro, freier Versand
  end if;
  if new.sale_val > 100 then
    set new.discount = new.sale_val * 0.02;   -- ab 100 Euro, 2% Rabatt
  end if;
end $$
delimiter ;

drop trigger if exists sales_upd_before;
delimiter $$
create trigger sales_upd_before before update on sales
  for each row
begin
  if new.sale_val >= 50 then
    set new.free_shipping = true;             -- ab 50 Euro, freier Versand
  else
    set new.free_shipping = false;
  end if;
  if new.sale_val > 100 then
    set new.discount = new.sale_val * 0.02;   -- ab 100 Euro, 2% Rabatt
  else
    set new.discount = 0.00; 
  end if;
end $$
delimiter ;

-- Trigger testen
insert into sales (cust_id, sale_val)
values
    (1, 100.00), (2, 90.50), (3, 120.10), (1, 20.75), (1, 10.25), (2, 23.45);
    
select * from sales;

update sales set sale_val = 99.00 where id = 3;
select * from sales;
update sales set sale_val = 199.00 where id = 3;
select * from sales;



/*
-----------------------------------------------------------------------------------
*/


drop table if exists sales2;

create table sales2 (
    id int unsigned not null auto_increment primary key,
    cust_id int unsigned not null,
    sale_val numeric(10 , 2 ) not null default 0.00,
    discount numeric(10 , 2 ) generated always as (if(sale_val >= 100.00, round(sale_val * 0.02, 2 ), 0.00)) stored, -- stored speichert es in die datenbank
    free_shipping boolean generated always as (if(sale_val >= 50.00, true, false)) stored -- virtual , wird on the fly berechnet beim aufruf
);

insert into sales2 (cust_id, sale_val)
values
    (1, 100.00), (2, 90.50), (3, 120.10), (1, 20.75), (1, 10.25), (2, 23.45);
    
select * from sales2;

update sales2 set sale_val = 49.00 where id = 3;
select * from sales2;
update sales2 set sale_val = 199.00 where id = 3;
select * from sales2;

