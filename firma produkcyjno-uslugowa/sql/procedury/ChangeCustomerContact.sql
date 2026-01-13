CREATE   PROCEDURE dbo.ChangeCustomerContact
  @CustomerID   INT,
  @PhoneNumber  NVARCHAR(30)
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE dbo.Customers
     SET PhoneNumber = @PhoneNumber
   WHERE CustomerID = @CustomerID;

END
go
