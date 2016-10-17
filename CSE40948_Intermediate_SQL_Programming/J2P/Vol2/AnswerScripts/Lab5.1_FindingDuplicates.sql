/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 5.1 Finding Duplicates
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT emp.FirstName, emp.LastName, COUNT(*)
FROM Employee AS emp
INNER JOIN [Grant] AS gr
ON emp.EmpID = gr.EmpID
GROUP BY FirstName, LastName
HAVING COUNT(*) > 1	




--Skill Check2:
SELECT StateID,StateName, COUNT(*) as IDCount
FROM StateList
GROUP BY StateID,StateName
HAVING COUNT(*) > 1




