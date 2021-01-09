drop database if exists lernfabrik;
create database lernfabrik
character set utf8mb4
collate utf8mb4_de_pb_0900_ai_ci;

use lernfabrik;


# Artikel - Materialien, Kaufteil usw.
drop table if exists artikel;
create table artikel
(
	artnr			int unsigned auto_increment primary key,
    bezeichnung		varchar(30) not null,
					# M = Material, K = Kaufteil, E = Eigenteil, B= Baugruppe, P = Produkt
    typ 			enum('M', 'K', 'E', 'B', 'P') not null default 'M',
    dispostufe		int unsigned not null
);
insert into artikel (bezeichnung, typ, dispostufe)
values
	('Kantholz 1', 'M', 1),			#  1
    ('Kantholz 2', 'M', 1),			#  2
    ('Tischlerplatte', 'M', 1),		#  3
    ('Lehnenrohling', 'M', 1),	    #  4
    ('Leim', 'M', 1),				#  5
    ('Bein', 'E', 2),				#  6
    ('Strebe', 'E', 2),				#  7
    ('Sitz 1', 'E', 2),				#  8
    ('Sitz 2', 'E', 3),				#  9
    ('Lehne', 'E', 2),				# 10
    ('Hocker', 'P', 3),				# 11
    ('Stuhl', 'P', 4);				# 12
    
select * from artikel;

  
# Stücklisten - welcher Artikel geht in einen anderen in welcher Menge ein
#             - welche Vorlauffrist ist bei der Beschaffung zu beachten
drop table if exists direktbedarf;
create table direktbedarf
(
	oartnr			int unsigned not null, -- oberartikel
    uartnr			int unsigned not null, -- unter artikel
    menge			decimal(8,2) not null default 1.0,
    vorlauffrist	decimal(8,2) not null default 1.0,
    primary key (oartnr, uartnr)
);    
insert into direktbedarf (oartnr, uartnr, menge, vorlauffrist)
values
	( 6,  1, 0.25, 4.0),
    ( 7,  2, 0.20, 4.0),
    ( 8,  3, 0.25, 4.0),
    ( 9,  8, 1.00, 4.0),
    (10,  4, 1.00, 4.0),
    (11,  6, 4.00, 8.0),
    (11,  8, 1.00, 8.0),
    (11,  5, 0.30, 8.0),
    (12,  6, 4.00, 8.0),
    (12,  7, 5.00, 8.0),
    (12,  9, 1.00, 8.0),
    (12,  5, 0.50, 8.0),
    (12, 10, 1.00, 8.0);
    
select * from direktbedarf;    
    
# Baukastenstückliste für Produkt 'Stuhl' (Art.-Nr. 12)
select 
	d.oartnr, d.uartnr, a.bezeichnung, d.menge
from
	direktbedarf d
join
	artikel a on d.uartnr = a.artnr
where
	d.oartnr = 12; # Stuhl
    
# Verwendungsnachweis für Eigenteil 'Bein' (Art.-Nr. 6)
select
	d.uartnr, d.oartnr, a.bezeichnung
from
	direktbedarf d
join
	artikel a on d.oartnr = a.artnr
where
	d.uartnr = 6;
    
# Knoten ohne Nachfolger = Materialien
select distinct uartnr, bezeichnung
from direktbedarf d1
join artikel on d1.uartnr = artnr
where not exists (select *
	from direktbedarf d2
    where d1.uartnr = d2.oartnr);
    
select * from artikel
where typ = 'M';


# Gesamtbedarf
drop table if exists gesamtbedarf;
create table gesamtbedarf
(
	oartnr			int unsigned not null,
    uartnr			int unsigned not null,
    menge			decimal(8,2) not null,
    vorlauffrist	decimal(8,2) not null,
    primary key (oartnr, uartnr)
);

