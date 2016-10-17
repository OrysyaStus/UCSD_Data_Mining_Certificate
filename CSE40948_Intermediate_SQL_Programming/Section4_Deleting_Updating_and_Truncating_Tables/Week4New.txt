--5.1 Steps

--Finding duplicates

SELECT *
FROM Employee

SELECT FirstName
FROM Employee

SELECT DISTINCT FirstName
FROM Employee

SELECT FirstName
FROM Employee
ORDER BY FirstName

SELECT FirstName, Count(*)
FROM Employee
GROUP BY FirstName

SELECT FirstName, Count(*)
FROM Employee
GROUP BY FirstName
HAVING Count(*) > 1



SELECT *
FROM Customer

SELECT *
FROM Customer
ORDER BY FirstName, LastName

SELECT FirstName, LastName, Count(*)
FROM Customer
GROUP BY FirstName, LastName

SELECT FirstName, LastName, Count(*)
FROM Customer
GROUP BY FirstName, LastName
HAVING Count(*) > 1

SELECT FirstName, LastName, Count(*)
FROM Customer
GROUP BY FirstName, LastName
HAVING Count(*) > 1
ORDER BY Count(*) DESC

------------------------------------

--5.2 Steps

SELECT *
FROM [Grant]

SELECT SUM(Amount)
FROM [Grant]

SELECT *, SUM(Amount)
FROM [Grant] --Does not work

SELECT *, SUM(Amount) OVER()
FROM [Grant] 

SELECT *, SUM(Amount) OVER() as CompanyTotal
FROM [Grant] 

SELECT *, SUM(Amount) OVER() as CompanyTotal,
Amount/ SUM(Amount) OVER()
FROM [Grant] --Need to turn Ratio into a pct

SELECT *, SUM(Amount) OVER() as CompanyTotal,
Amount/ SUM(Amount) OVER() * 100 as PctOfTotal
FROM [Grant]



SELECT FirstName, LastNAme, LocationID
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER()
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER() as TotalEmployee
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER() as TotalEmployee,
Count(*) OVER(PARTITION BY LocationID) as LocationCount
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER() as TotalEmployee,
Count(*) OVER(PARTITION BY LocationID) as LocationCount,
Count(*) OVER(PARTITION BY LocationID)/Count(*) OVER() --Added this but you get zeros
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER() as TotalEmployee,
Count(*) OVER(PARTITION BY LocationID) as LocationCount,
Count(*) OVER(PARTITION BY LocationID) *1.0 /Count(*) OVER() 
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER() as TotalEmployee,
Count(*) OVER(PARTITION BY LocationID) as LocationCount,
Count(*) OVER(PARTITION BY LocationID) *100.0 /Count(*) OVER() 
FROM Employee

SELECT FirstName, LastNAme, LocationID, Count(*) OVER() as TotalEmployee,
Count(*) OVER(PARTITION BY LocationID) as LocationCount,
Count(*) OVER(PARTITION BY LocationID) *100.0 /Count(*) OVER() as Pct
FROM Employee


------------------------------------


--Lab 6.1 Steps

SELECT *
FROM CurrentProducts
ORDER BY RetailPrice DESC


SELECT *
FROM CurrentProducts
WHERE RetailPrice >= 1147.986 --show the top 3
ORDER BY RetailPrice DESC

INSERT INTO CurrentProducts
VALUES ('Summer Trip Cabo',4500,getdate(),0,'Super Long')

SELECT *
FROM CurrentProducts
WHERE RetailPrice >= 1147.986 --No longer top 3 you get 4
ORDER BY RetailPrice DESC

SELECT TOP 3 *
FROM CurrentProducts
ORDER BY RetailPrice DESC

INSERT INTO CurrentProducts
VALUES ('Summer Trip Cabo and Aussie',7500,getdate(),0,'Super Long')

SELECT TOP 3 *
FROM CurrentProducts
ORDER BY RetailPrice DESC


SELECT TOP 3 *
FROM CurrentProducts
ORDER BY RetailPrice ASC --Cheapest items


--Reset 6.0 script again.
SELECT *
FROM CurrentProducts
ORDER BY RetailPrice DESC --Notice Tie for 6th place

SELECT TOP 6 *
FROM CurrentProducts
ORDER BY RetailPrice DESC 

SELECT TOP 6 WITH TIES * 
FROM CurrentProducts
ORDER BY RetailPrice DESC 



SELECT *
FROM CurrentProducts

SELECT *
FROM CurrentProducts
WHERE ToBeDeleted = 1

SELECT TOP (10) *
FROM CurrentProducts
WHERE ToBeDeleted = 1

DELETE TOP (10) *
FROM CurrentProducts
WHERE ToBeDeleted = 1



------------------------------------------------




--6.2 Steps

SELECT TOP 5 *
FROM CurrentProducts
ORDER BY RetailPrice DESC



DECLARE @TopNum INT
SET @TopNum = 4

SELECT TOP @TopNum  *
FROM CurrentProducts
ORDER BY RetailPrice DESC --Does not work


DECLARE @TopNum INT
SET @TopNum = 4

SELECT TOP (@TopNum)  *
FROM CurrentProducts
ORDER BY RetailPrice DESC --works great!




--Run both queries together
SELECT TOP 5 *
FROM CurrentProducts
ORDER BY RetailPrice DESC 

SELECT TOP 5 *
FROM CurrentProducts
ORDER BY RetailPrice DESC 
--River Rapids is the only record in the top5 not in the Top4.



SELECT TOP 1 *
FROM CurrentProducts
WHERE ProductID NOT IN (483,336,342,372)
ORDER BY RetailPrice DESC

SELECT TOP 1 *
FROM CurrentProducts
WHERE ProductID NOT IN (SELECT TOP 4 ProductID
			FROM CurrentProducts
			ORDER BY RetailPrice DESC )
