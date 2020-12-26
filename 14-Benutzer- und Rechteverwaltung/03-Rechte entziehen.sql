create user 'testuser'@'localhost'
identified by	'12345';

grant select, insert, delete, update on leihbib.* to 'testuser'@'localhost';


revoke insert on leihbib.* from 'testuser'@'localhost';
revoke insert on leihbib.verleih from 'testuser'@'localhost'; -- geht nicht weil oben leihbib.* nutzt

grant select, insert on leihbib.buch to 'testuser'@'localhost';