# berecheGesamtbedarf
delimiter $$
drop procedure if exists berechneGesamtbedarf $$
create procedure berechneGesamtbedarf()
# Ermittlung des Gesamtbedarfs aus der Direktbedarfstabelle
# - es wird über alle Artikel iteriert
# - die Direktbedarfe werden als Gesamtbedarf aufgezeichnet
# - wird für einen Artikel ein bereits vorhandener Gesamtbedarf
#   gefunden, wird dieser um den aktuellen erhöht
begin   # Variablen
	declare dnr int unsigned;
	declare gnr int unsigned;
	declare a_artnr int unsigned;
	declare a_done boolean default false;
	# Artikel-Cursor
	declare artcur cursor for
		select artnr from artikel order by dispostufe;
	# Continue-Handler für Artikel-Cursor
	declare continue handler for not found set a_done = true;
	
	# Daten in der Gesamtbedarfstabelle löschen
	delete from gesamtbedarf;
	# iteriere über alle Artikel, beginndend 
    # mit der niedrigsten Dispositionsstufe
	open artcur;
	art_loop: loop
		fetch artcur into a_artnr;
		if a_done then 
			leave art_loop; # kein Artikel (mehr) vorhanden
		end if;
		# Artikel, für den der Gesamtbedarf berechnet wird
		insert into gesamtbedarf 
			values (a_artnr, a_artnr, 1, 0.00);
		
		# Direktbedarfe
		DIR: begin
			declare d_done boolean default false;
			declare d_oartnr       int unsigned;
			declare d_uartnr       int unsigned;
			declare d_menge        decimal(8,2);
			declare d_vorlauffrist decimal(8,2);
            # Direktbedarf-Cursor beinhalte alle Datensätze, bei denen
            # der aktuelle Artikel als Oberartikel ausgewiesen ist
            declare dircur cursor for
				select * from direktbedarf where oartnr = a_artnr;
			declare continue handler for not found set d_done = true;
            # iteriere über die Direktbedarfe
			open dircur;
			dir_loop: loop
				fetch dircur into d_oartnr, d_uartnr, d_menge, d_vorlauffrist;
				if d_done then 
					leave dir_loop; # kein Direktbedarf (mehr) vorhanden
				end if;
				# Gesamtbedarfe
				GES: begin
					declare g_done boolean default false;
					declare g_oartnr       int unsigned;
					declare g_uartnr       int unsigned;
					declare g_menge        decimal(8,2);
					declare g_vorlauffrist decimal(8,2);
                    declare g_update       int unsigned default 0;
                    declare gescur cursor for
						select * from gesamtbedarf where oartnr = d_uartnr;
					declare continue handler for not found set g_done = true;
                    # iteriere über evtl. bereits vorhandene Gesamtbedarfe
					open gescur;
					ges_loop: loop
						fetch gescur into g_oartnr, g_uartnr, g_menge, g_vorlauffrist;
						if g_done then
							leave ges_loop; # kein Gesamtbedarf (mehr) vorhanden
						end if;
                        
						# prüfe, ob es einen Datensatz gibt, der aktualisiert
                        # werden kann
						select count(*) into g_update 
						from gesamtbedarf
                        where a_artnr = oartnr
						  and g_uartnr = uartnr
						  and d_vorlauffrist + g_vorlauffrist = vorlauffrist;
						# wenn keine Aktualisierung möglich ist, ist der aktuelle
                        # Gesamtbedarf als neuer Datensatz in der Gesamtbedarfstabelle
                        # zu erfassen
						if g_update = 0 then
							insert into gesamtbedarf
								values (a_artnr, g_uartnr, g_menge * d_menge, 
                                        g_vorlauffrist + d_vorlauffrist);
						else
							# aktualisiere bereits vorhandenen Datensatz
							update gesamtbedarf
							set menge = menge + g_menge * d_menge
							where a_artnr = oartnr
							  and g_uartnr = uartnr
							  and d_vorlauffrist + g_vorlauffrist = vorlauffrist;
                        end if;
					end loop ges_loop;
					close gescur;
				end GES; 
			end loop dir_loop;
			close dircur;
		end DIR;
	end loop art_loop;
	close artcur;
end $$
delimiter ;

SET SQL_SAFE_UPDATES = 0;
call berechneGesamtbedarf();
SET SQL_SAFE_UPDATES = 1;
select * from gesamtbedarf;


drop table if exists auftrag;
create table auftrag
(
	auftragnr		int unsigned not null primary key,
    artnr			int unsigned not null,
    menge			decimal(8,2) not null default 0.0,
    datum 			int unsigned not null
);
insert into auftrag
values
	(1, 11, 10, 2),
    (2, 12, 15, 3),
    (3, 11,  5, 3); 
    
    
drop table if exists bruttobedarf;
create table bruttobedarf
(
	artnr			int unsigned not null,
    menge			decimal(8,2) not null default 0.0,
    datum 			decimal(8,2) not null,
    dispostufe   	int unsigned not null,
    primary key (artnr, datum)
);