ORDER BY RetailPrice DESC


DECLARE @TopNum INT
SET @TopNum = 5

SELECT TOP 1 *
FROM CurrentProducts
WHERE ProductID NOT IN (SELECT TOP (@TopNum-1) ProductID
			FROM CurrentProducts
			ORDER BY RetailPrice DESC )
ORDER BY RetailPrice DESC



SELECT *
FROM Employee
ORDER BY Hiredate ASC

SELECT TOP (3) *
FROM Employee
ORDER BY Hiredate ASC

SELECT TOP (3) *
FROM Employee
ORDER BY Hiredate DESC




SELECT *
FROM CurrentProducts
ORDER BY RetailPrice DESC


SELECT *
FROM CurrentProducts
WHERE ToBeDeleted = 0
ORDER BY RetailPrice DESC


SELECT TOP (5) *
FROM CurrentProducts
WHERE ToBeDeleted = 0
ORDER BY RetailPrice DESC



-------------------------------------

-- 7.1 Steps

SELECT *
FROM [Grant]
ORDER BY Amount DESC

SELECT *, RANK() OVER(ORDER BY Amount DESC)
FROM [Grant]
ORDER BY Amount DESC --Gaps after ties



SELECT *
FROM CurrentProducts
ORDER BY RetailPrice DESC

SELECT ProductName, RetailPrice
FROM CurrentProducts
ORDER BY RetailPrice DESC

SELECT ProductName, RetailPrice, 
RANK() OVER(ORDER BY RetailPrice DESC)
FROM CurrentProducts

SELECT ProductName, RetailPrice, 
DENSE_RANK() OVER(ORDER BY RetailPrice DESC)
FROM CurrentProducts --No more gaps after ties

SELECT ProductName, RetailPrice, 
DENSE_RANK() OVER(ORDER BY RetailPrice DESC) AS PriceRank
FROM CurrentProducts --No more gaps after ties



SELECT ProductName, RetailPrice, 
DENSE_RANK() OVER(ORDER BY RetailPrice DESC) AS PriceRank
FROM CurrentProducts 
WHERE PriceRank = 5 --Does not work

SELECT * FROM 
  (SELECT ProductName, RetailPrice, 
  DENSE_RANK() OVER(ORDER BY RetailPrice DESC) AS PriceRank
  FROM CurrentProducts) as RankedProduct
WHERE PriceRank = 5 --Does not work



--GOAL: Find 5 highest amount
SELECT *
FROM [Grant]
ORDER BY Amount DESC

SELECT *, RANK() OVER(ORDER BY Amount DESC) as Rk
FROM [Grant]
ORDER BY Amount DESC

SELECT * FROM 
  (SELECT *, RANK() OVER(ORDER BY Amount DESC) as Rk
  FROM [Grant]
  ORDER BY Amount DESC) AS RankedGrants
WHERE Rk <= 5

SELECT * FROM 
  (SELECT *, DENSE_RANK() OVER(ORDER BY Amount DESC) as Rk
  FROM [Grant]
  ORDER BY Amount DESC) AS RankedGrants
WHERE Rk <= 5




------------------------------------


--7.2 Steps

SELECT FirstName, LastName
FROM Employee

SELECT FirstName, LastName, 
RANK() OVER(ORDER BY FirstNAme) as AzRank
FROM Employee

SELECT FirstName, LastName, 
RANK() OVER(ORDER BY FirstNAme) as AzRank,
DENSE_RANK() OVER(ORDER BY FirstNAme) as AzRankD,
ROW_NUMBER() OVER(ORDER BY FirstNAme) as AzRankRow
FROM Employee

--Show Vidoe 2:20


------------------------------------



--7.3 Steps

SELECT *
FROM [Grant]
ORDER BY Amount DESC

SELECT *, NTILE(4) OVER (ORDER BY Amount DESC)
FROM [Grant]

SELECT *, NTILE(2) OVER (ORDER BY Amount DESC)
FROM [Grant]



SELECT * 
FROM Employee
ORDER BY HireDate ASC

SELECT *, NTILE(2) OVER(ORDER BY HireDate ASC) 
FROM Employee

SELECT *, NTILE(2) OVER(ORDER BY HireDate ASC) as WhichHalf
FROM Employee





SELECT *
FROM Employee

SELECT *
FROM Employee
ORDER BY HireDate ASC

SELECT *
FROM Employee
WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year
ORDER BY HireDate ASC 


--find 2 that were hired first

SELECT TOP (2) *
FROM Employee
WHERE HireDate >= '7/1/2001' --Get the next two
ORDER BY HireDate ASC 


SELECT *
FROM Employee
WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year
ORDER BY HireDate ASC  -- order by does not work and uses natural table sort order 

UNION

SELECT TOP (2) *
FROM Employee
WHERE HireDate >= '7/1/2001' --Get the next two
ORDER BY HireDate ASC --Why Eric Bender from 2007 shows up

--Show Video 2:30

--Order by removed.

SELECT *
FROM Employee
WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year

UNION

SELECT * FROM
  (SELECT TOP (2) *
  FROM Employee
  WHERE HireDate >= '7/1/2001' --Get the next two
  ORDER BY HireDate ASC) AS NextTwo




SELECT * FROM 
  (SELECT *
  FROM Employee
  WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year
  ORDER BY HireDate ASC ) AS PreJulyEmp

UNION

SELECT * FROM
  (SELECT TOP (2) *
  FROM Employee
  WHERE HireDate >= '7/1/2001' --Get the next two
  ORDER BY HireDate ASC) AS NextTwoEmp





