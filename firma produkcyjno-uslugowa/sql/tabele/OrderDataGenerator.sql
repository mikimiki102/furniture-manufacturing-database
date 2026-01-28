DECLARE @Today date = CAST(GETDATE() AS date);

IF NOT EXISTS (SELECT 1 FROM dbo.Customers)
    THROW 50010, N'Brak klientów.', 1;

IF NOT EXISTS (SELECT 1 FROM dbo.Employees WHERE isActive = 1)
    THROW 50011, N'Brak aktywnych pracowników.', 1;

IF NOT EXISTS (SELECT 1 FROM dbo.Shippers WHERE isActive = 1)
    THROW 50012, N'Brak aktywnych dostawców.', 1;

DECLARE @Countries TABLE (Country nvarchar(100), idx int);
INSERT INTO @Countries VALUES
(N'Polska',1),(N'Niemcy',2),(N'Czechy',3),(N'Słowacja',4),(N'Litwa',5),(N'Francja',6),(N'Hiszpania',7),(N'Włochy',8),(N'Holandia',9),(N'Szwecja',10),
(N'Norwegia',11),(N'Dania',12),(N'Belgia',13),(N'Austria',14),(N'Szwajcaria',15),(N'Węgry',16),(N'Rumunia',17),(N'Bułgaria',18),(N'Grecja',19),(N'Irlandia',20);

DECLARE @Cities TABLE (City nvarchar(100), idx int);
INSERT INTO @Cities VALUES
(N'Warszawa',1),(N'Kraków',2),(N'Wrocław',3),(N'Poznań',4),(N'Gdańsk',5),(N'Łódź',6),(N'Szczecin',7),(N'Lublin',8),(N'Katowice',9),(N'Białystok',10),
(N'Rzeszów',11),(N'Bydgoszcz',12),(N'Toruń',13),(N'Gliwice',14),(N'Zabrze',15),(N'Opole',16),(N'Kielce',17),(N'Olsztyn',18),(N'Gdynia',19),(N'Częstochowa',20),
(N'Radom',21),(N'Sosnowiec',22),(N'Tychy',23),(N'Bielsko-Biała',24),(N'Zielona Góra',25),(N'Płock',26),(N'Elbląg',27),(N'Tarnów',28),(N'Koszalin',29),(N'Legnica',30);

DECLARE @Streets TABLE (Street nvarchar(120), idx int);
INSERT INTO @Streets VALUES
(N'Polna',1),(N'Leśna',2),(N'Słoneczna',3),(N'Krótka',4),(N'Długa',5),(N'Lipowa',6),(N'Kwiatowa',7),(N'Kościelna',8),(N'Szkolna',9),(N'Zielona',10),
(N'Ogrodowa',11),(N'Łąkowa',12),(N'Brzozowa',13),(N'Akacjowa',14),(N'Mickiewicza',15),(N'Sienkiewicza',16),(N'Piłsudskiego',17),(N'Kopernika',18),(N'Chopina',19),(N'Wiosenna',20),
(N'Jesienna',21),(N'Letnia',22),(N'Zimowa',23),(N'Parkowa',24),(N'Kolejowa',25),(N'Rynek',26),(N'Mostowa',27),(N'Portowa',28),(N'Górska',29),(N'Kasztanowa',30);

DECLARE @CntCountries int = (SELECT COUNT(*) FROM @Countries);
DECLARE @CntCities int = (SELECT COUNT(*) FROM @Cities);
DECLARE @CntStreets int = (SELECT COUNT(*) FROM @Streets);

;WITH
C AS (SELECT CustomerID, ROW_NUMBER() OVER (ORDER BY CustomerID) rn FROM dbo.Customers),
CC AS (SELECT COUNT(*) c FROM C),
E AS (SELECT EmployeeID, ROW_NUMBER() OVER (ORDER BY EmployeeID) rn FROM dbo.Employees WHERE isActive=1),
EC AS (SELECT COUNT(*) c FROM E),
S AS (SELECT ShipperID, ROW_NUMBER() OVER (ORDER BY ShipperID) rn FROM dbo.Shippers WHERE isActive=1),
SC AS (SELECT COUNT(*) c FROM S),
T AS (SELECT TOP (500) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) rn FROM sys.all_objects),

G AS (
SELECT
 t.rn,
 (SELECT CustomerID FROM C CROSS JOIN CC WHERE C.rn=(ABS(CHECKSUM(t.rn,'C'))%CC.c)+1) CustomerID,
 (SELECT EmployeeID FROM E CROSS JOIN EC WHERE E.rn=(ABS(CHECKSUM(t.rn,'E'))%EC.c)+1) EmployeeID,
 (SELECT ShipperID FROM S CROSS JOIN SC WHERE S.rn=(ABS(CHECKSUM(t.rn,'S'))%SC.c)+1) ShippersID,
 (SELECT Country FROM @Countries WHERE idx=(ABS(CHECKSUM(t.rn,'K'))%@CntCountries)+1) Country,
 (SELECT City FROM @Cities WHERE idx=(ABS(CHECKSUM(t.rn,'M'))%@CntCities)+1) City,
 (SELECT Street FROM @Streets WHERE idx=(ABS(CHECKSUM(t.rn,'U'))%@CntStreets)+1) Street,
 1+(ABS(CHECKSUM(t.rn,'H'))%220) HouseNo,
 CASE WHEN ABS(CHECKSUM(t.rn,'A'))%4=0 THEN 1+(ABS(CHECKSUM(t.rn,'B'))%80) END AptNo,
 CAST((ABS(CHECKSUM(t.rn,'P'))%8000)/100.0 AS decimal(10,2)) DeliveryPrice
FROM T t
),

Curr AS (
SELECT TOP 30 *,
 DATEADD(day,-ABS(CHECKSUM(rn,'D'))%5,@Today) OrderDate,
 CAST(NULL AS date) DeliveryDate,
 3 Status
FROM G ORDER BY rn
),

Old AS (
SELECT TOP 470 *,
 DATEADD(day,-(5+ABS(CHECKSUM(rn,'O'))%176),@Today) OrderDate,
 DATEADD(day,5+ABS(CHECKSUM(rn,'L'))%5,
         DATEADD(day,-(5+ABS(CHECKSUM(rn,'O'))%176),@Today)) DeliveryDate,
 4 Status
FROM G ORDER BY rn
)

INSERT dbo.Orders
(CustomerID,EmployeeID,ShippersID,OrderDate,DeliveryDate,Address,Country,City,DeliveryPrice,Status)
SELECT
 CustomerID,EmployeeID,ShippersID,
 OrderDate,DeliveryDate,
 N'Ul. '+Street+N' '+CAST(HouseNo AS nvarchar(10))+ISNULL(N'/'+CAST(AptNo AS nvarchar(10)),N''),
 Country,City,DeliveryPrice,Status
FROM Curr

UNION ALL

SELECT
 CustomerID,EmployeeID,ShippersID,
 OrderDate,DeliveryDate,
 N'Ul. '+Street+N' '+CAST(HouseNo AS nvarchar(10))+ISNULL(N'/'+CAST(AptNo AS nvarchar(10)),N''),
 Country,City,DeliveryPrice,Status
FROM Old;

SELECT TOP 40
 OrderID,
 CONVERT(varchar(10),OrderDate,104) OrderDate,
 CASE WHEN DeliveryDate IS NULL THEN NULL ELSE CONVERT(varchar(10),DeliveryDate,104) END DeliveryDate,
 Country,City,Address,Status
FROM dbo.Orders
ORDER BY OrderID DESC;

