-- 1:1 Beziehung
-- Mitarbeiter - Sozialversicherungsdaten

use seminar;

drop table if exists mitarbeiter;
create table mitarbeiter (
	persid			int unsigned not null auto_increment primary key,
	vorname			varchar(30) not null
    -- weiter spalten 
);

create table sozdaten(
	persid		int unsigned not null primary key,
	soznr		varchar(30) not null
    -- weitere spalten
    
);

select * from mitarbeiter
join sozdaten on sozdaten.persid = mitarbeiter.persid
