/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 1.1 BasicQueries
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT *
FROM CurrentProducts
WHERE RetailPrice <= 200



--Skill Check2:
SELECT *
FROM CurrentProducts
WHERE ProductName LIKE '%Canada%'



--Skill Check3:
SELECT GrantName, Amount
FROM [Grant]
WHERE Amount BETWEEN 21000 AND 30000