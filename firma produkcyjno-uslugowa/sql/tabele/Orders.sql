create table Orders
(
    OrderID       int identity
        constraint PK_Orders
            primary key,
    CustomerID    int                                    not null
        constraint FK_Orders_Customers
            references Customers,
    EmployeeID    int                                    not null
        constraint FK_Orders_Employees
            references Employees,
    ShippersID    int
        constraint FK_Orders_Shippers
            references Shippers,
    OrderDate     datetime                               not null,
    DeliveryDate  datetime,
    Address       nvarchar(200)                          not null,
    Country       nvarchar(100)                          not null,
    City          nvarchar(100)                          not null,
    DeliveryPrice decimal(10, 2)
        constraint DF_Orders_DeliveryPrice default 14.99 not null
        constraint CK_Orders_DeliveryPrice
            check ([DeliveryPrice] >= 0),
    Status        int
        constraint DF_Orders_Status default 2            not null
)
go
