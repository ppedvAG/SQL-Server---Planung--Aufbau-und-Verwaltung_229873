/*
Updatefrage-- wir ignorieren diese .. nachfolgende Meldung ist nicht wiurklich eine Fehlermeldung

Instanzen
Grund für Instanzen
--Software / Security
--Software braucht andere Version des SQL Servers
--Performance wg Serversettings

Std Instanz: Aufruf "PC"   Port 1433
2te Instanz  Aufruf "PC\Instanzname"  Port: ?????

Wie kommt der Client zu der benannten Instanz:

Rezeption: SQL Browserdienst (UDP 1434)

Dienst+Konto

Datenträgervorlumewartungstask



Agent: Jobs Zeitpläne Emailsystem Wartungsjobs

NT Service\.. sind lokale Konten (im Netz via Computerkonto), die Kennwortänderungen automatisch im Hintergrund organisieren

Security
NT Auth
SQL Login ( + NT Auth) = gemischte Auth

Windows Admins sind nicht mehr per default SQL Admin
SA = Sysadmin  darf alles--> Kennwort!!! 
--besser nioch : SA später deaktvieren und Ersatz SA Konto anlegen

Pfade
Trenne Daten von Logs per HDDs

DB 2 Dateien: .mdf (master data file) Systemtabellen und andere Tabellen

             .ldf Transaktionsprotokoll

Backup Pfad

Systemtabellenpfad

TempDB
#tabellen, Zeilenversionierung, IX Wartung, Auslagerung
am besten eig HDDs


Tempdb
ideal: eig HDDs für Daten und Log
soviele DatenDateien wie Kerne, aber nicht mehr als 8


Sortierung

Filestreaming

MAXDOP
maximale ANzhal der Kerne pro Abfrage (Lmit sollte 8 Sein oder Anzahl der kerne)

Arbeitsspeicher
Min = 0
Max= Gesamter RAM - OS - evtl anedere Software ider andere SQL Instanzen

Empfohlenen Wert übernehmen
---´Tipp: Empfohlender Wert sucht nicht nach anderen Instanzen






*/