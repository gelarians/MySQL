use seminar;

-- DATE (Datum): 'YYYY-MM-DD'

create table log(
	id			int unsigned auto_increment primary key,
	ereignis   	varchar(30) not null,
    isr_datum	timestamp default current_timestamp,
	upt_datum	timestamp null on update current_timestamp
);

insert into log (ereignis) values ('Mein erstes ereignis');
update log set ereignis='Nochmal Updated' where id = 1;

select * from log;