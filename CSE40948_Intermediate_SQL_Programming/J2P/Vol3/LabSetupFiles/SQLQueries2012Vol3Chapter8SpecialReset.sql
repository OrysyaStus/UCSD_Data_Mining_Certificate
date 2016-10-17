--
/*	
*		Reset the Sales.Localities table 
*		for SQL QUERIES 2012 Joes 2 Pros
*		Volume 3, Chapter 8, Composite Indexes
*/
--

PRINT ' '
PRINT ' Resetting the Sales.Localities table...'
PRINT ' '
--
USE JProCo
GO
--
IF EXISTS ( SELECT [name] FROM sys.tables
						WHERE [name] = 'Localities')
DROP TABLE Sales.Localities
PRINT ' Dropping the Sales.Localities table...'
GO
--
PRINT ' Creating the Sales.Localities table...'
CREATE TABLE Sales.Localities
([GeoID] INT IDENTITY PRIMARY KEY,
[State] NVARCHAR(50) NOT NULL,
[City] NCHAR(50) NOT NULL,
[Population] INT NULL)
GO
--
PRINT ' Inserting records into the Sales.Localities table...'
INSERT INTO Sales.Localities
VALUES 
('Oregon','Springfield',35000),
('Michigan','Springfield',68000),
('Washington','Des Moines',24000),
('Iowa','Des Moines',212000),
('Oregon','Toledo',6500),
('Ohio','Toledo',413000)
GO
--
--SELECT * FROM Sales.Localities

PRINT ' '
PRINT ' The Sales.Localities table has been reset...'
PRINT ' '
PRINT ' The Sales.Localities table is ready to use!'
--