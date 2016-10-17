/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 13.1 Updates With Subqueries
---Make sure you are in the JProCo


--Skill Check1:
UPDATE cp SET RetailPrice = RetailPrice + (SELECT SUM(Change)
		FROM PriceIncrease pr 
		WHERE pr.ProductID = cp.ProductID)
FROM CurrentProducts cp
WHERE ProductID IN (SELECT ProductID FROM PriceIncrease)
















