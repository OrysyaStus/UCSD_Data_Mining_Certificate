/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 12.1 Basic Subqueries
---Make sure you are in the JProCo


--Skill Check1:
SELECT * 
FROM SalesInvoice
WHERE InvoiceID IN (
		SELECT InvoiceID 
		FROM SalesInvoiceDetail
		GROUP BY InvoiceID
		HAVING Count(*) > 30)


--Skill Check2:
SELECT *
FROM Employee
WHERE EmpID IN	(SELECT EmpID FROM [Grant])


--Skill Check3:
SELECT *
FROM Customer
WHERE CustomerID IN 
(SELECT DISTINCT CustomerID FROM SalesInvoice)










