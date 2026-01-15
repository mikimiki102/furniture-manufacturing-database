CREATE PROCEDURE dbo.ChangeIsActiveEmployee
    @EmployeeID INT,
    @isActive BIT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Employees
    SET isActive = @isActive
    WHERE EmployeeID = @EmployeeID;
end
go