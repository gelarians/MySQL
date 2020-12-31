/* Datensatzsperren vs. Tabellensperre
  =====================================

   Datensatzsperren sind ggü. Tabellensperren smarter, weil andere Anwender 
   weniger bei ihrer Arbeit behindert werden.
   
   Datensatzsperren funktionieren bei MySQL nur mit InnoDB.
   
   Datensatzsperren erfordern einen Index. Ist kein Index vorhanden, wird
   eine Tabellensperre vorgenommen.
   
   Read-Lock (Shared Lock)      - andere können Daten lesen, jedoch nicht ändern
   Write-Lock (Exclusive Lock)  - andere können weder schreiben noch lesen
   
   
   Isolationlevel
  ================ 
  
    Aktueller Isolationslevel: select @@session.transaction_isolation;
    Isolationslevel setzen   : set session transaction isolation level LEVELBEZEICHNER;
    
    Wir unterschieden vier Level:
    
      - Serializable:     kein anderer Anwender kann Datensatz/Tabelle lesen oder schreiben
                          alle Aktionen werden serialisiert, d.h. nacheinander ausgeführt
                          
      - Repeatable Read:  innerhalb einer Transaktion können Daten wiederholt gelesen werden,
                          das Ergebnis ist immer identisch
                          (Standard-Level in MySQL)
                          
      - Read Committed:   wenn Dritte Datenänderungen vornehmen, werden diese auch in einer
                          laufenden Session sichtbar.
                          
      - Read Uncommitted: alle Änderungen Dritter werden sofort sichtbar. Kurz: keine Isolation.
   
*/
use seminar;

select @@session.transaction_isolation;