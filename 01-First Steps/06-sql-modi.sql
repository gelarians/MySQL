use seminar;

select @@global.sql_mode;
select @@session.sql_mode;

-- 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'


create table irgendwas (
	id 		int
)engine=myism;