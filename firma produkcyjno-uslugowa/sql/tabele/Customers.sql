CREATE TABLE dbo.Customers(
    CustomerID int IDENTITY(1, 1) NOT NULL CONSTRAINT PK_Customers PRIMARY KEY,
    Name Nvarchar(200) NOT NULL,
    Address Nvarchar(200) NOT NULL,
    PhoneNumber Nvarchar(20) NOT NULL
)
