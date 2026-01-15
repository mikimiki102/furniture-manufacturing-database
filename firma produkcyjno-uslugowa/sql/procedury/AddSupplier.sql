CREATE PROCEDURE dbo.AddSupplier
    @CompanyName NVARCHAR(200),
    @Address NVARCHAR(200),
    @City NVARCHAR(200),
    @Country NVARCHAR(200),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Suppliers (CompanyName, Address, City, Country, PhoneNumber)
    OUTPUT inserted.SupplierID
    VALUES (@CompanyName, @Address, @City, @Country, @PhoneNumber);
end
GO