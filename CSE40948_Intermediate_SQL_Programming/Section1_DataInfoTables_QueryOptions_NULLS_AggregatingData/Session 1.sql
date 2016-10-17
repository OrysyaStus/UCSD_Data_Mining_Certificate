Session 1


--------------------------------

SELECT * 
FROM Employee --Natural Sort

SELECT * 
FROM Employee
ORDER BY LastName

SELECT * 
FROM Employee
ORDER BY HireDate DESC



SELECT * 
FROM Location

SELECT * 
FROM Location
ORDER BY LocationID --Nulls come first

SELECT * 
FROM Location
ORDER BY LocationID DESC --Nulls come last



SELECT * 
FROM Employee
ORDER BY HireDate

SELECT FirstName, LastName, HireDate
FROM Employee
ORDER BY HireDate

SELECT FirstName, LastName
FROM Employee
ORDER BY HireDate



SELECT * 
FROM Employee em INNER JOIN Location as lo
ON em.LocationID = lo.LocationID
ORDER BY City

SELECT * 
FROM Employee em INNER JOIN Location as lo
ON em.LocationID = lo.LocationID
ORDER BY City, LastName

ELECT * FROM [Grant]
SELECT * FROM Employee


--------------------------------
SELECT * 
FROM [Grant] as gr INNER JOIN Employee as em
ON gr.EmpID = em.EmpID

SELECT GrantName, Amount, FirstName, LastName
FROM [Grant] as gr INNER JOIN Employee as em
ON gr.EmpID = em.EmpID

SELECT GrantName, Amount, FirstName, LastName, loc.LocationID, City
FROM [Grant] as gr INNER JOIN Employee as em
ON gr.EmpID = em.EmpID
INNER JOIN Location as Loc
ON em.LocationID = Loc.LocationID

SELECT GrantName, Amount, City
FROM [Grant] as gr INNER JOIN Employee as em
ON gr.EmpID = em.EmpID
INNER JOIN Location as Loc
ON em.LocationID = Loc.LocationID




--------------------------------

SELECT EmpID, 
FirstName, 
LastName
FROM Employee

SELECT EmpID, 
FirstName, 
LastName,
FirstName + LastName AS FullName
FROM Employee

SELECT EmpID, 
FirstName, 
LastName,
FirstName + ' ' + LastName AS FullName
FROM Employee


SELECT 
ProductName, 
RetailPrice
FROM CurrentProducts

SELECT 
ProductName, 
RetailPrice,
RetailPrice * 1.1 AS Cnd$
FROM CurrentProducts


--Play video starting @ 2:00

SELECT 
ProductName, 
RetailPrice,
CAST(RetailPrice * 1.1 as Decimal) AS Cnd$
FROM CurrentProducts

SELECT 
ProductName, 
RetailPrice,
CAST(RetailPrice * 1.1 as Decimal(6,2)) AS Cnd$
FROM CurrentProducts

SELECT 3.85
SELECT ROUND(3.85,2)
SELECT ROUND(3.85,1) --3.90
SELECT ROUND(3.85,0) --4.00

SELECT 4
SELECT ROUND(4,2) --4
SELECT ROUND(4,1) --4
SELECT ROUND(4,0) --4


SELECT 
ProductName, 
RetailPrice,
CAST(RetailPrice as Decimal(6,2)) AS Price
FROM CurrentProducts

SELECT 
ProductName, 
RetailPrice,
CAST(RetailPrice as Decimal(6,2)) AS Price,
ROUND(RetailPrice,2) AS RoundPrice
FROM CurrentProducts

SELECT 
ProductName, 
RetailPrice,
CAST(RetailPrice as Decimal(6,2)) AS Price,
ROUND(RetailPrice,2) AS Round2Price,
ROUND(RetailPrice,1) AS Round1Price
FROM CurrentProducts

SELECT 
ProductName, 
RetailPrice,
CAST(RetailPrice as Decimal(6,2)) AS Price,
ROUND(RetailPrice,2) AS Round2Price,
ROUND(RetailPrice,1) AS Round1Price,
ROUND(RetailPrice,0) AS Round0Price
FROM CurrentProducts


SELECT FirstName, LastName, HireDate
FROM Employee
WHERE HireDate >= '1/1/2000'

SELECT FirstName + ' ' + LastName, HireDate
FROM Employee
WHERE HireDate >= '1/1/2000'

SELECT FirstName + ' ' + LastName as FullName, HireDate
FROM Employee
WHERE HireDate >= '1/1/2000'

SELECT FirstName + ' ' + LastName as FullName, HireDate
FROM Employee
WHERE HireDate >= '1/1/2000'
ORDER BY LastName

SELECT FirstName + ' ' + LastName as FullName, HireDate
FROM Employee
WHERE HireDate >= '1/1/2000'
ORDER BY HireDate --Changed this

SELECT FirstName + ' ' + LastName as FullName, 
CONVERT(nvarchar,HireDate,101) 
FROM Employee
WHERE HireDate >= '1/1/2000'
ORDER BY HireDate --Changed this

