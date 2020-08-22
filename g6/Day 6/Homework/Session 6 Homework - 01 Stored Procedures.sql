/*
Create new procedure called CreateGrade
Procedure should create only Grade header info (not Grade Details) 
Procedure should return the total number of grades in the system for the Student from the CreateGrade
Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)
*/
CREATE PROCEDURE [dbo].[CreateGrade]
(
	@StudentID int
,	@CourseID smallint
,	@TeacherID smallint
,	@Grade tinyint
,	@Comment nvarchar(100)
,	@CreatedDate datetime)
AS
BEGIN
	INSERT INTO [dbo].[Grade] (StudentID, CourseID, TeacherID, Grade, Comment, CreatedDate)
	VALUES (@StudentID, @CourseID, @TeacherID, @Grade, @Comment, @CreatedDate)

	SELECT COUNT(*) as GradeCountsForStudent
	FROM [dbo].[Grade]
	WHERE StudentID = @StudentID

	SELECT MAX(Grade) as MaxGradeForStudent
	FROM [dbo].[Grade]
	WHERE
		StudentID = @StudentID
	and	TeacherID = @TeacherID
END
GO

-- test execution

EXEC [dbo].[CreateGrade] 
	@StudentID = 30
,	@CourseID = 1
,	@TeacherID = 1
,	@Grade = 10
,	@Comment = 'Snaodliv'
,	@CreatedDate = '2019-05-23'
GO

SELECT TOP 10 * 
FROM [dbo].[Grade]
ORDER BY ID DESC
GO

-- Second part
--------------
/*
Create new procedure called CreateGradeDetail
Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
Output from this procedure should be resultset with SUM of GradePoints calculated with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade
*/

CREATE OR ALTER PROCEDURE [dbo].[CreateGradeDetail]
(
	@GradeId int
,	@AchievementTypeID tinyint
,	@AchievementPoints tinyint
,	@AchievementMaxPoints tinyint
,	@AchievementDate datetime
)
AS
BEGIN
	INSERT INTO [dbo].[GradeDetails] (GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
	VALUES (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)

	SELECT
		SUM(cast(gd.AchievementPoints as decimal(5,2)) / cast(gd.AchievementMaxPoints as decimal(5,2)) * act.ParticipationRate) as GradePoints
	FROM
		[dbo].[GradeDetails] as gd
		INNER JOIN [dbo].[AchievementType] as act on gd.AchievementTypeID = act.ID
	WHERE
		gd.GradeID = @GradeID
END
GO
	
-- test execution

EXEC [dbo].[CreateGradeDetail]
	@GradeId = 20130
,	@AchievementTypeID = 0
,	@AchievementPoints = 93
,	@AchievementMaxPoints = 100
,	@AchievementDate = '2019-05-20'
GO
EXEC [dbo].[CreateGradeDetail]
	@GradeId = 20130
,	@AchievementTypeID = 1
,	@AchievementPoints = 95
,	@AchievementMaxPoints = 100
,	@AchievementDate = '2019-05-21'
GO
EXEC [dbo].[CreateGradeDetail]
	@GradeId = 20130
,	@AchievementTypeID = 2
,	@AchievementPoints = 94
,	@AchievementMaxPoints = 100
,	@AchievementDate = '2019-05-20'
GO
EXEC [dbo].[CreateGradeDetail]
	@GradeId = 20130
,	@AchievementTypeID = 5
,	@AchievementPoints = 97
,	@AchievementMaxPoints = 100
,	@AchievementDate = '2019-05-24'
GO

SELECT TOP 10 * 
FROM [dbo].[GradeDetails]
ORDER BY ID DESC
GO
