/*
List all Teacher First Names and Student First Names in single result set with duplicates
List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
List all common First Names for Teachers and Students
*/

SELECT FirstName
FROM Teacher
UNION ALL
SELECT FirstName 
FROM Student
GO

SELECT LastName
FROM Teacher
UNION
SELECT LastName 
FROM Student
GO

SELECT FirstName
FROM Teacher
INTERSECT
--EXCEPT
SELECT FirstName 
FROM Student
GO
