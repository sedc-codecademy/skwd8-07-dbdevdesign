/*
Calculate the count of all grades in the system
Calculate the count of all grades per Teacher in the system
Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
Find the Maximal Grade, and the Average Grade per Student on all grades in the system
*/

SELECT COUNT(Grade) as GradeCount
from Grade
GO

SELECT TeacherID, COUNT(Grade) as GradeCount
FROM Grade
GROUP BY TeacherID
ORDER BY TeacherID
GO

SELECT TeacherID, COUNT(Grade) as GradeCount
FROM Grade
WHERE StudentID < 100
GROUP BY TeacherID
ORDER BY TeacherID
GO

SELECT StudentId, Max(Grade) as MaxGrade, AVG(Cast(Grade as decimal(4,2))) as AverageGrade
FROM Grade
GROUP BY StudentId
ORDER BY StudentID
GO
