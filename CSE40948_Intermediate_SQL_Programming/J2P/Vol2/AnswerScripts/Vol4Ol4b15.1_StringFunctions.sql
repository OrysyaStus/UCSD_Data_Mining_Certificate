/*
** Joes2Pros.com 2009
** All Rights Reserved.
*/

---Code for Lab 15.1 String Functions
---Make sure you are in the JProCo database


--Skill Check1:
SELECT LocationID, street, 
UPPER(city) as Municipality , [state]
FROM Location


--Skill Check2:
SELECT FirstName, LastName, 
LEN(FirstName) + LEN(LastName) as NameSize
FROM Employee


--Skill Check3:
SELECT EmpID, FirstName, LastName,
LEFT(FirstName,2) + REPLACE(LastName, '''', '') 
+ '@JProCo.com' as Email
FROM Employee

OR

select EmpID, FirstName, LastName, 
CAST(Firstname as varchar(2))+
REPLACE(Lastname, '''', '')+
Cast('@JProCo.com' as varchar(max)) as Email
from Employee