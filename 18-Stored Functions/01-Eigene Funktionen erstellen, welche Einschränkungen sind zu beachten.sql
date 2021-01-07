/* Funktionen */

use seminar;

drop function if exists hoch2;
delimiter $$
create function hoch2(wert numeric(6,2)) returns numeric(10,2)
begin
  return wert * wert;
end $$
delimiter ;

select hoch2(10.8);