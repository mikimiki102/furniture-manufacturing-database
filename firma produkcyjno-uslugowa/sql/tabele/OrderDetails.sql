CREATE TABLE dbo.OrderDetails(
    OrderID INT NOT NULL UNIQUE
        CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY REFERENCES dbo.Orders(OrderID),
    ProductID INT NOT NULL
        CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY REFERENCES dbo.Products(ProductID),
    UnitPrice DECIMAL(10,2) NOT NULL
        CONSTRAINT CK_OrderDetails_UnitPrice CHECK (UnitPrice >= 0),
    Quantity INT NOT NULL
        CONSTRAINT CK_OrderDetails_Quantity CHECK (Quantity > 0)

);