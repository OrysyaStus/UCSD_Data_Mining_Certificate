/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 1.4 Creating and Populating tables
/*Make sure you are in the JProCo
database before running*/

USE JProCo
GO
--Skill Check1 (create the table):
CREATE TABLE [StateList]
(StateID Char(2) NOT NULL,
StateName varchar(50) NOT NULL,
RegionName varchar(50) NULL,
LandMass int NULL)
GO

--Second part of Skill Check 1 (populate the table using BCP):
--Copy Ch1StateListFeed.txt  to the Joe2Pros folder.

--Open a command prompt and type cd c:\Joes2Pros

--BCP JProCo.dbo.StateList in Ch1StateListFeed.txt -c -r \n  -T

--Skill Check 2 (drop and re-create the SalesInvoiceDetail table):
USE JProCo
GO
DROP TABLE SalesInvoiceDetail
GO

CREATE TABLE [SalesInvoiceDetail]
(InvoiceDetailID int NOT NULL PRIMARY KEY,
InvoiceID int NOT NULL,
ProductID int NOT NULL,
Quantity int NOT NULL,
UnitDiscount smallmoney NULL )
GO
--Second part of Skill Check 2 (populate the table using BCP):
--Copy Ch1SalesInvoiceDetailFeed.txt to the Joe2Pros folder.

--Open a command prompt and type cd c:\Joes2Pros

--BCP JProCo.dbo.SalesInvoiceDetail in Ch1SalesInvoiceDetailFeed.txt -c -r \n  -T