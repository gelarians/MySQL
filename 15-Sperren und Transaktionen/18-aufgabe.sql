Wie lautet der Kontostand MIT und OHNE Datensatzsperre?

Aenderungen werden fuer jede Person erst sichtbar, wenn die jeweils
andere Person ein COMMIT ausgeloest hat.


Zeit    Person A                      Person B                      Saldo

 t0     START TRANSACTION;            START TRANSACTION;            2000,00

 t1     UPDATE konten
        SET saldo = saldo - 1000
        WHERE konto_id = 1;

 t2                                   UPDATE konten
                                      SET saldo = saldo + 500
                                      WHERE konto_id = 1;

 t3     COMMIT;

 t4                                   COMMIT;

 t5      SELECT *
         FROM konten
         WHERE konto_id = 1;                                        ???
