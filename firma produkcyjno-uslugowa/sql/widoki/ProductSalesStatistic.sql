CREATE or ALTER VIEW dbo.v_ProductSalesStatistic AS
    SELECT
        p.ProductID,
        p.ProductName,
        p.Price as CurrentPrice,
        SUM(od.Quantity) as TotalSoldQuantity,
        SUM(od.Quantity * od.UnitPrice) as TotalRevenue,
        COUNT(DISTINCT o.OrderID) as NumberOfOrders,
        COUNT(Distinct o.CustomerID) as UniqueCustomers,
        MIN(o.OrderDate) as FirstSaleDate,
        MAX(o.OrderDate) as LastSaleDate,
        AVG(od.Quantity) as AverageQuantityPerOrder,
        CASE
            WHEN COUNT(o.OrderID) > 0
            THEN SUM(od.Quantity * od.UnitPrice) / COUNT(DISTINCT o.OrderID)
            ELSE 0
        END as AverageOrderValue

    FROM
        Products as p
    LEFT JOIN
            OrderDetails as od
            ON p.ProductID = od.ProductID
    LEFT JOIN
            Orders as o
            ON od.OrderID = o.OrderID
    GROUP BY p.ProductID, p.ProductName, p.Price
GO
