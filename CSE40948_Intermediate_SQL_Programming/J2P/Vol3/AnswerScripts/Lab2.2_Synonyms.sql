/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 2.2 Database Synonyms


--Skill Check 1: Remove the Classes synonym from JProCo
USE JProCo
GO

DROP SYNONYM Classes
GO


--Skill Check 2: Change the SalesArea Synonym to point to the Region Table
USE JProCo
GO

DROP SYNONYM SalesArea 
GO
CREATE SYNONYM SalesArea FOR dbo.Region
GO

SELECT * FROM SalesArea 


--Skill Check 3: Add RegionID 3 of Mexico with a population of 120 Million
USE JProCo
GO

INSERT INTO dbo.Region VALUES (3,'Mexico', 120)

SELECT * FROM dbo.Region

