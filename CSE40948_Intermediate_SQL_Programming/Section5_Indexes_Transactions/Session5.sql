


-- Using Merge

SELECT * FROM [Grant] --Grant 10 will be change Name and Amount

CREATE PROC UpdateGrant @GrID char(3), @GrName varchar(50),
@EmID int, @Amt smallmoney
AS
	UPDATE [Grant] 
	SET GrantName = @GrName, EmpID = @EmID , Amount = @Amt 
	WHERE GrantID = @GrID 

-----------------
SELECT * FROM [Grant]
EXEC UpdateGrant '010','Call Mom',5,9900
SELECT * FROM [Grant]

EXEC UpdateGrant '011','Big Giver Tom',7,95900 --Does not work with inserts
-------------------

CREATE PROC UpsertGrant @GrID char(3), @GrName varchar(50),
@EmID int, @Amt smallmoney
AS
	MERGE [Grant] as gr
	USING (SELECT @GrID ,@GrName ,@EmID ,@Amt ) as 
			Grantsrc (GrantID, GrantName, EmpID, Amount)
	ON gr.GrantID = Grantsrc.GrantID
	WHEN MATCHED THEN
		UPDATE SET gr.GrantName = Grantsrc .GrantName, gr.EmpID = Grantsrc.EmpID,
		gr.Amount = Grantsrc.Amount

	WHEN NOT MATCHED THEN
		INSERT (GrantID, GrantName, EmpID, Amount)
		VALUES (Grantsrc.GrantID, Grantsrc.GrantName, Grantsrc.EmpID, Grantsrc.Amount);

-------CROSS APPLY

SELECT *
FROM SalesInvoice as si  --We cant tell how many items were in InvoiceID 1 or any other invoice. 


SELECT *
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID --but what is the price

SELECT *
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID

SELECT si.InvoiceID, si.CustomerID, si.OrderDate,
sd.ProductID, sd.Quantity,
cp.ProductName, sd.Quantity, cp.RetailPrice
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID

SELECT si.InvoiceID, si.CustomerID, si.OrderDate,
sd.ProductID, sd.Quantity,
cp.ProductName, sd.Quantity, cp.RetailPrice
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID
WHERE si.CustomerID 1 -- Try 3 also


SELECT *
FROM dbo.fn_GetCustomerOrders(1) --Try 3 also

SELECT * FROM Customer

SELECT *
FROM Customer as cu
INNER JOIN dbo.fn_GetCustomerOrders(cu.CustomerID) --Does not work

SELECT *
FROM Customer as cu
CROSS APPLY dbo.fn_GetCustomerOrders(cu.CustomerID) --This works

SELECT *
FROM Customer as cu
CROSS APPLY dbo.fn_GetCustomerOrders(cu.CustomerID) 
ORDER BY cu.CustomerID



-- OUter Apply

SELECT *
FROM Customer
WHERE CUstomerID = 1 --How many products has he ordered?

SELECT *
FROM fn_GetCustomerOrders(1) --Try 2 and 3 for both queries
--Notice 5 and 7 have not yet orderd 



SELECT *
FROM Customer as cu
CROSS APPLY fn_GetCustomerOrders(cu.CustomerID) --Will not show 5 and 7

SELECT *
FROM Customer as cu
OUTER APPLY fn_GetCustomerOrders(cu.CustomerID) --Will show 5 and 7


--Using Merge

SELECT *
FROM [Grant]

EXEC UpsertGrant '010','Call Mom',5,9900
EXEC UpsertGrant '011','Big Giver Tom',7,95900



SELECT * FROM [Grant]

SELECT * FROM [GrantFeed] --Two records, one is new, one is an update
--Seperate Window
MERGE [Grant] as gr
USING GrantFeed as gf
ON gr.GrantID = gf.GrantID
WHEN MATCHED THEN
	UPDATE SET gr.GrantName = 	gf.GrantName,	gr.Amount = gf.Amount, gr.EmpID = gf.EmpID
WHEN NOT MATCHED THEN
	INSERT (GrantID, GrantName, EmpID, Amount)
	VALUES (gf.GrantID, gf.GrantName, gf.EmpID, gf.Amount);

	
----Merge Updating Options 

SELECT * FROM [Grant] --Target
SELECT * FROM [GrantFeed] --Source


SELECT * FROM ORDER BY GrantID [Grant] --Target
SELECT * FROM ORDER BY GrantID [GrantFeedCheckMaster] --Source
--If not matched by target then insert
--If not matched by source then delete


