CREATE PROCEDURE dbo.AddOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice DECIMAL(10,2),
    @Quantity INT
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO dbo.OrderDetails (OrderID, ProductID, UnitPrice, Quantity)
        VALUES(@OrderID, @ProductID, @UnitPrice, @Quantity);
    end
go