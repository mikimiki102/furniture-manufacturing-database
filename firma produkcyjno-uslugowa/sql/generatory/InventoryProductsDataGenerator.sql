DELETE FROM dbo.InventoryProducts;

;WITH P AS (
    SELECT ProductID,
           ROW_NUMBER() OVER (ORDER BY ProductID) AS rn
    FROM dbo.Products
)
INSERT INTO dbo.InventoryProducts (ProductID, Quantity, MinQuantity)
SELECT
    ProductID,
    MinQ + 1 + (ABS(CHECKSUM(NEWID(), rn, 'q')) % 500) AS Quantity,
    MinQ AS MinQuantity
FROM (
    SELECT
        ProductID,
        rn,
        ABS(CHECKSUM(NEWID(), rn, 'min')) % 50 AS MinQ
    FROM P
) x;
