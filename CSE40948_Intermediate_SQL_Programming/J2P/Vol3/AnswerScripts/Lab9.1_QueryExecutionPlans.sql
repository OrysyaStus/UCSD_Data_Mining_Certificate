/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 9.1 Query Execution Plans

--Skill check 1
CREATE INDEX NCI_SalesInvoice_CustomerID
ON SalesInvoice(CustomerID)

SELECT *
FROM SalesInvoice
WHERE CustomerID = 1


--Skill Check 2
SELECT *
FROM SalesInvoice
WITH (INDEX(NCI_SalesInvoice_CustomerID))
WHERE CustomerID = 155

--Skill Check 3
DECLARE @CustID INT
SET @CustID = 1

SELECT *
FROM SalesInvoice
WHERE CustomerID = @CustID
OPTION(Optimize FOR(@CustID = 1)) --Put "Query Hint" Code here

--Skill Check 4
SELECT *
FROM SalesInvoiceDetail
OPTION (FAST 10)