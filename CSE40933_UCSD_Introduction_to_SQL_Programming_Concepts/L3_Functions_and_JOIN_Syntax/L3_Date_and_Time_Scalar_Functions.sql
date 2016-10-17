SELECT 
	BirthDate
	--, GETDATE()
--The command provides current date
	, YEAR(BirthDate)
	, Month(BirthDate)
	, DAY(BirthDate)
	, DATENAME(Quarter, BirthDate)
	, DATENAME(Month, BirthDate)
	, DATENAME(Weekday, BirthDate)
--Always returns a string.
	, DATEPART(Month, BirthDate)
	, DATEPART(Weekday, BirthDate)
--Always returns an integer.
FROM Employee

SELECT 
	BirthDate
	, '1962'
	, '10'
	, '24'
	, DATEFROMPARTS(1962, 10, 24)
--Converts 3 integers into a date.
	, DATETIMEFROMPARTS(1962, 10, 24, 23, 34, 30, 0)
--Converts 7 integers into a date and time.
FROM Employee

SELECT 
	BirthDate
	, HireDate
	, DATEDIFF(Year, BirthDate, HireDate) [When hired age]
	, DATEDIFF(Hour, BirthDate, HireDate)/8766 [AgeAtHire]
--Where 8766 is the number of hours in a year
FROM Employee
--When working with ages, keep in mind how DATEDIFF function works.

SELECT
	BirthDate
	, HireDate
	, DATEADD(Year, 10, BirthDate)
--Add amount onto specificied parameter of date.
--DATEADD can take a negative number (subtraction), no such function as DATESUB for subtraction.
FROM Employee

SELECT
	BirthDate	
	, ISDATE(HireDate)
	, '2012-02-28'
	, ISDATE('2012-02-28')
	, ISDATE('2-12-02-30')
--Check to see if a string inputted is a true date; 1 is yes 0 if no.
--Handy when working with external files ie. excel files, filter out columns which should not be within the date column.
FROM Employee

SELECT
	BirthDate
	, CONVERT(varchar, BirthDate, 101)
--Converting the file type is necessary in order to use the styles.
--Styles:
--1 = mo.da.ye
--101 = mo/da/year
--102 = year.mo.da
--103 = da/mo/year
--104 = da.mo.year
--etc.
FROM Employee