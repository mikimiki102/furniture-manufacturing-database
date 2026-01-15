CREATE PROCEDURE dbo.ChangeEmployeeData
    @EmployeeID INT,
    @Name NVARCHAR(200),
    @Address NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Employees
    SET
        Name = @Name,
        Adddress = @Address
    WHERE EmployeeID = @EmployeeID;
end
go