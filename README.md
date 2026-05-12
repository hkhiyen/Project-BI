# Project-BI
 Designed a BI solution to optimize production and sales operations with Adventure Works Cycles database
# 🎯 Objectives
## General Objectives
- Analyze historical sales and production data to identify trends and patterns
- Build a Data Warehouse to support analytical reporting
- Define and measure Key Performance Indicators (KPIs)
- Visualize data through interactive dashboards using Power BI
## Specific Objectives
- Analyze customer characteristics and behavior
- Evaluate product performance and profitability
- Measure manufacturing efficiency by production location
- Assess sales performance by channel and territory
- Support strategic and operational decision-making
# Data Warehouse Modeling
- Fact tables & Dimension tables
- DimProduct (Product, Product Category, Product SubCategory)
- DimCustomer (Customer, Person)
<img width="943" height="570" alt="image" src="https://github.com/user-attachments/assets/b6b0aafe-a5c8-4fa8-8986-a4b470ca0b22" />

# Flow 
Data Source → ETL → Data Warehouse → Analytics → Visualization.
## Data source
- Sales & Production data from AdventureWorks database.
## ETL (Extract – Transform – Load)
- Data cleansing, transformation, and integration using SSIS
## Data Warehouse
- Designed following Kimball methodology
## Analytics
- OLAP Cubes using SSAS
- MDX queries (Slice, Dice, Drill-down, Roll-up, Pivot)
## OLAP Cubes
<img width="1528" height="687" alt="image" src="https://github.com/user-attachments/assets/39ffd744-75d8-49e4-8d4b-1facdcc20568" />

## Visualization by PowerBI
- Customer Overview Dashboard
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/33c6810f-7425-4bad-b53d-290aa71b12d5" />

- Product Overview Dashboard
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/807f1779-da94-4e4f-a700-6d7eaa942172" />

- Product Analysis Dashboard
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9a123745-e2f8-43c7-bdba-ec16ee47fdd7" />

- Channel and Territory Dashboard
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6401d907-31b0-48fc-b4ee-8f497dc6e15d" />

# 🛠️ Tools & Technologies
- SQL Server Management Studio (SSMS):	Database management & querying
- SQL Server Integration Services (SSIS):	ETL processes
- SQL Server Analysis Services (SSAS):	OLAP cube & multidimensional analysis
- Power BI:	Reporting & data visualization
