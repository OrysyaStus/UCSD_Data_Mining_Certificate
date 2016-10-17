/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 15.1 Using OUTPUT
---Make sure you are in the JProCo database


--Skill Check1:
DELETE FROM Contractor
OUTPUT deleted.*
WHERE LocationID = 2


--Skill Check2:
INSERT INTO Contractor
OUTPUT inserted.*
VALUES ('Anderson','Vern',GetDate(),1)


--Skill Check 3:
UPDATE dbo.PayRates SET YearlySalary = YearlySalary + 1500
OUTPUT inserted.*, deleted.*
WHERE YearlySalary IS NOT NULL


--Skill Check 4:
DELETE FROM Contractor
OUTPUT Deleted.* INTO ContractorLog
WHERE HireDate > '1/1/2007'
	--student uses this code to confirm Skill Check 4 result:
	--SELECT * FROM Contractor
	--SELECT * FROM ContractorLog

--Skill Check 5:
INSERT INTO CurrentProducts
OUTPUT inserted.ProductID, inserted.OriginationDate
VALUES	('Baja 3 Day', 595, GETDATE(),0,'Medium-Stay',0), 
		('Baja 5 Day', 795, GETDATE(),0,'Medium-Stay',0)











