/*
Find all Students with FirstName = Antonio
Find all Students with DateOfBirth greater than ‘01.01.1999’
Find all Male students
Find all Students with LastName starting With ‘T’
Find all Students Enrolled in January/1998
Find all Students with LastName starting With ‘J’ enrolled in January/1998
*/

SELECT * 
FROM Student
WHERE FirstName = 'Antonio'
GO

SELECT * 
FROM Student
WHERE DateOfBirth > '1999-01-01'
GO

SELECT * 
FROM Student
WHERE Gender = 'M'
GO

SELECT * 
FROM Student
WHERE LastName like 'T%'
GO

SELECT * 
FROM Student
WHERE EnrolledDate >='1998-01-01' and EnrolledDate < '1998-02-01'
GO

SELECT * 
FROM Student
WHERE EnrolledDate >='1999-01-01' and EnrolledDate < '1999-02-01'
and LastName like 'J%'
GO
