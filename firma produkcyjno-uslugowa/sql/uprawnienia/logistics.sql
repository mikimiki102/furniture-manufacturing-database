CREATE ROLE logistics;

GRANT SELECT ON dbo.Orders TO logistics;
GRANT SELECT ON dbo.Customers TO logistics;
GRANT SELECT ON dbo.Shippers TO logistics;
GRANT SELECT ON dbo.Payments TO logistics;

GRANT SELECT ON dbo.v_OrderSchedule TO logistics;
GRANT SELECT ON dbo.v_CustomerOrderHistory TO logistics;
GRANT SELECT ON dbo.v_OrderBasic TO logistics;
GRANT INSERT, UPDATE, SELECT ON dbo.OrderExecution TO logistics;

GRANT EXECUTE ON AddShipper TO logistics;
GRANT EXECUTE  ON ChangeShipperData to logistics;
GRANT EXECUTE ON ChangeShipperContact to logistics;
GRANT EXECUTE ON ChangeIsActiveShipper to logistics;
GRANT EXECUTE ON ChangeOrderData TO logistics;



