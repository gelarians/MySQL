use seminar;


create user 'test2'@'localhost'
identified by	'12345';
 
show engines;

grant all on seminar.* to 'test2'@'localhost';

drop table if exists test;
create table test
(
  id      int unsigned not null auto_increment primary key,
  wert    int
) engine=myisam;
insert into test (wert) values (1), (2), (3), (4);

select * from test;

lock tables test read;

select * from test;
insert into test(wert) values (5);

select * from personen;

unlock tables;