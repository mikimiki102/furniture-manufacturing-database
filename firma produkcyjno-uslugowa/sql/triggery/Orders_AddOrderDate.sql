create or alter trigger  dbo.trg_AddOrderDate
    on dbo.Payments
    after update
    as
    begin
        set nocount on;

        if not update(STATUS)
            return;

        update o
        set o.OrderDate = GETDATE()
        from Payments p
        inner join Orders as o on o.OrderID = p.OrderID
        inner join inserted as i on i.OrderID = o.OrderID
        inner join deleted as d on d.OrderID = o.OrderID
        where i.STATUS = 4
            and d.STATUS <> 4;
    end;