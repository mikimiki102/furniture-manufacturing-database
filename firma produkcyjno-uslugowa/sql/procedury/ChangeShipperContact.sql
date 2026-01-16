CREATE PROCEDURE dbo.ChangeShipperContact
    @ShipperID INT,
    @PhoneNumber NVARCHAR(20)

    AS
    BEGIN
        SET NOCOUNT ON;

        UPDATE dbo.Shippers
        SET
            PhoneNumber = @PhoneNumber
        WHERE ShipperID = @ShipperID
    end
go