/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 13.3 Existance Subqueries
---Make sure you are in the JProCo


--Skill Check1:
SELECT *
FROM CurrentProducts AS cp
WHERE EXISTS (SELECT ProductID 
				FROM SalesInvoiceDetail AS sd
				WHERE sd.ProductID = cp.ProductID)



--Skill Check2:
SELECT *
FROM Customer AS cu
WHERE EXISTS (SELECT CustomerID
				FROM SalesInvoice AS si
				WHERE cu.CustomerID = si.CustomerID)



--Skill Check3:
SELECT *
FROM Employee AS em
WHERE EXISTS (SELECT EmpID
			FROM [Grant] AS gr
			WHERE em.EmpID = gr.EmpID
			GROUP BY EmpID
			HAVING Count(*) > 2)
















