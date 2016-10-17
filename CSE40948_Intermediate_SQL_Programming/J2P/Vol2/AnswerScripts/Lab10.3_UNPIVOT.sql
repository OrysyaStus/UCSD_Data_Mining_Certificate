/*
** Joes2Pros.com 2012
** All Rights Reserved.
*/

---Code for Lab 10.3: UNPIVOT
/*Make sure you are in the JProCo database */


--Skill Check1:
SELECT * FROM
	(SELECT ProductID, [2009], [2010],[2011],[2012],[2013]
	FROM SalesGrid) AS Sales
UNPIVOT 	(TotalSales FOR CalYear IN 
		([2009], [2010],[2011], [2012], [2013])
	) AS unpvt








