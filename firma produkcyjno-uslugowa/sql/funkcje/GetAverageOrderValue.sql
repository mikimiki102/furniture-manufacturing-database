CREATE FUNCTION dbo.fn_GetAverageOrderValue()
RETURNS DECIMAL(10, 2)
AS
    BEGIN
        DECLARE @AvgValue DECIMAL(10, 2);

        SELECT @AvgValue = AVG(OrderValue)
        FROM (
            SELECT SUM(od.Quantity * od.UnitPrice) + o.DeliveryPrice as OrderValue
            FROM dbo.Orders as o
            JOIN dbo.OrderDetails as od ON o.OrderID = od.OrderID
            WHERE o.Status = 4
            GROUP BY o.OrderID, o.DeliveryPrice
             ) as OrdersSubquery;

        RETURN ISNULL(@AvgValue, 0);
    end;