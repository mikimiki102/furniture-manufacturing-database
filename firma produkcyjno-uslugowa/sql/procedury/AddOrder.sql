CREATE PROCEDURE dbo.AddOrder
    @CustomerID INT,
    @EmployeeID INT,
    @ShipperID INT,
    @OrderDate DATETIME,
    @DeliveryDate DATETIME = NULL,
    @Address NVARCHAR(200),
    @Country NVARCHAR(100),
    @City NVARCHAR(100)
AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO dbo.Orders
        (CustomerID, EmployeeID, ShippersID, OrderDate, DeliveryDate, Address, Country, City)
        VALUES
        (@CustomerID,@EmployeeID, @ShipperID, @OrderDate,
         @DeliveryDate, @Address, @Country, @City);

        SELECT CAST(SCOPE_IDENTITY() AS INT) AS OrderID;
    END;
go
