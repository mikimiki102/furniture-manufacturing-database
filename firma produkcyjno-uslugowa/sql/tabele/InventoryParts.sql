CREATE TABLE dbo.InventoryParts
(
    PartID INT NOT NULL,
    Quantity INT NOT NULL
        CONSTRAINT CK_InventoryParts_Quantity_NonNegative CHECK (Quantity >= 0),
    MinQuantity INT NOT NULL
        CONSTRAINT CK_InventoryParts_MinQuantity_NonNegative CHECK (MinQuantity >= 0),

    CONSTRAINT PK_InventoryParts PRIMARY KEY (PartID),
    CONSTRAINT FK_InventoryParts FOREIGN KEY (PartID) REFERENCES dbo.Parts(PartID)
);
