CREATE FUNCTION dbo.fn_GetProductRevenue (@ProductID INT)
RETURNS DECIMAL(10, 2)
AS
    BEGIN
        DECLARE @TotalRevenue DECIMAL(10, 2);
        SELECT @TotalRevenue = SUM(Quantity * UnitPrice)
        FROM dbo.OrderDetails as od
        JOIN dbo.Orders as o ON od.OrderID = o.OrderID
        WHERE od.ProductID = @ProductID
            AND o.Status = 4
        RETURN ISNULL(@TotalRevenue, 0);
    end;
