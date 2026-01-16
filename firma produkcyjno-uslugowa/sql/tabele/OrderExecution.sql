CREATE TABLE dbo.OrderExecution (
    OrderID INT NOT NULL
        CONSTRAINT PK_OrderExecution PRIMARY KEY (OrderID),
        CONSTRAINT FK_OrderExecution_Orders FOREIGN KEY (OrderID) REFERENCES dbo.Orders(OrderID),
    PredictedOrderDelivery DATETIME NOT NULL
);