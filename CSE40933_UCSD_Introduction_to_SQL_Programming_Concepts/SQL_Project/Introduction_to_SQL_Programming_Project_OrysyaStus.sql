/* Orysya Stus Introduction to SQL Programming Project*/

/*
1. Provide a report displaying the 10 artists with the most sales from July 2011 through June 2012.
Do not include any video tracks in the sales. Display the Artist's name and the total sales for the
year. Include ties for 10th if there are any.
*/
SELECT TOP 10 WITH TIES
	A.Name AS [Artist Name]
	, ((COUNT(A.Name))*IL.UnitPrice) AS [Total Sale]
FROM Invoice I
JOIN InvoiceLine IL
	ON I.InvoiceId = IL.InvoiceId
JOIN Track T
	ON IL.TrackId = T.TrackId
JOIN Album AL
	ON T.AlbumId = AL.AlbumId
JOIN Artist A
	ON A.ArtistId = AL.ArtistId
JOIN MediaType MT
	ON T.MediaTypeId = MT.MediaTypeId
WHERE MT.Name LIKE '%audio%'
	AND I.InvoiceDate BETWEEN '2011-07-01' AND '2012-06-30'
GROUP BY A.Name
	, IL.UnitPrice
ORDER BY ((COUNT(A.Name))*IL.UnitPrice) DESC

/*
2. Provide a report displaying the total sales for all Sales Support Agents grouped by year and
quarter. Include data from January 2010 through June 2012. Each year has 4 Sales Quarters
divided as follows:
Jan-Mar: Quarter 1
Apr-Jun: Quarter 2
Jul-Sep: Quarter 3
Oct-Dec: Quarter 4
The Sales Quarter column should display its values as First, Second, Third, Fourth. The data
needs to be ordered by the employee name, the fiscal year, and the sales quarter. The sales
quarter order should be numeric and not alphabetical (e.g. “Third” comes before “Fourth”).
*/
SELECT 
	E.FirstName+' '+E.LastName AS [Employee Name]
	, YEAR(I.InvoiceDate) AS [Fiscal Year]
	, CASE	
		WHEN DATEPART(QUARTER, I.InvoiceDate) = 1 THEN 'First'
		WHEN DATEPART(QUARTER, I.InvoiceDate) = 2 THEN 'Second'
		WHEN DATEPART(QUARTER, I.InvoiceDate) = 3 THEN 'Third'
		WHEN DATEPART(QUARTER, I.InvoiceDate) = 4 THEN 'Fourth'
		END[Sales Quarter]
	, MAX(I.Total) AS [Highest Sale]
	, COUNT(I.Total) AS [Number of Sales]
	, SUM(I.Total) AS [Total Sales]
FROM Employee E
JOIN Customer C
	ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
	ON C.CustomerId = I.CustomerId
WHERE I.InvoiceDate BETWEEN '2010-01-01' AND '2012-06-30'
GROUP BY E.FirstName+' '+E.LastName
	, YEAR(I.InvoiceDate)
	, DATEPART(QUARTER, I.InvoiceDate)
ORDER BY [Employee Name], [Fiscal Year], DATEPART(QUARTER, I.InvoiceDate)

/*
3. The Sales Reps have discovered duplicate Playlists in the database. Some but not all of the
Playlists have Tracks associated with them. The duplicates have the same Playlist name, but
have a higher Playlist ID. Write a report that displays the duplicate Playlist IDs and Playlist
Names, as well as any associated Track IDs if they exist. Your result set will be marked for
deletion so it must be accurate.
*/
SELECT 
	P.Name AS [Playlist Name]
	, MAX(Py.PlaylistId) AS [Playlist ID]
	, PT.TrackId AS [Track ID]
From
	(SELECT Name ,COUNT(*) c
		FROM Playlist
		GROUP BY Name
		HAVING COUNT(*)>1
	)  P
JOIN Playlist Py
	ON P.Name = Py.Name
LEFT JOIN PlaylistTrack PT
	ON Py.PlaylistId = PT.PlaylistId
GROUP BY
	P.Name
	, PT.TrackId
ORDER BY [Playlist Name]

/*
4. Management would like to view Artist popularity by Country. Provide a report that displays the
Customer country and the Artist name. Determine the total number of tracks sold by an artist
to each country, and the total unique tracks by artist sold to each country. Include a column
that shows the difference between the track count and the unique track count. Include the total
revenue which will be the cost of the track multiplied by the number of tracks purchased.
Include a column that shows whether the tracks are audio or video (Hint: Videos have a
MediaTypeId =3). The range of data will be between July 2009 and June 2013. Order the results
by Country, Track Count and Artist Name.
*/
SELECT 
	I.BillingCountry AS Country
	, A.Name AS [Artist Name]
	, COUNT(T.TrackId) AS [Track Count]
	, COUNT(DISTINCT T.TrackId) AS [Unique Track Count]
	, COUNT(T.TrackId) - COUNT(DISTINCT T.TrackId) AS [Count Difference]
	, ((COUNT(IL.Quantity))*T.UnitPrice) AS [Total Revenue]
	, CASE
		WHEN MT.MediaTypeId = 3 THEN 'Video'
		WHEN MT.MediaTypeId IN(1,2,4,5) THEN 'Audio'
		END AS [Media Type]
