CREATE TABLE dbo.Employees
(
    EmployeeID INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Employees PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(200) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL
        CONSTRAINT UQ_Employees_PhoneNumber UNIQUE
        CHECK (
            PhoneNumber LIKE '+[0-9]%'
            AND PhoneNumber NOT LIKE '%[^0-9+]%'
            AND LEN(PhoneNumber) BETWEEN 10 AND 16
            ),
    isActive BIT NOT NULL
);