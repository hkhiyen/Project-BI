
-- DIM PRODUCT SOURCE QUERY --- QUERY FROM SOURCE ADVENTURE WORK 
SELECT
    pp.ProductID                AS ProductKey,
    pp.Name                     AS ProductName,
    pp.MakeFlag,
    pp.Color                    AS ProductColor,
    pp.SafetyStockLevel,
    pp.ReorderPoint,
    pp.StandardCost,
    pp.ListPrice,
    pp.Size                     AS ProductSize,
    pp.SizeUnitMeasureCode,
    pp.Style                    AS ProductStyle,
    pp.Class                    AS ProductClass,
    pp.Weight                   AS ProductWeight,
    pp.WeightUnitMeasureCode,
    pp.SellStartDate,
    pp.SellEndDate,
    pp.DiscontinuedDate,

    ps.Name                     AS ProductSubcategoryName,
    pc.Name                     AS ProductCategoryName
FROM Production.Product pp
LEFT JOIN Production.ProductSubcategory ps
    ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID;

-- DIM PRODUCT DESTINATION  --- DW
CREATE TABLE DimProduct (
    ProductKey INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    ProductID INT NULL,
    ProductName NVARCHAR(50) NULL,
    MakeFlag BIT NULL,
    ProductColor NVARCHAR(15) NULL,
    SafetyStockLevel SMALLINT NULL,
    ReorderPoint SMALLINT NULL,
    StandardCost MONEY NULL,
    ListPrice MONEY NULL,
    ProductSize NVARCHAR(5) NULL,
    WeightUnitMeasureCode NVARCHAR(3) NULL,
    Weightt NUMERIC(8, 2) NULL,
    DaysToManufacture INT NULL,
    ProductClass NCHAR(2) NULL,
    ProductStyle NCHAR(2) NULL,
    SellStartDate DATETIME NOT NULL,
    SellEndDate DATETIME NULL,
    ProductSubcategoryName NVARCHAR(50) NULL,
    ProductCategoryName NVARCHAR(50) NULL,
    ActiveFrom DATETIME NULL,
    ActiveTo DATETIME NULL
)

----  DIM CUSTOMER SOURCE QUERY (Customer, Person)  --- QUERY FROM SOURCE ADVENTURE WORK 
select
c.CustomerID,
   p.FirstName AS CustomerFirstName,
   p.MiddleName AS CustomerMiddleName,
   p.LastName AS CustomerLastName,
   p.EmailPromotion,
   p.PersonType as CustomerType
from Sales.Customer c
left join Person.Person p on c.PersonID = p.BusinessEntityID

-- DIM CUSTOMER DESTINATION  --- DW
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NULL,
    CustomerFirstName NVARCHAR(50) NULL,
    CustomerMiddleName NVARCHAR(50) NULL,
    CustomerLastName NVARCHAR(50) NULL,
    EmailPromotion INT NULL,
    CustomerType NCHAR(2) NULL,
    ActiveFrom DATETIME NULL,
    ActiveTo DATETIME NULL
);
ALTER TABLE DimCustomer
ADD CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerKey);

-----  DIM SALESPERSON SOURCE QUERY (Person, SalesPerson) --- QUERY FROM SOURCE ADVENTURE WORK 
select
	sl.BusinessEntityID as SalesPersonID,
	sl.SalesQuota,
	sl.Bonus,
	sl.CommissionPct,
	p.FirstName,
	p.MiddleName,
	p.LastName
from Sales.SalesPerson sl
left join Person.Person p on sl.BusinessEntityID = p.BusinessEntityID

-- DIM SALESPERSON DESTINATION  --- DW
CREATE TABLE DimSalesPerson (
    SalesPersonKey INT IDENTITY(1,1) NOT NULL,
    SalesPersonID INT NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NOT NULL,
    SalesQuota MONEY NULL,
    Bonus MONEY NULL,
    CommissionPct MONEY NULL,
    ActiveFrom DATETIME NOT NULL, 
    ActiveTo DATETIME NULL
);

