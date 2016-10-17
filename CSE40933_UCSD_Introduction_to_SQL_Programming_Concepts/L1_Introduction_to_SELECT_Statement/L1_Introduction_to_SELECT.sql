SELECT *
--in Total for "*" have 59 rows, but if want to make specific selections need to narrow it down.
FROM Customer
WHERE Country = 'USA'
--With the above WHERE statement narrow it down to 13 rows

SELECT *
--in Total for "*" have 59 rows, but if want to make specific selections need to narrow it down.
FROM Customer
WHERE Country <> 'USA'
--With the above WHERE 'NOT USA' statement narrow does to 46 rows.

SELECT
	FirstName
	, LastName
	, Phone
FROM Customer
WHERE Country = 'USA'
ORDER BY LastName DESC, FirstName
--Narrows down to 13 rows ordered by Lastname, Firstname alphabetically in descending order (using ASC will order by ascending order which occurs at default anyway).

SELECT
	FirstName AS [First Name]
	, LastName AS [Last Name]
	, Phone AS [Phone Number]
--Remaining column names with [new name], AS is not necessary but good for formatting purposes. 
FROM Customer
WHERE Country = 'USA'
ORDER BY LastName, FirstName

SELECT *
FROM Customer
WHERE Country = 'USA'
	OR Country = 'Brazil'
--Returns 18 rows, can verify only Brazil or USA in Country column in "results" rection
--Note: AND will be executed before OR, make sure to place () where needed as order does matter!

SELECT DISTINCT Country
FROM Customer
--Returns 24 rows, showing unique/distinct sample names for the column Country.

SELECT TOP 5 *
FROM Customer
ORDER BY CustomerId Desc
--Returns 5 rows, showing top 5 rows for each column value. 