6.1 Spatial Unions and Collections
6.2 Spatial Envelope Aggregates
7.1 Clustered Indexes
	
7.2 Nonclustered Indexes
8.1 Coding Indexes
8.2 Index Options
9.1 Query Execution Plans

--cHECK EXEC PLANS
SELECT * FROM SALESINVOICEDETAIL
WHERE INVOICEID = 5

SELECT * FROM SALESINVOICEDETAIL
WHERE INVOICEID = 5

CREATE NONCLUSTERED INDEX
NCI_SALESINVOICEDETAIL_INVOICEID
ON SALESINVOICEDETAIL(INVOICEID)


SELECT * FROM SALESINVOICEDETAIL
WHERE INVOICEID != 5

--USED TABLE SCAN

SELECT * FROM SALESINVOICEDETAIL
WITH(INDEX(NCI_SALESINVOICEDETAIL_INVOICEID))
WHERE INVOICEID != 5


SELECT * 
FROM CUSTOMER
WHERE CUSTOMERTYPE = 'Business' --scan

CREATE NONCLUSTERED INDEX
NCI_CUSTOMER_CUSTOMERTYPE ON CUSTOMER(CUSTOMERTYPE)

--GET EXEC PLAN


SELECT * 
FROM CUSTOMER
WHERE CUSTOMERTYPE = 'Consumer'  --seek

declare @type varchar(50)
set @type = 'Business'

SELECT * 
FROM CUSTOMER
WHERE CUSTOMERTYPE = @type


declare @type varchar(50)
set @type = 'Consumer'


SELECT * 
FROM CUSTOMER
WHERE CUSTOMERTYPE = @type


declare @type varchar(50)
set @type = 'Business'

