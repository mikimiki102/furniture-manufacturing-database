
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderID = 1) OR
   NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderID = 500)
    THROW 56000, N'Orders nie zawiera pełnego zakresu 1..500.', 1;

IF NOT EXISTS (SELECT 1 FROM dbo.Products)
    THROW 56001, N'Brak danych w dbo.Products.', 1;

DELETE FROM dbo.OrderDetails
WHERE OrderID BETWEEN 1 AND 500;

;WITH
Nums AS (
    SELECT TOP (500) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS OrderID
    FROM sys.all_objects
),
O AS (
    SELECT n.OrderID
    FROM Nums n
    JOIN dbo.Orders o ON o.OrderID = n.OrderID
),
P AS (
    SELECT
        p.ProductID,
        CAST(p.Price AS decimal(10,2)) AS Price,
        ROW_NUMBER() OVER (ORDER BY p.ProductID) AS rn
    FROM dbo.Products p
),
PC AS (SELECT COUNT(*) AS c FROM P),

Lines AS (
    SELECT
        o.OrderID,
        CASE (ABS(CHECKSUM(o.OrderID, 'L')) % 100)
            WHEN 0 THEN 4 WHEN 1 THEN 4 WHEN 2 THEN 4 WHEN 3 THEN 4 WHEN 4 THEN 4
            WHEN 5 THEN 3 WHEN 6 THEN 3 WHEN 7 THEN 3 WHEN 8 THEN 3 WHEN 9 THEN 3
            WHEN 10 THEN 3 WHEN 11 THEN 3 WHEN 12 THEN 3 WHEN 13 THEN 3 WHEN 14 THEN 3
            WHEN 15 THEN 3 WHEN 16 THEN 3 WHEN 17 THEN 3 WHEN 18 THEN 3 WHEN 19 THEN 3
            WHEN 20 THEN 2 WHEN 21 THEN 2 WHEN 22 THEN 2 WHEN 23 THEN 2 WHEN 24 THEN 2
            WHEN 25 THEN 2 WHEN 26 THEN 2 WHEN 27 THEN 2 WHEN 28 THEN 2 WHEN 29 THEN 2
            WHEN 30 THEN 2 WHEN 31 THEN 2 WHEN 32 THEN 2 WHEN 33 THEN 2 WHEN 34 THEN 2
            WHEN 35 THEN 2 WHEN 36 THEN 2 WHEN 37 THEN 2 WHEN 38 THEN 2 WHEN 39 THEN 2
            WHEN 40 THEN 2 WHEN 41 THEN 2 WHEN 42 THEN 2 WHEN 43 THEN 2 WHEN 44 THEN 2
            WHEN 45 THEN 2 WHEN 46 THEN 2 WHEN 47 THEN 2 WHEN 48 THEN 2 WHEN 49 THEN 2
            WHEN 50 THEN 2 WHEN 51 THEN 2 WHEN 52 THEN 2 WHEN 53 THEN 2 WHEN 54 THEN 2
            ELSE 1
        END AS cnt
    FROM O o
),

Slots AS (
    SELECT OrderID, 1 AS slot FROM Lines
    UNION ALL SELECT OrderID, 2 FROM Lines WHERE cnt >= 2
    UNION ALL SELECT OrderID, 3 FROM Lines WHERE cnt >= 3
    UNION ALL SELECT OrderID, 4 FROM Lines WHERE cnt >= 4
),

Picked AS (
    SELECT
        s.OrderID,
        s.slot,
        pPick.ProductID,
        pPick.Price AS UnitPrice,
        1 + (ABS(CHECKSUM(NEWID())) % 10) AS Quantity  
    FROM Slots s
    CROSS JOIN PC k
    CROSS APPLY (
        SELECT p.ProductID, p.Price
        FROM P p
        WHERE p.rn =
          (ABS(CHECKSUM(s.OrderID, (s.slot * 104729) + 9973, 'PID')) % NULLIF(k.c,0)) + 1
    ) pPick
),

Dedup AS (
    SELECT
        OrderID, ProductID, UnitPrice, Quantity,
        ROW_NUMBER() OVER (PARTITION BY OrderID, ProductID ORDER BY slot) AS dup_no
    FROM Picked
)

INSERT INTO dbo.OrderDetails (OrderID, ProductID, UnitPrice, Quantity)
SELECT OrderID, ProductID, UnitPrice, Quantity
FROM Dedup
WHERE dup_no = 1
ORDER BY OrderID, ProductID;

SELECT
  MIN(OrderID) AS MinOrderID,
  MAX(OrderID) AS MaxOrderID,
  COUNT(DISTINCT OrderID) AS DistinctOrdersInDetails,
  COUNT(*) AS TotalDetailsRows
FROM dbo.OrderDetails;

;WITH Nums AS (
    SELECT TOP (500) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS OrderID
    FROM sys.all_objects
)
SELECT n.OrderID
FROM Nums n
LEFT JOIN dbo.OrderDetails od ON od.OrderID = n.OrderID
WHERE od.OrderID IS NULL
ORDER BY n.OrderID;

SELECT TOP 20 od.OrderID, od.ProductID, od.UnitPrice, p.Price AS ProductPrice
FROM dbo.OrderDetails od
JOIN dbo.Products p ON p.ProductID = od.ProductID
WHERE od.UnitPrice <> p.Price;

SELECT Quantity, COUNT(*) AS c
FROM dbo.OrderDetails
GROUP BY Quantity
ORDER BY Quantity;


