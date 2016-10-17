--Utilizing '+' for concatenation
SELECT
	FirstName
	, LastName
	, FirstName+''+LastName AS Fullname
	, LastName+','+FirstName AS LastNameFirst
	, Company
	, LastName + ' ' + Company
--Note: If concatenate NULL values then the result will be NULL as well.
	--,LastNamer + 1 an error will occur because combining different data types
	, LastName + '1'
	--LastName + 'CustomerId' an error will occur
	, LastName + CAST(CustomerId AS varchar)
--Same data types through CAST
FROM Customer

--Utilizing CONCAT function for concatenation
SELECT
	FirstName
	, LastName
	, CONCAT(FirstName, ' ', LastName)
	, CONCAT(LastName, Company)
--Advantage vs '+' is that CONCAT ignores NULL values in concatenation, therefore concwtenated values will not result with NULL.
	, Concat(FirstName, CustomerID)
--Advantage vs '+' is that CONCAT implicitly converts integers
FROM Customer

--Arithmetic in SQL and Math Scalar Functions
SELECT
	9+4
	, 9-4
	, 9*4
	, 9/4
--When dividing the result is not as expected, doing division between two products ie. integer/integer = integer
	, 9/4.
--If want to result a decimal value add a '.'
	, 9%4
--% = Modulo and it returns the remainder of 1 number divided by another

--Determining the length of a track in seconds and minutes.
SELECT 
	Milliseconds
	, Milliseconds/1000 [Seconds]
	, Milliseconds/60000 [Minutes]
--On a track typically see minutes + remaining number of seconds
	, Milliseconds/1000%60 [RemainingSeconds]
	, CONCAT(Milliseconds/60000, ':', Milliseconds/1000%60) [TrackLength]
	, SQRT(9)
	, SQUARE(4)
	, POWER(2,5)
FROM Track