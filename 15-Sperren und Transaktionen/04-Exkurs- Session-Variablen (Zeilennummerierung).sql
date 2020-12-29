use seminar;

set @mein_vorname := 'David';   -- session variable
select @mein_vorname;

show tables;


set @linenr := 0;
select @linenr := @linenr + 1 as linien_nummer, ort from wohnorte;


