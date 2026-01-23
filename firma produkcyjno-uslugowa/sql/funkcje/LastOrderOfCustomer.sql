create function dbo.fn_LastOrderOfCustomer (@CustomerID INT)
returns datetime as
    begin
        declare @LastOrderDate datetime
        select @LastOrderDate = max(o.OrderDate)
        from Orders o
        where o.CustomerID = @CustomerID
        return @LastOrderDate
    end;