CREATE PROCEDURE dbo.AddEmployee
    @Name NVARCHAR(200),
    @Address NVARCHAR(200),
    @PhoneNumber NVARCHAR(20),
    @isActive BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Employees (Name, Address, PhoneNumber, isActive)
    OUTPUT inserted.EmployeeID
    VALUES (@Name, @Address, @PhoneNumber, @isActive);
END
GO