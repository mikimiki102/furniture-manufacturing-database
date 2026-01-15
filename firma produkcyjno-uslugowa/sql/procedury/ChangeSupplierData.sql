CREATE PROCEDURE dbo.ChangeSupplierData
    @SupplierID INT,
    @CompanyName NVARCHAR(200),
    @Address NVARCHAR(200),
    @City NVARCHAR(200),
    @Country NVARCHAR(200),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Suppliers
    SET
        CompanyName = @CompanyName,
        Address = @Address,
        City = @City,
        Country = @Country,
        PhoneNumber = @PhoneNumber
    WHERE SupplierID = @SupplierID;
end
go