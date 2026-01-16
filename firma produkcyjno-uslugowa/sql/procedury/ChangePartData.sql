CREATE PROCEDURE dbo.ChangePartData
    @PartID INT,
    @PartName NVARCHAR(200),
    @Cost DECIMAL(10, 2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Parts
    SET
        PartName = @PartName,
        Cost = @Cost
    WHERE PartID = @PartID;
end
go
