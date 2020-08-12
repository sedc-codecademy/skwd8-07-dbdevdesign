/*
List all possible combinations of Courses names and AchievementType names that can be passed by student
List all Teachers that has any exam Grade
List all Teachers without exam Grade
List all Students without exam Grade (using Right Join)
*/

select c.Name as CourseName, a.Name as AchievementName
from [dbo].[Course] as c
cross join [dbo].[AchievementType] as a
GO

select DISTINCT t.FirstName, t.LastName
from [dbo].[Teacher] as t
inner join [dbo].[Grade] as g on t.ID = g.TeacherID
GO

select DISTINCT t.FirstName, t.LastName
from [dbo].[Teacher] as t
left join [dbo].[Grade] as g on t.ID = g.TeacherID
where g.ID is null
GO

--Students without exam grades - RIGHT
select s.*
from [dbo].[Grade] as g
right join [dbo].[Student] as s on g.StudentID = s.ID
where g.StudentID is null

--right can be writen with Left as well
select s.*
from [dbo].[Student] as s 
left join [dbo].[Grade] as g on s.ID = g.StudentID
where g.StudentID is null
