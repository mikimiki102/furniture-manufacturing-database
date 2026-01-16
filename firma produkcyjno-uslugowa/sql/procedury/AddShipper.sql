CREATE PROCEDURE dbo.AddShipper
    @CompanyName NVARCHAR(200),
    @PhoneNumber NVARCHAR(20),
    @isActive BIT

AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO dbo.Shippers(CompanyName, PhoneNumber, isActive)
        OUTPUT inserted.ShipperID
        VALUES (@CompanyName, @PhoneNumber, @isActive);
    end
go