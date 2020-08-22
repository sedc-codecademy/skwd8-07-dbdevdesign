ALTER FUNCTION dbo.fn_FormatStudentName (@StudentId int)
RETURNS Nvarchar(100)
AS 
BEGIN

DECLARE @Output Nvarchar(100)

select @Output = Replace(StudentCardNumber,'sc-','') + ' - ' + Left(FirstName,1) + '.' + LastName
from dbo.Student
where id = @StudentId

RETURN @Output

END
GO

-- test execution
select *, dbo.fn_FormatStudentName(id) as FunctionOutput
from dbo.Student

