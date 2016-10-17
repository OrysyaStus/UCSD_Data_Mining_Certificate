/* Creating Databases and Tables */
--data and log files exist for each of the system databases
/* Execute commands by Sections one at a time */

/* A. */
CREATE DATABASE Chinook_Eric
--can view that a new database was added under "Databases" as well as a new data and log file created

/* B. */
/* Creating Tables */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person
--check to see if the tables exist, if the tables exist drop them

CREATE TABLE Person (
--created a table called Person
	PersonID int 
	, FirstName varchar(50) 
	, LastName varchar(50) 
	, BirthDate date 
	, Gender char(1) 
	, UserID varchar(25) 
	, DataCreated datetime2
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)
--Must assign data type to each column

INSERT INTO Person(PersonID, FirstName, LastName)
VALUES (1, 'John', 'Doe')
, (1, 'Jane', 'Doe')
, (2, 'Harrold', 'Smith')

SELECT *
FROM Person
--Outputted 3 rows, NULL values for the rest of the columns

/* C. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
--created a table called Person
	PersonID int PRIMARY KEY
	, FirstName varchar(50) 
	, LastName varchar(50) 
	, BirthDate date 
	, Gender char(1) 
	, UserID varchar(25) 
	, DataCreated datetime2
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)

INSERT INTO Person(PersonID, FirstName, LastName)
VALUES (1, 'John', 'Doe')
, (3, 'Jane', 'Doe')
, (2, 'Harrold', 'Smith')
--The PersonID needs to be unqiue therefore in order to prevent error make PersonID values all unique

SELECT *
FROM Person

/* D. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
--created a table called Person
	PersonID int IDENTITY(10000,2) PRIMARY KEY
--Creating an identity column which will start with a n1 = 10000 n2 = 10000+2 etc.
	, FirstName varchar(50) 
	, LastName varchar(50) 
	, BirthDate date 
	, Gender char(1) 
	, UserID varchar(25) 
	, DataCreated datetime2
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)
--The Identity column will be automatically incremented

INSERT INTO Person(FirstName, LastName)
VALUES ('John', 'Doe')
, ('Jane', 'Doe')
, ('Harrold', 'Smith')

SELECT *
FROM Person

/* E. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
	PersonID int IDENTITY(10000, 2) Primary Key
	, FirstName varchar(50) NOT NULL
	, LastName varchar(50) NOT NULL
	, BirthDate date NULL
	, Gender char(1) NULL 
	, UserID varchar(25) NOT NULL 
	, DataCreated datetime2 NULL 
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)

INSERT INTO Person(FirstName, LastName, UserID)
VALUES ('John', 'Doe', 'jdoe')
, ('Jane', 'Doe', 'jdoe')
, ('Harrold', 'Smith', 'hsmith')
--Will have an error since UserID is not NULL and needs a value to be inputted, therefore add UserId info. to avoid error

SELECT *
FROM Person
--All columns are correctly populated, no errors occur

/* F. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
	PersonID int IDENTITY(10000, 2) Primary Key
	, FirstName varchar(50) NOT NULL
	, LastName varchar(50) NOT NULL
	, BirthDate date NULL
	, Gender char(1) NULL CHECK(GENDER IN('M', 'F'))
--add CHECK that will allow for only M or F (as well as NULL)as an input, acts like a WHERE clause
	, UserID varchar(25) NOT NULL 
	, DataCreated datetime2 NULL
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)

INSERT INTO Person(FirstName, LastName, UserID, Gender)
VALUES ('John', 'Doe', 'jdoe', 'M')
, ('Jane', 'Doe', 'jdoe', 'F')
, ('Harrold', 'Smith', 'hsmith', NULL)
--Error will occur on the CHECK constraint if incorrect gender is inputted ie. H vs. F

SELECT *
FROM Person

/* G. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
	PersonID int IDENTITY(10000, 2) Primary Key
	, FirstName varchar(50) NOT NULL
	, LastName varchar(50) NOT NULL
	, BirthDate date NULL
	, Gender char(1) NULL CHECK(GENDER IN('M', 'F'))
	, UserID varchar(25) NOT NULL UNIQUE
--prevents duplication of UserID
--Can enter it in multiple times in CREATE TABLE, will allow NULL value (typically, unless otherwise specified) unlike for Primary Key
	, DataCreated datetime2 NULL 
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)

INSERT INTO Person(FirstName, LastName, UserID, Gender)
VALUES ('John', 'Doe', 'jdoe', 'M')
, ('Jane', 'Doe', 'jadoe', 'F')
, ('Harrold', 'Smith', 'hsmith', NULL)
--Error will occur on the CHECK constraint if incorrect gender is inputted ie. H vs. F

SELECT *
FROM Person

/* H. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
	PersonID int IDENTITY(10000, 2) Primary Key
	, FirstName varchar(50) NOT NULL
	, LastName varchar(50) NOT NULL
	, BirthDate date NULL
	, Gender char(1) NULL CHECK(GENDER IN('M', 'F'))
	, UserID varchar(25) NOT NULL UNIQUE
	, DataCreated datetime2 NOT NULL DEFAULT GETDATE()
--want the date and time at the instance that the row is created, thus use DEFAULT which is = to the fxn. GETDATE()
	, --CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)

INSERT INTO Person(FirstName, LastName, UserID, Gender)
VALUES ('John', 'Doe', 'jdoe', 'M')
, ('Jane', 'Doe', 'jadoe', 'F')
, ('Harrold', 'Smith', 'hsmith', NULL)

SELECT *
FROM Person
	
/* I. */
USE Chinook_Eric
IF OBJECT_ID('Address') IS NOT NULL DROP TABLE Address
IF OBJECT_ID('Person') IS NOT NULL DROP TABLE Person

