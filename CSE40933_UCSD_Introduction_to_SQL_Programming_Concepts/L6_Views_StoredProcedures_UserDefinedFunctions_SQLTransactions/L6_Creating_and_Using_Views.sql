/* Creating and Using Views */

CREATE VIEW ArtistAlbum_v AS
SELECT 
	A.ArtistId
	, A.Name AS ArtistiName
	, AL.Title AS AlbumTitle
FROM Artist A
JOIN Album AL
	ON A.ArtistId = AL.ArtistId
--to avoid creating multiple commands of the same JOIN statement, create a view
--Output: Command(s) completed successfully

--If open in new query then:
SELECT *
FROM ArtistAlbum_v
--will show up also in "Views" tab

--If want to add something to the view, alter it
--If have original query available:
--ALTER VIEW ArtistAlbum_v AS
--SELECT 
--	A.ArtistId
--	, A.Name AS ArtistiName
--	, AL.Title AS AlbumTitle
--FROM Artist A
--JOIN Album AL
--	ON A.ArtistId = AL.ArtistId
--If don't have the original query available
--1. Can do Views > Select View As > Alter to > New Query Edit Window > edit query in a new window
--confirm with select statement above
--do not click on Views > Design as this is a poor GUI to work with, confusing and bad for larger queries; takes SQL code and rewrites it for you

EXEC sp_helptext ArtistAlbum_v
--will output info. about the view and then copy and paste text file:
ALTER VIEW [dbo].[ArtistAlbum_v] AS
SELECT 
	A.ArtistId
	, A.Name AS ArtistiName
	, AL.AlbumId
	, AL.Title AS AlbumTitle
FROM Artist A
JOIN Album AL
	ON A.ArtistId = AL.ArtistId

/* Create another new view based on prior view*/
CREATE VIEW ArtistAlbumTrack_v AS
SELECT 
	AA.*
	, T.TrackId
	, T.Name AS TrackName
FROM ArtistAlbum_v AA
JOIN Track T
	ON T.AlbumId = AA.AlbumId
--have a view embedded in a view

SELECT *
FROM ArtistAlbumTrack_v
--if keep embedding views, it is not the best practice b/c may forget how the original view looked like

DROP VIEW ArtistAlbumTrack_v
--to drop views
--refresh "Views" for confirmation of drop