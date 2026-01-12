CREATE TABLE dbo.Payments
(
    PaymentID INT IDENTITY(1, 1) NOT NULL,
    OrderID INT NOT NULL,
    PaymentDate DATETIME NOT NULL,
    Amount INT NOT NULL
        CONSTRAINT CK_Payments_Amount_NonNegative CHECK (Amount >= 0),
    STATUS INT NOT NULL,
    Method NVARCHAR(50) NOT NULL

    CONSTRAINT PK_Payments PRIMARY KEY (PaymentID),
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderID) REFERENCES dbo.Orders(OrderID)
)
