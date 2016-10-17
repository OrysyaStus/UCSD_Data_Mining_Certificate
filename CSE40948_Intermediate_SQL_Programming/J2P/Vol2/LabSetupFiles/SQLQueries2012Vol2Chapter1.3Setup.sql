/** Joes2Pros.com 2012
** All Rights Reserved.
*/
USE master
GO

IF EXISTS(SELECT * FROM sys.databases where [name] = 'JProCo' AND is_cdc_enabled = 1)
BEGIN
  EXEC JProco.sys.sp_cdc_Disable_db
END

IF EXISTS(SELECT * FROM sys.databases where [name] = 'dbBasics' AND is_cdc_enabled = 1)
BEGIN
  EXEC dbBasics.sys.sp_cdc_Disable_db
END
GO

WHILE (	(SELECT count(name) FROM sys.databases WHERE source_database_id = (SELECT database_id FROM sys.databases WHERE [name] = 'RatisCo')) > 0)
BEGIN
	DECLARE @ssName varchar(50)
	IF EXISTS(SELECT database_id FROM sys.databases WHERE [name] = 'RatisCo')
	BEGIN
	SELECT TOP 1 @ssName = name FROM sys.databases 
	WHERE source_database_id = (SELECT database_id FROM sys.databases WHERE [name] = 'RatisCo')
	EXEC ('DROP DATABASE ' + @ssName)
	END
END
GO

WHILE (	(SELECT count(name) FROM sys.databases WHERE source_database_id = (SELECT database_id FROM sys.databases WHERE [name] = 'dbBasics')) > 0)
BEGIN
	DECLARE @ssName varchar(50)
	IF EXISTS(SELECT database_id FROM sys.databases WHERE [name] = 'dbBasics')
	BEGIN
	SELECT TOP 1 @ssName = name FROM sys.databases 
	WHERE source_database_id = (SELECT database_id FROM sys.databases WHERE [name] = 'dbBasics')
	EXEC ('DROP DATABASE ' + @ssName)
	END
END
GO

if exists(SELECT * from sysdatabases WHERE name = 'JPracticeCo' )
DROP database JPracticeCo
go



if exists(SELECT * from sysdatabases WHERE name = 'DBMovie' )
DROP database DBMovie
go



if exists(SELECT * from sysdatabases WHERE name = 'DBsara' )
DROP database DBsara
go


if exists(SELECT * from sysdatabases WHERE name = 'DBMurray' )
DROP database DBMurray
go


if exists(SELECT * from sysdatabases WHERE name = 'DBAlan' )
DROP database DBAlan
go


if exists(SELECT * from sysdatabases WHERE name = 'DBBruce' )
DROP database DBBruce
go

-- Paste in all this code before starting
--code to create DB.
use master
go

if exists (select * from sys.sysdatabases where name = 'JProCo')
begin
  alter database JProCo set single_user with rollback immediate
  drop database JProCo
end
go



create database JProCo
go


use JProCo
go

CREATE TABLE PayRates
(EmpID int PRIMARY KEY,
YearlySalary smallMoney NULL,
MonthlySalary smallMoney NULL,
HourlyRate SmallMoney NULL,
Selector INT NULL,
Estimate float null)
GO

INSERT INTO PayRates VALUES (1,75000,null,null,1,1)
INSERT INTO PayRates VALUES (2,78000,null,null,1,1)
INSERT INTO PayRates VALUES (3,null,null,45,3,2080)
INSERT INTO PayRates VALUES (4,null,6500,null,2,12)
INSERT INTO PayRates VALUES (5,null,5800,null,2,12)
INSERT INTO PayRates VALUES (6,52000,null,null,1,1)
INSERT INTO PayRates VALUES (7,null,6100,null,2,12)
INSERT INTO PayRates VALUES (8,null,null,32,3,2080)
INSERT INTO PayRates VALUES (9,null,null,18,3,2080)
INSERT INTO PayRates VALUES (10,Null,null,17,3,2080)
INSERT INTO PayRates VALUES (11,115000,null,null,1,1)
INSERT INTO PayRates VALUES (12,null,null,21,3,2080)
INSERT INTO PayRates VALUES (13,72000,null,null,1,1)
GO

CREATE TABLE MgmtTraining
(
ClassID int PRIMARY KEY IDENTITY(1,1),
ClassName varchar(50) NOT NULL,
ClassDurationHours int NULL
)
GO

INSERT INTO MgmtTraining VALUES('Embracing Diversity',12)
INSERT INTO MgmtTraining VALUES('Interviewing',6)
INSERT INTO MgmtTraining VALUES('Difficult Negotiations',30)
GO

