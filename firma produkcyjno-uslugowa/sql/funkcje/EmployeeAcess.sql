create function dbo.fn_EmployeeAccess(@EmployeeID int)
returns table with schemabinding
as
    return select 1 as allowed
    where exists(
        select 1
        from dbo.Employees e
        where e.EmployeeID = @EmployeeID
    )