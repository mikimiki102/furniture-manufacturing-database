DECLARE @NE int = 20;
DELETE FROM dbo.Employees;
DBCC CHECKIDENT('Employees', RESEED, 0);

DECLARE @First TABLE (val nvarchar(100));
INSERT INTO @First VALUES
 (N'Adam'),(N'Barbara'),(N'Cezary'),(N'Dorota'),(N'Edward'),(N'Felicja'),(N'Grzegorz'),(N'Hanna'),(N'Igor'),(N'Justyna'),
 (N'Krzysztof'),(N'Ludmiła'),(N'Marek'),(N'Natalia'),(N'Oskar'),(N'Patrycja'),(N'Robert'),(N'Sylwia'),(N'Tomasz'),(N'Urszula'),
 (N'Wiktor'),(N'Beata'),(N'Andrzej'),(N'Magdalena'),(N'Marcin'),(N'Monika'),(N'Rafał'),(N'Ewa'),(N'Piotr'),(N'Agnieszka');

DECLARE @Last TABLE (val nvarchar(100));
INSERT INTO @Last VALUES
 (N'Zając'),(N'Król'),(N'Wróbel'),(N'Woźniak'),(N'Adamczyk'),(N'Mazurek'),(N'Krawczyk'),(N'Kaczmarek'),(N'Stępień'),(N'Dudek'),
 (N'Zalewski'),(N'Wieczorek'),(N'Włodarczyk'),(N'Liwiński'),(N'Szczepański'),(N'Górski'),(N'Kozłowski'),(N'Sikora'),(N'Baran'),(N'Przybylski'),
 (N'Wierzbicki'),(N'Walczak'),(N'Bielecki'),(N'Sokołowski'),(N'Jaworski'),(N'Laskowski'),(N'Stasiak'),(N'Makowski'),(N'Abramowicz'),(N'Malinowski');

DECLARE @Street TABLE (val nvarchar(100));
INSERT INTO @Street VALUES
 (N'Główna'),(N'Ogrodowa'),(N'Długa'),(N'Zielona'),(N'Kolejowa'),(N'Boczna'),(N'Cicha'),(N'Wąska'),(N'Stroma'),(N'Prosta'),
 (N'Leśna'),(N'Polna'),(N'Krótka'),(N'Szkolna'),(N'Łąkowa'),(N'Słoneczna'),(N'Kwiatowa'),(N'Lipowa'),(N'Brzozowa'),(N'Jodłowa');

DECLARE @City TABLE (val nvarchar(100));
INSERT INTO @City VALUES
 (N'Kraków'),(N'Katowice'),(N'Wieliczka'),(N'Skawina'),(N'Niepołomice'),
 (N'Myślenice'),(N'Bochnia'),(N'Krzeszowice'),(N'Olkusz'),(N'Trzebinia');

DECLARE @Prefix TABLE (p int);
INSERT INTO @Prefix VALUES
 (601),(602),(603),(604),(605),(606),(607),(608),(609),(661),(662),(663),(664),(665),(667),(668),(669);

;WITH Cnts AS (
  SELECT (SELECT COUNT(*) FROM @First)  AS cF,
         (SELECT COUNT(*) FROM @Last)   AS cL,
         (SELECT COUNT(*) FROM @Street) AS cS,
         (SELECT COUNT(*) FROM @City)   AS cC,
         (SELECT COUNT(*) FROM @Prefix) AS cP
),
Tally AS (
  SELECT TOP (@NE) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM sys.all_objects
),
F AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @First),
L AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Last),
S AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Street),
C AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @City),
P AS (SELECT p,   ROW_NUMBER() OVER (ORDER BY p)   AS idx FROM @Prefix)
INSERT INTO dbo.Employees (Name, Address, PhoneNumber, isActive)
SELECT
  (SELECT f1.val FROM F f1 CROSS JOIN Cnts k WHERE f1.idx = ((t.rn * 17) % k.cF) + 1)
  + N' ' +
  (SELECT l1.val FROM L l1 CROSS JOIN Cnts k WHERE l1.idx = ((t.rn * 23) % k.cL) + 1),

  N'ul. ' +
  (SELECT s1.val FROM S s1 CROSS JOIN Cnts k WHERE s1.idx = ((t.rn * 13) % k.cS) + 1) + N' ' +
  CAST(1 + ((t.rn * 7) % 199) AS nvarchar(4)) + N', ' +
  (SELECT c1.val FROM C c1 CROSS JOIN Cnts k WHERE c1.idx = ((t.rn * 11) % k.cC) + 1),

  N'+48' +
  CAST((SELECT p FROM P p1 CROSS JOIN Cnts k WHERE p1.idx = ((t.rn * 3) % k.cP) + 1) AS varchar(3)) +
  RIGHT('000000' + CAST((t.rn + 500000) AS varchar(6)), 6),

  CASE WHEN (t.rn % 12) = 0 THEN 0 ELSE 1 END
FROM Tally t;