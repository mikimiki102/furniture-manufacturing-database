DECLARE @NC int = 500;

DELETE FROM dbo.Customers;
DBCC CHECKIDENT('Customers', RESEED, 0);

DECLARE @First TABLE (val nvarchar(100));
INSERT INTO @First VALUES
 (N'Jan'),(N'Anna'),(N'Piotr'),(N'Katarzyna'),(N'Paweł'),
 (N'Karolina'),(N'Michał'),(N'Joanna'),(N'Łukasz'),(N'Magda');

DECLARE @Last TABLE (val nvarchar(100));
INSERT INTO @Last VALUES
 (N'Nowak'),(N'Kowalski'),(N'Wiśniewski'),(N'Wójcik'),(N'Kamiński'),
 (N'Lewandowski'),(N'Zieliński'),(N'Szymański'),(N'Dąbrowski'),(N'Pawlak');

DECLARE @Street TABLE (val nvarchar(100));
INSERT INTO @Street VALUES
 (N'Mickiewicza'),(N'Słoneczna'),(N'Kwiatowa'),(N'Lipowa'),(N'Polna'),
 (N'Krótka'),(N'Leśna'),(N'Kościuszki'),(N'Szkolna'),(N'Łąkowa');

DECLARE @City TABLE (val nvarchar(100));
INSERT INTO @City VALUES
 (N'Warszawa'),(N'Kraków'),(N'Gdańsk'),(N'Wrocław'),(N'Poznań'),
 (N'Łódź'),(N'Szczecin'),(N'Lublin'),(N'Katowice'),(N'Białystok');

DECLARE @Prefix TABLE (p int);
INSERT INTO @Prefix VALUES
 (500),(501),(502),(503),(505),(506),(507),(508),(509),
 (511),(512),(513),(515),(516),(517),(518),(519),
 (721),(722),(723),(724),(725),(726),(727),(728),(729);

;WITH Cnts AS (
  SELECT (SELECT COUNT(*) FROM @First)  AS cF,
         (SELECT COUNT(*) FROM @Last)   AS cL,
         (SELECT COUNT(*) FROM @Street) AS cS,
         (SELECT COUNT(*) FROM @City)   AS cC,
         (SELECT COUNT(*) FROM @Prefix) AS cP
),
Tally AS (
  SELECT TOP (@NC) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM sys.all_objects
),
F AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @First),
L AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Last),
S AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Street),
C AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @City),
P AS (SELECT p,   ROW_NUMBER() OVER (ORDER BY p)   AS idx FROM @Prefix)
INSERT INTO dbo.Customers (Name, Address, PhoneNumber)
SELECT
  (SELECT f1.val FROM F f1 CROSS JOIN Cnts k WHERE f1.idx = ((t.rn*3)%k.cF)+1)
  + N' ' +
  (SELECT l1.val FROM L l1 CROSS JOIN Cnts k WHERE l1.idx = ((t.rn*5)%k.cL)+1),
  N'ul. ' +
  (SELECT s1.val FROM S s1 CROSS JOIN Cnts k WHERE s1.idx = ((t.rn*7)%k.cS)+1) + N' ' +
  CAST(1 + ((t.rn*11)%120) AS nvarchar(4)) +
  CASE WHEN (t.rn % 4) = 0
       THEN N'/' + CAST(1 + ((t.rn*13)%50) AS nvarchar(3))
       ELSE N'' END
  + N', ' +
  (SELECT c1.val FROM C c1 CROSS JOIN Cnts k WHERE c1.idx = ((t.rn*9)%k.cC)+1),
  N'+48' +
  RIGHT('000' + CAST((SELECT p FROM P p1 CROSS JOIN Cnts k WHERE p1.idx = ((t.rn*9)%k.cP)+1) AS varchar(3)),3) +
  RIGHT('000000' + CAST(((t.rn*104729)%1000000) AS varchar(6)),6)
FROM Tally t;