CREATE TABLE CurrentProducts
(
ProductID INT PRIMARY KEY IDENTITY(1,1),
ProductName nvarchar(max) NOT NULL,
RetailPrice MONEY NULL,
OriginationDate DateTime NULL,
ToBeDeleted bit Null)
GO
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Day West Coast',61.483,38938.5646985891,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Days West Coast',110.6694,39356.988458488,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 3 Days West Coast',184.449,39940.6721053332,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 5 Days West Coast',245.932,38778.2077153155,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Week West Coast',307.415,37088.8056875052,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Weeks West Coast',553.347,39627.8615597411,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Day East Coast',80.859,39177.3511948613,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Days East Coast',145.5462,38512.4112605625,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 3 Days East Coast',242.577,37710.2077066043,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 5 Days East Coast',323.436,38453.1906832043,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Week East Coast',404.295,38237.5524674277,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Weeks East Coast',727.731,39775.8331876042,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Day Mexico',105.059,37316.0710966305,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Days Mexico',189.1062,39498.9878692529,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 3 Days Mexico',315.177,38176.2430949518,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 5 Days Mexico',420.236,38240.3767755875,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Week Mexico',525.295,39903.8725296664,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Weeks Mexico',945.531,37339.5951645408,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Day Canada',85.585,38093.675084451,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Days Canada',154.053,39018.4242087035,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 3 Days Canada',256.755,38637.879998218,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 5 Days Canada',342.34,37117.2442517722,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Week Canada',427.925,38054.3068714327,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Weeks Canada',770.265,39433.852135422,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Day Scandinavia',116.118,39483.8537014876,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Days Scandinavia',209.0124,38496.4173770375,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 3 Days Scandinavia',348.354,38877.023904561,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 5 Days Scandinavia',464.472,39391.076613303,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 1 Week Scandinavia',580.59,38052.0438109738,0)
INSERT INTO dbo.CurrentProducts VALUES ('Underwater Tour 2 Weeks Scandinavia',1045.062,39899.5905334781,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Day West Coast',74.622,38536.6577839802,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Days West Coast',134.3196,39908.6100706344,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 3 Days West Coast',223.866,37843.0664539112,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 5 Days West Coast',298.488,37821.9679534215,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Week West Coast',373.11,37657.9522699812,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Weeks West Coast',671.598,37601.3823349779,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Day East Coast',107.159,37275.7359646449,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Days East Coast',192.8862,38536.2606421485,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 3 Days East Coast',321.477,38459.0360928693,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 5 Days East Coast',428.636,38129.307884931,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Week East Coast',535.795,40033.3878335664,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Weeks East Coast',964.431,39313.9725564362,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Day Mexico',71.142,37811.7129253815,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Days Mexico',128.0556,39183.6346355892,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 3 Days Mexico',213.426,38924.2769522567,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 5 Days Mexico',284.568,39298.7113757213,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Week Mexico',355.71,38957.0651958543,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Weeks Mexico',640.278,39462.0684195455,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Day Canada',113.287,39180.8168341431,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Days Canada',203.9166,38879.074454327,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 3 Days Canada',339.861,37685.0799336758,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 5 Days Canada',453.148,38758.4005149295,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Week Canada',566.435,39137.1733311248,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Weeks Canada',1019.583,37266.8967811644,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Day Scandinavia',111.735,37795.7316542821,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Days Scandinavia',201.123,38037.3179699925,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 3 Days Scandinavia',335.205,39238.6665718835,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 5 Days Scandinavia',446.94,38703.4397942087,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 1 Week Scandinavia',558.675,37571.2057501235,0)
INSERT INTO dbo.CurrentProducts VALUES ('History Tour 2 Weeks Scandinavia',1005.615,37321.8653259859,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Day West Coast',122.441,38183.7201059893,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Days West Coast',220.3938,39038.5808624833,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 3 Days West Coast',367.323,39852.4745643548,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 5 Days West Coast',489.764,39023.6564045141,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Week West Coast',612.205,37960.954554801,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Weeks West Coast',1101.969,38935.3250468,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Day East Coast',61.86,38051.8189952563,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Days East Coast',111.348,39710.8799736661,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 3 Days East Coast',185.58,39860.3050847484,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 5 Days East Coast',247.44,38356.3223683349,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Week East Coast',309.3,39343.4713408586,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Weeks East Coast',556.74,38688.8949543991,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Day Mexico',32.601,39177.2507165277,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Days Mexico',58.6818,38734.1321506432,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 3 Days Mexico',97.803,39878.3911684783,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 5 Days Mexico',130.404,37651.90411053,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Week Mexico',163.005,40069.9657832473,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Weeks Mexico',293.409,37337.4502284874,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Day Canada',62.544,38733.6079265914,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Days Canada',112.5792,38730.4444423955,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 3 Days Canada',187.632,38949.1223512803,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 5 Days Canada',250.176,38981.1774902795,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Week Canada',312.72,39788.2929574115,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Weeks Canada',562.896,39397.5812249504,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Day Scandinavia',107.175,37775.6187499454,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Days Scandinavia',192.915,37500.5485168183,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 3 Days Scandinavia',321.525,37879.0522472816,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 5 Days Scandinavia',428.7,40021.1379357811,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 1 Week Scandinavia',535.875,37566.5201696178,0)
INSERT INTO dbo.CurrentProducts VALUES ('Ocean Cruise Tour 2 Weeks Scandinavia',964.575,38534.809239181,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Day West Coast',85.933,38787.2579950323,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Days West Coast',154.6794,38267.0588560672,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 3 Days West Coast',257.799,39086.819014585,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 5 Days West Coast',343.732,37362.3953086562,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Week West Coast',429.665,40073.8722688064,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Weeks West Coast',773.397,37094.4313894593,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Day East Coast',69.992,37312.4384572618,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Days East Coast',125.9856,38589.0535116781,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 3 Days East Coast',209.976,39177.6920423815,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 5 Days East Coast',279.968,39972.5183074982,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Week East Coast',349.96,37666.7992296851,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Weeks East Coast',629.928,38840.6337311778,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Day Mexico',79.597,39366.9233556736,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Days Mexico',143.2746,39210.3484879195,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 3 Days Mexico',238.791,39272.7094335333,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 5 Days Mexico',318.388,38332.8699127606,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Week Mexico',397.985,38203.8170697493,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Weeks Mexico',716.373,38210.2550780113,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Day Canada',47.793,38838.2107985091,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Days Canada',86.0274,38910.5510944471,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 3 Days Canada',143.379,40003.8239810228,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 5 Days Canada',191.172,38952.1410394223,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Week Canada',238.965,39732.0257603557,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Weeks Canada',430.137,37568.7828882842,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Day Scandinavia',109.382,39863.5332310877,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Days Scandinavia',196.8876,37924.307520065,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 3 Days Scandinavia',328.146,38864.1960656966,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 5 Days Scandinavia',437.528,39710.4716969311,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 1 Week Scandinavia',546.91,39289.5037618314,0)
INSERT INTO dbo.CurrentProducts VALUES ('Fruit Tasting Tour 2 Weeks Scandinavia',984.438,39122.6254457712,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Day West Coast',89.501,37744.1486228508,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Days West Coast',161.1018,37135.6300594289,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 3 Days West Coast',268.503,37376.1867728991,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 5 Days West Coast',358.004,38281.7243853953,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Week West Coast',447.505,39752.3688003156,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Weeks West Coast',805.509,39554.6088926774,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Day East Coast',52.681,39671.4784243299,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Days East Coast',94.8258,38961.6241522531,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 3 Days East Coast',158.043,39215.8383591909,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 5 Days East Coast',210.724,39428.2711428262,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Week East Coast',263.405,38000.7189785108,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Weeks East Coast',474.129,38707.4772789601,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Day Mexico',87.436,39966.5531140111,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Days Mexico',157.3848,39186.9379515532,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 3 Days Mexico',262.308,39776.9529120641,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 5 Days Mexico',349.744,37827.5704072264,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Week Mexico',437.18,37864.6186420288,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Weeks Mexico',786.924,38292.8687348044,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Day Canada',73.698,38302.2206435708,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Days Canada',132.6564,39547.6785464789,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 3 Days Canada',221.094,39940.8213650633,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 5 Days Canada',294.792,39640.8763172209,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Week Canada',368.49,39416.2398842794,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Weeks Canada',663.282,37764.5773057776,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Day Scandinavia',32.574,39910.2470534372,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Days Scandinavia',58.6332,37631.9260935416,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 3 Days Scandinavia',97.722,38953.7376064852,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 5 Days Scandinavia',130.296,37970.5814023271,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 1 Week Scandinavia',162.87,39241.1417814266,0)
INSERT INTO dbo.CurrentProducts VALUES ('Mountain Lodge 2 Weeks Scandinavia',293.166,37277.1534790265,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Day West Coast',80.311,39539.6445896785,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Days West Coast',144.5598,38230.5301288512,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 3 Days West Coast',240.933,40053.5975167824,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 5 Days West Coast',321.244,39625.3575887326,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Week West Coast',401.555,37867.6491966216,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Weeks West Coast',722.799,39467.9977682216,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Day East Coast',86.484,38110.5438675191,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Days East Coast',155.6712,37542.3132047829,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 3 Days East Coast',259.452,37705.0039098792,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 5 Days East Coast',345.936,38423.3904094082,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Week East Coast',432.42,39208.9394759492,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Weeks East Coast',778.356,39152.702090343,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Day Mexico',98.592,39784.7390401797,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Days Mexico',177.4656,39548.0496229064,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 3 Days Mexico',295.776,39057.1151337681,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 5 Days Mexico',394.368,37957.4266295324,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Week Mexico',492.96,38383.9513193707,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Weeks Mexico',887.328,37732.5499649975,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Day Canada',93.377,40028.0150331161,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Days Canada',168.0786,39018.4491735898,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 3 Days Canada',280.131,39590.5634195641,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 5 Days Canada',373.508,40038.471194825,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Week Canada',466.885,38805.3137987867,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Weeks Canada',840.393,37670.1412211842,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Day Scandinavia',97.766,39100.016257,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Days Scandinavia',175.9788,40038.1644300365,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 3 Days Scandinavia',293.298,40015.7566315276,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 5 Days Scandinavia',391.064,38961.3211196043,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 1 Week Scandinavia',488.83,39134.3702543418,0)
INSERT INTO dbo.CurrentProducts VALUES ('Spa & Pleasure Getaway 2 Weeks Scandinavia',879.894,39078.6532827256,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Day West Coast',74.451,38556.0511002497,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Days West Coast',134.0118,38532.136960191,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 3 Days West Coast',223.353,39845.9396591064,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 5 Days West Coast',297.804,39083.546326845,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Week West Coast',372.255,37740.9762031719,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Weeks West Coast',670.059,37603.9645562123,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Day East Coast',41.979,38774.155977381,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Days East Coast',75.5622,37801.4925235734,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 3 Days East Coast',125.937,37154.4757301926,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 5 Days East Coast',167.916,39997.0822181988,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Week East Coast',209.895,37280.6776105354,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Weeks East Coast',377.811,39635.8307957767,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Day Mexico',98.331,37485.8588675928,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Days Mexico',176.9958,37828.8038725909,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 3 Days Mexico',294.993,39250.2941996541,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 5 Days Mexico',393.324,37126.7014153854,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Week Mexico',491.655,39963.6662095651,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Weeks Mexico',884.979,39420.8373384674,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Day Canada',45.795,39133.7271776902,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Days Canada',82.431,37832.8028451852,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 3 Days Canada',137.385,38932.4623176296,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 5 Days Canada',183.18,39656.6936201949,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Week Canada',228.975,38525.3127781851,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Weeks Canada',412.155,39977.8503750038,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Day Scandinavia',113.714,39994.2353211326,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Days Scandinavia',204.6852,39106.7984060653,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 3 Days Scandinavia',341.142,37409.4715274264,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 5 Days Scandinavia',454.856,37397.5483929613,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 1 Week Scandinavia',568.57,37586.5944969283,0)
INSERT INTO dbo.CurrentProducts VALUES ('Horseback Tour 2 Weeks Scandinavia',1023.426,38171.3562460292,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Day West Coast',50.041,38665.7944095907,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Days West Coast',90.0738,37630.662588767,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 3 Days West Coast',150.123,38743.8561054508,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 5 Days West Coast',200.164,38569.9944311471,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Week West Coast',250.205,39919.6465494652,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Weeks West Coast',450.369,39306.5902617159,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Day East Coast',86.747,38764.0322420001,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Days East Coast',156.1446,39185.7390501223,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 3 Days East Coast',260.241,38641.7488825278,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 5 Days East Coast',346.988,38772.6047127871,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Week East Coast',433.735,37718.3544552153,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Weeks East Coast',780.723,37474.4597581584,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Day Mexico',105.121,38434.7719406379,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Days Mexico',189.2178,38948.7313595436,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 3 Days Mexico',315.363,37859.6220581876,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 5 Days Mexico',420.484,38936.8130722673,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Week Mexico',525.605,38531.1485848024,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Weeks Mexico',946.089,37582.0832330975,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Day Canada',77.542,39040.1486145081,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Days Canada',139.5756,38158.0764677055,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 3 Days Canada',232.626,37396.8052611365,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 5 Days Canada',310.168,39743.3569105114,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Week Canada',387.71,39292.8441571621,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Weeks Canada',697.878,38489.8715875445,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Day Scandinavia',68.267,38885.1428910932,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Days Scandinavia',122.8806,37830.9486719757,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 3 Days Scandinavia',204.801,37557.1990569005,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 5 Days Scandinavia',273.068,38228.3819797289,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 1 Week Scandinavia',341.335,37360.1145008556,0)
INSERT INTO dbo.CurrentProducts VALUES ('Tiger Watching Tour 2 Weeks Scandinavia',614.403,38531.4466703237,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Day West Coast',45.342,39656.6474332081,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Days West Coast',81.6156,38895.1962985817,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 3 Days West Coast',136.026,39435.6771891336,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 5 Days West Coast',181.368,37280.1957909715,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Week West Coast',226.71,38468.9078442224,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Weeks West Coast',408.078,39224.3525227126,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Day East Coast',78.948,39786.882000643,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Days East Coast',142.1064,39909.0573895541,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 3 Days East Coast',236.844,38229.9911029681,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 5 Days East Coast',315.792,39209.7658292767,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Week East Coast',394.74,38013.1974484003,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Weeks East Coast',710.532,38700.2735869192,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Day Mexico',86.593,40072.1039751201,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Days Mexico',155.8674,39691.8589936503,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 3 Days Mexico',259.779,39889.4253551568,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 5 Days Mexico',346.372,39951.3102128472,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Week Mexico',432.965,38741.569244788,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Weeks Mexico',779.337,38167.235827615,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Day Canada',90.695,38157.9014558443,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Days Canada',163.251,39786.3292250139,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 3 Days Canada',272.085,37538.8818307287,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 5 Days Canada',362.78,37203.043147374,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Week Canada',453.475,38221.310285883,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Weeks Canada',816.255,37554.1441495897,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Day Scandinavia',34.506,39606.6721303414,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Days Scandinavia',62.1108,39547.838924132,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 3 Days Scandinavia',103.518,39847.4869823663,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 5 Days Scandinavia',138.024,37460.0237166914,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 1 Week Scandinavia',172.53,37802.9368717074,0)
INSERT INTO dbo.CurrentProducts VALUES ('Winter Tour 2 Weeks Scandinavia',310.554,37522.7986461728,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Day West Coast',111.366,37583.9712802758,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Days West Coast',200.4588,37137.8244145207,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 3 Days West Coast',334.098,37989.6671438015,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 5 Days West Coast',445.464,37650.8483501377,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Week West Coast',556.83,39781.2664787429,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Weeks West Coast',1002.294,38718.4080674201,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Day East Coast',52.67,39647.8721868812,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Days East Coast',94.806,39860.2779618258,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 3 Days East Coast',158.01,39793.899889636,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 5 Days East Coast',210.68,39695.8506850488,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Week East Coast',263.35,39085.1263368186,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Weeks East Coast',474.03,39228.4792363168,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Day Mexico',101.068,37690.2251970164,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Days Mexico',181.9224,39768.7440648667,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 3 Days Mexico',303.204,40005.2189959714,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 5 Days Mexico',404.272,38477.1381711309,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Week Mexico',505.34,39913.6302696751,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Weeks Mexico',909.612,38197.7632755546,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Day Canada',78.95,40052.0732592917,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Days Canada',142.11,37250.8931081998,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 3 Days Canada',236.85,39479.8542715733,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 5 Days Canada',315.8,37076.5009983985,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Week Canada',394.75,39357.4571477092,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Weeks Canada',710.55,39443.7406462206,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Day Scandinavia',66.897,38626.0192799691,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Days Scandinavia',120.4146,39142.2472994262,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 3 Days Scandinavia',200.691,38025.2371501039,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 5 Days Scandinavia',267.588,38908.1796946685,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 1 Week Scandinavia',334.485,37469.2847738863,0)
INSERT INTO dbo.CurrentProducts VALUES ('Acting Lessons Tour 2 Weeks Scandinavia',602.073,39978.1605817813,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Day West Coast',68.552,39951.665760659,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Days West Coast',123.3936,38955.081275012,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 3 Days West Coast',205.656,37196.4194858087,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 5 Days West Coast',274.208,37944.6635849826,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Week West Coast',342.76,38927.7614483123,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Weeks West Coast',616.968,37356.2213882187,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Day East Coast',108.552,40042.3966459903,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Days East Coast',195.3936,39310.4831025214,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 3 Days East Coast',325.656,38611.5898819862,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 5 Days East Coast',434.208,39121.3354216831,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Week East Coast',542.76,39670.5490313236,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Weeks East Coast',976.968,38789.9067306531,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Day Mexico',31.909,38181.3226233095,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Days Mexico',57.4362,38545.1558051282,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 3 Days Mexico',95.727,37459.1026057267,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 5 Days Mexico',127.636,39444.1110086949,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Week Mexico',159.545,38077.6028896905,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Weeks Mexico',287.181,38558.1510300578,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Day Canada',34.944,38994.1860862793,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Days Canada',62.8992,39306.6894817408,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 3 Days Canada',104.832,37100.7528648246,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 5 Days Canada',139.776,37964.1540797924,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Week Canada',174.72,39164.9770711097,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Weeks Canada',314.496,39193.5740822919,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Day Scandinavia',80.648,38594.2137419175,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Days Scandinavia',145.1664,37451.5886940492,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 3 Days Scandinavia',241.944,37423.163598442,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 5 Days Scandinavia',322.592,38238.6649483707,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 1 Week Scandinavia',403.24,39537.7393903769,0)
INSERT INTO dbo.CurrentProducts VALUES ('Cherry Festival Tour 2 Weeks Scandinavia',725.832,40062.5201378689,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Day West Coast',129.011,37935.2451138552,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Days West Coast',232.2198,37941.1088585795,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 3 Days West Coast',387.033,40024.4968381058,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 5 Days West Coast',516.044,39815.6641091276,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Week West Coast',645.055,39572.4699514138,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Weeks West Coast',1161.099,39813.761017456,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Day East Coast',127.554,39107.6427558377,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Days East Coast',229.5972,39678.5276303785,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 3 Days East Coast',382.662,38018.9422528185,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 5 Days East Coast',510.216,38524.220641511,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Week East Coast',637.77,39956.6611837714,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Weeks East Coast',1147.986,38689.5562833884,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Day Mexico',67.391,37682.2739666782,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Days Mexico',121.3038,37457.3622647415,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 3 Days Mexico',202.173,37110.4713419162,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 5 Days Mexico',269.564,37793.9079811227,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Week Mexico',336.955,37688.2227916864,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Weeks Mexico',606.519,39855.4758975481,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Day Canada',77.909,39431.0891118735,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Days Canada',140.2362,38761.5476662674,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 3 Days Canada',233.727,39545.3753814707,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 5 Days Canada',311.636,37107.4780802896,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Week Canada',389.545,38645.0253195637,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Weeks Canada',701.181,38370.5160960145,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Day Scandinavia',113.354,39465.960948266,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Days Scandinavia',204.0372,38663.6936297148,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 3 Days Scandinavia',340.062,39244.9900189166,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 5 Days Scandinavia',453.416,38890.1553691139,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 1 Week Scandinavia',566.77,37546.7123270793,0)
INSERT INTO dbo.CurrentProducts VALUES ('Lakes Tour 2 Weeks Scandinavia',1020.186,37294.0559140129,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Day West Coast',46.728,37780.0309118199,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Days West Coast',84.1104,37599.2747534866,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 3 Days West Coast',140.184,39708.1457957801,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 5 Days West Coast',186.912,38561.3750274918,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Week West Coast',233.64,39313.5880191351,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Weeks West Coast',420.552,37505.1467849873,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Day East Coast',127.197,38140.0876282796,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Days East Coast',228.9546,38527.0671212311,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 3 Days East Coast',381.591,39983.707613704,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 5 Days East Coast',508.788,37393.106808344,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Week East Coast',635.985,38482.1817491695,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Weeks East Coast',1144.773,38191.7026783081,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Day Mexico',51.058,37762.7538485892,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Days Mexico',91.9044,38312.3091055567,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 3 Days Mexico',153.174,38567.2302594105,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 5 Days Mexico',204.232,38404.2289388254,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Week Mexico',255.29,38956.8368020235,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Weeks Mexico',459.522,37138.2599417381,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Day Canada',92.982,40000.1924316229,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Days Canada',167.3676,39499.8597885427,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 3 Days Canada',278.946,38201.3155227173,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 5 Days Canada',371.928,39615.9858746373,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Week Canada',464.91,37342.9843066688,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Weeks Canada',836.838,38652.9563435308,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Day Scandinavia',93.812,39503.4061507898,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Days Scandinavia',168.8616,38117.229939474,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 3 Days Scandinavia',281.436,39594.7925821028,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 5 Days Scandinavia',375.248,39647.9035247136,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 1 Week Scandinavia',469.06,38719.6919930719,0)
INSERT INTO dbo.CurrentProducts VALUES ('Rain Forest Tour 2 Weeks Scandinavia',844.308,37204.5981655394,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Day West Coast',75.387,39828.1905132623,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Days West Coast',135.6966,39146.8212782558,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 3 Days West Coast',226.161,39712.4844002102,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 5 Days West Coast',301.548,37903.7961234193,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Week West Coast',376.935,38472.0289232607,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Weeks West Coast',678.483,39915.2684756034,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Day East Coast',124.012,39978.5042708372,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Days East Coast',223.2216,38289.5636554002,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 3 Days East Coast',372.036,37563.2447341988,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 5 Days East Coast',496.048,39801.2763501134,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Week East Coast',620.06,39825.4926689736,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Weeks East Coast',1116.108,39107.3948514973,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Day Mexico',41.837,37652.6319534484,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Days Mexico',75.3066,37969.6766439463,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 3 Days Mexico',125.511,39327.7894916309,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 5 Days Mexico',167.348,38579.0016039004,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Week Mexico',209.185,39822.2153620053,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Weeks Mexico',376.533,38048.4189377813,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Day Canada',108.762,39701.7310116844,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Days Canada',195.7716,37868.5410789019,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 3 Days Canada',326.286,39789.7049093695,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 5 Days Canada',435.048,39180.6451698346,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Week Canada',543.81,39057.5320774288,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Weeks Canada',978.858,37203.7650785947,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Day Scandinavia',36.042,37243.8547300148,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Days Scandinavia',64.8756,37563.9051251149,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 3 Days Scandinavia',108.126,39176.3721276658,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 5 Days Scandinavia',144.168,39974.809854147,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 1 Week Scandinavia',180.21,38099.0643392389,0)
INSERT INTO dbo.CurrentProducts VALUES ('River Rapids Tour 2 Weeks Scandinavia',324.378,38750.2426391363,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Day West Coast',35.308,38768.6720670346,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Days West Coast',63.5544,39565.0193832539,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 3 Days West Coast',105.924,37903.0886526045,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 5 Days West Coast',141.232,38487.5286816379,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Week West Coast',176.54,38060.0757217404,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Weeks West Coast',317.772,38551.3313263994,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Day East Coast',85.551,39224.8936928778,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Days East Coast',153.9918,39187.0051265412,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 3 Days East Coast',256.653,40039.8853346666,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 5 Days East Coast',342.204,38159.3929622938,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Week East Coast',427.755,37828.7077123686,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Weeks East Coast',769.959,37120.6707352996,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Day Mexico',72.792,37762.5073278733,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Days Mexico',131.0256,39179.7619718188,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 3 Days Mexico',218.376,39341.4269639062,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 5 Days Mexico',291.168,38435.4403025849,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Week Mexico',363.96,38048.0496204576,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Weeks Mexico',655.128,37465.9460871125,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Day Canada',48.351,39731.8099294616,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Days Canada',87.0318,38487.7284865386,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 3 Days Canada',145.053,37196.0266056157,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 5 Days Canada',193.404,37671.7498961104,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Week Canada',241.755,38725.0022961075,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Weeks Canada',435.159,37250.0007437607,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Day Scandinavia',42.001,38663.6779050741,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Days Scandinavia',75.6018,38164.3175356193,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 3 Days Scandinavia',126.003,38333.5712492646,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 5 Days Scandinavia',168.004,37693.2247157841,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 1 Week Scandinavia',210.005,39207.1447779282,0)
INSERT INTO dbo.CurrentProducts VALUES ('Snow Ski Tour 2 Weeks Scandinavia',378.009,37114.2735210806,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Day West Coast',120.198,37075.0609196017,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Days West Coast',216.3564,39404.0065275085,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 3 Days West Coast',360.594,38963.1270731733,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 5 Days West Coast',480.792,39030.6848344847,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Week West Coast',600.99,37737.6471577446,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Weeks West Coast',1101.969,39793.4792398887,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Day East Coast',64.133,39238.4682552525,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Days East Coast',115.4394,37682.1987089733,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 3 Days East Coast',192.399,39441.8045383956,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 5 Days East Coast',256.532,39283.4777025131,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Week East Coast',320.665,37386.9569586964,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Weeks East Coast',577.197,39567.1485568427,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Day Mexico',77.308,37610.568919616,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Days Mexico',139.1544,39459.4126750044,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 3 Days Mexico',231.924,38164.6927467932,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 5 Days Mexico',309.232,38820.3214944845,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Week Mexico',386.54,38633.2902654754,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Weeks Mexico',695.772,37317.5065290309,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Day Canada',44.265,39554.4611166264,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Days Canada',79.677,37464.2863800955,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 3 Days Canada',132.795,39789.3890414472,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 5 Days Canada',177.06,38687.6722511034,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Week Canada',221.325,38259.2236279945,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Weeks Canada',398.385,37093.2726849676,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Day Scandinavia',40.564,38331.2919847311,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Days Scandinavia',73.0152,39389.4766400892,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 3 Days Scandinavia',121.692,38116.1062198842,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 5 Days Scandinavia',162.256,38644.2753609275,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 1 Week Scandinavia',202.82,38322.894033825,0)
INSERT INTO dbo.CurrentProducts VALUES ('Wine Tasting Tour 2 Weeks Scandinavia',365.076,37404.8146269419,0)

UPDATE CurrentProducts SET OriginationDate = OriginationDate + 1000
GO

ALTER TABLE dbo.CurrentProducts ADD Category varchar(20) NULL
GO

UPDATE dbo.CurrentProducts SET Category = 'Medium-Stay'
UPDATE dbo.CurrentProducts SET Category = 'No-Stay' WHERE ProductName like '%1 day%'
UPDATE dbo.CurrentProducts SET Category = 'Overnight-Stay' WHERE ProductName like '%2 day%'
UPDATE dbo.CurrentProducts SET Category = 'LongTerm-Stay' WHERE ProductName like '%week%'



create table Employee
(EmpID int primary key not null,
LastName varchar(30) null,
FirstName varchar(20) null,
HireDate datetime null,
LocationID int null)
go


create table Location
(LocationID char(3) not null unique,
Street varchar(30) null,
City varchar(20) null,
[State] char(2) null)
go



insert into Employee values(1,'Adams','Alex','1/1/01','001')
insert into Employee values(2,'Brown','Barry','8/12/02','001')
insert into Employee values(3,'Osako','Lee','9/1/99','002')
insert into Employee values(4,'Kennson','David','3/16/96','001')
insert into Employee values(5,'Bender','Eric','5/17/07','001')
insert into Employee values(6,'Kendall','Lisa','11/15/01','004')
insert into Employee values(7,'Lonning','David','1/1/00','001')
insert into Employee values(8,'Marshbank','John','11/15/01',null)
insert into Employee values(9,'Newton','James','9/30/03','002')
insert into Employee values(10,'O''Haire','Terry','10/04/04','002')
insert into Employee values(11,'Smith','Sally','4/1/89','001')
insert into Employee values(12,'O''Neil','Barbara','5/26/95','004')

insert into Location values(1,'111 First ST','Seattle', 'WA')
insert into Location values(2,'222 Second AVE', 'Boston','MA')
insert into Location values(3,'333 Third PL','Chicago','IL')
insert into Location values(4,'444 Ruby ST','Spokane', 'WA')
go

--Add a new ManagerID field to the Employee table of JProCo
ALTER TABLE Employee
ADD ManagerID int NULL
GO

--Update all Seattle Employees to Report to Sally Smith (Expect herself)
UPDATE Employee SET ManagerID = 11
WHERE LocationID =  1 AND EmpID != 11

--Update all Boston Employee to report to Lee Osako (except for himself)
UPDATE Employee SET ManagerID = 3
WHERE LocationID = 2 AND EmpID != 3

--Update all Spokane Employees to report directly to David Kennson
UPDATE Employee SET ManagerID = 4
WHERE locationID = 4

--Set all sales people with no office location to work for David Kennson
UPDATE Employee SET ManagerID = 4
WHERE LocationID IS NULL

--Set Lee Osako to work for Sally Smith
UPDATE Employee SET ManagerID = 11
WHERE EmpID = 3

--Add a new ManagerID field to the Employee table of JProCo
ALTER TABLE Employee
ADD Status CHAR(12) NULL
GO

UPDATE Employee SET Status = 'On Leave' WHERE EmpID = 7
UPDATE Employee SET Status = 'Has Tenure' WHERE EmpID in (12,4)

CREATE TABLE [Grant]
(
GrantID char(3) NOT NULL UNIQUE,
GrantName Nvarchar(50) NOT NULL,
EmpID int,
Amount smallmoney
)

INSERT INTO [Grant] VALUES ('001','92 Purr_Scents %% team',7,4750)
INSERT INTO [Grant] VALUES ('002','K_Land fund trust',2,15750)
INSERT INTO [Grant] VALUES ('003','Robert@BigStarBank.com',7,18100)
INSERT INTO [Grant] VALUES ('004','Norman''s Outreach',null,21000)
INSERT INTO [Grant] VALUES ('005','BIG 6''s Foundation%',4,21000)
INSERT INTO [Grant] VALUES ('006','TALTA_Kishan International',3,18100)
INSERT INTO [Grant] VALUES ('007','Ben@MoreTechnology.com',010,41000)
INSERT INTO [Grant] VALUES ('008','www.@-Last-U-Can-Help.com',7,25000)
INSERT INTO [Grant] VALUES ('009','Thank you @.com',11,21500)
INSERT INTO [Grant] VALUES ('010','Call Mom @Com',5,7500)
GO

create procedure spGetEmployeeLastAndState
@eid char(3)
as
select e.LastName, a.state
from Employee as e inner join Location as a
on e.LocationID = a.LocationID
where e.LocationID = @eid
go

--exec spGetEmployeeLastAndState '002'
-- go








USE Master
GO

IF EXISTS(SELECT * FROM sys.databases where [name] = 'dbBasics')
DROP DATABASE dbBasics
GO

CREATE DATABASE dbBasics
GO

USE dbBasics
GO

CREATE TABLE dbo.ShoppingList
(
ItemNumber int IDENTITY(1,1) PRIMARY KEY ,
Description varchar(30) NOT NULL,
Price MONEY NULL
)
GO

INSERT INTO dbo.ShoppingList VALUES('Milk',1)
INSERT INTO dbo.ShoppingList VALUES('Eggs',1.5)
INSERT INTO dbo.ShoppingList VALUES('Bread',.99)
INSERT INTO dbo.ShoppingList VALUES('Soda',1.25)
INSERT INTO dbo.ShoppingList VALUES('Chips',.75)
INSERT INTO dbo.ShoppingList VALUES('PaperTowels',.99)
INSERT INTO dbo.ShoppingList VALUES('Napkins',1.25)
GO

SELECT * INTO [Shopping List] FROM ShoppingList
GO

CREATE TABLE dbo.Members
(
LibraryCardNo int IDENTITY(1001,1) PRIMARY KEY,
fName varchar(25) NOT NULL,
lName varchar(30) NOT NULL,
Address varchar(40) NOT NULL,
Gender char(1) NULL,
DOB Datetime NULL
)
GO

INSERT INTO dbo.Members VALUES ('Tom','Larson','312 Costa Ave','M','8/16/71')
INSERT INTO dbo.Members VALUES ('Gary','Randall','85 Main','M','7/7/1967')
INSERT INTO dbo.Members VALUES ('Susan','Pederson','4515 Tolo Rd','F','4/4/1942')
INSERT INTO dbo.Members VALUES ('Kelly','Keren','595 Orchard st','F','9/6/1980')
INSERT INTO dbo.Members VALUES ('Larry','Kimball','1908 S Huson','M','3/5/1966')
INSERT INTO dbo.Members VALUES ('Phil','Coleman','655 Rubber Rd','M','7/9/1940')
GO

CREATE TABLE dbo.Activity
(
LibraryCardNo int NOT NULL,
Book varchar(40) NOT NULL
)
GO

INSERT INTO dbo.Activity VALUES (1001,'Dust Bowl')
INSERT INTO dbo.Activity VALUES (1001,'How to Fix Things')
INSERT INTO dbo.Activity VALUES (1003,'Yachting for dummies')
INSERT INTO dbo.Activity VALUES (1005,'How to marry a millionaire')
INSERT INTO dbo.Activity VALUES (1005,'Spice world')
INSERT INTO dbo.Activity VALUES (1005,'Juice Master tells all')
INSERT INTO dbo.Activity VALUES (1006,'Doctor Doctor')
INSERT INTO dbo.Activity VALUES (1007,'North of 60''')

CREATE TABLE dbo.FlatFileActivity
(
LibraryCardNo int,
fName varchar(25) NOT NULL,
lName varchar(30) NOT NULL,
Address varchar(40) NOT NULL,
Gender char(1) NOT NULL,
DOB datetime NOT NULL,
Book1 varchar(40) NULL,
Book2 varchar(40) NULL,
Book3 varchar(40) NULL
)
GO

INSERT INTO dbo.FlatFileActivity VALUES(1001,	'Tom','Larson','312 costa Ave','M','08/16/71','Dust Bowl','How to Fix things',null)
INSERT INTO dbo.FlatFileActivity VALUES(1002,'Gary','Randall','85 Main','M','7/7/1967',null,null,null		)
INSERT INTO dbo.FlatFileActivity VALUES(1003,'Susan','Pederson','4515 Tolo Rd','F','4/4/1942','Yachting for dummies',null,null)
INSERT INTO dbo.FlatFileActivity VALUES(1005,'Kelly','Keren','595 Orchard','F','9/6/1980','How to marry a millionaire','Spice world','Juice master tells all')
INSERT INTO dbo.FlatFileActivity VALUES(1006,'Larry','Kimball','1908 S Huson','M','3/5/1966','Doctor Doctor',null,null)
INSERT INTO dbo.FlatFileActivity VALUES(1007,'Phil','Coleman','655 Rupert Rd','M','7/9/1940','North of 60',null,null)

CREATE TABLE dbo.Customer
(
CustomerID int IDENTITY(1001,1) PRIMARY KEY,
CustomerName varchar(50) NOT NULL,
CEO varchar(40) NULL,
Phone varchar(20) NOT NULL
)
GO

INSERT INTO dbo.Customer VALUES('KittyHawk Air Cargo','Brad West','(678) 569-6326')
INSERT INTO dbo.Customer VALUES('Air Canada','Dan Dorn','(604) 565-2398')
INSERT INTO dbo.Customer VALUES('Frontier','Kathy Yates','(818) 692-6531')
INSERT INTO dbo.Customer VALUES('Japan Air Lines JAL','Miguemi Kameda','(206) 695-3694')
INSERT INTO dbo.Customer VALUES('Southwest Airlines','Phile Eyler','(712) 635-9564')
GO

CREATE TABLE dbo.PurchaseActivity
(
TransactionID bigint IDENTITY(17843401,1) PRIMARY KEY,
Date Datetime NOT NULL,
Item varchar(50) NOT NULL,
Price money,
CustomerID int NOT NULL
)
GO

INSERT INTO dbo.PurchaseActivity VALUES('12/8/11','747-400',175000000,1004)
INSERT INTO dbo.PurchaseActivity VALUES('1/16/12','777',120000000,1001)
INSERT INTO dbo.PurchaseActivity VALUES('2/24/12','777',120000000,1002)
INSERT INTO dbo.PurchaseActivity VALUES('4/4/12','747-400',175000000,1004)
INSERT INTO dbo.PurchaseActivity VALUES('5/13/12','767',105000000,1004)
INSERT INTO dbo.PurchaseActivity VALUES('6/21/12','727-200',90000000,1003)
INSERT INTO dbo.PurchaseActivity VALUES('7/30/12','747-400',175000000,1005)
INSERT INTO dbo.PurchaseActivity VALUES('9/7/12','747-400',175000000,1001)
INSERT INTO dbo.PurchaseActivity VALUES('10/16/12','767',105000000,1005)
INSERT INTO dbo.PurchaseActivity VALUES('11/24/12','727-200',90000000,1002)
INSERT INTO dbo.PurchaseActivity VALUES('12/8/12','747-400',175000000,1004)
GO



CREATE TABLE dbo.Employee
(
EmpNo int PRIMARY KEY,
LastName varchar(25) NOT NULL,
FirstName varchar(35) NOT NULL,
Dept varchar(25) NULL,
Position varchar(40) NULL,
Salary MONEY NULL,
LocatioinID int NULL
)
GO

INSERT INTO dbo.Employee VALUES(101,'Smith','Sarah','Admin','Manager',54000.00,2)
INSERT INTO dbo.Employee VALUES(102,'Brown','Bill','Sales','Clerk',25200.00,2)
INSERT INTO dbo.Employee VALUES(103,'Fry','Fred','Admin','Clerk',21900.00,1)
INSERT INTO dbo.Employee VALUES(104,'Thomas','Tina','Admin','Secretary',26700.00,1)
INSERT INTO dbo.Employee VALUES(105,'Gregg','Gary','Sales','Manager',48000.00,2)
INSERT INTO dbo.Employee VALUES(106,'Davies','Diana','Admin','Clerk',23400.00,1)
INSERT INTO dbo.Employee VALUES(107,'Potter','Peter','Sales','Secretary',27300.00,1)
INSERT INTO dbo.Employee VALUES(108, 'Lewis','Len','Sales','Secretary',25900.00,2)
INSERT INTO dbo.Employee VALUES(109,'Jones','Julie','Admin','Clerk',22600.00,2)
INSERT INTO dbo.Employee VALUES(110,'Hamlin','Harriet','Sales','Clerk',23000.00,1)
INSERT INTO dbo.Employee VALUES(111,'Mark','Lamme','RND','Lead',9900000,1)
INSERT INTO dbo.Employee VALUES(112,'Charley','Jones','Education','Faculty',65000.00,Null)
INSERT INTO dbo.Employee VALUES(113,'Adam','Moore','Education','Faculty',55000.00,1)
INSERT INTO dbo.Employee VALUES(114,'Jonathan','Muro','Education','Faculty',47500.00,1)
INSERT INTO dbo.Employee VALUES(115,'Gladys','Norldland','Education','Faculty',77500.00,1)
INSERT INTO dbo.Employee VALUES(116,'Rick','Morelan','Education','Faculty',150000.00,NULL)	
GO

CREATE TABLE Location
(
LocationID int IDENTITY(1,1) PRIMARY KEY,
LocationName varchar(40),
Address varchar(60),
City Varchar(40),
State char(2),
ZIP char(10)
)
GO



INSERT INTO Location VALUES('Main Office','1565 E Desert Sand Rd Suite A-4','Henderson','NV',89014)
INSERT INTO Location VALUES('Sum-Branch','9920 Trailwood','Las Vegas','NV',	89134)
INSERT INTO Location VALUES('Bo-Branch','318 Main','BoulderCity','NV',	89101)








USE Master
GO

IF EXISTS(SELECT * FROM sys.sysdatabases WHERE [name] = 'dbTester')
DROP DATABASE dbTester
GO

CREATE DATABASE dbTester
GO

USE dbTester
GO

IF NOT EXISTS (SELECT * FROM dbTester.sys.tables WHERE [name] = 'TestScore')
CREATE TABLE dbtester.dbo.TestScore
(
Item Nvarchar(200) null,
Pts smallint null
)
GO



-------------------------------------END Lab6.1 Tester


---Code for Lab 5.1 Creating Databases

--Challenge 1
USE master
GO

if exists(SELECT * from sysdatabases 
		WHERE name = 'dbSkillCheck' )
DROP database dbSkillCheck
go

CREATE database dbSkillCheck
go



---Code for Lab 5.2 Creating Tables

--Challenge 1
USE master
GO

if exists(SELECT * from sysdatabases WHERE name = 'DBMovie' )
DROP database dbMovie
go

CREATE database dbMovie
go

USE dbMovie
GO

create table tblMovie
(
m_ID int primary key,
m_Title varchar(30) not null,
m_Runtime int,
m_Rating varchar(10)
)

-----------------------

USE master
GO

IF EXISTS(SELECT * FROM sys.sysdatabases 
		WHERE [name] = 'dbMovie')
DROP DATABASE dbMovie
GO

CREATE DATABASE dbMovie
GO

USE dbMovie
GO

create table tblMovie
(m_ID int primary key,
m_Title varchar(30) not null,
m_Runtime int,
m_Rating varchar(10)
)


INSERT INTO tblMovie
VALUES (1,'A-List Explorers',96,'PG-13')

INSERT INTO tblMovie
VALUES (2,'Bonker Bonzo',75,'G')

INSERT INTO tblMovie
VALUES (3,'Chumps to Champs',75,'PG-13')

INSERT INTO tblMovie
VALUES (4,'Dare or Die',110,'R')

INSERT INTO tblMovie
VALUES (5,'EeeeGhads',88,'G')

------------

USE JProCo
GO

CREATE TABLE Customer
(CustomerID INT PRIMARY  KEY,
CustomerType NVARCHAR(25),
FirstName NVArCHAR(30),
LastName NVARCHAR(40),
CompanyName NVARCHAR(100)
)
GO

INSERT INTO Customer VALUES (1,'Consumer','Mark','Williams',NULL)
INSERT INTO Customer VALUES (2,'Consumer','Lee','Young',NULL)
INSERT INTO Customer VALUES (3,'Consumer','Patricia','Martin',NULL)
INSERT INTO Customer VALUES (4,'Consumer','Mary','Lopez',NULL)
INSERT INTO Customer VALUES (5,'Business',NULL,NULL,'MoreTechnology.com')

------

UPDATE PR SET YearlySalary = YearlySalary + 1000
FROM Employee as E INNER JOIN PayRates AS PR
ON E.EmpID = PR.EmpID
WHERE ManagerID = 11
AND YearlySalary IS NOT NULL 

IF EXISTS(SELECT * FROM sys.tables WHERE [name] = 'SalesInvoice')
DROP TABLE SalesInvoice
GO

CREATE TABLE SalesInvoice
(InvoiceID int PRIMARY KEY,OrderDate datetime NOT NULL,PaidDate datetime NOT NULL,CustomerID int NOT NULL,Comment NTEXT)
GO

ALTER TABLE mgmtTraining
ADD ApprovedDate datetime
GO

UPDATE MgmtTraining 
SET ApprovedDate = '1/1/2007' WHERE ClassID = 1

UPDATE MgmtTraining 
SET ApprovedDate = '1/15/2007' WHERE ClassID = 2

UPDATE MgmtTraining 
SET ApprovedDate = '2/12/2008' WHERE ClassID = 3

INSERT INTO MgmtTraining
VALUES ('Dummy1',1,CURRENT_TIMESTAMP)


INSERT INTO MgmtTraining
VALUES ('Dummy2',1,CURRENT_TIMESTAMP)

DELETE MgmtTraining WHERE ClassName like '%Dummy%'


USE dbMovie
GO

ALTER TABLE tblMovie 
ADD m_Description Varchar(100) NOT NULL
DEFAULT 'Description Coming Soon'
GO


sp_rename 'tblMovie.m_Description', 'm_Teaser'
GO

sp_rename 'tblMovie','Movie'
GO


ALTER TABLE Movie 
ADD m_Release Varchar(100) NOT NULL
DEFAULT '2000'
GO
USE JProCo
GO

CREATE TABLE SalesInvoiceDetail
(InvoiceDetailID INT PRIMARY KEY,
InvoiceID INT NOT NULL,
ProductID INT NOT NULL, Quantity INT NOT NULL,
UnitDiscount smallmoney)
GO

CREATE VIEW vSales
AS
SELECT CustomerID,OrderDate,RetailPrice, Quantity, CP.ProductID,CP.ProductName, YEAR(OrderDate) as OrderYear
FROM CurrentProducts CP
INNER JOIN dbo.SalesInvoiceDetail SVD
ON CP.ProductID = SVD.ProductID
INNER JOIN dbo.SalesInvoice SD
ON SVD.InvoiceID = SD.InvoiceID
GO

--Lab 1.3 Starts Here
USE dbMovie
GO

INSERT INTO Movie 
VALUES (6,'Farewell Yeti',92,'R','Ice and Terror find common ground',2009)
INSERT INTO Movie
VALUES (7,'Gone and Back',78,'PG-13','Sometime death gives you a second chance',2010)

IF EXISTS(SELECT * FROM sys.tables WHERE [name] = 'SalesInvoiceDetail')
DROP TABLE SalesInvoiceDetail
GO

