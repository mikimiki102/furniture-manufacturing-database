create function dbo.fn_AvgOrderCompletionTime ()
returns decimal(10,2) as
    begin
        declare @AvgTime decimal(10,2)
        select @AvgTime = avg(datediff(day, o.OrderDate, o.DeliveryDate))
        from Orders o
        return @AvgTime
    end