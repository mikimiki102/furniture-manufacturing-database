CREATE OR ALTER TRIGGER dbo.trg_Orders_InventoryDecrement
ON dbo.Orders
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @changed TABLE (OrderID INT PRIMARY KEY);

  INSERT INTO @changed(OrderID)
  SELECT i.OrderID
  FROM inserted i
  LEFT JOIN deleted d ON d.OrderID = i.OrderID
  WHERE i.Status = 3
    AND (d.OrderID IS NULL OR d.Status <> 3);

  IF NOT EXISTS (SELECT 1 FROM @changed)
    RETURN;

  DECLARE @req TABLE (ProductID INT PRIMARY KEY, ReqQty INT NOT NULL);

  INSERT INTO @req(ProductID, ReqQty)
  SELECT od.ProductID,
         SUM(od.Quantity) AS ReqQty
  FROM dbo.OrderDetails od
  JOIN @changed c ON c.OrderID = od.OrderID
  GROUP BY od.ProductID;

  IF EXISTS (
      SELECT 1
      FROM @req r
      LEFT JOIN dbo.InventoryProducts ip ON ip.ProductID = r.ProductID
      WHERE ip.ProductID IS NULL
  )
  BEGIN
    THROW 51001, N'Brak pozycji w magazynie (InventoryProducts) dla co najmniej jednego produktu z zamówienia.', 1;
  END;

  IF EXISTS (
      SELECT 1
      FROM @req r
      JOIN dbo.InventoryProducts ip ON ip.ProductID = r.ProductID
      WHERE ip.Quantity < r.ReqQty
  )
  BEGIN
    THROW 51002, N'Niewystarczający stan magazynowy (InventoryProducts) dla co najmniej jednego produktu z zamówienia.', 1;
  END;

  UPDATE ip
     SET ip.Quantity = ip.Quantity - r.ReqQty
  FROM dbo.InventoryProducts ip
  JOIN @req r ON r.ProductID = ip.ProductID;
END
GO