SELECT FirstName + ' ' + LastName as FullName, 
CONVERT(nvarchar,HireDate,101) as HireDate --Changed this
FROM Employee
WHERE HireDate >= '1/1/2000'
ORDER BY HireDate --Shorting looks wierd now

SELECT FirstName + ' ' + LastName as FullName, 
CONVERT(nvarchar,HireDate,101) as EmployementDate--Changed this
FROM Employee
WHERE HireDate >= '1/1/2000'
ORDER BY HireDate

SELECT FirstName + ' ' + LastName as FullName, 
CONVERT(nvarchar,HireDate,101) as HireDate 
FROM Employee
WHERE HireDate >= '1/1/2000'
ORDER BY Employee.HireDate --Shorting looks OK now


----------------------------


SELECT * FROM CurrentProducts --Products up to 480

INSERT INTO CurrentProducts VALUES
(481, 'Yoga Mtn Getaway 5 Days', 875,'9/1/2009',0,'Medium-Stay')

INSERT INTO CurrentProducts VALUES
('Yoga Mtn Getaway 5 Days', 875,'9/1/2009',0,'Medium-Stay')

INSERT INTO CurrentProducts VALUES
('Yoga Mtn Getaway 1 Week', 995,GetDate(),0,'LongTerm-Stay')

--Get the Propertied of the ID field


INSERT INTO CurrentProducts VALUES
('Yoga Mtn Getaway 2 Weeks', 1695,CURRENT_TIMESTAMP,0,'LongTerm-Stay')

--Both are the same
SELECT GetDate()
SELECT CURRENT_TIMESTAMP


SELECT *
FROM CurrentProducts
WHERE ProductName LIKE '%Yoga%'

DELETE
FROM CurrentProducts
WHERE ProductName LIKE '%Yoga%'

SELECT * FROM CurrentProducts --Products up to 480, Next insert will be 484

INSERT INTO CurrentProducts VALUES
(481, 'Yoga Mtn Getaway 5 Days', 875,'9/1/2009',0,'Medium-Stay')

SELECT * FROM CurrentProducts --See 484




SET IDENTITY_INSERT CurrentProducts ON

INSERT INTO CurrentProducts 
VALUES (481, 'Yoga Mtn Getaway 5 Days', 875,'9/1/2009',0,'Medium-Stay') --Need to pass by name



SET IDENTITY_INSERT CurrentProducts ON

INSERT INTO CurrentProducts (ProductID, ProductName, RetailPrice, Originationdate, TobeDeleted, Category)
VALUES (481, 'Yoga Mtn Getaway 5 Days', 875,'9/1/2009',0,'Medium-Stay')


SET IDENTITY_INSERT CurrentProducts OFF


--Do 482 and 482
SET IDENTITY_INSERT CurrentProducts ON

INSERT INTO CurrentProducts VALUES
 (481, 'Yoga Mtn Getaway 1 week', 995.00,'9/1/2009',0,'Medium-Stay')

INSERT INTO CurrentProducts VALUES
 (481, 'Yoga Mtn Getaway 5 weeks', 1695.00,'9/1/2009',0,'Medium-Stay')

SET IDENTITY_INSERT CurrentProducts OFF



-----------------------------


SELECT *
FROM [Grant]

SELECT GrantName, Amount
FROM [Grant]

SELECT EmpID --You see same EmpId list many times
FROM [Grant]

SELECT DISTINCT EmpID
FROM [Grant]

SELECT EmpID
FROM [Grant]
GROUP BY EmpID



SELECT EmpID, Amount
FROM [Grant]

SELECT EmpID, SUM(Amount)
FROM [Grant]
GROUP BY EmpID

SELECT EmpID, Count(Amount)
FROM [Grant]
GROUP BY EmpID

SELECT EmpID, Max(Amount)
FROM [Grant]
GROUP BY EmpID

SELECT EmpID, SUM(Amount) as TotalAmount
FROM [Grant]
GROUP BY EmpID

SELECT Category
,COUNT(ProductID) AS [ProductID Count]
,ROUND(MAX(RetailPrice),2) AS [High Price]
FROM CurrentProducts
GROUP BY Category



SELECT *
FROM Employee AS Emp
INNER JOIN Location as Loc
ON emp.LocationID = Loc.LocationID --Only some Employees

SELECT *
FROM Employee AS Emp
FULL OUTER JOIN Location as Loc
ON emp.LocationID = Loc.LocationID

SELECT city, FirstName
FROM Employee AS Emp
FULL OUTER JOIN Location as Loc
ON emp.LocationID = Loc.LocationID

SELECT city, Count(FirstName)
FROM Employee AS Emp
FULL OUTER JOIN Location as Loc
ON emp.LocationID = Loc.LocationID
GROUP BY City

SELECT city, Count(*) --Chicago gets a count of 1
FROM Employee AS Emp
FULL OUTER JOIN Location as Loc
ON emp.LocationID = Loc.LocationID
GROUP BY City


SELECT * 
FROM Employee as emp
INNER JOIN [Grant] as gr
ON emp.EmpID = gr.EmpID --4 Davids (3 are Lonning)


