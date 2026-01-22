CREATE OR ALTER TRIGGER dbo.trg_InventoryProducts_AutoAddStock
    on dbo.InventoryProducts
    AFTER UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;

        IF NOT UPDATE(Quantity)
            RETURN;

        UPDATE ip
        SET ip.Quantity = ip.Quantity + 1 + (ip.MinQuantity * 3)
        FROM InventoryProducts as ip
        INNER JOIN inserted as i ON ip.ProductID = i.ProductID
        INNER JOIN deleted as d ON ip.ProductID = d.ProductID
        WHERE i.Quantity < i.MinQuantity
        AND i.Quantity < d.Quantity;
    end;
go