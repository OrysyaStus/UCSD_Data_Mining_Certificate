/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 3.2 Expression Fields
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT ProductName, RetailPrice, 
CAST(RetailPrice * 1.1 AS Decimal (6,2)) as cdn$,
CAST(RetailPrice * 1.4 AS Decimal (6,2)) as Aussie$,
CAST(RetailPrice * .82 AS Decimal (6,2)) as Euro
FROM CurrentProducts



--Skill Check2:
SELECT CustomerID,
CustomerType,
FirstName + ' ' + LastName AS FullName FROM Customer
WHERE CustomerType = 'Consumer'
ORDER BY FullName DESC

--Skill Check3:
SELECT cp.ProductID, cp.ProductName, RetailPrice, sv.Quantity, (RetailPrice * sv.Quantity) AS SubTotal
FROM CurrentProducts AS cp
INNER JOIN SalesInvoiceDetail AS sv
ON cp.ProductID = sv.ProductID

--Skill Check4:
SELECT cp.ProductID, cp.ProductName, ROUND(RetailPrice,2) AS RetailPrice, 
sv.Quantity, ROUND((RetailPrice * sv.Quantity),2) AS SubTotal
FROM CurrentProducts AS cp
INNER JOIN SalesInvoiceDetail AS sv
ON cp.ProductID = sv.ProductID







