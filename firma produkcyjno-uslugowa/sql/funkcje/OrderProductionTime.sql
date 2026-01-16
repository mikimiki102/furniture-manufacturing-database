CREATE OR ALTER FUNCTION dbo.fn_OrderProductionTimeScalar (@OrderID INT)
RETURNS INT
AS
BEGIN
  DECLARE @t INT;
  SELECT @t = ISNULL(MAX(p.ProductionTime), 0) + 2
  FROM dbo.OrderDetails od
  JOIN dbo.Products p ON p.ProductID = od.ProductID
  WHERE od.OrderID = @OrderID;
  RETURN @t;
END
