/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 11.2 Range Hierarchies
---Make sure you are in the JProCo


--Skill Check1:
SELECT E1.FirstName, E1.LastName, E1.HireDate
, 'Was hired before' AS Note
, E2.FirstName, E2.LastName, E2.HireDate
FROM Employee AS E1
JOIN Employee AS E2
ON E1.HireDate < E2.HireDate
WHERE E1.EmpId = 3

--Skill Check 2
USE dbBasics
GO

SELECT high.*, 'OUTRANKS' AS Note, low.* 
FROM Military AS high
INNER JOIN Military AS low
ON high.GradeRank > low.GradeRank
WHERE high.GradeName = 'Colonel'
ORDER BY high.GradeRank




