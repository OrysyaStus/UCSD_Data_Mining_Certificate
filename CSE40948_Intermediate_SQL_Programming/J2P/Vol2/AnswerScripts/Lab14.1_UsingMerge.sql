/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 14.1 Using Merge
---Make sure you are in the JProCo database


--Skill Check1:
CREATE PROC UpsertLocation @LocID int, @Street varchar(50), @City varchar(25), @State varchar(25)
AS
BEGIN
	MERGE Location as loc
	USING (SELECT @LocID,@Street,@City,@State) 
		as LocScr (LocationID, street, city, [state])
	ON loc.LocationID = LocScr.LocationID
	WHEN MATCHED THEN UPDATE SET loc.street = @Street, 
		loc.City = @City, loc.[State] = @State
	WHEN NOT MATCHED THEN INSERT (LocationID, street, 
		city, [state])
		VALUES(@LocID,@Street,@City,@State);
END
GO

		---->student input this code prescribed by Lab 13.2 instructions
		----EXEC UpsertLocation 1,'545 Pike','Seattle','WA'
		----EXEC UpsertLocation 5,'1595 Main','Philadelphia','PA'
		----GO
		----SELECT * FROM Location

--Skill Check 2:
MERGE dbo.PayRates as pr
USING dbo.PayRatesFeed as src
ON pr.EmpID = src.EmpID
WHEN MATCHED THEN UPDATE 
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

--Skill Check3:
CREATE PROC UpsertMgmtTraining @ClassID Int, @ClassName varchar(50), 
@ClassDuration int, @ApprovedDate datetime
AS
BEGIN
	MERGE MgmtTraining AS MT
	USING (SELECT @ClassID,@ClassName,@ClassDuration,@ApprovedDate)
		AS MTFeed (ClassID, ClassName, ClassDurationHours, ApprovedDate)
	ON MT.ClassID = MTFeed.ClassID
	WHEN MATCHED THEN UPDATE SET MT.ClassName = @ClassName, --Update to the values passed into to the proc.
		MT.ClassDurationHours = @ClassDuration, MT.ApprovedDate = @ApprovedDate
	WHEN NOT MATCHED THEN INSERT (ClassName, 
		ClassDurationHours, ApprovedDate)
		VALUES (@ClassName,@ClassDuration,@ApprovedDate); --Insert the values passed into to the proc.
END
GO

-->after creating sproc, student calls on sproc using this code (per Lab 13.1)
EXEC UpsertMgmtTraining 3,'Challenging Negotiations',40,'12/1/2009'
EXEC UpsertMgmtTraining 0,'Corporate Privacy',8,'12/1/2009'
GO
SELECT * FROM MgmtTraining




















