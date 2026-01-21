CREATE FUNCTION dbo.fn_EmployeesWithMostOrders()
RETURNS TABLE
AS
RETURN (
    SELECT TOP 1 WITH TIES
        e.EmployeeID,
        e.Name,
        e.Address,
        e.PhoneNumber,
        e.isActive,
        COUNT(o.OrderID) as TotalOrdersHandled
    FROM dbo.Employees as e
    INNER JOIN dbo.Orders as o ON e.EmployeeID = o.EmployeeID
        AND o.Status in (3, 4)
    GROUP BY
        e.EmployeeID,
        e.Name,
        e.Address,
        e.PhoneNumber,
        e.isActive
    ORDER BY TotalOrdersHandled DESC, e.Name ASC
    );