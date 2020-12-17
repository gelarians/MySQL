-- Boolean

use seminar;

create table wahrheit(
	wahrfalsch		bool
);

insert into wahrheit (wahrfalsch) values (true), (false);

select * from wahrheit;

desc wahrheit;