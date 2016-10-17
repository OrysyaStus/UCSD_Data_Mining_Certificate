--Where clauses to consider with operators also used.
SELECT *
FROM Customer
WHERE Company IS NOT NULL

SELECT *
FROM Customer
WHERE STATE <> 'CA'
	OR State IS NULL
--Note: Null columns represent unknown data, not empty spaces

SELECT *
FROM Invoice
WHERE InvoiceDate BETWEEN '1/8/2010' AND '1/26/2010'
--Will include 1/8/2010 as well as 1/26/2010 into column

SELECT *
FROM Customer
WHERE Email LIKE '%gmail%'
--Can use wildcards with LIKE

SELECT *
FROM Customer
WHERE City LIKE '[ACT]%'
--Outputted cities will start with C,A, or T

SELECT *
FROM Customer
WHERE City LIKE '_[ACT]%'
--Outputted cities will have second character as a,c, or t

SELECT *
FROM Customer
WHERE Country IN ('Canada', 'USA', 'Mexico', 'Brazil')
--No wildcards allowed for IN clause, but can put multiple inputs in a once.
ORDER BY Country

SELECT *
FROM Invoice
WHERE CustomerId IN(
	SELECT CustomerId
	FROM Customer
	WHERE Country = 'USA')
--Query within a query to locate indices from a separate table

SELECT *
FROM Invoice I
WHERE EXISTS 
(
SELECT *
FROM Customer C
WHERE C.CustomerId = I.CustomerId
AND Country = 'USA'
)
ORDER BY CustomerId

SELECT *
FROM Invoice I
WHERE CustomerId IN(
	SELECT CustomerId
	FROM Customer
	WHERE Country = 'USA')
ORDER BY CustomerId

SELECT *
FROM Customer
WHERE (Country = 'Canada' OR State = 'CA')
AND Company IS NOT NULL
--Make sure that the order or ORs/ANDs are in the correct order for what should be selected.