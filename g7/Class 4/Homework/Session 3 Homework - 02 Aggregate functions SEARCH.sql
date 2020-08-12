/*

Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
List Student First Name and Last Name next to the other details from previous query

*/


SELECT TeacherID, COUNT(Grade) as GradeCount
FROM Grade
GROUP BY TeacherID
HAVING COUNT(Grade) > 200
GO

SELECT TeacherID, COUNT(Grade) as GradeCount
FROM Grade
WHERE StudentID < 100
GROUP BY TeacherID
HAVING COUNT(Grade) > 50
GO

SELECT StudentId, Count(Grade) as GradeCount, Max(Grade) as MaxGrade, AVG(Cast(Grade as decimal(4,2))) as AverageGrade
FROM Grade
GROUP BY StudentId
HAVING  Max(Grade) = AVG(Cast(Grade as decimal(4,2)))
GO

SELECT g.StudentId, s.FirstName, s.LastName, Count(g.Grade) as GradeCount, Max(g.Grade) as MaxGrade, AVG(Cast(g.Grade as decimal(4,2))) as AverageGrade
FROM Grade as g
inner join Student as s on g.StudentID = s.ID
GROUP BY StudentId, s.FirstName, s.LastName
HAVING  Max(g.Grade) = AVG(Cast(g.Grade as decimal(4,2)))
GO
