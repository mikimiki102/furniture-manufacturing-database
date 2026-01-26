create or alter view dbo.v_InventoryProductsStockInfo as
    select p.ProductName,
           case
                when ip.Quantity > 3 * ip.MinQuantity then 'Wysoki stan'
                when ip.Quantity > 2 * ip.MinQuantity then N'Średni stan'
                else 'Niski stan'
            end
            as Stan_Magazynu
    from InventoryProducts ip
        inner join Products p on p.ProductID = ip.ProductID
