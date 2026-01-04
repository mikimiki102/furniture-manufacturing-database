CREATE TABLE dbo.Customers
(
    CustomerID  INT IDENTITY(1, 1) NOT NULL CONSTRAINT PK_Customers PRIMARY KEY,
    Name        NVARCHAR(200) NOT NULL,
    Address     NVARCHAR(200) NOT NULL,
    PhoneNumber NVARCHAR(20)  NOT NULL
        CONSTRAINT CK_Customers_Correct_Phone
        CHECK (
            PhoneNumber LIKE '+[0-9]%'
            AND PhoneNumber NOT LIKE '%[^0-9+]%'
            AND LEN(PhoneNumber) BETWEEN 10 AND 16
        )
);
