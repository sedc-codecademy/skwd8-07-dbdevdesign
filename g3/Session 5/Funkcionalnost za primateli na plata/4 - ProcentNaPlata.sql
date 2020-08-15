USE [SEDC]
GO

DECLARE @SalaryDate DATE
SET @SalaryDate='2019-03-01'


DECLARE @EmployeeId INT
DECLARE @TotalSales DECIMAL(18,2)
DECLARE @Salary DECIMAL(18,2)
DECLARE @Incentive DECIMAL(18,2)

IF EXISTS (SELECT 1 FROM dbo.EmployeeSalariesEvidence WHERE YearMonth =  SUBSTRING(CONVERT(VARCHAR,@SalaryDate,112),1,6))
BEGIN
	RAISERROR('Vole veke si pustil plata!!!',16,1)
	RETURN
END

SELECT *
INTO #tempEmployee
FROM Employee

WHILE (SELECT COUNT(*) FROM #tempEmployee)>0
BEGIN
	SELECT TOP 1 @EmployeeId = id FROM #tempEmployee

	IF (SELECT COUNT(*) FROM dbo.[order] WHERE EmployeeId=@EmployeeId)>0
	BEGIN
		SELECT @TotalSales = SUM(ISNULL(TotalPrice,0))
		FROM dbo.[order]
		WHERE EmployeeID = @EmployeeId
			AND OrderDate>=@SalaryDate AND OrderDate<= EOMONTH(@SalaryDate);
	END

	SELECT @Salary = TotalSalary 
		FROM dbo.fn_SalaryCalculation (@EmployeeId, @TotalSales)

	SET @Incentive = @TotalSales * (SELECT IncentiveCoef 
											FROM dbo.EmployeeSalariesRegistar 
											WHERE EmployeeID = @EmployeeId)
		
	INSERT INTO dbo.EmployeeSalariesEvidence 
				VALUES (@EmployeeId, 
						SUBSTRING(CONVERT(VARCHAR,@SalaryDate,112),1,6),  --YearMonth
						@Incentive,
						@Salary, 
						GETDATE())


	DELETE FROM #tempEmployee WHERE Id = @EmployeeId
END

DROP TABLE #tempEmployee

--PRIKAZ na PRESMETANA PLATA
SELECT * FROM dbo.EmployeeSalariesEvidence WHERE YearMonth=SUBSTRING(CONVERT(VARCHAR,@SalaryDate,112),1,6)

--KONTROLE SELECT OD KOJ E NAPRAVENO I VIEW podole
SELECT o.EmployeeId, TotalSales = SUM(o.TotalPrice), er.Points, er.PointValue, er.Experience, er.ExperienceCoef, er.IncentiveCoef,
		FiksnaPlata = (er.Points*er.PointValue),
		DodatokOdStaz = (er.Experience * er.ExperienceCoef),
		ProcentOdProdazba = (SUM(o.TotalPrice)*er.IncentiveCoef),
		VkupnaPlata = (er.Points*er.PointValue) + (er.Experience * er.ExperienceCoef) + (SUM(o.TotalPrice)*er.IncentiveCoef)
FROM dbo.[Order] o
INNER JOIN EmployeeSalariesRegistar er
	ON o.EmployeeId = er.EmployeeID
WHERE OrderDate>=@SalaryDate AND OrderDate<= EOMONTH(@SalaryDate)
GROUP BY o.EmployeeId, er.Points, er.PointValue, er.Experience, er.ExperienceCoef, er.IncentiveCoef

--VIEW
SELECT * 
FROM vv_PlataZaOdredenPeriod
WHERE OrderDate>=@SalaryDate AND OrderDate<= EOMONTH(@SalaryDate)