USE dbBasics
GO

IF EXISTS (SELECT * FROM sys.tables WHERE [name] = 'SkiAreas')
DROP TABLE SkiAreas
GO

CREATE TABLE SkiAreas
(ShapeID INT PRIMARY KEY,
ShapeCode CHAR(2),
ShapeName VARCHAR(50),
ShapeParentCode CHAR(2),
ShapeOgraphy GEOGRAPHY,
ShapeMetry GEOMETRY,

)
GO

DECLARE @Idaho GEOGRAPHY
SET @Idaho = GEOGRAPHY::STGeomFromText('Polygon ((-117 49, -117 46,  -116.6 45.5, -117.1 44.5,  -117 42, -111 42, -111 44.5, -112.5 44.2,  -114 46, -114.55 45.8, -114.5 46.7, -115 46.9,-116 48, -116 49,-117 49 ))',4326)
DECLARE @IdahoMetry GEOMETRY
SET @IdahoMetry = GEOMETRY::STGeomFromText('Polygon ((-117 49, -117 46,  -116.6 45.5, -117.1 44.5,  -117 42, -111 42, -111 44.5, -112.5 44.2,  -114 46, -114.55 45.8, -114.5 46.7, -115 46.9,-116 48, -116 49,-117 49 ))',4326)


DECLARE @Shoshone GEOGRAPHY
SET @Shoshone = GEOGRAPHY::STGeomFromText('Polygon ((-116 48, -116.3 48.1, -116.3 46.9, -115 46.9, -116 48))',4326)
DECLARE @ShoshoneMetry GEOMETRY
SET @ShoshoneMetry = GEOMETRY::STGeomFromText('Polygon ((-116 48, -116.3 48.1, -116.3 46.9, -115 46.9, -116 48))',4326)

DECLARE @ClearWater GEOGRAPHY
SET @ClearWater = GEOGRAPHY::STGeomFromText('Polygon ((-116.3 46.9, -116.3 46.5, -115.9 46.3, -114.5 46.7, -115 46.9, -116.3 46.9  ))',4326)
DECLARE @ClearWaterMetry GEOMETRY
SET @ClearWaterMetry = GEOMETRY::STGeomFromText('Polygon ((-116.3 46.9, -116.3 46.5, -115.9 46.3, -114.5 46.7, -115 46.9, -116.3 46.9  ))',4326)


DECLARE @Kootenai GEOGRAPHY
SET @Kootenai = GEOGRAPHY::STGeomFromText('Polygon ((-117 48, -117 47.4, -116.5 47.4, -116.4 47.45, -116.3 47.5, -116.3 47.9, -116.4 47.9, -116.4 48, -117 48  ))',4326)
DECLARE @KootenaiMetry GEOMETRY
SET @KootenaiMetry = GEOMETRY::STGeomFromText('Polygon ((-117 48, -117 47.4, -116.5 47.4, -116.4 47.45, -116.3 47.5, -116.3 47.9, -116.4 47.9, -116.4 48, -117 48  ))',4326)


DECLARE @Montana GEOGRAPHY
SET @Montana = GEOGRAPHY::STGeomFromText('Polygon (( -116 49, -116 48, -115 46.9, -114.5 46.7, -114.55 45.8, -114 46, -112.5 44.2, -110.9 44.5,  -110.9 45, -104 45, -104 49,  -105 49, -106 49, -107 49, -108 49, -109 49, -110 49, -111 49, -112 49, -113 49, -114 49, -115 49, -116 49 ))',4326) 
DECLARE @MontanaMetry GEOMETRY
SET @MontanaMetry = GEOMETRY::STGeomFromText('Polygon (( -116 49, -116 48, -115 46.9, -114.5 46.7, -114.55 45.8, -114 46, -112.5 44.2, -110.9 44.5,  -110.9 45, -104 45, -104 49,  -105 49, -106 49, -107 49, -108 49, -109 49, -110 49, -111 49, -112 49, -113 49, -114 49, -115 49, -116 49 ))',4326) 


DECLARE @MtRunt GEOGRAPHY
SET @MtRunt = GEOGRAPHY::STGeomFromText('Polygon (( -116 47.5, -115.5 47, -115 47.5, -115.5 48,  -116 47.5 ))',4326) 
DECLARE @MtRuntMetry GEOMETRY
SET @MtRuntMetry = GEOMETRY::STGeomFromText('Polygon (( -116 47.5, -115.5 47, -115 47.5, -115.5 48,  -116 47.5 ))',4326) 


DECLARE @Lincoln GEOGRAPHY
SET @Lincoln = GEOGRAPHY::STGeomFromText('Polygon ((-116 49, -116 48.2, -115.7 48.3, -115.5 47.9, -115.2 47.9, -115.1 48, -115 48, -115 49, -116 49  ))',4326)
DECLARE @LincolnMetry GEOMETRY
SET @LincolnMetry = GEOMETRY::STGeomFromText('Polygon ((-116 49, -116 48.2, -115.7 48.3, -115.5 47.9, -115.2 47.9, -115.1 48, -115 48, -115 49, -116 49  ))',4326)


DECLARE @Sanders GEOGRAPHY
SET @Sanders = GEOGRAPHY::STGeomFromText('Polygon (( -116 48.2, -116 48, -115.73 47.7, -115 47.5, -114.2 47.1, -114.2 47.3, -114.3 47.3 -114.5 47.6, -114.5 47.9, -115 47.9, -115 48, -115.1 48,  -115.2 47.9, -115.5 47.9, -115.7 48.3,   -116 48.2	 ))',4326)
DECLARE @SandersMetry GEOMETRY
SET @SandersMetry = GEOMETRY::STGeomFromText('Polygon (( -116 48.2, -116 48, -115.73 47.7, -115 47.5, -114.2 47.1, -114.2 47.3, -114.3 47.3 -114.5 47.6, -114.5 47.9, -115 47.9, -115 48, -115.1 48,  -115.2 47.9, -115.5 47.9, -115.7 48.3,   -116 48.2	 ))',4326)


--SELECT @ClearWaterMetry
--UNION ALL
--SELECT @ShoshoneMetry
--UNION ALL 
--SELECT @KootenaiMetry
--UNION ALL 
--SELECT @IdahoMetry
--UNION ALL
--SELECT @LincolnMetry
--UNION ALL
--SELECT @SandersMetry
--UNION ALL 
--SELECT @MontanaMetry

INSERT INTO SkiAreas VALUES (1,'ID','Idaho State','US', @Idaho, @IdahoMetry)
INSERT INTO SkiAreas VALUES (2,'MT','Montana State','US', @Montana, @MontanaMetry)
INSERT INTO SkiAreas VALUES (3,'Kt','Kootenai County','ID', @Kootenai, @KootenaiMetry)
INSERT INTO SkiAreas VALUES (4,'Sh','Shoshone County','ID', @Shoshone, @ShoshoneMetry)
INSERT INTO SkiAreas VALUES (5,'Cl','ClearWater County','ID', @ClearWater, @ClearWaterMetry)
INSERT INTO SkiAreas VALUES (6,'Ln','Lincoln County','MT', @Lincoln, @LincolnMetry)
INSERT INTO SkiAreas VALUES (7,'Sd','Sanders County','MT', @Sanders, @SandersMetry)
INSERT INTO SkiAreas VALUES (8,'M1','Runt Mountain','**', @MtRunt, @MtRuntMetry)


SELECT * 
FROM SkiAreas
