DECLARE @N int = 100;

DELETE FROM dbo.Employees;
DBCC CHECKIDENT ('Employees', RESEED, 0);

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

DECLARE @Prefix TABLE (p int);
INSERT INTO @Prefix VALUES
 (500),(501),(502),(503),(505),(506),(507),(508),(509),
 (511),(512),(513),(515),(516),(517),(518),(519),
 (721),(722),(723),(724),(725),(726),(727),(728),(729);

WITH F AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @First),
     L AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Last),
     S AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Street),
     P AS (SELECT p,   ROW_NUMBER() OVER (ORDER BY p)   AS idx FROM @Prefix),
     Cnts AS (
       SELECT (SELECT COUNT(*) FROM F) AS cF,
              (SELECT COUNT(*) FROM L) AS cL,
              (SELECT COUNT(*) FROM S) AS cS,
              (SELECT COUNT(*) FROM P) AS cP
     ),
     Tally AS (
       SELECT TOP (@N) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
       FROM sys.all_objects
     )

INSERT INTO dbo.Employees (Name, Address, PhoneNumber, isActive)
SELECT
  (SELECT F1.val FROM F F1 CROSS JOIN Cnts c WHERE F1.idx = ((t.rn*3)  % c.cF) + 1)
  + N' ' +
  (SELECT L1.val FROM L L1 CROSS JOIN Cnts c WHERE L1.idx = ((t.rn*5)  % c.cL) + 1) AS [Name],

  N'ul. ' +
  (SELECT S1.val FROM S S1 CROSS JOIN Cnts c WHERE S1.idx = ((t.rn*7) % c.cS) + 1)
  + N' ' +
  CAST(1 + ((t.rn*11) % 120) AS nvarchar(4)) +
  CASE WHEN (t.rn % 3) = 0
       THEN N'/' + CAST(1 + ((t.rn*13) % 50) AS nvarchar(3))
       ELSE N'' END AS [Address],

  N'+48' +
  RIGHT('000' + CAST( (SELECT p FROM P P1 CROSS JOIN Cnts c WHERE P1.idx = ((t.rn*9) % c.cP) + 1) AS varchar(3)), 3) +
  RIGHT('000000' + CAST( ((t.rn * 104729) % 1000000) AS varchar(6)), 6) AS PhoneNumber,

  CAST(
    CASE WHEN (ABS(CHECKSUM(NEWID(), t.rn)) % 100) < 15 THEN 0 ELSE 1 END
    AS bit
  ) AS isActive
FROM Tally t;
