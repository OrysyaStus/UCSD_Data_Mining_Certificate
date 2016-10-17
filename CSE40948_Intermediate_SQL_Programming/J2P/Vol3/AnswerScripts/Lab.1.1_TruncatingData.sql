/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 1.1 Truncating data
---Make sure you are in the JProCo


--Skill Check1:
DELETE FROM Contractor
WHERE LocationID != 1



--Skill Check2:
TRUNCATE TABLE Contractor
GO

INSERT INTO Contractor 
VALUES ('Barker', 'Bill', CURRENT_TIMESTAMP, 1)

SELECT * 
FROM Contractor
















