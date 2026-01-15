CREATE PROCEDURE dbo.AddInventoryProduct
    @ProductID INT,
    @Quantity INT
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO dbo.InventoryProducts (ProductID, Quantity)
        VALUES (@ProductID, @Quantity);
    end
go