/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 6.1 Spacial Envelope Aggregates
--Skill Check 1:
--Take the following query for the ShapeMetry Field
USE dbBasics
GO

SELECT *
FROM SkiAreas
WHERE ShapeCode IN ('sh','M1')

--Turn it into a Shape Collection
SELECT GEOMETRY::CollectionAggregate(ShapeMetry)
FROM SkiAreas
WHERE ShapeCode IN ('sh','M1')


--Skill Check 2: Take the Same Query from Skill check one and turn it into 1 polygon
SELECT GEOMETRY::UnionAggregate(ShapeMetry)
FROM SkiAreas
WHERE ShapeCode IN ('sh','M1')



--Skill Check 3: Combine all the Counties of Idaho into 1 shape using the ShapeMetry field
SELECT GEOMETRY::UnionAggregate(ShapeMetry)
FROM SkiAreas
WHERE ShapeName LIKE '%County'
AND ShapeParentCode = 'ID'

--Skill Check 4:
--Take the following query for the ShapeMetry Field and Group on the RoomNotes field.
--Note, Since you can't Group by a LOB type you need to cast the RoomNotes fields as an NVARCHAR(20)
USE JProCo
GO

SELECT CAST(RoomNotes AS nvarchar(20)) as RoomNotes, GEOMETRY::UnionAggregate(RoomLocation) as Location
FROM HumanResources.RoomChart
WHERE RoomNotes IS NOT NULL
GROUP BY CAST(RoomNotes AS nvarchar(20))