delimiter $$
drop procedure if exists berechneBruttobedarf $$
create procedure berechneBruttobedarf()
begin
	declare a_auftragnr 	int unsigned;
    declare a_artnr     	int unsigned;
    declare a_menge     	decimal(8,2) default 0.0;
    declare a_datum     	int unsigned;
    declare a_done      	boolean default false;
	declare aufcur cursor for
		select * from auftrag;
	declare continue handler for not found set a_done = true;
    
    delete from bruttobedarf;
    
    open aufcur;
    auf_loop: loop
		fetch aufcur into a_auftragnr, a_artnr, a_menge, a_datum;
        if a_done then
			leave auf_loop;
		end if;
        GES: begin
			declare g_oartnr		int unsigned;
			declare g_uartnr		int unsigned;
			declare g_menge			decimal(8,2) default 0.0;
			declare g_vorlauffrist	decimal(8,2) default 0.0;
            declare g_done  		boolean default false;
            declare g_update        int unsigned default 0;
            declare a_dispostufe	int unsigned;
            declare gescur cursor for
				select * from gesamtbedarf where oartnr = a_artnr;
			declare continue handler for not found set g_done = true;
            open gescur;
            ges_loop: loop
				fetch gescur into g_oartnr, g_uartnr, g_menge, g_vorlauffrist;
                if g_done then
					leave ges_loop;
				end if;
                select count(*) into g_update from bruttobedarf
					where g_uartnr = artnr
                      and a_datum - (g_vorlauffrist / 8) = datum;
				if g_update = 0 then
					select distinct dispostufe into a_dispostufe 
						from artikel 
                        where artnr = g_uartnr;
					insert into bruttobedarf
						values
							(g_uartnr, g_menge * a_menge, (a_datum * 8 - g_vorlauffrist) / 8, a_dispostufe);
				else
					update bruttobedarf
					set menge = menge + g_menge * a_menge
					where g_uartnr = artnr
                      and a_datum - (g_vorlauffrist / 8) = datum;
                end if;
            end loop ges_loop;
            close gescur;
        end GES;
    end loop auf_loop;
    close aufcur;
end $$
delimiter ;

call berechneBruttobedarf();
select * from bruttobedarf;


drop table if exists lager;
create table lager
(
	artnr			int unsigned not null primary key,
    bestand			decimal(8,2) not null default 0.0
);
insert into lager
values
	( 1,  5),
    ( 2,  3),
    ( 3, 20),
    ( 4, 10),
    ( 6, 15),
    ( 9, 15),
    (11,  8),
    (12, 10);


drop table if exists nettobedarf;
create table nettobedarf
(
	artnr			int unsigned not null,
    menge			decimal(8,2) not null default 0.0,
    datum 			decimal(8,2) not null,
    primary key (artnr, datum)
);


delimiter $$
drop procedure if exists berechneNettobedarf $$
create procedure berechneNettobedarf()
begin
	declare b_artnr		int unsigned;
    declare b_menge		decimal(8,2) default 0.0;
    declare b_datum 	decimal(8,2);
    declare b_done 		boolean default false;
    declare brucur cursor for
		select artnr, menge, datum from bruttobedarf order by dispostufe desc, artnr, datum;
    declare continue handler for not found set b_done = true;
    
    # Bruttobedarfe übernehmen ...
    delete from nettobedarf;
	insert into nettobedarf
		select artnr, menge, datum from bruttobedarf;
	# ... und dann um Lagerbestände korrigieren
    open brucur;
	bru_loop: loop
		fetch brucur into b_artnr, b_menge, b_datum;
        if b_done then
			leave bru_loop;
		end if;
        NET: begin
			declare n_artnr				int unsigned;
            declare n_menge				decimal(8,2) default 0.0;
            declare n_datum 			decimal(8,2);
            declare zaehler 			bigint default 0;
            declare l_artnr				int unsigned;
            declare l_bestand			decimal(8,2) default 0.0;
            declare lagerreservierung 	decimal(8,2) default 0.0;
            
			select distinct * into n_artnr, n_menge, n_datum 
				from nettobedarf
                where artnr = b_artnr and datum = b_datum;
			if n_menge>0 then
				select count(*) into zaehler
					from lager
                    where artnr = n_artnr;
				if zaehler>0 then
					select distinct * into l_artnr, l_bestand
						from lager
                        where artnr = n_artnr;
					if l_bestand > n_menge then
						set lagerreservierung = n_menge;
					else	
						set lagerreservierung = l_bestand;
                    end if;
                    # Lagerbestand korrigieren
                    update lager
						set bestand = bestand - lagerreservierung
						where artnr = n_artnr;
                    
                    GES: begin
						declare g_oartnr		int unsigned;
                        declare g_uartnr		int unsigned;
						declare g_menge			decimal(8,2) default 0.0;
						declare g_vorlauffrist 	decimal(8,2);
						declare g_done 			boolean default false;
						declare gescur cursor for
							select oartnr, uartnr, menge, vorlauffrist 
								from gesamtbedarf 
								where  oartnr = n_artnr;
						declare continue handler for not found set g_done = true;
                        open gescur;
                        gesloop: loop
							fetch gescur into g_oartnr, g_uartnr, g_menge, g_vorlauffrist;
							if g_done then
								leave gesloop;
							end if;
							update nettobedarf
								set menge = menge - (g_menge * lagerreservierung)
								where datum = n_datum - (g_vorlauffrist/8)
								  and artnr = g_uartnr;
						end loop gesloop;
                        close gescur;
					end GES;
                end if;
            end if;
        end NET;
    end loop bru_loop;
	close brucur;
