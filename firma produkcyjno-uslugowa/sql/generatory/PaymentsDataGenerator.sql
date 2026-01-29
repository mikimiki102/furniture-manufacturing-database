DELETE FROM dbo.Payments
WHERE OrderID BETWEEN 1 AND 500;

;WITH totals AS (
  SELECT
    o.OrderID,
    CONVERT(date, o.OrderDate) AS PaymentDate,
    o.Status AS OrderStatus,
    CAST(ROUND(COALESCE(SUM(od.UnitPrice*od.Quantity),0) + COALESCE(o.DeliveryPrice,0), 2) * 100 AS bigint) AS TotalCents
  FROM dbo.Orders o
  LEFT JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
  WHERE o.OrderID BETWEEN 1 AND 500
  GROUP BY o.OrderID, o.OrderDate, o.Status, o.DeliveryPrice
),
final AS (
  SELECT
    t.OrderID,
    t.PaymentDate,
    t.TotalCents,
    CAST(
      CASE
        WHEN t.OrderStatus IN (3,4) THEN t.TotalCents                           
        WHEN t.OrderStatus = 1 THEN 0                                          
        WHEN t.OrderStatus = 2 THEN                                            
          CASE
            WHEN t.TotalCents <= 0 THEN 0
            ELSE (t.TotalCents * (10 + (ABS(CHECKSUM(t.OrderID,'PF')) % 81))) / 100
          END
        ELSE 0
      END
    AS bigint) AS PaidCents,
    CHOOSE(((ABS(CHECKSUM(t.OrderID,'M')) % 5) + 1),
           N'BLIK', N'Przelew', N'PayPal', N'Karta', N'Gotówka') AS Method
  FROM totals t
)
INSERT INTO dbo.Payments (OrderID, PaymentDate, Amount, STATUS, Method)
SELECT
  OrderID,
  PaymentDate,
  CAST(PaidCents / 100.0 AS decimal(10,2)) AS Amount,
  0 AS STATUS, 
  Method
FROM final
ORDER BY OrderID;