MERGE [Grant] as gr
USING GrantCheckMaster as gcm
ON gr.GrantID = gcm.GrantID
WHEN MATCHED THEN --Update
WHEN NOT MATCHED BY TARGET THEN --Insert
WHEN NOT MATCHED BY SOURCE THEN --Delete
DELETE;

MERGE [Grant] as gr
USING GrantCheckMaster as gcm
ON gr.GrantID = gcm.GrantID
WHEN MATCHED THEN
	update SET gr.EmpID = gcm.EmpID,
	gr.GrantName = gcm.GrantName,
	gr.Amount = gcm.Amount
WHEN NOT MATCHED BY TARGET
	INSERT (GrantID, GrantName, EmpID, Amount)
	VALUES (gcm.GrantID, gcm.GrantName, gcm.EmpID, gcm.Amount)
WHEN NOT MATCHED BY SOURCE
DELETE;




SELECT * FROM Employee
--Phil works for Manager 4
SELECT * FROM PromotionList
--Phil works for Manager 11
--Fact EmpID 14 will be inserted.
--Fact EmpID 10,11,12 there is no change
--Fact EmpID 13 Phil will have a new boss
--1 Insert, 1 Update, 1 Delete

MERGE Employee AS em
USING PromotionList as pl
ON em.EmpID = pl.EmpID
WHERE MATCHED AND NOT (em.ManagerID = pl.ManagerID) THEN --Update	
WHEN NOT MATCHED THEN --Insert


MERGE Employee AS em
USING PromotionList as pl
ON em.EmpID = pl.EmpID
WHERE MATCHED AND NOT (em.ManagerID = pl.ManagerID) THEN
	UPDATE SET em.ManagerID = pl.ManagerID
WHEN NOT MATCHED THEN
	INSERT (EmpID, LastName, FirstName, HireDate,
		LocationID, ManagerID, [Status])
	VALUES (pl.EmpID, pl.LastName, pl.FirstName, pl.HireDate,
		pl.LocationID, pl.ManagerID, pl.[Status]);


--CROSS APPLY


SELECT *
FROM SalesInvoice as si  --We cant tell how many items were in InvoiceID 1 or any other invoice. 


SELECT *
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID --but what is the price

SELECT *
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID

SELECT si.InvoiceID, si.CustomerID, si.OrderDate,
sd.ProductID, sd.Quantity,
cp.ProductName, sd.Quantity, cp.RetailPrice
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID

SELECT si.InvoiceID, si.CustomerID, si.OrderDate,
sd.ProductID, sd.Quantity,
cp.ProductName, sd.Quantity, cp.RetailPrice
FROM SalesInvoice as si
INNER JOIN SalesInvoiceDetail sd
ON si.InvoiceID = sd.InvoiceID
INNER JOIN CurrentProducts as cp
ON cp.ProductID = sd.ProductID
WHERE si.CustomerID 1 -- Try 3 also


SELECT *
FROM dbo.fn_GetCustomerOrders(1) --Try 3 also

SELECT * FROM Customer

SELECT *
FROM Customer as cu
INNER JOIN dbo.fn_GetCustomerOrders(cu.CustomerID) --Does not work

SELECT *
FROM Customer as cu
CROSS APPLY dbo.fn_GetCustomerOrders(cu.CustomerID) --This works

SELECT *
FROM Customer as cu
CROSS APPLY dbo.fn_GetCustomerOrders(cu.CustomerID) 
ORDER BY cu.CustomerID


-------- OUter Apply

SELECT *
FROM Customer
WHERE CUstomerID = 1 --How many products has he ordered?

SELECT *
FROM fn_GetCustomerOrders(1) --Try 2 and 3 for both queries
--Notice 5 and 7 have not yet orderd 



SELECT *
FROM Customer as cu
CROSS APPLY fn_GetCustomerOrders(cu.CustomerID) --Will not show 5 and 7

SELECT *
FROM Customer as cu
OUTER APPLY fn_GetCustomerOrders(cu.CustomerID) --Will show 5 and 7


------15 Using OUTPUT
--Run the reset script

DELETE 
FROM Location
WHERE [State] = 'WA'

DELETE 
FROM Location
OUTPUT deleted.*
WHERE [State] = 'WA'


INSERT INTO Location
OUTPUT Inserted.*
VALUES(6,'678 CanDo St','Portland','OR')

SELECT * FROM Location



UPDATE Location
SET City = 'Kirkland'
WHERE LocationID = 1

SELECT * FROM Location WHERE LocationID = 1

UPDATE Location
SET City = 'Tacoma'
OUTPUT Deleted.*
WHERE LocationID = 1

UPDATE Location
SET City = 'Seattle'
OUTPUT Inserted.*
WHERE LocationID = 1

