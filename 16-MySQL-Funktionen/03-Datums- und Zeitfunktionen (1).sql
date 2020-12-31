use seminar;

drop table if exists zeiten;
create table zeiten
(
  datum date not null
);

-- ISO-Format: 'YYYY-MM-DD HH:MM:SS'

select curdate() + interval 2 week;

select last_day('2017-09-10'); -- letzte eines monats finden

select str_to_date(concat(date_format('2020-12-10', '%Y-%m'), '-01'), '%Y-%m-%d'); -- erste eines monats finden

