/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 8.2 Index Options

--Skill check 1
CREATE UNIQUE NONCLUSTERED INDEX 
UNCI_Employee_FirstNameLastName ON Employee
(FirstName,LastName)
GO

--Skill Check 2
CREATE UNIQUE INDEX UNCI_Vendor_SSN
ON HumanResources.Vendor(SSN)
INCLUDE (FirstName,LastName)
WITH (ONLINE = ON)

--Skill Check 3
CREATE NONCLUSTERED INDEX 
NCI_SalesInvoiceDetail_UnitDiscount
ON SalesInvoiceDetail(UnitDiscount)
WHERE UnitDiscount != 0