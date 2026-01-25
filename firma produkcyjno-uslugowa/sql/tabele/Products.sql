create table Products
(
    ProductID      int identity
        primary key,
    ProductName    nvarchar(200)  not null,
    Price          decimal(10, 2) not null
        constraint CK_Products_Price_NonNegative
            check ([Price] >= 0),
    ProductionTime int            not null
        constraint CK_Products_ProductionTime_Positive
            check ([ProductionTime] > 0),
    PartID         int            not null
        constraint FK_Products_Parts
            references Parts
)
go
