/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 5.2 The Over Clause
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SELECT ProductName, RetailPrice, Category,
AVG(RetailPrice) OVER() AS AvgPrice
FROM CurrentProducts


--Skill Check2:
SELECT ProductName, RetailPrice, Category,
AVG(RetailPrice) OVER() AS AvgPrice,
AVG(RetailPrice) OVER(PARTITION BY Category) AS AvgCatPrice
FROM CurrentProducts



--Skill Check3:
SELECT DISTINCT Category,
COUNT(*) OVER (PARTITION BY Category)*100.0/ COUNT(*) OVER() as PctCategory
FROM CurrentProducts


--Skill Check4:
SELECT emp.FirstName, emp.LastName, gr.GrantName, loc.City, gr.Amount,
SUM(Amount) OVER(PARTITION BY City) as CityTotal
FROM Employee AS emp
INNER JOIN Location AS Loc
ON Emp.locationID = Loc.locationID
INNER JOIN [Grant] AS gr
ON emp.EmpID = gr.EmpID