UPDATE Location
SET City = 'Anacortes'
OUTPUT Inserted.*, Deleted.*
WHERE LocationID = 1



DELETE 
FROM Location
OUTPUT deleted.*
WHERE [State] = 'WA'

SELECT * FROM Deleted --Error (scope is done)



SELECT *
FROM Location

SELECT *
FROM LocationChanges

DELETE 
FROM Location
OUTPUT deleted.* INTO LocationChanges
WHERE [State] = 'WA'

--Lets change WA to WS

UPDATE Location
SET [state] = 'WS'
WHERE [State] = 'WA'

UPDATE Location
SET [state] = 'WS'
OUTPUT Inserted.* 
WHERE [State] = 'WA'

Insert into LocationChanges
SELECT * FROM 
  (UPDATE Location
  SET [state] = 'WS'
  OUTPUT Inserted.* 
  WHERE [State] = 'WA') as LocIns

SELECT *
FROM Location

SELECT *
FROM LocationChanges



15.2 Output code combinations 

SELECT *
FROM mgmtTraining

DELETE FROM mgmtTraining
OUTPUT Deleted.*
WHERE ClassID = 8

INSERT INTO TrainingChangeLog
SELECT * FROM
  (DELETE FROM mgmtTraining
  OUTPUT Deleted.*, GetDate()
  WHERE ClassID = 8) as TrainChange

SELECT * FROM mgmtTraining

SELECT * FROM TrainingChangeLog



--Now make an update
SELECT * FROM mgmtTraining --40 hours will become 32
SELECT * FROM TrainingChangeLog

UPDATE mgmTraining
SET ClassDurationHours = 32
WHERE ClassID = 3

UPDATE mgmTraining
SET ClassDurationHours = 32
OUTPUT Inserted.*, GetDate()
WHERE ClassID = 3)

INSERT INTO TrainingChangeLog
  (UPDATE mgmTraining
  SET Inserted.*, GetDate()
  OUTPUT ClassDurationHours = 32) as UpdateChange


  WHERE ClassID = 3)



--String Functions

SELECT FirstName, LastName
FROM Employee --First names seem to vary from 3 to 8 letters long

SELECT FirstName, LastName, Len(FirstName) as FNameSize
FROM Employee

SELECT FirstName, LastName, Len(FirstName) as FNameSize,
Len(LastName) as LNameSize
FROM Employee



SELECT FirstName, LastName, UPPER(FirstName) as UpperFName,
LOWER(LastName) as LowerLName
FROM Employee


SELECT FirstName, LastName, LEFT(FirstName,2) AS PreFName,
RIGHT(FirstName,3) as EndFName
FROM Employee


SELECT FirstName
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,1)
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,2)
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,Len(FirstName)-2)
FROM Employee




--Book2 14.1 

DELETE 
FROM Location
WHERE [State] = 'WA'

DELETE 
FROM Location
OUTPUT deleted.*
WHERE [State] = 'WA'


INSERT INTO Location
OUTPUT Inserted.*
VALUES(6,'678 CanDo St','Portland','OR')

SELECT * FROM Location



UPDATE Location
SET City = 'Kirkland'
WHERE LocationID = 1

SELECT * FROM Location WHERE LocationID = 1

UPDATE Location
SET City = 'Tacoma'
OUTPUT Deleted.*
WHERE LocationID = 1

UPDATE Location
SET City = 'Seattle'
OUTPUT Inserted.*
WHERE LocationID = 1

UPDATE Location
SET City = 'Anacortes'
OUTPUT Inserted.*, Deleted.*
WHERE LocationID = 1



--Run the reset script
DELETE 
FROM Location
OUTPUT deleted.*
WHERE [State] = 'WA'

SELECT * FROM Deleted --Error (scope is done)


--Run the reset script
SELECT *
FROM Location

SELECT *
FROM LocationChanges

DELETE 
FROM Location
OUTPUT deleted.* INTO LocationChanges
WHERE [State] = 'WA'

--Run reset script
--Lets change WA to WS
UPDATE Location
SET [state] = 'WS'
WHERE [State] = 'WA'

UPDATE Location
SET [state] = 'WS'
OUTPUT Inserted.* 
WHERE [State] = 'WA'

Insert into LocationChanges
SELECT * FROM 
  (UPDATE Location
  SET [state] = 'WS'
  OUTPUT Inserted.* 
  WHERE [State] = 'WA') as LocIns

SELECT *
FROM Location

SELECT *
FROM LocationChanges





--Book 2  14.2 

SELECT *
FROM mgmtTraining

