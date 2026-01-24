DECLARE @NS int = 25;

DELETE FROM dbo.Shippers;
DBCC CHECKIDENT('Shippers', RESEED, 0);

DECLARE @Adj TABLE (val nvarchar(100));
INSERT INTO @Adj VALUES
 (N'Szybki'),(N'Pewny'),(N'Global'),(N'Euro'),(N'Trans'),(N'Inter'),(N'Mega'),
 (N'North'),(N'Super'),(N'Eko'),(N'Rapid'),(N'Flash'),(N'Smart'),(N'Blue'),(N'Red'),
 (N'Gold'),(N'Silver'),(N'Prime'),(N'Direct'),(N'Universal'),
 (N'First'),(N'Top'),(N'Pro'),(N'Star'),(N'Max'),
 (N'Solid'),(N'Terra'),(N'Aqua'),(N'Fast'),(N'General');

DECLARE @Noun TABLE (val nvarchar(100));
INSERT INTO @Noun VALUES
 (N'Trans'),(N'Logistics'),(N'Cargo'),(N'Shipping'),(N'Express'),(N'Delivery'),(N'Kurier'),
 (N'Freight'),(N'Lines'),(N'Transport'),(N'Connect'),(N'Move'),(N'Way'),(N'Air'),(N'Road'),
 (N'Haulage'),(N'Distribution'),(N'Link'),(N'Chain'),(N'Service'),
 (N'Network'),(N'Hub'),(N'Carrier'),(N'Post'),(N'Speed'),
 (N'Route'),(N'Track'),(N'Solutions'),(N'Spedition'),(N'Trust');

DECLARE @Suf TABLE (val nvarchar(100));
INSERT INTO @Suf VALUES
 (N'Sp. z o.o.'),(N'S.A.'),(N'GmbH'),(N'Inc.'),(N'LLC'),
 (N'Corp.'),(N'Ltd.'),(N'& Partners'),(N'Group'),(N'International');

-- 2. KODY KRAJÓW
DECLARE @CountryCode TABLE (code nvarchar(10));
INSERT INTO @CountryCode VALUES
 (N'+1'), (N'+44'), (N'+49'), (N'+33'), (N'+39'),
 (N'+34'), (N'+86'), (N'+48'), (N'+420'), (N'+351');

;WITH Cnts AS (
  SELECT (SELECT COUNT(*) FROM @Adj)   AS cA,
         (SELECT COUNT(*) FROM @Noun)  AS cN,
         (SELECT COUNT(*) FROM @Suf)   AS cS,
         (SELECT COUNT(*) FROM @CountryCode) AS cCC
),
Tally AS (
  SELECT TOP (@NS) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM sys.all_objects
),
A AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Adj),
N AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Noun),
S AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Suf),
CC AS (SELECT code, ROW_NUMBER() OVER (ORDER BY code) AS idx FROM @CountryCode)

INSERT INTO dbo.Shippers (CompanyName, PhoneNumber, isActive)
SELECT

  (SELECT a1.val FROM A a1 CROSS JOIN Cnts k WHERE a1.idx = ((t.rn*1)%k.cA)+1) + N' ' +
  (SELECT n1.val FROM N n1 CROSS JOIN Cnts k WHERE n1.idx = ((t.rn*2)%k.cN)+1) + N' ' +
  (SELECT s1.val FROM S s1 CROSS JOIN Cnts k WHERE s1.idx = ((t.rn*3)%k.cS)+1),

  (SELECT cc1.code FROM CC cc1 CROSS JOIN Cnts k WHERE cc1.idx = ((t.rn*7)%k.cCC)+1) +
  RIGHT('000000000' + CAST(((t.rn * 982451653) % 1000000000) AS varchar(9)), 9),


  CASE WHEN (t.rn % 10) = 0 THEN 0 ELSE 1 END

FROM Tally t;