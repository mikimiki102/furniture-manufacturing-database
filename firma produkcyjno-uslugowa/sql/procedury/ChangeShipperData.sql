CREATE PROCEDURE dbo.ChangeShipperData
    @ShipperID INT,
    @CompanyName NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Shippers
    SET
        CompanyName = @CompanyName
    WHERE ShipperID = @ShipperID;
end
go

