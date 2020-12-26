/* Erstellen Sie einen View (sales_rep), der Rabatt und Versandkosten bestimmt.

   Regeln:

   - sale_val >= 50.0, dann keine Versandkosten (free_shipping)
   - sale_val >= 100.00, dann 2% Rabatt (discount)
*/
use seminar;

drop table if exists sales;
create table sales (
    id int unsigned not null auto_increment primary key,
    cust_id int unsigned not null,
    sale_val numeric(10 , 2 ) not null default 0.00
);

insert into sales (cust_id, sale_val)
values
    (1, 100.00), (2, 90.50), (3, 120.10), (1, 20.75), (1, 10.25), (2, 23.45); 
    
    
create or replace view sales_rep(id, cust_id, sale_val, free_shipping, discount)
as
select 
	id, cust_id,
    sale_val,
    if(sale_val >= 50.00, true, false) free_shipping,
    if(sale_val >= 100.00, round(sale_val*0.02, 2), 0.00) discount
from sales;
    
select * from sales_rep;