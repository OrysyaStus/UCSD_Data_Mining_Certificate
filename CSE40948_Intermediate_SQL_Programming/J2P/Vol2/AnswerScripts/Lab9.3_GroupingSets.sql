/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

/*
Code for Lab 9.3 Intersect and Except
Make sure you are in the JProCo database
*/

--Skill Check 1 

--Turn this complicated UNION query into the equivalent with GROUPING SETS
SELECT YEAR([OriginationDate]) AS OriginationYear, NULL, COUNT(ProductID)
FROM CurrentProducts
GROUP BY YEAR([OriginationDate])

UNION 

SELECT NULL AS OriginationYear, Category, COUNT(ProductID)
FROM CurrentProducts
GROUP BY Category


--This is the Answer
SELECT YEAR([OriginationDate]) AS OriginationYear, Category, COUNT(ProductID)
FROM CurrentProducts
GROUP BY GROUPING SETS (YEAR([OriginationDate]), Category)

--Skill Check 2
SELECT Category, ToBeDeleted, COUNT(*)
FROM CurrentProducts
GROUP BY GROUPING SETS (Category, ToBeDeleted)

--Skill Check 3
SELECT Category, ToBeDeleted, COUNT(*)
FROM CurrentProducts
GROUP BY GROUPING SETS (Category, ToBeDeleted, (Category, ToBeDeleted))

