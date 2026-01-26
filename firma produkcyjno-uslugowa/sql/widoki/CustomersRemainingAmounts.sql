create or alter view dbo.v_CustomersRemainingAmounts as
    select c.Name,
           c.Address,
           c.PhoneNumber,
           sum(dbo.fn_RemainingOrderAmount(o.OrderID)) as RemainingAmountsSum
    from Customers c
        inner join Orders o on o.CustomerID = c.CustomerID
    group by
        o.OrderID, c.Name, c.Address, c.PhoneNumber;
go