/* Baumstrukturen

   Hierarchie:
   
      Karsten (1)
         |
         |---- Ines (2)
         |       |
         |       |---- Thomas (5)
         |       |
         |       |---- Martin (6)
         |
         |---- Klaus (3)
         |       |
         |       |---- Inge (7)
         |
         |---- Rainer (4)
                 |
                 |---- Sabine (8)
                 |       |
                 |       |---- Claudia (10)
                 |
                 |---- Dierk (9)
*/

-- Hierarchie rekursiv
use seminar;
set foreign_key_checks = 0;
drop table if exists mitarbeiter;
set foreign_key_checks = 1;
create table mitarbeiter
(
  id            int unsigned not null primary key,
  vorname       varchar(20) not null,
  vorgesetzter  int unsigned,
  foreign key (vorgesetzter) references mitarbeiter(id)
);
insert into mitarbeiter2 (id, vorname, vorgesetzter)
values
  ( 1, 'Karsten', null),
  ( 2, 'Ines'   , 1), (3, 'Klaus' , 1), (4, 'Rainer', 1),
  ( 5, 'Thomas' , 2), (6, 'Martin', 2), (7, 'Inge' , 3), (8, 'Sabine', 4), (9, 'Dierk', 4),
  (10, 'Claudia', 8);
  
select * from mitarbeiter2;
/*
select vorname, vorgesetzter
from mitarbeiter
start with id=1
connect by prior id=vorgesetzter;
*/
select t1.vorname ebene1, t2.vorname ebene2, t3.vorname ebene3, t4.vorname ebene4
from mitarbeiter2 t1
left join mitarbeiter2 t2 on t2.vorgesetzter = t1.id
left join mitarbeiter2 t3 on t3.vorgesetzter = t2.id
left join mitarbeiter2 t4 on t4.vorgesetzter = t3.id
where t1.id = 1;