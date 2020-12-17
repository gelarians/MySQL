use seminar;

select * from anwender;

#daten ändern
update anwender
set lebensalter = 36
where id = 10;

#lösche daten
delete from anwender
where id = 9;

desc anwender;