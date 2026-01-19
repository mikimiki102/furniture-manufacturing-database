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
    SELECT od.OrderID,
           SUM(od.UnitPrice * od.Quantity) AS TotalAmount
    FROM dbo.OrderDetails od
    WHERE od.OrderID IN (SELECT OrderID FROM changed_orders)
    GROUP BY od.OrderID
  ),
  paid_totals AS (
    SELECT p.OrderID,
           SUM(p.Amount) AS PaidAmount
    FROM dbo.Payments p
    WHERE p.OrderID IN (SELECT OrderID FROM changed_orders)
    GROUP BY p.OrderID
  ),
  combined AS (
    SELECT co.OrderID,
           ISNULL(pt.PaidAmount, 0)   AS PaidAmount,
           ISNULL(ot.TotalAmount, 0)  AS TotalAmount
    FROM (SELECT DISTINCT OrderID FROM changed_orders) co
    LEFT JOIN order_totals ot ON ot.OrderID = co.OrderID
    LEFT JOIN paid_totals pt ON pt.OrderID = co.OrderID
  )
  UPDATE o
     SET o.Status =
         CASE WHEN c.TotalAmount > 0 AND c.PaidAmount >= c.TotalAmount
              THEN 1 ELSE 0 END
  FROM dbo.Orders o
  JOIN combined c ON c.OrderID = o.OrderID;
END;
GO
