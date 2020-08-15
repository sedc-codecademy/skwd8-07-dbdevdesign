DROP FUNCTION IF EXISTS dbo.fn_SalaryCalculation;
GO

CREATE FUNCTION dbo.fn_SalaryCalculation (@EmployeeID INT, @TotalSales DECIMAL(18,2))
RETURNS TABLE 
AS
RETURN					   /*fiskna plata*/		/*Dodatok od iskustvo*/			/*Dodatok od bonus*/
	SELECT TotalSalary = (Points*PointValue) + (Experience*ExperienceCoef) + (@TotalSales*IncentiveCoef)
	FROM dbo.EmployeeSalariesRegistar WHERE EmployeeID = @EmployeeId