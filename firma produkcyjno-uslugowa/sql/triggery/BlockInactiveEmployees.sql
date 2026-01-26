create or alter trigger dbo.trg_BlockInactiveEmployees
on dbo.Orders
    after insert, update
    as
    begin
        set nocount on;

        declare @InactiveEmployeeID int;
        declare @ErrorMessage NVARCHAR(100);

        select top 1 @InactiveEmployeeID = sfrom ;
    end