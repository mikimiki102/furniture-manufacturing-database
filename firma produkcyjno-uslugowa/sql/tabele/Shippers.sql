CREATE TABLE dbo.Shippers
(
    ShipperID INT IDENTITY(1, 1) NOT NULL
        CONSTRAINT PK_Shippers PRIMARY KEY,
    CompanyName NVARCHAR(200) NOT NULL
        CONSTRAINT UQ_Shippers_CompanyName UNIQUE,
    PhoneNumber NVARCHAR(20) NOT NULL
        CONSTRAINT UQ_Shippers_PhoneNumber UNIQUE,
        CONSTRAINT CK_Shippers_Correct_Phone
        CHECK (
            PhoneNumber LIKE '+[0-9]%'
            AND PhoneNumber NOT LIKE '%[^0-9+]%'
            AND len(PhoneNumber) BETWEEN 10 and 16
            ),
    isActive BIT NOT NULL
);