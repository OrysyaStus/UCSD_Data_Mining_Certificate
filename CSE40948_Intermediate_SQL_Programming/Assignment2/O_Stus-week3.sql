/* Orysya Stus - Assignment 2 */
USE JProCo

/* Lab 6.1: Top N Queries Skill Checks 1 to 4 */
/*
Skill Check 1: In the JProCo database, create the SQL syntax to display only the two EmpID records with the oldest HireDate in the Employee table. When done, the result set should resemble the one shown below.
*/
SELECT TOP 2 *
FROM Employee
ORDER BY HireDate ASC

/*
Skill Check 2: In the JProCo database, display the six largest grants found in the Grant table. Make sure any tied values will also appear in the result set. When done , the result set should resemble the one shown below.
*/
SELECT TOP 6 WITH TIES *
FROM [Grant]
ORDER BY Amount DESC

/*
Skill Check 3: In the JProCo database, display the ten most expensive single day trips found in the CurrentProducts table. Since an overnight stay is not required, a day trip has a value of No-Stay in the Category field. When done, the results should resemble those shown below.
*/
SELECT TOP 10 *
FROM CurrentProducts
WHERE Category = 'No-Stay'
ORDER BY RetailPrice DESC

/*
Skill Check 4: Our sister company is now handling all trips lasting two weeks and thus need to be deleted from our CurrentProducts table. There are 81 records in the CurrentProducts table marked ToBeDeleted with a value of one (1). Create and run a query to delete the first 10 records in the CurrentProducts table. Once this is complete, create and run a another query to verify there are only 71 ToBeDeleted records with a value of one (1) remaining in the CurrentProducts table as shown below.
*/
DELETE TOP (10)
FROM CurrentProducts
WHERE ToBeDeleted = 1

SELECT *
FROM CurrentProducts
WHERE ToBeDeleted = 1

/* Lab 6.2: Top N Tricks Skill Checks 1 and 2 */
/*
Skill Check 1: In the JProCo database, write a query to find and then display only the third most expensive record from the Grant table based on the Amount field. 
Hint: Locate the most expensive single GrantID that is not in the TOP( 2) results. When done the results should resemble those shown below.
*/
SELECT TOP 1 *
FROM [Grant]
WHERE GrantID NOT IN (SELECT TOP 2 GrantID
			FROM [Grant]
			ORDER BY Amount DESC )
ORDER BY Amount DESC

/*
Skill Check 2: In the JProCo database context, write a query to find the three newest employees from the Employee table with a LocationID of 1. When done, the results should resemble those shown below.
*/
SELECT TOP 3 *
FROM Employee
WHERE LocationID = 1
ORDER BY HireDate DESC

/* Lab 6.3: Top(n) Percent */
/*
Skill Check 1: From the Employee table of the JProCo database, show the top 50% most senior employees by HireDate as shown below.
*/
SELECT TOP 50 PERCENT *
FROM Employee
ORDER BY HireDate ASC

/* Lab 9.1: Union and Union All Skill Checks 1 and 2. */
/*
Skill Check 1: The Grant table lists all grants, and vNonEmployeeGrants shows grants that were not found by an employee. The figure below shows these two result sets run at the same time. We can see they both include Norman’s Outreach. This is an example of two different sets of data with similar metadata (in this case the metadata is the same).
*/
SELECT *
FROM vNonEmployeeGrants
UNION ALL
SELECT *
FROM [Grant]

/*
Skill Check 2: You have two employees whose status shows they have received tenure. You also have two employees who work in Location 4. You have one employee working in Location 4 who has received tenure. Write two separate queries from the Employee table to find each group of employees. Then use the correct operator to put both result sets into one and show the distinct employees. When you are done, your result should resemble the figure below.
*/
SELECT *
FROM Employee
WHERE Status = 'Has Tenure'

UNION

SELECT *
FROM Employee
WHERE LocationID = 4

/* Lab 9.2: Intersect and Except Skill Check 1 */
/*
Skill Check 1: There are 81 records in your CurrentProducts table that are marked for deletion. Those products are to be moved to the RetiredProducts table. When you query the RetiredProducts table, notice there are only 75 records. Use the correct set operator to find the six ToBeDeleted records from the CurrentProducts table that do not appear in the RetiredProducts table. 
*/
SELECT *
FROM CurrentProducts
WHERE ToBeDeleted = 1
EXCEPT
SELECT *
FROM RetiredProducts
WHERE ToBeDeleted = 1

/* Lab 10.1: Common Table Expressions Skill Check 1. */
/*
Skill Check 1: You want to create an external report of your locations with a CTE called LocList. This list should show all fields of the Location table except for LocationID. The fields should also get new names, as shown in the following matrix. o Street should be shown as Address o City should be shown as Municipality o State should be shown as Region When you’re done , your result will resemble the figure below. 
*/
WITH LocList ([Address], Municipality, Region) AS
  (SELECT Street, City, State
  FROM Location)
SELECT * FROM LocList