end $$
delimiter ;


delimiter $$
drop procedure if exists berechneNettobedarf $$
create procedure berechneNettobedarf()
begin
	declare b_artnr		int unsigned;
    declare b_menge		decimal(8,2) default 0.0;
    declare b_datum 	decimal(8,2);
    declare b_done 		boolean default false;
    declare brucur cursor for
		select artnr, menge, datum from bruttobedarf order by dispostufe desc, artnr, datum;
    declare continue handler for not found set b_done = true;
    
    # Bruttobedarfe übernehmen ...
    delete from nettobedarf;
	insert into nettobedarf
		select artnr, menge, datum from bruttobedarf;
	# ... und dann um Lagerbestände korrigieren
    open brucur;
	bru_loop: loop
		fetch brucur into b_artnr, b_menge, b_datum;
        if b_done then
			leave bru_loop;
		end if;
        NET: begin
			declare n_artnr				int unsigned;
            declare n_menge				decimal(8,2) default 0.0;
            declare n_datum 			decimal(8,2);
            declare zaehler 			bigint default 0;
            declare l_artnr				int unsigned;
            declare l_bestand			decimal(8,2) default 0.0;
            declare lagerreservierung 	decimal(8,2) default 0.0;
            
			select distinct * into n_artnr, n_menge, n_datum 
				from nettobedarf
                where artnr = b_artnr and datum = b_datum;
			if n_menge>0 then
				select count(*) into zaehler
					from lager
                    where artnr = n_artnr;
				if zaehler>0 then
					select distinct * into l_artnr, l_bestand
						from lager
                        where artnr = n_artnr;
					if l_bestand > n_menge then
						set lagerreservierung = n_menge;
					else	
						set lagerreservierung = l_bestand;
                    end if;
                    # Lagerbestand korrigieren
                    update lager
						set bestand = bestand - lagerreservierung
						where artnr = n_artnr;
                    update nettobedarf n join gesamtbedarf g on n.artnr = g.uartnr
						set n.menge = n.menge - g.menge * lagerreservierung
						where n.datum = n_datum - (g.vorlauffrist/8)
						  and n.artnr = g.uartnr
						  and g.oartnr = n_artnr;
                end if;
            end if;
        end NET;
    end loop bru_loop;
	close brucur;
end $$
delimiter ;

delete from lager;
insert into lager
values
	( 1,  5),
    ( 2,  3),
    ( 3, 20),
    ( 4, 10),
    ( 6, 15),
    ( 9, 15),
    (11,  8),
    (12, 10);
call berechneNettoBedarf();
select * from nettobedarf;

select * from lager;



########### ALTERNATIVE ARTIKELERFASSUNG - auch korrekt
insert into artikel (bezeichnung, typ, dispostufe)
values
	('Sitz 1', 'E', 2),				#  1
    ('Sitz 2', 'E', 3),				#  2
    ('Lehne', 'E', 2),				#  3
    ('Hocker', 'P', 3),				#  4
    ('Stuhl', 'P', 4),				#  5
	('Kantholz 1', 'M', 1),			#  6
    ('Kantholz 2', 'M', 1),			#  7
    ('Tischlerplatte', 'M', 1),		#  8
    ('Lehnenrohling 1', 'M', 1),	#  9
    ('Leim', 'M', 1),				#  10
    ('Bein', 'E', 2),				#  11
    ('Strebe', 'E', 2);				#  12
insert into direktbedarf (oartnr, uartnr, menge, vorlauffrist)
values
	(11,  6, 0.25, 4.0),
    (12,  7, 0.20, 4.0),
    ( 1,  8, 0.25, 4.0),
    ( 2,  1, 1.00, 4.0),
    ( 3,  9, 1.00, 4.0),
    ( 4, 11, 4.00, 8.0),
    ( 4,  1, 1.00, 8.0),
    ( 4, 10, 0.30, 8.0),
    ( 5, 11, 4.00, 8.0),
    ( 5, 12, 5.00, 8.0),
    ( 5,  2, 1.00, 8.0),
    ( 5, 10, 0.50, 8.0),
    ( 5,  3, 1.00, 8.0);
    