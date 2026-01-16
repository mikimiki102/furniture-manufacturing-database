CREATE PROCEDURE dbo.AddPart
    @SupplierID INT,
    @PartName NVARCHAR(200),
    @Cost DECIMAL(10, 2)

AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO dbo.Parts(SupplierID, PartName, Cost)
        OUTPUT inserted.PartID
        VALUES (@SupplierID, @PartName, @Cost);
    end
GO

