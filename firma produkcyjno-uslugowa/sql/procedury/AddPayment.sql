CREATE PROCEDURE dbo.AddPayment
    @OrderID INT,
    @Amount INT,
    @STATUS INT,
    @Method NVARCHAR(50)

    AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO dbo.Payments(OrderID, PaymentDate, Amount, STATUS, Method)
        OUTPUT inserted.PaymentID
        VALUES (@OrderID, GETDATE(), @Amount, @STATUS, @Method)


    end
go

