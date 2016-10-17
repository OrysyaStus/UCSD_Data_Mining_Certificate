/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 2.3 Many to Many Relationships
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT *
FROM dbo.SalesInvoiceDetail AS sd
INNER JOIN dbo.SalesInvoice AS si
ON sd.InvoiceID= si.InvoiceID
WHERE si.CustomerID= 490 


--Skill Check2:
SELECT si.CustomerID, si.InvoiceID, si.OrderDate, sd.Quantity, cp.ProductName, cp.RetailPrice
FROM dbo.SalesInvoiceDetail AS sd
INNER JOIN dbo.SalesInvoice AS si
ON sd.InvoiceID = si.InvoiceID
INNER JOIN CurrentProducts AS cp
ON cp.ProductID = sd.ProductID
 




