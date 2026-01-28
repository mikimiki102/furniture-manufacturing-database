CREATE ROLE client;

GRANT SELECT ON Products to client;
GRANT SELECT ON v_CustomerOrderHistory to client;
GRANT SELECT ON v_OrderSchedule to client;

GRANT EXECUTE ON AddCustomer to client;
GRANT EXECUTE ON ChangeCustomerContact  to client;
GRANT EXECUTE ON ChangeCustomerData to client;

