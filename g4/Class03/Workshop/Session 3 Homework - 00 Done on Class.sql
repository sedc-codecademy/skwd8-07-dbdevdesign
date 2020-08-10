--	Calculate the count of all grades in the system
select count(*) from dbo.Grade --20425
--	Calculate the count of all grades per Teacher in the system
select t.FirstName + ' ' + t.LastName as Teacher, count(*) as GradeCount 
from dbo.Grade g
join dbo.Teacher t on g.TeacherID = t.ID
group by t.FirstName + ' ' + t.LastName 
--	Calculate the count of all grades per Teacher in the system 
--	for first 100 Students (ID < 100)
select t.FirstName + ' ' + t.LastName as Teacher, count(*) as GradeCount 
from dbo.Grade g
join dbo.Teacher t on g.TeacherID = t.ID
WHERE StudentID < 100
group by t.FirstName + ' ' + t.LastName 
--Find the Maximal Grade, and the Average Grade per Student on all grades 
--in the system
select s.FirstName + ' ' + s.LastName as Student, 
MAX(Grade) as MaxGrade,
AVG(Grade) as AverageGrade
from dbo.Grade g
join dbo.Student s on g.StudentID = s.ID
group by s.FirstName + ' ' + s.LastName
order by AVG(Grade) desc

--	Calculate the count of all grades per Teacher in the system and filter 
--	only grade count greater then 200
select t.FirstName + ' ' + t.LastName as Teacher, count(*) as GradeCount 
from dbo.Grade g
join dbo.Teacher t on g.TeacherID = t.ID
group by t.FirstName + ' ' + t.LastName 
having count(*) > 200

--Calculate the count of all grades per Teacher in the system 
--for first 100 Students (ID < 100) 
--and filter teachers with more than 50 Grade count
select t.FirstName + ' ' + t.LastName as Teacher, count(*) as GradeCount 
from dbo.Grade g
join dbo.Teacher t on g.TeacherID = t.ID
WHERE g.StudentID < 100
group by t.FirstName + ' ' + t.LastName 
having count(*) > 50
/*
Find the Grade Count, Maximal Grade, and the Average Grade per Student 
on all grades in the system. 
Filter only records where Maximal Grade is equal to Average Grade
*/
select s.FirstName + ' ' + s.LastName as Student, 
COUNT(*) as GradeCount,
MAX(Grade) as MaxGrade,
AVG(Grade) as AverageGrade
from dbo.Grade g
join dbo.Student s on g.StudentID = s.ID
group by s.FirstName + ' ' + s.LastName
having MAX(Grade) = AVG(Grade)
--order by AVG(Grade) desc


--Create new view (vv_StudentGrades) that will List all StudentIds 
--and count of Grades per student

CREATE VIEW vv_StudentGrades
AS 
SELECT StudentId, count(*) as GradeCount from dbo.Grade
group by StudentID

select s.FirstName, s.LastName,  t.* 
from vv_StudentGrades t
join dbo.Student s on t.StudentID = s.ID

--Change the view to show Student First and Last Names instead of StudentID
ALTER VIEW vv_StudentGrades
AS 
SELECT s.FirstName, s.LastName, count(*) as GradeCount 
from dbo.Grade g
join dbo.Student s on g.StudentID = s.ID
group by s.FirstName, s.LastName

select * from vv_StudentGrades

--List all rows from view ordered by biggest Grade Count
select * from vv_StudentGrades order by GradeCount desc

/*
Create new view (vv_StudentGradeDetails) that will List all Students 
(FirstName and LastName) and Count the courses he passed through the exam(Ispit)
*/
create view vv_StudentGradeDetails
AS
select FirstName, LastName, count(*) as CourseCount  
from dbo.Grade g
join dbo.Student s on g.StudentID = s.ID
join dbo.GradeDetails gd on g.Id = gd.GradeID
join dbo.AchievementType att on gd.AchievementTypeID = att.ID
where att.Name = 'Ispit'
group by FirstName, LastName

select * from vv_StudentGradeDetails
