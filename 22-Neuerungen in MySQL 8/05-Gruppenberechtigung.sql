create role 'seminarteilnehmer';
grant select on seminar.* to 'seminarteilnehmer';
create user 'semtest'@'localhost' identified by 'kennwort';
grant 'seminarteilnehmer' to 'semtest'@'localhost';