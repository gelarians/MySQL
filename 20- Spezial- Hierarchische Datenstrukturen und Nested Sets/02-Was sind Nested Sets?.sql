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
  





