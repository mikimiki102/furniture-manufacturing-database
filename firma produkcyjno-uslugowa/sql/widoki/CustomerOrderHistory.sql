CREATE OR ALTER VIEW dbo.v_CustomerOrderHistory AS
    SELECT
        c.CustomerID,
        c.Name as CustomerName,
        o.OrderID,
        o.OrderDate,
        o.DeliveryDate,
        o.Status as OrderStatus,
        o.Address as DeliveryAddress,
        o.City as DeliveryCity,
        o.Country,
        p.ProductName,
        od.UnitPrice,
        od.Quantity,
        (od.UnitPrice * od.Quantity) AS ItemTotal

    FROM Customers as c
    INNER JOIN Orders as o
        ON c.CustomerID = o.CustomerID
    INNER JOIN OrderDetails as od
                ON o.OrderID = od.OrderID
    INNER JOIN Products as p
                ON od.ProductID = p.ProductID;

GO