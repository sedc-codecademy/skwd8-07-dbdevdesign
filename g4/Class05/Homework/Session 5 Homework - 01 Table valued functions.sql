DROP FUNCTION IF EXISTS dbo.fn_StudentGradesPerTeacherCourse;
GO

CREATE FUNCTION dbo.fn_StudentGradesPerTeacherCourse (@TeacherID smallint, @CourseId smallint)
RETURNS @output TABLE (StudentFirstName nvarchar(50), StudentLastName nvarchar(50), Grade tinyint, CreatedDate datetime)
AS
BEGIN

INSERT INTO @output
SELECT
	s.FirstName as StudentFirstName, s.LastName as StudentLastName, g.Grade, g.CreatedDate
FROM
	Grade as g
	INNER JOIN Student as s ON g.StudentID = s.ID
WHERE
	TeacherID = @TeacherID and CourseID = @CourseId

RETURN 
END

GO

-- Execution
declare @TeacherId int = 1
declare @CourseId int = 1

select * from dbo.fn_StudentGradesPerTeacherCourse (@TeacherId, @CourseId)
order by CreatedDate, StudentFirstName, StudentLastName
