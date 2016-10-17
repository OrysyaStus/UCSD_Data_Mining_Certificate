/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 4.2 Having
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT CustomerID, Count(InvoiceID) as OrderCount
FROM SalesInvoice
GROUP BY CustomerID 
HAVING Count(InvoiceID) > 7


--Skill Check2:
SELECT ProductID, 
Count(InvoiceID) AS InvoiceCt 
FROM salesInvoiceDetail
GROUP BY ProductID
HAVING Count(InvoiceID) > 200	










