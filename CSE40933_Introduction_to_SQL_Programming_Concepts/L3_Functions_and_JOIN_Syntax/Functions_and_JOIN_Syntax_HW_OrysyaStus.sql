/* Orysya Stus */

--1.
SELECT 
	A.Title
	, T.Name
	, T.Milliseconds/1000 Seconds
FROM Album A
JOIN Track T
	ON T.AlbumId = A.AlbumId
	AND A.Title = 'Let There Be Rock'

--2.
SELECT
	CONCAT(FirstName, ' ', LastName) FullName
	, DAY(BirthDate) [Day]
	, DATENAME(Month, BirthDate) [Month]
	, YEAR(BirthDate) [Year]
FROM Employee

--3.
SELECT
	CONCAT(E.FirstName, ' ', E.LastName) CustomerRep
	, CONCAT(C.FirstName, ' ', C.LastName) CustomerName
	, C.Country
FROM Customer C
JOIN Employee E
	ON C.SupportRepId = E.EmployeeId
ORDER BY CustomerRep, C.Country

--4. 
SELECT 
	A.Title
	, T.Name
	, IL.InvoiceId
FROM Track T
LEFT JOIN InvoiceLine IL
	ON T.TrackId = IL.TrackId
JOIN Album A
	ON A.AlbumId = T.AlbumId
ORDER BY T.Name, IL.InvoiceId DESC

--5.
SELECT 
	Title
	, REPLACE(Title, ' ','') TitleNoSpaces
	, UPPER(Title) TitleUpperCase
	, REVERSE(Title) TitleReverse
	, LEN(Title) TitleLength
	, PATINDEX('% %', Title) SpaceLocation
FROM Album

--6.
SELECT
	FirstName
	, LastName
	, BirthDate
	, DATEDIFF(Hour, BirthDate, HireDate)/8766 Age
FROM Employee

--7.
SELECT 
	E.EmployeeId
	, E.LastName
	, E.FirstName
	, E.ReportsTo
	, ISNULL(M.FirstName+''+M.LastName,'N/A') ManagerName
--Note: Directions didn't specify to have a space between the Manager first and last name.
FROM Employee E
LEFT JOIN Employee M
	ON E.ReportsTo = M.EmployeeId

--8.
SELECT
	Title
	, LTRIM(SUBSTRING(Title, CHARINDEX(' ',Title), Len(Title))) ShortTitle
FROM Employee

--9.
SELECT 
	FirstName
	, LastName
	, CONCAT(LEFT(FirstName,1),'', LEFT(LastName,1)) Initials
FROM Customer
ORDER BY Initials

--10.
SELECT
	C.LastName
	, A.Title
	, T.Name
	, CONVERT(varchar, I.InvoiceDate, 103) PurchaseDate
FROM Album A
JOIN Track T
	ON A.AlbumId = T.AlbumId
JOIN InvoiceLine IL
	ON T.TrackId = IL.TrackId
JOIN Invoice I
	ON IL.InvoiceId = I.InvoiceId
JOIN Customer C
	ON I.CustomerId = C.CustomerId
WHERE C.FirstName = 'Julia'
ORDER BY PurchaseDate, A.Title, T.Name