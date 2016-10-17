/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 4.1 Group By
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT ManagerID, COUNT(EmpID) AS EmpIDCount
FROM Employee
GROUP BY ManagerID


--Skill Check2:
SELECT CustomerType, COUNT(*) AS CustomerCount
FROM Customer
GROUP BY CustomerType


--Skill Check3:
SELECT C.CustomerID,C.FirstName, C.LastName,
COUNT(InvoiceID) as InvoiceIDCount
FROM Customer AS C LEFT OUTER JOIN dbo.SalesInvoice AS SI
ON C.CustomerID = SI.CustomerID
GROUP BY C.CustomerID,C.FirstName, C.LastName



--Skill Check4:
--CustomerID 5 does not appear in this result  
SELECT C.CustomerID,C.FirstName, C.LastName,
COUNT(InvoiceID) as InvoiceIDCount
FROM Customer AS C INNER JOIN dbo.SalesInvoice AS SI
ON C.CustomerID = SI.CustomerID
GROUP BY C.CustomerID,C.FirstName, C.LastName









