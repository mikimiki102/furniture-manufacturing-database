CREATE OR ALTER VIEW dbo.v_OrderValue AS
SELECT
  od.OrderID,
  CAST(SUM(od.UnitPrice * od.Quantity) AS DECIMAL(18,2)) AS ItemsTotal,
  SUM(od.Quantity)                                       AS ItemsQuantity
FROM dbo.OrderDetails od
GROUP BY od.OrderID;
GO
