/* Using SSMS to Manage Tables and Databases */
--Can use SSMS user interface to create databases & tables

/* Reference: http://onlinex.ucsd.edu/players/HTML_Video_Player/videoPlayer.html?xml=/CSE/40933/demos/lec05f.xml */

/* Once reference followed up to min 9: */
INSERT INTO Person(FirstName, LastName, UserID)
VALUES('R', 'Jones', 'RJ')

SELECT *
FROM Person

INSERT INTO Person(FirstName, LastName, UserID)
VALUES('Jeff', 'Jones', 'JJ', 'M')

SELECT *
FROM Person

/* Create Address table following reference, then min. 17: */
INSERT INTO Address(AddressType, AddressLine1, PersonID)
VALUES ('home', '111 elm', 10000)

SELECT *
FROM Address

INSERT INTO Address(AddressType, AddressLine1, PersonID)
VALUES ('work', '111 elm', 10000)

SELECT *
FROM Address