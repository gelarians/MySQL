/* ACID

   ACID = Atomicity Consistency Isolation Durability
   
   InnoDB ist ACID-compliant, alle anderen Engines von MySQL nicht!
   
   Beispiel: Es soll Geld von einem Bankkonto auf ein anderes Konto überwiesen werden.
             --> zwei Update-Operationen
             
             set @betrag := 1000;
             update konten set saldo = saldo - @betrag where konto = 1234;
             update konten set saldo = saldo + @betrag where konto = 6789;
   
    Atomicity. : Beide Befehle werden zusammen als EINE Aktion ausgeführt!
    Consistency: Bricht die Netzwerkverbindung ab, bleibt die DB in einem
                 konsitenten Zustand. Kein Konto wird verändert.
    Isolation. : Zwei Anwender, die das jeweils gleich Konto bearbeiten wollen,
                 kommen sich nicht in die Quere.
    Durability : Auch nach einem Crash, Serverabsturz, wird die DB wieder in
                 einem konsistenten Zustand wiederhergestellt.
                 
*/