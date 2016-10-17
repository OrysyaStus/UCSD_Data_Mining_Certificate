/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 4.2 Custom Data Types


--Skill Check1:
USE JProCo
GO

CREATE TYPE dbo.Email
FROM varchar(50)
NULL
GO

ALTER TABLE JProCo.dbo.Employee
ADD EmailAddress dbo.Email
GO


--Skill Check 2:
--Check Dependencies first
ALTER TABLE dbo.Employee
DROP COLUMN Country 
GO

DROP TYPE dbo.CountryCode
GO