CREATE ROLE finance;

GRANT SELECT, INSERT, UPDATE ON Payments TO finance;

GRANT SELECT ON Orders TO finance;
GRANT SELECT ON OrderDetails TO finance;
GRANT SELECT ON Customers TO finance;
GRANT SELECT ON Products TO finance;
