create role employee;

grant select, insert, update on Orders to employee;
grant select, insert, update on OrderDetails to employee;
grant select on Products to employee;
grant select, update on Employees to employee;