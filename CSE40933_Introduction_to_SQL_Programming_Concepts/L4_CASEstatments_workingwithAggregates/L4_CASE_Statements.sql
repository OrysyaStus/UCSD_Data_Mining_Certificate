--CASE..THEN statements like IF...THEN statements.

--Simple CASE example
SELECT
	FirstName
	, LastName
	, Country
	, CASE Country
--Will be evaluating all the cases of Country
		WHEN 'Brazil' THEN 'South America'
		WHEN 'Argentina' THEN 'South America'
		WHEN 'Canada' THEN 'North America'
		WHEN 'USA' THEN 'North America'
		END AS Region
--When 'country' then region (where Region will be the name of the new column). 
--Note: NULL appeared where CASE statement didn't apply.
--Simple CASE statment: evaluate against one column where format is CASE column name.
--Cannot check for greater than, less than, for NULLs.
FROM Customer

SELECT
	FirstName
	, LastName
	, Country
	, CASE Country
		WHEN 'Brazil' THEN 'South America'
		WHEN 'Argentina' THEN 'South America'
		WHEN 'Canada' THEN 'North America'
		WHEN 'USA' THEN 'North America'
		WHEN 'India' THEN 'Asia'
		ELSE 'Europe'
		END AS Region
--Add in ELSE statement to change NULL statement to other label.
FROM Customer

--Search CASE example
SELECT
	FirstName
	, LastName
	, Country
	, CASE	
--For search CASE do not enter the column name immediately after CASE.
		WHEN Country IN('USA', 'Canada') THEN 'North America'
		WHEN Country IN('Brazil', 'Argentina', 'Chile') THEN 'South America'
		WHEN Country = 'India' THEN 'Asia'
		WHEN Country = 'Australia' THEN Country
--Will return back Australia in Region column
		END Region
FROM Customer
--The advantage is that you can identify multiple labels on a single line.
--CASE statements resolve in the order written, firsst line which resolves true then will exit out of the CASE statement

SELECT
	FirstName
	, LastName
	, Country
	, CASE	
		WHEN Country IN('USA', 'Canada') THEN 'North America'
		WHEN Country IN('Brazil', 'Argentina', 'Chile') THEN 'South America'
		WHEN Country = 'India' THEN 'Asia'
		WHEN Country = 'Australia' THEN Country
		ELSE 'Europe'
		END Region
FROM Customer

SELECT
	Company
--Many NULL values exist for the argument
	, Email
--If new that the suffix of the email identified the name of the company which the person works for.
--Can write a code in which if the Company is written in then include the company if not then take suffix of the Email as the company.
	, CASE
		WHEN Company IS NOT NULL THEN Company
		WHEN Email LIKE '%gmail%' THEN 'Google'
		WHEN Email LIKE '%apple%' THEN 'Apple'
		WHEN Email LIKE '%yahoo%' THEN 'Yahoo!'
		ELSE 'Company Unknown'
		END DerivedCompanyName
--Can use more than 1 column in search CASE statment
FROM Customer

--Searched CASE with nested CASE statement
SELECT
	State
	, Country
	, CASE	
--For search CASE do not enter the column name immediately after CASE.
		WHEN Country IN('USA') THEN
			CASE 
				WHEN State IN('CA', 'NV', 'WA') THEN 'USA-West'
				WHEN State IN('MA', 'NY') THEN 'USA-NorthEast'
				WHEN State IN('TX', 'AZ') THEN 'USA-SouthWest'
				ELSE 'USA-Other'
				END
--Subcategorize regions in the USA.
		WHEN Country IN('Canada') THEN 'North America'
		WHEN Country IN('Brazil', 'Argentina', 'Chile') THEN 'South America'
		WHEN Country = 'India' THEN 'Asia'
		WHEN Country = 'Australia' THEN Country
		ELSE 'Europe'
		END Region
FROM Customer
ORDER BY Country