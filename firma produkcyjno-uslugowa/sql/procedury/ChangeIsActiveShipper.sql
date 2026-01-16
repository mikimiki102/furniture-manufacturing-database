CREATE PROCEDURE dbo.ChangeIsActiveShipper
    @ShipperID INT,
    @isActive BIT
    AS
    BEGIN
        SET NOCOUNT ON;

        UPDATE dbo.Shippers
        SET
            isActive = @isActive
        WHERE ShipperID = @ShipperID
    end
go