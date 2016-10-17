/*
** Joes2Pros.com 2009
** All Rights Reserved.
*/

---Code for Lab 15.3 Metadata Functions
---Make sure you are in the JProCo database


--Skill Check1:
SELECT * 
FROM dbBasics.sys.objects
WHERE OBJECTPROPERTY([Object_id],'ISMSShipped') = 0


--Skill Check2:
SELECT * 
FROM JProCo.sys.objects
WHERE type_desc = 'Primary_Key_Constraint'
