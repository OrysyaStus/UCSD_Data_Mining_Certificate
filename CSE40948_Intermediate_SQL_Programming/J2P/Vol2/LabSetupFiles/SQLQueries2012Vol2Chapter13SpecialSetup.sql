USE [JProCo]
GO


TRUNCATE TABLE [Grant]
GO

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

IF EXISTS(SELECT * FROM sys.tables WHERE [name] = 'GrantAdder')
DROP TABLE GrantAdder
GO

CREATE TABLE [dbo].[GrantAdder](
	[GrantID] [char](3) NOT NULL,
	[Amount] [smallmoney] NULL)

GO

INSERT INTO [GrantAdder] VALUES ('001',2000)
INSERT INTO [GrantAdder] VALUES ('005',500)
INSERT INTO [GrantAdder] VALUES ('005',1000)

IF EXISTS(SELECT * FROM sys.tables WHERE [name] = 'PriceIncrease')
DROP TABLE PriceIncrease
GO

CREATE TABLE [dbo].[PriceIncrease]
(
	[ProductID] [int]  NOT NULL,
	[Change] [money] NULL
)
GO

INSERT INTO PriceIncrease VALUES (1,5.75)
INSERT INTO PriceIncrease VALUES (1,1.00)
INSERT INTO PriceIncrease VALUES (2,9.50)
INSERT INTO PriceIncrease VALUES (3,1.50)
INSERT INTO PriceIncrease VALUES (3,2.50)