SELECT * FROM 
  (SELECT *
  FROM Employee
  WHERE HireDate < '7/1/2001' 
  OR LocationID = 4 --All Spokane Emp get 3 weeks vaca
  ORDER BY HireDate ASC ) AS PreJulyEmp

UNION  --Later change to UNION ALL

SELECT * FROM
  (SELECT TOP (2) *
  FROM Employee
  WHERE HireDate >= '7/1/2001' --Get the next two
  ORDER BY HireDate ASC) AS NextTwoEmp



SELECT * 
FROM Location

SELECT 5, '99 Union Ave','Fargo','ND'



SELECT * 
FROM Location

UNION

--similar structure
SELECT 5, '99 Union Ave','Fargo','ND'



-- Book 2; 8.2 Using Except
-- run 8.2 setup script


SELECT * 
FROM [Grant]

SELECT *
FROM vNonEmployeeGrants



SELECT * 
FROM [Grant]

UNION --Then change to UNION ALL / INTERSECT / EXCEPT

SELECT *
FROM vNonEmployeeGrants



--Book2; 9.1 Common Table Expressions
-- run 9.1 setup script

SELECT FirstName, LastName, EmpID, LocationID
FROM Employee
ORDER BY LastName, FirstName

SELECT FirstName, LastName, EmpID, LocationID,
ROW_NUMBER() OVER(ORDER BY LastName, FirstName)
FROM Employee

SELECT FirstName, LastName, EmpID, LocationID,
ROW_NUMBER() OVER(ORDER BY LastName, FirstName) AS Position
FROM Employee
WHERE Position = 10 --does not work


SELECT * FROM
  (SELECT FirstName, LastName, EmpID, LocationID,
  ROW_NUMBER() OVER(ORDER BY LastName, FirstName) AS Position
  FROM Employee) AS EmpSort
WHERE Position = 10


  (SELECT FirstName, LastName, EmpID, LocationID,
  ROW_NUMBER() OVER(ORDER BY LastName, FirstName) AS Position
  FROM Employee) 



WITH EmpSort AS
  (SELECT FirstName, LastName, EmpID, LocationID,
  ROW_NUMBER() OVER(ORDER BY LastName, FirstName) AS Position
  FROM Employee) 
SELECT * FROM EmpSort



WITH EmpSort AS
  (SELECT FirstName, LastName, EmpID, LocationID,
  ROW_NUMBER() OVER(ORDER BY LastName, FirstName) AS Position
  FROM Employee) 
SELECT * FROM EmpSort
WHERE Position = 10




SELECT GrantID, GrantName, Amount
FROM [Grant]
WHERE Amount > 20000

WITH HighGrants AS
  (SELECT GrantID, GrantName, Amount  
  FROM [Grant]
  WHERE Amount > 20000)
SELECT * FROM HighGrants


WITH HighGrants AS
  (SELECT GrantID, GrantName, Amount  + 1000
  FROM [Grant]
  WHERE Amount > 20000)
SELECT * FROM HighGrants


WITH HighGrants (GNumber, GName, Pledge) AS
  (SELECT GrantID, GrantName, Amount  + 1000
  FROM [Grant]
  WHERE Amount > 20000)
SELECT * FROM HighGrants



-- Book 2; 9.2 Advanced Clause Combinations
-- run 9.2 setup script

SELECT *
FROM [Grant]
WHERE EmpID IS NOT NULL

SELECT *
FROM [Grant]
WHERE EmpID IS NOT NULL
COMPUTE SUM(Amount)

SELECT *
FROM [Grant]
WHERE EmpID IS NOT NULL
COMPUTE SUM(Amount), Avg(Amount), Max(Amount)



SELECT *
FROM [Grant]
WHERE EmpID IS NOT NULL
ORDER BY EmpID
COMPUTE SUM(Amount) By EmpID


SELECT *
FROM [Grant]
WHERE EmpID IS NOT NULL
ORDER BY EmpID
COMPUTE SUM(Amount) By EmpID,
COMPUTE SUM(Amount) --Grand total at the bottom.



--Book 2; 10.1 Self Joins
-- run 10.1 setup script

SELECT *
FROM Employee

SELECT *
FROM Employee
WHERE ManagerID = 11 --Who works for Sally



SELECT *
FROM Employee

SELECT *
FROM vBossList

SELECT *
FROM Employee em INNER JOIN VBossList bl
ON em.ManagerID = bl.empID



SELECT *
FROM Employee

SELECT *
FROM Employee

SELECT *
FROM Employee E1
INNER JOIN Employee BL
ON.ManagerID = BL.EmpID


--Book 2; 10.2 Range Hierarchies
-- run 10.2 setup script

SELECT *
FROM [Grant] as Gr
ORDER BY Gr.Amount

SELECT *
FROM [Grant] as LgGr
INNER JOIN [Grant] SmGr
ON LgGr.Amount > SmGr.Amount
ORDER BY LgGr.Amount

SELECT LgGr.*, SmGr.GrantName, SmGr.Amount
FROM [Grant] as LgGr
INNER JOIN [Grant] SmGr
ON LgGr.Amount > SmGr.Amount
ORDER BY LgGr.Amount



SELECT *
FROM CurrentProducts SCP
ORDER BY SCP.RetailPrice

SELECT *
FROM CurrentProducts SCP
WHERE SCP.Category = 'No-Stay'
ORDER BY SCP.RetailPrice

SELECT *
FROM CurrentProducts SCP 
INNER JOIN CurrentProducts LCP
ON SC.RetailPrice > LCP.RetailPrice
WHERE SCP.Category = 'No-Stay'
ORDER BY SCP.RetailPrice

SELECT SCP.ProductName, SCP.RetailPrice,
LCP.ProductName, LCP.RetailPrice
FROM CurrentProducts SCP 
INNER JOIN CurrentProducts LCP
ON SC.RetailPrice > LCP.RetailPrice
WHERE SCP.Category = 'No-Stay'
ORDER BY SCP.RetailPrice


