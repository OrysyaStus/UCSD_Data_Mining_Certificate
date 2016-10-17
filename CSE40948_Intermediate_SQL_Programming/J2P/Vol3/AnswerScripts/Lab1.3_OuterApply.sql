/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 1.3 OUTER APPLY
---Make sure you are in the JProCo database

--Skill Check1:
SELECT em.FirstName, em.LastName, StateName, RegionName
FROM Employee AS em
OUTER APPLY fn_GetStateFromLocationID(LocationID)
ORDER BY LastName, FirstName


--Skill Check2:
SELECT cu.FirstName, cu.LastName, gp.* 
FROM Customer AS cu
OUTER APPLY dbo.fn_GetCustomerTrips(cu.CustomerID) AS gp 
WHERE CustomerType = 'Consumer'
ORDER BY cu.CustomerID


--Skill Check3:
SELECT cu.FirstName, cu.LastName, gp.* 
FROM Customer AS cu
OUTER APPLY dbo.fn_GetCustomerTrips(cu.CustomerID) AS gp 
WHERE CustomerType = 'Consumer'
AND gp.CustomerID IS NULL
ORDER BY cu.CustomerID





