DELETE FROM mgmtTraining
OUTPUT Deleted.*
WHERE ClassID = 8

INSERT INTO TrainingChangeLog
SELECT * FROM
  (DELETE FROM mgmtTraining
  OUTPUT Deleted.*, GetDate()
  WHERE ClassID = 8) as TrainChange

SELECT * FROM mgmtTraining

SELECT * FROM TrainingChangeLog



--Now make an update
SELECT * FROM mgmtTraining --40 hours will become 32
SELECT * FROM TrainingChangeLog

UPDATE mgmTraining
SET ClassDurationHours = 32
WHERE ClassID = 3

UPDATE mgmTraining
SET ClassDurationHours = 32
OUTPUT Inserted.*, GetDate()
WHERE ClassID = 3)

INSERT INTO TrainingChangeLog
  (UPDATE mgmTraining
  SET Inserted.*, GetDate()
  OUTPUT ClassDurationHours = 32) as UpdateChange


  WHERE ClassID = 3)



--Book 2  15.1

SELECT FirstName, LastName
FROM Employee --First names seem to vary from 3 to 8 letters long

SELECT FirstName, LastName, Len(FirstName) as FNameSize
FROM Employee

SELECT FirstName, LastName, Len(FirstName) as FNameSize,
Len(LastName) as LNameSize
FROM Employee



SELECT FirstName, LastName, UPPER(FirstName) as UpperFName,
LOWER(LastName) as LowerLName
FROM Employee


SELECT FirstName, LastName, LEFT(FirstName,2) AS PreFName,
RIGHT(FirstName,3) as EndFName
FROM Employee


SELECT FirstName
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,1)
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,2)
FROM Employee

SELECT FirstName, SUBSTRING(FirstName,2,Len(FirstName)-2)
FROM Employee



--Book2 15.2

SELECT GETDATE()
SELECT GETDATE()+1 --Tomorrow
SELECT GETDATE()-1 --Yesterday



SELECT * 
FROM Contractor

UPDATE Contractor SET HireDate = GetDate() -1
WHERE CtrID = 1

UPDATE Contractor SET HireDate = GetDate() +1
WHERE CtrID = 2



SELECT * 
FROM Contractor

SELECT GetDate()

SELECT * 
FROM Contractor
WHERE HireDate < GetDate() --Hired before today

SELECT * 
FROM Contractor
WHERE HireDate - 30 < GetDate() --Hired in the last 30 days



SELECT *
FROM MgmtTraining

SELECT *, DatePart(yy,ApprovedDate)
FROM MgmtTraining

SELECT *, DatePart(yy,ApprovedDate), 
DatePart(mm,ApprovedDate)
FROM MgmtTraining

SELECT GetDate()
SELECT GetDAte() + 1 --1 day in the future
SELECT GetDate() + 30 --One month (sort of) into the future
SELECT DateAdd(M,1,GetDate())
SELECT DateAdd(M,2,GetDate())
SELECT DateAdd(D,30,GetDate())
SELECT DateAdd(D,-30,GetDate())


SELECT * 
FROM SalesInvoice

SELECT * 
FROM SalesInvoice
WHERE PaidDate < DateAdd(D,30,GetDate())



--Book 2 15.3

SELECT ServerProperty() --Not enough info
SELECT ServerProperty('ProductVersion')  --10.0.2
SELECT ServerProperty('ProductLevel') --RTM
SELECT ServerProperty('Edition') --Developer

SELECT ServerProperty('Product Version') ,('ProductLevel') ,ServerProperty('Edition')


--Create a new database called dbTest
--Expand and notice there are no tables or views
--There are some system views

--Go back to JProCo to see a mixture of system and user created objects.
SELECT *
FROM sys.objects --Look for the Customer table and find the OBject ID

SELECT '38593557'
SELECT OBJECTPROPERTY(38593557, 'ISMSShipped') --0 is no

SELECT *
FROM sys.objects --Look for the sysfiles1 table and find the OBject ID

SELECT OBJECTPROPERTY(8, 'ISMSShipped') --0 is no


SELECT *
FROM sys.objects
WHERE OBJECTPROPERTY([Objiect_id],'IsMsShipped') = 0



/*
Loops
The WHILE loop sets a condition for the repeated execution of an SQL statement or statement block. 
The statements are executed repeatedly as long as the specified condition is true. The execution of statements in the WHILE loop can be controlled from inside the loop with the BREAK and CONTINUE keywords.
Is an expression that returns TRUE or FALSE. 
If the Boolean expression contains a SELECT statement, the SELECT statement must be enclosed in parentheses.
Is any Transact-SQL statement or statement grouping as defined with a statement block. To define a statement block, use the control-of-flow keywords BEGIN and END. 
*/

