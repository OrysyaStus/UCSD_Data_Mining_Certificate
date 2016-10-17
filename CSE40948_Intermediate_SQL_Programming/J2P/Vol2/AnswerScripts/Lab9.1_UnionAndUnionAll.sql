/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

/*
Code for Lab 9.1 Union and Union All
Make sure you are in the JProCo database
*/

--Skill Check1:
SELECT *
FROM vNonEmployeeGrants

UNION ALL

SELECT *
FROM [Grant]



--Skill Check2:
SELECT *
FROM Employee
WHERE Status = 'Has Tenure'

UNION

SELECT *
FROM Employee
WHERE LocationID = 4
