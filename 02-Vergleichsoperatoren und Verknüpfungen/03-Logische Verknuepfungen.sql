-- Logische Verknuepfungen
--
--    AND logische UND, beide Bedingungen müssen erfuellt sein
--    OR  logisches ODER, eine oder beide Bedingungen müssen zutreffen
--    XOR exklusives ODER, es darf nur eine Bedungung zutreffen
--
-- ----------------------- WAHRHEITSTAFELN ----------------------
-- Negation (NOT)
-- 
--   A       NOT A
--   -------------
--   wahr    falsch
--   falsch  wahr
--   
-- Disjunktion (OR)                  Exklusiv ODER (XOR)
-- 
--   A       B       A OR B          A       B       A XOR B
--   ----------------------          -----------------------
--   wahr    wahr    wahr            wahr    wahr    falsch
--   wahr    falsch  wahr            wahr    falsch  wahr
--   falsch  wahr    wahr            falsch  wahr    wahr
--   falsch  falsch  falsch          falsch  falsch  falsch
--   
-- Konjunktion (AND)
-- 
--   A       B       A AND B
--   -----------------------
--   wahr    wahr    wahr
--   wahr    falsch  falsch
--   falsch  wahr    falsch
--   falsch  falsch  falsch

use seminar;                          -- benutze die Datenbank "seminar"
  
select * from anwender where lebensalter between 30 and 50;
select * from anwender where lebensalter >= 30;
select * from anwender where lebensalter <= 50;
select * from anwender where lebensalter >= 30 and lebensalter <= 50;

select * from anwender where lebensalter <= 30 or lebensalter >= 50;

select * from anwender where lebensalter is not null;

select * from anwender where vorname = 'Wolfgang' xor lebensalter = 42;     