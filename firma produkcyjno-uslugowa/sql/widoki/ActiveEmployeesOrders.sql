CREATE OR ALTER VIEW dbo.v_ActiveEmployeesOrders AS
SELECT
  e.EmployeeID,
  e.Name           AS EmployeeName,
  COUNT(o.OrderID) AS ActiveOrdersCount
FROM dbo.Employees e
LEFT JOIN dbo.Orders o
  ON o.EmployeeID = e.EmployeeID
 AND o.Status = 3
WHERE e.IsActive = 1
GROUP BY e.EmployeeID, e.Name;
GO
