/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 4.3 AggregatingStoredProcedures
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
CREATE PROC GetCategoriesByProductCount
AS
BEGIN
	SELECT CP.Category, 
	Count(*) as ProductCt
	FROM SalesInvoiceDetail AS SDV
	INNER JOIN CurrentProducts AS CP
	ON SDV.ProductID = CP.ProductID
	GROUP BY CP.Category
END	
GO

EXEC GetCategoriesByProductCount








