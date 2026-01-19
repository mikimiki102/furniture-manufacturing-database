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

  DECLARE @req TABLE (PartID INT PRIMARY KEY, ReqQty INT NOT NULL);

  INSERT INTO @req(PartID, ReqQty)
  SELECT od.ProductID AS PartID,
         SUM(od.Quantity) AS ReqQty
  FROM dbo.OrderDetails od
  JOIN @changed c ON c.OrderID = od.OrderID
  GROUP BY od.ProductID;

  IF EXISTS (
      SELECT 1
      FROM @req r
      LEFT JOIN dbo.InventoryParts ip ON ip.PartID = r.PartID
      WHERE ip.PartID IS NULL
  )
  BEGIN
    THROW 51001, N'Brak pozycji w magazynie dla co najmniej jednego produktu.', 1;
  END;

  IF EXISTS (
      SELECT 1
      FROM @req r
      JOIN dbo.InventoryParts ip ON ip.PartID = r.PartID
      WHERE ip.Quantity < r.ReqQty
  )
  BEGIN
    THROW 51002, N'Niewystarczający stan magazynowy dla co najmniej jednego produktu.', 1;
  END;

  UPDATE ip
     SET ip.Quantity = ip.Quantity - r.ReqQty
  FROM dbo.InventoryParts ip
  JOIN @req r ON r.PartID = ip.PartID;
END;
GO
