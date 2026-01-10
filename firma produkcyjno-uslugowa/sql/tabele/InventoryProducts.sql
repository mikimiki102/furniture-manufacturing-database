CREATE TABLE dbo.InventoryProducts(
    ProductID INT NOT NULL UNIQUE
        CONSTRAINT FK_InventoryProducts_Products
        FOREIGN KEY REFERENCES dbo.Products(ProductID),
    Quantity INT NOT NULL
        CONSTRAINT CK_InventoryProducts_Quantity CHECK (Quantity >= 0),
    MinQuantity INT NOT NULL
        CONSTRAINT CK_InventoryProducts_MinQuantity CHECK (MinQuantity >= 0)
);