FROM Invoice I
JOIN InvoiceLine IL
	ON I.InvoiceId = IL.InvoiceId
JOIN Track T
	ON IL.TrackId = T.TrackId
JOIN Album AL
	ON T.AlbumId = AL.AlbumId
JOIN Artist A
	ON AL.ArtistId = A.ArtistId
JOIN MediaType MT
	ON T.MediaTypeId = MT.MediaTypeId
WHERE I.InvoiceDate BETWEEN '2009-07-01' AND '2013-06-30'
GROUP BY 
	A.Name
	, I.BillingCountry
	, T.UnitPrice
	, CASE
		WHEN MT.MediaTypeId = 3 THEN 'Video'
		WHEN MT.MediaTypeId IN(1,2,4,5) THEN 'Audio'
		END
ORDER BY Country, [Track Count] DESC, [Artist Name]

/*
5. HR wants to plan birthday celebrations for all employees in 2016. They would like a list of
employee names and birth dates, as well as the day of the week the birthday falls on in 2016.
Celebrations will be planned the same day as the birthday if it falls on Monday through Friday. If
the birthday falls on a weekend then the celebration date needs to be set on the following
Monday. Provide a report that displays the above date logic. The column formatting needs to
be the same as in the example below. (Hint: This is a tough one. I used 7 different functions in
my solution. You will need to nest functions inside other functions. Don’t worry about
accounting for leap birthdays in your script.)
*/
SELECT 
	FirstName+' '+LastName AS [Employee Name]
	, CONVERT(varchar, BirthDate, 101) AS [Birth Date]
	, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101) AS [Birth Day 2016]
	, DATENAME(Weekday, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101)) AS [Birth Day of Week]
	, CASE	
		WHEN (DATENAME(Weekday, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101))) = 'Saturday' THEN CONVERT(varchar, DATEADD(DAY, 2, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101)), 101)
		WHEN (DATENAME(Weekday, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101))) = 'Sunday' THEN CONVERT(varchar, DATEADD(DAY, 1, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101)), 101)
		ELSE CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101) 
		END AS [Celebration Date]
	, CASE	
		WHEN (DATENAME(Weekday, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101))) = 'Saturday' THEN DATENAME(Weekday, CONVERT(varchar, DATEADD(DAY, 2, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101)), 101))
		WHEN (DATENAME(Weekday, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101))) = 'Sunday' THEN DATENAME(Weekday, CONVERT(varchar, DATEADD(DAY, 1, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101)), 101))
		ELSE DATENAME(Weekday, CONVERT(varchar, DATEADD(YEAR, (2016-YEAR(BirthDate)), BirthDate), 101)) 
		END AS [Celebration Day of Week] 
FROM Employee 

/*
6. Management is interested in consolidating the Media Types and Genres offered. Specifically
they want to see which Genres and Media Types are underperforming in terms of Track sales.
Provide a report that groups Media Type and Genre. Include a column that shows the Unique
Track Count of available tracks, as well as a column called Tracks Purchased Count that shows
the count of tracks purchased. Include a column called Total Revenue for track purchases.
Include a column called Percentile dividing Track Purchases Count by Unique Track Count and
showing it as a percentile. Only include rows that have less than 10 in Total Revenue, or have a
Percentile of less than 50. Order by Total Revenue in ascending order, Percentile in descending
order, and Genre in ascending order.
*/
SELECT
	MT.Name AS [Media Type]
	, G.Name AS Genre
	, COUNT(DISTINCT T.TrackId) AS [Unique Track Count]
	, SUM(IL.Quantity) AS [Tracks Purchased Count]
	, ((COUNT(IL.Quantity))* T.UnitPrice) AS [Total Revenue]
	, CONVERT(DECIMAL(5,2),100.0 * SUM(IL.Quantity) / COUNT(DISTINCT T.TrackId)) AS Percentile
FROM MediaType MT
JOIN Track T
	ON MT.MediaTypeId = T.MediaTypeId
JOIN Genre G
	ON T.GenreId = G.GenreId
LEFT JOIN InvoiceLine IL
	ON T.TrackId = IL.TrackId
GROUP BY
	G.Name
	, MT.Name
	, T.UnitPrice
HAVING (((COUNT(IL.Quantity))*0.99) < 10.00) 
	OR (((CONVERT(float, SUM(IL.Quantity))) / (CONVERT(float, COUNT(DISTINCT T.TrackId))))*100.0 < 50.00)
ORDER BY [Total Revenue] ASC, Percentile DESC, Genre ASC