SELECT * 
FROM CUSTOMER
WHERE CUSTOMERTYPE = @type
option(optimize for (@type = 'Business') -- using query hint


use adventureworks
select * from sales.salesorderdetail

select top(50) *
 from sales.salesorderdetail

select *
 from sales.salesorderdetail
option(FAST 50)



9.2 Index Statistics


select top (12) *
from SalesInvoiceDetail

select * from HumanResources.RoomChart

sp_helpstats 'HumanResources.RoomChart'

DBCC SHOW_STATISTICS ('HUMANRESOURCES.ROOMCHART', _WA_Sys_00000001_37A5467C) --HISTOGRAMS

CREATE STATISTICS RoomChart_RoomName ON HumanResources.RoomChart(RoomName)

sp_helpstats 'HumanResources.RoomChart'

DBCC SHOW_STATISTICS ('HUMANRESOURCES.ROOMCHART', RoomChart_RoomName) --HISTOGRAMS

--Statistics periodically autoupdates


create statistics Customer_CustomerType
on dbo.Customer(CustomerType)

sp_helpStats 'dbo.Customer'

UDPDATE STATISTICS Customer NCI_Customer_CustomerType --specific only to the index

UPDATE STATISTICS Customer -- updates all index statistics


10.1 Introduction to GUIDs

-- Identity Fields - are normally unique

USE JPROCO
GO

CREATE TABLE TestInt
(IntID INT IDENTITY(1,1),
IntName VARCHAR(25)
)
GO

INSERT into TestInt
values('One'),('Two'), ('Three'), ('Four'), ('Five'), ('Six')

select * from TestInt


--GUID - Globally Unique Identifier - 16 byte unique number

SELECT NEWID()

CREATE TABLE TESTGUID
(GuidID uniqueidentifier default newid(),
intName Varchar(25)
)
go

INSERT INTO TestGuid
VALUES (DEFAULT,'One'),(DEFAULT,'Two'),(DEFAULT,'Three'),(DEFAULT,'Four'),(DEFAULT,'Five'),(DEFAULT,'Six')

SELECT * FROM TESTGUID


--LOOKING FOR RANGES ON GUIDS


SELECT * FROM TESTGUID
WHERE GUIDID = ' '


SELECT * FROM TESTGUID
WHERE GUIDID != ' '

SELECT * FROM TESTGUID
WHERE GUIDID > ' '


SELECT * FROM TESTGUID
WHERE GUIDID < ' '


SELECT * FROM TESTGUID
WHERE GUIDID LIKE '% % '


SELECT * FROM TESTGUID
WHERE GUIDID LIKE ' '

SELECT * FROM TESTGUID
WHERE GUIDID < ' '


SELECT NEWID()
SELECT NEWID(UNIQUEIDENTIFIER, '12345678-AAAA-BBBB-CCCCC-+++')

10.2 Advantages / Disadvantages of GUIDs

--aUTO GENERATED FIELD VALUES
-- 

CREATE TABLE SERVER_A
(INTID INT IDENTITY(1,1),
INTNAME VARCHAR(20)
)
GO

INSERT INTO SERVER_A
VALUES ('One'),('Two'),('Three'),('Four'),('Five'),('Six')

CREATE TABLE SERVER_B
(INTID INT IDENTITY(1,1),
INTNAME VARCHAR(20)
)
GO

INSERT INTO SERVER_B
VALUES ('Seven'),('Eight'),('Nine'),('Ten'),('Eleven'),('Twelve')


select * from server_a
select * from server_b


CREATE TABLE DataWareHouse
(INTID INT PRIMARY KEY,
INTNAME VARCHAR(20)
)
GO

INSERT INTO DataWareHouse
VALUES ('Seven'),('Eight'),('Nine'),('Ten'),('Eleven'),('Twelve')


INSERT INTO DataWareHouse
SELECT * FROM SERVER_A


INSERT INTO DataWareHouse
SELECT * FROM SERVER_B



DROP TABLE SERVER_A
DROP TABLE SERVER_B
DROP TABLE DataWareHouse


CREATE TABLE SERVER_A
(G_ID UNIQUEIDENTIFIER DEFAULT NEWID(),
G_NAME VARCHAR(25)
)
GO
INSERT INTO SERVER_A
VALUES (DEFAULT,'One'),(DEFAULT,'Two'),(DEFAULT,'Three'),(DEFAULT,'Four'),(DEFAULT,'Five'),(DEFAULT,'Six')




CREATE TABLE SERVER_B
(G_ID UNIQUEIDENTIFIER DEFAULT NEWID(),
G_NAME VARCHAR(25)
)
GO
INSERT INTO SERVER_B
VALUES (DEFAULT,'Seven'),(DEFAULT,'Eight'),(DEFAULT,'Nine'),(DEFAULT,'Ten'),(DEFAULT,'Eleven'),(DEFAULT,'Twelve')


CREATE TABLE DataWareHouse
(G_ID UNIQUEIDENTIFIER PRIMARY KEY,
G_NAME VARCHAR(25)
)
GO


INSERT INTO DataWareHouse
select * from SERVER_A

INSERT INTO DataWareHouse
select * from SERVER_B



SELECT * FROM DataWareHouse
-- advantage - guarranteed to be unique


10.3 GUID Performance

--Performance

SELECT NEWID()


SELECT NEWSEQUENTIALID()

TRUNCATE TABLE TESTGUID

INSERT INTO TESTGUID
VALUES (DEFAULT,'1'),(DEFAULT,'2'),(DEFAULT,'3'),(DEFAULT,'4'),(DEFAULT,'5'),(DEFAULT,'6'),(DEFAULT,'7')


SELECT * FROM TESTGUID

SELECT * FROM TESTGUID
ORDER BY GuidID


CREATE TABLE TESTGUID
(GuidID uniqueidentifier default newid(),
intName Varchar(25)
)
go


CREATE TABLE TESTSEQ
(GuidID uniqueidentifier default NEWSEQUENTIALID(),
intName Varchar(25)
)
go

INSERT INTO TESTSEQ
VALUES (DEFAULT,'1'),(DEFAULT,'2'),(DEFAULT,'3'),(DEFAULT,'4'),(DEFAULT,'5'),(DEFAULT,'6'),(DEFAULT,'7')


SELECT * FROM TESTSEQ

SELECT * FROM TESTSEQ
ORDER BY GUIDID


DECLARE @IDNAME INT = 6
WHILE @IDNAME <=25000
BEGIN
	INSERT INTO TESTGUID VALUES (DEFAULT, @IDNAME)
	SET @IDNAME = @IDNAME + 1

END



DECLARE @IDNAME INT = 6
WHILE @IDNAME <=25000
BEGIN
	INSERT INTO TESTSEQ VALUES (DEFAULT, @IDNAME)
	SET @IDNAME = @IDNAME + 1

END


11.1 SQL Locking

USE JPROCO
GO

DROP DATABASE DBMOVIE
GO

--try dropping jproco db



select * from location

kill 'session number'


11.2 Transactions


USE DBMOVIE
GO

SELECT * FROM MOVIE

UPDATE MOVIE
SET M_RUNTIME = M_RUNTIME + 1

--AUTO COMMITTED TRANSACTIONS

BEGIN TRANSACTION

UPDATE MOVIE
SET M_RUNTIME = M_RUNTIME - 1


--COMMIT TRANSACTION
--ROLLBACK TRANSACTION


-- CHECK REQUESTS
SELECT * FROM SYS.DM_EXEC_REQUESTS
WHERE SESSION_ID > PROVIDE #


11.3 Deadlocks

USE JPROCO
GO

SELECT @@SPID

BEGIN TRANSACTION

UPDATE LOCATION
SET STREET = '101 Pike'
where locationid = 1



--open another session or query window
DBCC OPENTRAN


--COMMIT TRANSACTION
--ROLLBACK TRANSACTION


-- CHECK REQUESTS
SELECT * FROM SYS.DM_EXEC_REQUESTS
WHERE SESSION_ID > PROVIDE #

12.1 Pessimistic Concurrency


USE NORTHWIND
BEGIN TRAN
UPDATE dbo.Employees
set HireDate='1/1/1992'
WHERE EmployeeID = 1

WAITFOR DELAY '00:00:30'

--open another connection and run below - Dirty Read vs committed read
--isolation level read uncommitted - dirty reads are allowed.
--isolation level read committed - dirty reads are not allowed.

SELECT HireDate
FROM dbo.Employees
WHERE EmployeeID = 1


--ROLLBACK TRAN


BEGIN TRAN
UPDATE dbo.Employees
set HireDate='1/1/2002'
WHERE EmployeeID = 1

WAITFOR DELAY '00:01:30'

--open another connection and run below - Dirty Read vs committed read
--isolation level read uncommitted - dirty reads are allowed.
--isolation level read committed - dirty reads are not allowed.

SELECT HireDate
FROM dbo.Employees
WHERE EmployeeID = 1


--ROLLBACK TRAN

SELECT *
FROM Employee (NOLOCK)
WHERE EmpID = 1


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
GO

SELECT *
FROM Employee
WHERE EmpID = 1


SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO

SELECT *
FROM Employee
WHERE EmpID = 1


--Concurrency problem: Nonrepeatable Reads




12.2 Optimistic Concurrency

/*
ISOLATION LEVELS	Dirty Reads	Nonrepeatable Reads

Read Uncommitted	YES		YES
Read Committed		NO		YES
Repeatable Read		NO		NO

*/

DBCC USEROPTIONS

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
GO

BEGIN TRANSACTION

SELECT * FROM EMPLOYEE
WHERE EMPID = 3

WAITFOR DELAY '00:00:30'

UPDATE EMPLOYEE
SET LASTNAME = 'Smith'
where Empid = 2

--COMMIT TRANSACTION
--ROLLBACK TRANSACTION

--open another session or query window

UPDATE EMPLOYEE
SET LASTNAME = 'Eccles'
where Empid = 2



DBCC USEROPTIONS
GO
--USE A HIGHER LEVEL ISOLATION LEVEL

--SET TRANSACTION ISOLATION LEVEL SNAPSHOT -- MUST BE ENABLED

ALTER DATABASE JPROCO

SET ALLOW_SNAPSHOT_ISOLATION ON
GO

DBCC USEROPTIONS

BEGIN TRAN

SELECT * FROM EMPLOYEE 
WHERE EMPID = 3

WAITFOR DELAY '00:00:30'


UPDATE EMPLOYEE
SET LASTNAME = 'Wagner'
where Empid = 3

COMMIT TRAN


--ANOTHER SESSION
UPDATE EMPLOYEE
SET LASTNAME = 'Wagner'
where Empid = 3



12.3 READ_COMMITTED_SNAPSHOT



USE JPROCO
GO


ALTER DATABASE JPROCO
SET READ_COMMITTED_SNAPSHOT ON -- CANNOT SET IF SOMEONE IS USING THE DATABASE.



