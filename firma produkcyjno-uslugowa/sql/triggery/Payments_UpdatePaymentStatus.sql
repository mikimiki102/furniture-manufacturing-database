CREATE OR ALTER TRIGGER dbo.trg_Payments_UpdatePaymentStatus
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
    order_totals AS (
        SELECT
            o.OrderID,
            CAST(
                ROUND(
                    COALESCE(SUM(od.UnitPrice * od.Quantity), 0)
                    + COALESCE(o.DeliveryPrice, 0),
                2) * 100
            AS bigint) AS TotalCents
        FROM dbo.Orders o
        LEFT JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
        WHERE o.OrderID IN (SELECT OrderID FROM changed_orders)
        GROUP BY o.OrderID, o.DeliveryPrice
    ),
    paid_totals AS (
        SELECT
            p.OrderID,
            CAST(ROUND(COALESCE(SUM(p.Amount), 0), 2) * 100 AS bigint) AS PaidCents
        FROM dbo.Payments p
        WHERE p.OrderID IN (SELECT OrderID FROM changed_orders)
        GROUP BY p.OrderID
    ),
    combined AS (
        SELECT
            ot.OrderID,
            ot.TotalCents,
            ISNULL(pt.PaidCents, 0) AS PaidCents
        FROM order_totals ot
        LEFT JOIN paid_totals pt ON pt.OrderID = ot.OrderID
    )

    UPDATE p
    SET p.STATUS =
        CASE
            WHEN c.TotalCents > 0 AND c.PaidCents >= c.TotalCents THEN 1
            ELSE 0
        END
    FROM dbo.Payments p
    JOIN combined c ON c.OrderID = p.OrderID
    WHERE p.OrderID IN (SELECT OrderID FROM changed_orders);
END;
GO
