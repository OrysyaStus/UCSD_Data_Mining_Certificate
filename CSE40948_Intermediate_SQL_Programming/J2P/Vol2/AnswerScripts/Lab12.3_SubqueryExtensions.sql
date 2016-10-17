/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 12.3 Subquery Extensions
---Make sure you are in the JProCo


--Skill Check1:
SELECT *
FROM Supplier
WHERE 1000 > ALL (SELECT RetailPrice FROM CurrentProducts
		WHERE Supplier.SupplierID = CurrentProducts.SupplierID)



--Skill Check2:
SELECT *
FROM Employee AS e
WHERE 5000 >= 
ALL (SELECT Amount FROM [Grant] AS g WHERE g.EmpID = e.EmpID)















