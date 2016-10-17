/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 6.2 Top n Tricks
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT TOP 1 *
FROM [Grant]
WHERE GrantID NOT IN (SELECT TOP 2 GrantID
					FROM [Grant]
					ORDER BY Amount DESC)
ORDER BY Amount DESC


--Skill Check2:
SELECT TOP 3 *
FROM Employee
WHERE LocationID =	1
ORDER BY HireDate DESC
