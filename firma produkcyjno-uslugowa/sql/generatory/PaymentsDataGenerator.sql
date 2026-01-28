delete from Payments where PaymentID > -1000;

-- Obliczamy sumy dla każdego zamówienia i wstawiamy płatności
;WITH OrderSummary AS (
    -- Obliczamy całkowitą wartość brutto zamówienia (produkty + dostawa)

    SELECT
        o.OrderID,
        o.OrderDate,
        SUM(od.UnitPrice * od.Quantity) + o.DeliveryPrice AS TotalValue
    FROM dbo.Orders o
             JOIN dbo.OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.OrderID, o.OrderDate, o.DeliveryPrice
),
      PaymentRandomizer AS (
          SELECT
              OrderID,
              OrderDate,
              TotalValue,
              CASE
                  WHEN ABS(CHECKSUM(NEWID())) % 10 < 7 THEN 1.0
                  WHEN ABS(CHECKSUM(NEWID())) % 10 < 9 THEN (ABS(CHECKSUM(NEWID())) % 51 + 30) / 100.0
                  ELSE 0.0
                  END AS PaymentFactor,
              CASE
                  WHEN ABS(CHECKSUM(NEWID())) % 10 < 8 THEN 1
                  WHEN ABS(CHECKSUM(NEWID())) % 10 = 8 THEN 0
                  ELSE -1
                  END AS RandStatus,
              ISNULL(CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 5) + 1,
                     N'BLIK', N'Karta Kredytowa', N'Przelew', N'PayPal', N'Gotówka'), N'Przelew') AS RandMethod
          FROM OrderSummary
      )

 INSERT INTO dbo.Payments (OrderID, PaymentDate, Amount, STATUS, Method)
 SELECT
     OrderID,
     DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 2880 + 60, OrderDate),
     CAST(TotalValue * PaymentFactor AS INT),
RandStatus,
     ISNULL(CASE
                WHEN RandStatus = -1 AND ABS(CHECKSUM(NEWID()) % 5) = 0 THEN N'Nieznana'
                ELSE RandMethod
                END, N'Przelew Bankowy') AS Method
 FROM PaymentRandomizer
 WHERE TotalValue * PaymentFactor > 0 OR RandStatus = 0;
