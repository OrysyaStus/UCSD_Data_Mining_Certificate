Volume 2 SQL Queries 2012 Joes 2 Pros

*/


/*
Section  3.1 - run setup 3.1
Working with NULLS 

--EMPLOYEE TABLE DESIGN
USE [JProCo]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Employee](
	[EmpID] [int] NOT NULL,
	[LastName] [varchar](30) NULL,
	[FirstName] [varchar](20) NOT NULL,
	[HireDate] [datetime] NULL,
	[LocationID] [int] NULL,
	[ManagerID] [int] NULL,
	[Status] [char](12) NULL,
 PRIMARY KEY CLUSTERED 
  ([EmpID] ASC) WITH 
       ( PAD_INDEX  = OFF, 
         STATISTICS_NORECOMPUTE = OFF, 
         IGNORE_DUP_KEY = OFF, 
         ALLOW_ROW_LOCKS  = ON, 
         ALLOW_PAGE_LOCKS  = ON
       ) ON [PRIMARY]
  ) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

*/

SELECT * FROM Employee

SELECT * FROM Employee
where Lastname = 'Smith'

SELECT * FROM Employee
where Lastname <> 'Smith'

-- Hire a new employee as pending hire create a record with NULL values
INSERT INTO Employee
VALUES (13, NULL, 'Phil', NULL, 1, 4, 'Pending Hire')

SELECT * FROM Employee
where Lastname IS NULL


SELECT * FROM Employee
where Status IS NULL

--change predicate to not null
SELECT * FROM Employee
where Status IS NOT NULL

UPDATE Employee
SET [Status] = 'Active'
WHERE Status IS NULL

SELECT * FROM Employee
ORDER BY Status DESC


UPDATE Employee
SET [Status] = NULL
WHERE Status = 'Active'


/*

SECTION 3.2 - Run Setup 3.2
DERIVED OR EXPRESSION FIELDS


Precision and Scale

*/


-- Using concatenations

SELECT EmpID, Firstname, Lastname 
 FROM Employee

SELECT EmpID, Firstname + ' ' + Lastname AS FullName
 FROM Employee

SELECT ProductName, RetailPrice
FROM CurrentProducts

SELECT ProductName, 
       RetailPrice, 
       RetailPrice * 1.1 AS Cnd$
  FROM CurrentProducts

/*

Decimals
Precision and Scale

1234.5  (5,1)
1.2345  (5,4)

1.2     (2,1)
14.5    (3,1)
14.45   (4,2)
985.1   (4,1)
9982.16 (6,2)




*/

SELECT ProductName, 
       RetailPrice, 
       RetailPrice * 1.1 AS Cnd$
  FROM CurrentProducts


SELECT ProductName, 
       RetailPrice, 
  CAST(RetailPrice * 1.1 AS decimal(6,2)) Cnd$
  FROM CurrentProducts  
SELECT ProductName, 
       RetailPrice, 
       RetailPrice * 1.1(6,0) Cnd$
  FROM CurrentProducts

SELECT CAST((10.5) AS DECIMAL(3,0)) + 0.1 
SELECT ROUND(3.85,2)
SELECT ROUND(3.85,1)
SELECT ROUND(3.85,0)
SELECT ROUND(3.85,3)

SELECT ROUND(3.5,0) + 6




SELECT 3.850
SELECT ROUND(3.850,2)
SELECT ROUND(3.850,1)
SELECT ROUND(3.850,0)
SELECT ROUND(3.850,3)
SELECT ROUND(3.850,4)

SELECT 4 
SELECT ROUND(4,2)
SELECT ROUND(4,1)
SELECT ROUND(4,0)
SELECT ROUND(4,3)


SELECT ProductName, 
       RetailPrice, 
  CAST(RetailPrice AS decimal(6,2)) as Price
  FROM CurrentProducts


SELECT ProductName, 
       RetailPrice, 
  CAST(RetailPrice AS decimal(6,2)) as Price,
  ROUND(RetailPrice,2) AS RoundedPrice
  FROM CurrentProducts

