set @gebdatum := '2004-02-28';
set @aktdatum := '2021-02-28';

select year(@aktdatum)-year(@gebdatum) -
       if(date_format(@gebdatum, '%m%d') > date_format(@aktdatum, '%m%d'), 1, 0)
       ;