--Book 2; 10.3 Recursive Queries
-- run 10.3 setup script

SELECT EmpID, FirstName, LastName, ManagerID
FROM Employee

--Show up to 1:50


SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID, 1 as EmpLevel ---
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, 2 as EmpLevel --
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID, 1 as EmpLevel
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, EmpLevel + 1 ---
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID, 1 as EmpLevel
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, EmpLevel + 1 
FROM Employee as Emp
INNER JOIN EmployeeList as EL ---
ON Emp.ManagerID = El.EmpID ---
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList

------------------


--Grouping Sets 
--

SELECT * FROM SALESINVOICEDETAIL

SELECT INVOICEID, SUM(QUANTITY) AS TOTALUNITS
FROM SALESINVOICEDETAIL
GROUP BY INVOICEID


SELECT PRODUCTID, SUM(QUANTITY) AS TOTALUNITS
FROM SALESINVOICEDETAIL
GROUP BY PRODUCTID

SELECT INVOICEID, NULL AS PRODUCTID,SUM(QUANTITY) AS TOTALUNITS
FROM SALESINVOICEDETAIL
GROUP BY INVOICEID

UNION

SELECT NULL AS INVOICEID, PRODUCTID, SUM(QUANTITY) AS TOTALUNITS
FROM SALESINVOICEDETAIL
GROUP BY PRODUCTID

SELECT INVOICEID, PRODUCTID, SUM(QUANTITY) AS TOTALUNITS
 FROM SALESINVOICEDETAIL
GROUP BY GROUPING SETS (INVOICEID, PRODUCTID)
ORDER BY INVOICEID, PRODUCTID

SELECT * 
FROM VSALES


SELECT CUSTOMERID, NULL AS PRODUCTID, NULL AS ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM vSALES
GROUP BY CUSTOMERID

UNION

SELECT NULL AS CUSTOMERID, NULL AS ORDERYEAR, PRODUCTID, SUM(QUANTITY) AS TOTALUNITS
FROM SALES
GROUP BY PRODUCTID

UNION

SELECT NULL AS CUSTOMERID, NULL AS PRODUCTID, ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM SALES
GROUP BY ORDERYEAR


SELECT CUSTOMERID, PRODUCTID, ORDERYEAR 
FROM VSALES
GROUP BY CUSTOMERID, PRODUCTID,ORDERYEAR

SELECT CUSTOMERID, PRODUCTID, ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM VSALES
GROUP BY GROUPING SETS (CUSTOMERID, PRODUCTID, ORDERYEAR)

----------------------------------------------------------

---LOW LEVEL AND HIGH LEVER GRANULARITY

SELECT * FROM EMPLOYEE 
WHERE LOCAITONID IS NOT NULL;


--
SELECT LOCATIONID, COUNT(*) AS EMPCT
 FROM EMPLOYEE 
WHERE LOCAITONID IS NOT NULL;
GROUP BY LOCATIONID


SELECT MANAGERID, COUNT(*) AS EMPCT
 FROM EMPLOYEE 
WHERE MANAGERID IS NOT NULL;
GROUP BY MANAGERID

SELECT LOCATIONID, MANAGERID, COUNT(*) AS EMPCT
 FROM EMPLOYEE 
WHERE MANAGERID IS NOT NULL AND MANAGERID IS NOT NULL
GROUP BY LOCATIONID,MANAGERID


SELECT LOCATIONID, MANAGERID, COUNT(*) AS EMPCT
 FROM EMPLOYEE 
WHERE MANAGERID IS NOT NULL AND MANAGERID IS NOT NULL
GROUP BY GROUPING SETS (LOCATIONID,MANAGERID)

SELECT LOCATIONID, MANAGERID, COUNT(*) AS EMPCT
 FROM EMPLOYEE 
WHERE MANAGERID IS NOT NULL AND MANAGERID IS NOT NULL
GROUP BY GROUPING SETS ((LOCATIONID,MANAGERID))

SELECT LOCATIONID, MANAGERID, COUNT(*) AS EMPCT
 FROM EMPLOYEE 
WHERE MANAGERID IS NOT NULL AND MANAGERID IS NOT NULL
GROUP BY GROUPING SETS 
(
(LOCATIONID),
(MANAGERID),
(LOCATIONID, MANAGERID)
)

-------------------------------------------------------------------

--1 SET
SELECT CUSTOMERID, PRODUCTID, ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM VSALES
GROUP BY GROUPING SETS (CUSTOMERID, PRODUCTID, ORDERYEAR)

--2 SETS
SELECT CUSTOMERID, PRODUCTID, ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM VSALES
GROUP BY GROUPING SETS ((CUSTOMERID, PRODUCTID, ORDERYEAR))

--3 SETS
SELECT CUSTOMERID, PRODUCTID, ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM VSALES
GROUP BY GROUPING SETS (CUSTOMERID, PRODUCTID,
(CUSTOMERID, PRODUCTID, ORDERYEAR)
)

--4 SETS
SELECT CUSTOMERID, PRODUCTID, ORDERYEAR, SUM(QUANTITY) AS TOTALUNITS
FROM VSALES
GROUP BY GROUPING SETS (CUSTOMERID, PRODUCTID, ORDERYEAR,
(CUSTOMERID, PRODUCTID, ORDERYEAR)
)

-- 10.1 CTE COMMON TABLE EXPRESSIONS

SELECT FIRSTNAME, LASTNAME, EMPID, LOCATIONID
FROM EMPLOYEE
ORDER BY LASTNAME, FIRSTNAME

