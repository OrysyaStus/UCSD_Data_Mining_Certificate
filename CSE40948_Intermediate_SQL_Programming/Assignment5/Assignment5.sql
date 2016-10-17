/* Orysya Stus - Assignment 5 */

/*
Extra 5 points. Please reset your databases using the Vol2 Chapter 13.0 setup script.
With the Cursor statements below, complete the update statement section on the Employee table to ensure the transaction completes and exits out of the loop.
*/

-- Using Cursors in a WHILE loop

USE
JProCo
GO

DECLARE
Employee_Cursor CURSOR FOR

SELECT
EmpID, FirstName, LastName, LocationID
FROM
dbo.Employee
WHERE Status = 'Active';

OPEN
Employee_Cursor;
FETCH
NEXT FROM Employee_Cursor;
WHILE
@@FETCH_STATUS = 0  -- Fetch statement was successful

-- @@FETCH_STATUS - Returns the status of the last cursor FETCH statement issued against any cursor currently opened by the connection.

-- @@FETCH_STATUS = -1 -- FETCH statement failed or the row was beyond the result set.

-- @@FETCH_STATUS = -2 -- Row fetched is missing.
BEGIN
	update dbo.Employee
	set LocationID = 4
	where LocationID = 3

	FETCH NEXT FROM Employee_Cursor;
END;

CLOSE
Employee_Cursor;
DEALLOCATE
Employee_Cursor;
GO
