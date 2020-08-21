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

			RAISERROR('Vole veke si pustil plata!!!',16,2)
			RETURN

			SELECT @Salary = TotalSalary 
				FROM dbo.fn_SalaryCalculation (@EmployeeId, @TotalSales)
			
			
			/*--##### PRESMETKA NA BONUS SKALABILNO NACIN 1 ######
			IF	(@TotalSales BETWEEN 10000 AND 20000)
			begin
				SET @Incentive = 0.25 * @TotalSales * (SELECT IncentiveCoef
													FROM dbo.EmployeeSalariesRegistar 
													WHERE EmployeeID = @EmployeeId)
			end
			ELSE IF @TotalSales > 20001
			begin
					SET @Incentive =  @TotalSales * (SELECT IncentiveCoef
													FROM dbo.EmployeeSalariesRegistar 
													WHERE EmployeeID = @EmployeeId)
			end
			ELSE
			BEGIN
				SET @Incentive = 0 
			END
			*/
			
			/*--##### PRESMETKA NA BONUS SKALABILNO NACIN 2 ######
			SELECT CASE WHEN @TotalSales BETWEEN 10000 AND 20000 THEN IncentiveCoef*@TotalSales
						WHEN @TotalSales > 20001 THEN IncentiveCoef*@TotalSales*0.25
						ELSE 0 
						END
			FROM dbo.EmployeeSalariesRegistar 
			WHERE EmployeeID = @EmployeeId
			*/

			--##### PRESMETKA NA BONUS FIKSEN ######
			SET @Incentive =  @TotalSales * (SELECT IncentiveCoef
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
		IF OBJECT_ID('tempdb..#tempEmployee') IS NOT NULL DROP TABLE #tempEmployee