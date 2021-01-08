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


set sql_safe_updates=0;
drop table if exists hierarchie;
create table hierarchie
(
  id            int unsigned not null auto_increment primary key,
  vorname       varchar(20) not null,
  links         int unsigned not null,
  rechts        int unsigned not null
);  
insert into hierarchie (vorname, links, rechts)
values ('Karsten', 1, 2);

select * from hierarchie;
/*
   Karsten, 1, 2   Karsten, 1, 4   Karsten, 1, 6  Karsten, 1, 8  Karsten ...
                   Ines, 2, 3      Ines, 2, 5     Ines, 2, 7
                                   Thomas, 3, 4   Thomas, 3, 4
                                                  Martin 5, 6
*/
-- Weitere Dateneingaben -------------------------------------------------------------------------

-- Ines
select @rchts := rechts from hierarchie where vorname = 'Karsten';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Ines', @rchts, @rchts+1);
-- Thomas
select @rchts := rechts from hierarchie where vorname = 'Ines';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Thomas', @rchts, @rchts+1);
-- Martin
select @rchts := rechts from hierarchie where vorname = 'Ines';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Martin', @rchts, @rchts+1);
-- Klaus
select @rchts := rechts from hierarchie where vorname = 'Karsten';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Klaus', @rchts, @rchts+1);
-- Inge
select @rchts := rechts from hierarchie where vorname = 'Klaus';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Inge', @rchts, @rchts+1);
-- Rainer
select @rchts := rechts from hierarchie where vorname = 'Karsten';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Rainer', @rchts, @rchts+1);
-- Sabine
select @rchts := rechts from hierarchie where vorname = 'Rainer';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Sabine', @rchts, @rchts+1);
-- Dierk
select @rchts := rechts from hierarchie where vorname = 'Rainer';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Dierk', @rchts, @rchts+1);
-- Claudia
select @rchts := rechts from hierarchie where vorname = 'Dierk';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Claudia', @rchts, @rchts+1);

select * from hierarchie;
-- Roger
start transaction;
select @rchts := rechts from hierarchie where vorname = 'Thomas';
update hierarchie set rechts = rechts + 2 where rechts >= @rchts;
update hierarchie set links = links + 2 where links > @rchts;
insert into hierarchie (vorname, links, rechts) values ('Roger', @rchts, @rchts+1);
commit;

select * from hierarchie;

