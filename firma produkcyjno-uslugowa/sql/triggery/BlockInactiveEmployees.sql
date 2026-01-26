create or alter trigger dbo.trg_BlockInactiveEmployees
on dbo.Orders
    after insert, update
    as
    begin
        set nocount on;

        declare @InactiveEmployeeID int;
        declare @ErrorMsg NVARCHAR(100);

        select top 1 @InactiveEmployeeID = e.EmployeeID
        from inserted i
        inner join Employees e
            on i.EmployeeID = e.EmployeeID
        where e.isActive = 0;

        if @InactiveEmployeeID is not null
        begin
            set @ErrorMsg = concat(
                            'Nie można przypisać nieaktywnego pracownika (ID: ', cast(@InactiveEmployeeID as NVARCHAR(10)), ') do zamówienia'
                            );
            throw 50001, @ErrorMsg, 1;
        end
    end