DECLARE @NS int = 30;

DELETE FROM dbo.Suppliers;
DBCC CHECKIDENT('Suppliers', RESEED, 0);

DECLARE @AddressBook TABLE (
    ID INT IDENTITY(1,1),
    City NVARCHAR(100),
    Country NVARCHAR(100),
    PhoneCode NVARCHAR(10),
    StreetName NVARCHAR(100)
);

INSERT INTO @AddressBook (City, Country, PhoneCode, StreetName) VALUES
 (N'Berlin',    N'Germany',     N'+49',  N'Alexanderplatz'),
 (N'Paris',     N'France',      N'+33',  N'Rue de Rivoli'),
 (N'London',    N'UK',          N'+44',  N'Oxford Street'),
 (N'Madrid',    N'Spain',       N'+34',  N'Calle Gran Vía'),
 (N'Rome',      N'Italy',       N'+39',  N'Via del Corso'),
 (N'Amsterdam', N'Netherlands', N'+31',  N'Damrak'),
 (N'Brussels',  N'Belgium',     N'+32',  N'Rue de la Loi'),
 (N'Stockholm', N'Sweden',      N'+46',  N'Drottninggatan'),
 (N'Oslo',      N'Norway',      N'+47',  N'Karl Johans gate'),
 (N'Copenhagen',N'Denmark',     N'+45',  N'Strøget'),
 (N'Helsinki',  N'Finland',     N'+358', N'Aleksanterinkatu'),
 (N'Dublin',    N'Ireland',     N'+353', N'Grafton Street'),
 (N'Zurich',    N'Switzerland', N'+41',  N'Bahnhofstrasse'),
 (N'Vienna',    N'Austria',     N'+43',  N'Ringstraße'),


 (N'Warsaw',    N'Poland',      N'+48',  N'ul. Marszałkowska'),
 (N'Prague',    N'Czech Rep.',  N'+420', N'Vaclavske namesti'),
 (N'Budapest',  N'Hungary',     N'+36',  N'Vaci utca'),
 (N'Athens',    N'Greece',      N'+30',  N'Ermou Street'),
 (N'Istanbul',  N'Turkey',      N'+90',  N'Istiklal Caddesi'),


 (N'New York',  N'USA',         N'+1',   N'5th Avenue'),
 (N'Toronto',   N'Canada',      N'+1',   N'Yonge Street'),
 (N'Mexico City',N'Mexico',     N'+52',  N'Paseo de la Reforma'),
 (N'Sao Paulo', N'Brazil',      N'+55',  N'Avenida Paulista'),
 (N'Buenos Aires',N'Argentina', N'+54',  N'Avenida 9 de Julio'),


 (N'Tokyo',     N'Japan',       N'+81',  N'Chuo-dori'),
 (N'Beijing',   N'China',       N'+86',  N'Wangfujing'),
 (N'Seoul',     N'South Korea', N'+82',  N'Gangnam-daero'),
 (N'Sydney',    N'Australia',   N'+61',  N'George Street');


DECLARE @Adj TABLE (val nvarchar(100));
INSERT INTO @Adj VALUES (N'Global'),(N'Eco'),(N'Smart'),(N'Best'),(N'Pro'),(N'Mega'),(N'Super'),(N'General'),(N'Rapid'),(N'Top'),(N'Prime'),(N'Solid'),(N'First'),(N'Blue'),(N'Red'),(N'Golden'),(N'Silver'),(N'Iron'),(N'Steel'),(N'Heavy'),(N'Light'),(N'Fast'),(N'Direct'),(N'Pacific'),(N'Atlantic'),(N'Universal'),(N'Royal'),(N'Advanced');

DECLARE @Noun TABLE (val nvarchar(100));
INSERT INTO @Noun VALUES (N'Supplies'),(N'Parts'),(N'Components'),(N'Trade'),(N'Import'),(N'Export'),(N'Logistics'),(N'Warehousing'),(N'Materials'),(N'Solutions'),(N'Systems'),(N'Technologies'),(N'Industries'),(N'Motors'),(N'Mechanics'),(N'Tools'),(N'Hardware'),(N'Equipments'),(N'Wholesale'),(N'Depot'),(N'Group'),(N'Holdings'),(N'Partners'),(N'Ventures'),(N'Works');

DECLARE @Suf TABLE (val nvarchar(100));
INSERT INTO @Suf VALUES (N'Sp. z o.o.'),(N'S.A.'),(N'GmbH'),(N'Inc.'),(N'LLC'),(N'Corp.'),(N'Ltd.'),(N'AB'),(N'NV'),(N'Oy');


;WITH Cnts AS (
  SELECT (SELECT COUNT(*) FROM @Adj)   AS cA,
         (SELECT COUNT(*) FROM @Noun)  AS cN,
         (SELECT COUNT(*) FROM @Suf)   AS cS,
         (SELECT COUNT(*) FROM @AddressBook) AS cAddr
),
Tally AS (
  SELECT TOP (@NS) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM sys.all_objects
),
A AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Adj),
N AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Noun),
S AS (SELECT val, ROW_NUMBER() OVER (ORDER BY val) AS idx FROM @Suf)

INSERT INTO dbo.Suppliers (CompanyName, Address, City, Country, PhoneNumber)
SELECT
  (SELECT a1.val FROM A a1 CROSS JOIN Cnts k WHERE a1.idx = ((t.rn*1)%k.cA)+1) + N' ' +
  (SELECT n1.val FROM N n1 CROSS JOIN Cnts k WHERE n1.idx = ((t.rn*2)%k.cN)+1) + N' ' +
  (SELECT s1.val FROM S s1 CROSS JOIN Cnts k WHERE s1.idx = ((t.rn*3)%k.cS)+1),

  Addr.StreetName + N' ' + CAST(((t.rn * 7) % 200) + 1 AS nvarchar(10)),
  Addr.City,
  Addr.Country,
  Addr.PhoneCode + RIGHT('000000000' + CAST(((t.rn * 982451653) % 1000000000) AS varchar(9)), 9)

FROM Tally t
CROSS JOIN Cnts k
INNER JOIN @AddressBook Addr ON Addr.ID = ((t.rn - 1) % k.cAddr) + 1;