--Display only where the artist name is U2.

SELECT 
	A.Name ArtistName
	, AL.Title
	, T.Name TrackName
FROM Artist A
JOIN Album AL
	ON AL.ArtistId = A.ArtistId
JOIN Track T 
	ON T.AlbumId = AL.AlbumId
--For only track name.
	AND T.Name = 'Zoo Station'
WHERE A.Name = 'U2'

SELECT 
	A.Name ArtistName
	, AL.Title
	, T.Name TrackName
FROM Artist A
JOIN Album AL
	ON AL.ArtistId = A.ArtistId
LEFT JOIN Track T 
--All tracks will be seen, but NULL where track name is not present. 
	ON T.AlbumId = AL.AlbumId
--For only track name.
	AND T.Name = 'Zoo Station'
WHERE A.Name = 'U2'

SELECT 
	T.Name	
	, C.FirstName
	, C.LastName
FROM Track T
JOIN InvoiceLine IL
	ON IL.TrackId = T.TrackId
JOIN Invoice I
	ON I.InvoiceId = IL.InvoiceId
JOIN Customer C
	ON C.CustomerId = I.CustomerId
WHERE T.Name = 'Holiday'

--Employee table where the ReportsTo goes back to the EmployeeId; want to see name to who someone is reporting to.
SELECT 
	E.EmployeeId
	, E.FirstName
	, E.LastName
	, E.ReportsTo
	, M.EmployeeId
	, M.FirstName
	, M.LastName
FROM Employee E
LEFT JOIN Employee M
--To see all, even if someone doesn't report to anyone.
	ON E.ReportsTo = M.EmployeeId


