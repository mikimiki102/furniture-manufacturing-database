CREATE   PROCEDURE dbo.ChangeCustomerData
  @CustomerID   INT,
  @Name         NVARCHAR(100),
  @Address      NVARCHAR(200)
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE dbo.Customers
     SET Name = @Name,
         Address = @Address
   WHERE CustomerID = @CustomerID;

END
go
