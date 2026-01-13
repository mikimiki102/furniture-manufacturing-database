CREATE   PROCEDURE dbo.ChangeProductData
  @ProductID       INT,
  @ProductName     NVARCHAR(200),
  @Price           DECIMAL(10,2),
  @ProductionTime  INT
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE dbo.Products
     SET ProductName = @ProductName,
         Price = @Price,
         ProductionTime = @ProductionTime
   WHERE ProductID = @ProductID;

END
go
