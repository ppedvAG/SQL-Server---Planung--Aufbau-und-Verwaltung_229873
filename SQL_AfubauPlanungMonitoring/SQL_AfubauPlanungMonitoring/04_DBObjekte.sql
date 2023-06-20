--DBObjekte

--Sichten  Views
gemerkte Abfrage und verh�lt sich wie ein Tabelle

SELECT
INSERT
UPDATE
DELETE 
IX
Rechte auf Sichten setzen

Grund f�r Sicht:
h�ufig Security.. Zugriff auf Tabellendaten einschr�nken


Schreibfaulheit

create view KundeBestellung
as
SELECT        Customers.CompanyName, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID

select * from kundeBestellung


--Prozeduren  stored procedures


---wie Windowsbatchdatei
--kann alles beinhalten SEL INS UP DEL

--wird aber anders ausgef�hrt

exec namederporc par1, par2, par3



--Functions

select f(spalte), f(wert) from f(Wert)
where f(spalte) > (f(wert)



--a) adhoc 
--b) Sicht
--c) Proz
--d) F()

---langsam------------------------>schnell
-- d/c        b/a      

--QueryStore --Sammeln von Abfragen und Messwerten

--Was wenn dem Agent das Recht fehlen w�rde
--> PS  CMD

--ProxyKonto

--1: Anmeldeinformation
























create view Sichtname
as
select ..

select * from sichtname















/*

a) adhoc Abfragen 
select * from tabelle...

b) Prozeduren 
exec procName 10, 'XY'      wie Windows Batchdatei

oft BI Logik
create proc procname @par1 int, @par2 vrchar(50)
as
select * from 
insert
update
delete 

schneller: weil der Plan, der einmal erstellt wird auch in Zukunft weiter verwendet wird..auch nach Neustart



c) Views / Sichten 
Sichten haben keine DAten sindern nur Abfragen..
Sichten k�nnen wie Tabellen behandelt werden: SEL  INS DEL UP Securtiy
Grund f�r Sicht: komplexe Abfragen, oder Security
create view vName
as
select * from tabelle 

select * from vName

select * from (select * from tabelle) t


d) Funktionen
eigtl immer mies.. seitens Performance


select fnetto(freight)  from ftab(100) 


---------------------------------->schneller
  a    d      b		c


  --faktisch:
  d          a|c               b

  --kann aber auch so sein
    b     d    a|c
