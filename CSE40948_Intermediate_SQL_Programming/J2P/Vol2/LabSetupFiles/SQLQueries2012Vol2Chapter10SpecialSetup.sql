/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/
USE JProCo
GO

IF EXISTS (SELECT * FROM sys.tables WHERE [name] = 'SalesGrid')
DROP TABLE SalesGrid
GO

IF EXISTS (SELECT * FROM sys.tables WHERE [name] = 'CategoryGrid')
DROP TABLE CategoryGrid
GO

--Create the table
SELECT Category, [0] as Internal,[1] as [Stay Way Away and Save],[2] as [LaVue Connect],[3] as [More Shores Amigo] INTO CategoryGrid
FROM
(SELECT ProductID, Category, SupplierID AS SupplierName
FROM CurrentProducts) AS Products
PIVOT
(
COUNT(ProductID) 
FOR SupplierName IN 
([0],[1],[2],[3])
) as Pvt
ORDER BY  Category


SELECT * INTO SalesGrid FROM
(SELECT ProductID, OrderYear, RetailPrice
FROM vSales) AS Sales
PIVOT 
(
SUM(RetailPrice) FOR OrderYear IN ([2009],[2010],[2011],[2012],[2013])
) as pvt
GO


IF EXISTS (SELECT * FROM sys.tables WHERE [name] = 'Sales')
DROP TABLE Sales
GO

CREATE TABLE Sales
(SalesID INT IDENTITY PRIMARY KEY,
CustomerID INT NOT NULL,
OrderDate DATETIME,
OrderAmount SMALLMONEY,
ProductID INT,
OrderYear SMALLINT)

INSERT INTO Sales
SELECT CustomerID, OrderDate, Quantity * RetailPrice, ProductID, OrderYear
FROM vSales