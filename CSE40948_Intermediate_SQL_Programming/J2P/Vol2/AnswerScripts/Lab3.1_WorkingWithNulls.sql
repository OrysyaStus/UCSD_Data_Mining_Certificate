/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 3.1 Working with Nulls
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT *
FROM Employee
WHERE ManagerID IS NULL


--Skill Check2:
SELECT *
FROM Customer
WHERE CompanyName IS NOT NULL

--Skill Check3:
UPDATE Customer
SET CustomerType = 'Business'
WHERE CompanyName IS NOT NULL

SELECT *
FROM Customer
WHERE CompanyName IS NOT NULL

--Skill Check4:
SELECT *
FROM [Grant]
WHERE EmpID != 5
OR EmpID IS NULL




