/* Orysya Stus */

--1. Display all tracks from the Track table and their associated media type name from the MediaType table. (3503 rows)
SELECT 
	T.Name TrackName
	, M.Name MediaName
	, CASE
		WHEN M.Name LIKE '%video%' THEN 'Video'
		ELSE 'Audio'
		END MediaType
	, CASE
		WHEN M.Name LIKE '%AAC%' THEN 'AAC'
		WHEN M.Name LIKE '%MPEG%' THEN 'MPEG'
		ELSE 'Unknown'
		END EncodingFormat 
FROM Track T
JOIN MediaType M
	ON T.MediaTypeId = M.MediaTypeId

--2. Display the total track count for each Media type. (5 rows)
SELECT 
	M.Name MediaTypeName
	, COUNT(*) TotalTracks 	
FROM Track T
JOIN MediaType M
	ON T.MediaTypeId = M.MediaTypeId
GROUP BY M.Name

--3. Sum the total sales for each Sales Support Agent grouped by year. (15 rows)
SELECT 
	E.FirstName
	, E.LastName
	, YEAR(I.InvoiceDate) SaleYear
	, SUM(I.Total) TotalSales
FROM Employee E
JOIN Customer C
	ON C.SupportRepId = E.EmployeeId
JOIN Invoice I
	ON I.CustomerId = C.CustomerId
GROUP BY 
	E.FirstName
	, E.LastName
	, YEAR(I.InvoiceDate)

--4. Display the highest amount paid by each customer for a single invoice. (59 rows)
SELECT 
	C.LastName
	, C.FirstName
	, MAX(I.Total) MaxInvoice
FROM Customer C
JOIN Invoice I
	ON I.CustomerId = C.CustomerId
GROUP BY 
	C.LastName
	, C.FirstName

--5. Check customer postal codes to determine if they are numeric. (59 rows)
SELECT 
	Country
	, PostalCode
	, CASE 
		WHEN PostalCode LIKE '%[A-Z]%' THEN 'No'
		WHEN PostalCode LIKE '%[0-9]%' THEN 'Yes'
		WHEN PostalCode IS NULL THEN 'Unknown'
		END NumericPostalCode
FROM Customer
ORDER BY NumericPostalCode, Country

--6. Find the customers whose total purchases are greater than 42 dollars. (10 rows)
SELECT 
	C.FirstName
	, C.LastName
	, SUM(I.Total) TotalSales
FROM Customer C
JOIN Invoice I
	ON I.CustomerId = C.CustomerId
GROUP BY 
	C.FirstName
	, C.LastName
HAVING SUM(I.Total) > 42

--7. Which artist has the most tracks in the database? (1 row)
SELECT TOP 1
	A.Name TopArtist
	--Count(A.Name) TopArtist ; this statement is not needed for the problem but would confirm the count of TopArtist.
FROM Track T
JOIN Album AL
	ON AL.AlbumId = T.AlbumId
JOIN Artist A
	ON A.ArtistId = AL.ArtistId
GROUP BY A.Name
ORDER BY Count(A.Name) DESC

--8. Assign customers to groups using a derived column named CustomerGrouping. (59 rows)
SELECT 
	FirstName
	, LastName
	, CASE 
		WHEN LastName LIKE '[A-G]%' THEN 'Group1'
		WHEN LastName LIKE '[H-M]%' THEN 'Group2'
		WHEN LastName LIKE '[N-S]%' THEN 'Group3'
		WHEN LastName LIKE '[T-Z]%' THEN 'Group4'
		WHEN LastName IS NULL THEN LastName
		END CustomerGrouping
FROM Customer

--9. List all the artists and a count of how many albums each artist has in the database. (275 rows)
SELECT
	A.Name ArtistName
	, Count(A.Name) AlbumCount
FROM Artist A
LEFT JOIN Album AL
	ON A.ArtistId = AL.ArtistId
GROUP BY A.Name
ORDER BY AlbumCount, ArtistName

--10. Place employees in departments based on their title. (8 rows)
SELECT
	FirstName
	, LastName
	, Title
	, CASE	
		WHEN Title LIKE '%Manager%' THEN 'Management'
		WHEN Title LIKE '%Sales%' THEN 'Sales'
		WHEN Title LIKE '%IT%' THEN 'Technology'
		END Department
FROM Employee
ORDER BY Department