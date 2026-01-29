CREATE OR ALTER PROCEDURE dbo.AddPayment
    @OrderID INT,
    @Amount DECIMAL(10,2),
    @STATUS INT,
    @Method NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @out TABLE (PaymentID INT);

    INSERT INTO dbo.Payments (OrderID, PaymentDate, Amount, STATUS, Method)
    OUTPUT inserted.PaymentID INTO @out(PaymentID)
    VALUES (@OrderID, GETDATE(), @Amount, @STATUS, @Method);

    SELECT PaymentID FROM @out;
END
GO