SELECT ProductName, 
       RetailPrice, 
  CAST(RetailPrice AS decimal(6,1)) as Price,
  ROUND(RetailPrice,2) AS Round2Price,
  ROUND(RetailPrice,1) AS Round1Price 
  FROM CurrentProducts
  
  
  SELECT ProductName, 
       RetailPrice, 
  CAST(RetailPrice AS decimal(6,2)) as Price,
  ROUND(RetailPrice,2) AS Round2Price,
  ROUND(RetailPrice,1) AS Round1Price,
  ROUND(RetailPrice,0) AS Round0Price 
  FROM CurrentProducts

-----------------

SELECT FirstName, LastName, HireDate
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 
 SELECT FirstName + ' ' + LastName AS FullName, 
        HireDate
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 ORDER BY FullName
 
 
 SELECT FirstName + ' ' + LastName AS FullName, 
 CONVERT(nvarchar,HireDate,101)
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 ORDER BY FullName
 
 
 SELECT FirstName + ' ' + LastName AS FullName, 
 CONVERT(nvarchar,HireDate,102)
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 ORDER BY FullName
 

 SELECT FirstName + ' ' + LastName AS FullName, 
 CONVERT(nvarchar,HireDate,101) as HireDate
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 ORDER BY HireDate
 
-- Sorting based on the original data 
SELECT FirstName + ' ' + LastName AS FullName, 
 CONVERT(nvarchar,HireDate,101) as HiredDate
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 ORDER BY HireDate
 
SELECT FirstName + ' ' + LastName AS FullName, 
 CONVERT(nvarchar,HireDate,101) as HireDate
  FROM Employee 
 WHERE HireDate >= '1/1/2000'
 ORDER BY Employee.HireDate

/*
Section 3.3 - run setup 3.3
IDENTITY FIELDS


*/


SELECT * FROM CurrentProducts

-- 6 POINTS OF DATA DUE TO 6 FIELDS

INSERT INTO CurrentProducts
VALUES(481, 'Yoga Mtn Getaway 5 Days', 875.00, '12/1/2012', 0, 'Medium-Stay')

-- ProductID field is an Identity Field


INSERT INTO CurrentProducts
VALUES('Yoga Mtn Getaway 5 Days', 875.00, '12/1/2012', 0, 'Medium-Stay')


INSERT INTO CurrentProducts
VALUES('Yoga Mtn Getaway 1 Week', 875.00, GETDATE(), 0, 'Long-Term')

-----

SELECT GETDATE()
--differentiate with CURRENT_TIMESTAMP



INSERT INTO CurrentProducts
VALUES('Yoga Mtn Getaway 2 Week', 875.00, CURRENT_TIMESTAMP, 0, 'Long Term')

SELECT CURRENT_TIMESTAMP


SELECT GETDATE(), -- FUNCTION - MS specific
       CURRENT_TIMESTAMP -- Property does not need parenthesis and an ANSI std

SELECT * FROM CurrentProducts
WHERE ProductName Like '%yoga%';


DELETE FROM CurrentProducts WHERE ProductName LIKE '%YOGA%';


SELECT * FROM CurrentProducts

INSERT INTO CurrentProducts
VALUES('Yoga Mtn Getaway 5 Days', 875.00, '12/1/2012', 0, 'Medium-Stay')


SET IDENTITY_INSERT CurrentProducts ON

INSERT INTO CurrentProducts
VALUES(482, 'Yoga Mtn Getaway 5 Days', 875.00, '12/1/2012', 0, 'Medium-Stay')

INSERT INTO CurrentProducts
(ProductID,ProductName,RetailPrice,OriginationDate,ToBeDeleted,Category)
VALUES(486,'Yoga Mtn Getaway 5 Days', 875.00, '12/1/2012', 0, 'Medium-Stay')


SET IDENTITY_INSERT CurrentProducts OFF


/*
SECTION 4.1 - run setup 4.1
USING GROUP BY

*/

SELECT * 
FROM [GRANT]

SELECT GrantName, Amount, EmpID
FROM [GRANT]



SELECT DISTINCT EmpID
FROM [GRANT]

--or Using Group By

SELECT EmpID
FROM [Grant]
GROUP BY EmpID


SELECT EmpID, Sum(Amount)
FROM [Grant]
GROUP BY EmpID


SELECT EmpID, Count(Amount)
FROM [Grant]
GROUP BY EmpID

SELECT EmpID, MAX(Amount)
FROM [Grant]
GROUP BY EmpID