CREATE TABLE Person (
	PersonID int IDENTITY(10000, 2) --Primary Key
	, FirstName varchar(50) NOT NULL
	, LastName varchar(50) NOT NULL
	, BirthDate date NULL
	, Gender char(1) NULL CHECK(GENDER IN('M', 'F'))
	, UserID varchar(25) NOT NULL UNIQUE
	, DataCreated datetime2 NULL DEFAULT GETDATE()
	, CONSTRAINT pk_Person PRIMARY KEY (PersonID)
	)
--Can use the primary key as a contraint by commenting out: Primary Key
--And uncommenting:
--	, CONSTRAINT pk_Person PRIMARY KEY (PersonID)
--Also, can use PRIMARY KEY (FirstName, LastName), but just not in this example

/* Create Address Table, which references the Person table through a foreign key */
CREATE TABLE Address(
	AddressID int IDENTITY(1,1) Primary KEY
	, AddressType varchar(10) NOT NULL
	, AddressLine1 varchar(50) NOT NULL
	, AddressLine2 varchar(50) NULL
	, City varchar(50) NULL
	, State char(2) NULL
	, Zip varchar(10) NOT NULL
	, PersonID int --FOREIGN KEY REFERENCES Person(PersonID)
	, DateCreated datetime2 NOT NULL DEFAULT GETDATE()
	, CONSTRAINT uc_AddressType UNIQUE (AddressType, PersonID)
--This means that can have 2 PersonIDs that are the same as long as the AddressTypes are different, and vise versa
	, CONSTRAINT fk_PersonAddress FOREIGN KEY (PersonID)
		REFERENCES Person(PersonID)
--Can also uncomment: FOREIGN KEY REFERENCES Person(PersonID)
--While commenting out:
--	, CONSTRAINT fk_PersonAddress FOREIGN KEY (PersonID)
--		REFERENCES Person(PersonID)
--And the same results will be achieved, the advantage of using a constraint is that you can multiple columns used in the constraint
	)

INSERT INTO Person(FirstName, LastName, UserID, Gender)
VALUES ('John', 'Doe', 'jdoe', 'M')
, ('Jane', 'Doe', 'jadoe', 'F')
, ('Harrold', 'Smith', 'hsmith', NULL)

INSERT INTO Address(AddressType, AddressLine1, Zip, PersonID)
VALUES ('Work', '111 Elm', '92112', 10000)
, ('Home', '555 Maple', '92101', 10000)
, ('Home', '123 Hickory', '92101', 10002)
, ('Work', '456 Palm', '92103', 10002)
--PersonIDs match with the IDs present in the Person table
--Not allowed to input a foreign key that does not exist in the primary key table

SELECT *
FROM Address

SELECT *
FROM Person