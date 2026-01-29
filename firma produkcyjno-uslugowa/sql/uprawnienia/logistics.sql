CREATE ROLE logistics;

GRANT SELECT, UPDATE ON dbo.Orders TO logistics;
GRANT SELECT ON dbo.Customers TO logistics;
GRANT SELECT, INSERT, UPDATE ON dbo.Shippers TO logistics;
GRANT SELECT, UPDATE ON dbo.OrderExecution TO logistics;




