/* Data Manipulation Language = term applied to queries that interact w/data ie. SELECT, INSERT, UPDATE, DELETE */
/* Note: Execute sections one by one */

/* Making a simple, local temporary table */
SELECT *
INTO #Playlist_Local
--creates a temporary table but does not output a table
--advantage = use data from temporary table in future
--syntax (#) makes it a local temp table
--will only be able to be used in this script/tab
FROM Playlist

/* Showing contents of the temporary table created: */
SELECT *
FROM #Playlist_Local
--Note: on left hand tab can seen under "Temporary Tables" tab
--Can not create a table if the table already exists, thus give the temp table duplicates other names

--Global temporary table:
SELECT *
INTO ##Artist_Global
FROM Artist

SELECT *
FROM ##Artist_Global
--As long as the tab that created is open, then anyone that has access to the server can use the global temp table ie. can use in a different sql window/tab
--If instance that created it was deleted, then can't open the global temp table in other sql tabs

/* The DELETE Statement */
SELECT *
INTO Customer_Copy
--Insert into brand new table, not a temp table
--can visualize under "Tables" tab 
FROM Customer

SELECT *
FROM Customer_Copy
--Displays 59 rows

SELECT
	FirstName
	, LastName
	, Country
FROM Customer_Copy
ORDER BY Country
--Displays 59 rows

DELETE Customer_Copy
--Without any further commands the above would delete all entries in the table
WHERE Country = 'Austria'
--Output: '(1 row(s) affected)' therefore 58 rows left

DELETE CC
--If you alias the table to delete in the FROM clause, you must use that alias in the DELETE clause
FROM Customer_Copy CC
JOIN Employee E
	ON E.EmployeeId = CC.SupportRepId
WHERE E.LastName = 'Peacock'
--Output: '(21 row(s) affected)' thus 37 rows left in the table created

DELETE Customer_Copy
--Will delete entire table
--37 rows deleted, the table exists but is without instances

/* The INSERT Statement */
--Note: The data types of each of the columns, reference columns of Customer_Copy table
INSERT INTO Customer_Copy (CustomerId, FirstName, LastName, Email)
--Select which columns you want to add instances to
VALUES (100, 'Jane', 'Doe', 'test@mail.com')
,(101, 'John', 'Doe', 'aaa@bbb.com')
--Output: '(2 row(s) affected)

SELECT *
FROM Customer_Copy
--The column with added information are shown, the other columns show up as NULL

INSERT INTO Customer_Copy (CustomerId, FirstName, LastName, Email, Country)
SELECT 
	CustomerId
	, FirstName
	, LastName
	, Email
	, Country
--Need to have the same number of insert columns to insert items in list
FROM Customer
WHERE Country = 'USA'
--Output: '(13 row(s) affected)

INSERT INTO Customer_Copy
--didn't declare which columns to add, therefore will add all columns in the order specified
SELECT *
FROM Customer C
WHERE NOT EXISTS (
	SELECT *
	FROM Customer_Copy CC
	WHERE CC.CustomerId = C.CustomerId)
--do not want to add duplicate values
--only will insert instances that do not have the CustomerId in them
--Ouput: '(46 row(s) affected)'

SELECT *
FROM Customer_Copy
--Have 61 rows outputted

/* The UPDATE Statement */
--Use when need to change info. w/in an existing record
UPDATE Customer_Copy
SET FirstName = LOWER(FirstName)
, LastName = UPPER(LastName)
--specify what you want to do using the SET keyword
--Output: '(61 row(s) affected)'

SELECT *
FROM Customer_Copy
--Can verify that output was correct by viewing case of FirstName & LastName

UPDATE Customer_Copy
SET FirstName = LOWER(FirstName)
, LastName = UPPER(LastName)
, Phone = NULL
, Fax = NULL

SELECT *
FROM Customer_Copy
--Can verify that output was correct

UPDATE Customer_Copy
SET FirstName = LOWER(FirstName)
, LastName = UPPER(LastName)
, Phone = NULL
, Fax = NULL
, Company = CASE WHEN Email LIKE '%gmail%' THEN 'Google'
	ELSE 'N/A'
	END

SELECT *
FROM Customer_Copy
--Affects all of the rows, view output to verify

--Pull in data from other table
UPDATE CC
	SET Phone = C.Phone
	, Fax = C.Fax
--Pulling info. from the Customer C file
FROM Customer_Copy CC
JOIN Customer C
	ON C.CustomerId = CC.CustomerId
WHERE CC.Country = 'Canada'
--Output: '(8 row(s) affected)'

SELECT 
	Country
	, Phone
	, Fax
FROM Customer_Copy

DROP TABLE Customer_Copy
--Will remove the Customer_Copy table from the file tables