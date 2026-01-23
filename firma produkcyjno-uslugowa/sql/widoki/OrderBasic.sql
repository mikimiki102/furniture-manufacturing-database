CREATE OR ALTER VIEW dbo.v_OrderBasic AS
SELECT
  o.OrderID,
  c.Name        AS CustomerName,
  s.CompanyName AS ShipperName,
  o.OrderDate
FROM dbo.Orders o
JOIN dbo.Customers c ON c.CustomerID = o.CustomerID
LEFT JOIN dbo.Shippers s ON s.ShipperID = o.ShippersID;
GO
