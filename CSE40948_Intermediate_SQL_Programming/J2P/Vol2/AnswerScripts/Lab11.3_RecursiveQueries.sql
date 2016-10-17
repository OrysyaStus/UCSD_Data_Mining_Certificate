/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 11.3 Recursive Queries
---Make sure you are in the JProCo


--Skill Check1:
WITH EmployeeList  AS 
	(SELECT Boss.EmpID, Boss.FirstName, Boss.LastName, Boss.ManagerID,
	0 AS RootOffset
	FROM Employee AS Boss
	WHERE ManagerID IS NULL

	UNION ALL

	SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID,
	RootOffset + 1
	FROM Employee AS Emp
	INNER JOIN EmployeeList AS EL
	ON Emp.ManagerID = EL.EmpID
	WHERE Emp.ManagerID IS NOT NULL)

SELECT * FROM EmployeeList









