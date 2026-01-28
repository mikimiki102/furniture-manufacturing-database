CREATE ROLE client;

GRANT SELECT ON Products to client;

GRANT EXECUTE ON AddCustomer to client;
GRANT EXECUTE ON ChangeCustomerContact  to client;
GRANT EXECUTE ON ChangeCustomerData to client;

