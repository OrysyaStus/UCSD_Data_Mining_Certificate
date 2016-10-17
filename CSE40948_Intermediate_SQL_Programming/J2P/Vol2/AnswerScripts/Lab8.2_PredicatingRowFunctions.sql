/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 8.2 : Predicating Row Functions  
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT *
FROM Employee
WHERE EmpID % 2 = 0


--Skill Check2:
SELECT * FROM 
	(SELECT ROW_NUMBER() OVER(ORDER BY HireDate ) AS SeniorRow, *
	FROM Employee) DrvTbl
WHERE SeniorRow % 2 = 0


--Skill Check3:
SELECT * FROM
	(SELECT *, MAX([OriginationDate]) OVER(PARTITION BY [Category]) AS MaxCatDate
	FROM CurrentProducts ) DrvTbl
WHERE [OriginationDate] = MaxCatDate



