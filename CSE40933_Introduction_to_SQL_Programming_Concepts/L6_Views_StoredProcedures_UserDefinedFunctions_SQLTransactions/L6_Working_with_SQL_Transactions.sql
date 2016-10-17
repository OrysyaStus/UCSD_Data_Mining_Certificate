/* Working with SQL Transactions */
--when execute 1+ SQL queries in a single window, if no errors seen then commited if generate error then changes are rolledback

IF OBJECT_IF('Customer_Temp') IS NOT NULL DROP TABLE Customer_Temp

SELECT *
INTO Customer_Temp
FROM Customer

DELETE Customer_Temp
WHERE Country NOT IN('India', 'Denmark')
--if accidently execute only "DELETE Customer_Temp" then screwed since not transactions exist
--only way to get it back would be to recreate it or get it back

--Creating a transaction:
BEGIN TRANSACTION
DELETE Customer_Temp

SELECT *
FROM Customer_Temp
--no rows exist
--but haven't committed the transaction yet

COMMIT TRANSACTION
--the rows are deleted forever
--if rollback after commit then will cause an error to occur

ROLLBACK TRANSACTION
--if didn't mean to delete the entire table
SELECT *
FROM Customer_Temp
--all 59 rows are back

--Creating a transaction:
BEGIN TRANSACTION
DELETE Customer_Temp
WHERE Country NOT IN('India', 'Denmark')

SELECT *
FROM Customer_Temp

DELETE Customer_Temp
WHERE Country = 'India'

/*
COMMIT TRANSACTION

ROLLBACK TRANSACTION
*/

--If the table is locked by the transaction, there will not be an execution in a different tab
--must choose either COMMIT or ROLLBACK to ensure that the database is not locked, before continuing

--View info. in a table even if the table is locked, use:
SELECT *
FROM Customer_Temp WITH (NOLOCK)
--shows what exists in the table, even if a lock exists on the table; ignores the fact that is hasn't been committed yet
--good to check what is present in the table, but shouldn't be relied upon if the table becomes updated often