/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 12.2 Optimistic Concurrency

--Skill check 1
ALTER DATABASE dbBasics
SET ALLOW_SNAPSHOT_ISOLATION ON

USE dbBasics
GO

SET TRANSACTION ISOLATION LEVEL SNAPSHOT 
GO

DBCC USEROPTIONS
