/* Erstellen Sie Trigger fuer INSERT- und UPDATE, die Rabatt und Versandkosten bestimmen

   Regeln:

   - sale_val >= 50.0, dann keine Versandkosten (free_shipping)
   - sale_val >= 100.00, dann 2% Rabatt (discount)
*/
use seminar;

drop table if exists sales;
create table sales (
    id int unsigned not null auto_increment primary key,
    cust_id int unsigned not null,
    sale_val numeric(10 , 2 ) not null default 0.00,
    discount numeric(10 , 2 ) not null default 0.00,
    free_shipping boolean not null default false
);

-- Trigger testen
insert into sales (cust_id, sale_val)
values
    (1, 100.00), (2, 90.50), (3, 120.10), (1, 20.75), (1, 10.25), (2, 23.45);
    
select * from sales;

update sales set sale_val = 99.00 where id = 3;
select * from sales;
update sales set sale_val = 199.00 where id = 3;
select * from sales;