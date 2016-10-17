/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 4.3 Date-Time Types


--Skill Check1:
USE JProCo
GO

ALTER TABLE Employee
ADD HiredOffset Datetimeoffset null
GO

ALTER TABLE Employee
ADD TimeZone char(6) null
GO

UPDATE Employee SET Timezone = '-08:00'
WHERE LocationID in (1,4) --Seattle Spokane

UPDATE Employee SET Timezone = '-05:00'
WHERE LocationID in (2) --Boston

UPDATE Employee SET Timezone = '-06:00'
WHERE LocationID in (3) OR LocationID IS NULL --Chicago

--Skill Check2:
UPDATE Employee
SET HiredOffset = TODATETIMEOFFSET(HireDate,Timezone)


--Skill Check3:
SELECT SWITCHOFFSET(HiredOffset,'-09:00') as AlaskHireTime
,*
FROM Employee


