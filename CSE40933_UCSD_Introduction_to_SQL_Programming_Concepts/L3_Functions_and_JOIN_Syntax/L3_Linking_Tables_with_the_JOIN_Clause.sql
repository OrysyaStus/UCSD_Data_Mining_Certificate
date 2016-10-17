USE Chinook
--Check for existing tables
IF OBJECT_ID('Customer_Temp') IS NOT NULL DROP TABLE Customer_Temp
IF OBJECT_ID('Invoice_Temp') IS NOT NULL DROP TABLE Invoice_Temp

--Create Tables
SELECT CustomerId, LastName
INTO Customer_Temp
FROM Customer
WHERE CustomerId BETWEEN 1 AND 3

SELECT InvoiceId, CustomerId, BillingCountry, Total
INTO Invoice_Temp
FROM Invoice
WHERE CustomerId BETWEEN 2 AND 4
ORDER BY CustomerId

--Display JOIN types:

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
JOIN Invoice_Temp I
--INTERJOIN, Only rows which have CustomerIds in each table will be joined, therefore CustomerId = 2-3 will show up.
	ON I.CustomerId = C.CustomerId
ORDER BY C.CustomerId, I.CustomerId, InvoiceId

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
LEFT JOIN Invoice_Temp I
--LEFT JOIN, all rows to show in Customer C but only rows in Invoice I, therefore CustomerId = 1-3 will show up.
	ON I.CustomerId = C.CustomerId
ORDER BY C.CustomerId, I.CustomerId, InvoiceId

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
RIGHT JOIN Invoice_Temp I
--RIGHT JOIN, all rows to show in Invoice I but only rows in Customer C, therefore CustomerId = 2-4 will show up.
	ON I.CustomerId = C.CustomerId
ORDER BY C.CustomerId, I.CustomerId, InvoiceId
--Note: if Data does not exist in one of the tables, then 'NULL" is returned

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
FULL JOIN Invoice_Temp I
--FULL JOIN, all records from both tables and match up using ON clause, CustomerId = 1-4 w/some NULLs.
	ON I.CustomerId = C.CustomerId
ORDER BY C.CustomerId, I.CustomerId, InvoiceId

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
CROSS JOIN Invoice_Temp I
--CROSS JOIN, Cartesian product = matches every single row in the Customer table and Invoice table, row count = customer * invoice.
	--ON I.CustomerId = C.CustomerId
ORDER BY C.CustomerId, I.CustomerId, InvoiceId
--Note: Do not use ON, as selectivity is not necessary. 

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
JOIN Invoice_Temp I
	ON I.CustomerId = C.CustomerId
--Will return a selection from the JOIN table. 
	AND I.BillingCountry = 'Germany'
ORDER BY C.CustomerId, I.CustomerId, InvoiceId

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
LEFT JOIN Invoice_Temp I
	ON I.CustomerId = C.CustomerId
--Will return a selection from the JOIN table. 
	AND I.BillingCountry = 'Germany'
ORDER BY C.CustomerId, I.CustomerId, InvoiceId
--Runs very similar to a WHERE clause, but differences in OUTER JOINs.
--Note: There are 'NULLS' wherever 'Germany' is not present.

SELECT 
	C.CustomerId AS [CustomerId C]
	, C.LastName
	, I.CustomerId AS [CustomerId I]
	, I.InvoiceId
	, I.BillingCountry
	, I.Total
FROM Customer_Temp C
LEFT JOIN Invoice_Temp I
	ON I.CustomerId = C.CustomerId
--More formatting options.
	AND (I.BillingCountry = 'Germany'
		OR I.Total > 3)
ORDER BY C.CustomerId, I.CustomerId, InvoiceId