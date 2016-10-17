/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 7.2 Row_Number
/*Make sure you are in the JProCo
database before running*/
USE JProCo
GO

--Skill Check1:
 SELECT *,
RANK() OVER(ORDER BY LandMass) as RankNo,
DENSE_RANK() OVER(ORDER BY LandMass) as DRankNo,
ROW_NUMBER() OVER(ORDER BY LandMass) as RowNo
FROM StateList




