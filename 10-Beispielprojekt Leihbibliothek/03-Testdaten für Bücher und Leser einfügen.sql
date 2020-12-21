-- Testdatensaetze fuer Leibibliothek

use leihbib;

-- Test-Buchbestand
insert into buch (autor, titel, kategorie)
values
  ('Goethe', 'Wilhelm Meister', 'K'),
  ('Goethe', 'Faust', 'K'),
  ('Goethe', 'Wahlverwandtschaften', 'K'),
  ('Schiller', 'Die Räuber', 'K'),
  ('Lessing', 'Nathan der Weise', 'K'),
  ('Lessing', 'Nathan der Weise', 'K'),
  ('Dubois', 'MySQL Cookbook', 'W'),
  ('Böll', 'Frauen vor Flusslandschaft', 'U');
insert into buch (autor, titel, kategorie, leihdauer)
values
  ('Dubois', 'MySQL Deverloper\'s Library', 'W', 0);        -- Präsenzexemplar
  
-- Test-Leserbestand
insert into leser (nachname, vorname, wohnort, eintrittsdatum)
values
  ('Brodmann', 'Karsten', 'Osnabrück', '1999-07-01'),
  ('Stackelborg', 'Winfried', 'Osnabrück', '2000-08-01'),
  ('Ehrenbrink', 'Heidelore', 'Osnabrück', '208-10-21'),
  ('Hauptmann', 'Jan', 'Ibbenbüren', '2011-11-01'),
  ('Tammen', 'Thomas', 'Rheine', '2011-11-02');
  
  
  select * from buch;
  select * from leser;