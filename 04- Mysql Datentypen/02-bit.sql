use seminar;

create table bits (bitfeld bit(4));
desc bits;

insert into bits (bitfeld) values (b'0000');
insert into bits (bitfeld) values (b'0001');
insert into bits (bitfeld) values (b'0010');

select * from bits;