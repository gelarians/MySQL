use seminar;

select max(lebensalter), vorname
		from anwender;
        
-- 17:55:03	select max(lebensalter), vorname   from anwender LIMIT 0, 1000	
-- Error Code: 1140. In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 
-- 'seminar.anwender.vorname'; this is incompatible with sql_mode=only_full_group_by	0.0030 sec

-- weiter in nächster datei -----> 03...