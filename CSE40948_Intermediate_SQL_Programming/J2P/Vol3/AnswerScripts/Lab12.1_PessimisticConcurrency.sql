/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 12.1 Pessimistic Concurrency

--Skill Check 1: Set the ISOLATION LEVEL to that Dirty Reads are not allowed but non-repeatable reads are allowed. 

SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
