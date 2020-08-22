/*
 Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
 Change the view to show Student First and Last Names instead of StudentID
 List all rows from view ordered by biggest Grade Count

 Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit) 
 */

drop view if exists vv_StudentGrades;
GO

CREATE VIEW vv_StudentGrades
AS
SELECT StudentID, COUNT(Grade) as GradeCount
FROM Grade
GROUP BY StudentID
GO

ALTER VIEW vv_StudentGrades
AS
SELECT s.FirstName, s.LastName, COUNT(Grade) as GradeCount
FROM Grade as g
INNER JOIN Student as s ON g.StudentID = s.ID
GROUP BY s.FirstName, s.LastName
GO

SELECT * FROM vv_StudentGrades
ORDER BY GradeCount DESC
GO

drop view if exists vv_StudentGradeDetails;
GO

CREATE VIEW vv_StudentGradeDetails
AS
SELECT s.FirstName + N' ' + s.LastName as StudentName, COUNT(g.CourseID) as CourseCount
FROM Grade as g
INNER JOIN Student as s ON g.StudentID = s.ID
INNER JOIN GradeDetails as gd ON g.ID = gd.GradeID
INNER JOIN AchievementType as a on gd.AchievementTypeID = a.ID
WHERE a.Name = 'Ispit'
GROUP BY s.FirstName, s.LastName
