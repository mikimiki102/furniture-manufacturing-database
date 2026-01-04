CREATE TABLE dbo.Products
(
    ProductID      INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Products PRIMARY KEY,
    ProductName    NVARCHAR(200) NOT NULL,
    Price          DECIMAL(10, 2) NOT NULL
        CONSTRAINT CK_Products_Price_NonNegative CHECK (Price >= 0),
    ProductionTime INT NOT NULL
        CONSTRAINT CK_Products_ProductionTime_Positive CHECK (ProductionTime > 0)
);
