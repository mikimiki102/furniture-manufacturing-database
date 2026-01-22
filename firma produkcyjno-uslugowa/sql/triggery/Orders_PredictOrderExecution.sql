CREATE OR ALTER TRIGGER dbo.trg_Orders_PredictOrderExecution
ON dbo.Orders
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  ;WITH changed AS (
    SELECT i.OrderID, i.Status, d.Status AS OldStatus
    FROM inserted i
    LEFT JOIN deleted d ON d.OrderID = i.OrderID
    WHERE i.Status = 3
      AND (d.OrderID IS NULL OR ISNULL(d.Status, -1) <> 3)
  ),
  agg AS (
    SELECT
      c.OrderID,
      COALESCE(MAX(p.ProductionTime), 0) + 2 AS ExecDays
    FROM changed c
    LEFT JOIN dbo.OrderDetails oi ON oi.OrderID = c.OrderID
    LEFT JOIN dbo.Products p ON p.ProductID = oi.ProductID
    GROUP BY c.OrderID
  ),
  vals AS (
    SELECT
      a.OrderID,
      DATEADD(DAY, a.ExecDays, GETDATE()) AS PredictedOrderDelivery
    FROM agg a
  )
  MERGE dbo.OrderExecution AS tgt
  USING vals AS src
     ON tgt.OrderID = src.OrderID
  WHEN MATCHED THEN
    UPDATE SET PredictedOrderDelivery = src.PredictedOrderDelivery
  WHEN NOT MATCHED THEN
    INSERT (OrderID, PredictedOrderDelivery)
    VALUES (src.OrderID, src.PredictedOrderDelivery);
END;
GO
