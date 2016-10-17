/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 3.2 NullData


--Skill Check1:
USE Master 
GO

Row 1 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 84 
TOTAL = 115 Bytes

Row 2 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 48
TOTAL = 79Bytes

Row 3 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 32
TOTAL = 63Bytes

Row 4 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 20
TOTAL = 51Bytes

Row 5 : Header 4 | Fixed Data = 18 | Null Block 3 | Variable Block 6 | Variable Data 0
TOTAL = 31Bytes


--Code used to create the table & data shown in Lab 3.2, Skill Check 1 
USE JProCo
GO

CREATE TABLE [HumanResources].[RoomChart](
	[R_ID] [int] NOT NULL,
	[R_Code] [nchar](3) NULL,
	[R_RoomName] [nvarchar](25) NULL,
	[R_Description] [nvarchar](200) NULL,
	[R_MaxTemp] [int] NULL,
	[R_MinTemp] [int] NULL
) ON [PRIMARY]

GO

INSERT INTO [HumanResources].[RoomChart] VALUES (1,	'RLT',	'Renault-Langsford-Tribute', 'Customer Previews', 79, 66)
INSERT INTO [HumanResources].[RoomChart] VALUES (2,	'QTX',	'Quinault-Experience', 'Party', 85, 50)
INSERT INTO [HumanResources].[RoomChart] VALUES (3,	'TQW',	'TranquilWest', 'Misc', 85, 55)
INSERT INTO [HumanResources].[RoomChart] VALUES (4,	'XW', 	'XavierWest', NULL, NULL, NULL)
INSERT INTO [HumanResources].[RoomChart] VALUES (5,	NULL,	NULL, NULL, NULL, NULL)
GO