-- DIM LOCATION DESTINATION  --- DW

CREATE TABLE DimLocation (
    LocationKey SMALLINT IDENTITY(1,1) NOT NULL,
    LocationID SMALLINT NULL,
    LocationName NVARCHAR(50) NULL,
    CostRate MONEY NULL,
    Availability NUMERIC(8,2) NULL,
    ActiveFrom DATETIME NULL,
    ActiveTo DATETIME NULL,

    CONSTRAINT PK_DimLocation 
        PRIMARY KEY (LocationKey)
);
-- DIM SCRAPREASON DESTINATION  --- DW

CREATE TABLE DimScrapReason (
    ScrapReasonKey INT IDENTITY(1,1) NOT NULL,
    ScrapReasonID SMALLINT NOT NULL,
    ScrapReasonName NVARCHAR(50) NULL,
    ActiveFrom DATETIME NULL,
    ActiveTo DATETIME NULL,

    CONSTRAINT PK_DimScrapReason 
        PRIMARY KEY (ScrapReasonKey)
);

----FACT WORKORDERS ARCHITECTURE (WorkOrders, WorkOrdersRouting) --- DW
CREATE TABLE FactWorkOrders (
    WorkOrderID INT NULL,
    ProductKey INT NULL,
    LocationKey SMALLINT NULL,
    ScrapReasonKey INT NULL,
    ScheduledStartDate DATETIME NULL,
    ScheduledEndDate DATETIME NULL,
    ActualStartDate DATETIME NULL,
    ActualEndDate DATETIME NULL,
    ActualResourceHrs NUMERIC(9,4) NULL,
    PlannedCost MONEY NULL,
    ActualCost MONEY NULL,
    OrderQty INT NULL,
    StockedQty INT NULL,
    -- Foreign Keys
    CONSTRAINT FK_FactWorkOrders_Product 
        FOREIGN KEY (ProductKey)
        REFERENCES DimProduct(ProductKey),

    CONSTRAINT FK_FactWorkOrders_Location 
        FOREIGN KEY (LocationKey)
        REFERENCES DimLocation(LocationKey),

    CONSTRAINT FK_FactWorkOrders_ScrapReason 
        FOREIGN KEY (ScrapReasonKey)
        REFERENCES DimScrapReason(ScrapReasonKey)
);
ALTER TABLE [dbo].[FactWorkOrders]  WITH CHECK ADD  CONSTRAINT [FK_FactWorkOrders_DimTime] FOREIGN KEY([ActualStartDate])
REFERENCES [dbo].[DimTime] ([DateKey])

