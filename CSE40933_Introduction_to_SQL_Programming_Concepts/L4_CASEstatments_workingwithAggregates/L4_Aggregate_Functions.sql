--Working with Aggregate Functions

SELECT 
	COUNT(*) Rows
--Returns number of rows
	, COUNT(LastName) LastName
--Count number of specific rows in column, doesn't count NULL values.
	, COUNT(Company) Company
	, COUNT(State) AS State
--Duplicate state values exist in the State column
	, COUNT(DISTINCT State) UniqueState
--Doesn't count duplicates, only returns distinct values.
	, Country
FROM Customer
--Can not do a WHERE clause to only return where rows > 2, since GROUP By functions are not allowed in WHERE clauses use HAVING clause.
GROUP BY Country
--Group By expand the column
HAVING COUNT(*)>1

--Display total number of tracks by Genre.
SELECT
	G.Name
	, COUNT(*) Total
FROM Track T
JOIN Genre G
	ON G.GenreId = T.GenreId
GROUP BY
	G.Name
ORDER BY Total DESC
--Shows that the biggest genre is Rock and the smallest Genre is Opera.

--Top with Ties Example
--Find 10 most ordered tracks, using Invoice.
SELECT TOP 10 WITH TIES
--How to display all which are displayed with ties for 3.
	T.Name TrackName
	, COUNT(*) total
FROM Track T
JOIN InvoiceLine IL
	ON IL.TrackId = T.TrackId
GROUP BY T.Name
ORDER BY COUNT(*) DESC, TrackName

--Sum Aggregate
SELECT
	AL.Title
	,SUM(Milliseconds/60000.) Minutes
--Make sure that the return is a floating number, not an integer.
--Better accuracy, be sure to include a '.'
FROM Album AL
JOIN Track T
	ON T.AlbumId = AL. AlbumId
GROUP BY AL.Title
HAVING SUM(Milliseconds/60000.)>60
ORDER BY Minutes

--Sum Aggregate over time
--Display the total gross revenue in sales by sales rep and year.
SELECT 
	E.LastName
	, YEAR(I.InvoiceDate) FiscalYear
	, SUM(I.Total) Total
	, AVG(I.Total) AverageSales
	, MAX(I.Total) MaxSale
	, MIN(I.Total) MinSale
	, COUNT(*) TotalCount
FROM Employee E
JOIN Customer C
	ON C.SupportRepId = E.EmployeeId
JOIN Invoice I
	ON I.CustomerId = C.CustomerId
GROUP BY 
	E.LastName
	, YEAR(I.InvoiceDate) 
--Caveat: Need to grab the entire function ie. YEAR(I.InvoiceDate) vs. just I.InvoiceDate in order to get the correct level of detail wanted
ORDER BY LastName, FiscalYear