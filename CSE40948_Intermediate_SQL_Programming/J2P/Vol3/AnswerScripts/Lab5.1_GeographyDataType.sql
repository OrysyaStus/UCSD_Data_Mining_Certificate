/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 5.1 Geography DataTypes


---Skill Check #1
INSERT INTO Location 
VALUES (6,'915 Wallaby Drive','Sydney',NULL,-33.876,151.315,GEOGRAPHY::Point(-33.876,151.315,4326))

--Skill Check #2
SELECT * 
FROM Location
--Click "Spatial Results" tab
--Select Projection: Boone

--Skill Check #3
SELECT Lm.city,Lo.City,
Lm.GeoLoc.STDistance(Lo.GeoLoc)/1609 as MilesApart
FROM Location Lm
CROSS JOIN Location Lo
WHERE Lm.city != Lo.City
ORDER BY MilesApart DESC
