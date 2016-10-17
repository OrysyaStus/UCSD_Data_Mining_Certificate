/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 11.2 

--Skill check 1
--Query Window#1 (This will be the blocking query)
USE JProCo
GO

BEGIN TRAN
 UPDATE Employee SET HireDate = '1/1/2000'
 

--Query Window#2 (This query will be blocked)
USE JProCo
GO

SELECT *
FROM Employee

--Query Window#3 (Show the Activity)
SELECT * FROM sys.dm_exec_requests
WHERE session_id > 50


--Skill Check 2:
--From Skill Check 1, show the intermediate Records
USE JProCo
GO

SELECT *
FROM Employee (NOLOCK)



--Skill check 1
--Query Window#1 (This will be the blocking query)
USE JProCo
GO

BEGIN TRAN
 UPDATE Employee SET HireDate = '1/1/2000'
ROLLBACK TRAN