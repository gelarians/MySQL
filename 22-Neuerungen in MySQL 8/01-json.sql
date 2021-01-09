drop database if exists neuerungen;
create database neuerungen
character set utf8mb4
collate utf8mb4_de_pb_0900_ai_ci;


use neuerungen;

drop table if exists mitarbeiter;
create table mitarbeiter
(
	persnr			int unsigned auto_increment primary key,
    vorname			varchar(30) not null,
    nachname		varchar(30) not null,
    zusatzinfo		json
);

insert into mitarbeiter (vorname, nachname, zusatzinfo)
values
	('Dave', 'Mustermann',
	 '{"email": "dave@gmail.com",
       "adresse": { "strasse" : "Baumstraße 14",
					"PLZ": "32456",
                    "Ort": "Azeroth",
                    "Land": "WoW"},
		"Hobbies": ["Fußball", "mathematik"]
        }'
    );
    
insert into mitarbeiter (vorname, nachname, zusatzinfo)
values
	('Christian', 'Baumeister',
	 '{"email": "chris@google.com",
       "adresse": { "strasse" : "Hundegasse 3",
					"PLZ": "96527",
                    "Ort": "Berlin",
                    "Land": "DE"},
		"Ehefrau": "Stefanie"
        }'
    );
    
select * from mitarbeiter;

select persnr, vorname, nachname, json_pretty(zusatzinfo) from mitarbeiter; -- funktioniert nich in der Workbench aber im terminal

select zusatzinfo->"$.adresse.Ort" from mitarbeiter; -- $ = wurtzel . adresse . Ort VORSICHT groß kleinschreibung beachten in Json
select zusatzinfo->>"$.adresse.Ort" from mitarbeiter; -- ohne anführungszeichen
 
select vorname, zusatzinfo->"$.Hobbies" from mitarbeiter; -- datensetze ohne Hobbies werden mit null angezeigt

select persnr, vorname, nachname
from mitarbeiter
where zusatzinfo->"$.adresse.Ort" = 'Berlin'; -- json in einer where abfrage 

select json_extract(zusatzinfo, "$.Hobbies")
from mitarbeiter;

select persnr, vorname, nachname
from mitarbeiter
where json_extract(zusatzinfo, "$.Hobbies") LIKE '%Fußball%'; -- sucht im string nach Fußball

select persnr, vorname, nachname
from mitarbeiter
where json_search(zusatzinfo->"$.Hobbies", 'one', 'Fußball') is not null; -- schönere suche 

select persnr, vorname, nachname
from mitarbeiter
where zusatzinfo->>"$.adresse.PLZ" = 96527; -- full Table Scan SEHR LANGSAM!


alter table mitarbeiter
	add plz char(5)
    generated always as (json_unquote( -- json_unquote entfernt die anführungszeichen
		json_extract(zusatzinfo, "$.adresse.PLZ")
    ))
    virtual not null;
    
create index plz_idx on mitarbeiter(plz);

select persnr, vorname, nachname
from mitarbeiter
where zusatzinfo->>"$.adresse.PLZ" = "96527"; 
-- nun läut es über eine index suche VORSICHT die plz muss hier als String gesucht werden#
-- sonst funktioniert das nciht weil wir ja ein char field haben in unserer tabelle


-- Update json 

update mitarbeiter
set zusatzinfo = json_set(zusatzinfo, "$.Ehefrau", "Jenny")
where persnr = 2;

select * from mitarbeiter
where persnr = 2;

-- insert json
update mitarbeiter
set zusatzinfo = json_insert(zusatzinfo, "$.Hobbies", json_array('Fotografie'))
where persnr = 2;

update mitarbeiter
set zusatzinfo = json_array_insert(zusatzinfo, "$.Hobbies[0]", 'Reiten') -- neues hobby am anfang des arrays einfügen 
where persnr = 2;

-- remove json

update mitarbeiter
set zusatzinfo = json_remove(zusatzinfo, "$.Hobbies")
where persnr = 2;


