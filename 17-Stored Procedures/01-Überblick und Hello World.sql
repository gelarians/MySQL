-- Gespeicherte Programme
--
--      Prozeduren - führen etwas aus                                - expliziter Aufruf
--      Funktionen - führen etwas aus und geben ein Ergebnis zurück  - expliziter Aufruf
--      Trigger    - führen etwas aus                                - automatischer Aufruf (Event)
use seminar;


delimiter $$

drop procedure if exists helloworld $$
create procedure helloworld()
begin
  select 'Hello World.';
  select 'Hello again';
end $$

delimiter ;

