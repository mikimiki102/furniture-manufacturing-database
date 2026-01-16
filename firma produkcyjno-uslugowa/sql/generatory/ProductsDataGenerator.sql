DECLARE @NP int = 120;

DELETE FROM dbo.Products;
DBCC CHECKIDENT('Products', RESEED, 0);

DECLARE @Adj TABLE (val nvarchar(100));
INSERT INTO @Adj VALUES
 (N'Ergonomiczny'),(N'Wytrzymały'),(N'Nowoczesny'),(N'Klasyczny'),(N'Kompaktowy'),
 (N'Modułowy'),(N'Premium'),(N'Budżetowy'),(N'Profesjonalny'),(N'Akustyczny'),
 (N'Regulowany'),(N'Antypoślizgowy'),(N'Lekki'),(N'Stalowy'),(N'Drewniany'),
 (N'Aluminiowy'),(N'Industrialny'),(N'Minimalistyczny'),(N'Ekonomiczny'),(N'Wzmocniony'),
 (N'Mobilny'),(N'Zintegrowany'),(N'Wentylowany'),(N'Antystatyczny'),(N'Bezprzewodowy'),
 (N'Elektrycznie regulowany'),(N'Z pamięcią pozycji'),(N'Łatwy w montażu'),(N'Higieniczny'),(N'Bezpieczny');

DECLARE @Item TABLE (val nvarchar(120));
INSERT INTO @Item VALUES
 (N'Krzesło biurowe'),(N'Fotel biurowy'),(N'Fotel gamingowy'),(N'Biurko'),
 (N'Biurko gamingowe'),(N'Stół konferencyjny'),(N'Stołek laboratoryjny'),
 (N'Szafka biurowa'),(N'Regał na sprzęt'),(N'Kontener biurowy'),
 (N'Podstawka pod monitor'),(N'Wózek na laptopy'),(N'Stojak na projektor ruchomy'),
 (N'Tablica interaktywna'),(N'Panel akustyczny'),(N'Stół laboratoryjny'),
 (N'Ławka komputerowa'),(N'Podnóżek ergonomiczny'),(N'Parawan biurowy'),
 (N'Regał serwerowy'),(N'Szafa rack'),(N'Wózek AV'),(N'Pulpit wykładowy'),
 (N'Organizer kabli'),(N'Szuflada na klawiaturę'),(N'Podstawa VESA'),
 (N'Blat roboczy'),(N'Belka zasilająca'),(N'Kontener mobilny'),(N'Podpora CPU');

DECLARE @Brand TABLE (val nvarchar(80));
INSERT INTO @Brand VALUES
 (N'ErgoLine'),(N'OfficeFlex'),(N'ProDesk'),(N'ClassRoom'),
 (N'TechSpace'),(N'GamerPro'),(N'EduTech'),(N'WorkSmart'),
 (N'LabMaster'),(N'AVMotion'),(N'RackCore'),(N'DeskWorks');

DECLARE @Material TABLE (val nvarchar(40));
INSERT INTO @Material VALUES
 (N'drewnopodobny'),(N'laminat'),(N'buk'),(N'dąb'),(N'metal'),
 (N'aluminium'),(N'siatka'),(N'tkanina'),(N'skóra PU'),(N'szkło hartowane');

DECLARE @AZ nvarchar(26)     = N'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
DECLARE @Digits nvarchar(10) = N'0123456789';

;WITH PCnts AS (
  SELECT (SELECT COUNT(*) FROM @Adj)      AS cA,
         (SELECT COUNT(*) FROM @Item)     AS cI,
         (SELECT COUNT(*) FROM @Brand)    AS cB,
         (SELECT COUNT(*) FROM @Material) AS cM
),
PTally AS (
  SELECT TOP (@NP) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM sys.all_objects
),
A AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Adj),
I AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Item),
B AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Brand),
M AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Material),

Base AS (
  SELECT
    t.rn,
    (SELECT a1.val FROM A a1 CROSS JOIN PCnts k WHERE a1.idx = (ABS(CHECKSUM(t.rn, 'A')) % k.cA) + 1)
    + N' ' +
    (SELECT i1.val FROM I i1 CROSS JOIN PCnts k WHERE i1.idx = (ABS(CHECKSUM(t.rn*7 + 13, 'I')) % k.cI) + 1)
    + CASE WHEN (ABS(CHECKSUM(t.rn, 'MAT?')) % 3) = 0
           THEN N' ' + (SELECT m1.val FROM M m1 CROSS JOIN PCnts k WHERE m1.idx = (ABS(CHECKSUM(t.rn*11 + 5, 'M')) % k.cM) + 1)
           ELSE N'' END
    + N' ' +
    (SELECT b1.val FROM B b1 CROSS JOIN PCnts k WHERE b1.idx = (ABS(CHECKSUM(t.rn*5 + 17, 'B')) % k.cB) + 1)
    + N' ' +
    SUBSTRING(@AZ, 1 + ABS(CHECKSUM(t.rn, 'm1')) % 26, 1) +
    SUBSTRING(@AZ, 1 + ABS(CHECKSUM(t.rn*3 + 7, 'm2')) % 26, 1) +
    N'-' +
    SUBSTRING(@Digits, 1 + ABS(CHECKSUM(t.rn*19 + 23, 'd1')) % 10, 1) +
    SUBSTRING(@Digits, 1 + ABS(CHECKSUM(t.rn*29 + 31, 'd2')) % 10, 1) AS CandidateName,

    CAST( (15000 + (ABS(CHECKSUM(NEWID(), t.rn, 'price', SYSDATETIME())) % 485000)) / 100.0 AS decimal(10,2)) AS Price,
    3 + (ABS(CHECKSUM(t.rn, 'ptime')) % 5) AS ProductionTime
  FROM PTally t
),

DeDup AS (
  SELECT
    rn,
    CandidateName,
    Price,
    ProductionTime,
    ROW_NUMBER() OVER (PARTITION BY CandidateName ORDER BY rn) AS dup_no
  FROM Base
)

INSERT INTO dbo.Products (ProductName, Price, ProductionTime)
SELECT
  CASE WHEN dup_no = 1
       THEN CandidateName
       ELSE CandidateName + N' (' + CAST(dup_no AS nvarchar(10)) + N')'
  END AS ProductName,
  Price,
  ProductionTime
FROM DeDup
ORDER BY rn;
