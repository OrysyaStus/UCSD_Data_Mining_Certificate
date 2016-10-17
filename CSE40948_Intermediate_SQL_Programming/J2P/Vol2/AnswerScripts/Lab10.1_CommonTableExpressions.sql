/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 10.1 Common Table Expressions
/*Make sure you are in the JProCo database*/


--Skill Check1:
WITH LocList (Address, Municipality, Region) AS
	(SELECT Street, City, State FROM Location)
SELECT * FROM LocList


--Skill Check2:
WITH EmpGrantRank AS 
	(SELECT G.GrantName,  E.FirstName, E.LastName, G.Amount,
	Dense_Rank() OVER (ORDER BY G.Amount DESC) AS GrantRank
	FROM [Grant] G INNER JOIN Employee E
	ON G.EmpID = E.EmpID)
SELECT * FROM EmpGrantRank

--Skill Check3: 
WITH StateRank AS
	(SELECT *, NTILE(5) OVER(ORDER BY LandMass DESC) AS SizeGroup
	FROM StateList
	WHERE RegionName LIKE 'USA%')

SELECT * FROM StateRank



--Skill Check4: 
WITH StateRank AS
	(SELECT *, NTILE(5) OVER(ORDER BY LandMass DESC) AS SizeGroup
	FROM StateList
	WHERE RegionName LIKE 'USA%')

SELECT * FROM StateRank
WHERE SizeGroup = 1



