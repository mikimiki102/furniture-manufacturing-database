CREATE TABLE dbo.Suppliers (
    SupplierID INT IDENTITY(1, 1) NOT NULL
        CONSTRAINT PK_Suppliers PRIMARY KEY,
    CompanyName NVARCHAR(200) NOT NULL
        CONSTRAINT UQ_Suppliers_CompanyName UNIQUE,
    Address NVARCHAR(200) NOT NULL,
    City NVARCHAR(200) NOT NULL,
    Country NVARCHAR(200) NOT NULL,
    PhoneNumber NVARCHAR(20)  NOT NULL
        CONSTRAINT UQ_Suppliers_PhoneNumber UNIQUE,
        CONSTRAINT CK_Suppliers_Correct_Phone
        CHECK (
            PhoneNumber LIKE '+[0-9]%'
            AND PhoneNumber NOT LIKE '%[^0-9+]%'
            AND LEN(PhoneNumber) BETWEEN 10 AND 16
            )

);