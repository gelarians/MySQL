-- Rechte zuweisen

-- alter = userdaten ändern
-- create = user anlegen
-- drop = user löschen
-- grant = berechtigung vergeben an user
-- rename user = user umbenennen
-- revoke = rechte entziehen 
-- set password = ^^ sagt der befehl ja schon


create user 'testuser'@'localhost'
identified by	'12345';

grant select, insert, delete, update on leihbib.* to 'testuser'@'localhost';