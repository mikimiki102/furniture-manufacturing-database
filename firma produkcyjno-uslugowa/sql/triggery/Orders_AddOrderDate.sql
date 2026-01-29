CREATE OR ALTER TRIGGER dbo.trg_AddOrderDate
ON dbo.Payments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT UPDATE(Status)
        RETURN;

    UPDATE o
    SET o.OrderDate = GETDATE()
    FROM dbo.Orders o
    JOIN inserted i ON i.OrderID = o.OrderID
    JOIN deleted  d ON d.PaymentID = i.PaymentID
    WHERE i.Status = 1
      AND d.Status <> 1;
END
GO
