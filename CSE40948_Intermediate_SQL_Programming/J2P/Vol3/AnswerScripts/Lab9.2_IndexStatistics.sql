/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 9.2 Index Statistics

--Skill check 1
CREATE STATISTICS SalesInvoiceDetail_Quantity ON dbo.SalesInvoiceDetail(Quantity)


--Skill check 2
UPDATE STATISTICS dbo.SalesInvoiceDetail


--Skill check 3
--SalesInvoiceDetail_Quantity Histogram

DBCC SHOW_STATISTICS ('SalesInvoiceDetail',SalesInvoiceDetail_Quantity)