/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 7.1 Rank&DenseRank
/*Make sure you are in the JProCo
database before running*/

--Skill Check 1
SELECT *,
DENSE_RANK() OVER(ORDER BY HireDate DESC) AS GreenRank
FROM Employee

--Skill Check 2
--answer using TOP
SELECT TOP 2 FirstName, em.LastName, pr.YearlySalary
,RANK() OVER(ORDER BY pr.YearlySalary DESC) AS yrRank
FROM Employee AS em
INNER JOIN PayRates as pr
ON em.EmpID = pr.EmpID

--alternate answer for Skill Check 2
SELECT * FROM
	(SELECT em.FirstName, em.LastName, pr.YearlySalary
	,RANK() OVER(ORDER BY pr.YearlySalary DESC) AS yrRank
	FROM Employee as em
	INNER JOIN PayRates as pr
	ON em.EmpID = pr.EmpID) AS EmpRank
WHERE yrRank <=2

--Skill Check 3
SELECT GrantID, GrantName, EmpID, Amount
,RANK() OVER(ORDER BY Amount DESC) AS AmountRank
FROM [Grant]

--Skill Check 4
SELECT * FROM
	(SELECT DENSE_RANK() OVER(ORDER BY RetailPrice DESC) AS PriceRank
	,ProductID, ProductName, RetailPrice, OriginationDate
	FROM CurrentProducts) AS QueryAlias
WHERE PriceRank = 5

