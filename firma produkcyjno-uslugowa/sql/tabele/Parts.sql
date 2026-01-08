CREATE TABLE dbo.Parts (
    PartID INT IDENTITY(1, 1) NOT NULL
        CONSTRAINT PK_Parts PRIMARY KEY,

    SupplierID INT NOT NULL
        CONSTRAINT FK_Parts_Suppliers
        FOREIGN KEY REFERENCES dbo.Suppliers(SupplierID),

    PartName NVARCHAR(200) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL
        CONSTRAINT CK_Parts_Cost_NonNegative
        CHECK (Cost >= 0)

);