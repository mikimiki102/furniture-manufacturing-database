CREATE OR ALTER FUNCTION dbo.fn_OrderCount_ByCustomerID (@CustomerID INT)
RETURNS INT
AS
BEGIN
  DECLARE @cnt INT;
  SELECT @cnt = COUNT(*)
  FROM dbo.Orders
  WHERE CustomerID = @CustomerID;

  RETURN ISNULL(@cnt, 0);
END

