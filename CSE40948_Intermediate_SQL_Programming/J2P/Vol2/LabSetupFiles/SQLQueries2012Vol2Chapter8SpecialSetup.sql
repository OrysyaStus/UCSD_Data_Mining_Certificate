/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/
USE JProCo
GO

IF EXISTS(SELECT * FROM sys.tables WHERE [name] = 'Buyers')
DROP TABLE Buyers
GO

CREATE TABLE Buyers
(BuyerID INT,
OrderType char(1),
OrderDate datetime)
GO

INSERT INTO Buyers
VALUES (1,'A','5/6/2009'),(1,'B','5/9/2009'),(1,'C','6/6/2009'),
(2,'A','9/6/2009'),(2,'B','8/9/2009'),(2,'C','7/6/2009'),
(3,'A','11/6/2009'),(3,'B','10/9/2009'),(3,'C','12/6/2009'),
(4,'A','3/5/2010'),(4,'B','8/8/2010'),(4,'C','9/9/2010'),
(5,'A','9/5/2010'),(5,'B','8/8/2010'),(5,'C','9/1/2010'),
(6,'A','5/5/2010'),(6,'B','8/8/2010'),(6,'C','11/1/2010')

USE JProCo
GO

IF OBJECT_ID(N'CharitableEvents', N'U') IS NOT NULL 
DROP TABLE CharitableEvents;

CREATE TABLE CharitableEvents (
CharityID INT,
SponsorLevel CHAR(10),
OrderDate DATETIME)
GO

INSERT INTO CharitableEvents VALUES 
(1,'Gold','5/6/2008'),(1,'Silver','5/9/2009'),(1,'Bronze','10/6/2009'),
(2,'Gold','9/6/2009'),(2,'Silver','4/9/2008'),(2,'Bronze','2/6/2010'),
(3,'Gold','11/6/2009'),(3,'Silver','10/9/2009'),(3,'Bronze','12/6/2008'),
(4,'Gold','3/5/2010'),(4,'Silver','8/8/2010'),(4,'Bronze','4/9/2011'),
(5,'Gold','2/5/2011'),(5,'Silver','5/8/2010'),(5,'Bronze','9/1/2010'),
(6,'Gold','5/5/2010'),(6,'Silver','8/8/2011'),(6,'Bronze','11/1/2010')