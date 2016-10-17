/*
** Joes2Pros.com 2009
** All Rights Reserved.
*/

---Code for Lab 10.1 

--Skill check 1
--Create the Skill10 table in JProCo to have a SkillID UNIQUEIDENTIFIER 
--that defaults to using the NEWID() and a field named SkillName as a VARHCHAR(20)
CREATE TABLE Skill10
(SkillID UNIQUEIDENTIFIER DEFAULT NEWID(),
SkillName VARCHAR(20)
)
GO

INSERT INTO Skill10
VALUES (DEFAULT, 'One'), (DEFAULT, 'Two')

SELECT * FROM Skill10

--Skill Check 2:
-- Alter the Contractor table to contain a field called CtrGuid
--Update the table with NEWID
ALTER TABLE [dbo].[Contractor]
ADD CtrGuid UNIQUEIDENTIFIER DEFAULT NEWID()
GO

UPDATE Contractor
SET CtrGuid = NEWID()

SELECT *
FROM Contractor
