/* Creating and Using Stored Procedures */
--ie. creating a view

CREATE PROC Customer_p AS
SELECT
	FirstName
	, LastName
	, Country
FROM Customer
WHERE Country = 'Canada'
--different from views in how they are displayed

EXEC Customer_p
--returns the result set of the SELECT statement
--advantage: can be used for create, drop, inserts, etc. not just for select statements

--To alter the procedure 
--1. Programmability > Stored Procedures > select procedure > Modify > opens code in new query for editting purposes, ALTER PROC is already set up
EXEC Customer_p
--to confirm changes

/* Create Stored Procedures with Parameters */
CREATE PROC ArtistGenre_p 
	@ArtistName varchar(50)
	, @GenreName varchar(50)
AS
SELECT
	A.Name AS ArtistName
	, T.Name AS TrackName
	, G.Name AS GenreName
FROM Artist A
JOIN Album AL
	ON AL.ArtistId = A.ArtistId
JOIN Track T
	ON T.AlbumId = AL.AlbumId
JOIN Genre G
	ON G.GenreId = T.GenreId
WHERE A.Name = @ArtistName
	AND G.Name = @GenreName
--takes parameter defined above and insert that instead

GO
--separates into batches

EXEC ArtistGenre_p 'U2', 'Rock'
--supply parameters
--only returns where U2 and Rock.

EXEC ArtistGenre_p 'U2', 'Pop'
--both values have to be defined

--To set a default value, without having to define the parameters then alter the PROC statement
ALTER PROC ArtistGenre_p 
	@ArtistName varchar(50) = 'U2'
	, @GenreName varchar(50) = 'Rock'
AS
SELECT
	A.Name AS ArtistName
	, T.Name AS TrackName
	, G.Name AS GenreName
FROM Artist A
JOIN Album AL
	ON AL.ArtistId = A.ArtistId
JOIN Track T
	ON T.AlbumId = AL.AlbumId
JOIN Genre G
	ON G.GenreId = T.GenreId
WHERE A.Name = @ArtistName
	AND G.Name = @GenreName

EXEC ArtistGenre_p
--no need for parameters to be listed

EXEC ArtistGenre_p 'Iron Maiden'
--Iron Maiden will be outputted
--will be in the correct order and Iron Maiden will replace U2

EXEC ArtistGenre_p @ArtistName ='U2', @GenreName = 'Pop'
--clearly define the inputs of the parameters

EXEC ArtistGenre_p @GenreName = 'Pop'
--can take out some of the parameters once defined inputs, order doesn't matter

EXEC ArtistGenre_p @GenreName = 'Blues', @ArtistName = 'Iron Maiden'