SELECT FIRSTNAME, LASTNAME, EMPID, LOCATIONID,
ROW_NUMBER() OVER(ORDER BY LASTNAME, FIRSTNAME) 
FROM EMPLOYEE

--INVALID
SELECT FIRSTNAME, LASTNAME, EMPID, LOCATIONID,
ROW_NUMBER() OVER(ORDER BY LASTNAME, FIRSTNAME) AS POSITION 
FROM EMPLOYEE
WHERE POSITION - 10


--AS CTE
SELECT * FROM EMPSORT
(SELECT FIRSTNAME, LASTNAME, EMPID, LOCATIONID,
ROW_NUMBER() OVER(ORDER BY LASTNAME, FIRSTNAME) AS POSITION 
FROM EMPLOYEE) AS EMPSORT
WHERE POSITION - 10 -- ALLOWS TO PREDICATE ON THE POSITION FIELD

WITH EMPSORT AS
(
SELECT FIRSTNAME, LASTNAME, EMPID, LOCATIONID,
ROW_NUMBER() OVER(ORDER BY LASTNAME, FIRSTNAME) AS POSITION 
FROM EMPLOYEE
)
SELECT * FROM EMPSORT 
WHERE POSITION = 10

-----Pivot

select * from vProductList

--aggregate 

select Category, SupplierID, Count(productid)
 from vProductList
group by Category, SupplierID


select * from vProductList
pivot
(
count(productid)
for supplierid in
([0],[1],[2],[3])
) as pvt


select category, [0] as Sup0, [1] as Sup1, [2] as Sup2, [3] as Sup3
  from vProductList
 pivot
(
count(productid)
for supplierid in
([0],[1],[2],[3])
) as pvt


select * from currentproducts
select * from vProductList


select * 
from currentproducts
pivot
(
count(productid)
for supplierid in
([0],[1],[2],[3])
) as pvt



select category, [0],[1],[2],[3]
from currentproducts
pivot
(
count(productid)
for supplierid in
([0],[1],[2],[3])
) as pvt


-- view created
select category, [0],[1],[2],[3]
from vproductslist
pivot
(
count(productid)
for supplierid in
([0],[1],[2],[3])
) as pvt


--create a product list derived table


select category, [0],[1],[2],[3] FROM
	(SELECT * 
	   FROM CURRENTPRODUCTS) AS PRODUCTLIST
	  pivot
	  (
	   count(productid)
	   for supplierid in
	   ([0],[1],[2],[3])
	  ) as pvt


select category, [0],[1],[2],[3] FROM
	(SELECT PRODUCTID, CATEGORY, SUPPLIERID
	   FROM CURRENTPRODUCTS) AS PRODUCTLIST
	  pivot
	  (
	   count(productid)
	   for supplierid in
	   ([0],[1],[2],[3])
	  ) as pvt


--DB_BASICS db

SELECT DEPT, LOCATIONID, COUNT(EMPNO)
FROM EMPLOYEE
WHERE LOCATIONID IS NOT NULL
GROUP BY DEPT, LOCATIONID

SELECT DEPT, LOCATIONID, EMPNO
FROM EMPLOYEE
WHERE LOCATIONID IS NOT NULL

SELECT * FROM 
(SELECT DEPT, LOCATIONID, EMPNO
FROM EMPLOYEE
WHERE LOCATIONID IS NOT NULL) AS EMPLIST
PIVOT
(COUNT(EMPNO)
FOR LOCATIONID IN [1],[2])
) AS PVT


SELECT * FROM 
(SELECT DEPT, LOCATIONID, EMPNO
FROM EMPLOYEE
WHERE LOCATIONID IS NOT NULL) AS EMPLIST
PIVOT
(COUNT(EMPNO)
FOR DEPT IN [Admin],[Education],[RND],[sales])
) AS PVT


--UNPIVOT

--RESET SCRIPT SQLQueriesChapter10.0SpecialSetup.sql script

SELECT * FROM CATEGORYGRID


SELECT category, [internal], [stay way away and save], [LaVue Connect], [More Shores Amigo] 
FROM CATEGORYGRID


select * from
(SELECT category, [internal], [stay way away and save], [LaVue Connect], [More Shores Amigo] 
FROM CATEGORYGRID) as Products
unpivot
(Salescount
for suppliername in (
[internal], 
[stay way away and save], 
[LaVue Connect], 
[More Shores Amigo])
) as UNPVT



--11.1: Self Joins

SELECT *
FROM Employee

SELECT *
FROM Employee
WHERE ManagerID = 11 --Who works for Sally



SELECT *
FROM Employee

SELECT *
FROM vBossList

SELECT *
FROM Employee em INNER JOIN VBossList bl
ON em.ManagerID = bl.empID



SELECT *
FROM Employee

SELECT *
FROM Employee

SELECT *
FROM Employee E1
INNER JOIN Employee BL
ON.ManagerID = BL.EmpID


--Book 2; 11.2 Range Hierarchies

SELECT *
FROM [Grant] as Gr
ORDER BY Gr.Amount

SELECT *
FROM [Grant] as LgGr
INNER JOIN [Grant] SmGr
ON LgGr.Amount > SmGr.Amount
ORDER BY LgGr.Amount

SELECT LgGr.*, SmGr.GrantName, SmGr.Amount
FROM [Grant] as LgGr
INNER JOIN [Grant] SmGr
ON LgGr.Amount > SmGr.Amount
ORDER BY LgGr.Amount



SELECT *
FROM CurrentProducts SCP
ORDER BY SCP.RetailPrice

SELECT *
FROM CurrentProducts SCP
WHERE SCP.Category = 'No-Stay'
ORDER BY SCP.RetailPrice

SELECT *
FROM CurrentProducts SCP 
INNER JOIN CurrentProducts LCP
ON SC.RetailPrice > LCP.RetailPrice
WHERE SCP.Category = 'No-Stay'
ORDER BY SCP.RetailPrice

