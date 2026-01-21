CREATE FUNCTION dbo.fn_LeastBoughtProducts (@Count INT)
RETURNS TABLE
as
RETURN (
    SELECT TOP (@Count)
        p.ProductName,
        ISNULL(SUM(od.Quantity), 0) AS TotalQuantitySold
    FROM dbo.Products AS p
    LEFT JOIN (
        SELECT od.ProductID, od.Quantity
        FROM dbo.OrderDetails as od
        INNER JOIN dbo.Orders as o
            ON od.OrderID = o.OrderID
        WHERE o.Status = 4
    ) as od ON p.ProductID = od.ProductID
    GROUP BY p.ProductName
    ORDER BY TotalQuantitySold ASC, p.ProductName ASC

    );