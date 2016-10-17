/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 6.2 Spatial Envelope Aggregates
--Skill Check 1:
--In dbBasics draw a round envelope around Montana and show both shapes
USE dbBasics
GO

SELECT GEOGRAPHY::EnvelopeAggregate(ShapeOgraphy)
FROM SkiAreas
WHERE ShapeCode = 'MT'

UNION ALL

SELECT ShapeOgraphy
FROM SkiAreas
WHERE ShapeCode = 'MT'


--Skill Check 2:
-- In dbBasics draw a rectangle envelope around Montana and show both shapes
USE dbBasics
GO

SELECT GEOMETRY::EnvelopeAggregate(ShapeMetry)
FROM SkiAreas
WHERE ShapeCode = 'MT'

UNION ALL

SELECT ShapeMetry
FROM SkiAreas
WHERE ShapeCode = 'MT'



--Skill Check 3:
-- In dbBasics draw a convex hull around Idaho and Montana
USE dbBasics
GO 

SELECT GEOMETRY::ConvexHullAggregate(ShapeMetry)
FROM SkiAreas
WHERE ShapeParentCode = 'US'

UNION ALL

SELECT ShapeMetry
FROM SkiAreas
WHERE ShapeParentCode = 'US'