SELECT SCP.ProductName, SCP.RetailPrice,
LCP.ProductName, LCP.RetailPrice
FROM CurrentProducts SCP 
INNER JOIN CurrentProducts LCP
ON SC.RetailPrice > LCP.RetailPrice
WHERE SCP.Category = 'No-Stay'
ORDER BY SCP.RetailPrice


--Book 2; 11.3 Recursive Queries

SELECT EmpID, FirstName, LastName, ManagerID
FROM Employee


--Show up to 1:50


SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID, 1 as EmpLevel ---
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, 2 as EmpLevel --
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID, 1 as EmpLevel
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, EmpLevel + 1 ---
FROM Employee as Emp
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



WITH EmployeeList AS
(SELECT BOSS.EmpID, BOSS.FirstName, BOSS.LastName, BOSS.ManagerID, 1 as EmpLevel
FROM Employee as BOSS
WHERE BOSS.ManagerID IS NULL

UNION ALL

SELECT Emp.EmpID, Emp.FirstName, Emp.LastName, Emp.ManagerID, EmpLevel + 1 
FROM Employee as Emp
INNER JOIN EmployeeList as EL ---
ON Emp.ManagerID = El.EmpID ---
WHERE Emp.ManagerID IS NOT NULL)
SELECT * FROM EmployeeList



-----------------------------

--12.1 Basic Subqueries

SELECT *
FROM CurrentProduct

SELECT *
FROM SalesInvoiceDetail
--But what products have never sold?


SELECT ProductID
FROM SalesInvoiceDetail

SELECT DISTINCT ProductID
FROM SalesInvoiceDetail


SELECT *
FROM CurrentProduct
WHERE ProductID NOT IN (23,69,15,72...)

SELECT *
FROM CurrentProduct
WHERE ProductID NOT IN (SELECT DISTINCT ProductID
			FROM SalesInvoiceDetail)




SELECT *
FROM CurrentProducts

SELECT *
FROM Supplier --3 Supplier 
--What products from Supplier#2?


SELECT *
FROM CurrentProducts
WHERE SupplierID = 2

SELECT *
FROM CurrentProducts
WHERE SupplierID = (	SELECT SupplierID
			FROM Supplier
			WHERE SupplierName = 'LaVue Connect')


SELECT *
FROM CurrentProduct

SELECT *
FROM SalesInvoiceDetail
--But what products have never sold?


SELECT ProductID
FROM SalesInvoiceDetail

SELECT DISTINCT ProductID
FROM SalesInvoiceDetail


SELECT *
FROM CurrentProduct
WHERE ProductID NOT IN (23,69,15,72...)

SELECT *
FROM CurrentProduct
WHERE ProductID NOT IN (SELECT DISTINCT ProductID
			FROM SalesInvoiceDetail)


----------------


--Book2  12.2 Correlated Subqueries

SELECT * 
FROM Location as L

SELECT E.LocationID, Count(*)
FROM Employee as E
GROUP BY E.LocationID



SELECT * , (	SELECT E.LocationID, Count(*)
		FROM Location as E
		GROUP BY E.LocationID)
FROM Location as L


SELECT * , (	SELECT Count(*)
		FROM Location as E
		WHERE E.LocationID = L.LocationID)
FROM Location as L

SELECT * , (	SELECT Count(*)
		FROM Location as E
		WHERE E.LocationID = L.LocationID) AS empCt
FROM Location as L



SELECT *
FROM Employee AS Em

SELECT Gr.EmpID, Count(*)
FROM [Grant] as Gr
GROUP BY Gr.EmpID


SELECT FirstName, LastName, 1 As GrantCount
FROM Employee AS Em

SELECT Gr.EmpID, Count(*)
FROM [Grant] as Gr
GROUP BY Gr.EmpID


SELECT FirstName, LastName, (	SELECT Gr.EmpID, Count(*)
				FROM [Grant] as Gr
				GROUP BY Gr.EmpID) As GrantCount
FROM Employee AS Em


SELECT FirstName, LastName, (	SELECT Count(*)
				FROM [Grant] as Gr
				WHERE Gr.EmpID = Em.EmpID) As GrantCount
FROM Employee AS Em



----Book2  12.3 Subquery Extensions 

SELECT *
FROM Customer --What are these customers buying patterns

SELECT *
FROM vSales
WHERE CustomerID = 3 --Patricia
--Buys from 2 to 4 quantities Never bought 5 before

SELECT *
FROM vSales
WHERE CustomerID = 4 
--Buys from 2 to 5

SELECT *
FROM vSales
WHERE CustomerID = 2
--Buys from 1 to 5



SELECT *
FROM Customer
WHERE 5 > ALL ()


SELECT *
FROM Customer
WHERE 5 > ALL (SELECT Quantity
		FROM vSales)

SELECT *
FROM Customer
WHERE 5 > ALL (SELECT Quantity
		FROM vSales
		WHERE Customer.CustomerID = VSales.CustomerID)

SELECT *
FROM vSales
WHERE CustomerID = 1 --Then 2 Then 3 Then to see the highs and lows


SELECT *
FROM Customer
WHERE 2 > ANY ()



SELECT *
FROM Customer
WHERE 2 > ANY (SELECT Quantity
		FROM vSales
		WHERE vSales.CustomerID = Customer.CustomerID)

SELECT *
FROM Customer
WHERE 2 > ALL (SELECT Quantity
		FROM vSales
		WHERE vSales.CustomerID = Customer.CustomerID)

SELECT *
FROM Customer
WHERE 2 > SOME (SELECT Quantity
		FROM vSales
		WHERE vSales.CustomerID = Customer.CustomerID)




----------------

--truncating

