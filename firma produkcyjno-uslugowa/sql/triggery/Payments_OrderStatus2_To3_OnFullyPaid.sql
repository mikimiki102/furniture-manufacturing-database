CREATE OR ALTER TRIGGER dbo.trg_Payments_OrderStatus2_To3_OnFullyPaid
ON dbo.Payments
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH changed_orders AS (
        SELECT OrderID FROM inserted
        UNION
        SELECT OrderID FROM deleted
    ),
    totals AS (
        SELECT
            o.OrderID,
            o.Status AS OrderStatus,
            CAST(ROUND(COALESCE(SUM(od.UnitPrice*od.Quantity),0) + COALESCE(o.DeliveryPrice,0), 2) * 100 AS bigint) AS TotalCents
        FROM dbo.Orders o
        LEFT JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
        WHERE o.OrderID IN (SELECT OrderID FROM changed_orders)
        GROUP BY o.OrderID, o.Status, o.DeliveryPrice
    ),
    paid AS (
        SELECT
            p.OrderID,
            CAST(ROUND(COALESCE(SUM(p.Amount),0), 2) * 100 AS bigint) AS PaidCents
        FROM dbo.Payments p
        WHERE p.OrderID IN (SELECT OrderID FROM changed_orders)
        GROUP BY p.OrderID
    )
    UPDATE o
    SET o.Status = 3
    FROM dbo.Orders o
    JOIN totals t ON t.OrderID = o.OrderID
    JOIN paid   p ON p.OrderID = o.OrderID
    WHERE t.OrderStatus = 2
      AND t.TotalCents > 0
      AND p.PaidCents >= t.TotalCents;
END;
GO
