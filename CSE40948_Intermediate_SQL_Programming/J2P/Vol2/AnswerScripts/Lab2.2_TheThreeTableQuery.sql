/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 2.2 Three Table Join
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT lo.city, em.firstname, em.lastname, pr.*
FROM Location lo
INNER JOIN Employee AS em
ON lo.LocationID = em.LocationID
INNER JOIN PayRates AS pr 
ON pr.EmpID = em.EmpID



