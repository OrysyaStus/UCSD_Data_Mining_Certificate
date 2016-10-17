/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 3.3 Identity Fields
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
SET IDENTITY_INSERT MgmtTraining ON

INSERT INTO MgmtTraining
(ClassID, ClassName, ClassDurationHours, ApprovedDate)
VALUES (4,'Empowering Others',18,CURRENT_TIMESTAMP)

SET IDENTITY_INSERT MgmtTraining OFF

select * from MgmtTraining






