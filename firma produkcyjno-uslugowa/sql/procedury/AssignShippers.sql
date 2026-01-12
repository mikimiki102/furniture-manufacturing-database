CREATE   PROCEDURE dbo.AssignShippers
    @OrderID    INT,
    @ShippersID INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Orders
    SET ShippersID = @ShippersID
    WHERE OrderID = @OrderID;

END;
go

