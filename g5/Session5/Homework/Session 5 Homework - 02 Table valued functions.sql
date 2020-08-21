/*Create multi-statement table value function that for specific Teacher 
	will list all students (FirstName, LastName) who passed the exam 
	with that Teacher and with Average grade per Student 
*/
use SEDCHome_2020_G5
go

SELECT --*
		s.FirstName as StudentFirstName, s.LastName as StudentLastName, avg(g.Grade) as AvgGrade
	FROM
		Grade as g
		INNER JOIN Student as s ON g.StudentID = s.ID	
		INNER JOIN Teacher as t ON g.TeacherID = t.ID
	WHERE TeacherID = 41
	GROUP BY s.FirstName , s.LastName	

CREATE or alter FUNCTION dbo.fn_StudentPerTeacherForAward (@TeacherID smallint)
RETURNS @output TABLE (StudentFirstName nvarchar(50), StudentLastName nvarchar(50), AvgGrade numeric(4,2))
AS
BEGIN

	INSERT INTO @output
	SELECT --*
		s.FirstName as StudentFirstName, s.LastName as StudentLastName, avg(g.Grade) as AvgGrade
	FROM
		Grade as g
		INNER JOIN Student as s ON g.StudentID = s.ID	
		INNER JOIN Teacher as t ON g.TeacherID = t.ID
	WHERE TeacherID = @TeacherID
	GROUP BY s.FirstName , s.LastName		


RETURN
END

go


select * from dbo.fn_StudentPerTeacherForAward(41) order by AvgGrade desc

select * 
from Teacher t
cross apply dbo.fn_StudentPerTeacherForAward(t.id) req


/*Modify previous function, by adding new parameter named RewardTreshold. 
	This will be used inside the function logic to determine if student will 
		receive award from teacher or not. Accordingly Add new Output column named ForReward 
		and fill that with ‘yes’ if Student average grade is above RewardTreshold or ‘No’ 
		if Student average grade is above RewardTreshold. 
*/
go

CREATE or alter FUNCTION dbo.fn_StudentPerTeacherForAward (@TeacherID smallint,@RewardTreshold Numeric(4,2))
RETURNS @output TABLE (StudentFirstName nvarchar(50), StudentLastName nvarchar(50), AvgGrade numeric(4,2), ForReward NVARCHAR(3))
AS
BEGIN

	INSERT INTO @output
	SELECT
		s.FirstName as StudentFirstName, s.LastName as StudentLastName, avg(g.Grade) as AvgGrade, NULL AS ForReward
	FROM
		Grade as g
		INNER JOIN Student as s ON g.StudentID = s.ID	
		INNER JOIN Teacher as t ON g.TeacherID = t.ID
	WHERE TeacherID = @TeacherID
	GROUP BY s.FirstName , s.LastName	

	UPDATE @output
				SET ForReward = 
				CASE WHEN AvgGrade > @RewardTreshold THEN 'Yes'
				ELSE 'No'
				END
	
	insert into dbo.GradeDetails

RETURN
END

go

select * 
into #TmpOutput
from dbo.fn_StudentPerTeacherForAward(41,8) 
order by AvgGrade desc

select * from #TmpOutput

select * 
from Teacher t
cross apply dbo.fn_StudentPerTeacherForAward(t.id,8) req
order by t.firstName,t.LastName,AvgGrade desc