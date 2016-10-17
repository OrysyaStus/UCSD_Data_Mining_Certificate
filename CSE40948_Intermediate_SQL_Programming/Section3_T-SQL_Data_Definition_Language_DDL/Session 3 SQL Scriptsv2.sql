

--Book 2;  8.1 Union operators

SELECT *
FROM Employee
ORDER BY HireDate ASC


SELECT *
FROM Employee
WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year
ORDER BY HireDate ASC 

SELECT TOP (2) *
FROM Employee
WHERE HireDate >= '7/1/2001' --Get the next two
ORDER BY HireDate ASC 


SELECT *
FROM Employee
WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year
ORDER BY HireDate ASC 

UNION

SELECT TOP (2) *
FROM Employee
WHERE HireDate >= '7/1/2001' --Get the next two
ORDER BY HireDate ASC --Why Eric Bender from 2007 shows up

--Show Video 2:30



SELECT *
FROM Employee
WHERE HireDate < '7/1/2001' --3 Weeks of Vaca per year
ORDER BY HireDate ASC 

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
  ORDER BY HireDate ASC) AS PreJulyEmp

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

SELECT 5, '99 Union Ave','Fargo','ND'



-- Book 2; 8.2 Using Except

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



--Book 2; 9.2 Advanced Clause Combinations

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
ON E1.ManagerID = BL.EmpID


--Book 2; 10.2 Range Hierarchies

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






--Book 3: 2.1 Creating Schemas


USE JProCo
GO


CREATE SCHEMA Purchasing
GO

CREATE SCHEMA Production
GO

CREATE SCHEMA Sales
GO



--Book 3: 2.2 Database Snapshots


USE Master
GO

CREATE DATABASE dbBasics_Monday_noon
ON (NAME = dbBasics,
	FILENAME = 'C:\SQL\DBBasics_SnapshotMonNoon.ss')
AS SNAPSHOT OF dbBasics
GO


update dbBasics.dbo.Employee set LastName ='Santwon' where EmpNo = 106

--Part A (the old record from the snapshot db)

SELECT * FROM dbBasics_Monday_Noon.dbo.Employee
EXCEPT
SELECT * FROM dbBasics.dbo.Employee

--Part B (the new record from the source db)
SELECT * FROM dbBasics.dbo.Employee
EXCEPT
SELECT * FROM dbBasics_Monday_Noon.dbo.Employee



---Book 3 2.3 Database Properties


USE Master 
GO

ALTER DATABASE [RATISCO] SET ANSI_NULLS ON 
GO
ALTER DATABASE [RATISCO] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [RATISCO] SET READ_WRITE
GO


USE Master 
GO

ALTER DATABASE [RATISCO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RATISCO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RATISCO] SET READ_ONLY
GO



--Book3;  3.1 DataRows

USE Master 
GO

--TranquilWest
Row 3 = Header 4 | Fixed Data = 7 | Variable Block 4 | Variable Data 24 
TOTAL = 39Bytes

--XavierWest
Row 4 = Header 4 | Fixed Data = 7 | Variable Block 4 | Variable Data 20 
TOTAL = 35Bytes


--Book 3; 3.2 NullData


USE Master 
GO

Row 1 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 84 
TOTAL = 115 Bytes

Row 2 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 48
TOTAL = 79Bytes

Row 3 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 32
TOTAL = 63Bytes

Row 4 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 20
TOTAL = 51Bytes

Row 5 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 0
TOTAL = 31Bytes


--Code used to create the table & data
USE JProCo
GO

CREATE TABLE [HumanResources].[RoomChart](
	[ID] [int] NOT NULL,
	[Code] [nchar](3) NULL,
	[RoomName] [nvarchar](25) NULL,
	[RoomDescription] [nvarchar](200) NULL,
	[MaxTemp] [int] NULL,
	[MinTemp] [int] NULL
) ON [PRIMARY]

GO

INSERT INTO [HumanResources].[RoomChart] VALUES (1,	'RLT',	'Renault-Langsford-Tribute', 'Customer Previews', 79, 66)
INSERT INTO [HumanResources].[RoomChart] VALUES (2,	'QTX',	'Quinault-Experience', 'Party', 85, 50)
INSERT INTO [HumanResources].[RoomChart] VALUES (3,	'TQW',	'TranquilWest', 'Misc', 85, 55)
INSERT INTO [HumanResources].[RoomChart] VALUES (4,	'XW', 	'XavierWest', NULL, NULL, NULL)
INSERT INTO [HumanResources].[RoomChart] VALUES (5,	NULL,	NULL, NULL, NULL, NULL)
GO





---Book 3; 4.1 Sparse DataType Option


--Skill Check1:
ALTER TABLE Customer
ALTER COLUMN CompanyName ADD SPARSE 

EXEC sp_SpaceUsed 'Customer'


--Book 3; 4.2 Custom Data Types


USE JProCo
GO

CREATE TYPE dbo.Email
FROM varchar(50)
NULL
GO

ALTER TABLE JProCo.dbo.Employee
ADD EmailAddress dbo.Email
GO


--Check Dependencies first
ALTER TABLE dbo.Customer
DROP Country CountryCode
GO

DROP TYPE dbo.CountryCode
GO



--Book 3; 4.3 Date-Time Types

USE JProCo
GO

ALTER TABLE Employee
ADD HiredOffset Datetimeoffset null
GO

ALTER TABLE Employee
ADD TimeZone char(6) null
GO

UPDATE Employee SET Timezone = '-08:00'
WHERE LocationID in (1,4) --Seattle Spokane

UPDATE Employee SET Timezone = '-05:00'
WHERE LocationID in (2) --Boston

UPDATE Employee SET Timezone = '-06:00'
WHERE LocationID in (3) OR LocationID IS NULL --Chicago



UPDATE Employee
SET HiredOffset = TODATETIMEOFFSET(HireDate,Timezone)


SELECT SWITCHOFFSET(HiredOffset,'-09:00') as AlaskHireTime
,*
FROM Employee




