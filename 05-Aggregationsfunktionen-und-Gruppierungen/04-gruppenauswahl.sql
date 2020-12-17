
-- HAVING - Gruppenauswahlbedingungen
--
-- WHERE = Datensatzauswahl vs. HAVING = Gruppenauswahl

use seminar;

select avg(lebensalter), geschlecht          
from anwender                             
group by geschlecht
having avg(lebensalter) > 40;                         
                                     
      