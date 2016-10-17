/* ALTER and DROP Databases and Tables */

/* Run L5_Creating_Databases_and_Tables */
--Validate by checking "Databases"

/* Execute commands one at a time */

/* Modify database name */
ALTER DATABASE Chinook_Eric
MODIFY NAME = Northwind_Eric
--to run without error, must disconnect all connections to Chinook_Eric

ALTER TABLE Person
ADD 
MiddleName varchar(20) NULL
, Ethnicity varchar(50) NULL
--added columns to the table Person

ALTER TABLE Person
ALTER COLUMN
MiddleName nvarchar(35)
--Altering columns, can only do it one column at a time

ALTER TABLE Person
ALTER COLUMN
Ethnicity char(2)
--Altering columns, can only do it one column at a time
--Between commands refresh Object Explorer tabs

ALTER TABLE Person
DROP COLUMN
--when dropping and altering need to add COLUMN, but adding no not include COLUMN keyword
MiddleName
, Ethnicity

/* ADD and DROP Constraints that are located in tables*/
EXEC sp_help Person
--Will provide a list of info. about the table Person
--Will provide a butch of results sets

ALTER TABLE Address
DROP CONSTRAINT [fk_PersonAddress]

ALTER TABLE Person
DROP CONSTRAINT pk_Person
--look at "Constraints" to determine the specific names of the constraints for the tables
--drops primary key on the Table Person, can't can't delete primary key since it is references by the foreign key, therefore drop foriegn key constraint to Address

--If change your mind you can do the following, want to add both constraints back into the table:
ALTER TABLE Person 
ADD CONSTRAINT pk_Person Primary KEY (PersonID)

ALTER TABLE Address
ADD CONSTRAINT [fk_PersonAddress] FOREIGN KEY (PersonID)
	REFERENCES Person(PersonID)
--add foreign key and primary key back

/* Renaming Objects using SP_RENAME */
EXEC sp_rename 'Person', 'Users'
--Renames Person as User
--refresh 'Tables' to see the name change

--For renaming column:
EXEC sp_rename 'Address.zip', 'ZipCode', 'COLUMN'
--Identify table and column name, finds zip column in address table to rename to 'ZipCode', make sure to define what you are renaming

/* DROP Tables and Databases */
DROP TABLE Address
DROP TABLE Users
--Prior to dropping a table, make sure that there is not a primary key that is being references by another table as a foreign key

DROP DATABASE Northwind_Eric
--make sure you do not have any active connections, change location of "Available Databases"