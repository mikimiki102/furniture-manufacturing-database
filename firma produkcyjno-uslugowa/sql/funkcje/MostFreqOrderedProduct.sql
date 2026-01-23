create function dbo.fn_MostFreqOrderedProduct ()
returns NVARCHAR(200) as
    begin
        declare @MostOrderedProduct NVARCHAR(200)
        select top 1 @MostOrderedProduct = p.ProductName
        from OrderDetails od
            inner join Products p on p.ProductID = od.ProductID
        group by p.ProductName
        order by count(*) desc
        return @MostOrderedProduct;
    end