/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 4.1 Sparse DataType Option


--Skill Check1:
ALTER TABLE Customer
ALTER COLUMN CompanyName ADD SPARSE 

EXEC sp_SpaceUsed 'Customer'