SELECT FirstName, Count(*)
FROM Employee as emp
INNER JOIN [Grant] as gr
ON emp.EmpID = gr.EmpID --4 Davids (3 are Lonning)
GROUP BY FirstName

SELECT FirstName, LastName Count(*)
FROM Employee as emp
INNER JOIN [Grant] as gr
ON emp.EmpID = gr.EmpID --4 Davids (3 are Lonning)
GROUP BY FirstName, LastName


---------------------------------


SELECT * 
FROM Employee

SELECT LocationID, Count(*)
FROM Employee
GROUP BY LocationID

SELECT LocationID, Count(*)
FROM Employee
WHERE Count(*) > 2 --Does not work
GROUP BY LocationID

SELECT LocationID, Count(*)
FROM Employee
GROUP BY LocationID
HAVING Count(*) > 2


SELECT *
FROM Location as Loc
FULL OUTER JOIN Employee as emp
ON Loc.LocationId = emp.LocationID

SELECT Loc.[State], emp.FirstName
FROM Location as Loc
FULL OUTER JOIN Employee as emp
ON Loc.LocationId = emp.LocationID

SELECT Loc.[State], count(emp.FirstName)
FROM Location as Loc
FULL OUTER JOIN Employee as emp
ON Loc.LocationId = emp.LocationID
GROUP BY Loc.[State]

SELECT Loc.[State], count(emp.FirstName)
FROM Location as Loc
FULL OUTER JOIN Employee as emp
ON Loc.LocationId = emp.LocationID
GROUP BY Loc.[State]
HAVING count(emp.FirstName) > 2



SELECT FirstName, LastName, Amount
FROM Employee as emp
INNER JOIN [Grant] as gra
ON emp.EmpID = gra.EmpID

SELECT FirstName, LastName, Amount
FROM Employee as emp
INNER JOIN [Grant] as gra
ON emp.EmpID = gra.EmpID
GROUP BY FirstName, LastName
HAVING SUM(Amount) > 40000 --Only 2 emp totals are that high

SELECT FirstName, LastName, Amount
FROM Employee as emp
INNER JOIN [Grant] as gra
ON emp.EmpID = gra.EmpID
WHERE Amount > 40000  --Only 1 emp total is that high
GROUP BY FirstName, LastName



SELECT * 
FROM Customer

SELECT * 
FROM Customer as cu
INNER JOIN SalesInvoice as SV
ON cu.CustomerID = sv.CustomerID
WHERE OrderDAte BETWEEN '1/1/2006' AND '1/1/2007'

SELECT cu.* 
FROM Customer as cu
INNER JOIN SalesInvoice as SV
ON cu.CustomerID = sv.CustomerID
WHERE OrderDAte BETWEEN '1/1/2006' AND '1/1/2007'

SELECT DISTINCT cu.* 
FROM Customer as cu
INNER JOIN SalesInvoice as SV
ON cu.CustomerID = sv.CustomerID
WHERE OrderDAte BETWEEN '1/1/2006' AND '1/1/2007'


--Show the Video 6:30
SELECT * 
FROM vSales

SELECT ProductID, CustomerID
FROM vSales

SELECT ProductID, Count(CustomerID)
FROM vSales
GROUP BY ProductID

SELECT ProductID, Count(DISTINCT CustomerID)
FROM vSales
GROUP BY ProductID


-----------------------------
SELECT *
FROM CurrentProducts

SELECT Category, Count(*)
FROM CurrentProducts
GROUP BY Category

CREATE PROC GetCategoryCount
AS
BEGIN
 SELECT Category, Count(*)
 FROM CurrentProducts
 GROUP BY Category
END

--New window
EXEC GetCategoryCount

--Notice the object in "Stored Procedures"



SELECT * 
FROM Location --Goal to create a Get

SELECT *
FROM Location as Loc
INNER JOIN Employee as emp
ON Loc.LocationID = emp.LocationID
GROUP BY Loc.LocationID

SELECT Loc.LocationID, Count(*)
FROM Location as Loc
LEFT OUTER JOIN Employee as emp
ON Loc.LocationID = emp.LocationID
GROUP BY Loc.LocationID --Why does chicago have people?

SELECT Loc.LocationID, Count(EmpID)
FROM Location as Loc
LEFT OUTER JOIN Employee as emp
ON Loc.LocationID = emp.LocationID
GROUP BY Loc.LocationID

SELECT Loc.LocationID, Count(EmpID)
FROM Location as Loc
LEFT OUTER JOIN Employee as emp
ON Loc.LocationID = emp.LocationID
GROUP BY Loc.LocationID
ORDER BY Count(EmpID) DESC 

CREATE PROC GetLocationCount
AS
BEGIN
 SELECT Loc.LocationID, Count(EmpID)
 FROM Location as Loc
 LEFT OUTER JOIN Employee as emp
 ON Loc.LocationID = emp.LocationID
 GROUP BY Loc.LocationID
 ORDER BY Count(EmpID) DESC 
END


