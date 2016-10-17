/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 2.1 Sorting Data
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT *
FROM [Grant]
ORDER BY GrantName


--Skill Check2:
SELECT *
FROM Employee
ORDER BY HireDate DESC



--Skill Check3:
SELECT ProductName, Category
FROM CurrentProducts
ORDER BY RetailPrice DESC


--Skill Check4:
SELECT *
FROM [Grant]
ORDER BY Amount DESC, GrantName ASC


--Skill Check5:
SELECT em.FirstName, em.LastName, lo.City
FROM Employee AS em LEFT OUTER JOIN Location AS lo
ON em.LocationID = lo.LocationID
ORDER BY city