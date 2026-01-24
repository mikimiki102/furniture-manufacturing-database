CREATE OR ALTER VIEW dbo.v_OrderSchedule AS
SELECT
    o.OrderID,
    o.OrderDate,
    s.CompanyName AS ShipperName,
    oe.PredictedOrderDelivery,
    o.DeliveryDate AS ActualDeliveryDate,


    CASE
        WHEN o.DeliveryDate IS NOT NULL
        THEN DATEDIFF(DAY, oe.PredictedOrderDelivery, o.DeliveryDate)
    END AS DelayDays,


    CASE
        WHEN o.DeliveryDate IS NULL AND oe.PredictedOrderDelivery < GETDATE()
            THEN 'Opóźnione (w trakcie)'
        WHEN o.DeliveryDate IS NULL AND oe.PredictedOrderDelivery >= GETDATE()
            THEN 'W trakcie (na czas)'
        WHEN o.DeliveryDate IS NOT NULL AND o.DeliveryDate <= oe.PredictedOrderDelivery
            THEN 'Dostarczone na czas'
        WHEN oe.PredictedOrderDelivery IS NULL THEN 'Brak planu'
        ELSE 'Dostarczone z opóźnieniem'
    END AS DeliveryStatus,

    o.City,
    o.Country,
    c.Name AS CustomerName

FROM dbo.Orders o
INNER JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN dbo.OrderExecution oe ON o.OrderID = oe.OrderID
LEFT JOIN dbo.Shippers s ON o.ShippersID = s.ShipperID;
GO