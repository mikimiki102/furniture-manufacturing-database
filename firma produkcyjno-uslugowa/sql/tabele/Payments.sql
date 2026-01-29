create table Payments
(
    PaymentID   int identity
        constraint PK_Payments
            primary key,
    OrderID     int            not null
        constraint FK_Payments_Orders
            references Orders,
    PaymentDate datetime       not null,
    Amount      decimal(10, 2) not null
        constraint CK_Payments_Amount_NonNegative
            check ([Amount] >= 0)
        constraint CK_Payments_Amount_NonNegative
            check ([Amount] >= 0),
    Status      int            not null,
    Method      nvarchar(50)   not null
)
go
