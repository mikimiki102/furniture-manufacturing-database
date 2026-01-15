CREATE PROCEDURE dbo.ChangeSupplierContact
    @SupplierID INT,
    @PhoneNumber NVARCHAR(20)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE dbo.Suppliers
        SET PhoneNumber = @PhoneNumber
        WHERE SupplierID = @SupplierID;
    end
go