CREATE TABLE Contractor
(
ctrID int IDENTITY PRIMARY KEY,
lastname varchar(30) NOT NULL,
firstname varchar(30) NOT NULL,
hiredate datetime NOT NULL,
LocationID INT NULL
)

SELECT *
FROM Contractor

INSERT INTO Contractor VALUES ('Disarray','Major','01/02/2008',1)
INSERT INTO Contractor VALUES ('Morelan','Rick','02/27/2008',1)
INSERT INTO Contractor VALUES ('Plummer','Joe','01/13/2008',2)
INSERT INTO Contractor VALUES ('Kim','Gene','01/13/2008',1)
GO
--4 Fiedls into a 5 field table (Identity is there).

SELECT *
FROM Contractor

DELETE FROM Contractor

INSERT INTO Contractor VALUES ('Disarray','Major','01/02/2008',1)
INSERT INTO Contractor VALUES ('Morelan','Rick','02/27/2008',1)
INSERT INTO Contractor VALUES ('Plummer','Joe','01/13/2008',2)
INSERT INTO Contractor VALUES ('Kim','Gene','01/13/2008',1)

SELECT *
FROM Contractor --ID are now 5,6,7, and 8

TRUNCATE TABLE Contractor

SELECT *
FROM Contractor --ID goes from 1 to 4 now.


DELETE FROM Contractor WHERE ContractorID = 1
TRUNCATE Contractor WHERE ContractorID = 1 --Does not work

--Truncate runs faster
--Truncate does not log transactions
--Truncate does not work with HERE


------------------------


--CROSS APPLY

SELECT *
FROM SalesInvoice as si  --We cant tell how many items were in InvoiceID 1 or any other invoice. 


SELECT *
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID --but what is the price

SELECT *
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID

SELECT si.InvoiceID, si.CustomerID, si.OrderDate,
sd.ProductID, sd.Quantity,
cp.ProductName, sd.Quantity, cp.RetailPrice
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID

SELECT si.InvoiceID, si.CustomerID, si.OrderDate,
sd.ProductID, sd.Quantity,
cp.ProductName, sd.Quantity, cp.RetailPrice
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID
WHERE si.CustomerID 1 -- Try 3 also


SELECT *
FROM dbo.fn_GetCustomerOrders(1) --Try 3 also

SELECT * FROM Customer

SELECT *
FROM Customer as cu
INNER JOIN dbo.fn_GetCustomerOrders(cu.CustomerID) --Does not work

SELECT *
FROM Customer as cu
CROSS APPLY dbo.fn_GetCustomerOrders(cu.CustomerID) --This works

SELECT *
FROM Customer as cu
CROSS APPLY dbo.fn_GetCustomerOrders(cu.CustomerID) 
ORDER BY cu.CustomerID




-------------------



-- OUter Apply

SELECT *
FROM Customer
WHERE CUstomerID = 1 --How many products has he ordered?

SELECT *
FROM fn_GetCustomerOrders(1) --Try 2 and 3 for both queries
--Notice 5 and 7 have not yet orderd 



SELECT *
FROM Customer as cu
CROSS APPLY fn_GetCustomerOrders(cu.CustomerID) --Will not show 5 and 7

SELECT *
FROM Customer as cu
OUTER APPLY fn_GetCustomerOrders(cu.CustomerID) --Will show 5 and 7

------------------


--Book2 14.1 Using Merge

SELECT * FROM [Grant] --Grant 10 will be change Name and Amount

CREATE PROC UpdateGrant @GrID char(3), @GrName varchar(50),
@EmID int, @Amt smallmoney
AS
	UPDATE [Grant] 
	SET GrantName = @GrName, EmpID = @EmID , Amount = @Amt 
	WHERE GrantID = @GrID 

-----------------
SELECT * FROM [Grant]
EXEC UpdateGrant '010','Call Mom',5,9900
SELECT * FROM [Grant]

EXEC UpdateGrant '011','Big Giver Tom',7,95900 --Does not work with inserts
-------------------

CREATE PROC UpsertGrant @GrID char(3), @GrName varchar(50),
@EmID int, @Amt smallmoney
AS
	MERGE [Grant] as gr
	USING (SELECT @GrID ,@GrName ,@EmID ,@Amt ) as 
			Grantsrc (GrantID, GrantName, EmpID, Amount)
	ON gr.GrantID = Grantsrc.GrantID
	WHEN MATCHED THEN
		UPDATE SET gr.GrantName = Grantsrc .GrantName, gr.EmpID = Grantsrc.EmpID,
		gr.Amount = Grantsrc.Amount

	WHEN NOT MATCHED THEN
		INSERT (GrantID, GrantName, EmpID, Amount)
		VALUES (Grantsrc.GrantID, Grantsrc.GrantName, Grantsrc.EmpID, Grantsrc.Amount);

------Seperate Window
SELECT *
FROM [Grant]

EXEC UpsertGrant '010','Call Mom',5,9900
EXEC UpsertGrant '011','Big Giver Tom',7,95900



SELECT * FROM [Grant]

SELECT * FROM [GrantFeed] --Two records, one is new, one is an update
--Seperate Window
MERGE [Grant] as gr
USING GrantFeed as gf
ON gr.GrantID = gf.GrantID
WHEN MATCHED THEN
	UPDATE SET gr.GrantName = 	gf.GrantName,	gr.Amount = gf.Amount, gr.EmpID = gf.EmpID
WHEN NOT MATCHED THEN
	INSERT (GrantID, GrantName, EmpID, Amount)
	VALUES (gf.GrantID, gf.GrantName, gf.EmpID, gf.Amount);
	
-------------------------


--Book 2 14.2 Merge Updating Options 

SELECT * FROM [Grant] --Target
SELECT * FROM [GrantFeed] --Source


