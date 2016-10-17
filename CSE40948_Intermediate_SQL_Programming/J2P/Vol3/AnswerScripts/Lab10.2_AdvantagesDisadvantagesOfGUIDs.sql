/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab10.2

--Skill check 1
--Create ServerC table with the same structure as ServerB and ServerC with records Eleven to Fifteen
CREATE TABLE ServerC
(G_ID  UNIQUEIDENTIFIER DEFAULT NEWID(),
G_Name  VARCHAR(25)
)
GO


INSERT INTO ServerC
VALUES (DEFAULT, 'Eleven'), (DEFAULT, 'Twelve'), (DEFAULT, 'Thirteen'), (DEFAULT, 'Fourteen'), (DEFAULT, 'Fifteen')


SELECT * 
FROM ServerC


--Skill Check 2:
--Insert the records from ServerC into the DataWarehouse

INSERT INTO DataWarehouse
SELECT * FROM ServerC


SELECT * 
FROM DataWarehouse
