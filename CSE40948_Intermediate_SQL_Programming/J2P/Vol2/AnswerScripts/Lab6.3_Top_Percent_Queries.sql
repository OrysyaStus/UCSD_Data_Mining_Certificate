/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 6.3 Top Percent Queries
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
--Show the Top 50% most senior employees by HireDate
SELECT TOP (50) PERCENT *
FROM Employee
ORDER BY HireDate



--Skill Check2:
--Show the Top 2% most expensive products from the CurrentProducts table
SELECT TOP (2) PERCENT *
FROM CurrentProducts
ORDER BY RetailPrice DESC

