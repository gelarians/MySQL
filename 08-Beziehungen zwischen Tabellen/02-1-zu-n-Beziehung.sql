-- 1:N Beziehung
-- mutter - kinder

create table muetter(
	mutter_id		int unsigned not null auto_increment primary key,
    vorname			varchar(30) not null
    -- weitere felder
);


create table kinder(
	kind_id			int unsigned not null auto_increment primary key,
    vorname			varchar(30) not null,
    mutter			int unsigned not null
);


select * from muetter
join kinder on mutter_id = mutter;