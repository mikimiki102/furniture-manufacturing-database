create function dbo.fn_RemainingAmount (@OrderID INT)
returns decimal(10,2) as
    begin
        declare @Amount decimal(10,2)
        select @Amount = od.UnitPrice * od.Quantity - isnull(sum(p.Amount), 0)
        from OrderDetails od
            inner join Payments p on od.OrderID = p.OrderID
        where od.OrderID = @OrderID
        group by od.UnitPrice, od.Quantity
        return @Amount
    end;