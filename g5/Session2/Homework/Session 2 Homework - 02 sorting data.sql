/*
Find all Students with FirstName = Antonio ordered by Last Name
List all Students ordered by FirstName
Find all Male students ordered by EnrolledDate, starting from the last enrolled
*/

SELECT * 
FROM Student
WHERE FirstName = 'Antonio'
Order by LastName
GO

SELECT * 
FROM Student
Order by FirstName 
GO

SELECT * 
FROM Student
WHERE Gender = 'M'
ORDER by EnrolledDate desc
GO
