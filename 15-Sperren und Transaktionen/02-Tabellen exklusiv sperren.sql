use seminar;

show engines;

grant all on seminar.* to 'test'@'localhost';

drop table if exists test;
create table test
(
  id      int unsigned not null auto_increment primary key,
  wert    int
) engine=myisam;
insert into test (wert) values (1), (2), (3), (4);

select * from test;

lock tables test write;

select * from test;
insert into test(wert) values (5);

select * from personen;

unlock tables;