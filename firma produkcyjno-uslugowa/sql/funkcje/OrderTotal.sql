CREATE OR ALTER FUNCTION dbo.fn_OrderTotal (@OrderID INT)
RETURNS DECIMAL(12,2)
AS
BEGIN
  DECLARE @Total DECIMAL(12,2);
  SELECT
    @Total = CAST(ISNULL(SUM(od.UnitPrice * od.Quantity), 0) AS DECIMAL(12, 2))
  FROM dbo.Orders o
  LEFT JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
  WHERE o.OrderID = @OrderID;

  RETURN ISNULL(@Total, 0);
END