SELECT EmpID, Sum(Amount) AS TotalAmount
FROM [Grant]
GROUP BY EmpID

--Using Group By with a JOIN

SELECT * FROM Employee AS emp
INNER JOIN Location as loc
ON emp.LocationID = loc.LocationID

SELECT * FROM Employee AS emp
FULL OUTER JOIN Location as loc
ON emp.LocationID = loc.LocationID



SELECT city, Firstname
 FROM Employee AS emp
FULL OUTER JOIN Location as loc
ON emp.LocationID = loc.LocationID

-- Counting FirstNames by City
SELECT city, count(Firstname)
 FROM Employee AS emp
FULL OUTER JOIN Location as loc
ON emp.LocationID = loc.LocationID
GROUP BY city


SELECT city, count(*)
 FROM Employee AS emp
FULL OUTER JOIN Location as loc
ON emp.LocationID = loc.LocationID
GROUP BY city

-- difference from counting values and counting records

SELECT * FROM Employee AS EMP
INNER JOIN [Grant] AS GR
ON EMP.EmpID = GR.EmpID

SELECT distinct Firstname, LastName --COUNT(GrantName) NumberOfGrants
FROM Employee AS EMP
INNER JOIN [Grant] AS GR
ON EMP.EmpID = GR.EmpID
--GROUP BY Firstname


SELECT Firstname, LastName, COUNT(GrantName) 
FROM Employee AS EMP
INNER JOIN [Grant] AS GR
ON EMP.EmpID = GR.EmpID
GROUP BY Firstname, Lastname

select * from Employee

insert into Employee
values(14, 'Marshbank','John', GETDATE(), 2, 11, 'Has Tenure')
 
 select distinct firstname, lastname, ManagerID
  from Employee
 

select * from [Grant]

/*

SECTION 4.2 - Run setup 4.2
Filtering Aggregated Data

*/

SELECT LocationID, COUNT(*)
FROM Employee
GROUP BY LocationID


SELECT LocationID, COUNT(*)
FROM Employee
WHERE COUNT(*) > 2  -- WHERE clause does not support aggregated fields 
GROUP BY LocationID

SELECT LocationID, COUNT(*)
FROM Employee
where LocationID in(1,2,4)
GROUP BY LocationID
HAVING COUNT(*) > 1 -- instead, HAVING clause supports aggregated fields


SELECT LOC.[STATE], EMP.Firstname
FROM Location AS LOC
FULL OUTER JOIN Employee AS EMP
ON LOC.LocationID = EMP.LocationID


SELECT LOC.[STATE], COUNT(EMP.Firstname)
FROM Location AS LOC
FULL OUTER JOIN Employee AS EMP
ON LOC.LocationID = EMP.LocationID
GROUP BY LOC.state


SELECT LOC.[STATE], COUNT(EMP.Firstname)
FROM Location AS LOC
FULL OUTER JOIN Employee AS EMP
ON LOC.LocationID = EMP.LocationID
GROUP BY LOC.state
HAVING COUNT(EMP.Firstname) > 2


SELECT FIRSTNAME, LASTNAME, AMOUNT
FROM Employee AS E
INNER JOIN [Grant] AS G
ON E.EmpID = G.EmpID


SELECT FIRSTNAME, LASTNAME, SUM(AMOUNT)
FROM Employee AS E
INNER JOIN [Grant] AS G
ON E.EmpID = G.EmpID
GROUP BY Firstname, Lastname
HAVING SUM(AMOUNT) > 40000


SELECT FIRSTNAME, LASTNAME, SUM(AMOUNT)
FROM Employee AS E
INNER JOIN [Grant] AS G
ON E.EmpID = G.EmpID
WHERE Amount > 40000
GROUP BY Firstname, Lastname
HAVING SUM(AMOUNT) > 40000

SELECT FIRSTNAME, LASTNAME, AMOUNT
FROM Employee AS E
INNER JOIN [Grant] AS G
ON E.EmpID = G.EmpID


select * from Employee

select * from [Grant]

update [Grant]
set Amount = 50000.00
where GrantID = 8

SELECT * 
FROM Customer as C
INNER JOIN SalesInvoice AS SV
ON C.CUSTOMERID = SV.CUSTOMERID

