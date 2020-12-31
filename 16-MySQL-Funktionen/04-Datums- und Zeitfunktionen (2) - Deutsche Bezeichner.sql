select weekday(curdate());
select dayofweek(curdate());
select dayname(curdate());


use seminar;
drop table if exists datumswerte;
create table datumswerte (
  datum   date
);

insert into datumswerte values ('2017-03-10'), ('2017-04-01'),
                               ('2017-07-23'), ('2017-11-09');
                               
select datum, concat(if(date_format(datum, '%m%d') <= '0331', '1. ',
                     if(date_format(datum, '%m%d') <= '0630', '2. ',
                     if(date_format(datum, '%m%d') <= '0930', '3. ',
                     '4. '))), 'Quartal') as quartal
from datumswerte;

select datum, concat(if(date_format(datum, '%m%d') <= '0331', '1. ',
                     if(date_format(datum, '%m%d') <= '0630', '2. ',
                     if(date_format(datum, '%m%d') <= '0930', '3. ',
                     '4. '))), 'Quartal') as quartal,
              case dayname(datum) 
                when 'Sunday' then 'Sonntag'
                when 'Monday' then 'Montag'
                when 'Tuesday' then 'Dienstag'
                when 'Wednesday' then 'Mittwoch'
                when 'Thursday' then 'Donnerstag'
                when 'Friday' then 'Freitag'
                else 'Samstag'
              end as wochentag,
              dayname(datum) as dayname
from datumswerte;

-- Exkurs: lc_time_names gemaess Doku zu dayname()
    
select @@lc_time_names;
set lc_time_names='de_DE';  -- deutsche Tagesnamen

select datum, concat(if(date_format(datum, '%m%d') <= '0331', '1. ',
                     if(date_format(datum, '%m%d') <= '0630', '2. ',
                     if(date_format(datum, '%m%d') <= '0930', '3. ',
                     '4. '))), 'Quartal') as quartal,
              dayname(datum)
from datumswerte;

set lc_time_names='en_US';