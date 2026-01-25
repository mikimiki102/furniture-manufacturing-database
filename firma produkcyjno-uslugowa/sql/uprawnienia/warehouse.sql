CREATE ROLE warehouse;

GRANT SELECT, UPDATE ON InventoryProducts TO warehouse;
GRANT SELECT, UPDATE ON InventoryParts TO warehouse;

GRANT SELECT ON Products TO warehouse;
GRANT SELECT ON Parts TO warehouse;
GRANT SELECT ON Orders TO warehouse;
GRANT SELECT ON OrderDetails TO warehouse;
