CREATE OR ALTER TRIGGER dbo.trg_OrdersBlockInactiveShippers
ON dbo.Orders
    AFTER INSERT, UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @InactiveShipperID INT;
        DECLARE @ErrorMessage NVARCHAR(100);

        SELECT TOP 1 @InactiveShipperID = s.ShipperID
        FROM inserted as i
        JOIN Shippers as s
        ON i.ShippersID = s.ShipperID
        WHERE s.isActive = 0 AND i.ShippersID IS NOT NULL;

        IF @InactiveShipperID IS NOT NULL
        BEGIN
            SET @ErrorMessage = CONCAT('Nie można przypisać nieaktywnego dostawcy (ID: ',
                                       CAST(@InactiveShipperID AS NVARCHAR(10)),
                                       ') do zamówienia.');
            THROW 50001, @ErrorMessage, 1;
        end
    end;
GO