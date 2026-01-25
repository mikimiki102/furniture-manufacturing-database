DELETE FROM dbo.InventoryParts;

;WITH P AS (
    SELECT PartID,
           ROW_NUMBER() OVER (ORDER BY PartID) AS rn
    FROM dbo.Parts
)
INSERT INTO dbo.InventoryParts (PartID, Quantity, MinQuantity)
SELECT
    PartID,
    MinQ + 1 + (ABS(CHECKSUM(NEWID(), rn, 'q')) % 500) AS Quantity,
    MinQ AS MinQuantity
FROM (
    SELECT
        PartID,
        rn,
        ABS(CHECKSUM(NEWID(), rn, 'min')) % 50 AS MinQ
    FROM P
) x;
