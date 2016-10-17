/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 8.1 NTILE
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
 SELECT *,
NTILE(20) OVER (ORDER BY LandMass DESC) AS StateGroup 
FROM StateList
