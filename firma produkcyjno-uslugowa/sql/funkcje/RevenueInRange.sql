CREATE OR ALTER FUNCTION dbo.fn_RevenueInRange
(
  @From DATETIME,
  @To   DATETIME
)
RETURNS DECIMAL(12,2)
AS
BEGIN
  DECLARE @rev DECIMAL(12,2);

  SELECT @rev = CAST(SUM(ISNULL(t.ItemsTotal,0)) AS DECIMAL(12,2))
  FROM dbo.Orders o
  OUTER APPLY (
    SELECT SUM(od.UnitPrice * od.Quantity) AS ItemsTotal
    FROM dbo.OrderDetails od
    WHERE od.OrderID = o.OrderID
  ) t
  WHERE o.OrderDate >= @From
    AND o.OrderDate <  DATEADD(DAY, 1, @To);

  RETURN ISNULL(@rev, 0);
END
