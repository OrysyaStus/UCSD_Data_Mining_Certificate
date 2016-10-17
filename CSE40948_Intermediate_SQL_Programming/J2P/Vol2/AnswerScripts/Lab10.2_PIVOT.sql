/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 10.2: PIVOT	
/*Make sure you are in the JProCo database */


--Skill Check1:
SELECT * FROM
(SELECT ProductID, OrderYear, RetailPrice
FROM vSales) AS Sales
PIVOT 
(
SUM(RetailPrice) FOR OrderYear IN ([2009],[2010],[2011],[2012],[2013])
) AS pvt


--Skill Check2:
	--SELECT OrderYear, Quantity, 
	--COUNT(ProductID) AS OrderCount
	--FROM vSales
	--GROUP BY OrderYear, Quantity
	--ORDER BY OrderYear, Quantity

SELECT OrderYear,[1] AS Qty1,
[2] AS Qty2,
[3] AS Qty3,
[4] AS Qty4,
[5] AS Qty5,
[6] AS Qty6
FROM
(SELECT OrderYear, Quantity, ProductID
FROM vSales) AS Sales
PIVOT 
(
COUNT(ProductID) FOR Quantity IN ([1],[2],[3],[4],[5],[6])
) AS pvt
ORDER BY OrderYear










