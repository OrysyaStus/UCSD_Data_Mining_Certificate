/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 6.1 Top N Queries
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT TOP (2) * 
FROM Employee
ORDER BY HireDate


--Skill Check2:
SELECT 
TOP (6) WITH TIES * 
FROM [Grant]
ORDER BY Amount DESC


--Skill Check3:
SELECT TOP (10) * 
FROM CurrentProducts
WHERE Category = 'No-Stay'
ORDER BY RetailPrice DESC 


--Skill Check4:
DELETE TOP (10) 
FROM CurrentProducts 
WHERE toBeDeleted = 1