/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 15.2 OUTPUT Code Combinations
---Make sure you are in the JProCo database

--Skill Check 1:
CREATE TABLE MyGrantChanges
(GrChangeDt datetime,
INSGrName nvarchar(40),
INSGrAmt money
)
GO

MERGE [Grant] AS gr
USING GrantCheckMaster AS gcm
ON gr.GrantID = gcm.GrantID 
WHEN MATCHED THEN --Update
	UPDATE SET gr.GrantName=gcm.GrantName,
	           gr.EmpID=gcm.EmpID, gr.Amount=gcm.Amount	
WHEN NOT MATCHED BY TARGET THEN --Insert
	INSERT (GrantID, GrantName, EmpID, Amount)
	VALUES (gcm.GrantID, gcm.Grantname, gcm.EmpID, gcm.Amount)
WHEN NOT MATCHED BY SOURCE THEN --Delete
	DELETE
OUTPUT '2009-8-15', Inserted.GrantName, Inserted.Amount INTO MyGrantChanges;

		----**student creates MyGrantChanges table**
		--CREATE TABLE MyGrantChanges
		--(
		--GrChangeDt  datetime,
		--INSGrName nvarchar(50) null,
		--INSGrAmt smallmoney null
		--)
		--GO
		----**check results by querying ProductPriceChange table**
		--SELECT * FROM MyGrantChanges

--Skill Check 2:
INSERT INTO ProductPriceChange 
SELECT * FROM
(UPDATE CurrentProducts
SET RetailPrice = RetailPrice + 3.00
OUTPUT inserted.ProductID, Deleted.RetailPrice, inserted.RetailPrice
WHERE RetailPrice < 40) as updCurProd (ProductID, OldPrice, NewPrice)
		----**student creates ProductPriceChange table**
		--CREATE TABLE ProductPriceChange
		--(ProductID int not null,
		--OldPrice money null,
		--NewPrice money null
		--)
		--GO
		----**check results by querying ProductPriceChange table**
SELECT * FROM ProductPriceChange


--Skill Check 3:
MERGE EmployeeLMO AS ELMO
USING EmpCheckMaster AS ECM
ON ELMO.EmpID = ECM.EmpID
WHEN MATCHED AND NOT (ELMO.ManagerID = ECM.ManagerID) THEN --update
	UPDATE SET ELMO.EmpID=ECM.EmpID, ELMO.LastName=ECM.LastName, ELMO.FirstName=ECM.FirstName,
			   ELMO.HireDate=ECM.HireDate, ELMO.LocationID=ECM.LocationID,ELMO.ManagerID = ECM.ManagerID,
			   ELMO.[Status]=ECM.[Status]
WHEN NOT MATCHED BY TARGET THEN --insert
	INSERT (EmpID, LastName, FirstName, HireDate, 
			LocationID, ManagerID, [Status])
	VALUES (ECM.EmpID, ECM.LastName, ECM.FirstName, ECM.HireDate, 
			ECM.LocationID, ECM.ManagerID, ECM.[Status])
WHEN NOT MATCHED BY SOURCE THEN --delete
	DELETE
OUTPUT Inserted.FirstName, Inserted.LastName, Inserted.ManagerID, Inserted.LocationID,
	   Inserted.HireDate, Inserted.[Status], Inserted.EmpID INTO EmpMergeArchive;

--****************************************************************************
--SELECT * FROM EmployeeLMO AS ELMO   --the student creates this (code given in Skill Check)
--SELECT * FROM EmpCheckMaster AS ECM 
--SELECT * FROM EmpMergeArchive       











