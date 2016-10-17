/* Creating and Using User Defined Functions */

CREATE FUNCTION DayOfBirth_fn (@date date)
--have to enclose the parameters
RETURNS varchar(10) 
--have to tell the function the output data type
AS
BEGIN
RETURN DATENAME(WEEKDAY, @date)
END
--encapsulate any code you are writing inside BEGIN and END components

GO

SELECT
	BirthDate
	, dbo.DayOfBirth_fn(BirthDate) AS DayOfBirth
FROM Employee
-- Programmability > Functions > Salar-valued Functions to determine the schema


/* Create function that will return Supervisor's name for a particular employee */
CREATE FUNCTION Supervisor_fn (@ReportTo int)
RETURNS varchar(50)
AS
BEGIN
DECLARE @Supervisor varchar(50)
--create a variabe within the function
SELECT
	@Supervisor = CONCAT(FirstName, ' ', LastName)
FROM Employee
WHERE EmployeeId = @ReportTo
RETURN @Supervisor
--will return a single value
END

GO

SELECT
	EmployeeId
	, FirstName
	, LastName
	, ReportsTo
	, dbo.Supervisor_fn(ReportsTo)
--be sure to provide the function schema
FROM Employee
--were able to avoid the hassle of creating a SELF JOIN to the table and building out a CONCAT function

/* To ALTER a function */
-- 1. Programmability > Functions > Modify
--ie. stored procedure or view
--2. ALTER FUNCTION Supervisor_fn (@ReportTo int)
--RETURNS varchar(50)
--AS
--BEGIN
--DECLARE @Supervisor varchar(50)
----create a variabe within the function
--SELECT
--	@Supervisor = CONCAT(FirstName, ' ', LastName, EmployeeId)
--FROM Employee
--WHERE EmployeeId = @ReportTo
--RETURN @Supervisor
----will return a single value
--END
EXEC sp_helptext Supervisor_fn
--grab text syntax, copy and paste, edit it

DROP FUNCTION dbo.DayOfBirth_fn
--confirm by viewing the Functions tab