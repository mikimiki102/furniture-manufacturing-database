CREATE   PROCEDURE dbo.ChangeOrderData
    @OrderID      INT,
    @DeliveryDate DATETIME = NULL,
    @Address      NVARCHAR(200) = NULL,
    @Country      NVARCHAR(100) = NULL,
    @City         NVARCHAR(100) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        UPDATE dbo.Orders
        SET
            DeliveryDate = COALESCE(@DeliveryDate, DeliveryDate),
            Address = COALESCE(@Address, Address),
            Country = COALESCE(@Country, Country),
            City = COALESCE(@City, City)
        WHERE OrderID = @OrderID;
    END;
go