ALTER TABLE DimSalesPerson
ADD CONSTRAINT PK_DimSalesPerson PRIMARY KEY (SalesPersonKey)

---- DIM TERRITORY SOURCE QUERY  (SalesTerritory, CountryRegion) --- QUERY FROM SOURCE ADVENTURE WORK 
select
	st.TerritoryID,
	st.Name TerritoryName,
	st.[Group] as TerritoryRegion,
	ct.Name as TerritoryCountry
from Sales.SalesTerritory as st
left join Person.CountryRegion ct on st.CountryRegionCode = ct.CountryRegionCode

-- DIM TERRITORY DESTINATION  --- DW
CREATE TABLE DimTerritory (
    TerritoryKey INT IDENTITY(1,1) NOT NULL,
    TerritoryID INT NOT NULL,
    TerritoryName NVARCHAR(50) NOT NULL,
    TerritoryRegion NVARCHAR(50) NOT NULL,
    TerritoryCountry NVARCHAR(50) NOT NULL,
    ActiveFrom DATETIME NULL,
    ActiveTo DATETIME NULL
);
ALTER TABLE dbo.DimTerritory
ADD CONSTRAINT PK_DimTerritory PRIMARY KEY (TerritoryKey)

--- DIM TIME ---
DECLARE @StartDate date = '20120101'; 
DECLARE @Year int = 4; 
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, @Year, 
@StartDate)); 
 
;WITH seq(n) AS  
( 
  SELECT 0 UNION ALL SELECT n + 1 FROM seq 
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate) 
), 
d(d) AS  
( 
  SELECT DATEADD(DAY, n, @StartDate) FROM seq 
), 
src AS 
( 
  SELECT 
    DateKey          = CONVERT(date, d), 
    TheDay          = DATEPART(DAY,       d), 
    TheDayName       = DATENAME(WEEKDAY,   d), 
    TheWeek          = DATEPART(WEEK,      d), 
    TheISOWeek       = DATEPART(ISO_WEEK,  d), 
    TheDayOfWeek     = DATEPART(WEEKDAY,   d), 
    TheMonth         = DATEPART(MONTH,     d), 
    TheMonthName     = DATENAME(MONTH,     d), 
    TheQuarter       = DATEPART(Quarter,   d), 
    TheYear          = DATEPART(YEAR,      d), 
    TheFirstOfMonth  = DATEFROMPARTS(YEAR(d), MONTH(d), 1), 
    TheLastOfYear    = DATEFROMPARTS(YEAR(d), 12, 31), 
    TheDayOfYear     = DATEPART(DAYOFYEAR, d) 
  FROM d 
) 
 
SELECT * FROM src 
  ORDER BY DateKey 
  OPTION (MAXRECURSION 0)

  ----FACT SALES ARCHITECTURE--- DW
CREATE TABLE [FactSales] (
    [SalesOrderID] int null,
    [SalesOrderDetailID] int null,
    [OrderQty] smallint null,
    [ProductKey] int null,
    [CustomerKey] int null,
    [SalesPersonKey] int null,
    [TerritoryKey] int null,
    [UnitPrice] money null,
    [UnitPriceDiscount] money null,
    [OrderDate] datetime null,
    [DueDate] datetime null,
    [ShipDate] datetime null,
    [Status] tinyint null,
    [OnlineOrderFlag] bit null,
    [TaxAmt] money null,
    [Freight] money null,

    -- Foreign Keys
    CONSTRAINT FK_FactSales_Product 
        FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),

    CONSTRAINT FK_FactSales_Customer 
        FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),

    CONSTRAINT FK_FactSales_SalesPerson 
        FOREIGN KEY (SalesPersonKey) REFERENCES DimSalesPerson(SalesPersonKey),

    CONSTRAINT FK_FactSales_Territory 
        FOREIGN KEY (TerritoryKey) REFERENCES DimTerritory(TerritoryKey)