SELECT * FROM ORDER BY GrantID [Grant] --Target
SELECT * FROM ORDER BY GrantID [GrantFeedCheckMaster] --Source
--If not matched by target then insert
--If not matched by source then delete


MERGE [Grant] as gr
USING GrantCheckMaster as gcm
ON gr.GrantID = gcm.GrantID
WHEN MATCHED THEN --Update
WHEN NOT MATCHED BY TARGET THEN --Insert
WHEN NOT MATCHED BY SOURCE THEN --Delete
DELETE;

MERGE [Grant] as gr
USING GrantCheckMaster as gcm
ON gr.GrantID = gcm.GrantID
WHEN MATCHED THEN
	update SET gr.EmpID = gcm.EmpID,
	gr.GrantName = gcm.GrantName,
	gr.Amount = gcm.Amount
WHEN NOT MATCHED BY TARGET
	INSERT (GrantID, GrantName, EmpID, Amount)
	VALUES (gcm.GrantID, gcm.GrantName, gcm.EmpID, gcm.Amount)
WHEN NOT MATCHED BY SOURCE
DELETE;




SELECT * FROM Employee
--Phil works for Manager 4
SELECT * FROM PromotionList
--Phil works for Manager 11
--Fact EmpID 14 will be inserted.
--Fact EmpID 10,11,12 there is no change
--Fact EmpID 13 Phil will have a new boss
--1 Insert, 1 Update, 1 Delete

MERGE Employee AS em
USING PromotionList as pl
ON em.EmpID = pl.EmpID
WHERE MATCHED AND NOT (em.ManagerID = pl.ManagerID) THEN --Update	
WHEN NOT MATCHED THEN --Insert


MERGE Employee AS em
USING PromotionList as pl
ON em.EmpID = pl.EmpID
WHERE MATCHED AND NOT (em.ManagerID = pl.ManagerID) THEN
	UPDATE SET em.ManagerID = pl.ManagerID
WHEN NOT MATCHED THEN
	INSERT (EmpID, LastName, FirstName, HireDate,
		LocationID, ManagerID, [Status])
	VALUES (pl.EmpID, pl.LastName, pl.FirstName, pl.HireDate,
		pl.LocationID, pl.ManagerID, pl.[Status]);


--------------------
--15.1 Using OUTPUT

DELETE 
FROM Location
WHERE [State] = 'WA'

DELETE 
FROM Location
OUTPUT deleted.*
WHERE [State] = 'WA'


INSERT INTO Location
OUTPUT Inserted.*
VALUES(6,'678 CanDo St','Portland','OR')

SELECT * FROM Location



UPDATE Location
SET City = 'Kirkland'
WHERE LocationID = 1

SELECT * FROM Location WHERE LocationID = 1

UPDATE Location
SET City = 'Tacoma'
OUTPUT Deleted.*
WHERE LocationID = 1

UPDATE Location
SET City = 'Seattle'
OUTPUT Inserted.*
WHERE LocationID = 1

UPDATE Location
SET City = 'Anacortes'
OUTPUT Inserted.*, Deleted.*
WHERE LocationID = 1



--Run the reset script
DELETE 
FROM Location
OUTPUT deleted.*
WHERE [State] = 'WA'

SELECT * FROM Deleted --Error (scope is done)


--Run the reset script
SELECT *
FROM Location

SELECT *
FROM LocationChanges

DELETE 
FROM Location
OUTPUT deleted.* INTO LocationChanges
WHERE [State] = 'WA'

--Run reset script
--Lets change WA to WS
UPDATE Location
SET [state] = 'WS'
WHERE [State] = 'WA'

UPDATE Location
SET [state] = 'WS'
OUTPUT Inserted.* 
WHERE [State] = 'WA'

Insert into LocationChanges
SELECT * FROM 
  (UPDATE Location
  SET [state] = 'WS'
  OUTPUT Inserted.* 
  WHERE [State] = 'WA') as LocIns

SELECT *
FROM Location

SELECT *
FROM LocationChanges





--Book 2  15.2 Output code combinations 

SELECT *
FROM mgmtTraining

DELETE FROM mgmtTraining
OUTPUT Deleted.*
WHERE ClassID = 8

INSERT INTO TrainingChangeLog
SELECT * FROM
  (DELETE FROM mgmtTraining
  OUTPUT Deleted.*, GetDate()
  WHERE ClassID = 8) as TrainChange

SELECT * FROM mgmtTraining

SELECT * FROM TrainingChangeLog



--Now make an update
SELECT * FROM mgmtTraining --40 hours will become 32
SELECT * FROM TrainingChangeLog

UPDATE mgmTraining
SET ClassDurationHours = 32
WHERE ClassID = 3

UPDATE mgmTraining
SET ClassDurationHours = 32
OUTPUT Inserted.*, GetDate()
WHERE ClassID = 3)

INSERT INTO TrainingChangeLog
  (UPDATE mgmTraining
  SET Inserted.*, GetDate()
  OUTPUT ClassDurationHours = 32) as UpdateChange


  WHERE ClassID = 3)



--String Functions

SELECT FirstName, LastName
FROM Employee --First names seem to vary from 3 to 8 letters long

SELECT FirstName, LastName, Len(FirstName) as FNameSize
FROM Employee

SELECT FirstName, LastName, Len(FirstName) as FNameSize,
Len(LastName) as LNameSize
FROM Employee



SELECT FirstName, LastName, UPPER(FirstName) as UpperFName,
LOWER(LastName) as LowerLName
FROM Employee


SELECT FirstName, LastName, LEFT(FirstName,2) AS PreFName,
RIGHT(FirstName,3) as EndFName
FROM Employee


SELECT FirstName
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,1)
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,2)
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,Len(FirstName)-2)
FROM Employee

