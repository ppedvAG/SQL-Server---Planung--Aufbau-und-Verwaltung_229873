--BACKUP

/*

Welche Fälle kann es geben um einen Restore zu brauchen



Fall 1:
Server TOT oder MIgration via.. Backup  vorhanden

Fall 2:
Server tot, Backup etwas älter, aber HDDS existieren noch
DB Dateien sind noch da....


Fall 3:
User versemmelt ein TSQL - Update(Alle Kunden un in München)
Daten retten ohne großen Verlust

Fall 4:
Restore der DB notwendig (fehlerhaft, oder TSQL Zeug nicht mehr wiederherstellbar)


Fall 5:
Wenn ich wüßte , dass gleich was passiert



Arten des Backups:

Vollsicherung   V
sichert Dateien und deren Pfade, Größe
Checkpoint
Zeitpunkt!


Differentielle Sicherung D
sichert alle geänderten Blöcke siet V weg 
Checkpoint


Transaktionsprotokollsicherung T
notiert alle TX 



Wiederherstellungsmodel
Einfach 
TX werden erfasst (rudimentär)
"Fertige" TX werden glöscht aus dem T
--> Keine Sicherung des T
--> rel schnell , weil wengier protkolliert wird
--> und einfacher beim Verwaten

Massenprotokolliert
wie EInfach, aberes wird nichts aus dem T gelöscht
--> nur die Sicherung eines T löscht TX aus dem T
--> MUSS! T Sicherung
--> Restore per T machbar
-->wenn kein BULK Befehl stattfand, würde eine Restore auf die Sek machbar sein


Vollständig
--ausführliche Protokollierung
--> Log füllt sich schneller
--> auf Sek restore machbar

---------------------------------------------------------
TX xxx| TX TX| xxxx tX|
--------------------------------------------------------


dbcc loginfo()



! V
	T
	T
	T
	T
D
	T
	T
	T
	T
! D  alle Blöcke seit V
!	T
!	T
!	T
	Krachts!!

Was ist der schellste Restore?
V

Wie lange dauertder Restore des vorletzten T?
Solange die TX eben dauerten







-- Fall 3: Restore der DB mit geringsten Datenverlust


V   8:00

D: 10:00
T
T
T

D: 11:00
T: 11:15
T: 11:30

Problem bei 11:53
Aktuelle Uhrzeit: 12:05


Restore von etwas vor 11:53... 

--Idee 1: 11:30 restoren


Idee2: jetzt eine T Sicherung 11:30 bis 12:05  restore von 11:52
--Datenverlust  bis zum Ende der T Sicherung 12:10
--T Sicherung dauert 5 min
--aber wenn man aber die DB in Singel_user Modus versetzt , dann kann keiner etwas tun

*/
USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2023-06-20_12-09-46.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2023-06-20_12-09-46', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2023-06-20_12-09-46.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2023-06-20T11:45:00'
ALTER DATABASE [Northwind] SET MULTI_USER

GO



---Fall was wäre wenn ich wüsste dass gleich was passiert



--DB X     100GB   90GB MDF     10 GB LDF

--lesbare DB mit den Daten von 12:00

--Auf LW D:  freier Platz 1  MB frei


--Snapshot
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Vollständig', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'Northwind-Diff', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\nwindxxx.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Log', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


V  TTT  D TTT D TTT


-- Create the database snapshot
CREATE DATABASE DBNAMEDESSNAPHOT ON
( 
NAME = NamederOrigDBDatendatei,
FILENAME = 'PfadundNamederSNapshotdatei' 
)
AS SNAPSHOT OF OrigDB;
GO


CREATE DATABASE Nwind_2023_06_20_1239 ON
( 
NAME = northwind,
FILENAME = 'D:\_SQLDBDATA\Nwind_1239.mdf' 
)
AS SNAPSHOT OF Northwind;
GO




















Dateisicheung Kopiesicherung Teilschicherung













*/

--Fall 3 Restore als andere DB
--DB bei Ziel umbennen
--Dateinamen ändern
--Fragemntsicherung ausschalten