/* Script for SelectTopRows command from SSMS */
SELECT TOP 1000 [EmployeeId]
	, [LastName]
	, [FirstName]
	, [Title]
	, [ReportsTo]
	, [HireDate]
	, [Address]
	, [City]
	, [State]
	, [Country]
	, [PostalCode]
	, [Phone]
	, [Fax]
	, [Email]
FROM [Chinook].[dbo].[Employee]

SELECT TOP 1000 [GenreId]	
	, [Name]
FROM [Chinook].[dbo].[Genre]

--Tip: Good to keep "Tables" folder opened in needed database.
--Also, divide SELECT, FROM, etc. clauses into separate lines for good readability.
--Also for finding & replacing names use "Quick Find" took in SSMS.
--Tabs allow for code readability and code function.
SELECT
	FirstName
	, LastName
	, Company
	, [PostalCode]
FROM Customer