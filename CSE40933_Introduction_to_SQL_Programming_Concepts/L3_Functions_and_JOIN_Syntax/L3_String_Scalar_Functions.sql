SELECT
	Country
	, UPPER(Country)
	, LOWER(Country)
	, REVERSE(Country)
	, UPPER(REVERSE(Country))
	, LEFT(Country, 5)
--Returns first 5 = specify #, from the Country column; if string is smaller than specified number then all of the string is displayed.
	, RIGHT(Country, 3)
--Returns specified # of characters from the right
	, LEN(Country)
--Note: Space is included in character count
FROM Customer

SELECT 
	Country
	, REPLACE(Country, 'a', 'x')
--String replacement
FROM Customer

SELECT 
	Country
	, PATINDEX('%a%', Country)
--Find index of a string, wildcards are permitted to be used.
	, PATINDEX('%[e,z]%', Country)
--Searching for the first occurance of the letter e or z.
	, CHARINDEX('a', Country)
--Find index of a string, wildcards are not permitted to be used. 
	, CHARINDEX('a', Country, 4)
--But can take an optional third parameter, starting point.
FROM Customer

SELECT 
	Country
	, SUBSTRING(Country, 2, 3)
--Will find 2nd character in the string + 3 characters
FROM Customer

SELECT
	Phone
	, SUBSTRING(Phone, 2, CHARINDEX(' ', Phone)-2) CountryCode
--Combinations of String functions in order to determine the area code of each phone number.
	, SUBSTRING(
		Phone
		, CHARINDEX(' ', Phone)+1
--Will find the 1st space
		, CHARINDEX(' ', Phone, CHARINDEX(' ', Phone)+1)- CHARINDEX(' ', Phone)-1) AS AreaCode
--Will find the second space
--Was able to grab Area Code from the rest of the phone number.
	, SUBSTRING(Phone, CHARINDEX(' ', Phone, CHARINDEX(' ', Phone)+1), LEN(PHONE)) AS LocalPhone
--Was able to grab the rest of the phone number.
FROM Customer