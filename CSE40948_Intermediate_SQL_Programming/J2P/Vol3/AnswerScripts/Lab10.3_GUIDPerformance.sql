/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

--Lab 10.3

--Skill check 1
--Add the CtrSeq UNIQUEIDENTIFIER non nullable field to the [dbo].[Contractor] using the NEWSEQUENTIALID()
ALTER TABLE [dbo].[Contractor]
ADD CtrSeq UNIQUEIDENTIFIER NOT NULL DEFAULT NEWSEQUENTIALID()
GO

--Check your results
SELECT *
FROM Contractor


