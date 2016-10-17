/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 11.3 

--Skill check 1:
--Query #1 and Run
BEGIN TRAN
UPDATE Employee SET HireDate = '1/1/2000' WHERE EmpID = 1

--Query #2 and Run
BEGIN TRAN
UPDATE Employee SET HireDate = '1/1/2000' WHERE EmpID = 2



--Skill check 2:
--Change Query #1 and complete
BEGIN TRAN
UPDATE Employee SET HireDate = '1/1/2000' WHERE EmpID = 1

SELECT * FROM Employee
COMMIT TRAN


--Change Query #2 and complete (SQL will realize there is a deadlock and kill one of the processes)
BEGIN TRAN
UPDATE Employee SET HireDate = '1/1/2000' WHERE EmpID = 2

SELECT * FROM Employee
COMMIT TRAN
