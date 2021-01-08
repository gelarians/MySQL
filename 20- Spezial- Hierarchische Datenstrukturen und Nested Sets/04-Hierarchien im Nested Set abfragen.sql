/* Baumstrukturen

   Hierarchie:
   
      Karsten (1)
      1  | 20
         |---- Ines (2)
         |     2 | 7
         |       |---- Thomas (5)
         |       |     3    4
         |       |---- Martin (6)
         |             5    6
         |---- Klaus (3)
         |     8 | 11
         |       |---- Inge (7)
         |             9  10
         |---- Rainer (4)
              12 | 19
                 |---- Sabine (8)
                 |     13| 16
                 |       |---- Claudia (10)
                 |             14   15
                 |---- Dierk (9)
                       17 18
                       
                       
                                    Karsten
    ------------------------------------------------------------------------------                   
    |                                                                            |
    |          Ines                Klaus                   Rainer                |
    |   ---------------------   --------------   -----------------------------   |
    |   |                   |   |            |   |                           |   |
    |   |  Thomas  Martin   |   |    Inge    |   |      Sabine       Dierk   |   |
    |   |   -----   -----   |   |   ------   |   |   -------------   -----   |   |
    |   |   |   |   |   |   |   |   |    |   |   |   |           |   |   |   |   |
    |   |   |   |   |   |   |   |   |    |   |   |   |  Claudia  |   |   |   |   |
    |   |   |   |   |   |   |   |   |    |   |   |   |   -----   |   |   |   |   |
    |   |   |   |   |   |   |   |   |    |   |   |   |   |   |   |   |   |   |   |
    1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16  17  18  19  20
    
    - Wurzel hat Links-Wert L = 1
    - Sortierung folgt den Links-Werten
    - Anzahl der Nachfahren eines Knotens: (R - L -1) / 2
    - Für Blätter, Knoten ohne Kinder, gilt: R - L = 1
    - L und R der Nachfahren liegen zwischen L und R des Vorfahren
*/
use seminar;

select * from hierarchie;

select child.vorname
from hierarchie child,
     hierarchie parent
where child.links between parent.links and parent.rechts
and parent.vorname = 'Karsten'
order by child.links;

select child.vorname, (count(parent.vorname)-1) ebene
from hierarchie child,
    hierarchie parent
where child.links between parent.links and parent.rechts
group by child.vorname
order by child.links;


set @sqlmodus := @@session.sql_mode;
select @sqlmodus;
set sql_mode := 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
select @@session.sql_mode;