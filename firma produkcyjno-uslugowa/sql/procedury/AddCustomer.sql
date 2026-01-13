CREATE   PROCEDURE dbo.AddCustomer
  @Name         NVARCHAR(100),
  @Address      NVARCHAR(200),
  @PhoneNumber  NVARCHAR(30)
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO dbo.Customers (Name, Address, PhoneNumber)
  OUTPUT INSERTED.CustomerID
  VALUES (@Name, @Address, @PhoneNumber);
END
go

