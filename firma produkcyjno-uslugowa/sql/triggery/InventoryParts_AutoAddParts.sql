create or alter trigger dbo.trg_InventoryParts_AutoAddParts
    on dbo.InventoryParts
    after update
    as
    begin
        set nocount on;
        if not update(Quantity)
            return;

        update ip
        set ip.Quantity = ip.Quantity + (ip.MinQuantity * 3)
        from InventoryParts ip
        inner join inserted as i on ip.PartID = i.PartID
        inner join deleted as d on ip.PartID = d.PartID
        where i.Quantity < i.MinQuantity
            and i.Quantity < d.Quantity
    end;
go