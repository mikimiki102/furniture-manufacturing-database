DECLARE @HalfCount int = 50;

DECLARE @RealSupplierIDs TABLE (RowID INT IDENTITY(1,1), RealID INT);
INSERT INTO @RealSupplierIDs (RealID) SELECT SupplierID FROM dbo.Suppliers;

DECLARE @SupplierCount INT = (SELECT COUNT(*) FROM @RealSupplierIDs);

IF @SupplierCount = 0
BEGIN
    PRINT 'Błąd: Brak dostawców w tabeli Suppliers!';
    RETURN;
END

DELETE FROM dbo.Parts;
DBCC CHECKIDENT('Parts', RESEED, 0);


DECLARE @AdjMasc TABLE (val nvarchar(100));
INSERT INTO @AdjMasc VALUES
 (N'Stalowy'),(N'Aluminiowy'),(N'Ocynkowany'),(N'Nierdzewny'),(N'Mosiężny'),
 (N'Plastikowy'),(N'Gumowy'),(N'Filcowy'),(N'Hartowany'),(N'Montażowy'),
 (N'Chromowany'),(N'Antypoślizgowy'),(N'Meblowy'),(N'Pneumatyczny'),(N'Hydrauliczny');

DECLARE @NounMasc TABLE (val nvarchar(100));
INSERT INTO @NounMasc VALUES
 (N'Wkręt do drewna'),(N'Wkręt do metalu'),(N'Nit zrywalny'),(N'Kołek rozporowy'),(N'Kołek drewniany'),
 (N'Trzpień'),(N'Zamek meblowy'),(N'Ogranicznik'),(N'Ślizgacz'),(N'Odbojnik'),
 (N'Profil zamknięty'),(N'Kątownik'),(N'Ceownik'),(N'Płaskownik'),(N'Pręt gwintowany'),
 (N'Siłownik gazowy'),(N'Amortyzator'),(N'Mechanizm regulacji'),(N'Zestaw montażowy'),(N'Uchwyt krawędziowy');

;WITH Cnts AS (SELECT (SELECT COUNT(*) FROM @AdjMasc) AS cA, (SELECT COUNT(*) FROM @NounMasc) AS cN),
Tally AS (SELECT TOP (@HalfCount) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn FROM sys.all_objects),
A AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @AdjMasc),
N AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @NounMasc)

INSERT INTO dbo.Parts (SupplierID, PartName, Cost)
SELECT
  (SELECT RealID FROM @RealSupplierIDs WHERE RowID = ((t.rn - 1) % @SupplierCount) + 1),
  (SELECT a1.val FROM A a1 CROSS JOIN Cnts k WHERE a1.idx = ((t.rn * 2) % k.cA) + 1) + N' ' +
  (SELECT n1.val FROM N n1 CROSS JOIN Cnts k WHERE n1.idx = ((t.rn * 3) % k.cN) + 1),
  CAST(1.40 + (ABS(CHECKSUM(NEWID())) % 12860) / 100.0 AS DECIMAL(10, 2))
FROM Tally t;

DECLARE @AdjFem TABLE (val nvarchar(100));
INSERT INTO @AdjFem VALUES
 (N'Stalowa'),(N'Aluminiowa'),(N'Ocynkowana'),(N'Nierdzewna'),(N'Mosiężna'),
 (N'Plastikowa'),(N'Gumowa'),(N'Filcowa'),(N'Hartowana'),(N'Montażowa'),
 (N'Chromowana'),(N'Ochronna'),(N'Meblowa'),(N'Piankowa'),(N'Sprężynująca');

DECLARE @NounFem TABLE (val nvarchar(100));
INSERT INTO @NounFem VALUES
 (N'Śruba metryczna'),(N'Nakrętka sześciokątna'),(N'Nakrętka samokontrująca'),(N'Podkładka płaska'),(N'Podkładka sprężynująca'),
 (N'Śruba zamkowa'),(N'Mufa wkręcana'),(N'Zaślepka otworu'),(N'Uszczelka krawędziowa'),(N'Sprężyna gazowa'),
 (N'Blacha perforowana'),(N'Rura konstrukcyjna'),(N'Płyta montażowa'),(N'Szyna prowadząca'),(N'Tuleja dystansowa'),
 (N'Okleina PCV'),(N'Taśma montażowa'),(N'Pianka tapicerska'),(N'Formatka sklejkowa'),(N'Stopka regulacyjna');

;WITH Cnts AS (SELECT (SELECT COUNT(*) FROM @AdjFem) AS cA, (SELECT COUNT(*) FROM @NounFem) AS cN),
Tally AS (SELECT TOP (@HalfCount) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn FROM sys.all_objects),
A AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @AdjFem),
N AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @NounFem)

INSERT INTO dbo.Parts (SupplierID, PartName, Cost)
SELECT
  (SELECT RealID FROM @RealSupplierIDs WHERE RowID = (((t.rn + 50) - 1) % @SupplierCount) + 1),
  (SELECT a1.val FROM A a1 CROSS JOIN Cnts k WHERE a1.idx = ((t.rn * 4) % k.cA) + 1) + N' ' +
  (SELECT n1.val FROM N n1 CROSS JOIN Cnts k WHERE n1.idx = ((t.rn * 7) % k.cN) + 1),
  CAST(1.40 + (ABS(CHECKSUM(NEWID())) % 12860) / 100.0 AS DECIMAL(10, 2))
FROM Tally t;