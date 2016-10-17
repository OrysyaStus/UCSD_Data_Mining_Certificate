/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 1.2 Joining Tables
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT em.FirstName, em.LastName, lo.City, lo.[State]
FROM Employee em INNER JOIN Location lo
ON em .LocationID = lo.LocationID




--Skill Check2:
SELECT em.FirstName, em.LastName, gr.GrantName, gr.Amount 
FROM [Grant] gr
LEFT OUTER JOIN Employee em
ON Em.EmpID = gr.EmpID

