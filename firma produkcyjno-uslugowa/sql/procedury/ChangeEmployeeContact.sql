CREATE PROCEDURE dbo.ChangeEmployeeContact
    @EmployeeID INT,
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Employees
    SET PhoneNumber = @PhoneNumber
    WHERE EmployeeID = @EmployeeID;
end
go