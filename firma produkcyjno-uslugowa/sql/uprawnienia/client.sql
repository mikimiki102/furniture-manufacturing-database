CREATE ROLE endUser;

GRANT SELECT ON Products to endUser;

GRANT EXECUTE ON AddCustomer to endUser;
GRANT EXECUTE ON ChangeCustomerContact  to endUser;
GRANT EXECUTE ON ChangeCustomerData to endUser;

