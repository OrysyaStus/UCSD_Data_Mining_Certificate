/*
** Joes2Pros.com 2009
** All Rights Reserved.
*/

---Code for Lab 15.2 Time Functions
---Make sure you are in the JProCo database


--Skill Check1:
SELECT ProductName, OriginationDate,
DATEPART(mm,OriginationDate) AS OrigMonth
FROM CurrentProducts
WHERE DATEPART(mm,OriginationDate) = 12


--Skill Check2:
---the instructions call for the student to assume "today" is 11/19/2009
SELECT *
FROM Employee
WHERE HireDate > DATEADD(mm,-2,'11/19/2009')


--Skill Check3:
SELECT *
FROM SalesInvoice
WHERE PaidDate BETWEEN DATEADD(D,-30,GetDate())
AND GETDATE()

--***if the hardcoded date 8/29/09 is run, the result will be the same as in Figure 15.45**
SELECT *
FROM SalesInvoice
WHERE PaidDate BETWEEN DATEADD(D,-30,'11/19/2009')
AND '11/19/2009'

