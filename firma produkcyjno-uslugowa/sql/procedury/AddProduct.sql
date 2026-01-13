CREATE   PROCEDURE dbo.AddProduct
  @ProductName     NVARCHAR(200),
  @Price           DECIMAL(10,2),
  @ProductionTime  INT
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO dbo.Products (ProductName, Price, ProductionTime)
  VALUES (@ProductName, @Price, @ProductionTime);

END
go