SELECT * 
FROM Customer as C
INNER JOIN SalesInvoice AS SV
ON C.CUSTOMERID = SV.CUSTOMERID
WHERE ORDERDATE BETWEEN '1/1/2006' AND '1/1/2007'

SELECT distinct C.* 
FROM Customer as C
INNER JOIN SalesInvoice AS SV
ON C.CUSTOMERID = SV.CUSTOMERID
WHERE ORDERDATE BETWEEN '1/1/2006' AND '1/1/2007'

SELECT ProductID, count(CustomerID) customerCount
FROM vSales
GROUP BY ProductID


/*
SECTION 4.3 - Run Setup 4.3
Aggregations in Stored Procedures

*/

SELECT * FROM CurrentProducts

SELECT Category, COUNT(*)
 FROM CurrentProducts
group by Category


CREATE PROCEDURE GetCategoryCount
AS
BEGIN
	SELECT Category, COUNT(*)
	 FROM CurrentProducts
	group by Category
END


--Run the new procedure in a new window.

EXEC GetCategoryCount

SELECT * FROM Location
-- GET LOCATION COUNT

SELECT * FROM Location AS L
INNER JOIN Employee AS E
ON L.LocationID=E.LocationID


SELECT L.LocationID, COUNT(*)
 FROM Location AS L
INNER JOIN Employee AS E
ON L.LocationID=E.LocationID
GROUP BY L.LocationID


SELECT L.LocationID, COUNT(*)
 FROM Location AS L
LEFT OUTER JOIN Employee AS E
ON L.LocationID=E.LocationID
GROUP BY L.LocationID



SELECT L.LocationID, COUNT(*)
 FROM Location AS L
LEFT OUTER JOIN Employee AS E
ON L.LocationID=E.LocationID
GROUP BY L.LocationID


SELECT L.LocationID, COUNT(EmpID)
 FROM Location AS L
LEFT OUTER JOIN Employee AS E
ON L.LocationID=E.LocationID
GROUP BY L.LocationID
ORDER BY COUNT(EmpID) DESC

CREATE PROC GetLocationCount
BEGIN
	SELECT L.LocationID, COUNT(EmpID)
	 FROM Location AS L
	LEFT OUTER JOIN Employee AS E
	ON L.LocationID=E.LocationID
	GROUP BY L.LocationID
	ORDER BY COUNT(EmpID) DESC
END


/*
SECTION 5.1 

FINDING DUPLICATES

*/

SELECT * FROM Employee

SELECT DISTINCT FirstName
FROM Employee
ORDER BY FirstName

SELECT FirstName, COUNT(*)
 FROM Employee
 GROUP BY FirstName
 --HAVING COUNT(*) > 1
 
SELECT LastName,FirstName, COUNT(*)
FROM Employee
GROUP BY LastName, FirstName
HAVING COUNT(*) > 1




/*
SECTION 5.2 

THE OVER CLAUSE allows you to compare individual records 
to aggregated records while having to group those records.

*/

SELECT * FROM [GRANT]

SELECT SUM(AMOUNT)
FROM [GRANT]


SELECT *, SUM(AMOUNT) -- AGGREGATED FUNCTION NEEDS SOME SUPPORTING LANGUAGE
FROM [GRANT]


SELECT *, SUM(AMOUNT) OVER() AS CompanyTotal
FROM [GRANT]


SELECT *, SUM(AMOUNT) OVER() AS CompanyTotal,
        Amount/ SUM(AMOUNT) OVER() * 100 AS PercentOfTotal
FROM [GRANT]

SELECT FirstName, LastName, LocationID
FROM Employee


SELECT FirstName, LastName, LocationID, 
       COUNT(*) OVER() AS TotalEmp,
       COUNT(*) OVER(PARTITION BY LocationID) AS LocationCount,
       COUNT(*) OVER(PARTITION BY LocationID) * 100.0 /COUNT(*) OVER()
FROM Employee
SELECT FirstName, LastName, LocationID, 
       COUNT(*) OVER() AS TotalEmp,
       COUNT(*) OVER(PARTITION BY LocationID) AS LocationCount,
       COUNT(*) OVER(PARTITION BY LocationID) * 100.0 /COUNT(*) OVER()
FROM Employee
