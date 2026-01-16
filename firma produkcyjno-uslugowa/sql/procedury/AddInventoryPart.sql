CREATE PROCEDURE dbo.AddInventoryPart
    @PartID INT,
    @Quantity INT,
    @MinQuantity INT

    AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO dbo.InventoryParts(PartID, Quantity, MinQuantity)
        VALUES (@PartID, @Quantity, @MinQuantity);
    end
go