create or alter function dbo.fn_RemainingOrderAmount (@OrderID INT)
returns decimal(10,2) as
    begin
        declare @Amount decimal(10,2)
        select @Amount = od.UnitPrice * od.Quantity + o.DeliveryPrice - isnull(sum(p.Amount), 0)
        from OrderDetails od
            inner join Payments p on od.OrderID = p.OrderID
            inner join Orders o on od.OrderID = o.OrderID
        where od.OrderID = @OrderID
            and p.STATUS = 1 -- zatwierdzone
        group by od.UnitPrice, od.Quantity, o.DeliveryPrice
        return @Amount
    end;