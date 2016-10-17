/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 7.2 Non-Clustered Indexes

--Skill check 1
CREATE UNIQUE NONCLUSTERED INDEX [UNCI_Contractor_Email] ON [HumanResources].[Contractor] 
(
	[EMail] ASC
)

--If you want to insert records uncomment the lines below and run.

/*
INSERT INTO HumanResources.Contractor VALUES ('222-22-2222','Jonny','Dirt','Jdirt@JProCo.com',35000)
INSERT INTO HumanResources.Contractor VALUES ('656-66-6767','Sally','Smith','SallyS@JProCo.com',45000)
INSERT INTO HumanResources.Contractor VALUES ('888-88-8888','Irene','Intern','I-IreneI@JProCo.com',null)
INSERT INTO HumanResources.Contractor VALUES ('555-55-5555','Rick','Morelan','rmorelan@JProCo.com',25000)
INSERT INTO HumanResources.Contractor VALUES ('999-99-9999','Vince','Verhoff','Viv@JProCo.com',65000)
INSERT INTO HumanResources.Contractor VALUES ('444-44-4444','Major','Disarray ','Majord@JProCo.com',20000)
*/

