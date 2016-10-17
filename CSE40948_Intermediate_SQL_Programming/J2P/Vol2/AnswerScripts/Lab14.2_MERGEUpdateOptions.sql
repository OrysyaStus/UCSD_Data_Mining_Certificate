/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 14.2 Merge Update Options
---Make sure you are in the JProCo database


--Skill Check1:
MERGE dbo.PayRates AS pr
USING dbo.PayRatesFeed AS src
ON pr.EmpID = src.EmpID
WHEN MATCHED AND NOT (pr.YearlySalary = src.YearlySalary) THEN UPDATE 
	SET pr.YearlySalary = src.YearlySalary,
	pr.MonthlySalary = src.MonthlySalary,
	pr.HourlyRate = src.HourlyRate
WHEN NOT MATCHED THEN INSERT 
	(EmpID,YearlySalary, MonthlySalary, HourlyRate)
	VALUES (src.EmpID,
	src.YearlySalary,
	src.MonthlySalary,
	src.HourlyRate);
GO
-->after running the MERGE statement, student uses this code to check his work
select * from PayRatesFeed
select * from PayRates