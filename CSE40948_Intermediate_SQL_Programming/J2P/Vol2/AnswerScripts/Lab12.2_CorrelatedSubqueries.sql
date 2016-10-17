/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 12.2 Correlated Subqueries
---Make sure you are in the JProCo


--Skill Check1:
SELECT *,
                        (SELECT Count(*) FROM CurrentProducts CP
                        WHERE CP.SupplierID = SP.SupplierID ) as ProductCount
FROM Supplier SP



--Skill Check2:
SELECT TOP 7 e.FirstName, e.LastName, e.HireDate,
(SELECT Count(*) FROM [Grant] AS g WHERE g.EmpID = e.EmpID) As GrantCount
FROM Employee AS e
ORDER BY HireDate DESC















