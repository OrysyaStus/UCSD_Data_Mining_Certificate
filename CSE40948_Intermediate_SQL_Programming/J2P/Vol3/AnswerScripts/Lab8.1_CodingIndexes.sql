/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 8.1 Coding Indexes

--Skill check 1
CREATE UNIQUE NONCLUSTERED INDEX UNCI_Vendor_Email
ON HumanResources.Vendor(Email)
GO