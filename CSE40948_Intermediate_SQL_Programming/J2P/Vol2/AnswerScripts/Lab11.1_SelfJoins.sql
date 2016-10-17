/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 11.1 Self Joins
---Make sure you are in the JProCo


--Skill Check1:
SELECT e.EmpId, e.FirstName, e.LastName, 
bl.FirstName + ' ' + Bl.LastName As BossFullName
 FROM Employee AS e
LEFT OUTER JOIN Employee AS bl
ON E.ManagerID = bl.EmpID






