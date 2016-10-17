/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 1.2 CROSS APPLY
---Make sure you are in the JProCo database


--Skill Check1:
SELECT em.FirstName, em.LastName, gsfl.StateName, gsfl.RegionName
FROM Employee as em
CROSS APPLY fn_GetStateFromLocationID(em.LocationID) as gsfl
ORDER BY LastName, FirstName

--Skill Check2:
SELECT cu.FirstName, cu.LastName, gct.* 
FROM Customer AS cu
CROSS APPLY dbo.fn_GetCustomerTrips(cu.CustomerID) AS gct 
ORDER BY CustomerID, InvoiceID

--Skill Check 3:
SELECT cp.ProductName, gcl.*
FROM CurrentProducts AS cp
CROSS APPLY fn_GetCustomerList(cp.ProductID) AS gcl
ORDER BY gcl.CustomerID, gcl.InvoiceID















