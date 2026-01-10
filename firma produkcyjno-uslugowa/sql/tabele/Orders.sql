CREATE TABLE dbo.Orders (
    OrderID INT IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Orders PRIMARY KEY,
    CustomerID INT NOT NULL
        CONSTRAINT FK_Orders_Customers
        FOREIGN KEY REFERENCES dbo.Customers(CustomerID),
    EmployeeID INT NOT NULL
        CONSTRAINT FK_Orders_Employees
        FOREIGN KEY REFERENCES dbo.Employees(EmployeeID),
    ShippersID INT NULL
        CONSTRAINT FK_Orders_Shippers
        FOREIGN KEY REFERENCES dbo.Shippers(ShipperID),
    OrderDate DATETIME NOT NULL,
    DeliveryDate DATETIME NULL,
    Address NVARCHAR(200) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    DeliveryPrice DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_Orders_DeliveryPrice CHECK (DeliveryPrice >= 0),
    Status INT NOT NULL
);