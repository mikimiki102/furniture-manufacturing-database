create role employee;

grant select, insert, update on Orders to employee;
grant select, insert, update on OrderDetails to employee;
grant select on Products to employee;

-- Row-Level Security (tylko swój rekord)
grant select, update on Employees to employee;

create security policy dbo.EmployeePolicy
add filter predicate dbo.fn_EmployeeAccess(EmployeeID) on dbo.Employees,
add block predicate dbo.fn_EmployeeAccess(EmployeeID) on dbo.Employees
after update with (state = on);