-- Session 6
/*
Loops
The WHILE loop sets a condition for the repeated execution of an SQL statement or statement block. 
The statements are executed repeatedly as long as the specified condition is true. The execution of statements in the WHILE loop can be controlled from inside the loop with the BREAK and CONTINUE keywords.
Is an expression that returns TRUE or FALSE. 
If the Boolean expression contains a SELECT statement, the SELECT statement must be enclosed in parentheses.
Is any Transact-SQL statement or statement grouping as defined with a statement block. To define a statement block, use the control-of-flow keywords BEGIN and END. 
*/
USE JProco 
GO 
WHILE (SELECT AVG(RetailPrice) 
FROM dbo.CurrentProducts) < $300 
/*
BEGIN...END
Encloses a series of Transact-SQL statements so that a group of Transact-SQL statements can be executed. 
BEGIN and END are control-of-flow language keywords. 
*/
BEGIN 
	UPDATE dbo.CurrentProducts SET RetailPrice = RetailPrice * 2 
	SELECT MAX(RetailPrice) 	
	  FROM dbo.CurrentProducts 
		IF (SELECT MAX(RetailPrice) FROM dbo.CurrentProducts) > $500 
/*
BREAK in a WHILE loop causes an exit from the innermost WHILE loop. Any statements that appear after the END keyword, marking the end of the loop, are executed.
*/
		BREAK 
		ELSE 
/*
CONTINUE Causes the WHILE loop to restart, ignoring any statements after the CONTINUE keyword. 
*/
		CONTINUE 
END PRINT 'Too much for the market to bear';
-----------------------------------------------
-- Using Cursors in a WHILE loop
USE JProCo
GO
DECLARE Employee_Cursor CURSOR FOR
SELECT EmpID, FirstName, LastName, LocationID
FROM dbo.Employee
WHERE Status = 'Active';
OPEN Employee_Cursor;
FETCH NEXT FROM Employee_Cursor;
WHILE @@FETCH_STATUS = 0  -- Fetch statement was successful
-- @@FETCH_STATUS - Returns the status of the last cursor FETCH statement issued against any cursor currently opened by the connection.
-- @@FETCH_STATUS = -1 -- FETCH statement failed or the row was beyond the result set.
-- @@FETCH_STATUS = -2 -- Row fetched is missing.
   BEGIN
      FETCH NEXT FROM Employee_Cursor;
   END;
CLOSE Employee_Cursor;
DEALLOCATE Employee_Cursor;
GO
------------------------------------------------

/*
The IF statement is used to test for a condition. The resulting flow of control depends on whether the optional ELSE statement is specified: 
IF specified without ELSE 
When the IF statement evaluates to TRUE, the statement or block of statements following the IF statement are executed. When the IF statement evaluates to FALSE, the statement, or block of statements, following the IF statement is skipped. 
IF specified with ELSE 
When the IF statement evaluates to TRUE, the statement, or block of statements, following the IF statement, is executed. Then control jumps to the point after the statement, or block of statements, following the ELSE statement. 
When the IF statement evaluates to FALSE, the statement, or block of statements, following the IF statement is skipped and the statement, or block of statements, following the optional ELSE statement is executed. 
*/
IF 1 = 1 PRINT 'Boolean_expression is true.'
ELSE PRINT 'Boolean_expression is false.' ;
----------------------
IF 1 = 2 PRINT 'Boolean_expression is true.'
ELSE PRINT 'Boolean_expression is false.' ;
GO
----------------------
USE JProCo
GO
IF 
(SELECT COUNT(*) FROM CurrentProducts WHERE ProductName LIKE 'Wine Tasting Tour%' ) > 5
PRINT 'There are more than 5 Wine Tasting Tours.'
ELSE PRINT 'There are less than 5 Wine Tasting Tours.' ;
GO

/*
Microsoft SQL Server statements produce a complete result set, but there are times when the results are best processed one row at a time. Opening a cursor on a result set allows processing the result set one row at a time. You can assign a cursor to a variable or parameter with a cursor data type.
Cursor operations are supported on these statements:
CLOSE 
CREATE PROCEDURE 
DEALLOCATE 
DECLARE CURSOR 
DECLARE @local_variable 
DELETE 
FETCH 
OPEN 
UPDATE 
SET 
These system functions and system stored procedures also support cursors:
@@CURSOR_ROWS 
CURSOR_STATUS 
@@FETCH_STATUS 
sp_cursor_list 
sp_describe_cursor 
sp_describe_cursor_columns 
sp_describe_cursor_tables 

*/






