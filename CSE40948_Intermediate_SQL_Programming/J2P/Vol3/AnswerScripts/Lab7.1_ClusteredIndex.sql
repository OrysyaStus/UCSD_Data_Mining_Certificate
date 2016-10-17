/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 7.1 Intro to Indexes
--Skill check 1 is done in the UI

--Skill check 2
IF EXISTS(SELECT * FROM Sys.objects so INNER JOIN sys.schemas ss ON so.schema_id = ss.Schema_id WHERE so.[name]= 'Contractor'  AND ss.[name] = 'HumanResources')
DROP TABLE HumanResources.Contractor
GO


CREATE TABLE HumanResources.Contractor
(
ContractorID INT IDENTITY(1,1) PRIMARY KEY,
SSN CHAR(11),
FirstName varchar(25) NOT NULL,
LastName varchar(35) NOT NULL,
EMail varchar(50) NOT NULL,
Pay money NULL)
GO

INSERT INTO HumanResources.Contractor VALUES ('222-22-2222','Jonny','Dirt','Jdirt@JProCo.com',35000)
INSERT INTO HumanResources.Contractor VALUES ('656-66-6767','Sally','Smith','SallyS@JProCo.com',45000)
INSERT INTO HumanResources.Contractor VALUES ('888-88-8888','Irene','Intern','I-IreneI@JProCo.com',null)
INSERT INTO HumanResources.Contractor VALUES ('555-55-5555','Rick','Morelan','rmorelan@JProCo.com',25000)
INSERT INTO HumanResources.Contractor VALUES ('999-99-9999','Vince','Verhoff','Viv@JProCo.com',65000)
INSERT INTO HumanResources.Contractor VALUES ('444-44-4444','Major','Disarray ','Majord@JProCo.com',20000)
