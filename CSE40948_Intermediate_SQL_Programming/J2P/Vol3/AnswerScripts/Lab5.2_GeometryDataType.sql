/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 5.2 Geometry DataTypes


---Skill Check #1
INSERT INTO HumanResources.RoomChart
VALUES (8, 'PRK', 'Yard Parking Lot', NULL, NULL,
GEOMETRY::STPolyFromText('Polygon ((0 3, 9 3, 9 19, 0 19,0 3))',0)
)


--Skill Check #2

DECLARE @Yard GEOMETRY
DECLARE @Warehouse GEOMETRY
DECLARE @Lumber GEOMETRY
DECLARE @Park GEOMETRY

SELECT @Yard = RoomLocation 
FROM HumanResources.RoomChart
WHERE R_ID = 5

SELECT @Warehouse = RoomLocation 
FROM HumanResources.RoomChart
WHERE R_ID = 6

SELECT @Lumber = RoomLocation 
FROM HumanResources.RoomChart
WHERE R_ID = 7

SELECT @Park = RoomLocation 
FROM HumanResources.RoomChart
WHERE R_ID = 8
SELECT @Warehouse.STContains(@Park)
SELECT @Yard.STContains(@Park)

SELECT @Yard, @Warehouse, @Lumber, @Park

--Is the parking lot inside the yard ?
SELECT @Yard.STContains(@Park)
--1, YES

--Is the parking lot inside the Warehouse?
SELECT @Warehouse.STContains(@Park)
--0, no

