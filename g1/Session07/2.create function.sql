--2-- funkcija za presmetka na plata
DROP FUNCTION IF EXISTS dbo.fn_SalaryCalculation;
GO

CREATE FUNCTION dbo.fn_SalaryCalculation (@EmployeeID INT)
RETURNS TABLE 
AS
RETURN					   /*fiskna plata*/		/*Dodatok od iskustvo*/			
	SELECT TotalSalary = (Points*PointValue) + (Experience*ExperienceCoef) 
	FROM dbo.EmployeeSalariesRegistar WHERE EmployeeID = @EmployeeId



